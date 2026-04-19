_G.AutoTranslate = true
_G.SaveConfig = true
repeat task.wait() until game:IsLoaded()

-- PHẢI LOAD FLUENT TRƯỚC KHI DÙNG NHA ANH SHADOW
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

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
    hookfunction(require(ReplicatedStorage.Effect.Container.Respawn), function()
        return nil
    end)
end)

Tabs = {
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

-- [[ NÚT SEND WEBHOOK - ĐÃ CÀI ĐẶT LOGIC THEO Ý ANH SHADOW ]]
Tabs.Webhook:AddButton({
    Title = "Send Report Now",
    Description = "Gửi thông số nhân vật hiện tại về Discord ngay lập tức",
    Callback = function()
        local url = _G.Webhook_URL
        if url == "" or not url then 
            return Fluent:Notify({Title = "Lỗi", Content = "Anh chưa dán link Webhook vào ô ở trên kìa!", Duration = 3}) 
        end
        
        local p = game.Players.LocalPlayer
        local data = {
            ["embeds"] = {{
                ["title"] = "📩 SHADOW PREMIUM - BÁO CÁO THỦ CÔNG",
                ["description"] = string.format(
                    "👤 **Người chơi:** %s\n📊 **Cấp độ:** %s\n💵 **Beli:** %s\n✨ **Fragment:** %s\n🏴‍☠️ **Bounty:** %s",
                    p.Name, 
                    tostring(p.Data.Level.Value), 
                    tostring(p.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", ""),
                    tostring(p.Data.Fragments.Value),
                    tostring(p.leaderstats["Bounty/Honor"].Value)
                ),
                ["color"] = 0x00A2FF,
                ["footer"] = {["text"] = "Gửi lúc: " .. os.date("%X")}
            }}
        }
        
        -- Gửi đi
        local response = (syn and syn.request or http_request or request or HttpService.Request)({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
        
        Fluent:Notify({Title = "Webhook", Content = "Đã gửi báo cáo về Discord rồi nhé anh!", Duration = 3})
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
    local BaseUrl = "https://raw.githubusercontent.com/shadowyeuem/Shadow-Premium/main/"
    local files = {
        "Shop.lua", "StatusServer.lua", "LocalPlayer.lua", "SettingFarm.lua", 
        "Skill.lua", "Farming.lua", "StackFarming.lua", "FarmingOther.lua", 
        "Dungeon.lua", "SeaEvent.lua", "UpgradeRace.lua", "Items.lua",
        "Volcano.lua", "ESP.lua", "PVP.lua", "Webhook.lua", "Settings.lua"
    }

    for _, v in pairs(files) do 
        pcall(function() 
            local code = game:HttpGet(BaseUrl .. v)
            if code and code ~= "" then
                loadstring(code)() 
            end
        end)
    end
end)
-- [[ CONFIG SYSTEM - LƯU TÙY CHỌN CHO ANH SHADOW ]]
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Đặt tên thư mục lưu script của anh
SaveManager:SetIgnoreIndexes({})
SaveManager:IgnoreThemeSettings()

-- Tự động nạp cấu hình khi vừa mở script
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

SaveManager:LoadAutoloadConfig() 

-- Thiết lập để mỗi khi anh tích vào nút nào đó, nó sẽ tự nhớ
task.spawn(function()
    while task.wait(5) do -- Cứ 5 giây tự lưu một lần cho chắc
        pcall(function()
            SaveManager:Save(SaveManager:GetConfigsList()[1] or "Shadow_Premium_Config")
        end)
    end
end)

-- [[ KÍCH HOẠT GIAO DIỆN & FIX THANH CUỘN ]]
Fluent:SetTheme("Darker")
Window:SelectTab(Tabs.StatusServer)

-- Vòng lặp tối ưu theo ý anh Shadow
for _, tab in pairs(Tabs) do
    tab:AddSection("— SHADOW PREMIUM —") 
    -- Giảm xuống còn 3 ô trắng bên phải chức năng cho đỡ trống trải
    for i = 1, 3 do
        tab:AddSection(" ") 
    end
end

-- FIX RIÊNG CHO THANH TAB BÊN TRÁI (SIDEBAR)
-- Thêm khoảng trắng vào cuối Sidebar để anh trượt tới tab Setting dễ dàng
local DummyTab = Window:AddTab({ Title = " ", Icon = "" })
local DummyTab2 = Window:AddTab({ Title = " ", Icon = "" })

