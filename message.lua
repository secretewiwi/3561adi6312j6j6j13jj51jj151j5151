--//library\\--
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
--//Just ignore this\\--
local script_version_number = "v1"
local game_name = "Quarantine-z"

--//Variables\\--

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local Cameras = game:GetService("Workspace").Camera;
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldindex = gmt.__index

local _Character = getrenv()._G.Character;

local LeavesRemoverOn = false
local HomeRayOn = false
local ZoomOn = false
local AimbotOn = false
local HRTransp = 0.6

local fovcircle = Drawing.new("Circle")
fovcircle.Visible = false
fovcircle.Radius = 120
fovcircle.Color = Color3.fromRGB(255,255,255)
fovcircle.Thickness = 1
fovcircle.Filled = false
fovcircle.Transparency = 1

fovcircle.Position = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)

--Aim
getgenv()._Aimbot = {
    Enabled = false,
    AimSmooth = 1,
    X_Offset = 0,
    Y_Offset = 0
}

getgenv().ASSettings = {
    AimType = "To Cursor",
    AimDis = 300,
    AimSleepers = false,
    VisibleCheck = false
}
--All Global Settings
local AllSettings = {
    FovNow = 70
}
-- GetClosestPlayerToPlayer
function getClosestPlayerToPlayer()
    local closestPlayer = nil;
    local shortestDistance = ASSettings["AimDis"];
	for i, v in pairs(workspace:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name then
			if v.Humanoid.Health ~= 0 and v.PrimaryPart ~= nil and v:FindFirstChild("Head") then
				local pos = Cameras.WorldToViewportPoint(Cameras, v.PrimaryPart.Position)
				local magnitude = (_Character.character.Middle.Position - v.PrimaryPart.Position).magnitude
				local fovmagnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
				
				if magnitude < shortestDistance then
				    if fovmagnitude < 120 then
				        closestPlayer = v
					    shortestDistance = magnitude
				    end
				end
			end
		end
	end
	return closestPlayer
end
--

local Window = Library:CreateWindow({

    Title = '⚫ BlvckWare ⚫ ',
    Center = true, 
    AutoShow = true,
})


local Tabs = {
    Visuals = Window:AddTab('Visuals'), 
    Misc = Window:AddTab('Misc'),
    Combat = Window:AddTab('Combat'),
    Settings = Window:AddTab('Settings'),
}

local rightGroupBox = Tabs.Visuals:AddRightGroupbox('LocalPlayer')

local rightGroupBox2 = Tabs.Visuals:AddRightGroupbox('Arms')

local rightGroupBox3 = Tabs.Visuals:AddRightGroupbox('Guns')

--- 2 LeftGroupBox

local LeftGroupBox1 = Tabs.Visuals:AddLeftGroupbox('World')

LeftGroupBox1:AddToggle('Grass', {
    Text = 'Grass',
    Default = true, -- Default value (true / false)
    Tooltip = 'This is Turn ON / TURN OFF  GRASS', 
})


Toggles.Grass:OnChanged(function(GassTT)

    sethiddenprop(workspace.Terrain, "Decoration", GassTT)
end)


Toggles.Grass:SetValue(false)
---
LeftGroupBox1:AddToggle('Shadows', {
    Text = 'Shadows',
    Default = true, 
    Tooltip = 'This is turn off shadows', 
})

Toggles.Shadows:OnChanged(function(GlobalS)
    game:GetService("Lighting").GlobalShadows = GlobalS

end)


Toggles.Shadows:SetValue(false)

--
--LeftGroupBox1:AddToggle('NyanCatSky', {
  --  Text = 'NyanCatSky',
 --   Default = false, 
--    Tooltip = 'This is a NyanCatSky', 
--})
local true1 = false
local Socolo = Instance.new("Sky",game:GetService("Lighting"))

local LeavesRemover  = false
local MyButton = LeftGroupBox1:AddButton('Leavs', function()
    if LeavesRemover == false then
        LeavesRemover = true
        while LeavesRemover == true do
            for v, i in pairs(game:GetService("Workspace"):GetChildren()) do
                if i:FindFirstChild("Part") then
                    if i:FindFirstChild("top") then
                        i.top:Remove()
                    else
                        for x,b in pairs(i:GetChildren()) do
                            if b.ClassName == "MeshPart" and b.MeshId == "rbxassetid://743205322" then
                                b:Remove()
                            end
                        end
                    end
                end
            end
        wait(5)
        end
    else
        LeavesRemover = false
    end
end)






MyButton:AddTooltip('Leavs Remover')



Socolo.Name = "Custom Skybox"
LeftGroupBox1:AddDropdown('SkyC', {
    Values = { 'Default', 'Sponge Bob', 'Among Us', 'Amogus us 2',},
    Default = 1,
    Multi = false,

    Text = '',
    Tooltip = 'Sky Changer',
})

Options.SkyC:OnChanged(function(HOMO)
    if HOMO == "Default" then
        Socolo.SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex"
        Socolo.SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex"
        Socolo.SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex"
        Socolo.SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex"
        Socolo.SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex"
        Socolo.SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
    elseif HOMO == "Sponge Bob" then
        Socolo.SkyboxBk = "http://www.roblox.com/asset/?id=7633178166"
        Socolo.SkyboxDn = "http://www.roblox.com/asset/?id=7633178166"
        Socolo.SkyboxFt = "http://www.roblox.com/asset/?id=7633178166"
        Socolo.SkyboxLf = "http://www.roblox.com/asset/?id=7633178166"
        Socolo.SkyboxRt = "http://www.roblox.com/asset/?id=7633178166"
        Socolo.SkyboxUp = "http://www.roblox.com/asset/?id=7633178166"
    elseif HOMO == "Among Us" then
        Socolo.SkyboxBk = "rbxassetid://5752463190"
        Socolo.SkyboxDn = "rbxassetid://5872485020"
        Socolo.SkyboxFt = "rbxassetid://5752463190"
        Socolo.SkyboxLf = "rbxassetid://5752463190"
        Socolo.SkyboxRt = "rbxassetid://5752463190"
        Socolo.SkyboxUp = "rbxassetid://5752463190"

    

    end
end)

--LeftGroupBox1:AddLabel('This is a label')
--LeftGroupBox1:AddLabel('This is a label\n\nwhich wraps its text!', true)


---LeftGroupBox1:AddDivider()
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldindex = gmt.__index
local Cameras = game:GetService("Workspace").Camera
rightGroupBox:AddSlider('SPFVVV', { Text = 'Fov', Default = 70, Min = 0, Max = 120, Rounding = 1, Compact = false, }) 
Options.SPFVVV:OnChanged(function(t) 
    gmt.__index = newcclosure(function(self,b) 
        if b == "FieldOfView" then 
            return t 
        end 
            return oldindex(self,b) 
        end) 
end) 


Options.SPFVVV:SetValue(70)


--- Arms

local MyButton1 = rightGroupBox2:AddButton('Default Color', function(ARMC )
        game:GetService("Workspace").Ignore.FPSArms.RightUpperArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.RightLowerArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.RightHand.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftUpperArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftLowerArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftHand.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Handle.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Handle.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.USP.Handle.Color = ARMC 
end)

MyButton1:AddTooltip('Default Color')

rightGroupBox2:AddDropdown('GColorDrop3', { Values = { 'Default', 'Force Field', 'Neon' }, Default = 1, Multi = false, Text = 'Arms Materials', Tooltip = 'yup', })
        Options.GColorDrop3:OnChanged(function(ggggggg2) if ggggggg2 == "Default" then
            game:GetService("Workspace").Ignore.FPSArms.RightUpperArm.Material = Enum.Material.Plastic 
            game:GetService("Workspace").Ignore.FPSArms.RightLowerArm.Material = Enum.Material.Plastic 
            game:GetService("Workspace").Ignore.FPSArms.RightHand.Material = Enum.Material.Plastic 
            game:GetService("Workspace").Ignore.FPSArms.LeftUpperArm.Material = Enum.Material.Plastic 
            game:GetService("Workspace").Ignore.FPSArms.LeftLowerArm.Material = Enum.Material.Plastic 
            game:GetService("Workspace").Ignore.FPSArms.LeftHand.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Handle.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Handle.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.USP.Handle.Material = Enum.Material.Plastic 

        game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].Material = Enum.Material.Metal elseif ggggggg2 == "Force Field" then 
                
                game:GetService("Workspace").Ignore.FPSArms.RightUpperArm.Material = Enum.Material.ForceField 
                game:GetService("Workspace").Ignore.FPSArms.RightLowerArm.Material = Enum.Material.ForceField 
                game:GetService("Workspace").Ignore.FPSArms.RightHand.Material = Enum.Material.ForceField 
                game:GetService("Workspace").Ignore.FPSArms.LeftUpperArm.Material = Enum.Material.ForceField 
                game:GetService("Workspace").Ignore.FPSArms.LeftLowerArm.Material = Enum.Material.ForceField 
                game:GetService("Workspace").Ignore.FPSArms.LeftHand.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Handle.Material = Enum.Material.ForceField
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Handle.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.USP.Handle.Material = Enum.Material.ForceField 
            elseif ggggggg2 == "Neon" then
                game:GetService("Workspace").Ignore.FPSArms.RightUpperArm.Material = Enum.Material.Neon
                game:GetService("Workspace").Ignore.FPSArms.RightLowerArm.Material = Enum.Material.Neon
                game:GetService("Workspace").Ignore.FPSArms.RightHand.Material = Enum.Material.Neon
                game:GetService("Workspace").Ignore.FPSArms.LeftUpperArm.Material = Enum.Material.Neon 
                game:GetService("Workspace").Ignore.FPSArms.LeftLowerArm.Material = Enum.Material.Neon 
                game:GetService("Workspace").Ignore.FPSArms.LeftHand.Material = Enum.Material.Neon
                game:GetService("ReplicatedStorage").HandModels.HMAR.Handle.Material = Enum.Material.Neon
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Handle.Material = Enum.Material.Neon
                game:GetService("ReplicatedStorage").HandModels.USP.Handle.Material = Enum.Material.Neon
            end 
        end) 
   

