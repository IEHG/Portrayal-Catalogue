-- TOPMAR02 conditional symbology rules file.

local floatingTopmarks =
{
	[1] = 'TOPMAR02',
	[2] = 'TOPMAR04',
	[3] = 'TOPMAR10',
	[4] = 'TOPMAR12',
	[5] = 'TOPMAR13',
	[6] = 'TOPMAR14',
	[7] = 'TOPMAR65',
	[8] = 'TOPMAR17',
	[9] = 'TOPMAR16',
	[10] = 'TOPMAR08',
	[11] = 'TOPMAR07',
	[12] = 'TOPMAR14',
	[13] = 'TOPMAR05',
	[14] = 'TOPMAR06',
	[15] = 'TMARDEF2',
	[16] = 'TMARDEF2',
	[17] = 'TMARDEF2',
	[18] = 'TOPMAR10',
	[19] = 'TOPMAR13',
	[20] = 'TOPMAR14',
	[21] = 'TOPMAR13',
	[22] = 'TOPMAR14',
	[23] = 'TOPMAR14',
	[24] = 'TOPMAR02',
	[25] = 'TOPMAR04',
	[26] = 'TOPMAR10',
	[27] = 'TOPMAR17',
	[28] = 'TOPMAR18',
	[29] = 'TOPMAR02',
	[30] = 'TOPMAR17',
	[31] = 'TOPMAR14',
	[32] = 'TOPMAR10',
	[33] = 'TMARDEF2'
}
	
local rigidTopmarks =
{
	[1] = 'TOPMAR22',
	[2] = 'TOPMAR24',
	[3] = 'TOPMAR30',
	[4] = 'TOPMAR32',
	[5] = 'TOPMAR33',
	[6] = 'TOPMAR34',
	[7] = 'TOPMAR85',
	[8] = 'TOPMAR86',
	[9] = 'TOPMAR36',
	[10] = 'TOPMAR28',
	[11] = 'TOPMAR27',
	[12] = 'TOPMAR14',
	[13] = 'TOPMAR25',
	[14] = 'TOPMAR26',
	[15] = 'TOPMAR88',
	[16] = 'TOPMAR87',
	[17] = 'TMARDEF1',
	[18] = 'TOPMAR30',
	[19] = 'TOPMAR33',
	[20] = 'TOPMAR34',
	[21] = 'TOPMAR33',
	[22] = 'TOPMAR34',
	[23] = 'TOPMAR34',
	[24] = 'TOPMAR22',
	[25] = 'TOPMAR24',
	[26] = 'TOPMAR30',
	[27] = 'TOPMAR86',
	[28] = 'TOPMAR89',
	[29] = 'TOPMAR22',
	[30] = 'TOPMAR86',
	[31] = 'TOPMAR14',
	[32] = 'TOPMAR30',
	[33] = 'TMARDEF1'
}


local floatingInlandTopmarks =
{
	[1] = 'TOPMA100',
	[2] = 'TOPMA101',
	[3] = 'TOPMA102',
	[4] = 'TOPMA103',
	[5] = 'TOPMA104',
	[6] = 'TOPMA105',
	[7] = 'TOPMA106',
	[8] = 'TOPMA107',
	[9] = 'TOPMA108',
	[10] = 'TOPMA109',
	[11] = 'TOPMA110',
	[12] = 'TOPMA111',
	[13] = 'TOPMA112',
	[14] = 'TOPMA113',
	[15] = 'TOPMA114',
	[16] = 'TOPMA115',
	[17] = 'TOPMA116',
	[18] = 'TOPMA117'
}
	

