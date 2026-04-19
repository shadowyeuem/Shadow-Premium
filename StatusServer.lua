-- [[ TAB STATUS SERVER - SHADOW PREMIUM ]]
local StatusSection = Tabs.StatusServer:AddSection("📊 NHÂN VẬT & MÁY CHỦ")

-- Tạo khung hiển thị thông tin bằng Paragraph cho chuyên nghiệp
local LevelLabel = Tabs.StatusServer:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
local BeliLabel = Tabs.StatusServer:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
local FragLabel = Tabs.StatusServer:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
local BountyLabel = Tabs.StatusServer:AddParagraph({ Title = "Bounty / Honor:", Content = "Đang nạp..." })

Tabs.StatusServer:AddSection("🌍 THÔNG TIN SERVER")
local TimeLabel = Tabs.StatusServer:AddParagraph({ Title = "Giờ hệ thống:", Content = "00:00:00" })
local JobIDLabel = Tabs.StatusServer:AddParagraph({ Title = "Job ID:", Content = game.JobId })

-- [[ VÒNG LẶP CẬP NHẬT THÔNG SỐ REAL-TIME ]]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = game.Players.LocalPlayer
            local data = p.Data
            
            -- Cập nhật Level
            LevelLabel:SetTitle("Cấp độ: " .. tostring(data.Level.Value))
            
            -- Cập nhật Tiền (Thêm dấu phẩy cho sang)
            local beli = tostring(data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
            BeliLabel:SetTitle("Tiền Beli: 💵 " .. beli)
            
            -- Cập nhật Fragment & Bounty
            FragLabel:SetTitle("Fragment: ✨ " .. tostring(data.Fragments.Value))
            BountyLabel:SetTitle("Bounty: 🏴‍☠️ " .. tostring(p.leaderstats["Bounty/Honor"].Value))
            
            -- Cập nhật Giờ
            local t = os.date("!*t")
            TimeLabel:SetTitle(string.format("Giờ: %02d:%02d:%02d", t.hour, t.min, t.sec))
        end)
    end
end)