rightGroupBox2:AddLabel('Arms Color'):AddColorPicker('ColorPicker2', {
    Default = Color3.new(0, 1, 0),
    Title = 'Arms color', 
})

Options.ColorPicker2:OnChanged(function(ARMC)
        game:GetService("Workspace").Ignore.FPSArms.RightUpperArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.RightLowerArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.RightHand.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftUpperArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftLowerArm.Color = ARMC 
        game:GetService("Workspace").Ignore.FPSArms.LeftHand.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Handle.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Handle.Color = ARMC 
        game:GetService("ReplicatedStorage").HandModels.USP.Handle.Color = ARMC 
end)

Options.ColorPicker2:SetValueRGB(Color3.fromRGB(255,255,255))
--ColorArms:AddTooltip('Default')
--guns
rightGroupBox3:AddButton('Default Color', function() 
        -----HMAR 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Barrel.BrickColor = BrickColor.new("Dark grey") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Body.BrickColor = BrickColor.new("Dark stone grey") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Bolt.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Stock.BrickColor = BrickColor.new("Bronze") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Grip.BrickColor = BrickColor.new("Bronze") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Mag.BrickColor = BrickColor.new("Dark stone grey") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.Muzzle.BrickColor = BrickColor.new("Bronze") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.ADS.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.Union.BrickColor = BrickColor.new("Medium stonne grey") 
        -----PipeSMG 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.ADS.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.Union.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Mag.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Flap.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Muzzle.BrickColor = BrickColor.new("Medium stonne grey")
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Body.BrickColor = BrickColor.new("Dark stone grey") 
        game:GetService("ReplicatedStorage").HandModels.PipeSMG.Bolt.BrickColor = BrickColor.new("Medium stonne grey") 
        -----USP 
        game:GetService("ReplicatedStorage").HandModels.USP.IronSights.ADS.BrickColor = BrickColor.new("Lime green") 
        game:GetService("ReplicatedStorage").HandModels.USP.IronSights.Union.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.USP.Muzzle.BrickColor = BrickColor.new("Medium stone grey") 
        game:GetService("ReplicatedStorage").HandModels.USP.Mag.BrickColor = BrickColor.new("Medium stonne grey") 
        game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Slide"].BrickColor = BrickColor.new("Sliver flip/flop") 
        game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].BrickColor = BrickColor.new("Dark stone grey") end) 


