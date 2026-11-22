-- LUA script
-- Notice Mark main entry point.


-- require 'NOTMRKI1'
require 'MARSYS01'


function SplitComma(text)
    --  prevent crashes if text is nil or not a string
    if type(text) ~= "string" then
        return {}
    end

    -- Return an empty array immediately if the string is empty
    if text == "" then
        return {}
    end

    local result = {}
    
    -- match everything that isn't a comma
    for match in text:gmatch("([^,]*),?") do
        table.insert(result, match)
    end
    
    -- gmatch pattern creates an extra trailing empty match at the end
    if #result > 1 and result[#result] == "" then
        table.remove(result)
    end

    return result
end
function StringToNumber(str)
    -- Guard against nil or non-string types
    if type(str) ~= "string" then
        return nil
    end
    
    -- Trim trailing/leading spaces
    local cleanStr = str:match("^%s*(.-)%s*$")
    
    return tonumber(cleanStr)
end

local ROMAN_VALUES = {
	{1000, "M"},
	{900,  "CM"},
	{500,  "D"},
	{400,  "CD"},
	{100,  "C"},
	{90,   "XC"},
	{50,   "L"},
	{40,   "XL"},
	{10,   "X"},
	{9,    "IX"},
	{5,    "V"},
	{4,    "IV"},
	{1,    "I"}
}

function ToRoman(number)
    -- Ensure it's a positive number. If not, return an empty string safely.
    if type(number) ~= "number" or number < 1 then
        return ""
    end

    -- Strip out decimals to prevent fraction calculation loops
    number = math.floor(number)

    local roman = ""

    for i = 1, #ROMAN_VALUES do
        local item   = ROMAN_VALUES[i]
        local value  = item[1]
        local symbol = item[2]

        if number >= value then
            local count = math.floor(number / value)
            roman = roman .. string.rep(symbol, count)
            number = number % value
        end
        
        -- stop iterating if the number hits 0
        if number == 0 then 
            break 
        end
    end

    return roman
end

local function GetVisualLength(text)

    -- handle nil or non-string inputs gracefully
    if type(text) ~= "string" or text == "" then
        return 0
    end

    local len = 0

    for c in text:gmatch(".") do

        if c:match("[%u%d]") then
            len = len + 0.75      -- hoofdletters/cijfers
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

local function SetTextInRectangle(featurePortrayal, text, centerX, centerY, width, color, align) 
    local visualLength = GetVisualLength(text)

    -- Prevent division by zero if text is empty or has zero length
    if not visualLength or visualLength <= 0 then 
        visualLength = 1 
    end

    local rectWidthMm = (width - 0.2)
    local fontSizePt = rectWidthMm / (visualLength * 0.3528)

    featurePortrayal:AddInstructions('LocalOffset:'..centerX..','..centerY..';TextAlignHorizontal:'..align..';TextAlignVertical:Center;FontWeight:Bold;FontSize:'..fontSizePt..';FontColor:'..color..'')
    featurePortrayal:AddTextInstruction(text, 29, 24, 27250, 32, false)   
end

