-- LUA script
-- Notice Mark main entry point.


-- require 'NOTMRKI1'

function NoticeMark(feature, featurePortrayal, contextParameters)
	local viewingGroup

	-- Simplified and paper chart points use the same symbolization
	if feature.PrimitiveType == PrimitiveType.Point then
        viewingGroup = 17030
        if contextParameters.RadarOverlay then
            featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:32;DisplayPlane:OverRADAR')
        else				
            featurePortrayal:AddInstructions('ViewingGroup:17030;DrawingPriority:32;DisplayPlane:UnderRADAR')
        end

        ----------------------------------------
        -- If the marking system is IALA B (US):
        ----------------------------------------       
        if (feature.marksNavigationalSystemOf == 2) then   
            if feature.categoryOfNoticeMark == 1 then                
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')          
            elseif feature.categoryOfNoticeMark == 6 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH07')  
            elseif feature.categoryOfNoticeMark == 8 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH08')              
            elseif feature.categoryOfNoticeMark == 114 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRE101')  
            else
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')  
            end
            
        -------------------------------------------
        -- If the marking system is European CEVNI:
        -------------------------------------------        
        elseif (feature.marksNavigationalSystemOf == 11) then           

            if feature.categoryOfNoticeMark == 1 then                
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
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
            --              
            elseif feature.categoryOfNoticeMark == 7 then
                -- =======================================================================================
                -- Check if this coding is correct: distance has to be displayed in the middle of the mark
                -- =======================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK01')   
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Center;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)         

            elseif feature.categoryOfNoticeMark == 8 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH08')            
            elseif feature.categoryOfNoticeMark == 9 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH09')            
            elseif feature.categoryOfNoticeMark == 10 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH10')           
            elseif feature.categoryOfNoticeMark == 11 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH11')          
            elseif feature.categoryOfNoticeMark == 12 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')          
            elseif feature.categoryOfNoticeMark == 13 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')          
            elseif feature.categoryOfNoticeMark == 14 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH14')          
            elseif feature.categoryOfNoticeMark == 15 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH15')          
            elseif feature.categoryOfNoticeMark == 16 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH16')         
            elseif feature.categoryOfNoticeMark == 17 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH17')         
            elseif feature.categoryOfNoticeMark == 18 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH18')         
            elseif feature.categoryOfNoticeMark == 19 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH19')         
            elseif feature.categoryOfNoticeMark == 20 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH20')         
            elseif feature.categoryOfNoticeMark == 21 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH21')       
            elseif feature.categoryOfNoticeMark == 22 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH22')       
                
            -- =================
            -- Check PresLib !!!
            -- =================
            elseif feature.categoryOfNoticeMark == 23 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG21')   
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
            elseif feature.categoryOfNoticeMark == 24 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG22')   
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')

            elseif feature.categoryOfNoticeMark == 25 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG04')       
            elseif feature.categoryOfNoticeMark == 26 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG05')       
            elseif feature.categoryOfNoticeMark == 27 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG06')      
            elseif feature.categoryOfNoticeMark == 28 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG07')      
            elseif feature.categoryOfNoticeMark == 29 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG08')      
            elseif feature.categoryOfNoticeMark == 30 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG09')      
            elseif feature.categoryOfNoticeMark == 31 then
                if (feature.orientationValue) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG23')  
                    featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
                else
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG10')      
                end 
            elseif feature.categoryOfNoticeMark == 32 then
                -- =======================================================================================
                -- Check if this coding is correct: distance has to be displayed in the middle of the mark
                -- =======================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NMKREG01') 
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Center;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)  

            elseif feature.categoryOfNoticeMark == 33 then
                if (feature.orientationValue) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG24')  
                    featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
                else
                    featurePortrayal:AddInstructions('PointInstruction:NMKREG11')      
                end    
            elseif feature.categoryOfNoticeMark == 34 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG12')     
            elseif feature.categoryOfNoticeMark == 35 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG13')     
            elseif feature.categoryOfNoticeMark == 36 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG14')     
            elseif feature.categoryOfNoticeMark == 37 then
                -- ===============================================================================================
                -- Check if this coding is correct: distance has to be displayed in the middle, bottom of the mark
                -- ===============================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NMKREG15') 
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Bottom;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)    
            elseif feature.categoryOfNoticeMark == 38 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG16')     
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Top;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)   
            elseif feature.categoryOfNoticeMark == 39 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG17')   
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Bottom;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)    
            elseif feature.categoryOfNoticeMark == 40 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG18')  
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Center;FontSize:10;FontColor:CHBLK')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)     
  
            elseif feature.categoryOfNoticeMark == 41 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG01')  
                -- ===============================================================================================
                -- Information should be displayed below the sign!
                -- ===============================================================================================    
            elseif feature.categoryOfNoticeMark == 42 then
                -- ===============================================================================================
                -- Check if this coding is correct: distance has to be displayed in the left, center of the mark
                -- ===============================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NMKREG19')  
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Left;TextAlignVertical:Center;FontSize:10;FontColor:WHITE')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)     
            elseif feature.categoryOfNoticeMark == 43 then
                -- ===============================================================================================
                -- Check if this coding is correct: distance has to be displayed in the right, center of the mark
                -- ===============================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NMKREG20')  
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Right;TextAlignVertical:Center;FontSize:10;FontColor:WHITE')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)     
                  
            elseif feature.categoryOfNoticeMark == 44 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
            elseif feature.categoryOfNoticeMark == 45 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')    
            elseif feature.categoryOfNoticeMark == 46 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')    
            elseif feature.categoryOfNoticeMark == 47 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')      
            elseif feature.categoryOfNoticeMark == 48 then                
                if (feature.orientationValue) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD07')  
                    featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
                else
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD05')      
                end    
            elseif feature.categoryOfNoticeMark == 49 then             
                if (feature.orientationValue) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD08')  
                    featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
                else
                    featurePortrayal:AddInstructions('PointInstruction:NMKRCD06')      
                end           
            elseif feature.categoryOfNoticeMark == 50 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF01')  
            elseif feature.categoryOfNoticeMark == 51 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF02')    
            elseif feature.categoryOfNoticeMark == 52 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF03') 
            elseif feature.categoryOfNoticeMark == 53 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF04') 
            elseif feature.categoryOfNoticeMark == 54 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF05') 
            elseif feature.categoryOfNoticeMark == 55 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF06') 

            -- ===============================================================================================
            -- No symbol forseen on which this can be displayed.
            -- ===============================================================================================   
            elseif feature.categoryOfNoticeMark == 56 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF05') 
            elseif feature.categoryOfNoticeMark == 57 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF05') 
            -- ===============================================================================================
            -- How to determine which symbol to display?
            -- ===============================================================================================        
            elseif feature.categoryOfNoticeMark == 58 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF51') -- 51, 52, 53, 54 or 54

                 

            elseif feature.categoryOfNoticeMark == 59 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF07')
            elseif feature.categoryOfNoticeMark == 60 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF08') 
            elseif feature.categoryOfNoticeMark == 61 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF09')
            elseif feature.categoryOfNoticeMark == 62 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF10')
            elseif feature.categoryOfNoticeMark == 63 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF11')
            elseif feature.categoryOfNoticeMark == 64 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF12')
            elseif feature.categoryOfNoticeMark == 65 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF13')
            elseif feature.categoryOfNoticeMark == 66 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF14')
            elseif feature.categoryOfNoticeMark == 67 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF15')
            elseif feature.categoryOfNoticeMark == 68 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF16')
            elseif feature.categoryOfNoticeMark == 69 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF17')
            elseif feature.categoryOfNoticeMark == 70 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF18')
            elseif feature.categoryOfNoticeMark == 71 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF19')
            elseif feature.categoryOfNoticeMark == 72 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF20')
            elseif feature.categoryOfNoticeMark == 73 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF21')
            elseif feature.categoryOfNoticeMark == 74 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF22')
            elseif feature.categoryOfNoticeMark == 75 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF23')
            elseif feature.categoryOfNoticeMark == 76 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF24')
            elseif feature.categoryOfNoticeMark == 77 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF25')
            elseif feature.categoryOfNoticeMark == 78 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF26')
            elseif feature.categoryOfNoticeMark == 79 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF27')
            elseif feature.categoryOfNoticeMark == 80 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF28')
            elseif feature.categoryOfNoticeMark == 81 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF29')
            elseif feature.categoryOfNoticeMark == 82 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF30')
            elseif feature.categoryOfNoticeMark == 83 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF31')
            elseif feature.categoryOfNoticeMark == 84 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF32')
            elseif feature.categoryOfNoticeMark == 85 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF33')
            elseif feature.categoryOfNoticeMark == 86 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF34')
            elseif feature.categoryOfNoticeMark == 87 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF35')
            elseif feature.categoryOfNoticeMark == 88 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF36')
            elseif feature.categoryOfNoticeMark == 89 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF37')
            elseif feature.categoryOfNoticeMark == 90 then           
                if (feature.orientationValue) then
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF60')  
                    featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')    
                else
                    featurePortrayal:AddInstructions('PointInstruction:NMKINF38')      
                end           
            elseif feature.categoryOfNoticeMark == 91 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF39')
            elseif feature.categoryOfNoticeMark == 92 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF40')
            elseif feature.categoryOfNoticeMark == 93 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF41')
            elseif feature.categoryOfNoticeMark == 94 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF42')
            elseif feature.categoryOfNoticeMark == 95 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF43')
            elseif feature.categoryOfNoticeMark == 96 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF44')
            elseif feature.categoryOfNoticeMark == 97 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF45')
            elseif feature.categoryOfNoticeMark == 98 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF46')
            elseif feature.categoryOfNoticeMark == 99 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF47A')
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Bottom;FontSize:10;FontColor:WHITE')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15)     
            elseif feature.categoryOfNoticeMark == 100 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF48')
            elseif feature.categoryOfNoticeMark == 101 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF49')    
            elseif feature.categoryOfNoticeMark == 102 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF50')
            elseif feature.categoryOfNoticeMark == 110 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG50')
            elseif feature.categoryOfNoticeMark == 111 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG51')
            elseif feature.categoryOfNoticeMark == 117 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF56')
            elseif feature.categoryOfNoticeMark == 118 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF57')
            elseif feature.categoryOfNoticeMark == 119 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF57')
                -- ===============================================================================================
                -- How to determine which symbol to display? How to put font into Roman I, II, III, IV, V?
                -- ===============================================================================================     
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Center;FontSize:10;FontColor:AZUBL')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15) 
            elseif feature.categoryOfNoticeMark == 120 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF58')
            elseif feature.categoryOfNoticeMark == 121 then
                -- ===============================================================================================
                -- How to determine which symbol to display? How to put font into Roman I, II, III, IV, V?
                -- ===============================================================================================
                featurePortrayal:AddInstructions('PointInstruction:NMKINF58')
            elseif feature.categoryOfNoticeMark == 122 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF59')
            elseif feature.categoryOfNoticeMark == 123 then
                featurePortrayal:AddInstructions('PointInstruction:NMKREG25')


                

            elseif feature.categoryOfNoticeMark == 12 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH12')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 13 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH13')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 44 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 45 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 46 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD03')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 47 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD04')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            elseif feature.categoryOfNoticeMark == 50 then
                featurePortrayal:AddInstructions('PointInstruction:NMKINF01')
                if (feature.orientationValue) featurePortrayal:AddInstructions('Rotation:GeographicCRS,' .. tostring(feature.orientationValue) .. '')
            else
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
            end
        -------------------------------------------
        -- If the marking system is Russian:
        -------------------------------------------        
        elseif (feature.marksNavigationalSystemOf == 12) then            
            if feature.categoryOfNoticeMark == 5 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPR103')                
            elseif feature.categoryOfNoticeMark == 8 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPR101')               
            elseif feature.categoryOfNoticeMark == 11 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPR104')               
            elseif feature.categoryOfNoticeMark == 39 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRE103')   
                featurePortrayal:AddInstructions('LocalOffset:0,0;TextAlignHorizontal:Center;TextAlignVertical:Bottom;FontSize:10;FontColor:AZUBL')
                featurePortrayal:AddTextInstruction(EncodeString(GetFeatureName(feature, contextParameters), '%s'), 29, 24, 32440, 15) 
            elseif feature.categoryOfNoticeMark == 74 then
                featurePortrayal:AddInstructions('PointInstruction:NMKIN101')
            elseif feature.categoryOfNoticeMark == 112 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPR102')
            elseif feature.categoryOfNoticeMark == 113 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPR105')
            elseif feature.categoryOfNoticeMark == 114 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRE101')
            elseif feature.categoryOfNoticeMark == 115 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRE102')
            elseif feature.categoryOfNoticeMark == 116 then
                featurePortrayal:AddInstructions('PointInstruction:NMKIN102')
            else
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
            end
        -------------------------------------------
        -- If the marking system is Brazilian:
        -------------------------------------------        
        elseif (feature.marksNavigationalSystemOf == 13) then
            if feature.categoryOfNoticeMark == 1 then
                featurePortrayal:AddInstructions('PointInstruction:NMKPRH02')  
            elseif feature.categoryOfNoticeMark == 8 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC008R')  
                elseif (feature.bankOfTheWaterway == 2)
                featurePortrayal:AddInstructions('PointInstruction:NMKAC008G')            
                end
            elseif feature.categoryOfNoticeMark == 39 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC039R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC039G')            
                end 
            elseif feature.categoryOfNoticeMark == 44 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
            elseif feature.categoryOfNoticeMark == 45 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')    
            elseif feature.categoryOfNoticeMark == 82 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE082L')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE082R')            
                end 
            elseif feature.categoryOfNoticeMark == 83 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE083L')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE083R')            
                end 
            elseif feature.categoryOfNoticeMark == 103 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC103R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC103G')            
                end  
            elseif feature.categoryOfNoticeMark == 104 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC104R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC104G')            
                end  
            elseif feature.categoryOfNoticeMark == 105 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC105R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC105G')            
                end  
            elseif feature.categoryOfNoticeMark == 106 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC106R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC106G')            
                end  
            elseif feature.categoryOfNoticeMark == 107 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC107R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC107G')            
                end  
            elseif feature.categoryOfNoticeMark == 108 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC108R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC108G')            
                end  
            elseif feature.categoryOfNoticeMark == 109 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC109R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAC109G')            
                end  
            elseif feature.categoryOfNoticeMark == 44 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD01')  
            elseif feature.categoryOfNoticeMark == 45 then
                featurePortrayal:AddInstructions('PointInstruction:NMKRCD02')                 
            elseif feature.categoryOfNoticeMark == 124 then
                featurePortrayal:AddInstructions('PointInstruction:NMKAD124')                                    
            elseif feature.categoryOfNoticeMark == 125 then
                featurePortrayal:AddInstructions('PointInstruction:NMKAD125')                                       
            elseif feature.categoryOfNoticeMark == 126 then
                featurePortrayal:AddInstructions('PointInstruction:NMKAD126')                                
            elseif feature.categoryOfNoticeMark == 127 then
                featurePortrayal:AddInstructions('PointInstruction:NMKAD127')        
            else
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
            end
        -----------------------------------------------
        -- If the marking system is Brazilian Paraguay:
        -----------------------------------------------        
        elseif (feature.marksNavigationalSystemOf == 15) then

            if feature.categoryOfNoticeMark == 103 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE103R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE103G')            
                end  
            elseif feature.categoryOfNoticeMark == 104 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE104R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE104G')            
                end  
            elseif feature.categoryOfNoticeMark == 105 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE105R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE105G')            
                end  
            elseif feature.categoryOfNoticeMark == 106 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE106R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE106G')            
                end  
            elseif feature.categoryOfNoticeMark == 107 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE107R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE107G')            
                end  
            elseif feature.categoryOfNoticeMark == 108 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE108R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE108G')            
                end  
            elseif feature.categoryOfNoticeMark == 109 then
                if (feature.bankOfTheWaterway == 1)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE109R')  
                elseif (feature.bankOfTheWaterway == 2)
                    featurePortrayal:AddInstructions('PointInstruction:NMKAE109G')            
                end  
            else
                featurePortrayal:AddInstructions('PointInstruction:NOTMRK02')
            end
        end 
        
	else
		error('Invalid primitive type or mariner settings passed to portrayal')
	end

	return viewingGroup
end
