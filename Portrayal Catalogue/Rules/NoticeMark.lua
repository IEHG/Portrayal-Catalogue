require 'MARSYS01'

---------------------------------------------------------------
-- Hulpfuncties
---------------------------------------------------------------

local function SplitComma(text)
    local t = {}
    for part in string.gmatch(text, "([^,]+)") do
        t[#t+1] = part
    end
    return t
end

local numerals = {
    {1000, "M"}, {900,  "CM"}, {500,  "D"}, {400,  "CD"},
    {100,  "C"}, {90,   "XC"}, {50,   "L"}, {40,   "XL"},
    {10,   "X"}, {9,    "IX"}, {5,    "V"}, {4,    "IV"},
    {1,    "I"}
}

local function ToRoman(n)
    n = tonumber(n)
    if not n or n < 1 then return "" end
    local roman = ""
    for _, pair in ipairs(numerals) do
        local value, symbol = pair[1], pair[2]
        while n >= value do
            roman = roman .. symbol
            n = n - value
        end
    end
    return roman
end

local function GetVisualLength(text)
    local len = 0
    for c in text:gmatch(".") do
        if c:match("[%u%d]") then
            len = len + 0.75
        elseif c == " " then
            len = len + 0.30
        elseif c == "." then
            len = len + 0.25
        else
            len = len + 0.60
        end
    end
    return len
end

-- BELANGRIJK: baseX, baseY = fanned-out positie (of 0,0 bij niet-uitgevouwen)
local function SetTextInRectangle(featurePortrayal, text, baseX, baseY, cx, cy, width, color, align)
    if not text or text == "" then return end
    
    text = EncodeString(text, '%s')
    local visual = GetVisualLength(text)
    if visual == 0 then
        visual = 0.1
    end
    local rectWidthMm = width - 0.2
    local fontSizePt = rectWidthMm / (visual * 0.3528)
    if fontSizePt > 5 then
        fontSizePt = 5
    end

    local x = baseX + cx
    local y = baseY + cy

    featurePortrayal:AddInstructions(
        'DrawingPriority:26;' ..
        'LocalOffset:' .. x .. ',' .. y ..
        ';TextAlignHorizontal:' .. align ..
        ';TextAlignVertical:Center' ..
        ';FontWeight:Bold' ..
        ';FontSize:' .. fontSizePt ..
        ';FontColor:' .. color
    )
    featurePortrayal:AddTextInstruction(text, 29, 24, 21020)
end

---------------------------------------------------------------
-- Additional marks
---------------------------------------------------------------

local ADD_MARK_SYMBOLS = {
    [0] = { [1]="ADDMRK06", [2]="ADDMRK05", [3]="ADDMRK01", [4]="ADDMRK02", [5]="ADDMRK09" },
    [1] = { [1]="ADDMRK04", [2]="ADDMRK03", [3]="ADDMRK01", [4]="ADDMRK02", [5]="ADDMRK10" },
    [2] = { [1]="ADDMRK06", [2]="ADDMRK05", [3]="ADDMRK07", [4]="ADDMRK08", [5]="ADDMRK09" }
}

-- baseX, baseY = positie van het bord (ook fanned-out)
local function DrawAdditionalMark(feature, featurePortrayal, text, idx, type, baseX, baseY)
    local code = feature.additionalMark[idx]
    local symbol = ADD_MARK_SYMBOLS[type] and ADD_MARK_SYMBOLS[type][code]
    if not symbol then return end

    featurePortrayal:AddInstructions(
        'DrawingPriority:24;LocalOffset:' .. baseX .. ',' .. baseY .. ';PointInstruction:' .. symbol
    )

    if text and text ~= '' then
        if type == 0 or type == 2 then
            if code == 1 then
                SetTextInRectangle(featurePortrayal, text, baseX, baseY, 0, 4.66, 7, 'CHBLK', 'Center')
            elseif code == 2 then
                SetTextInRectangle(featurePortrayal, text, baseX, baseY, 0, -4.66, 7, 'CHBLK', 'Center')
            end
        else
            if code == 1 then
                SetTextInRectangle(featurePortrayal, text, baseX, baseY, 0, 6.26, 7, 'CHBLK', 'Center')
            elseif code == 2 then
                SetTextInRectangle(featurePortrayal, text, baseX, baseY, 0, -6.26, 7, 'CHBLK', 'Center')
            end
        end
    end
end

-- cx, cy zijn offsets BINNEN het bord; baseX, baseY is de bordpositie
local function DrawAdditionalInformation(feature, featurePortrayal, text, type, baseX, baseY, cx, cy, width, color, align)
    local infoText = ""
    if feature.information and feature.information[1] and feature.information[1].text then
        infoText = feature.information[1].text
    end

    if #feature.additionalMark > 0 then
        for i = 1, #feature.additionalMark do
            local textAdditional = infoText
            if textAdditional and textAdditional ~= "" and string.find(textAdditional, ", ") then
                local values = SplitComma(textAdditional)
                local main = values[1] or ""
                local extra = values[2] or ""

                if feature.categoryOfNoticeMark == 119 or feature.categoryOfNoticeMark == 121 then
                    main = ToRoman(tonumber(main)) or main
                    extra = ToRoman(tonumber(extra)) or extra
                end

                DrawAdditionalMark(feature, featurePortrayal, extra, i, type, baseX, baseY)
                SetTextInRectangle(featurePortrayal, main, baseX, baseY, cx, cy, width, color, align)
            else
                local t = text
                if t == '' and infoText ~= '' then
                    t = infoText
                end
                if feature.categoryOfNoticeMark == 119 or feature.categoryOfNoticeMark == 121 then
                    t = ToRoman(tonumber(t)) or t
                end
                DrawAdditionalMark(feature, featurePortrayal, t, i, type, baseX, baseY)
            end
        end
    else
        if feature.categoryOfNoticeMark == 119 then
            local t = infoText ~= '' and infoText or text
            t = ToRoman(tonumber(t)) or t
            SetTextInRectangle(featurePortrayal, t, baseX, baseY, 0.0, -0.3, 5.8, 'AZUBL', 'Center')
        elseif feature.categoryOfNoticeMark == 121 then
            local t = infoText ~= '' and infoText or text
            local values = SplitComma(t)
            local t1 = ToRoman(tonumber(values[1])) or values[1]
            local t2 = ToRoman(tonumber(values[2])) or values[2]
            if t1 == 'I' then t1 = ' ' .. t1 .. ' ' end
            SetTextInRectangle(featurePortrayal, t1, baseX, baseY, 0.0, 1.51, 2.5, 'AZUBL', 'Center')
            SetTextInRectangle(featurePortrayal, t2, baseX, baseY, 0.0, -1.51, 2.5, 'AZUBL', 'Center')
        else
            local t = infoText ~= '' and infoText or text
            SetTextInRectangle(featurePortrayal, t, baseX, baseY, cx, cy, width, color, align)
        end
    end
    return 1
end

---------------------------------------------------------------
-- Symbol mapping (zoals in jouw script)
---------------------------------------------------------------

local CATEGORY_SYMBOLS_IALA_B = {
    [1] = { [1]="NMKPRH02", [2]=0 },
    [6] = { [1]="NMKPRH07", [2]=0 },
    [8] = { [1]="NMKPRH08", [2]=0 },
    [114] = { [1]="NMKRE101", [2]=0 }
}

local CATEGORY_SYMBOLS_CEVNI = {
    [1]  = { [1]="NMKPRH02", [2]=0 },
    [2]  = { [1]="NMKPRH03", [2]=0 },
    [3]  = { [1]="NMKPRH04", [2]=1 },
    [4]  = { [1]="NMKPRH05", [2]=1 },
    [5]  = { [1]="NMKPRH06", [2]=1 },
    [6]  = { [1]="NMKPRH07", [2]=0 },
    [7]  = { [1]="NMKPRH07A", [2]=0 },
    [8]  = { [1]="NMKPRH08", [2]=0 },
    [9]  = { [1]="NMKPRH09", [2]=0 },
    [10] = { [1]="NMKPRH10", [2]=0 },
    [11] = { [1]="NMKPRH11", [2]=0 },
    [12] = { [1]="NMKPRH12", [2]=0 },
    [13] = { [1]="NMKPRH13", [2]=0 },
    [14] = { [1]="NMKPRH14", [2]=0 },
    [15] = { [1]="NMKPRH15", [2]=0 },
    [16] = { [1]="NMKPRH16", [2]=0 },
    [17] = { [1]="NMKPRH17", [2]=0 },
    [18] = { [1]="NMKPRH18", [2]=0 },
    [19] = { [1]="NMKPRH19", [2]=0 },
    [20] = { [1]="NMKPRH20", [2]=0 },
    [21] = { [1]="NMKPRH21", [2]=0 },
    [22] = { [1]="NMKPRH22", [2]=0 },
    [23] = { [1]="NMKREG02", [2]=2 },
    [24] = { [1]="NMKREG03", [2]=2 },
    [25] = { [1]="NMKREG04", [2]=1 },
    [26] = { [1]="NMKREG05", [2]=1 },
    [27] = { [1]="NMKREG06", [2]=1 },
    [28] = { [1]="NMKREG07", [2]=1 },
    [29] = { [1]="NMKREG08", [2]=1 },
    [30] = { [1]="NMKREG09", [2]=1 },
    [31] = { [1]="NMKREG10", [2]=0 },
    [32] = { [1]="NMKREG01", [2]=0 },
    [33] = { [1]="NMKREG11", [2]=0 },
    [34] = { [1]="NMKREG12", [2]=0 },
    [35] = { [1]="NMKREG13", [2]=0 },
    [36] = { [1]="NMKREG14", [2]=0 },
    [37] = { [1]="NMKREG15", [2]=0 },
    [38] = { [1]="NMKREG16", [2]=0 },
    [39] = { [1]="NMKREG17", [2]=0 },
    [40] = { [1]="NMKREG18", [2]=0 },
    [41] = { [1]="NMKREG01", [2]=0 },
    [42] = { [1]="NMKREG19", [2]=0 },
    [43] = { [1]="NMKREG20", [2]=0 },
    [44] = { [1]="NMKRCD01", [2]=0 },
    [45] = { [1]="NMKRCD02", [2]=0 },
    [46] = { [1]="NMKRCD03", [2]=0 },
    [47] = { [1]="NMKRCD04", [2]=0 },
    [48] = { [1]="NMKRCD07", [2]=2 },
    [49] = { [1]="NMKRCD08", [2]=2 },
    [50] = { [1]="NMKINF01", [2]=0 },
    [51] = { [1]="NMKINF02", [2]=0 },
    [52] = { [1]="NMKINF03", [2]=0 },
    [53] = { [1]="NMKINF04", [2]=2 },
    [54] = { [1]="NMKINF05", [2]=2 },
    [55] = { [1]="NMKINF06", [2]=0 },
    [56] = { [1]="NMKINF05", [2]=2 },
    [57] = { [1]="NMKINF05", [2]=0 },
    [58] = { [1]="NMKINF5", [2]=0 },
    [59] = { [1]="NMKINF07", [2]=0 },
    [60] = { [1]="NMKINF08", [2]=0 },
    [61] = { [1]="NMKINF09", [2]=0 },
    [62] = { [1]="NMKINF10", [2]=0 },
    [63] = { [1]="NMKINF11", [2]=0 },
    [64] = { [1]="NMKINF12", [2]=0 },
    [65] = { [1]="NMKINF13", [2]=0 },
    [66] = { [1]="NMKINF14", [2]=0 },
    [67] = { [1]="NMKINF15", [2]=0 },
    [68] = { [1]="NMKINF16", [2]=0 },
    [69] = { [1]="NMKINF17", [2]=0 },
    [70] = { [1]="NMKINF18", [2]=0 },
    [71] = { [1]="NMKINF19", [2]=1 },
    [72] = { [1]="NMKINF20", [2]=0 },
    [73] = { [1]="NMKINF21", [2]=0 },
    [74] = { [1]="NMKINF22", [2]=0 },
    [75] = { [1]="NMKINF23", [2]=0 },
    [76] = { [1]="NMKINF24", [2]=0 },
    [77] = { [1]="NMKINF25", [2]=0 },
    [78] = { [1]="NMKINF26", [2]=0 },
    [79] = { [1]="NMKINF27", [2]=0 },
    [80] = { [1]="NMKINF28", [2]=0 },
    [81] = { [1]="NMKINF29", [2]=0 },
    [82] = { [1]="NMKINF30", [2]=0 },
    [83] = { [1]="NMKINF31", [2]=0 },
    [84] = { [1]="NMKINF32", [2]=0 },
    [85] = { [1]="NMKINF33", [2]=0 },
    [86] = { [1]="NMKINF34", [2]=0 },
    [87] = { [1]="NMKINF35", [2]=0 },
    [88] = { [1]="NMKINF36", [2]=0 },
    [89] = { [1]="NMKINF37", [2]=0 },
    [90] = { [1]="NMKINF38", [2]=1 },
    [91] = { [1]="NMKINF39", [2]=0 },
    [92] = { [1]="NMKINF40", [2]=0 },
    [93] = { [1]="NMKINF41", [2]=0 },
    [94] = { [1]="NMKINF42", [2]=0 },
    [95] = { [1]="NMKINF43", [2]=0 },
    [96] = { [1]="NMKINF44", [2]=0 },
    [97] = { [1]="NMKINF45", [2]=0 },
    [98] = { [1]="NMKINF46", [2]=0 },
    [99] = { [1]="NMKINF47", [2]=0 },
    [100] = { [1]="NMKINF48", [2]=0 },
    [101] = { [1]="NMKINF49", [2]=0 },
    [102] = { [1]="NMKINF50", [2]=0 },
    [110] = { [1]="NMKREG50", [2]=0 },
    [111] = { [1]="NMKREG51", [2]=0 },
    [117] = { [1]="NMKINF56", [2]=0 },
    [118] = { [1]="NMKINF57", [2]=0 },
    [119] = { [1]="NMKINF57", [2]=0 },
    [120] = { [1]="NMKINF58", [2]=0 },
    [121] = { [1]="NMKINF58", [2]=0 },
    [122] = { [1]="NMKINF59", [2]=0 },
    [123] = { [1]="NMKREG25", [2]=0 },
    [128] = { [1]="NMKPRH06A", [2]=1 }
}

local CATEGORY_SYMBOLS_RUSSIAN = {
    [5]  = { [1]="NMKPR103", [2]=0 },
    [8]  = { [1]="NMKPR101", [2]=0 },
    [11] = { [1]="NMKPR104", [2]=0 },
    [39] = { [1]="NMKRE103", [2]=0 },
    [74] = { [1]="NMKIN101", [2]=0 },
    [112] = { [1]="NMKPR102", [2]=0 },
    [113] = { [1]="NMKPR105", [2]=0 },
    [114] = { [1]="NMKRE101", [2]=0 },
    [115] = { [1]="NMKRE102", [2]=0 },
    [116] = { [1]="NMKIN102", [2]=0 }
}

local CATEGORY_SYMBOLS_BRAZILIAN_13 = {
    [1]   = { [1]="NMKPR103", [2]=0 },
    [8]   = { [1]="NMKAC008", [2]=0 },
    [39]  = { [1]="NMKAC039", [2]=0 },
    [44]  = { [1]="NMKRCD01", [2]=0 },
    [45]  = { [1]="NMKRCD02", [2]=0 },
    [82]  = { [1]="NMKAE082", [2]=0 },
    [83]  = { [1]="NMKAE083", [2]=0 },
    [103] = { [1]="NMKAC103", [2]=0 },
    [104] = { [1]="NMKAC104", [2]=0 },
    [105] = { [1]="NMKAC105", [2]=0 },
    [106] = { [1]="NMKAC106", [2]=0 },
    [107] = { [1]="NMKAC107", [2]=0 },
    [108] = { [1]="NMKAC108", [2]=0 },
    [109] = { [1]="NMKAC109", [2]=0 },
    [124] = { [1]="NMKAD124", [2]=0 },
    [125] = { [1]="NMKAD125", [2]=0 },
    [126] = { [1]="NMKAD126", [2]=0 },
    [127] = { [1]="NMKAD127", [2]=0 }
}

local CATEGORY_SYMBOLS_BRAZILIAN_15 = {
    [103] = { [1]="NMKAE103", [2]=0 },
    [104] = { [1]="NMKAE104", [2]=0 },
    [105] = { [1]="NMKAE105", [2]=0 },
    [106] = { [1]="NMKAE106", [2]=0 },
    [107] = { [1]="NMKAE107", [2]=0 },
    [108] = { [1]="NMKAE108", [2]=0 },
    [109] = { [1]="NMKAE109", [2]=0 }
}

---------------------------------------------------------------
-- Hoofdfunctie: DrawNoticeMark (met baseX, baseY)
---------------------------------------------------------------

local function DrawNoticeMark(feature, featurePortrayal, contextParameters, baseX, baseY)
    baseX = baseX or 0
    baseY = baseY or 0

    local system = MARSYS01(feature, featurePortrayal, contextParameters)
    local cat = feature.categoryOfNoticeMark

    local viewingGroup = 27250
    featurePortrayal:AddInstructions(
        'ViewingGroup:27250;DrawingPriority:32;DisplayPlane:' ..
        (contextParameters.RadarOverlay and 'OverRadar' or 'UnderRadar')
    )

    -- Symbool altijd op baseX, baseY
    featurePortrayal:AddInstructions('LocalOffset:' .. baseX .. ',' .. baseY)

    if contextParameters.SimplifiedSymbols then
        local simple = { [1]="NOTMRK01", [2]="NOTMRK02", [3]="NOTMRK02", [4]="NOTMRK03", [5]="NOTMRK03" }
        local sym = simple[feature.functionOfNoticeMark]
        if sym then featurePortrayal:AddInstructions('PointInstruction:' .. sym) end
        return viewingGroup
    end

    -- IALA B
    if system == 2 then
        local entry = CATEGORY_SYMBOLS_IALA_B[cat]
        local symbol = entry and entry[1]
        if symbol then
            featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:' .. symbol)
        else
            featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
        end
    end

    -- CEVNI
    if system == 11 then
        local entry = CATEGORY_SYMBOLS_CEVNI[cat]
        local symbol = entry and entry[1]
        local size   = entry and entry[2] or 0
        local text   = ""

        if symbol then
            if cat == 58 then
                if feature.information and feature.information[1] and feature.information[1].text then
                    symbol = symbol .. feature.information[1].text
                else
                    symbol = symbol .. '1'
                end
            end
            featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:' .. symbol)
        else
            featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
        end

        if feature.information and feature.information[1] and feature.information[1].text then
            text = feature.information[1].text

            if cat == 32 or cat == 37 or cat == 38 or cat == 39 or cat == 40 or
               cat == 41 or cat == 42 or cat == 43 or cat == 56 or cat == 71 or
               cat == 99 or cat == 119 or cat == 121 then

                if cat == 32 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, 0.0, 6.51, 'CHBLK', 'Center')
                elseif cat == 37 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, -1.05, 4.0, 'CHBLK', 'Center')
                elseif cat == 38 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, 1.05, 6.0, 'CHBLK', 'Center')
                elseif cat == 39 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, -1.05, 6.0, 'CHBLK', 'Center')
                elseif cat == 40 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, 0.0, 2.8, 'CHBLK', 'Center')
                elseif cat == 41 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, -4.65, 7.0, 'CHBLK', 'Center')
                elseif cat == 42 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, -2.51, 0.0, 4.52, 'WHITE', 'Start')
                elseif cat == 43 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 2.51, 0.0, 4.52, 'WHITE', 'End')
                elseif cat == 56 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 2.51, 0.0, 4.52, 'WHITE', 'End')
                elseif cat == 71 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 2.51, 0.0, 4.52, 'CHBLK', 'Center')
                elseif cat == 99 then
                    local t = string.sub(text, 5)
                    DrawAdditionalInformation(feature, featurePortrayal, t, size, baseX, baseY, 0.0, -1.05, 4.0, 'WHITE', 'Center')
                elseif cat == 119 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, -0.3, 5.8, 'AZUBL', 'Center')
                elseif cat == 121 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0.0, 0.0, 5.51, 'AZUBL', 'Center')
                end
            else
                if cat ~= 58 then
                    DrawAdditionalInformation(feature, featurePortrayal, text, size, baseX, baseY, 0, 0, 5.51, 'CHBLK', 'Center')
                end
            end
        else
            if #feature.additionalMark > 0 and cat ~= 58 then
                DrawAdditionalInformation(feature, featurePortrayal, '', size, baseX, baseY, 0, 0, 5.51, 'CHBLK', 'Center')
            end
        end

        if cat == 7 and feature.distanceFromNoticeMarkSecond then
            local t = tostring(feature.distanceFromNoticeMarkSecond)
            DrawAdditionalInformation(feature, featurePortrayal, t, size, baseX, baseY, 0, 0, 5.51, 'CHBLK', 'Center')
        elseif cat == 14 then
            DrawAdditionalInformation(feature, featurePortrayal, '', size, baseX, baseY, 0, 0, 5.51, 'CHBLK', 'Center')
        end
    end

    -- Russian
    if system == 12 then
        local entry = CATEGORY_SYMBOLS_RUSSIAN[cat]
        local symbol = entry and entry[1]
        local size   = entry and entry[2] or 0

        if symbol then
            featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:' .. symbol)
        else
            featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
        end

        if cat == 39 then
            local t = ""
            if feature.information and feature.information[1] and feature.information[1].text then
                t = feature.information[1].text
            end
            DrawAdditionalInformation(feature, featurePortrayal, t, size, baseX, baseY, 0.0, -1.05, 6.0, 'CHBLK', 'Center')
        end
    end

    -- Brazilian 13
    if system == 13 then
        local entry = CATEGORY_SYMBOLS_BRAZILIAN_13[cat]
        local symbol = entry and entry[1]
        local size   = entry and entry[2] or 0

        if symbol then
            if cat == 8 or cat == 39 or cat == 103 or cat == 104 or cat == 105 or
               cat == 106 or cat == 107 or cat == 108 or cat == 109 then
                if feature.bankOfTheWaterway == 1 then symbol = symbol .. 'R' end
                if feature.bankOfTheWaterway == 2 then symbol = symbol .. 'G' end
            end
            if cat == 82 or cat == 83 then
                if feature.bankOfTheWaterway == 1 then symbol = symbol .. 'L' end
                if feature.bankOfTheWaterway == 2 then symbol = symbol .. 'R' end
            end
            featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:' .. symbol)
        else
            featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
        end

        if cat == 39 then
            local t = ""
            if feature.information and feature.information[1] and feature.information[1].text then
                t = feature.information[1].text
            end
            DrawAdditionalInformation(feature, featurePortrayal, t, size, baseX, baseY, 0.0, -1.35, 6.0, 'CHBLK', 'Center')
        end
    end

    -- Brazilian 15
    if system == 15 then
        local entry = CATEGORY_SYMBOLS_BRAZILIAN_15[cat]
        local symbol = entry and entry[1]
        local size   = entry and entry[2] or 0

        if symbol then
            if feature.bankOfTheWaterway == 1 then symbol = symbol .. 'R' end
            if feature.bankOfTheWaterway == 2 then symbol = symbol .. 'G' end
            featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:' .. symbol)
        else
            featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
        end
    end

    return viewingGroup
