-- [[ TAB STATUS SERVER - SHADOW PREMIUM V2 ]]
local StatusSection = Tabs.StatusServer:AddSection("📊 NHÂN VẬT & MÁY CHỦ")

local LevelLabel = Tabs.StatusServer:AddParagraph({ Title = "Cấp độ:", Content = "Đang nạp..." })
local BeliLabel = Tabs.StatusServer:AddParagraph({ Title = "Tiền Beli:", Content = "Đang nạp..." })
local FragLabel = Tabs.StatusServer:AddParagraph({ Title = "Fragment:", Content = "Đang nạp..." })
local BountyLabel = Tabs.StatusServer:AddParagraph({ Title = "Bounty / Honor:", Content = "Đang nạp..." })

Tabs.StatusServer:AddSection("🌍 QUẢN LÝ SERVER")
local TimeLabel = Tabs.StatusServer:AddParagraph({ Title = "Giờ hệ thống:", Content = "00:00:00" })

Tabs.StatusServer:AddButton({
    Title = "Rejoin Server",
    Description = "Kết nối lại máy chủ hiện tại",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

Tabs.StatusServer:AddButton({
    Title = "Hop Server",
    Description = "Chuyển sang server khác (Fix kẹt)",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
        local function NextServer(cursor)
            local res = game:HttpGet(Api..(cursor and "&cursor="..cursor or ""))
            local data = Http:JSONEncode(res)
            for i,v in pairs(data.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                    break
                end
            end
        end
        NextServer()
    end
})

-- Vòng lặp cập nhật số vẫn giữ nguyên như cũ...