rightGroupBox3:AddDropdown('GColorDrop', { Values = { 'Default', 'Force Field', 'Neon' }, Default = 1, Multi = false, Text = 'Guns Materials', Tooltip = 'yup', })
        Options.GColorDrop:OnChanged(function(ggggggg1) if ggggggg1 == "Default" then
            -----HMAR 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Barrel.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Body.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Bolt.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Stock.Material = Enum.Material.Wood 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Grip.Material = Enum.Material.Wood 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Mag.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Muzzle.Material = Enum.Material.Wood 
            game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.ADS.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.Union.Material = Enum.Material.Metal 
            -----PipeSMG 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.ADS.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.Union.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Mag.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Flap.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Muzzle.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Body.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Bolt.Material = Enum.Material.Metal 
            -----USP 
            game:GetService("ReplicatedStorage").HandModels.USP.IronSights.ADS.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.USP.IronSights.Union.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.USP.Muzzle.Material = Enum.Material.Plastic 
            game:GetService("ReplicatedStorage").HandModels.USP.Mag.Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Slide"].Material = Enum.Material.Metal 
            game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].Material = Enum.Material.Metal elseif ggggggg1 == "Force Field" then 
                -----HMAR 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Barrel.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Body.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Bolt.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Stock.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Grip.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Mag.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Muzzle.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.ADS.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.Union.Material = Enum.Material.ForceField 
                -----PipeSMG 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.ADS.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.Union.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Mag.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Flap.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Muzzle.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Body.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Bolt.Material = Enum.Material.ForceField 
                -----USP 
                game:GetService("ReplicatedStorage").HandModels.USP.IronSights.ADS.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.USP.IronSights.Union.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.USP.Muzzle.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.USP.Mag.Material = Enum.Material.ForceField 
                game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Slide"].Material = Enum.Material.ForceField
                game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].Material = Enum.Material.ForceField 
            elseif ggggggg1 == "Neon" then
                -----HMAR 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Barrel.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Body.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Bolt.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Stock.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Grip.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Mag.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.Muzzle.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.ADS.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.Union.Material = Enum.Material.Neon 
                -----PipeSMG 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.ADS.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.Union.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Mag.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Flap.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Muzzle.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Body.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.PipeSMG.Bolt.Material = Enum.Material.Neon 
                -----USP game:GetService("ReplicatedStorage").HandModels.USP.IronSights.ADS.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.USP.IronSights.Union.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.USP.Muzzle.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.USP.Mag.Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Slide"].Material = Enum.Material.Neon 
                game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].Material = Enum.Material.Neon 
            end 
        end) 

