-- Converter Version: 0.99
-- Feature Catalogue Version: 1.1.0 (2024/03/13)
--
-- issues to solve: none
--

-- Truning basin main entry point.
function TurningBasin(feature, featurePortrayal, contextParameters)
	local viewingGroup

	if feature.PrimitiveType == PrimitiveType.Point then
		-- Paper chart and symbolized points use the same symbolization
		viewingGroup = 26020
		featurePortrayal:AddInstructions('ViewingGroup:26020;DrawingPriority:18;DisplayPlane:OverRADAR')
        featurePortrayal:AddInstructions('PointInstruction:TRNBSN01')
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 26020
		featurePortrayal:AddInstructions('ViewingGroup:26020;DrawingPriority:9;DisplayPlane:OverRADAR')
        featurePortrayal:AddInstructions('PointInstruction:TRNBSN01')
		featurePortrayal:SimpleLineStyle('dash',0.60,'CHMGD')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
