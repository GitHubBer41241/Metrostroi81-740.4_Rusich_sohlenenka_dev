local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")
or Map:find("gm_metropbl")) then
	return
end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-740"
ENT.Model = "models/metrostroi_train/81-740/body/81-740_4_defualt_mos_front.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = true
ENT.DontAccelerateSimulation = false

function ENT:PassengerCapacity()
    return 176
end

function ENT:GetStandingArea()
	return Vector(520-15,-25,-47),Vector(15,25,-46)
end 

local function GetDoorPosition(n,G)	--Правые двери			--Левые двери
	return Vector(652.5-15  - 35.0*G     -  338.8*n, -67.5*(1-2*G), 4.3)
end

local yventpos = {
    414.5+0*117-144-15,
	414.5+2*117+5-144-15,
	214.5+4*117+0.5-15,
}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)	

	for i = 1,10 do
		local id1 = Format("b1tunnel_%d",i)
		local id2 = Format("b2tunnel_%d",i)
		local id3 = Format("b3tunnel_%d",i)		
		self.SoundNames[id1.."a"] = "subway_trains/rusich/bogey/st"..i.."a.wav"
		self.SoundNames[id1.."b"] = "subway_trains/rusich/bogey/st"..i.."b.wav"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector( 520-25,0,-75),1}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		
		self.SoundNames[id2.."a"] = "subway_trains/rusich/bogey/st"..i.."a.wav"
		self.SoundNames[id2.."b"] = "subway_trains/rusich/bogey/st"..i.."b.wav"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-15-16.5,0,-74),1}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
		
		self.SoundNames[id3.."a"] = "subway_trains/rusich/bogey/st"..i.."a.wav"
		self.SoundNames[id3.."b"] = "subway_trains/rusich/bogey/st"..i.."b.wav"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532-25,0,-74.5),1}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end
	for i = 1,14 do
		local id1 = Format("b1street_%d",i)
		local id2 = Format("b2street_%d",i)
		local id3 = Format("b3street_%d",i)		
		self.SoundNames[id1.."a"] = "subway_trains/rusich/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id1.."b"] = "subway_trains/rusich/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id1.."a"] = {700,1e9,Vector(520-25,0,-75),1.5}
		self.SoundPositions[id1.."b"] = self.SoundPositions[id1.."a"]
		
		self.SoundNames[id2.."a"] = "subway_trains/rusich/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id2.."b"] = "subway_trains/rusich/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id2.."a"] = {700,1e9,Vector(-15-16.5,0,-74),1.5}
		self.SoundPositions[id2.."b"] = self.SoundPositions[id2.."a"]
		
		self.SoundNames[id3.."a"] = "subway_trains/rusich/bogey/wheels/street_"..i.."a.mp3"
		self.SoundNames[id3.."b"] = "subway_trains/rusich/bogey/wheels/street_"..i.."b.mp3"
		self.SoundPositions[id3.."a"] = {700,1e9,Vector(-532-25,0,-74.5),1.5}
		self.SoundPositions[id3.."b"] = self.SoundPositions[id3.."a"]		
	end
	
	--Костыль в лице id2 и 3, они работают только на передней секции, цель - переписать их под заднюю секцию без внедрения кода непосредственно в заднюю секцию.	

