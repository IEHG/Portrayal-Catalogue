
-- Signal Station Traffic main entry point.
function SignalStationTraffic(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- NOTE: rearranged and not autogenerated for #48 
	viewingGroup = 28020
	if contextParameters.RadarOverlay then
		featurePortrayal:AddInstructions('ViewingGroup:28020;DrawingPriority:21;DisplayPlane:OverRADAR')
	else
		featurePortrayal:AddInstructions('ViewingGroup:28020;DrawingPriority:21;DisplayPlane:UnderRADAR')
	end


	if feature.PrimitiveType == PrimitiveType.Point then
		-- Simplified and paper chart points use the same symbolization
		if feature.categoryOfSignalStationTraffic == 2 then
			featurePortrayal:AddInstructions('PointInstruction:SSENTR01') 
		elseif feature.categoryOfSignalStationTraffic == 62 then
			featurePortrayal:AddInstructions('PointInstruction:SSLOCK01') 
		elseif feature.categoryOfSignalStationTraffic == 10 then
			featurePortrayal:AddInstructions('PointInstruction:SSWARS01') 
	   	else
			featurePortrayal:AddInstructions('PointInstruction:SISTAT03') 
	   	end
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- PSWG #48
		viewingGroup = 28020
		featurePortrayal:AddInstructions('ViewingGroup:28020;DrawingPriority:21;PointInstruction:SISTAT03')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
