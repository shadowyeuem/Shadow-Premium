local HttpService = game:GetService("HttpService")

local function SendWebhook(msg)
    local url = _G.Webhook_URL
    if url == "" or not url then return end
    
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "🚀 SHADOW PREMIUM - REPORT",
            ["description"] = msg,
            ["color"] = 0x00FF00,
            ["footer"] = {["text"] = "Time: " .. os.date("%X")}
        }}
    }
    
    local response = request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(data)
    })
end

-- Ví dụ: Gắn vào nút "Test Webhook" của anh
-- Tìm đến đoạn AddButton "Test Webhook" và sửa Callback:
Callback = function()
    SendWebhook("✅ Kết nối thành công! Script Shadow Premium đã sẵn sàng.")
    Fluent:Notify({Title = "Webhook", Content = "Đã gửi tin nhắn thử nghiệm!", Duration = 3})
end

