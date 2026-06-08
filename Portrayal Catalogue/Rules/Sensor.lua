-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: categoryOfSensor
--

-- Sensor main entry point.
function Sensor(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point then
		-- Paper chart and symbolized points use the same symbolization
		viewingGroup = 27210
        featurePortrayal:AddInstructions('ViewingGroup:27210;DrawingPriority:21;DisplayPlane:OverRADAR')   
        if contains(3, feature.categoryOfSensor) then
            featurePortrayal:AddInstructions('PointInstruction:SENSOR03')
        end 
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
