local Map = game.GetMap() 
if (Map:find("gm_metro_minsk_1984") 
or Map:find("gm_metro_nsk_line_2_v6")
or Map:find("gm_metro_kalinin_v2")
or Map:find("gm_metro_krl_v1")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")) then
	return
end

ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.NoTrain = true

ENT.Category		= "Metrostroi (utility)"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Model 			= "models/metrostroi_train/81-740/body/81-740_4_rear_reference.mdl"

--------------------------------------------------------------------------------
-- Load/define basic sounds
--------------------------------------------------------------------------------
function ENT:InitializeSounds()
	self.SoundPositions = {} -- Positions (used clientside)
	self.SoundNames = {}
end

--------------------------------------------------------------------------------
-- Sound functions
--------------------------------------------------------------------------------
--[[
function ENT:SetSoundState(sound,volume,pitch,timeout,range)
	--if not self.Sounds[sound] then return end
	--if sound == "ring" then sound = "zombie_loop" end
	if not self.Sounds[sound] then
		if self.SoundNames and self.SoundNames[sound] then
			local name = self.SoundNames[sound]
			if self.SoundPositions[sound] then
				local ent_nwID
				if self.SoundPositions[sound] == "cabin" then ent_nwID = "seat_driver" end

				local ent = self:GetNW2Entity(ent_nwID)
				if IsValid(ent) then
					self.Sounds[sound] = CreateSound(ent, Sound(name))
				else
					return
				end
			else
				self.Sounds[sound] = CreateSound(self, Sound(name))
			end
		else
			return
		end
	end
	local default_range = 0.80
	if (volume <= 0) or (pitch <= 0) then
		self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
		self.Sounds[sound]:Stop()
		return
	end

	if soundid == "switch" then default_range = 0.50 end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
	local vol = math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random()
	self.Sounds[sound]:PlayEx(vol,pch+1)
	self.Sounds[sound]:ChangeVolume(vol,timeout or 0)
	self.Sounds[sound]:ChangePitch(pch+1,timeout or 0)
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
end
]]
local function PauseBASS(snd)
	snd:Pause()
	snd:SetTime(0)
end
function ENT:CreateBASSSound(name,callback)
	if self.StopSounds then return end
	--if self.SoundSpawned and name:find(".wav") then return end
	--self.SoundSpawned = true
	sound.PlayFile(Sound("sound/"..name), "3d noplay mono", function( snd,err,errName )
		if err then
			if snd then
				--if snd and snd.Remove then snd:Remove() end
			end
			if err == 4 or err == 37 then self.StopSounds = true end
			MsgC(Color(255,0,0),Format("Sound:%s\n\tErrCode:%s, ErrName:%s,\n",name,err,errName))
			return
		end
		if self.Sounds and not err and ( IsValid( snd ) ) then
			callback(snd)
			--[[snd:SetPos(self:GetNW2Entity("seat_driver"):GetPos())
			snd:SetPlaybackRate(pitch)
			snd:SetVolume(volume)
			if looptbl then
				snd:EnableLooping(looptbl.loop == true or looptbl.loop == looptbl.state)
				if #looptbl > 2 then
					self.Sounds[snd] = looptbl
					looptbl.state = (looptbl.state or 1)+1
					looptbl.callback = function()
						self:SetSoundState(soundid,volume,pitch)
					end
					if looptbl.state > #looptbl-1 then looptbl.state = nil end
				end
			end
			--if esnd[5] then
				snd:Set3DFadeDistance(200,1e9)
			--end
			snd:Play()]]
		end
	end )
end
function ENT:SetPitchVolume(snd,pitch,volume,tbl)
	if not IsValid(snd) then return end
	if tbl then
		if tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	else
		snd:SetVolume(volume)
	end
	snd:SetPlaybackRate(pitch)
end

function ENT:SetBASSPos(snd,tbl)
	if tbl then
		snd:SetPos(self:LocalToWorld(tbl[3]),self:GetAngles():Forward())
	else
		snd:SetPos(self:GetPos())
	end
end
function ENT:SetBassParameters(snd,pitch,volume,tbl,looping,spec)
	if snd:GetState() ~= GMOD_CHANNEL_STOPPED and snd:GetState() ~= GMOD_CHANNEL_PAUSED then
		return
	end
	self:SetBASSPos(snd,tbl)
	if tbl then
		snd:Set3DFadeDistance(tbl[1],tbl[2])
		if tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	else
		snd:Set3DFadeDistance(200,1e9)
		snd:SetVolume(volume)
	end
	snd:EnableLooping(looping or false)
	snd:SetPlaybackRate(pitch)
	local siz1,siz2 = snd:Get3DFadeDistance()--[[]
	debugoverlay.Sphere(snd:GetPos(),4,2,Color(0,255,0),true)
	debugoverlay.Sphere(snd:GetPos(),siz1,2,Color(255,0,0,100),false)]]
	--debugoverlay.Sphere(snd:GetPos(),siz2,2,Color(0,0,255,100),false)
