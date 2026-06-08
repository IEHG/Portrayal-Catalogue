
-- Checkpoint main entry point.
function Checkpoint(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point then
		-- Simplified and paper chart points use the same symbolization
		viewingGroup = 32410
		featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
		featurePortrayal:AddInstructions('PointInstruction:CHKPNT01')
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 32410
        
		featurePortrayal:SimpleLineStyle('dash',0.31,'TRFCF')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')

        if feature.categoryOfCheckpoint == 1 then
            featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:21;DisplayPlane:OverRADAR')
            featurePortrayal:AddInstructions('PointInstruction:CUSTOM01')
        elseif feature.categoryOfCheckpoint == 2 then
            featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:21;DisplayPlane:OverRADAR')
            featurePortrayal:AddInstructions('PointInstruction:BORDER01')
        else
            featurePortrayal:AddInstructions('ViewingGroup:32410;DrawingPriority:12;DisplayPlane:UnderRADAR')
            featurePortrayal:AddInstructions('PointInstruction:POSGEN04')
        end
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end