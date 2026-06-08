-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: 
--

-- Waterway area main entry point.
function WaterwayArea(feature, featurePortrayal, contextParameters)
	local viewingGroup=13040

	featurePortrayal:AddInstructions('ViewingGroup:13040;DrawingPriority:12;DisplayPlane:UnderRADAR')
	if feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		featurePortrayal:AddInstructions('NullInstruction')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