end
function ENT:SetSoundState(soundid,volume,pitch,time)
	if self.StopSounds then return end
	local name = self.SoundNames and self.SoundNames[soundid]
	local tbl = self.SoundPositions[soundid]
	local looptbl = type(name) == "table" and name
	if looptbl and #name > 1 then --triple-looped sound
		if not self.Sounds.loop[soundid] then self.Sounds.loop[soundid] = {state=false,newstate=false,pitch=0} end
		local sndtbl = self.Sounds.loop[soundid]
		if volume > 0 then sndtbl.volume = volume end
		if pitch > 0 then sndtbl.pitch = pitch end
		for i,v in ipairs(name) do
			if not sndtbl[i] then sndtbl[i] = {} end
			if not IsValid(sndtbl[i].sound) then
				if not IsValid(sndtbl[i].sound) and sndtbl[i].sound and sndtbl[i].sound.Remove then
					sndtbl[i].sound:Remove()
				end
				self:CreateBASSSound(v,function(snd)
					if not IsValid(self) then return end
                    snd:SetPos(self:LocalToWorld(tbl[3]),self:GetAngles():Forward())
					sndtbl[i].sound = snd
					sndtbl[i].volume = volume > 0 and sndtbl.volume or volume or 0
					self:SetBassParameters(snd,pitch,sndtbl[i].volume,tbl,i==2)
				end)
			end
		end
		local state = volume > 0
		if sndtbl.state ~= state then
			sndtbl[1].state = state
			if not state then sndtbl[2].state = false end
			sndtbl[3].state = not state
			sndtbl.control = state and 1 or 3
			sndtbl.state = state
		end
	else
		if looptbl then name = name[1] end
		local oldsnd = self.Sounds[soundid]
		if not IsValid(oldsnd) and name then
			if not IsValid(oldsnd) and oldsnd and oldsnd.Remove then
				oldsnd:Remove()
			end
			self:CreateBASSSound(name,function(snd)
				self.Sounds[soundid] = snd
				self:SetBassParameters(snd,pitch,volume,tbl,looptbl and looptbl.loop)
			end)
			return
		end
		local snd = self.Sounds[soundid]
		if not IsValid(snd) then return end
		local default_range = 0.80
		if ((volume <= 0) or (pitch <= 0)) then
			if snd:GetTime() > 0 then
				PauseBASS(snd)
			end
			return
		end
		if snd:GetState() ~= GMOD_CHANNEL_PLAYING then
			snd:Play()
			if time then
				snd:SetTime(time)
			end
		end
		snd:SetPlaybackRate(pitch)
		if tbl and tbl[4] then
			snd:SetVolume(tbl[4]*volume)
		else
			snd:SetVolume(volume)
		end
	end


	if soundid == "switch" then default_range = 0.50 end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	--self.Sounds[soundid]:SetSoundLevel(100*(range or default_range))
	--local vol = math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random()
	--self.Sounds[soundid]:PlayEx(vol,pch+1)
	--self.Sounds[soundid]:ChangeVolume(vol,timeout or 0)
	--self.Sounds[soundid]:ChangePitch(pch+1,timeout or 0)
	--self.Sounds[soundid]:SetSoundLevel(100*(range or default_range))
end

--[[function ENT:CheckActionTimeout(action,timeout)
	self.LastActionTime = self.LastActionTime or {}
	self.LastActionTime[action] = self.LastActionTime[action] or (CurTime()-1000)
	if CurTime() - self.LastActionTime[action] < timeout then return true end
	self.LastActionTime[action] = CurTime()

	return false
end
]]--

if SERVER then
	util.AddNetworkString("metrostroi_client_sound")
else
	net.Receive("metrostroi_client_sound", function(size)
		local train = net.ReadEntity()
		if not IsValid(train) or not train.PlayOnce or not train:ShouldRenderClientEnts() then return end
		local snd = net.ReadString()
		local pos = net.ReadString()
		local range = net.ReadFloat()
		local pitch = net.ReadUInt(9)/100
		if pitch == 0 then pitch = 1 end
		if pos == "styk" and train.OnStyk then
			local opsnd,oppos,oprange,oppitch = train:OnStyk(snd,pos,range,pitch)
			if opsnd then
				train:PlayOnce(opsnd or snd,oppos or pos,oprange or range,oppitch or pitch)
			end
		elseif train.OnPlay then
			local opsnd,oppos,oprange,oppitch = train:OnPlay(snd,pos,range,pitch)
			if opsnd then
				train:PlayOnce(opsnd or snd,oppos or pos,oprange or range,oppitch or pitch)
			end
		elseif snd then
			train:PlayOnce(snd,pos,range,pitch)
		end
	end)
