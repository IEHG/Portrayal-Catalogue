
-- Buoy Line Overhead main entry point.
function BuoyLine(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- featurePortrayal:AddInstructions('AlertReference:NavHazard')

	if feature.PrimitiveType == PrimitiveType.Curve then
		
		viewingGroup = 12210
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:OverRadar')
		else
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:UnderRadar')
		end

		if (feature.restriction == 7) then
        	featurePortrayal:AddInstructions('LineInstruction:NONAV01')
		end 
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end