function NoticeMark(feature, featurePortrayal, contextParameters)
	local viewingGroup 
    local text
	local marksNavigationalSystemOf = MARSYS01(feature, featurePortrayal, contextParameters, viewingGroup)
	local informationText
    local distanceFromNoticeMarkSecond = feature.distanceFromNoticeMarkSecond
	local orientationValue = feature.orientationValue

	if feature.information and feature.information[1] and feature.information[1].text then
		informationText = feature.information[1].text
	end

	-- Simplified and paper chart points use the same symbolization
	if feature.PrimitiveType == PrimitiveType.Point then
        viewingGroup = 27250
        if contextParameters.RadarOverlay then
            featurePortrayal:AddInstructions('ViewingGroup:27250;DrawingPriority:32;DisplayPlane:OverRadar')
        else				
            featurePortrayal:AddInstructions('ViewingGroup:27250;DrawingPriority:32;DisplayPlane:UnderRadar')
        end

        if contextParameters.SimplifiedSymbols then
            if (feature.functionOfNoticeMark == 1) then 
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK01')      
            elseif (feature.functionOfNoticeMark == 2) then    
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')  
            elseif (feature.functionOfNoticeMark == 3) then    
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')  
            elseif (feature.functionOfNoticeMark == 4) then     
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK03')  
            elseif (feature.functionOfNoticeMark == 5) then     
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK03')  
            end 
        else
            ----------------------------------------
            -- If the marking system is IALA B (US):
            ----------------------------------------   
            if (marksNavigationalSystemOf == 2) then   
                if (feature.categoryOfNoticeMark == 1) then                
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                    end   
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
                elseif (feature.categoryOfNoticeMark == 6) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH07')  
                elseif (feature.categoryOfNoticeMark == 8) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH08')              
                elseif (feature.categoryOfNoticeMark == 114) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRE101')  
                else
                    featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')  
                end
                
            -------------------------------------------
            -- If the marking system is European CEVNI:
            -------------------------------------------        
            elseif (marksNavigationalSystemOf == 11) then           
                if (feature.categoryOfNoticeMark == 1) then                
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
                elseif (feature.categoryOfNoticeMark == 2) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH03')                
                elseif (feature.categoryOfNoticeMark == 3) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH04')                
                elseif (feature.categoryOfNoticeMark == 4) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH05')           
                elseif (feature.categoryOfNoticeMark == 5) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH06')               
                elseif (feature.categoryOfNoticeMark == 6) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH07')                    
                elseif (feature.categoryOfNoticeMark == 7) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKPRH07A')    
					if distanceFromNoticeMarkSecond then
						text=EncodeString(distanceFromNoticeMarkSecond , '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 5.51, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 8) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH08')            
                elseif (feature.categoryOfNoticeMark == 9) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH09')            
                elseif (feature.categoryOfNoticeMark == 10) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH10')           
                elseif (feature.categoryOfNoticeMark == 11) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH11')          
                elseif (feature.categoryOfNoticeMark == 12) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')          
                elseif (feature.categoryOfNoticeMark == 13) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')          
                elseif (feature.categoryOfNoticeMark == 14) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH14')          
                elseif (feature.categoryOfNoticeMark == 15) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH15')          
                elseif (feature.categoryOfNoticeMark == 16) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH16')         
                elseif (feature.categoryOfNoticeMark == 17) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH17')         
                elseif (feature.categoryOfNoticeMark == 18) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH18')         
                elseif (feature.categoryOfNoticeMark == 19) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH19')         
                elseif (feature.categoryOfNoticeMark == 20) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH20')         
                elseif (feature.categoryOfNoticeMark == 21) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH21')       
                elseif (feature.categoryOfNoticeMark == 22) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH22')       
                    
                -- =================
                -- Check PresLib !!!
                -- =================
                elseif (feature.categoryOfNoticeMark == 23) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                    end 
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG21')   
                elseif (feature.categoryOfNoticeMark == 24) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end 
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG22')   
                elseif (feature.categoryOfNoticeMark == 25) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG04')       
                elseif (feature.categoryOfNoticeMark == 26) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG05')       
                elseif (feature.categoryOfNoticeMark == 27) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG06')      
                elseif (feature.categoryOfNoticeMark == 28) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG07')      
                elseif (feature.categoryOfNoticeMark == 29) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG08')      
                elseif (feature.categoryOfNoticeMark == 30) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG09')      
                elseif (feature.categoryOfNoticeMark == 31) then
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                        featurePortrayal:AddInstructions('PointInstruction:NMKREG23')  
                    else
                        featurePortrayal:AddInstructions('PointInstruction:NMKREG10')      
                    end 
                elseif (feature.categoryOfNoticeMark == 32) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG01') 
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 6.51, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 33) then
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                        featurePortrayal:AddInstructions('PointInstruction:NMKREG24')  
                    else
                        featurePortrayal:AddInstructions('PointInstruction:NMKREG11')      
                    end    
                elseif (feature.categoryOfNoticeMark == 34) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG12')     
                elseif (feature.categoryOfNoticeMark == 35) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG13')     
                elseif (feature.categoryOfNoticeMark == 36) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG14')     
                elseif (feature.categoryOfNoticeMark == 37) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG15') 
					if informationText then
						text=EncodeString(informationText, '%s') 
						text=string.sub(text, 5) -- temporary until instruction is set in DCEG
						SetTextInRectangle(featurePortrayal, text, 0.0, -1.5, 3.0, 'CHBLK', 'Center')
					end
                elseif (feature.categoryOfNoticeMark == 38) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG16')    
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, 1.05, 6.0, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 39) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG17')   
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 6.0, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 40) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG18')  
					if informationText then
						text=EncodeString(informationText, '%s')
						SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 2.8, 'CHBLK', 'Center')
					end
                elseif (feature.categoryOfNoticeMark == 41) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:ADDMRK05')  
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG01')  
					if informationText then
						text=EncodeString(informationText, '%s')
						SetTextInRectangle(featurePortrayal, text, 0.0, -4.65, 8.0, 'CHBLK', 'Center')  
					end
                elseif (feature.categoryOfNoticeMark == 42) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG19')  
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, -2.51, 0.0, 4.52, 'WHITE', 'Start')
					end
                elseif (feature.categoryOfNoticeMark == 43) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG20')  
					if informationText then
						text=EncodeString(informationText, '%s')  
						SetTextInRectangle(featurePortrayal, text, 2.51, 0.0, 4.52, 'WHITE', 'End')
					end
                elseif (feature.categoryOfNoticeMark == 44) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
                elseif (feature.categoryOfNoticeMark == 45) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')    
                elseif (feature.categoryOfNoticeMark == 46) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')    
                elseif (feature.categoryOfNoticeMark == 47) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')      
                elseif (feature.categoryOfNoticeMark == 48) then                
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                        featurePortrayal:AddInstructions('PointInstruction:NMKRCD07')  
                    else
                        featurePortrayal:AddInstructions('PointInstruction:NMKRCD05')      
                    end    
                elseif (feature.categoryOfNoticeMark == 49) then             
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                        featurePortrayal:AddInstructions('PointInstruction:NMKRCD08')  
                    else
                        featurePortrayal:AddInstructions('PointInstruction:NMKRCD06')      
                    end           
                elseif (feature.categoryOfNoticeMark == 50) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF01')  
                elseif (feature.categoryOfNoticeMark == 51) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF02')    
                elseif (feature.categoryOfNoticeMark == 52) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF03') 
                elseif (feature.categoryOfNoticeMark == 53) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF04') 
                elseif (feature.categoryOfNoticeMark == 54) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF05') 
                elseif (feature.categoryOfNoticeMark == 55) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF06') 

                -- ===============================================================================================
                -- No symbol forseen on which this can be displayed.
                -- ===============================================================================================   
                elseif (feature.categoryOfNoticeMark == 56) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF05') 
                elseif (feature.categoryOfNoticeMark == 57) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF05')       
                elseif (feature.categoryOfNoticeMark == 58) then
					local isValid = false
					-- check if the text property exists
					if informationText then
						local num = StringToNumber(informationText)

						-- validate that it is an integer between 1 and 5
						if num and num >= 1 and num <= 5 and num == math.floor(num) then
							isValid = true
							text = tostring(num) -- Use the cleaned number to avoid trailing spaces/zeros
						end
					end

					if isValid then
						local symbol = "NMKINF5" .. text
						featurePortrayal:AddInstructions('PointInstruction:' .. symbol) 
					else
						featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
					end
                elseif (feature.categoryOfNoticeMark == 59) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF07')
                elseif (feature.categoryOfNoticeMark == 60) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF08') 
                elseif (feature.categoryOfNoticeMark == 61) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF09')
                elseif (feature.categoryOfNoticeMark == 62) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF10')
                elseif (feature.categoryOfNoticeMark == 63) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF11')
                elseif (feature.categoryOfNoticeMark == 64) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF12')
                elseif (feature.categoryOfNoticeMark == 65) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF13')
                elseif (feature.categoryOfNoticeMark == 66) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF14')
                elseif (feature.categoryOfNoticeMark == 67) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF15')
                elseif (feature.categoryOfNoticeMark == 68) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF16')
                elseif (feature.categoryOfNoticeMark == 69) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF17')
                elseif (feature.categoryOfNoticeMark == 70) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF18')
                elseif (feature.categoryOfNoticeMark == 71) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF19')
                elseif (feature.categoryOfNoticeMark == 72) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF20')
                elseif (feature.categoryOfNoticeMark == 73) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF21')
                elseif (feature.categoryOfNoticeMark == 74) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF22')
                elseif (feature.categoryOfNoticeMark == 75) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF23')
                elseif (feature.categoryOfNoticeMark == 76) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF24')
                elseif (feature.categoryOfNoticeMark == 77) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF25')
                elseif (feature.categoryOfNoticeMark == 78) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF26')
                elseif (feature.categoryOfNoticeMark == 79) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF27')
                elseif (feature.categoryOfNoticeMark == 80) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF28')
                elseif (feature.categoryOfNoticeMark == 81) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF29')
                elseif (feature.categoryOfNoticeMark == 82) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF30')
                elseif (feature.categoryOfNoticeMark == 83) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF31')
                elseif (feature.categoryOfNoticeMark == 84) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF32')
                elseif (feature.categoryOfNoticeMark == 85) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF33')
                elseif (feature.categoryOfNoticeMark == 86) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF34')
                elseif (feature.categoryOfNoticeMark == 87) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF35')
                elseif (feature.categoryOfNoticeMark == 88) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF36')
                elseif (feature.categoryOfNoticeMark == 89) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF37')
                elseif (feature.categoryOfNoticeMark == 90) then           
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')    
                        featurePortrayal:AddInstructions('PointInstruction:NMKINF60')  
                    else
                        featurePortrayal:AddInstructions('PointInstruction:NMKINF38')      
                    end           
                elseif (feature.categoryOfNoticeMark == 91) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF39')
                elseif (feature.categoryOfNoticeMark == 92) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF40')
                elseif (feature.categoryOfNoticeMark == 93) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF41')
                elseif (feature.categoryOfNoticeMark == 94) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF42')
                elseif (feature.categoryOfNoticeMark == 95) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF43')
                elseif (feature.categoryOfNoticeMark == 96) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF44')
                elseif (feature.categoryOfNoticeMark == 97) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF45')
                elseif (feature.categoryOfNoticeMark == 98) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF46')
                elseif (feature.categoryOfNoticeMark == 99) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKINF47A')
					if informationText then
						text=EncodeString(informationText, '%s') 
						text=string.sub(text, 5) -- temporary until instruction is set in DCEG
						SetTextInRectangle(featurePortrayal, text, 0.0, -1.5, 4.0, 'WHITE', 'Center')    
					end
                elseif (feature.categoryOfNoticeMark == 100) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF48')
                elseif (feature.categoryOfNoticeMark == 101) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF49')    
                elseif (feature.categoryOfNoticeMark == 102) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF50')
                elseif (feature.categoryOfNoticeMark == 110) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG50')
                elseif (feature.categoryOfNoticeMark == 111) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG51')
                elseif (feature.categoryOfNoticeMark == 117) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF56')
                elseif (feature.categoryOfNoticeMark == 118) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF57')
                elseif (feature.categoryOfNoticeMark == 119) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKINF57')
					if informationText then
						text=StringToNumber(informationText) 
						text=ToRoman(text)
						SetTextInRectangle(featurePortrayal, text, 0.0, -0.3, 5.8, 'AZUBL', 'Center')   
					end
                elseif (feature.categoryOfNoticeMark == 120) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF58')
                elseif (feature.categoryOfNoticeMark == 121) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKINF58')
					if informationText then
						local values = SplitComma(informationText)
						if values[1] then
							local num = StringToNumber(values[1])
							if num and num > 0 then
								text = ToRoman(num)
								SetTextInRectangle(featurePortrayal, text, 0.0, 1.51, 2.5, 'AZUBL', 'Center') 
							end
						end
						if values[2] then
							local num = StringToNumber(values[2])
							if num and num > 0 then
								text = ToRoman(num)
								SetTextInRectangle(featurePortrayal, text, 0.0, -1.51, 3, 'AZUBL', 'Center') 
							end
						end
					end
                elseif (feature.categoryOfNoticeMark == 122) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF59')
                elseif (feature.categoryOfNoticeMark == 123) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG25')
                elseif (feature.categoryOfNoticeMark == 128) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH06A')
                elseif (feature.categoryOfNoticeMark == 12) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end 
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')
                elseif (feature.categoryOfNoticeMark == 13) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')
                elseif (feature.categoryOfNoticeMark == 44) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')
                elseif (feature.categoryOfNoticeMark == 45) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')
                elseif (feature.categoryOfNoticeMark == 46) then
                    if (orientationValue) then 
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')
                elseif (feature.categoryOfNoticeMark == 47) then
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')
                elseif (feature.categoryOfNoticeMark == 50) then
                    if (orientationValue) then
                        featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(orientationValue) .. '')
                    end
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF01')
                else
                    featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
                end
            -------------------------------------------
            -- If the marking system is Russian:
            -------------------------------------------        
            elseif (marksNavigationalSystemOf == 12) then            
                if (feature.categoryOfNoticeMark == 5) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPR103')                
                elseif (feature.categoryOfNoticeMark == 8) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPR101')               
                elseif (feature.categoryOfNoticeMark == 11) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPR104')               
                elseif (feature.categoryOfNoticeMark == 39) then
                    featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKRE103')   
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 6.0, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 74) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKIN101')
                elseif (feature.categoryOfNoticeMark == 112) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPR102')
                elseif (feature.categoryOfNoticeMark == 113) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPR105')
                elseif (feature.categoryOfNoticeMark == 114) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRE101')
                elseif (feature.categoryOfNoticeMark == 115) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRE102')
                elseif (feature.categoryOfNoticeMark == 116) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKIN102')
                else
                    featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
                end
            -------------------------------------------
            -- If the marking system is Brazilian:
            -------------------------------------------        
            elseif (marksNavigationalSystemOf == 13) then
                if (feature.categoryOfNoticeMark == 1) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')  
                elseif (feature.categoryOfNoticeMark == 8) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC008R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC008G')            
                    end
                elseif (feature.categoryOfNoticeMark == 39) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKAC039R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKAC039G')            
                    end 
					if informationText then
						text=EncodeString(informationText, '%s') 
						SetTextInRectangle(featurePortrayal, text, 0.0, -1.35, 6.0, 'CHBLK', 'Center') 
					end
                elseif (feature.categoryOfNoticeMark == 44) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
                elseif (feature.categoryOfNoticeMark == 45) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')    
                elseif (feature.categoryOfNoticeMark == 82) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE082L')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE082R')            
                    end 
                elseif (feature.categoryOfNoticeMark == 83) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE083L')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE083R')            
                    end 
                elseif (feature.categoryOfNoticeMark == 103) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC103R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC103G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 104) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC104R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC104G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 105) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC105R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC105G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 106) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC106R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC106G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 107) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC107R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC107G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 108) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC108R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC108G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 109) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC109R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAC109G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 44) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
                elseif (feature.categoryOfNoticeMark == 45) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')                 
                elseif (feature.categoryOfNoticeMark == 124) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKAD124')                                    
                elseif (feature.categoryOfNoticeMark == 125) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKAD125')                                       
                elseif (feature.categoryOfNoticeMark == 126) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKAD126')                                
                elseif (feature.categoryOfNoticeMark == 127) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKAD127')        
                else
                    featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
                end
            -----------------------------------------------
            -- If the marking system is Brazilian Paraguay:
            -----------------------------------------------        
            elseif (marksNavigationalSystemOf == 15) then

                if (feature.categoryOfNoticeMark == 103) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE103R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE103G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 104) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE104R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE104G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 105) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE105R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE105G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 106) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE106R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE106G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 107) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE107R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE107G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 108) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE108R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE108G')            
                    end  
                elseif (feature.categoryOfNoticeMark == 109) then
                    if (feature.bankOfTheWaterway == 1) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE109R')  
                    elseif (feature.bankOfTheWaterway == 2) then
                        featurePortrayal:AddInstructions('PointInstruction:NMKAE109G')            
                    end  
                else
                    featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
                end
            else         
                -- Navigational system of marks is unknown
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
            end 
        
            


            ------------------------------------------------------------
            -- Additional marks
            --
            -- Make difference between square and landscape rectangle!
            ------------------------------------------------------------
            -- Top board
            if (feature.additionalMark==1) then
                
            -- Bottom board
            elseif (feature.additionalMark==2) then
                
            -- Right triangle
            elseif (feature.additionalMark==3) then
                
            -- Left triangle
            elseif (feature.additionalMark==4) then
                
            -- Bottom triangle
            elseif (feature.additionalMark==5) then
            end 
        end 
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
