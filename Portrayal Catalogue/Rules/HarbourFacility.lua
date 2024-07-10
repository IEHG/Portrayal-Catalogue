-- Converter Version: 0.99
-- Feature Catalogue Version: 1.0.0 (2019/4/9)
-- #155

-- Harbour facility main entry point.
function HarbourFacility(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point and contextParameters.SimplifiedSymbols then
		if contains(1, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:ROLROL01')
		elseif contains(4, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC09')
		elseif contains(5, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:SMCFAC02')            
		elseif contains(6, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC11')        
		elseif contains(9, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC12')        
		elseif contains(14, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:3222410410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC15')        
		elseif contains(15, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC16')        
		elseif contains(16, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC17')        
		elseif contains(17, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC18')
		else
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:CHINFO07')
		end
	elseif feature.PrimitiveType == PrimitiveType.Point then
		if contains(1, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:ROLROL01')
		elseif contains(4, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC09')
		elseif contains(5, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:SMCFAC02')       
		elseif contains(6, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC11')        
		elseif contains(9, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC12')        
		elseif contains(14, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC15')        
		elseif contains(15, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC16')        
		elseif contains(16, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC17')        
		elseif contains(17, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:21;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC18')
		else
			viewingGroup = 32410
			if contextParameters.RadarOverlay then
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:OverRADAR')
			else
				featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			end
			featurePortrayal:AddInstructions('PointInstruction:CHINFO07')
		end
	elseif feature.PrimitiveType == PrimitiveType.Surface and contextParameters.PlainBoundaries then
		if contains(1, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:ROLROL01')
		elseif contains(4, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC09')
		elseif contains(5, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:SMCFAC02')
		elseif contains(6, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC11')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(9, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC12')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(12, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC13')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(13, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC14')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(16, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC17')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(17, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC18')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		else
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:CHINFO07')
		end
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		if contains(1, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:ROLROL01')
		elseif contains(4, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC09')
		elseif contains(5, feature.categoryOfHarbourFacility) then
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:SMCFAC02')
		elseif contains(6, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC11')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(9, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC12')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(12, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC13')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(13, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC14')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(16, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC17')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		elseif contains(17, feature.categoryOfHarbourFacility) then
			viewingGroup = 22410
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:12;DisplayPlane:OverRADAR')
			featurePortrayal:AddInstructions('PointInstruction:HRBFAC18')
            featurePortrayal:AddInstructions('ColorFill:CHBRN,0.75')
		else
			viewingGroup = 32410
			featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
			featurePortrayal:AddInstructions('PointInstruction:CHINFO07')
		end
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
