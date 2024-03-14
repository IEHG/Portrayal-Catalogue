-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Lock basin part main entry point.
function LockBasinPart(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 12420
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:12420;DrawingPriority:8;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:21060;DrawingPriority:12;DisplayPlane:UnderRADAR')
		end
		featurePortrayal:SimpleLineStyle('dash',0.60,'CHGRF')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