Options.GColorDrop:SetValue('Default')

rightGroupBox3:AddLabel('Guns Color'):AddColorPicker('ColorPicker4', {
    Default = Color3.new(0, 1, 0),
    Title = 'Guns color', 
})

Options.ColorPicker4:OnChanged(function(GCS)
            game:GetService("ReplicatedStorage").HandModels.HMAR.Barrel.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Body.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Bolt.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Stock.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Grip.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Mag.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.Muzzle.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.ADS.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.HMAR.IronSights.Union.Color = GCS 
            -----PipeSMG 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.ADS.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.IronSights.Union.Color = GCS
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Mag.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Flap.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Muzzle.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Body.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.PipeSMG.Bolt.Color = GCS 
            -----USP 
            game:GetService("ReplicatedStorage").HandModels.USP.IronSights.ADS.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.USP.IronSights.Union.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.USP.Muzzle.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.USP.Mag.Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Slide"].Color = GCS 
            game:GetService("ReplicatedStorage").HandModels.USP["Meshes/USP_Body"].Color = GCS 
end)

Options.ColorPicker4:SetValueRGB(Color3.fromRGB(255, 255, 255))

---left esp
local LeftGroupBox2 = Tabs.Visuals:AddLeftGroupbox('ESP')



local gui1 = Instance.new("BillboardGui")
local esp1 = Instance.new("TextLabel",gui1)                                                                   
            
            

gui1.Name = "nothing dont ban me please"; 
gui1.ResetOnSpawn = false
gui1.AlwaysOnTop = true;
gui1.LightInfluence = 0;
gui1.Size = UDim2.new(1.75, 0, 1.75, 0);
esp1.BackgroundColor3 = Color3.fromRGB(1, 0.682353, 0.862745);
esp1.Text = ""
esp1.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
esp1.BorderSizePixel = 4;
esp1.BorderColor3 = Color3.new(1, 0.682353, 0.862745)
esp1.BorderSizePixel = 1
esp1.Font = "GothamSemibold"
esp1.TextSize = 10
esp1.TextColor3 = Color3.new(1, 0.682353, 0.862745)



LeftGroupBox2:AddToggle('ESPPL', {
    Text = 'ESP CHAMSE|NAME',
    Default = false, 
    Tooltip = 'This is a ESP', 
})

local Highlight = Instance.new("Highlight")
Highlight.FillColor = Color3.fromRGB(255,255,255)
Highlight.OutlineColor = Color3.fromRGB(255,255,255)

local b = Instance.new("Highlight")
Toggles.ESPPL:OnChanged(function()
    if Toggles.ESPPL.Value == true then
        while true do
        
            for v,i in pairs(workspace:GetChildren()) do
	            if i:FindFirstChild("Humanoid") and  i:FindFirstChild("HumanoidRootPart") and i.Head:FindFirstChild("Nametag") then
		            if i.Head.Nametag.tag.Text == "Shylou2644" then
			            
		        else	
		            if i.Head:FindFirstChild("nothing dont ban me please") and i:FindFirstChild("Chamse") then
                        
			        else
				        
				        esp1.TextColor3 = Color3.new(1, 0.682353, 0.862745)
				        esp1.Text = ""..i.Head.Nametag.tag.Text..""
				        gui1:Clone().Parent = i.Head
				        
                        
                        b.Adornee = a
                        b.Name = "Chamse"
                        b.FillColor = Color3.fromRGB(128, 187, 219)
                        b.FillTransparency = 0.6
                        b.OutlineColor = Color3.fromRGB(13, 105, 172)
                        b:Clone().Parent = i
                        
		            end
		      end
             
	        end
	   end
	     wait(1)
    end
	   
    
        
    elseif Toggles.ESPPL.Value == false then
    
        for v,i in pairs(workspace:GetChildren()) do
            if i:FindFirstChild("Humanoid") and  i:FindFirstChild("HumanoidRootPart") and i.Head:FindFirstChild("Nametag") then
                if i.Head:FindFirstChild("nothing dont ban me please") and i:FindFirstChild("Highlight") then
                    i.Head["nothing dont ban me please"]:Destroy()
                    i.Highlight:Destroy()
                    
                    
                end
            end
        end

	end
end)


