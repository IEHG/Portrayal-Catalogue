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
		viewingGroup = 22410
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:15;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:15;DisplayPlane:UnderRADAR')
		end
	        if feature.categoryOfBunkerStation == 1 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA01')
	        elseif feature.categoryOfBunkerStation == 2 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA02')
	        elseif feature.categoryOfBunkerStation == 3 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA03')
	        elseif
			    featurePortrayal:AddInstructions('PointInstruction:CHINF007')
	        end
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 22410
		featurePortrayal:AddInstructions('ViewingGroup:22410;DrawingPriority:15;DisplayPlane:UnderRADAR')
	        if feature.categoryOfBunkerStation == 1 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA01')
	        elseif feature.categoryOfBunkerStation == 2 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA02')
	        elseif feature.categoryOfBunkerStation == 3 then
			    featurePortrayal:AddInstructions('PointInstruction:BUNSTA03')
	        elseif
			    featurePortrayal:AddInstructions('PointInstruction:CHINF007')
	        end
		featurePortrayal:SimpleLineStyle('solid',0.32,'CHGRD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
