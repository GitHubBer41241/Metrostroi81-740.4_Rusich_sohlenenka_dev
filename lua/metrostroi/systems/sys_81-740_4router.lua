--отображение номера маршрута и конечной станции на табло
Metrostroi.DefineSystem("81_740_4router")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end
if CLIENT then	local function createFont(name,font,size,weight,blur,scanlines,underline)    surface.CreateFont("Metrostroi_740_"..name, {        font = font,        size = size,        weight = weight or 400,        blursize = blur or false,        antialias = false,        underline = underline,        italic = false,        strikeout = false,        symbol = false,        rotary = false,        shadow = false,        additive = false,        outline = false,        extended = true,        scanlines = scanlines or false,    })  end  createFont("router","Advanced LED Board-7",128,0,0,0,false)  --createFont("routerBold","Advanced LED Board-7",128,0,0,0,false)
	local function ShortingString(str)
		if utf8.len(str) <= 11 - 1 then return str end		if utf8.sub(str,10,10) == " " or utf8.sub(str,10,10) == "." then			return utf8.sub(str,1,10)		else			return utf8.sub(str,1,10).."."		end
	end
	local function GetLastStation(self)
		if not Metrostroi.StationConfigurations or not Metrostroi.ASNPSetup then
			return "ИСПЫТАНИЯ"
		else			if os.date( "%m-%d" ) == "04-01" then	
			if self.ASNPState < 7 then return "ИСПЫТ̶́А̵̢͍͖͕̹̥̫̃̒̌͝НИ̸̼̮̥͙͚̝̖̞̯̼̅͐̿Я̷̡̨̨̬̥̖̪̻̩̝̣̝̙͆́̃̃͂̓̄͛ͅͅ" end			else			if self.ASNPState < 7 then return "ИСПЫТАНИЯ" end			end
			local Selected = Metrostroi.ASNPSetup[self:GetNW2Int("Announcer",0)] or nil
			local Line = Selected and Selected[self:GetNW2Int("ASNP:Line",0)] or nil
			local Path = self:GetNW2Bool("ASNP:Path",false)
			local Station = Line and (not Path and Line[self:GetNW2Int("ASNP:LastStation",0)] or Path and Line[self:GetNW2Int("ASNP:FirstStation",0)]) or nil		--красивый враиант. Спереди показывается одна станция, сзади другая
			--local Station = Line and Line[self:GetNW2Int("ASNP:LastStation",0)] or nil		--вариант, как в реальности. То есть и спереди и сзади одна и та же станция
			if Station then Station = Station[2] or nil end
			--PrintTable(Station)
			if Line and not Station then Station = "МАРШРУТ" end
			if Station then return Station else return "ошибка?" end
		end
	end	
	function TRAIN_SYSTEM:ClientInitialize()
		local self = self.Train
		self.GettedLastStation = ""
		self.LastGettedLastStation = 0
		self.ASNPState = self:GetNW2Int("ASNP:State",-1)
		self.ButtonMap["InfoScreen"] = {
			pos = Vector(656.5-15,-35,61.4),
			ang = Angle(0,90,90),
			width = 700,
			height = 100,
			scale = 0.1,
		}	end	
	function TRAIN_SYSTEM:ClientDraw()
        --RunConsoleCommand("say", "ура работаёт")
		local self = self.Train
		if os.time() - self.LastGettedLastStation > 1 then
			self.LastGettedLastStation = os.time()
			self.ASNPState = self:GetNW2Int("ASNP:State",-1)
			self.GettedLastStation = ShortingString(GetLastStation(self)) --GetLastStation(self)
		end
		self:DrawOnPanel("InfoScreen",function()
			local rn = Format("%02d",self:GetNW2Int("ASNP:RouteNumber","00"))				--text		if self:GetNW2Int("740RouterPower") > 62 then 		    if self.ASNPState <= 0 then 				color = Color(47,85,16, 9)			else				color = Color(150,255,70)			end						if self.ASNPState < 2 and self.ASNPState > 0 then 				text = self.GettedLastStation 			end			if self.ASNPState > 2 then 				drawnrn = rn				text = self.GettedLastStation 								if self.GettedLastStation == "МАРШРУТ" then 					text = self.GettedLastStation.." "..rn					drawnrn = false				end			end			if drawnrn then
				draw.Text({
					text = drawnrn,
					font = "Metrostroi_740_router", -- "Metrostroi_740_routerBold"
					pos = { 50, 45 },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					color = color})				draw.Text({					text = text,					font = "Metrostroi_740_router",					pos = { 420, 45 },					xalign = TEXT_ALIGN_CENTER,					yalign = TEXT_ALIGN_CENTER,					color = color})			else				draw.Text({
					text = text,
					font = "Metrostroi_740_router",
					pos = { 350, 53 },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
					color = color})			end		end
		end)	end	else	function TRAIN_SYSTEM:Think(dT)		local Train = self.Train		Train:SetNW2Int("740RouterPower",Train.Electric.Battery80V)		endend