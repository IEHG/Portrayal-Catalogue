require 'S101AttributeSupport'

-- from S-57 BRIDGE, CATBRG=1 (fixed bridge)
function SpanFixed(feature, featurePortrayal, contextParameters)
	featurePortrayal:AddInstructions('AlertReference:NavHazard')

	if feature.PrimitiveType == PrimitiveType.Curve then
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:UnderRADAR')
		end
		featurePortrayal:SimpleLineStyle('solid',1.6,'CHGRD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')

	elseif feature.PrimitiveType == PrimitiveType.Surface then
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:12210;DrawingPriority:24;DisplayPlane:UnderRADAR')
		end
		featurePortrayal:SimpleLineStyle('solid',1.28,'CHGRD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')

	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end
	
	if HasHorizontalClearance(feature) then
		local yOffset = 0
		featurePortrayal:AddInstructions('TextAlignHorizontal:Center')
		if feature.PrimitiveType == PrimitiveType.Curve then
			featurePortrayal:AddInstructions('TextAlignVertical:Center')
			yOffset = -3.51
		end
		PortrayClearances(feature, featurePortrayal, contextParameters, 12210, 0, yOffset)
	end

	return 12210
end
