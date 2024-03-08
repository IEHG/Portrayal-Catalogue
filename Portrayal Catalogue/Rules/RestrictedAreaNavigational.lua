-- Converter Version: 0.99
-- Feature Catalogue Version: 1.0.0 (2019/4/9)

-- Referenced portrayal rules.
require 'RESARE04'

-- Restricted Area Navigational main entry point.
function RestrictedAreaNavigational(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Surface and contextParameters.PlainBoundaries then
		if contains(27, feature.categoryOfRestrictedArea) then
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:ESSARE01')
			featurePortrayal:AddInstructions('LineInstruction:ESSARE01')
		elseif contains(28, feature.categoryOfRestrictedArea) then
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:PSSARE01')
			featurePortrayal:AddInstructions('LineInstruction:ESSARE01')
		else
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			RESARE04(feature, featurePortrayal, contextParameters, viewingGroup)
		end
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		if contains(27, feature.categoryOfRestrictedArea) then
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:ESSARE01')
			featurePortrayal:AddInstructions('LineInstruction:ESSARE01')
		elseif contains(28, feature.categoryOfRestrictedArea) then
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:PSSARE01')
			featurePortrayal:AddInstructions('LineInstruction:ESSARE01')
		else
			viewingGroup = 26010
			featurePortrayal:AddInstructions('ViewingGroup:26010;DrawingPriority:15;DisplayPlane:UnderRADAR')
			RESARE04(feature, featurePortrayal, contextParameters, viewingGroup)
		end
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
