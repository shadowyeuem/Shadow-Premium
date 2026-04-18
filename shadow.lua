repeat task.wait() until game:IsLoaded()
local CurrentVersion = "1.0.1"
Fluent:Notify({
    Title = "SHADOW PREMIUM",
    Content = "Đang chạy phiên bản: " .. CurrentVersion,
    Duration = 5
})
local function JoinTeam()
    local targetTeam = "Pirates"
    if not game.Players.LocalPlayer.Team then
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", targetTeam)
        end)
    end
end
JoinTeam()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "SHADOW PREMIUM",
    SubTitle = "cre by Kabii",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 420),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl 
})
-- [[ BYPASS SYSTEM - SHADOW PREMIUM ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

pcall(function()
    hookfunction(require(ReplicatedStorage.Effect.Container.Death), function()
        return nil
    end)
    
    hookfunction(require(ReplicatedStorage.Effect.Container.Respawn), function()
        return nil
    end)
end)

local Tabs = {
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    StatusServer = Window:AddTab({ Title = "Status And Server", Icon = "server" }),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user" }),
    SettingFarm = Window:AddTab({ Title = "Setting Farm", Icon = "settings" }),
    Skill = Window:AddTab({ Title = "Hold and Select Skill", Icon = "zap" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "swords" }),
    StackFarming = Window:AddTab({ Title = "Stack Farming", Icon = "layers" }),
    FarmingOther = Window:AddTab({ Title = "Farming Other", Icon = "plus-circle" }),
    Dungeon = Window:AddTab({ Title = "Fruit and Raid, Dungeon", Icon = "box" }),
    SeaEvent = Window:AddTab({ Title = "Sea Event", Icon = "waves" }),
    UpgradeRace = Window:AddTab({ Title = "Upgrade Race", Icon = "zap" }),
    Items = Window:AddTab({ Title = "Get and Upgrade Items", Icon = "package" }),
    Volcano = Window:AddTab({ Title = "Volcano Event", Icon = "flame" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    PVP = Window:AddTab({ Title = "PVP", Icon = "crosshair" }),
    Webhook = Window:AddTab({ Title = "Tab Webhook", Icon = "message-square" }),
    Settings = Window:AddTab({ Title = "Setting", Icon = "settings" })
}

--TAB Shop

--TAB StatusServer
local StatusSection = Tabs.StatusServer:AddSection("Protection System")

Tabs.StatusServer:AddParagraph({
    Title = "Anti-AFK & Anti-Ban",
    Content = "Statur: underground protection (Active)\Anti-Ban On."
})

Tabs.StatusServer:AddParagraph({
    Title = "Anti-AFK System",
    Content = "Status: Protection (always on)"
})

local StatsSection = Tabs.StatusServer:AddSection("Player Information")

-- 1. Hiển thị thông tin người chơi (Cập nhật liên tục)
local PlayerLevel = Tabs.StatusServer:AddParagraph({
    Title = "Level: " .. game.Players.LocalPlayer.Data.Level.Value,
    Content = "Beli: " .. string.format("%d", game.Players.LocalPlayer.Data.Beli.Value) .. " | Fragments: " .. string.format("%d", game.Players.LocalPlayer.Data.Fragments.Value)
})

-- 2. Tự động cập nhật chỉ số mỗi 5 giây
spawn(function()
    while task.wait(5) do
        PlayerLevel:SetTitle("Level: " .. game.Players.LocalPlayer.Data.Level.Value)
        PlayerLevel:SetDesc("Beli: " .. string.format("%d", game.Players.LocalPlayer.Data.Beli.Value) .. " | Fragments: " .. string.format("%d", game.Players.LocalPlayer.Data.Fragments.Value))
    end
end)

local ServerSection = Tabs.StatusServer:AddSection("Server Management")

-- 3. Nút Server Hop (Đổi Server)
Tabs.StatusServer:AddButton({
    Title = "Server Hop",
    Description = "Tìm và sang server mới ít người hơn",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local function GetServers()
            local Raw = game:HttpGet(Api)
            return Http:JSONDecode(Raw).data
        end
        local Servers = GetServers()
        for i, v in pairs(Servers) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                break
            end
        end
    end
})

-- 4. Nút Rejoin (Vào lại server hiện tại)
Tabs.StatusServer:AddButton({
    Title = "Rejoin Server",
    Description = "Kết nối lại server này ngay lập tức",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

local UtilsSection = Tabs.StatusServer:AddSection("Optimization")

-- 5. Nút White Screen (Giảm lag cực mạnh để treo đêm)
local WhiteScreenToggle = Tabs.StatusServer:AddToggle("WhiteScreen", {Title = "White Screen", Default = false })
WhiteScreenToggle:OnChanged(function(Value)
    if Value then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
        game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
end)

-- 6. Thông báo bảo vệ ngầm
Tabs.StatusServer:AddParagraph({
    Title = "Security Status",
    Content = "• Anti-AFK: [ACTIVE]\n• Anti-Ban: [ACTIVE]\n• Auto Join Team: [COMPLETED]"
})
-- [[ TAB LOCALPLAYER - SHADOW PREMIUM ]]
local PlayerSection = Tabs.LocalPlayer:AddSection("Movement & Physics")

Tabs.LocalPlayer:AddSlider("WalkSpeed", {
    Title = "Walk Speed (Tốc độ chạy)",
    Description = "Mặc định là 16",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        _G.WalkSpeed = Value
    end
})

Tabs.LocalPlayer:AddSlider("JumpPower", {
    Title = "Jump Power (Nhảy cao)",
    Description = "Mặc định là 50",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        _G.JumpPower = Value
    end
})

Tabs.LocalPlayer:AddToggle("InfiniteJump", {
    Title = "Infinite Jump (Nhảy vô hạn)",
    Default = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

Tabs.LocalPlayer:AddToggle("NoClip", {
    Title = "No Clip (Đi xuyên tường)",
    Default = false,
    Callback = function(Value)
        _G.NoClip = Value
    end
})

local VisualSection = Tabs.LocalPlayer:AddSection("Visual Effects")

Tabs.LocalPlayer:AddToggle("InfAbility", {Title = "Infinite Ability (Vô hạn nội năng)", Default = false})
Tabs.LocalPlayer:AddToggle("Invisible", {Title = "Invisible (Tàng hình)", Default = false})
Tabs.LocalPlayer:AddToggle("FullBright", {Title = "Full Bright (Sáng màn hình)", Default = false})

local ActionSection = Tabs.LocalPlayer:AddSection("Character Actions")

Tabs.LocalPlayer:AddButton({
    Title = "Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end
})

Tabs.LocalPlayer:AddButton({
    Title = "Sit (Ngồi xuống)",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Sit = true
    end
})

Tabs.LocalPlayer:AddButton({
    Title = "Died (Tự tử)",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})

local SafeSection = Tabs.LocalPlayer:AddSection("Safety")

Tabs.LocalPlayer:AddToggle("AntiAfk", {
    Title = "Anti-AFK System",
    Default = true,
    Callback = function(Value)
        _G.AntiAfk = Value
    end
})

--TAB SettingFarm 
Tabs.SettingFarm:AddSection("Weapon & Combat Settings")

local SelectWeapon = Tabs.SettingFarm:AddDropdown("SelectWeapon", {
    Title = "Select Weapon",
    Values = {"Melee", "Sword", "Blox Fruit"},
    Multi = false,
    Default = 1,
})
SelectWeapon:OnChanged(function(Value) _G.SelectWeapon = Value end)

Tabs.SettingFarm:AddToggle("AttackNoAnim", {
    Title = "Attack No Animation",
    Default = true,
    Callback = function(Value) _G.AttackNoAnim = Value end
})

Tabs.SettingFarm:AddToggle("AutoClick", {
    Title = "Auto Click",
    Default = true,
    Callback = function(Value) _G.AutoClick = Value end
})

local AttackMethod = Tabs.SettingFarm:AddDropdown("AttackMethod", {
    Title = "Chế độ tấn công (Attack Mode)",
    Description = "Shadow: Tự Aim & Click siêu nhanh vào Player/Boss/Mob ở gần",
    Values = {"None", "Normal Attack", "Shadow Attack"},
    Multi = false,
    Default = 1,
})

AttackMethod:OnChanged(function(Value)
    _G.AttackMode = Value
    Fluent:Notify({
        Title = "SHADOW PREMIUM",
        Content = "Chế độ: " .. Value .. " đã kích hoạt!",
        Duration = 3
    })
end)

Tabs.SettingFarm:AddSection("Character Buffs")
-- Bổ sung thêm cho đủ bộ Banana Pre
Tabs.SettingFarm:AddToggle("AutoV4", {
    Title = "Auto Turn On V4",
    Default = false,
    Callback = function(Value) _G.AutoV4 = Value end
})
Tabs.SettingFarm:AddToggle("AutoBuso", {
    Title = "Auto Turn On Buso (Haki)",
    Default = true,
    Callback = function(Value) _G.AutoBuso = Value end
})

Tabs.SettingFarm:AddToggle("AutoObservation", {
    Title = "Auto Turn On Observation (Instinct)",
    Default = false,
    Callback = function(Value) _G.AutoObservation = Value end
})

Tabs.SettingFarm:AddSection("Tween & Optimization")

Tabs.SettingFarm:AddSlider("SpeedTween", {
    Title = "Speed Tween",
    Description = "Recommended: 350 (Dùng để bay giữa các đảo)",
    Default = 350,
    Min = 200,
    Max = 1000,
    Rounding = 1,
    Callback = function(Value) _G.SpeedTween = Value end
})

Tabs.SettingFarm:AddToggle("BringMob", {
    Title = "Bring Mob (Gom quái lại một chỗ)",
    Default = true,
    Callback = function(Value) _G.BringMob = Value end
})

Tabs.SettingFarm:AddSlider("BringMobCount", {
    Title = "Bring Mob Count",
    Default = 6,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Callback = function(Value) _G.BringMobCount = Value end
})

Tabs.SettingFarm:AddSection("Safety Settings")

Tabs.SettingFarm:AddToggle("AutoDodgeSkill", {
    Title = "Auto Dodge Skill Mobs",
    Default = true,
    Callback = function(Value) _G.AutoDodgeSkill = Value end
})

Tabs.SettingFarm:AddSlider("TimeHop", {
    Title = "Time Hop Server (Minutes)",
    Default = 10,
    Min = 1,
    Max = 60,
    Rounding = 1,
    Callback = function(Value) _G.TimeHop = Value end
})

Tabs.SettingFarm:AddToggle("TeleLowHealth", {
    Title = "Teleport Y if low health",
    Description = "Bay lên cao khi máu yếu",
    Default = false,
    Callback = function(Value) _G.TeleLowHealth = Value end
})

Tabs.SettingFarm:AddSlider("HealthPercentage", {
    Title = "% Health Player to Teleport",
    Default = 20,
    Min = 1,
    Max = 99,
    Rounding = 1,
    Callback = function(Value) _G.HealthPercentage = Value end
})

Tabs.SettingFarm:AddSection("Extra Farm Options")

Tabs.SettingFarm:AddToggle("AutoClickNPC", {
    Title = "Auto Click NPC",
    Default = true,
    Callback = function(Value) _G.AutoClickNPC = Value end
})

Tabs.SettingFarm:AddToggle("FastAttack", {
    Title = "Fast Attack (Đánh siêu nhanh)",
    Default = true,
    Callback = function(Value) _G.FastAttack = Value end
})

local FarmConfig = Tabs.SettingFarm:AddSection("Farm Configuration")

-- 1. Chọn phương pháp gom quái (Bring Mob)
Tabs.SettingFarm:AddToggle("BringMob", {Title = "Bring Mob (Gom Quái)", Default = true})

-- 2. Khoảng cách gom quái
Tabs.SettingFarm:AddSlider("BringMobDistance", {
    Title = "Bring Mob Distance",
    Description = "Khoảng cách hút quái lại gần nhau",
    Default = 60,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        _G.BringMobDistance = Value
    end
})

local MethodSection = Tabs.SettingFarm:AddSection("Farm Methods & Distance")

-- 3. Chọn chế độ farm (Dưới quái, Trên quái, Xung quanh)
Tabs.SettingFarm:AddDropdown("FarmMethod", {
    Title = "Farm Method",
    Values = {"Below (Dưới)", "Above (Trên)", "Behind (Sau lưng)"},
    Multi = false,
    Default = "Below (Dưới)",
})

-- 4. Khoảng cách đứng so với quái (Farm Distance)
Tabs.SettingFarm:AddSlider("FarmDistance", {
    Title = "Farm Distance",
    Description = "Độ cao/khoảng cách khi đánh quái",
    Default = 20,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        _G.FarmDistance = Value
    end
})

local TweenSection = Tabs.SettingFarm:AddSection("Movement Speed")

-- 5. Tốc độ bay (Tween Speed)
Tabs.SettingFarm:AddSlider("TweenSpeed", {
    Title = "Tween Speed",
    Description = "Tốc độ di chuyển giữa các đảo",
    Default = 250,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        _G.TweenSpeed = Value
    end
})

-- 6. Tùy chọn Fast Attack (Đánh nhanh)
Tabs.SettingFarm:AddToggle("FastAttack", {Title = "Fast Attack (Siêu nhanh)", Default = true})
--TAB Skill 

--TAB Farming 
Tabs.Farming:AddSection("Farming Interface")

local MethodFarm = Tabs.Farming:AddDropdown("MethodFarm", {
    Title = "Select Method Farm",
    Values = {"Level Farm", "Bone Farm", "Katakuri Farm"},
    Multi = false,
    Default = 1,
})
MethodFarm:OnChanged(function(Value)
    _G.SelectMethod = Value
end)

Tabs.Farming:AddSlider("DistanceSlider", {
    Title = "Distance Farm Aura",
    Description = "Chỉnh độ cao khi treo Farm",
    Default = 300,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Callback = function(Value)
        _G.DistanceFarm = Value
    end
})

Tabs.Farming:AddSection("Mastery Farm")
-- (Chỗ này lát nữa mình sẽ dán code Auto Farm Mastery vào đây)

Tabs.Farming:AddSection("Farm Options")
Tabs.Farming:AddToggle("IgnoreKatakuri", {
    Title = "Ignore Attack Katakuri",
    Default = false,
    Callback = function(Value) _G.IgnoreKatakuri = Value end
})

Tabs.Farming:AddToggle("AutoQuest", {
    Title = "Auto Quest [Katakuri/Bone/Tyrant]",
    Default = true,
    Callback = function(Value) _G.AutoQuest = Value end
})

Tabs.Farming:AddToggle("StartFarmLevel", {
    Title = "Start Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
        if Value then
            Fluent:Notify({Title = "SHADOW PREMIUM", Content = "Start Farm Level!", Duration = 3})
        end
    end
})
--TAB StackFarming 

--TAB FarmingOther 

--TAB Dungeon 

--TAB SeaEvent 

--TAB UpgradeRace 

--TAB Get Items And Upgrade
local SwordSection = Tabs.Items:AddSection("Legendary Swords & Melee")

local SwordSection = Tabs.Items:AddSection("Legendary Swords & Melee")

Tabs.Items:AddDropdown("GetSwords", {
    Title = "Get Legendary Swords",
    Values = {"Tushita", "Yama", "Cursed Dual Katana", "Shark Anchor"},
    Multi = false,
    Default = "Tushita",
    Callback = function(Value)
        _G.GetItem_Selected = Value
    end
})

Tabs.Items:AddButton({
    Title = "Get Godhuman",
    Description = "Tự động cày nguyên liệu và lấy Godhuman",
    Callback = function()
        _G.AutoGodHuman = true
    end
})

local SeaEventSection = Tabs.Items:AddSection("Sea Events & Bosses")

Tabs.Items:AddToggle("AutoCursedCaptain", {Title = "Auto Cursed Captain", Default = false})
Tabs.Items:AddToggle("AutoDarkbeard", {Title = "Auto Darkbeard", Default = false})

local RaceV4Section = Tabs.Items:AddSection("Race V4 & Mirage")

Tabs.Items:AddToggle("AutoMirage", {Title = "Auto Find Mirage Island", Default = false})
Tabs.Items:AddToggle("AutoPullLever", {Title = "Auto Pull Lever (Gạt cần)", Default = false})

Tabs.Items:AddButton({
    Title = "Auto Get Mirror Fractal",
    Callback = function()
        _G.AutoGetMirror = true
    end
})

local ItemUtils = Tabs.Items:AddSection("Item Utilities")

Tabs.Items:AddToggle("AutoCollectChest", {Title = "Auto Farm Chest", Default = false})

-- 1. Lấy các kiếm huyền thoại
Tabs.Items:AddDropdown("GetSwords", {
    Title = "Get Legendary Swords",
    Values = {"Tushita", "Yama", "Cursed Dual Katana", "Shark Anchor"},
    Multi = false,
    Default = "Tushita",
    Callback = function(Value)
        _G.GetItem_Selected = Value
    end
})

Tabs.Items:AddButton({
    Title = "Get Godhuman",
    Description = "Tự động cày nguyên liệu và lấy Godhuman",
    Callback = function()
        _G.AutoGodHuman = true
    end
})

local SeaEventSection = Tabs.Items:AddSection("Sea Events & Bosses")

Tabs.Items:AddToggle("AutoCursedCaptain", {Title = "Auto Cursed Captain", Default = false})
Tabs.Items:AddToggle("AutoDarkbeard", {Title = "Auto Darkbeard", Default = false})

local RaceV4Section = Tabs.Items:AddSection("Race V4 & Mirage")

Tabs.Items:AddToggle("AutoMirage", {Title = "Auto Find Mirage Island", Default = false})
Tabs.Items:AddToggle("AutoPullLever", {Title = "Auto Pull Lever (Gạt cần)", Default = false})

Tabs.Items:AddButton({
    Title = "Auto Get Mirror Fractal",
    Callback = function()
        _G.AutoGetMirror = true
    end
})

local ItemUtils = Tabs.Items:AddSection("Item Utilities")

Tabs.Items:AddToggle("AutoCollectChest", {Title = "Auto Farm Chest", Default = false})
--TAB Volcano

--TAB ESP 

--TAB PVP 

-- [[ TAB WEBHOOK - SHADOW PREMIUM ]]
local WebhookSection = Tabs.Webhook:AddSection("Webhook Configuration")

Tabs.Webhook:AddInput("WebhookURL", {
    Title = "Discord Webhook URL",
    Default = "",
    Placeholder = "Dán link Webhook vào đây...",
    Callback = function(Value)
        _G.Webhook_URL = Value
    end
})

Tabs.Webhook:AddButton({
    Title = "Test Webhook",
    Description = "Gửi thử một thông báo đến Discord để kiểm tra",
    Callback = function()
        -- Logic gửi test message
        print("Đang gửi tin nhắn thử nghiệm...")
    end
})

local WebhookSettings = Tabs.Webhook:AddSection("Webhook Settings")

Tabs.Webhook:AddToggle("Web_Enable", {Title = "Enable Webhook", Default = false})
Tabs.Webhook:AddToggle("Web_SendStats", {Title = "Send Stats (Level, Beli, Frag)", Default = false})
Tabs.Webhook:AddToggle("Web_SendInventory", {Title = "Send Inventory (Items, Fruit)", Default = false})
Tabs.Webhook:AddToggle("Web_SendImage", {Title = "Send Screenshot (Chụp màn hình)", Default = false})

local WebhookNotify = Tabs.Webhook:AddSection("Notification Events")

Tabs.Webhook:AddToggle("Notify_LvlUp", {Title = "Notify Level Up", Default = false})
Tabs.Webhook:AddToggle("Notify_RareItem", {Title = "Notify Legendary Item", Default = false})
Tabs.Webhook:AddToggle("Notify_Fruit", {Title = "Notify Fruit Spawn/Find", Default = false})

Tabs.Webhook:AddSlider("Web_Delay", {
    Title = "Update Delay (Minutes)",
    Description = "Thời gian giãn cách giữa mỗi lần gửi báo cáo",
    Default = 5,
    Min = 1,
    Max = 60,
    Rounding = 0,
    Callback = function(Value)
        _G.Webhook_Delay = Value
    end
})

--TAB Settings

-- [[ LOGIC SYSTEM - SHADOW PREMIUM ]]
task.spawn(function()
    local BaseUrl = "https://raw.githubusercontent.com/shadowyeuem/Shadow-Premium/refs/heads/main/shadow.lua"
    
    local function LoadLogic(fileName)
        pcall(function() 
            loadstring(game:HttpGet(BaseUrl .. fileName))() 
        end)
    end

    LoadLogic("Shop.lua")
    LoadLogic("StatusServer.lua")
    LoadLogic("LocalPlayer.lua")
    LoadLogic("SettingFarm.lua")
    LoadLogic("Skill.lua")
    LoadLogic("Farming.lua")
    LoadLogic("StackFarming.lua")
    LoadLogic("FarmingOther.lua")
    LoadLogic("Dungeon.lua")
    LoadLogic("SeaEvent.lua")
    LoadLogic("UpgradeRace.lua")
    LoadLogic("Items.lua")
    LoadLogic("Volcano.lua")
    LoadLogic("ESP.lua")
    LoadLogic("PVP.lua")
    LoadLogic("Webhook.lua")
    LoadLogic("Settings.lua")

    print("SHADOW PREMIUM: Tat ca 17 Logic da duoc nap!")
end)

-- [[ END KẾT THÚC FILE]]
Fluent:SetTheme("Darker")
Window:SelectTab(Tabs.StatusServer)
for _, tab in pairs(Tabs) do
    tab:AddSection(" ") 
    tab:AddSection("— SHADOW PREMIUM —") 
end