end

---------------------------------------------------------------
-- Fanned-out NoticeMarks
---------------------------------------------------------------

local function snapZero(value)
    return math.abs(value) < 1e-10 and 0 or value
end

function NoticeMark(feature, featurePortrayal, contextParameters)
    local viewingGroup = 27250
    local marksNavigationalSystemOf = MARSYS01(feature, featurePortrayal, contextParameters, viewingGroup)

    local totalMarks = 0
    local ourMarkPosition = 0
    local functionNoticeMark = 5

    for pointAssociation in feature:GetFlattenedSpatialAssociations() do
        local associatedFeatures = pointAssociation.AssociatedFeatures
        for _, af in ipairs(associatedFeatures) do
            if af.Code == 'NoticeMark' then
                totalMarks = totalMarks + 1
                local fn = af.functionOfNoticeMark or 5
                if fn < functionNoticeMark then
                    functionNoticeMark = fn
                end
                if af == feature then
                    ourMarkPosition = totalMarks
                end
            end
        end
    end

    Debug.Trace('NoticeMark ' .. feature.ID .. ' ' .. ourMarkPosition .. ' of ' .. totalMarks)

    featurePortrayal:AddInstructions(
        'ViewingGroup:27250;DrawingPriority:32;DisplayPlane:' ..
        (contextParameters.RadarOverlay and 'OverRadar' or 'UnderRadar')
    )

    if totalMarks == 1 or not contextParameters.FanOutNoticeMarks then
        if totalMarks == 1 then
            DrawNoticeMark(feature, featurePortrayal, contextParameters, 0, 0)
        else
            local simple
            local scaleFactor
            if contextParameters.SimplifiedSymbols then
                simple = { [1]="NOTMRK01", [2]="NOTMRK02", [3]="NOTMRK02", [4]="NOTMRK03", [5]="NOTMRK03" }
                scaleFactor=1
            else
                simple = { [1]="NOTMRK04", [2]="NOTMRK05", [3]="NOTMRK05", [4]="NOTMRK06", [5]="NOTMRK06" }
                scaleFactor=3
            end
            local sym = simple[functionNoticeMark]
            if sym then
                featurePortrayal:AddInstructions('ScaleFactor:' .. scaleFactor ..';PointInstruction:' .. sym)
            end
        end
    else
        local deltaAngle = 360 / totalMarks
        local length = 10
        if totalMarks > 5 then
            length = 15
        end

        local curAngle = deltaAngle * (ourMarkPosition - 1)

        featurePortrayal:AddInstructions('DrawingPriority:24;AugmentedRay:LocalCRS,' .. curAngle .. ',LocalCRS,' .. length)
        featurePortrayal:SimpleLineStyle('solid', 0.16, 'CHBLK')
        featurePortrayal:AddInstructions('LineInstruction:_simple_')
        featurePortrayal:AddInstructions('ClearGeometry')

        local radians = math.rad(90 - curAngle)
        local x = length * snapZero(math.cos(radians))
        local y = length * snapZero(math.sin(radians))

        Debug.Trace('Fanned NoticeMark: angle=' .. curAngle .. ' x=' .. x .. ' y=' .. y)

        DrawNoticeMark(feature, featurePortrayal, contextParameters, x, y)
    end

    return viewingGroup
end
