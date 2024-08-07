-- #194

-- Pontoon main entry point.
function Pontoon(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- featurePortrayal:AddInstructions('AlertReference:SafetyContour')
	
	if feature.PrimitiveType == PrimitiveType.Curve then
		viewingGroup = 12410
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('ViewingGroup:12410;DrawingPriority:15;DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('ViewingGroup:12410;DrawingPriority:15;DisplayPlane:UnderRADAR')
		end
		featurePortrayal:SimpleLineStyle('solid',0.64,'CSTLN')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	elseif feature.PrimitiveType == PrimitiveType.Surface then
		-- Plain and symbolized boundaries use the same symbolization
		viewingGroup = 12410
		featurePortrayal:AddInstructions('ViewingGroup:12410;DrawingPriority:6;DisplayPlane:UnderRADAR')
		featurePortrayal:AddInstructions('ColorFill:CHBRN')
		featurePortrayal:SimpleLineStyle('solid',0.64,'CSTLN')
		featurePortrayal:AddInstructions('LineInstruction:_simple_')
	elseif feature.PrimitiveType == PrimitiveType.Point then
		--TODO: Determine S-101 portrayal for Pontoon point feature.
		viewingGroup = 21010
		if contextParameters.RadarOverlay then
			featurePortrayal:AddInstructions('DisplayPlane:OverRADAR')
		else
			featurePortrayal:AddInstructions('DisplayPlane:UnderRADAR')
		end
		featurePortrayal:AddInstructions('ViewingGroup:21010;DrawingPriority:15;PointInstruction:testPCB')
		Debug.Trace('Warning: S-52 does not define portrayal for Pontoon point features.')
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
