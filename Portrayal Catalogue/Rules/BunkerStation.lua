-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Anchor bunker station main entry point.
function BunkerStation(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point then
		-- Simplified and paper chart points use the same symbolization
		viewingGroup = 32270
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:32270;DrawingPriority:15;DisplayPlane:OverRadar')
		else
			featurePortrayal:AddInstructions('ViewingGroup:32270;DrawingPriority:15;DisplayPlane:UnderRadar')
		end
	        
		if contains(1, feature.categoryOfBunkerStation) then
			featurePortrayal:AddInstructions('PointInstruction:BUNSTA01')
	    elseif contains(2, feature.categoryOfBunkerStation) then
		    featurePortrayal:AddInstructions('PointInstruction:BUNSTA02')
        elseif contains(3, feature.categoryOfBunkerStation) then
			featurePortrayal:AddInstructions('PointInstruction:BUNSTA03')
	    elseif contains(4, feature.categoryOfBunkerStation) then
		    featurePortrayal:AddInstructions('PointInstruction:BUNSTA04')
	    else
		    featurePortrayal:AddInstructions('PointInstruction:CHINF007')
        end
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
