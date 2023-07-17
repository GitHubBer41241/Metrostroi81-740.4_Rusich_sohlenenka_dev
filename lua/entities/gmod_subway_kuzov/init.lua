local Map = game.GetMap():lower() or ""
if(Map:find("gm_metro_minsk") 
or Map:find("gm_metro_nsk_line")
or Map:find("gm_metro_kalinin")
or Map:find("gm_metro_krl")
or Map:find("gm_dnipro")
or Map:find("gm_bolshya_kolsewya_line")
or Map:find("gm_metrostroi_practice_d")
or Map:find("gm_metronvl")) then
	return
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SyncTable = {    "RearBrakeLineIsolation","RearTrainLineIsolation"}
 
function ENT:Initialize()
    self:SetModel("models/metrostroi_train/81-740/body/81-740_4_rear.mdl")
    self:SetPos(self:GetPos() + Vector(0,0,0))
	
    self.NormalMass = 10000		
	
    self.Joints = {}
    self.JointPositions = {}
    if self:GetModel() == "models/error.mdl" then
        self:SetModel("models/props_lab/reciever01a.mdl")
    end	
    if not self.NoPhysics then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
    else
        self:SetSolid(SOLID_VPHYSICS)
    end
    self:SetUseType(SIMPLE_USE)
    if CPPI and IsValid(self.Owner) then
        self:CPPISetOwner(self.Owner)
    end    
	
	self.InteractionZones = {	
        {
            ID = "RearBrakeLineIsolationToggle",
            Pos = Vector(-206-131,-25,-46), Radius = 31
        },
        {
            ID = "RearTrainLineIsolationToggle",
            Pos = Vector(-206-131,25,-46), Radius = 31
        },
        {
            ID = "RearDoor",
            Pos = Vector(-310, -13, 7), Radius = 31
        },
	} 

    -- Get default train mass
    if IsValid(self:GetPhysicsObject()) then
        self.NormalMass = self:GetPhysicsObject():GetMass()
    end	
	self.TrainEntities = {}	
	
end	
function ENT:OnRemove()
    -- Remove all linked objects
    constraint.RemoveAll(self)
    if self.TrainEntities then
        for k,v in pairs(self.TrainEntities) do
            SafeRemoveEntity(v)
        end
end	
end

-- Trigger output
function ENT:TriggerOutput(name,value)
    if Wire_TriggerOutput then
        Wire_TriggerOutput(self,name,tonumber(value) or 0)
    end
end

-- Trigger input
function ENT:TriggerInput(name, value)
    -- Drivers wrench present
    if name == "DriversWrenchPresent" then
        self.DriversWrenchPresent = (value > 0.5)
    end
end