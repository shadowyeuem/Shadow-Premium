-- [[ TAB SETTINGS - SHADOW PREMIUM OPTIMIZED ]]
local ConfigSection = Tabs.General:AddSection("⚙️ CẤU HÌNH FARM (FIX TRÙNG)")

-- 1. ĐÃ BỎ: Click NPC (Theo ý anh là không cần thiết)

-- 2. GOM NHÓM: Chỉ giữ lại 1 thanh Bring Mob duy nhất
Tabs.General:AddToggle("BringMob", {
    Title = "Gom quái (Bring Mob)",
    Default = true,
    Callback = function(Value)
        _G.BringMob = Value
    end
})

-- 3. GOM NHÓM: Chỉ giữ lại 1 thanh Tween Speed duy nhất
Tabs.General:AddSlider("TweenSpeed", {
    Title = "Tốc độ di chuyển (Tween Speed)",
    Description = "Chỉnh tốc độ bay để tránh bị kick",
    Default = 250,
    Min = 100,
    Max = 350,
    Rounding = 0,
    Callback = function(Value)
        _G.TweenSpeed = Value
    end
})

-- 4. ĐÃ BỎ: Farm Distance (Vì bên Tab Farming đã có rồi, bỏ đây cho gọn)

-- [[ THÔNG TIN ĐẢO HIẾM (MIRAGE, VOLCANO, FROZEN) ]]
local RadarSection = Tabs.StatusServer:AddSection("🏝️ RADAR ĐẢO HIẾM")
local MirageLabel = Tabs.StatusServer:AddParagraph({ Title = "Mirage Island:", Content = "❌ Chưa thấy" })
local EventLabel = Tabs.StatusServer:AddParagraph({ Title = "Sự kiện biển:", Content = "Đang quét..." })

-- Logic quét tự động
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            -- Quét Mirage
            if game:GetService("Workspace").Map:FindFirstChild("Mirage Island") then
                MirageLabel:SetTitle("Mirage Island: ✅ XUẤT HIỆN!")
            else
                MirageLabel:SetTitle("Mirage Island: ❌ Không có")
            end
            
            -- Quét Núi lửa & Đảo Băng
            local sea = game:GetService("Workspace").Map:FindFirstChild("SeaEvents")
            if sea then
                if sea:FindFirstChild("Volcano") then EventLabel:SetTitle("Sự kiện: 🔥 NÚI LỬA!")
                elseif sea:FindFirstChild("Frozen") then EventLabel:SetTitle("Sự kiện: ❄️ ĐẢO BĂNG!")
                else EventLabel:SetTitle("Sự kiện: 🌊 Bình thường") end
            end
        end)
    end
end)

-- [[ QUAN TRỌNG: THÊM 3 Ô TRỐNG ĐỂ DỄ TRƯỢT MENU ]]
Tabs.General:AddSection("— KẾT THÚC —")
for i = 1, 3 do
    Tabs.General:AddSection(" ") 
end

-- Lệnh lưu cấu hình cho file phụ
pcall(function() SaveManager:BuildConfigSection(Tabs.Settings) end)

