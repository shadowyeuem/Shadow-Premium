-- [[ FILE STATUSSERVER.LUA - FIX BY SHADOW PREMIUM ]]
-- Tự tìm lại Tab StatusServer từ UI nếu không thấy biến Tabs
local StatusTab = (Tabs and Tabs.StatusServer) or game:GetService("CoreGui"):FindFirstChild("Fluent"):FindFirstChild("Window"):FindFirstChild("Status And Server")

if StatusTab then
    local StatusSection = StatusTab:AddSection("📊 NHÂN VẬT & MÁY CHỦ")

    local LevelLabel = StatusTab:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
    local BeliLabel = StatusTab:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
    local FragLabel = StatusTab:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
    local BountyLabel = StatusTab:AddParagraph({ Title = "Bounty / Honor:", Content = "Đang nạp..." })

    StatusTab:AddSection("🌍 THÔNG TIN SERVER")
    local TimeLabel = StatusTab:AddParagraph({ Title = "Giờ hệ thống:", Content = "00:00:00" })

    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local p = game.Players.LocalPlayer
                LevelLabel:SetTitle("Cấp độ: " .. tostring(p.Data.Level.Value))
                local beli = tostring(p.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
                BeliLabel:SetTitle("Tiền Beli: 💵 " .. beli)
                FragLabel:SetTitle("Fragment: ✨ " .. tostring(p.Data.Fragments.Value))
                BountyLabel:SetTitle("Bounty: 🏴‍☠️ " .. tostring(p.leaderstats["Bounty/Honor"].Value))
                TimeLabel:SetTitle(os.date("Giờ: %X"))
            end)
        end
    end)
else
    warn("SHADOW PREMIUM: Khong tim thay Tab StatusServer!")
end
