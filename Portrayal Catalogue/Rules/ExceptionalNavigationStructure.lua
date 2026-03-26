-- Anchor ExceptionalNavigationStructure main entry point.
function ExceptionalNavigationStructure(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point then
		-- Simplified and paper chart points use the same symbolization
		viewingGroup = 12210
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:13030;DrawingPriority:24;DisplayPlane:OverRadar')
		else
			featurePortrayal:AddInstructions('ViewingGroup:13030;DrawingPriority:24;DisplayPlane:UnderRadar')
		end
		featurePortrayal:AddInstructions('PointInstruction:BRIDGE01')
    elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 12210
		featurePortrayal:AddInstructions('ViewingGroup:13030;DrawingPriority:24;DisplayPlane:UnderRadar')
        featurePortrayal:SimpleLineStyle('solid',0.64,'CSTLN')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
