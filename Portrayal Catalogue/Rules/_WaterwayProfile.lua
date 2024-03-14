-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Waterway axis main entry point.
function WaterwayAxisfeature, featurePortrayal, contextParameters)
	local viewingGroup
    
    if feature.PrimitiveType == PrimitiveType.Curve then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 31050
		featurePortrayal:AddInstructions('ViewingGroup:31050;DrawingPriority:9;DisplayPlane:UnderRADAR')
		featurePortrayal:SimpleLineStyle('dotted',0.30,'CHGRD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
