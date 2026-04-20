-- [[ TAB WEBHOOK - SHADOW PREMIUM V2 ]]
local WebhookSection = Tabs.Webhook:AddSection("📢 CẤU HÌNH THÔNG BÁO")

-- Ô nhập Link Webhook (Dùng biến _G để file nào cũng thấy)
Tabs.Webhook:AddInput("WebhookURL", {
    Title = "Discord Webhook URL",
    Default = _G.Webhook_URL or "",
    Placeholder = "Dán link Discord vào đây...",
    Callback = function(Value)
        _G.Webhook_URL = Value
    end
})

-- Nút Test Webhook có não (Đã fix lỗi gửi)
Tabs.Webhook:AddButton({
    Title = "Gửi Thử Thông Báo",
    Description = "Kiểm tra xem link Webhook có hoạt động không",
    Callback = function()
        local url = _G.Webhook_URL
        if url == "" or not url then 
            return Fluent:Notify({Title = "Lỗi", Content = "Anh chưa dán link Webhook!", Duration = 3}) 
        end
        
        local data = {
            ["embeds"] = {{
                ["title"] = "🚀 SHADOW PREMIUM CONNECTED",
                ["description"] = "User: " .. game.Players.LocalPlayer.Name .. "\nStatus: Hoạt động tốt!",
                ["color"] = 0x00FF00
            }}
        }
        
        request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
        Fluent:Notify({Title = "Thành công", Content = "Đã bắn thông báo về Discord!", Duration = 3})
    end
})

-- [[ THÊM 3 Ô TRỐNG ĐỂ TRƯỢT MENU MƯỢT MÀ ]]
Tabs.Webhook:AddSection("— KẾT THÚC —")
for i = 1, 3 do
    Tabs.Webhook:AddSection(" ") 
end

-- Lệnh ép SaveManager nhận diện lại để lưu cấu hình
pcall(function() SaveManager:BuildConfigSection(Tabs.Settings) end)