--[[
    self.SoundNames["async1"]   = {"subway_trains/rusich/inverter/inverter1.wav",loop = true}
    self.SoundPositions["async1"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async2"]   = {"subway_trains/rusich/inverter/inverter2.wav",loop = true}
    self.SoundPositions["async2"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async3"]   = {"subway_trains/rusich/inverter/inverter3.wav",loop = true}
    self.SoundPositions["async3"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async4"]   = {"subway_trains/rusich/inverter/inverter4.wav",loop = true}
    self.SoundPositions["async4"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    self.SoundNames["async5"]   = {"subway_trains/rusich/inverter/inverter5.wav",loop = true}
    self.SoundPositions["async5"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos
    --self.SoundNames["async6"]   = {"subway_trains/rusich/inverter/inverter6.wav",loop = true} --5 инвертер переименован в звук рекуперации.
    --self.SoundPositions["async6"] = {400,1e9,Vector(700-144,0,0),1} --FIXME: Pos		
]]

    self.SoundNames["chopper_onix"]   = {"subway_trains/rusich/chopper.wav",loop = true}
    self.SoundPositions["chopper_onix"] = {200,1e9,Vector(144-15,0,0),2}	
    self.SoundNames["ONIX"]   = {"subway_trains/rusich/inverter/inverter.wav", loop = true}
    self.SoundPositions["ONIX"] = {400,1e9,Vector(344-15,0,0),1.5}	
	
    for i=1,4 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop.wav"}
        self.SoundPositions["vent"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
        self.SoundNames["vent1"..i] = {loop=true,"subway_trains/rusich/vent/vent_loop_1.wav"}
        self.SoundPositions["vent1"..i] = {130,1e9,Vector(yventpos[i],0,30),0.2}
    end	

	self.SoundNames["kr_open"] = {
        "subway_trains/717/cover/cover_open1.mp3",
        "subway_trains/717/cover/cover_open2.mp3",
        "subway_trains/717/cover/cover_open3.mp3",
    }
    self.SoundNames["kr_close"] = {
        "subway_trains/717/cover/cover_close1.mp3",
        "subway_trains/717/cover/cover_close2.mp3",
        "subway_trains/717/cover/cover_close3.mp3",
    }

	self.SoundNames["ring"] = {loop=0.0,"subway_trains/rusich/rings/ring_start.wav","subway_trains/rusich/rings/ring_loop.wav","subway_trains/rusich/rings/ring_end.wav"}
    self.SoundPositions["ring"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}
	
    self.SoundNames["ring_old"] = {loop=0.0,"subway_trains/rusich/rings/ring_start1.wav","subway_trains/rusich/rings/ring_loop1.wav","subway_trains/rusich/rings/ring_end1.wav"}
    self.SoundPositions["ring_old"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}	
	
    self.SoundNames["ring_new"] = {loop=0.0,"subway_trains/rusich/rings/ring_start2.wav","subway_trains/rusich/rings/ring_loop2.wav","subway_trains/rusich/rings/ring_end2.wav"}
    self.SoundPositions["ring_new"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}	

    self.SoundNames["ring_1"] = {loop=0.0,"subway_trains/rusich/rings/ring_start3.wav","subway_trains/rusich/rings/ring_loop3.wav","subway_trains/rusich/rings/ring_end3.wav"}
    self.SoundPositions["ring_1"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}		
	
	self.SoundNames["ring_vityaz"] = "subway_trains/rusich/rings/ring_start1.wav"
	self.SoundPositions["ring_vityaz"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}
	
	self.SoundNames["ring_cams"] = "subway_trains/rusich/rings/ring_start.wav"
	self.SoundPositions["ring_cams"] = {100,1e9,Vector(803-159,25.6,-26.3),0.45}

    self.SoundNames["compressor_pn"] = "subway_trains/rusich/compressor/compressor_psh.wav"
    self.SoundPositions["compressor_pn"] = {485,1e9,Vector(-18+-159,-40,-66),0.7} --FIXME: Pos

	 local j = math.random (1,3)
    self.SoundNames["release_front"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
    self.SoundPositions["release_front"] = {1200,1e9,Vector(0-159,0,-70),0.4}
    self.SoundNames["release_middle"] = {loop=true,"subway_trains/rusich/pneumo_release_"..j..".wav"}
	self.SoundPositions["release_middle"] = {1200,1e9,Vector(800-159,0,-70),0.4}
    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["parking_brake"] = {400,1e9,Vector(-13+159,0,-70),0.95}
    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/release_2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(813-159,-14.8,-47.9),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(813-159,-14.8,-47.9),0.86}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_release.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(813-159,-14.8,-47.9),0.4}

	self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(813-159, 0,-63),1}

    self.SoundNames["switchbl_off"] = {
        "subway_trains/717/switches/tumbler_fatb_off1.mp3",
        "subway_trains/717/switches/tumbler_fatb_off2.mp3",
        "subway_trains/717/switches/tumbler_fatb_off3.mp3",
    }
    self.SoundNames["switchbl_on"] = {
        "subway_trains/717/switches/tumbler_fatb_on1.mp3",
        "subway_trains/717/switches/tumbler_fatb_on2.mp3",
        "subway_trains/717/switches/tumbler_fatb_on3.mp3",
    }
    self.SoundNames["switch2_off"] = {
        "subway_trains/717/switches/tumbler_slim_off1.mp3",
        "subway_trains/717/switches/tumbler_slim_off2.mp3",
        "subway_trains/717/switches/tumbler_slim_off3.mp3",
        "subway_trains/717/switches/tumbler_slim_off4.mp3",
    }
    self.SoundNames["switch2_on"] = {
        "subway_trains/717/switches/tumbler_slim_on1.mp3",
        "subway_trains/717/switches/tumbler_slim_on2.mp3",
        "subway_trains/717/switches/tumbler_slim_on3.mp3",
        "subway_trains/717/switches/tumbler_slim_on4.mp3",
    }

    self.SoundNames["pneumo_disconnect_close"] = {"subway_trains/720/013_close1.mp3","subway_trains/720/013_close2.mp3","subway_trains/720/013_close3.mp3"}
    self.SoundNames["pneumo_disconnect_open"] = {
        "subway_trains/720/013_open1.mp3",
        "subway_trains/720/013_open2.mp3",
        "subway_trains/720/013_open3.mp3",
        "subway_trains/720/013_open4.mp3",
    }
    self.SoundPositions["pneumo_disconnect_close"] = {800,1e9,Vector(795-159,40,-55),0.4}
    self.SoundPositions["pneumo_disconnect_open"] = {800,1e9,Vector(795-159,40,-55),0.4}
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["pnm_on"]           = {"subway_trains/common/pnm/pnm_switch_on.mp3","subway_trains/common/pnm/pnm_switch_on2.mp3"}
    self.SoundNames["pnm_off"]          = "subway_trains/common/pnm/pnm_switch_off.mp3"
    self.SoundNames["pnm_button1_on"]           = {
        "subway_trains/common/pnm/pnm_button_push.mp3",
        "subway_trains/common/pnm/pnm_button_push2.mp3",
    }

    self.SoundNames["pnm_button2_on"]           = {
        "subway_trains/common/pnm/pnm_button_push3.mp3",
        "subway_trains/common/pnm/pnm_button_push4.mp3",
    }

    self.SoundNames["pnm_button1_off"]          = {
        "subway_trains/common/pnm/pnm_button_release.mp3",
        "subway_trains/common/pnm/pnm_button_release2.mp3",
        "subway_trains/common/pnm/pnm_button_release3.mp3",
    }

    self.SoundNames["pnm_button2_off"]          = {
        "subway_trains/common/pnm/pnm_button_release4.mp3",
        "subway_trains/common/pnm/pnm_button_release5.mp3",
    }

    self.SoundNames["horn"] = {loop=0.6,"subway_trains/rusich/horn/horn8_start.wav","subway_trains/rusich/horn/horn8_loop.wav", "subway_trains/rusich/horn/horn8_end.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(820-159,0,-30),0.8}

    self.SoundNames["KV_-3_-2"] = "subway_trains/rusich/controller/t3_t2.mp3"
    self.SoundNames["KV_-2_-1"] = "subway_trains/rusich/controller/t2_t1.mp3"
    self.SoundNames["KV_-1_0"] = "subway_trains/rusich/controller/t1_0.mp3"
    self.SoundNames["KV_0_1"] = "subway_trains/rusich/controller/0_x1.mp3"
    self.SoundNames["KV_1_2"] = "subway_trains/rusich/controller/x1_x2.mp3"
    self.SoundNames["KV_2_3"] = "subway_trains/rusich/controller/x2_x3.mp3"
    self.SoundNames["KV_3_4"] = "subway_trains/rusich/controller/x3_x4.mp3"
    self.SoundNames["KV_4_3"] = "subway_trains/rusich/controller/x4_x3.mp3"
    self.SoundNames["KV_3_2"] = "subway_trains/rusich/controller/x3_x2.mp3"
    self.SoundNames["KV_2_1"] = "subway_trains/rusich/controller/x2_x1.mp3"
    self.SoundNames["KV_1_0"] = "subway_trains/rusich/controller/x1_0.mp3"
    self.SoundNames["KV_0_-1"] = "subway_trains/rusich/controller/0_t1.mp3"
    self.SoundNames["KV_-1_-2"] = "subway_trains/rusich/controller/t1_t2.mp3"
    self.SoundNames["KV_-2_-3"] = "subway_trains/rusich/controller/t2_t3.mp3"
    self.SoundPositions["KV_-3_-2"] = {80,1e9,Vector(830.8-159,25.3,-10)}
    self.SoundPositions["KV_-2_-1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-1_0"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_0_1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_1_2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_2_3"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_3_4"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_4_3"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_3_2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_2_1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_1_0"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_0_-1"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-1_-2"] = self.SoundPositions["KV_-3_-2"]
    self.SoundPositions["KV_-2_-3"] = self.SoundPositions["KV_-3_-2"]

    --[[self.SoundNames["kro_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundNames["kro_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }]]
    self.SoundNames["kro_-1_0"] = {"subway_trains/722/switches/multi_switch_panel_mid.mp3","subway_trains/722/switches/multi_switch_panel_mid2.mp3"}
    self.SoundNames["kro_0_1"] = {"subway_trains/722/switches/multi_switch_panel_max.mp3"}
    self.SoundNames["kro_1_0"] = {"subway_trains/722/switches/multi_switch_panel_mid.mp3","subway_trains/722/switches/multi_switch_panel_mid2.mp3"}
    self.SoundNames["kro_0_-1"] = {"subway_trains/722/switches/multi_switch_panel_min.mp3"}
    self.SoundPositions["kro_in"] = {80,1e9,Vector(813.4-159,53.3,-21.1)}
    self.SoundPositions["kro_out"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_-1_0"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_0_1"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_1_0"] = self.SoundPositions["kro_in"]
    self.SoundPositions["kro_0_-1"] = self.SoundPositions["kro_in"]

    self.SoundNames["krr_in"] = self.SoundNames["kro_in"]
    self.SoundNames["krr_out"] = self.SoundNames["kro_out"]
    self.SoundNames["krr_-1_0"] = self.SoundNames["kro_-1_0"]
    self.SoundNames["krr_0_1"] = self.SoundNames["kro_0_1"]
    self.SoundNames["krr_1_0"] = self.SoundNames["kro_1_0"]
    self.SoundNames["krr_0_-1"] = self.SoundNames["kro_0_-1"]
    self.SoundPositions["krr_in"] = {80,1e9,Vector(810.4-159,53.9,-17.3)}
    self.SoundPositions["krr_out"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_-1_0"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_0_1"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_1_0"] = self.SoundPositions["krr_in"]
    self.SoundPositions["krr_0_-1"] = self.SoundPositions["krr_in"]

    self.SoundNames["switch_batt_on"] = {"subway_trains/720/switches/batt_on.mp3","subway_trains/720/switches/batt_on2.mp3"}
    self.SoundNames["switch_batt_off"] = {"subway_trains/720/switches/batt_off.mp3","subway_trains/720/switches/batt_off2.mp3"}

    self.SoundNames["switch_batt"] = {"subway_trains/720/switches/batt_on.mp3","subway_trains/720/switches/batt_on2.mp3","subway_trains/720/switches/batt_off.mp3","subway_trains/720/switches/batt_off2.mp3"}

    self.SoundNames["switch_pvz_on"] = {"subway_trains/720/switches/switchb_on.mp3","subway_trains/720/switches/switchp_on.mp3"}
    self.SoundNames["switch_pvz_off"] = {"subway_trains/720/switches/switchb_off.mp3","subway_trains/720/switches/switchp_off.mp3"}

    self.SoundNames["switch_on"] = {"subway_trains/720/switches/switchp_on.mp3","subway_trains/720/switches/switchp_on2.mp3","subway_trains/720/switches/switchp_on3.mp3"}
    self.SoundNames["switch_off"] = {"subway_trains/720/switches/switchp_off.mp3","subway_trains/720/switches/switchp_off2.mp3","subway_trains/720/switches/switchp_off3.mp3"}

    self.SoundNames["button_vityaz1_press"] = {"subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press2.mp3","subway_trains/720/switches/buttv_press3.mp3"}
    self.SoundNames["button_vityaz1_release"] = {"subway_trains/720/switches/buttv_release.mp3","subway_trains/720/switches/buttv_release2.mp3","subway_trains/720/switches/buttv_release3.mp3"}
    self.SoundNames["button_vityaz2_press"] = {"subway_trains/720/switches/buttv_press4.mp3","subway_trains/720/switches/buttv_press5.mp3","subway_trains/720/switches/buttv_press6.mp3"}
    self.SoundNames["button_vityaz2_release"] = {"subway_trains/720/switches/buttv_release4.mp3","subway_trains/720/switches/buttv_release5.mp3","subway_trains/720/switches/buttv_release6.mp3"}
    self.SoundNames["button_vityaz3_press"] = {"subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press3.mp3","subway_trains/720/switches/buttv_press7.mp3","subway_trains/720/switches/buttv_press8.mp3"}
    self.SoundNames["button_vityaz3_release"] = {"subway_trains/720/switches/buttv_release.mp3","subway_trains/720/switches/buttv_release3.mp3","subway_trains/720/switches/buttv_release7.mp3","subway_trains/720/switches/buttv_release8.mp3"}
    self.SoundNames["button_vityaz4_press"] = {"subway_trains/720/switches/buttv3_press.mp3","subway_trains/720/switches/buttv_press2.mp3","subway_trains/720/switches/buttv_press.mp3","subway_trains/720/switches/buttv_press8.mp3"}
    self.SoundNames["button_vityaz4_release"] = {"subway_trains/720/switches/buttv4_release.mp3","subway_trains/720/switches/buttv_release5.mp3","subway_trains/720/switches/buttv_release7.mp3","subway_trains/720/switches/buttv_release6.mp3"}

    self.SoundNames["button_press"] = {"subway_trains/720/switches/butt_press.mp3","subway_trains/720/switches/butt_press2.mp3","subway_trains/720/switches/butt_press3.mp3"}
    self.SoundNames["button_release"] = {"subway_trains/720/switches/butt_release.mp3","subway_trains/720/switches/butt_release2.mp3","subway_trains/720/switches/butt_release3.mp3"}

    self.SoundNames["button_square_press"] = "subway_trains/720/switches/butts_press.mp3"
    self.SoundNames["button_square_release"] = "subway_trains/720/switches/butts_release.mp3"

    self.SoundNames["button_square_on"] = {"subway_trains/720/switches/butts_on.mp3","subway_trains/720/switches/butts_on2.mp3"}
    self.SoundNames["button_square_off"] = {"subway_trains/720/switches/butts_off.mp3","subway_trains/720/switches/butts_off2.mp3"}

    self.SoundNames["door_cab_open"] = {"subway_trains/rusich/door/cab/door_cab_open.mp3","subway_trains/rusich/door/cab/door_cab_open2.mp3"}
    self.SoundNames["door_cab_close"] = {"subway_trains/rusich/door/cab/door_cab_close.mp3","subway_trains/rusich/door/cab/door_cab_close2.mp3"}
	
	local rol = math.random (1,2)	
    self.SoundNames["door_cab_roll"] = "subway_trains/rusich/door/cab/cabdoor_roll.wav"
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/rusich/rolling/skrip1.mp3"}	
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/rusich/rolling/rolling_10.wav"}
    self.SoundNames["rolling_30"] = {loop=true,"subway_trains/rusich/rolling/rolling_30.wav"}
    self.SoundNames["rolling_55"] = {loop=true,"subway_trains/rusich/rolling/rolling_55.wav"}
    self.SoundNames["rolling_75"] = {loop=true,"subway_trains/rusich/rolling/rolling_75.wav"}
    self.SoundPositions["door_cab_roll"] = {485,1e9,Vector(516-159,0,0),0.5}
	
    self.SoundPositions["rolling_5"] = {485,1e9,Vector(520-25,0,0),0.6}	
    self.SoundPositions["rolling_10"] = {485,1e9,Vector(520-25,0,0),0.7}
    self.SoundPositions["rolling_30"] = {485,1e9,Vector(520-25,0,0),0.8}
    self.SoundPositions["rolling_55"] = {485,1e9,Vector(520-25,0,0),0.9}
    self.SoundPositions["rolling_75"] = {485,1e9,Vector(520-25,0,0),0.95}
    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_medium"..rol..".wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_high"..rol..".wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(520-25,0,0),0.6*0.4}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(520-25,0,0),0.90*0.4}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(520-25,0,0),1.00*0.4}
	
	self.SoundPositions["rolling_5_middle"] = {485,1e9,Vector(-15-16.5,0),1}	 --0.6
    self.SoundPositions["rolling_10_middle"] = {485,1e9,Vector(-15-16.5,0),1}  --0.7
    self.SoundPositions["rolling_30_middle"] = {485,1e9,Vector(-15-16.5,0),1}  --0.8
    self.SoundPositions["rolling_55_middle"] = {485,1e9,Vector(-15-16.5,0),1}  --0.9
    self.SoundPositions["rolling_75_middle"] = {485,1e9,Vector(-15-16.5,0),1} --0.95
    self.SoundNames["rolling_low_middle"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium2_middle"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_medium"..rol..".wav"}
    self.SoundNames["rolling_high2_middle"] = {loop=true,"subway_trains/rusich/rolling/rolling_outside_high"..rol..".wav"}
    self.SoundPositions["rolling_low_middle"] = {480,1e12,Vector(-15-16.5,0),0.6*0.4}
    self.SoundPositions["rolling_medium2_middle"] = {480,1e12,Vector(-15-16.5,0),0.90*0.4}
    self.SoundPositions["rolling_high2_middle"] = {480,1e12,Vector(-15-16.5,0),1.00*0.4}

    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}
    self.SoundPositions["gv_f"] = {80,1e9,Vector(126.4-159,50,-60-23.5),0.8}
    self.SoundPositions["gv_b"] = {80,1e9,Vector(126.4-159,50,-60-23.5),0.8}
	
	local loop = math.random (1,2)
	local start = math.random (1,5)		
	local closed = math.random (1,5)	
	local open = math.random (1,3)	
    for i=0,2 do	
    for i=0,1 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/rusich/doors/door_loop_"..loop..".wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."s"] = {"subway_trains/rusich/doors/door_start_"..start..".wav"}
            self.SoundPositions["door"..i.."x"..k.."s"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."o"] = {"subway_trains/rusich/doors/door_open_end"..open..".wav"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {200,1e9,GetDoorPosition(i,k),1}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/rusich/doors/door_close"..closed..".wav"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {200,1e9,GetDoorPosition(i,k),0.5}
	        end
    end		
    end
	-- ХВАТИТ БЛЯТЬ ПИЩАТЬ!!!
    --self.SoundNames["work_beep"] = {loop=true,"subway_trains/720/work_beep_loop.wavv"}
    --self.SoundPositions["work_beep"] = {65,1e9,Vector(816-144,23,10),0.03}
	
    self.SoundNames["batt_on"] = "subway_trains/720/batt_on.mp3"
    self.SoundPositions["batt_on"] = {400,1e9,Vector(816.4-159,50,-60-23.5),0.23}

    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla2_start1.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla2_start2.mp3"
    self.SoundPositions["igla_on"] = {50,1e9,Vector(800-155,42.3,45.71),0.05}
    self.SoundPositions["igla_off"] = {50,1e9,Vector(800-155,42.3,45.71),0.05}
    self.SoundPositions["igla_start1"] = {50,1e9,Vector(800-155,42.3,45.71),0.05}
    self.SoundPositions["igla_start2"] = {50,1e9,Vector(800-155,42.3,45.71),0.05}

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundPositions["emer_brake"] = {90,1e9,Vector(780-159,-45,-75),0.85}
end
 
function ENT:InitializeSystems()
    self:LoadSystem("TR","TR_3B_4740")
    self:LoadSystem("Electric","81_740_4ELECTRICA")
	self:LoadSystem("KV","81_740_4RV")

    self:LoadSystem("BUKP","81_740_4VITYAZ")
    self:LoadSystem("BUV","81_740_4BUV")
    self:LoadSystem("BARS","81_740_4BARS")
	self:LoadSystem("CAMS","81_740_4CAMS")

    self:LoadSystem("Pneumatic","81_740_4Pneumatic")
    self:LoadSystem("Horn","81_740_4Horn")

    self:LoadSystem("Panel","81_740_4Panel")

    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsASNP")
    self:LoadSystem("ASNP","81_74_ASNP")
    self:LoadSystem("RouteInf","81_740_4router")
    self:LoadSystem("ASNP_VV","81_74_ASNP_VV")

    self:LoadSystem("Tickers","81_740_4Ticker")
    --self:LoadSystem("Tickers","81_760_Ticker")
    --self:LoadSystem("PassSchemes","81_740_4PassScheme")
	
	--self:LoadSystem("81_740_RED_LAMPS")
	self:LoadSystem("IGLA_CBKI","IGLA_740_4CBKI")
	self:LoadSystem("IGLA_PCBK","IGLA_740_4PCBK")
	self:LoadSystem("Prost_Kos","81_740_4PROST")
	
	self:LoadSystem("AsyncInverter","81_760_AsyncInverter")	
end

ENT.AnnouncerPositions = {}
ENT.AnnouncerPositions = {
    {Vector(450,-34,55),50,0.4},
	{Vector(118,-34,55),50,0.4},
    {Vector(158,34,55),50,0.4},
    {Vector(495,34,55),50,0.4},
    {Vector(580,34,55),50,0.4},	
    {Vector(-140,0,55),50,0.4},	-- костыль под информатор.	
    {Vector(-360,0,55),50,0.4}, -- костыль под информатор.
    {Vector(-590,0,55),50,0.4},	-- костыль под информатор.
}
ENT.Cameras = {
    {Vector(770-159,36,42),Angle(0,180,0),"Train.740.CameraCond"},
    {Vector(750-159,36,26),Angle(0,180,0),"Train.740.CameraPPZ"},
    {Vector(800-159,36,2),Angle(0,180,0),"Train.740.CameraPV"},
    {Vector(815-159,-42,-4),Angle(50,0,0),"Train.Common.ASNP"},
    {Vector(800-159,-9,8),Angle(90-46,0,0),"Train.740.CameraVityaz"},
    {Vector(777-159,-35,-30),Angle(40,90,0),"Train.740.CameraKRMH"},
    {Vector(767-159,36,-18),Angle(0,180,0),"Train.740.CameraPVZ"},
    {Vector(840-159,0,-20),Angle(60,0,0),"Train.Common.CouplerCamera"},
}
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81-740",
    Name = "81-740",
    WagType = 1,
    Manufacturer = "MVM",
    ALS = {
        HaveAutostop = true,
        TwoToSix = true,
        RSAs325Hz = true,
        Aproove0As325Hz = false,
    },
    EKKType = 740
}
ENT.NumberRanges = {{0154,0209},{0212,0335}}
--ENT.NumberRanges = {{0154,0155,0337,0190,0191,0192,0193,0194,0195,0196,0197,0198,0199,0200,0201,0202,0203,0204,0205,0206,0207,0208,0209,0212,0213,0214,0215,0216,0217,0218,0219,0220,0221,0222,0223,0224,0225,0227,0228,0229,0230,0231,0232,0233,0234,0235,0236,0238,0239,0248,0249,0250,0251,0252,0253,0254,0255,0256,0257,0260,0261,0262,0263,0264,0265,0266,0267,0268,0269,0270,0271,0272,0273,0276,0277,0278,0279,0280,0281,0282,0283,0286,0287,0288,0289,0290,0291,0292,0293,0296,0297,0304,0305,0305,0306,0307,0308,0311,0318,0319,0320,0321,0322,0323,0324,0325,0326,0327,0328,0329,0330,0331,0332,0333,0334,0335}}
local Texture = {}
local Announcer = {}
for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do Announcer[k] = v.name or k end	

ENT.Spawner = {
	model = {
	"models/metrostroi_train/81-740/body/81-740_4_front.mdl",
	{"models/metrostroi_train/81-740/salon/salon.mdl",pos = Vector(-15,0,0), ang=Angle(0,0,0)},
	{"models/metrostroi_train/81-740/salon/handrails/handrails.mdl",pos = Vector(370-165,-5,0), ang=Angle(0,0,0)},
	{"models/metrostroi_train/81-740/cabine/Pult/pult.mdl",pos = Vector(465.4-159, 6, 0), ang=Angle(0,0,0)},	
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(852-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(799-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(746-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(691-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(636-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(581-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(527-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(474-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(419-159,0.1,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(852-159,-58.5,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(799-159,-58.5,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(746-159,-58.5,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(691-159,-58.5,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(636-159,-58.5,0),ang = Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(581-159,-58.5,0),ang = Angle(0,-180,0)},	
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(527-159,-58.5,0),ang = Angle(0,-180,0)},	
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(474-159,-58.5,0),ang = Angle(0,-180,0)},	
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_new.mdl", pos = Vector(419-159,-58.5,0),ang = Angle(0,-180,0)},			
	{"models/metrostroi_train/81-741/body/81-741_4_front.mdl",pos = Vector(-26.5,0,0), ang=Angle(0,-180,0)},
	{"models/metrostroi_train/81-740/cabine/Pult/bucik.mdl",pos = Vector(465.4-159, 6, 0), ang=Angle(0,0,0)},
	{"models/metrostroi_train/81-740/body/Garm.mdl",pos = Vector(330-15,0,-1.5), ang=Angle(0,0,0)},
	{"models/metrostroi_train/81-740/salon/salon_rear.mdl",pos = Vector(-544-15, 0, 5.5), ang=Angle(0,180,0)},
	{"models/metrostroi_train/81-740/salon/lamps/lamps_off_rear.mdl",pos = Vector(-450.1-15, 0.1, -75.15), ang=Angle(0,-180,0)},		
	{"models/metrostroi_train/81-741/salon/handrails/handrails.mdl",pos = Vector(-330-15,0,0), ang=Angle(0,0,0)},
	{"models/metrostroi_train/81-740/body/krepezh.mdl",pos = Vector(283-15,2,-74.6),ang = Angle(0,0,0)},
	{"models/metrostroi_train/81-740/body/krepezh.mdl",pos = Vector(-230-15,1,-74.6),ang = Angle(0,-180,0)},		
    {"models/metrostroi_train/81-740/cabine/electric/paneltex.mdl",pos = Vector(735.5-159,50,50),ang = Angle(180,270,0)},	
	},
	interim = "gmod_subway_81-741_4", 
	postfunc = function(trains,WagNum)
		for i=1,#trains do
			local ent = trains[i]
			if not ent.BUKP then continue end
			ent.BUKP.WagNum = WagNum
			ent.BUKP.Trains = {}
			local first,last = 1,#trains
			for i1=1,#trains do
				local tent = trains[i==1 and i1 or #trains-i1+1]
				ent.BUKP.Trains[i1] = tent:GetWagonNumber()
				ent.BUKP.Trains[tent:GetWagonNumber()] = {}
			end
		end
	end,
    WagNumTable = {1,2,3,4,5},	
	
	{"Announcer","Spawner.740.Announcer","List",Announcer},	
	{},
	{"RingSound","Spawner.740.RingSound","List",{"Spawner.740.RingSound1","Spawner.740.RingSound2","Spawner.740.RingSound3","Spawner.740.RingSound4","Spawner.740.RingSound.Random"}},	
	{"ZavodTable","Spawner.740.ZavodTable","List",{"Spawner.740.ZavodTable.Random","Spawner.740.ZavodTable1","Spawner.740.ZavodTable2","Spawner.740.ZavodTable3"}}, 
	{"BBESound","Spawner.740.BBESound","List",{"Spawner.740.BBESound.Random","Spawner.740.BBESound1","Spawner.740.BBESound2","Spawner.740.BBESound3"}}, 	
	{"MotorType","Spawner.740.MotorType","List",{"Spawner.740.MotorType.Random","Spawner.740.MotorType1","Spawner.740.MotorType2","Spawner.740.MotorType3","Spawner.740.MotorType4","Spawner.740.MotorType5"}},	
	{"VentSound","Spawner.740.VentSound","List",{"Spawner.740.VentSound.Random","Spawner.740.VentSound1","Spawner.740.VentSound2"}}, 	
	{},
	{"SpawnMode","Spawner.Common.SpawnMode","List",{"Spawner.Common.SpawnMode.Full","Spawner.Common.SpawnMode.Deadlock","Spawner.Common.SpawnMode.NightDeadlock","Spawner.Common.SpawnMode.Depot"},nil,function(ent,val,rot,i,wagnum,rclk)	
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.Battery:TriggerInput("Set",val<=2 and 1 or 0)
            if ent.SF1  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.Battery:TriggerInput("Set",val==1 and 1 or 0)
		        ent.PassLight:TriggerInput("Set",val==1 and 1 or 0)
		        ent.BBE:TriggerInput("Set",val==1 and 1 or 0)
		        ent.Compressor:TriggerInput("Set",val==1 and 1 or 0)
		        ent.Headlights1:TriggerInput("Set",val==1 and 1 or 0)
				ent.Headlights2:TriggerInput("Set",val==1 and 1 or 0)
				ent.CabLight:TriggerInput("Set",val==1 and 1 or 0)
				ent.Vent2:TriggerInput("Set",val==1 and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoorLeft = val==2 and first
                ent.CabinDoorRight = val==2 and first
				
				timer.Simple(0,function()	
				if not IsValid(ent) then return end				
				ent:GetNW2Entity("gmod_subway_kuzov").RearDoor = val == 2			
				ent:GetNW2Entity("gmod_subway_kuzov_741").RearDoor = val == 2
				end)				
				
                ent.PassScheme:TriggerInput("Set",val==1 and 1 or 0)
				--ent.BUKP.State = 0	
				--ent.Ticker:TriggerInput("Set",val==1 and 1 or 0)
                if val==1 then
					timer.Simple(1,function()
                        if not IsValid(ent) then return end
                        ent.BUKP.State=2
                    end)
                    timer.Simple(0.65,function()
                        if not IsValid(ent) then return end
                        ent.CAMS.State = -1
						ent.CAMS.StateTimer = CurTime()+19
						ent.BUKP.AutoStart = true
                    end)
                end
                ent.SF4:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF5:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF6:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF12:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF13:TriggerInput("Set",val<=2 and 1 or 0)
                ent.SF15:TriggerInput("Set",val<=2 and 1 or 0)
			
                _LastSpawner=CurTime()				
                ent.CabinDoorLeft = val==4 and first
                ent.CabinDoorRight = val==4 and first
				timer.Simple(0,function()	
				if not IsValid(ent) then return end					
				ent:GetNW2Entity("gmod_subway_kuzov").RearDoor = val == 4					
				ent:GetNW2Entity("gmod_subway_kuzov_741").RearDoor = val == 4
				end)				
            else
                ent.FrontDoor = val==4
				timer.Simple(0,function()	
				if not IsValid(ent) then return end					
				ent:GetNW2Entity("gmod_subway_kuzov").RearDoor = val == 4		
				ent:GetNW2Entity("gmod_subway_kuzov_741").RearDoor = val == 4
				end)				
            end
            ent.Pneumatic.RightDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorRight = val==4
            ent.Pneumatic.LeftDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorLeft = val==4
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
        if val==1 then ent.BV:TriggerInput("Close",1) end
        ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6
    end},
}
