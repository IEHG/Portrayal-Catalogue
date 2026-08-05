-- LUA script
-- Notice Mark main entry point.


-- require 'NOTMRKI1'
require 'MARSYS01'


function SplitComma(text)

	local result = {}
	local current = ""

	for i = 1, #text do

		local c = string.sub(text, i, i)

		if c == "," then
			result[#result + 1] = current
			current = ""
		else
			current = current .. c
		end
	end

	-- laatste element toevoegen
	result[#result + 1] = current

	return result
end

function StringToNumber(str)

	local value = 0

	for i = 1, #str do
		local c = string.sub(str, i, i)

		value = value * 10 + (
			string.byte(c) - string.byte("0")
		)
	end

	return value
end

function ToRoman(number)

	local roman = ""

	local values = {
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

	for _, item in ipairs(values) do
		local value  = item[1]
		local symbol = item[2]

		while number >= value do
			roman = roman .. symbol
			number = number - value
		end
	end

	return roman
end

local function GetVisualLength(text)

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
	local rectWidthMm = (width - 0.2)
	local fontSizePt = rectWidthMm / (visualLength * 0.3528)

	featurePortrayal:AddInstructions('DrawingPriority:25;LocalOffset: '..centerX..','..centerY..';TextAlignHorizontal:'..align..';TextAlignVertical:Center;FontWeight:Bold;FontSize:'..fontSizePt..';FontColor:'..color..'')
	featurePortrayal:AddTextInstruction(text, 29, 24, 21020)   
end

local function DrawSymbol(feature, featurePortrayal, contextParameters, marksNavigationalSystemOf)
	local text

	-- Simplified and paper chart points use the same symbolization
	if feature.PrimitiveType == PrimitiveType.Point then
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
					featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
					end   
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
					featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
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
					text=EncodeString(feature.distanceFromNoticeMarkSecond , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 5.51, 'CHBLK', 'Center') 
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
					featurePortrayal:AddInstructions('PointInstruction:NMKREG21')   
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
					end 
				elseif (feature.categoryOfNoticeMark == 24) then
					featurePortrayal:AddInstructions('PointInstruction:NMKREG22')   
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end 
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
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('PointInstruction:NMKREG23')  
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
					else
						featurePortrayal:AddInstructions('PointInstruction:NMKREG10')      
					end 
				elseif (feature.categoryOfNoticeMark == 32) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG01') 
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 6.51, 'CHBLK', 'Center') 
				elseif (feature.categoryOfNoticeMark == 33) then
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('PointInstruction:NMKREG24')  
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
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
					text=EncodeString(feature.information[1].text , '%s') 
					text=string.sub(text, 5) -- temporary until instruction is set in DCEG
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 4.0, 'CHBLK', 'Center')
				elseif (feature.categoryOfNoticeMark == 38) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG16')    
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, 1.05, 6.0, 'CHBLK', 'Center') 
				elseif (feature.categoryOfNoticeMark == 39) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG17')   
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 6.0, 'CHBLK', 'Center') 
				elseif (feature.categoryOfNoticeMark == 40) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG18')  
					text=EncodeString(feature.information[1].text , '%s')
					SetTextInRectangle(featurePortrayal, text, 0.0, 0.0, 2.8, 'CHBLK', 'Center')
				elseif (feature.categoryOfNoticeMark == 41) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:ADDMRK05')  
					featurePortrayal:AddInstructions('PointInstruction:NMKREG01')  
					text=EncodeString(feature.information[1].text , '%s')
					SetTextInRectangle(featurePortrayal, text, 0.0, -4.65, 7.0, 'CHBLK', 'Center')  
				elseif (feature.categoryOfNoticeMark == 42) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG19')  
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, -2.51, 0.0, 4.52, 'WHITE', 'Start')
				elseif (feature.categoryOfNoticeMark == 43) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKREG20')  
					text=EncodeString(feature.information[1].text , '%s')  
					SetTextInRectangle(featurePortrayal, "200", 2.51, 0.0, 4.52, 'WHITE', 'End')                    
				elseif (feature.categoryOfNoticeMark == 44) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
				elseif (feature.categoryOfNoticeMark == 45) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')    
				elseif (feature.categoryOfNoticeMark == 46) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')    
				elseif (feature.categoryOfNoticeMark == 47) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')      
				elseif (feature.categoryOfNoticeMark == 48) then                
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('PointInstruction:NMKRCD07')  
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
					else
						featurePortrayal:AddInstructions('PointInstruction:NMKRCD05')      
					end    
				elseif (feature.categoryOfNoticeMark == 49) then             
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('PointInstruction:NMKRCD08')  
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
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
					local symbol = "NMKINF5"..feature.information[1].text
					featurePortrayal:AddInstructions('PointInstruction:'..symbol) 
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
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('PointInstruction:NMKINF60')  
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
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
					text=EncodeString(feature.information[1].text , '%s') 
					text=string.sub(text, 5) -- temporary until instruction is set in DCEG
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 4.0, 'WHITE', 'Center')    
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
					text=StringToNumber(feature.information[1].text) 
					text=ToRoman(text)
					SetTextInRectangle(featurePortrayal, text, 0.0, -0.3, 5.8, 'AZUBL', 'Center')   
				elseif (feature.categoryOfNoticeMark == 120) then
					featurePortrayal:AddInstructions('PointInstruction:NMKINF58')
				elseif (feature.categoryOfNoticeMark == 121) then
					featurePortrayal:AddInstructions('DrawingPriority:24;PointInstruction:NMKINF58')
					text=feature.information[1].text
					local values = SplitComma(text)
					text = ToRoman(StringToNumber(values[1]))
					SetTextInRectangle(featurePortrayal, text, 0.0, 1.51, 2.5, 'AZUBL', 'Center') 
					text = ToRoman(StringToNumber(values[2]))
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.51, 3, 'AZUBL', 'Center') 
				elseif (feature.categoryOfNoticeMark == 122) then
					featurePortrayal:AddInstructions('PointInstruction:NMKINF59')
				elseif (feature.categoryOfNoticeMark == 123) then
					featurePortrayal:AddInstructions('PointInstruction:NMKREG25')
				elseif (feature.categoryOfNoticeMark == 128) then
					featurePortrayal:AddInstructions('PointInstruction:NMKPRH06A')
				elseif (feature.categoryOfNoticeMark == 12) then
					featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end 
				elseif (feature.categoryOfNoticeMark == 13) then
					featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
				elseif (feature.categoryOfNoticeMark == 44) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
				elseif (feature.categoryOfNoticeMark == 45) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')
					if (feature.orientationValue) then featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
				elseif (feature.categoryOfNoticeMark == 46) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')
					if (feature.orientationValue) then 
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
				elseif (feature.categoryOfNoticeMark == 47) then
					featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
				elseif (feature.categoryOfNoticeMark == 50) then
					featurePortrayal:AddInstructions('PointInstruction:NMKINF01')
					if (feature.orientationValue) then
						featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
					end
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
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.05, 6.0, 'CHBLK', 'Center') 
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
					text=EncodeString(feature.information[1].text , '%s') 
					SetTextInRectangle(featurePortrayal, text, 0.0, -1.35, 6.0, 'CHBLK', 'Center') 
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
end

