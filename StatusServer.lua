-- [[ TAB WEBHOOK - SHADOW PREMIUM ULTIMATE ]]
local WebhookSection = Tabs.Webhook:AddSection("📢 CẤU HÌNH THÔNG BÁO DISCORD")

-- Ô nhập Link Webhook (Tự động lưu nhờ biến _G)
Tabs.Webhook:AddInput("WebhookURL", {
    Title = "Discord Webhook URL",
    Default = _G.Webhook_URL or "",
    Placeholder = "Dán link Webhook của anh vào đây...",
    Callback = function(Value)
        _G.Webhook_URL = Value
    end
})

-- Nút gửi báo cáo đầy đủ thông tin (Level, Beli, Fragment, Bounty)
Tabs.Webhook:AddButton({
    Title = "Gửi Báo Cáo Ngay",
    Description = "Bắn thông số nhân vật hiện tại về Discord",
    Callback = function()
        local url = _G.Webhook_URL
        if url == "" or not url then 
            return Fluent:Notify({Title = "Lỗi", Content = "Anh chưa dán link Webhook kìa!", Duration = 3}) 
        end
        
        local p = game.Players.LocalPlayer
        local data = {
            ["embeds"] = {{
                ["title"] = "📩 SHADOW PREMIUM - BÁO CÁO NHÂN VẬT",
                ["description"] = string.format(
                    "👤 **Tên:** %s\n📊 **Cấp độ:** %s\n💵 **Beli:** %s\n✨ **Fragment:** %s\n🏴‍☠️ **Bounty:** %s",
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
        
        request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
        Fluent:Notify({Title = "Thành công", Content = "Đã gửi báo cáo về Discord rồi nhé anh Shadow!", Duration = 3})
    end
})

-- [[ FIX LỖI TRƯỢT: THÊM 3 Ô TRỐNG CUỐI FILE PHỤ ]]
Tabs.Webhook:AddSection("— KẾT THÚC —")
for i = 1, 3 do
    Tabs.Webhook:AddSection(" ") 
end

-- Lệnh ép SaveManager nhận diện lại để lưu cấu hình link Discord
pcall(function() 
    SaveManager:BuildConfigSection(Tabs.Settings) 
    SaveManager:Save(SaveManager:GetConfigsList()[1] or "Shadow_Premium_Config")
end)