Toggles.ESPPL:SetValue(false)

	
LeftGroupBox2:AddToggle('EspIron', {
    Text = 'ESP IRON',
    Default = false,
    Tooltip = 'EspIron', 
})

local esp_settings = { 
		textsize = 10,
		colour = 1,1,1
	}
local gui = Instance.new("BillboardGui")
local esp = Instance.new("TextLabel",gui) 
    


gui.Name = "BillboardGui"; 
gui.ResetOnSpawn = false
gui.AlwaysOnTop = true;
gui.LightInfluence = 0;
gui.Size = UDim2.new(1.75, 0, 1.75, 0);
esp.BackgroundColor3 = Color3.fromRGB(255,255,255);
esp.Text = ""
esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
esp.BorderSizePixel = 4;
esp.BorderColor3 = Color3.new(esp_settings.colour)
esp.BorderSizePixel = 0
esp.Font = "GothamSemibold"
esp.TextSize = esp_settings.textsize
esp.TextColor3 = Color3.new(255,255,255)
local Highlight1 = Instance.new("Highlight")
Toggles.EspIron:OnChanged(function()
    if Toggles.EspIron.Value == true then
        
        Highlight1.FillColor = Color3.fromRGB(255,255,0)
        Highlight1.OutlineColor = Color3.fromRGB(255,255,0)

      while Toggles.EspIron.Value == true do
        for _,v in pairs(workspace:GetChildren()) do
          if v:FindFirstChild("Part")  and v.Part.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then

            v.Part.Name = "Rock"
            if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Burlap") and  v:FindFirstChild("Part")then
              if v:FindFirstChild("Highlight") and v.Part:FindFirstChild("BillboardGui") then


              else

                print("founded iron")
                Highlight1:Clone().Parent = v
                esp.Text = "I"
                gui:Clone().Parent = v.Part

                --wait(600)
                --game:GetService("Players").LocalPlayer:Kick("ITS NOT MAIN SCRIPT, COME HERE - https://discord.gg/hDmEwnzySP")
                --game.Players.LocalPlayer.PlayerGui
              end
            end
          else
            if v:FindFirstChild("Rock")  and v.Rock.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then
              if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Burlap") then
                if v:FindFirstChild("Highlight") and v.Part:FindFirstChild("BillboardGui") then

                else



                  print("Esp Ore is turn on")

                  esp.Text = "I"
                  gui:Clone().Parent = v.Part
                  Highlight1:Clone().Parent = v
                  --wait(600)
                  --game:GetService("Players").LocalPlayer:Kick("ITS NOT MAIN SCRIPT, COME HERE - https://discord.gg/hDmEwnzySP")

                end
              end
            end

          end

        end
        wait(1)
      end
    else
      for i, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("Rock")  and v.Rock.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then
          if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Burlap") and v.Part:FindFirstChild("BillboardGui")  then
            v.Part.BillboardGui:Destroy()
            v.Highlight:Destroy()

            print("Esp ore is off")
          end



        end

      end
    end
    end)



Toggles.EspIron:SetValue(false)

LeftGroupBox2:AddToggle('espnitr', {
    Text = 'ESP NITRATE',
    Default = false, -- Default value (true / false)
    Tooltip = 'ESP NITRATE', 
})
local Highlight1 = Instance.new("Highlight")
Highlight1.FillColor = Color3.fromRGB(255,255,255)
Highlight1.OutlineColor = Color3.fromRGB(255,255,255)
Toggles.espnitr:OnChanged(function()
if Toggles.espnitr.Value == true then
    while Toggles.espnitr.Value == true do
		for _,v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("Part")  and v.Part.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then

				v.Part.Name = "Rock"
                if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Institutional white") and  v:FindFirstChild("Part")then
				    if v:FindFirstChild("Highlight") and v.Part:FindFirstChild("BillboardGui") then
				        
				        
				    else
				        
                     print("founded nitranite")
                    Highlight:Clone().Parent = v
					esp.Text = "N"
					gui:Clone().Parent = v.Part

					--wait(600)
					--game:GetService("Players").LocalPlayer:Kick("ITS NOT MAIN SCRIPT, COME HERE - https://discord.gg/hDmEwnzySP")
					--game.Players.LocalPlayer.PlayerGui
					end
				end
			else
				if v:FindFirstChild("Rock")  and v.Rock.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then
				    if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Institutional white") then
                        if v:FindFirstChild("Highlight") and v.Part:FindFirstChild("BillboardGui") then
                            
                        else
			
                            print("Esp Ore is turn on")
                        
						    esp.Text = "N"
						    gui:Clone().Parent = v.Part
						    Highlight:Clone().Parent = v
						        --wait(600)
						        --game:GetService("Players").LocalPlayer:Kick("ITS NOT MAIN SCRIPT, COME HERE - https://discord.gg/hDmEwnzySP")
						
						end
                    end
				end

			end

		end
	wait(1)
	end
	else
		for i, v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("Rock")  and v.Rock.BrickColor == BrickColor.new("Mid gray") and v:FindFirstChild("Part") then 
				if v:FindFirstChild("Part") and v.Part.BrickColor == BrickColor.new("Institutional white") and v.Part:FindFirstChild("BillboardGui")  then
					v.Part.BillboardGui:Destroy()
					v.Highlight:Destroy()

					print("Esp ore is off")
				end    



			end

		end
end 
end)
--