-- Mostly for neatness when debugging.
local function snapZero(value)
	return math.abs(value) < 1e-10 and 0 or value
end

function NoticeMark(feature, featurePortrayal, contextParameters)
	local viewingGroup = 27250
	local marksNavigationalSystemOf = MARSYS01(feature, featurePortrayal, contextParameters, viewingGroup)

	local totalMarks = 0
	local ourMarkPosition = 0

	local coNoticeMarks = {}

	for pointAssociation in feature:GetFlattenedSpatialAssociations() do
		local associatedFeatures = pointAssociation.AssociatedFeatures

		for _, af in ipairs(associatedFeatures) do
			if af.Code == 'NoticeMark' then
				totalMarks = totalMarks + 1

				coNoticeMarks[totalMarks] = af

				if af == feature then
					ourMarkPosition = totalMarks
				end
			end
		end
	end

	Debug.Trace('NoticeMark ' .. feature.ID .. ' ' .. ourMarkPosition .. ' of ' .. totalMarks)

	if contextParameters.RadarOverlay then
		featurePortrayal:AddInstructions('ViewingGroup:27250;DrawingPriority:32;DisplayPlane:OverRadar')
	else				
		featurePortrayal:AddInstructions('ViewingGroup:27250;DrawingPriority:32;DisplayPlane:UnderRadar')
	end

	if ourMarkPosition == 1 then
		if totalMarks == 1 then
			DrawSymbol(feature, featurePortrayal, contextParameters, marksNavigationalSystemOf)
		else
			local deltaAngle = 360 / totalMarks
			local length = 10

			if totalMarks > 6 then
				-- Spread out marks for more breathing room.
				-- TODO: Determine maximum number of marks and mitigation strategy.
				length = 15
			end

			for i = 1, totalMarks do
				local curAngle = deltaAngle * (i - 1)

				featurePortrayal:AddInstructions('AugmentedRay:LocalCRS,' .. curAngle .. ',LocalCRS,' .. length)
				featurePortrayal:SimpleLineStyle('solid',0.32,'CHBLK')
				featurePortrayal:AddInstructions('LineInstruction:_simple_')
				featurePortrayal:AddInstructions('ClearGeometry')

				local radians = math.rad(90 - curAngle)
				
				local x = length * snapZero(math.cos(radians))
				local y = length * snapZero(math.sin(radians))

				featurePortrayal:AddInstructions('AugmentedPoint:LocalCRS,' .. x .. ',' .. y)

				Debug.Trace('AugmentedRay:LocalCRS,' .. curAngle .. ',LocalCRS,' .. length)
				Debug.Trace('AugmentedPoint:LocalCRS,' .. x .. ',' .. y .. '  curAngle:' .. curAngle .. ' radians:' .. radians)

				DrawSymbol(coNoticeMarks[i], featurePortrayal, contextParameters, marksNavigationalSystemOf)

				featurePortrayal:AddInstructions('ClearGeometry')
			end
		end
	end

	return viewingGroup
end
