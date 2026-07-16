
function MARSYS01(feature, featurePortrayal, contextParameters, viewingGroup)
		
	Debug.StartPerformance('Lua Code - MARSYS01')
	
	local marksNavigationalSystemOf = feature.marksNavigationalSystemOf --or 11
	--                                                                  ^^ uncomment for testing if m_nsys doesn't cover and marksNavigationalSystemOf is missing

	Debug.Break()

	if marksNavigationalSystemOf == nil then
		-- Look for an enclosing NavigationalSystemofMarks feature
		for _, nsysFeature in ipairs(portrayalContext:GetFeatures('NavigationalSystemOfMarks')) do
			--Debug.Break()
			-- if nsysFeature COVERS feature
			if HostSpatialRelate(nsysFeature.Spatial.SpatialID, feature.Spatial.SpatialID, 'T*****FF*') then
				--Debug.Break()
				marksNavigationalSystemOf = nsysFeature.marksNavigationalSystemOf
				break
			end
		end
	end

	if marksNavigationalSystemOf == nil then
		error('marksNavigationalSystemOf must be specified if no enclosing NavigationalSystemOfMarks')
	end 

	return marksNavigationalSystemOf
end
