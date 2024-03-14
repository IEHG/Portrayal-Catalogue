-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Referenced portrayal rules.
require 'RESTRN01'

-- Anchor IncinerationArea main entry point.
function IncinerationArea(feature, featurePortrayal, contextParameters)
	local viewingGroup
    	if feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 26250
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:26250;DrawingPriority:9;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:26250;DrawingPriority:9;DisplayPlane:UnderRADAR')
		end
	        featurePortrayal:AddInstructions('PointInstruction:INFRA51')
	        featurePortrayal:SimpleLineStyle('dash',0.30,'TRFCD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
		RESTRN01(feature, featurePortrayal, contextParameters, viewingGroup)
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
