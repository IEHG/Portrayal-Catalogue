-- PhysicalAISAidToNavigation portrayal rules file.

-- Issues [PSWG #70] #97

-- Main entry point for feature type.
function PhysicalAISAidToNavigation(feature, featurePortrayal, contextParameters)

	local viewingGroup = 27240

	if feature.marksNavigationalSystemOf ~= 11 then
		if feature.PrimitiveType == PrimitiveType.Point then
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('AlertReference:NavHazard;ViewingGroup:' .. viewingGroup .. ';DrawingPriority:24;Hover:true;PointInstruction:AISPHY05')
		else
			error('Invalid primitive type or mariner settings passed to portrayal')
		end
	end 

	return viewingGroup
end
