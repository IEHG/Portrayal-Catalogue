-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Vehicle transfer main entry point.
function VehicleTransfer(feature, featurePortrayal, contextParameters)
	local viewingGroup
    
    if feature.PrimitiveType == PrimitiveType.Point then
		-- Paper chart and symbolized points use the same symbolization
		viewingGroup = 22410
		featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
		featurePortrayal:AddInstructions('PointInstruction:VEHTRF01')
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 22410
		featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:18;DisplayPlane:OverRADAR')
		featurePortrayal:AddInstructions('PointInstruction:VEHTRF01')
		featurePortrayal:SimpleLineStyle('dash',0.30,'CHGRF')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