local zoomvalue = 5


local ArmSector = Tabs.Misc:AddLeftGroupbox("ZoomX_x")
ArmSector:AddLabel('Zoom'):AddKeyPicker('ZoomPick', {
    Default = 'X', 
    SyncToggleState = false, 
    Mode = 'Toggle',
    Text = 'Zoom',
    NoUI = false,
})

Options.ZoomPick:OnClick(function()
    if ZoomOn == false then
        ZoomOn = true
        gmt.__index = newcclosure(function(self,b)
            if b == "FieldOfView" then
                return zoomvalue
            end
                return oldindex(self,b)
            end)
    else
        ZoomOn = false
        gmt.__index = newcclosure(function(self,b)
            if b == "FieldOfView" then
                return 70
            end
                return oldindex(self,b)
        end)
    end
end)

ArmSector:AddSlider('ZoomSlider', { Text = 'ZoomSlider', Default = 5, Min = 0, Max = 60, Rounding = 1, Compact = false, }) 
Options.ZoomSlider:OnChanged(function(t) 
     zoomvalue= t
end) 


Options.ZoomSlider:SetValue(0.7)
--

Toggles.espnitr:SetValue(false)

LeftGroupBox2:AddToggle('EspStone', {
    Text = 'EspStone',
    Default = false, -- Default value (true / false)
    Tooltip = 'EspStone', 
})


Toggles.EspStone:OnChanged(function()
    if Toggles.EspStone.Value == true then
        print(1)
        
        
    else
        print(2)
    end
end)

---Misc
Toggles.EspStone:SetValue(false)
---Gun MOode
local LeftGunMode = Tabs.Misc:AddLeftGroupbox('Gun Moods')

local PipePistolDerect = require(game.ReplicatedStorage.ItemConfigs.PipePistol)
local PipeSMGDerect = require(game.ReplicatedStorage.ItemConfigs.PipeSMG)
local USPDerect = require(game.ReplicatedStorage.ItemConfigs.USP)
local HMARDerect = require(game.ReplicatedStorage.ItemConfigs.HMAR)
local CrossbowDerect = require(game.ReplicatedStorage.ItemConfigs.Crossbow)
local BowDerect = require(game.ReplicatedStorage.ItemConfigs.Bow)
local BlunderbussDerect = require(game.ReplicatedStorage.ItemConfigs.Blunderbuss)
local BowDerect = require(game.ReplicatedStorage.ItemConfigs.Bow)
local DerectCrossbow = require(game.ReplicatedStorage.ItemConfigs.Crossbow)

LeftGunMode:AddToggle('NoS', { Text = 'No Scatter', Default = false, Tooltip = '', }) 
    Toggles.NoS:OnChanged(function(NoSCA) if NoSCA == true then 
        PipePistolDerect.accuracy = 10000 
        PipeSMGDerect.accuracy = 10000 
        USPDerect.accuracy = 100000 
        HMARDerect.accuracy = 70000 
    elseif NoSCA == false then 
        PipePistolDerect.accuracy = 5000 
        PipeSMGDerect.accuracy = 5000 
        USPDerect.accuracy = 4000 
        HMARDerect.accuracy = 7000 
    end 
end) 


LeftGunMode:AddToggle('EOKA', {
    Text = 'EOKA Pistol Op',
    Default = false,
    Tooltip = 'Fast fire in Pistol', 
})


Toggles.EOKA:OnChanged(function()
    if Toggles.EOKA.Value == true then
        BlunderbussDerect.accuracy = 999999999
        BlunderbussDerect.recoilPattern = { { 0, 0 } }
	elseif Toggles.EOKA.Value == false then 
        BlunderbussDerect.accuracy = 1200
        BlunderbussDerect.recoilPattern = { { 0, 2 } }
	end
end)

LeftGunMode:AddToggle('NoRecoil', {
    Text = 'NoRecoil',
    Default = false, 
    Tooltip = 'NoRecoil - not be shaked', 
})

