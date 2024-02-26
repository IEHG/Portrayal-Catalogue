-- LUA script
-- Notice Mark main entry point.


require 'NOTMRKI1'

function NoticeMark(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- Simplified and paper chart points use the same symbolization
	if feature.PrimitiveType == PrimitiveType.Point then
        ----------------------------------
        -- If the marking system is CEVNI:
        ----------------------------------        
        if (feature.marksNavigationalSystemOf == 11) then
            viewingGroup = 17030

            if feature.categoryOfNoticeMark == 1 then
                if contextParameters.RadarOverlay then
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:OverRADAR')
                else				
                    featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:8;DisplayPlane:UnderRADAR')
                end
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
            elseif feature.categoryOfNoticeMark == 2 then    
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH03')
            elseif feature.categoryOfNoticeMark == 3 then     
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH04')
            elseif feature.categoryOfNoticeMark == 4 then     
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH05')
            elseif feature.categoryOfNoticeMark == 5 then    
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH06') 
            elseif feature.categoryOfNoticeMark == 6 then   
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH07')  
            elseif feature.categoryOfNoticeMark == 7 then   
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH08')  
            elseif feature.categoryOfNoticeMark == 8 then   
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH09')  
            elseif feature.categoryOfNoticeMark == 9 then    
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH10') 
            elseif feature.categoryOfNoticeMark == 10 then  
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH11')   
            elseif feature.categoryOfNoticeMark == 11 then  
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH12') 
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
         ----------------------------------
        -- If the marking system is Brazilian national inland waterway regulations:
        ---------------------------------------------------------------------------     
        elseif (feature.marksNavigationalSystemOf == 13) then
            if feature.categoryOfNoticeMark == 1 then
            elseif feature.categoryOfNoticeMark == 2 then
            elseif feature.categoryOfNoticeMark == 3 then
            elseif feature.categoryOfNoticeMark == 4 then
            elseif feature.categoryOfNoticeMark == 5 then
            elseif feature.categoryOfNoticeMark == 6 then
            elseif feature.categoryOfNoticeMark == 7 then
            elseif feature.categoryOfNoticeMark == 8 then
            end
        end 
        
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
