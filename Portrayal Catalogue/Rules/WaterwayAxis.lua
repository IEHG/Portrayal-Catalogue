-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Waterway axis main entry point.
function WaterwayAxis(feature, featurePortrayal, contextParameters)
	local viewingGroup
    
    if feature.PrimitiveType == PrimitiveType.Curve then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 13040
		featurePortrayal:AddInstructions('ViewingGroup:13040;DrawingPriority:9;DisplayPlane:UnderRadar')
		featurePortrayal:SimpleLineStyle('dot',0.30,'CHGRD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