-- Main entry point for CSP.
function TOPMAR02(feature, featurePortrayal, contextParameters, viewingGroup, isFloating, isBeacon)
	Debug.StartPerformance('Lua Code - TOPMAR02')
		
	if feature.topmark then
		if isFloating then
			topmarkSymbol = floatingTopmarks[feature.topmark.topmarkDaymarkShape] or 'TMARDEF2'
			if isBeacon then
				if feature.topmark.topmarkDaymarkShape == 1 and feature.topmark.colour[1] == 4 then
					topmarkSymbol = 'TOPMA112'
				elseif feature.topmark.topmarkDaymarkShape == 1 and feature.topmark.colour[1] == 1 and feature.topmark.colour[2] == 4 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA103'
				elseif feature.topmark.topmarkDaymarkShape == 1 and feature.topmark.colour[1] == 4 and feature.topmark.colour[2] == 1 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA103'					

				elseif feature.topmark.topmarkDaymarkShape == 2 and feature.topmark.colour[1] == 3 then 
					topmarkSymbol = 'TOPMA100'
				elseif feature.topmark.topmarkDaymarkShape == 2 and feature.topmark.colour[1] == 1 and feature.topmark.colour[2] == 3 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA101'		
				elseif feature.topmark.topmarkDaymarkShape == 2 and feature.topmark.colour[1] == 3 and feature.topmark.colour[2] == 1 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA101'
					
				elseif feature.topmark.topmarkDaymarkShape == 6 and feature.topmark.colour[1] == 1 and feature.topmark.colour[2] == 3 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA107'		
				elseif feature.topmark.topmarkDaymarkShape == 6 and feature.topmark.colour[1] == 3 and feature.topmark.colour[2] == 1 and feature.topmark.colourPattern == 6 then 
					topmarkSymbol = 'TOPMA107'			
				elseif feature.topmark.topmarkDaymarkShape == 6 and feature.topmark.colour[1] == 1 and feature.topmark.colour[2] == 3 and feature.topmark.colour[3] == 1 and feature.topmark.colourPattern == 1 then 
					topmarkSymbol = 'TOPMA106'				
				elseif feature.topmark.topmarkDaymarkShape == 6 and feature.topmark.colour[1] == 6 and feature.topmark.colour[2] == 2 and feature.topmark.colour[3] == 6 and feature.topmark.colourPattern == 2 then 
					topmarkSymbol = 'TOPMA110'		
										
				if feature.topmark.topmarkDaymarkShape == 7 and feature.topmark.colour[1] == 6 then
					topmarkSymbol = 'TOPMA113'
					
				if feature.topmark.topmarkDaymarkShape == 8 and feature.topmark.colour[1] == 6 then
					topmarkSymbol = 'TOPMA111'
					
				if feature.topmark.topmarkDaymarkShape == 10 and feature.topmark.colour[1] == 3 and feature.topmark.colour[2] == 4 then
					topmarkSymbol = 'TOPMA104'
				if feature.topmark.topmarkDaymarkShape == 10 and feature.topmark.colour[1] == 4 and feature.topmark.colour[2] == 3 then
					topmarkSymbol = 'TOPMA104'
				if feature.topmark.topmarkDaymarkShape == 10 and feature.topmark.colour[1] == 3 and feature.topmark.colour[2] == 4 and feature.topmark.colourPattern == 6 then
					topmarkSymbol = 'TOPMA104'
					
				if feature.topmark.topmarkDaymarkShape == 12 and feature.topmark.colour[1] == 4 and feature.topmark.colour[2] == 1 and feature.topmark.colourPattern == 6 then
					topmarkSymbol = 'TOPMA109'
				if feature.topmark.topmarkDaymarkShape == 12 and feature.topmark.colour[1] == 1 and feature.topmark.colour[2] == 4 and feature.topmark.colourPattern == 6 then
					topmarkSymbol = 'TOPMA109'
				if feature.topmark.topmarkDaymarkShape == 12 and feature.topmark.colour[1] == 4 and feature.topmark.colour[2] == 1 and feature.topmark.colourPattern == 1 then
					topmarkSymbol = 'TOPMA108'
				if feature.topmark.topmarkDaymarkShape == 12 and feature.topmark.colour[1] == 6 and feature.topmark.colour[2] == 2 and feature.topmark.colour[2] == 6 and feature.topmark.colourPattern == 2 then
					topmarkSymbol = 'TOPMA112'
				end
			else
				if feature.topmark.topmarkDaymarkShape == 1 and feature.topmark.colour[1] == 4 then
					topmarkSymbol = 'TOPMA115'
				elseif feature.topmark.topmarkDaymarkShape == 5 and feature.topmark.colour[1] == 3 then 
					topmarkSymbol = 'TOPMA114'
				elseif feature.topmark.topmarkDaymarkShape == 5 and feature.topmark.colour[1] == 3 and feature.topmark.colour[2] == 1 and feature.topmark.colour[3] == 3 then 
					topmarkSymbol = 'TOPMA116'
				end
			end 
		end
				
		else
			topmarkSymbol = rigidTopmarks[feature.topmark.topmarkDaymarkShape] or 'TMARDEF1'
		end

		featurePortrayal:AddInstructions('PointInstruction:' .. topmarkSymbol)
	end

	Debug.StopPerformance('Lua Code - TOPMAR02')
end
