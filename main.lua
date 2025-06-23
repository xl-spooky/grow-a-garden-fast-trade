local Players           = game:GetService("Players")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataModule    = ReplicatedStorage:WaitForChild("Data_Module")
local GiftModule    = ReplicatedStorage:WaitForChild("Gift_Module")
local PostieSentEvt = ReplicatedStorage:WaitForChild("PostieSent")

local Data   = require(DataModule)
local Gift   = require(GiftModule)

local TARGET_NAME = "PulpitaIsHere"
local LOCAL       = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui   = LOCAL:WaitForChild("PlayerGui")

local logs = {}
local scriptEnabled = true

local function log(fmt, ...)
    local msg = (fmt):format(...)
    local entry = "[Gifter] " .. msg
    table.insert(logs, entry)
    print(entry)
end

PostieSentEvt.OnClientEvent:Connect(function(recipient, itemName, amount)
    if not scriptEnabled then return end
    log("✅ [Server] confirmed %s x%d → %s", itemName, amount, recipient.Name)
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GifterGUI"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false

local copyBtn = Instance.new("TextButton")
copyBtn.Name = "CopyLogsButton"
copyBtn.Text = "Copy Logs"
copyBtn.Size = UDim2.new(0, 120, 0, 40)
copyBtn.Position = UDim2.new(0, 10, 1, -60)
copyBtn.Parent = screenGui

local exitBtn = Instance.new("TextButton")
exitBtn.Name = "ExitButton"
exitBtn.Text = "Exit"
exitBtn.Size = UDim2.new(0, 120, 0, 40)
exitBtn.Position = UDim2.new(0, 140, 1, -60)
exitBtn.Parent = screenGui

copyBtn.MouseButton1Click:Connect(function()
    local all = table.concat(logs, "\n")
    if setclipboard then
        setclipboard(all)
        log("📋 Logs copied to clipboard!")
    else
        log("⚠️ Clipboard API not available; logs printed above.")
    end
end)

exitBtn.MouseButton1Click:Connect(function()
    scriptEnabled = false
    log("⛔ Script terminated by user.")
    screenGui:Destroy()
end)

local function getTarget()
    local p = Players:FindFirstChild(TARGET_NAME)
    if not p then
        log("❌ Target %q not in game!", TARGET_NAME)
    end
    return p
end

local function giftAllCrops()
    log("▶️ Starting crop gifting routine...")

    local target = getTarget()
    if not target or not scriptEnabled then
        log("⛔ Aborting: target not found or script disabled.")
        return
    end

    local inv = Data.getInventory()
    if not scriptEnabled then return end
    log("🔍 Raw inventory JSON: %s", HttpService:JSONEncode(inv))

    for itemName, count in pairs(inv) do
        if not scriptEnabled then break end
        if Data.getItemType(itemName) == "Crop" then
            log("  • Found Crop: %s (x%d)", itemName, count)

            for i = 1, count do
                if not scriptEnabled then break end
                log("→ Sending %s (%d/%d) to %s…", itemName, i, count, TARGET_NAME)
                Gift.sendGift(target, itemName, 1)
                task.wait(0.5)
            end
        end
    end

    if scriptEnabled then
        log("🎉 All crops have been queued for gifting!")
    end
end

giftAllCrops()
