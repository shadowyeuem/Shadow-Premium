-- [[ TAB ITEMS - CLONE CHUẨN 1:1 THEO HÌNH 1000001241 ]]

-- 1. DROPDOWN CHỌN VŨ KHÍ (Luôn nằm trên cùng)
local WeaponSection = Tabs.Items:AddSection("⚔️ WEAPON CONFIG")

Tabs.Items:AddDropdown("WeaponSelect", {
    Title = "Select Weapon",
    Values = {"Melee", "Sword", "Fruit"},
    Default = "Melee",
    Callback = function(Value) _G.Select_Weapon = Value end
})

-- 2. THANH TRƯỢT TỐC ĐỘ (Slider ở giữa)
Tabs.Items:AddSlider("TweenSpeed", {
    Title = "Tween Speed",
    Min = 100, Max = 350, Default = 250, Rounding = 0,
    Callback = function(Value) _G.TweenSpeed = Value end
})

-- 3. CÁC NÚT LẤY KIẾM (TOGGLE - CHI TIẾT TỪNG MỤC)
local SwordSection = Tabs.Items:AddSection("🗡️ GET RARE SWORDS")

Tabs.Items:AddToggle("GetSaber", {
    Title = "Auto Get Saber",
    Default = false,
    Callback = function(Value) _G.AutoSaber = Value end
})

Tabs.Items:AddToggle("GetPole", {
    Title = "Auto Get Pole",
    Default = false,
    Callback = function(Value) _G.AutoPole = Value end
})

Tabs.Items:AddToggle("GetRengoku", {
    Title = "Auto Get Rengoku",
    Default = false,
    Callback = function(Value) _G.AutoRengoku = Value end
})

Tabs.Items:AddToggle("GetMidnight", {
    Title = "Auto Get Midnight Blade",
    Default = false,
    Callback = function(Value) _G.AutoMidnight = Value end
})

Tabs.Items:AddToggle("GetYama", {
    Title = "Auto Get Yama",
    Default = false,
    Callback = function(Value) _G.AutoYama = Value end
})

Tabs.Items:AddToggle("GetTushita", {
    Title = "Auto Get Tushita",
    Default = false,
    Callback = function(Value) _G.AutoTushita = Value end
})

Tabs.Items:AddToggle("GetCDK", {
    Title = "Auto Get Cursed Dual Katana",
    Default = false,
    Callback = function(Value) _G.AutoCDK = Value end
})

-- 4. VẬT PHẨM KHÁC (SEA 3)
local OtherSection = Tabs.Items:AddSection("✨ OTHER ITEMS")

Tabs.Items:AddToggle("GetSoulGuitar", {
    Title = "Auto Get Soul Guitar",
    Default = false,
    Callback = function(Value) _G.AutoSoulGuitar = Value end
})

Tabs.Items:AddToggle("GetRainbowHaki", {
    Title = "Auto Get Rainbow Haki",
    Default = false,
    Callback = function(Value) _G.AutoRainbowHaki = Value end
})

Tabs.Items:AddToggle("AutoHolyTorch", {
    Title = "Auto Get Holy Torch",
    Default = false,
    Callback = function(Value) _G.AutoHolyTorch = Value end
})

-- [[ KẾT THÚC VỚI 3 Ô TRỐNG ĐỂ TRƯỢT MƯỢT MÀ ]]
for i = 1, 3 do
    Tabs.Items:AddSection(" ") 
end

-- Tự động lưu cấu hình Link và Checkbox
pcall(function() SaveManager:BuildConfigSection(Tabs.Settings) end)