end
if SERVER then
	function ENT:PlayOnce(soundid,location,range,pitch,randoff)
		if self.OnPlay then
			soundid,location,range,pitch = self:OnPlay(soundid,location,range,pitch)
		end
		net.Start("metrostroi_client_sound",true)
			net.WriteEntity(self)
			net.WriteString(soundid)
			net.WriteString(location or "")
			net.WriteFloat(range or 0.8)
			net.WriteUInt((pitch or 1)*100,9)
		net.SendPAS(self:GetPos())
	end
else
	function ENT:PlayOnceFromPos(id,sndname,volume,pitch,min,max,location)
		if self.StopSounds then return end
		if IsValid(self.Sounds[id]) then self.Sounds[id]:Stop() end
		if self.Sounds[id] and self.Sounds[id].Remove then self.Sounds[id]:Remove() end
		self.Sounds[id] = nil
		if sndname == "_STOP" then return end
		self.SoundPositions[id] = {min,max,location}
		self:CreateBASSSound(sndname,function(snd)
			self.Sounds[id] = snd
			self:SetBassParameters(self.Sounds[id],pitch,volume,self.SoundPositions[id],false)
			snd:Play()
		end)
	end
	function ENT:PlayOnce(soundid,location,range,pitch,randoff)
		if self.StopSounds then return end
		if not soundid then
			ErrorNoHalt(debug.Trace())
		end

		-- Emit sound from right location
		if self.ClientSounds and self.ClientSounds[soundid] then
			local entsound = self.ClientSounds[soundid]
			for i,esnd in ipairs(entsound) do
				soundid = esnd[2](self,range,location)
				local soundname = self.SoundNames[soundid]
				if not soundname then print("NO SOUND",soundname,soundid) continue end
				if type(soundname) == "table" then soundname = table.Random(soundname) end
				if not soundname then ErrorNoHalt(Format("WTF loop sound nil %s %s\n",soundid)) end
				if IsValid(self.ClientEnts[esnd[1]]) and not self.ClientEnts[esnd[1]].snd then
					local ent = self.ClientEnts[esnd[1]]
					sound.PlayFile( "sound/"..soundname, "3d noplay mono noblock", function( snd,err,errName )
						if not err and IsValid(ent) and IsValid( snd ) then
							if err then
								MsgC(Color(255,0,0),Format("Sound:%s\n\tErrCode:%s, ErrName:%s,\n",name,err,errName))
								if err == 4 then self.StopSounds = true end
							end
							snd:SetPos(ent:GetPos(),ent:LocalToWorldAngles(esnd[7]):Forward())
							snd:SetPlaybackRate(esnd[4])
							snd:SetVolume(esnd[3])
							if esnd[5] then
								snd:Set3DFadeDistance(esnd[5],esnd[6])
							end
							table.insert(ent.BASSSounds,snd)
							snd:Play()
							--local siz1,siz2 = snd:Get3DFadeDistance()
							--debugoverlay.Sphere(snd:GetPos(),4,2,Color(0,255,0),true)
							--debugoverlay.Sphere(snd:GetPos(),siz1,2,Color(255,0,0,100),false)
							--debugoverlay.Sphere(snd:GetPos(),siz2,2,Color(0,0,255,100),false)
						end
					end)
				end
			end
			return
		end

		local tbl = self.SoundPositions[soundid]

		local soundname = self.SoundNames[soundid]
		if type(soundname) == "table" then soundname = table.Random(soundname) end
		if not soundname or not tbl then
			--print("NO SOUND",soundname,soundid)
			return
		end

		if IsValid(self.Sounds[soundid]) then self.Sounds[soundid]:Stop() end
		if not IsValid(self.Sounds[soundid]) and self.Sounds[soundid] and self.Sounds[soundid].Remove then
			self.Sounds[soundid]:Remove()
		end
		self:CreateBASSSound(soundname,function(snd)
			self.Sounds[soundid] = snd
			self:SetBassParameters(self.Sounds[soundid],pitch,range,tbl,false)
			snd:Play()
		end)
	end
end

function ENT:SetupDataTables()
	self._NetData = {{},{}}
end
---------------------------------------------------------------------------------------
-- Sends and get float via NWVars
---------------------------------------------------------------------------------------
function ENT:SetPackedRatio(idx,value)
	--local idx = type(idx) == "number" and 999-idx or idx
	if self._NetData[2][idx] ~= nil and self._NetData[2][idx] == math.floor(value*500) then return end
	self:SetNW2Int(idx,math.floor(value*500))
end

function ENT:GetPackedRatio(idx)
	return self:GetNW2Int(idx)/500
end

--------------------------------------------------------------------------------
-- Sends and get bool via NWVars
--------------------------------------------------------------------------------
function ENT:SetPackedBool(idx,value)
	if self._NetData[1][idx] ~= nil and self._NetData[1][idx] == value then return end
	self:SetNW2Bool(idx,value)
end

function ENT:GetPackedBool(idx)
	return self:GetNW2Bool(idx)
end

ENT.SubwayTrain = nil