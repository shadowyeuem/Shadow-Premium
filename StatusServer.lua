-- [[ TAB STATUS SERVER - SHADOW PREMIUM ULTIMATE V3 ]]
local StatusSection = Tabs.StatusServer:AddSection("📊 THÔNG SỐ CHI TIẾT")

local LevelLabel = Tabs.StatusServer:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
local BeliLabel = Tabs.StatusServer:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
local FragLabel = Tabs.StatusServer:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
local BountyLabel = Tabs.StatusServer:AddParagraph({ Title = "Bounty:", Content = "Đang nạp..." })

Tabs.StatusServer:AddSection("🏝️ RADAR ĐẢO & DIMENSION (HÌNH ANH GỬI)")
local MirageLabel = Tabs.StatusServer:AddParagraph({ Title = "Mirage Island:", Content = "❌ Chưa xuất hiện" })
local VolcanoLabel = Tabs.StatusServer:AddParagraph({ Title = "Volcano Event:", Content = "❌ Chưa có" })
local FrozenLabel = Tabs.StatusServer:AddParagraph({ Title = "Frozen Dimension:", Content = "❌ Đang đóng" })
local SeaLabel = Tabs.StatusServer:AddParagraph({ Title = "Quái biển (Sea):", Content = "Đang quét..." })

Tabs.StatusServer:AddSection("⚔️ BOSS & EVENT")
local CakeLabel = Tabs.StatusServer:AddParagraph({ Title = "Cake Prince:", Content = "0/500" })
local MobLabel = Tabs.StatusServer:AddParagraph({ Title = "Mob Farm:", Content = "0" })

Tabs.StatusServer:AddSection("🌍 SERVER")
local TimeLabel = Tabs.StatusServer:AddParagraph({ Title = "Giờ:", Content = "00:00:00" })

Tabs.StatusServer:AddButton({
    Title = "Rejoin Server",
    Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end
})

-- [[ LOGIC QUÉT DỮ LIỆU REAL-TIME ]]
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local p = game.Players.LocalPlayer
            -- 1. Cập nhật số liệu cơ bản
            LevelLabel:SetTitle("Cấp độ: " .. tostring(p.Data.Level.Value))
            BeliLabel:SetTitle("Tiền Beli: 💵 " .. tostring(p.Data.Beli.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", ""))
            BountyLabel:SetTitle("Bounty: 🏴‍☠️ " .. tostring(p.leaderstats["Bounty/Honor"].Value))
            TimeLabel:SetTitle(os.date("Giờ: %X"))

            -- 2. Quét Mirage & Event
            if game:GetService("Workspace").Map:FindFirstChild("Mirage Island") then
                MirageLabel:SetTitle("Mirage Island: ✅ ĐÃ XUẤT HIỆN!")
            else
                MirageLabel:SetTitle("Mirage Island: ❌ Không thấy")
            end

            -- 3. Quét Frozen Dimension / Volcano (Quét trong vùng SeaEvents)
            local seaEvents = game:GetService("Workspace").Map:FindFirstChild("SeaEvents")
            if seaEvents then
                if seaEvents:FindFirstChild("Volcano") then VolcanoLabel:SetTitle("Volcano: ✅ ĐANG PHUN TRÀO!") end
                if seaEvents:FindFirstChild("Frozen") then FrozenLabel:SetTitle("Frozen: ✅ ĐANG MỞ!") end
            end

            -- 4. Quét Cake Prince
            local countCake = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetKillingCount") or 0
            CakeLabel:SetTitle("Cake Prince: " .. tostring(countCake) .. "/500")
        end)
    end
end)

-- [[ FIX LỖI TRƯỢT: THÊM 3 Ô TRỐNG CUỐI FILE ]]
for i = 1, 3 do
    Tabs.StatusServer:AddSection(" ") 
end

-- [[ ÉP LƯU CONFIG ]]
pcall(function() SaveManager:LoadAutoloadConfig() end)
