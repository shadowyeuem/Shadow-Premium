-- [[ FILE STATUSSERVER.LUA - SHADOW PREMIUM ]]
-- Lưu ý: Không được khai báo lại biến 'Tabs' mới, mà phải dùng biến từ file chính nạp qua
local StatusTab = Tabs.StatusServer 

local StatusSection = StatusTab:AddSection("📊 NHÂN VẬT & MÁY CHỦ")

-- Tạo khung hiển thị thông tin bằng Paragraph
local LevelLabel = StatusTab:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
local BeliLabel = StatusTab:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
local FragLabel = StatusTab:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
local BountyLabel = StatusTab:AddParagraph({ Title = "Bounty / Honor:", Content = "Đang nạp..." })

StatusTab:AddSection("🌍 THÔNG TIN SERVER")
local TimeLabel = StatusTab:AddParagraph({ Title = "Giờ hệ thống:", Content = "00:00:00" })
local JobIDLabel = StatusTab:AddParagraph({ Title = "Job ID:", Content = game.JobId })

-- [[ VÒNG LẶP CẬP NHẬT REAL-TIME ]]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = game.Players.LocalPlayer
            -- Cập nhật số liệu nhân vật
            LevelLabel:SetTitle("Cấp độ: " .. tostring(p.Data.Level.Value))
            local beli = tostring(p.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
            BeliLabel:SetTitle("Tiền Beli: 💵 " .. beli)
            FragLabel:SetTitle("Fragment: ✨ " .. tostring(p.Data.Fragments.Value))
            BountyLabel:SetTitle("Bounty: 🏴‍☠️ " .. tostring(p.leaderstats["Bounty/Honor"].Value))
            -- Cập nhật giờ
            local t = os.date("!*t")
            TimeLabel:SetTitle(string.format("Giờ: %02d:%02d:%02d", t.hour, t.min, t.sec))
        end)
    end
end)