Toggles.NoRecoil:OnChanged(function(NRe)
    if Toggles.NoRecoil.Value == true then
		PipePistolDerect.recoilPattern = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
		PipeSMGDerect.recoilPattern = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
		USPDerect.recoilPattern ={ { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
		HMARDerect.recoilPattern = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
		USPDerect.anims.fire = ""
		BowDerect.recoilPattern = { { 0, 0 } } 
		DerectCrossbow.recoilPattern = { { 0, 0 } }
	elseif Toggles.NoRecoil.Value == false then
		PipePistolDerect.recoilPattern = { { 0, 1 }, { 0, 1 }, { 1, 1 }, { 1, 1 }, { 2, 1 }, { 2, 1 }, { 2, 1 }, { 1, 1 }, { -1, 1 }, { -1, 1 }, { -1, 1 }, { -2, 1 }, { -2, 1 }, { -1, 1 }, { 0, 1 }, { 0, 1 } }
		PipeSMGDerect.recoilPattern = { { 0, 0.75 }, { 0.5, 0.75 }, { 0.5, 0.75 }, { -0.5, 0.75 }, { -0.5, 0.75 }, { -0.5, 0.75 }, { 0.3, 0.75 }, { 0.3, 0.75 }, { -0.3, 0.6 }, { -0.3, 0.6 }, { 0.5, 0.6 }, { -0.5, 0.4 }, { -0.5, 0.3 }, { -1, 0.15 }, { -1, 0.05 }, { -1, 0.02 }, { -1, 0.02 }, { -1, 0.02 }, { -1, 0.02 }, { -0.4, 0.1 }, { 0, 0.05 }, { 0, 0.02 }, { 0.1, 0.02 }, { 0.2, 0.02 }, { 0.4, 0.02 }, { 0.5, 0.02 } }
		USPDerect.recoilPattern = { { 0, 1 }, { 0, 1 }, { 1, 1 }, { 1, 1 }, { 2, 1 }, { 2, 1 }, { 2, 1 }, { 1, 1 }, { -1, 1 }, { -1, 1 }, { -1, 1 }, { -2, 1 }, { -2, 1 }, { -1, 1 }, { 0, 1 }, { 0, 1 } }
		BowDerect.recoilPattern = { { 0, 1 } }
		DerectCrossbow.recoilPattern = { { 0, 1 } }
		HMARDerect.recoilPattern = { { 0, 0.75 }, { 0.5, 0.75 }, { 0.5, 0.75 }, { -0.5, 0.75 }, { -0.5, 0.75 }, { -0.5, 0.75 }, { 0.3, 0.75 }, { 0.3, 0.75 }, { -0.3, 0.6 }, { -0.3, 0.6 }, { 0.5, 0.6 }, { -0.5, 0.4 }, { -0.5, 0.3 }, { -1, 0.15 }, { -1, 0.05 }, { -1, 0.02 }, { -1, 0.02 }, { -1, 0.02 }, { -1, 0.02 }, { -0.4, 0.1 }, { 0, 0.05 }, { 0, 0.02 }, { 0.1, 0.02 }, { 0.2, 0.02 }, { 0.4, 0.02 }, { 0.5, 0.02 } }
	end
end)
local WallHackOn = false
---X-RAY
local LeftXray = Tabs.Misc:AddLeftGroupbox('X-RAY')
LeftXray:AddLabel('X-Ray'):AddKeyPicker('XRKB', { Default = 'T', SyncToggleState = false, Mode = 'Toggle', Text = 'X-Ray Enabled', NoUI = false, }) 
        Options.XRKB:OnClick(function() 
            if WallHackOn == false 
            then WallHackOn = true 
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
                    if v:FindFirstChild("Hitbox") then 
                        v.Hitbox.Transparency = XRTransparency 
                    end 
                end 
            else 
                WallHackOn = false 
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
                    if v:FindFirstChild("Hitbox") then 
                        v.Hitbox.Transparency = 0
                    end 
                end 
            end 
        end) 

LeftXray:AddSlider('XRTransparency', { Text = 'X-RAY Transparency', Default = 0.7, Min = 0, Max = 1, Rounding = 1, Compact = false, }) 
Options.XRTransparency:OnChanged(function(t) 
    XRTransparency = t
end) 


Options.XRTransparency:SetValue(0.7)
--TAKE ALL

local LeftGive = Tabs.Misc:AddLeftGroupbox('Give')
LeftGive:AddLabel('GiveALL'):AddKeyPicker('Give', { Default = 'Y', SyncToggleState = false, Mode = 'Toggle', Text = 'GiveALL', NoUI = false, }) 
    Options.Give:OnClick(function() 
    game:GetService("ReplicatedStorage").e:FireServer(106, 1,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 2,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 3,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 4,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 5,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 6,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 7,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 8,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 9,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 10,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 11,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 12,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 13,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 14,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 15,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 16,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 17,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 18,true)
    game:GetService("ReplicatedStorage").e:FireServer(106, 19,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 20,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 21,true)
	game:GetService("ReplicatedStorage").e:FireServer(106, 22,true)
end) 






Library:SetWatermarkVisibility(true)
---sounds

local CustomHitsoundsTabBox = Tabs.Misc:AddRightTabbox('Custom Hitsounds')
        local CustomHitsoundsTab = CustomHitsoundsTabBox:AddTab('Custom Hitsounds')

        CustomHitsoundsTab:AddToggle('Custom_Hitsounds', {Text = 'Toggle', Default = false, Tooltip = nil, })
        CustomHitsoundsTab:AddDropdown('Custom_Hitsounds', {Values = { 'Head', 'HumanoidRootPart', 'All' }, Default = 3, Multi = false, Text = 'Hitsound Part'})
        CustomHitsoundsTab:AddDropdown('HitSoundssss', {
          Values = { 'Default', 'Gamesense', 'Rust', 'HZ','Bruh', 'Minecraft', 'TF2', 'Osu', 'Weeb' },
          Default = 1,
          Multi = false,

          Text = 'Hit Sound',
          Tooltip = 'This is a tooltip',
        })

        Options.HitSoundssss:OnChanged(function(Suuu)
        if Suuu == "Default" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://9114487369")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Gamesense" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://4817809188")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Rust" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://1255040462")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "HZ" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://705502934")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Bruh" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://4275842574")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Minecraft" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://4018616850")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "TF2" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://2868331684")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Osu" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://7149255551")
          game:GetService("SoundService").PlayerHit2.Playing = true
        elseif Suuu == "Weeb" then
          game:GetService("SoundService").PlayerHit2.SoundId = ("rbxassetid://6442965016")
          game:GetService("SoundService").PlayerHit2.Playing = true
        end
        end)
        CustomHitsoundsTab:AddSlider('Custom_Hitsounds', {Text = 'Volume',Default = 10, Min = 0, Max = 100, Rounding = 1,Compact = false,})
        Options.Custom_Hitsounds:OnChanged(function(t) 
            game:GetService("SoundService").PlayerHit2.Volume = t
        end) 
        CustomHitsoundsTab:AddSlider('Custom_Hitsounds', {Text = 'Pitch',Default = 1, Min = 0.1, Max = 10, Rounding = 1,Compact = false,})
        Options.Custom_Hitsounds:OnChanged(function(t) 
            game:GetService("SoundService").PlayerHit2.Pitch = t 
        end) 
-- Sets the watermark text



-------6
local AimlockSector = Tabs.Combat:AddLeftGroupbox('Aimlock')
AimlockSector:AddLabel('Keybind'):AddKeyPicker('AIMKBK', {
    Default = 'V', 
    SyncToggleState = false, 
    Mode = 'Toggle',
    Text = 'Aimlock',
    NoUI = false,
})
Options.AIMKBK:OnClick(function(Value)
    local Target;
	if AimbotOn == false then
        AimbotOn = true
		while AimbotOn == true do
			Target = getClosestPlayerToPlayer();
			if Target then
				local Head = Target:FindFirstChild("Head");
				if Head then
					local pos, _ = Cameras:WorldToScreenPoint(Head.Position)
					mousemoverel((pos.X - (Mouse.X))/_Aimbot["AimSmooth"], (pos.Y - (Mouse.Y))/_Aimbot["AimSmooth"])
				end
			end
			wait(0.01)
		end
	else
		AimbotOn = false
	end
end)

AimlockSector:AddToggle('vftt', {
    Text = 'Visible Fov',
    Default = false,
    Tooltip = 'Off/On Visible Fov',
})
Toggles.vftt:OnChanged(function(J)
    fovcircle.Visible = J
end)


AimlockSector:AddLabel('Color'):AddColorPicker('CCFF', {
    Default = Color3.new(1, 0, 0),
    Title = 'Fov Color',
})
Options.CCFF:OnChanged(function(KKK)
   fovcircle.Color = KKK
end)

AimlockSector:AddSlider('ADSSS', {
    Text = 'Aim ditance',
    Default = 650,
    Min = 300,
    Max = 1200,
    Rounding = 0,
    Compact = false,
})
Options.ADSSS:OnChanged(function(t)
    ASSettings["AimDis"] = t
end)

AimlockSector:AddSlider('frsss', {
    Text = 'Fov radius',
    Default = 70,
    Min = 0,
    Max = 600,
    Rounding = 0,
    Compact = false,
})
Options.frsss:OnChanged(function(t)
    fovcircle.Radius = t
end)

AimlockSector:AddSlider('ASSSS', {
    Text = 'Aim Smoothnes',
    Default = 20,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
})
Options.ASSSS:OnChanged(function(t)
    _Aimbot["AimSmooth"] = t/10
end)
--aimbot
Library:SetWatermark('⚫ BlvckWare ⚫ | ".. game_name .." | ".. script_version_number .." ')

Library.KeybindFrame.Visible = true; 

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

local MenuGroup = Tabs['Settings']:AddLeftGroupbox('Menu')


MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind


ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)


SaveManager:IgnoreThemeSettings() 


SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 


ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')


SaveManager:BuildConfigSection(Tabs['Settings']) 


ThemeManager:ApplyToTab(Tabs['Settings'])
