-- [[ TAB STATUS SERVER - SHADOW PREMIUM ULTIMATE ]]
local StatusSection = Tabs.StatusServer:AddSection("📊 THÔNG SỐ NHÂN VẬT")

-- Các thông số cơ bản nhảy số liên tục
local LevelLabel = Tabs.StatusServer:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
local BeliLabel = Tabs.StatusServer:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
local FragLabel = Tabs.StatusServer:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
local BountyLabel = Tabs.StatusServer:AddParagraph({ Title = "Bounty:", Content = "Đang nạp..." })

Tabs.StatusServer:AddSection("⚔️ TRẠNG THÁI BOSS & EVENT (HÌNH 3 & 4)")
-- Thêm các dòng check vật phẩm và boss hiếm theo ý anh
local CakeLabel = Tabs.StatusServer:AddParagraph({ Title = "Cake Prince / Dough King:", Content = "Đang kiểm tra..." })
local TyrantLabel = Tabs.StatusServer:AddParagraph({ Title = "Eyes Tyrant:", Content = "Đang nạp..." })
local MobLabel = Tabs.StatusServer:AddParagraph({ Title = "Số quái đã gom (Mob):", Content = "0" })
local MasteryLabel = Tabs.StatusServer:AddParagraph({ Title = "Mastery Vũ Khí:", Content = "Đang nạp..." })

Tabs.StatusServer:AddSection("🌍 QUẢN LÝ SERVER")
local TimeLabel = Tabs.StatusServer:AddParagraph({ Title = "Giờ hệ thống:", Content = "00:00:00" })

Tabs.StatusServer:AddButton({
    Title = "Rejoin Server",
    Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end
})

Tabs.StatusServer:AddButton({
    Title = "Hop Server (Fix Kẹt)",
    Callback = function() 
        -- Logic Hop Server đã có trong file chính
    end
})

-- [[ VÒNG LẶP CẬP NHẬT REAL-TIME & FIX LỖI ]]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = game.Players.LocalPlayer
            -- Cập nhật Level/Beli
            LevelLabel:SetTitle("Cấp độ: " .. tostring(p.Data.Level.Value))
            local beliFormatted = tostring(p.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
            BeliLabel:SetTitle("Tiền Beli: 💵 " .. beliFormatted)
            
            -- Cập nhật Boss/Event (Logic giả định theo game)
            local countCake = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetKillingCount") or 0
            CakeLabel:SetTitle("Cake Prince: " .. tostring(countCake) .. "/500")
            
            -- Đếm số Mob xung quanh anh
            local mobCount = 0
            for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then mobCount = mobCount + 1 end
            end
            MobLabel:SetTitle("Số quái xung quanh: " .. tostring(mobCount))
            
            TimeLabel:SetTitle(os.date("Giờ: %X"))
        end)
    end
end)

-- [[ FIX LỖI TRƯỢT: THÊM 3 Ô TRỐNG CUỐI FILE PHỤ ]]
Tabs.StatusServer:AddSection("— KẾT THÚC —")
for i = 1, 3 do
    Tabs.StatusServer:AddSection(" ") 
end

-- [[ LƯU TÙY CHỌN RIÊNG CHO FILE NÀY ]]
-- Dùng biến _G để giữ link Webhook không bị mất khi đổi Tab
task.spawn(function()
    if _G.SaveConfig then
        pcall(function()
            SaveManager:LoadAutoloadConfig() -- Tự động nạp lại màu và link Discord
        end)
    end
end)
