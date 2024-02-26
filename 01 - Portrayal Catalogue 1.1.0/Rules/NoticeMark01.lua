-- LUA script
-- Notice Mark main entry point.


require 'NOTMRKI1'

function NoticeMark(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- Simplified and paper chart points use the same symbolization
	if feature.PrimitiveType == PrimitiveType.Point then
       
            viewingGroup = 17030

            if feature.categoryOfNoticeMark == 1 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
            elseif feature.categoryOfNoticeMark == 12 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')
            elseif feature.categoryOfNoticeMark == 13 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 44 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 45 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 46 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 47 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 50 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKINF01')
                featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            else
                --  Add function conditional symbology --
                -----------------------------------------
                NOTMRKI1(feature, featurePortrayal, contextParameters)
            end
        
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
