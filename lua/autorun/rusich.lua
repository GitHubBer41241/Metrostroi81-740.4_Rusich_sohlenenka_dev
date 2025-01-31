vedro740 = vedro740 or {} --check 81-740 addon availability by other addons
--beb = beb or {} --uncomment to disable als autofreq

if Metrostroi.Version >= 1623941696 then

	if SERVER then		
		timer.Simple(1,function()
		
		local models = {
		["models/metrostroi_train/81-740/body/81-740_4_front.mdl"] = true,
		["models/metrostroi_train/81-740/body/81-740_4_rear.mdl"] = true,

		["models/metrostroi_train/81-740/bogey/metro_bogey_740"] = true,	
		["models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl"] = true,
		["models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl"] = true,
		
	}		
			-- регистрируем тележки
			local tbl = scripted_ents.Get("gmod_train_bogey")
			if tbl then	
				tbl.Types["740PER"] = { -- тележка
					"models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl",
					Vector(0,0.0,-10.5),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740G"] = { -- тележка + гармошка
					"models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl",
					Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740NOTR"] = { -- немоторная тележка
					"models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl",
					Vector(0,0.0,-10.1),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				scripted_ents.Register(tbl,"gmod_train_bogey") -- регистрируем
			end
			
			-- регистрируем сцепку
			local tbl = scripted_ents.Get("gmod_train_couple")
			if tbl then
				tbl.Types["740"] = { -- сцепка
					"models/metrostroi_train/81-740/bogey/metro_couple_740.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				scripted_ents.Register(tbl,"gmod_train_couple")	-- регистрируем
			end
		end)	
	end
    
    local ClBogeyConf = {
        {"ted1_740" ,08,00,16,  0.25},
        {"ted2_740" ,16,08-4,24,0.25},
        {"ted3_740" ,24,16-4,32,0.25},
        {"ted4_740" ,32,24-4,40,0.25},
        {"ted5_740" ,40,32-4,48,0.27},
        {"ted6_740" ,48,40-4,56,0.30},
        {"ted7_740" ,56,48-4,64,0.30},
        {"ted8_740" ,64,56-4,72,0.30},
        {"ted9_740" ,72,64-4,80,0.30},
        {"ted10_740",80,72-4,88,0.30}
    }
    
    if CLIENT then
        timer.Simple(1, function()
            local BogeyTbl = scripted_ents.GetStored("gmod_train_bogey").t
            
            BogeyTbl.SoundNames["ted1_740"]  = "subway_trains/rusich/engines/engine_8.wav"
            BogeyTbl.SoundNames["ted2_740"]  = "subway_trains/rusich/engines/engine_16.wav"
            BogeyTbl.SoundNames["ted3_740"]  = "subway_trains/rusich/engines/engine_24.wav"
            BogeyTbl.SoundNames["ted4_740"]  = "subway_trains/rusich/engines/engine_32.wav"
            BogeyTbl.SoundNames["ted5_740"]  = "subway_trains/rusich/engines/engine_40.wav"
            BogeyTbl.SoundNames["ted6_740"]  = "subway_trains/rusich/engines/engine_48.wav"
            BogeyTbl.SoundNames["ted7_740"]  = "subway_trains/rusich/engines/engine_56.wav"
            BogeyTbl.SoundNames["ted8_740"]  = "subway_trains/rusich/engines/engine_64.wav"
            BogeyTbl.SoundNames["ted9_740"]  = "subway_trains/rusich/engines/engine_72.wav"
            BogeyTbl.SoundNames["ted10_740"] = "subway_trains/rusich/engines/engine_80.wav"
            BogeyTbl.EngineSNDConfig[5] = ClBogeyConf
            print("[Metrostroi 81-740] Inject sounds")
        end)
    end

	if CLIENT then return end
	else

--custom bogey and couple
timer.Simple(0,function()
	if not Metrostroi then return end
	
	local models = {
		["models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"] = true,
		["models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"] = true,
		
		["models/metrostroi_train/81-741/body/81-741_4_defualt_mos_front.mdl"] = true,
		["models/metrostroi_train/81-741/body/81-741_4_rear_reference.mdl"] = true,
		
		["models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl"] = true,
		["models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl"] = true, 
		["models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl"] = true,
		
		["models/metrostroi_train/81-740/bogey/metro_couple_740.mdl"] = true,
		
	}
	
	if SERVER then
		timer.Simple(1,function()
		
			-- регистрируем тележки
			local tbl = scripted_ents.Get("gmod_train_bogey")
			if tbl then	
				tbl.Types["740PER"] = { -- тележка
					"models/metrostroi_train/81-740/bogey/metro_bogey_740.mdl",
					Vector(0,0,-10.5),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740G"] = { -- тележка + гармошка
					"models/metrostroi_train/81-740/bogey/metro_bogey_garm.mdl",
					Vector(0,0.0,-10),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				tbl.Types["740NOTR"] = { -- немоторная тележка
					"models/metrostroi_train/81-740/bogey/metro_bogey_notr.mdl",
					Vector(0,0.0,-10.1),Angle(0,90,0),"models/metrostroi_train/bogey/metro_wheels_collector.mdl",
					Vector(0,-61,-14),Vector(0,61,-14),
					nil,
					Vector(4.3,-63,-3.3),Vector(4.3,63,-3.3),
				}
				scripted_ents.Register(tbl,"gmod_train_bogey") -- регистрируем
			end
			
			-- регистрируем сцепку
			local tbl = scripted_ents.Get("gmod_train_couple")
			if tbl then
				tbl.Types["740"] = { -- сцепка
					"models/metrostroi_train/81-740/bogey/metro_couple_740.mdl",Vector(65,0,0),Vector(65.1,1,-4.9),Angle(0,-90,0)
				}
				scripted_ents.Register(tbl,"gmod_train_couple")	-- регистрируем
				print("[Metrostroi 81-740] Inject sounds")				
				end
			end)	
		end 	
	end) 
end

--[[mezhvag --межвагонки будут переделаны
hook.Add("Metrostroi.AddMezhvagToSpawner","81_740_stock",function(tab)
	tab["gmod_subway_81-740_4_mvm"] = {nil,nil,0}
	tab["gmod_subway_81-741_4_mvm"] = {nil,Vector(-340,0,-10),45}
end)]]