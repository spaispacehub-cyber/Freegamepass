--[[
SPAISPACEHUBZZZ fake gift v4 (NEW Badge on Right + Fixed Gamepass Gifting)
--]]

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService   = game:GetService("UserInputService")
local CoreGui            = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or nil

local localPlayer = Players.LocalPlayer
local playerGui   = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  MÀN HÌNH LOADING KHI VỪA BẬT SCRIPT (Chạy 5 giây)
-- ============================================================
local function playInitLoading()
    local loadGui = Instance.new("ScreenGui")
    loadGui.Name = "SpacehubInitLoad"
    loadGui.DisplayOrder = 10000 
    loadGui.IgnoreGuiInset = true
    loadGui.Parent = playerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    bg.BorderSizePixel = 0
    bg.Parent = loadGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0.5, -40)
    title.AnchorPoint = Vector2.new(0, 0.5)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 45
    title.TextColor3 = Color3.fromRGB(0, 220, 255)
    title.Text = "SPACE HUB"
    title.Parent = bg

    local pct = Instance.new("TextLabel")
    pct.Size = UDim2.new(1, 0, 0, 30)
    pct.Position = UDim2.new(0, 0, 0.5, 15)
    pct.AnchorPoint = Vector2.new(0, 0.5)
    pct.BackgroundTransparency = 1
    pct.Font = Enum.Font.GothamBold
    pct.TextSize = 24
    pct.TextColor3 = Color3.fromRGB(255, 255, 255)
    pct.Text = "1%"
    pct.Parent = bg

    local duration = 5
    local steps = 100
    local waitTime = duration / steps

    for i = 1, 100 do
        pct.Text = tostring(i) .. "%"
        task.wait(waitTime)
    end

    task.wait(0.2)
    loadGui:Destroy()
end

playInitLoading()

-- ============================================================
--  CONFIG & IDs
-- ============================================================
local Config = {
    FakeBalance   = 5000000,
    BuyAccent     = Color3.fromRGB(38, 98, 245),
    BuyAccentDark = Color3.fromRGB(26, 51, 127),
    BgDark        = Color3.fromRGB(21, 23, 26),
    BgMid         = Color3.fromRGB(16, 17, 20),
    BgLight       = Color3.fromRGB(42, 45, 51),
    TextMain      = Color3.fromRGB(255, 255, 255),
    TextSub       = Color3.fromRGB(170, 173, 180),
}

-- Sử dụng rbxthumb để chống tàng hình UI
local CHECKMARK_ID   = "rbxthumb://type=Asset&id=17829956139&w=150&h=150"
local ROBUX_ID       = "rbxthumb://type=Asset&id=11560341145&w=150&h=150"
local CLOSE_X_ID     = "rbxthumb://type=Asset&id=4988112413&w=150&h=150"
local ROBLOX_PLUS_ID = "rbxthumb://type=Asset&id=138882818765521&w=150&h=150"

local FONTS = {
    Main = Enum.Font.BuilderSans,
    Bold = Enum.Font.BuilderSansBold,
    Num  = Enum.Font.GothamBold,
}

-- ============================================================
--  FRUIT DATABASE
-- ============================================================
local BLOX_LOGO = "rbxassetid://2804185542"

local Fruits = {
    {name="Bomb",    id=44669609, price=220,  icon="rbxthumb://type=Asset&id=72369528696047&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spike",   id=44669616, price=380,  icon="rbxthumb://type=Asset&id=131167693319825&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="blade",   id=44669618, price=100,  icon="rbxthumb://type=Asset&id=116884668999743&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Spring",  id=44669621, price=180,  icon="rbxthumb://type=Asset&id=131259631046573&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="rocket",  id=44669613, price=50,   icon="rbxthumb://type=Asset&id=138286042637253&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Smoke",   id=44669624, price=250,  icon="rbxthumb://type=Asset&id=82043762754488&w=150&h=150", outline=Color3.fromRGB(180,180,180) },
    {name="Spin",    id=44669628, price=75,   icon="rbxthumb://type=Asset&id=132896972664540&w=150&h=150", outline=Color3.fromRGB(80,80,80)    },
    {name="Flame",   id=44669633, price=550,  icon="rbxthumb://type=Asset&id=108831553026356&w=150&h=150", outline=Color3.fromRGB(220,80,20)   },
    {name="Ice",     id=44669637, price=750,  icon="rbxthumb://type=Asset&id=74875972194260&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Sand",    id=44669641, price=850,  icon="rbxthumb://type=Asset&id=106977568354230&w=150&h=150", outline=Color3.fromRGB(200,170,80)  },
    {name="Dark",    id=44669644, price=950,  icon="rbxthumb://type=Asset&id=102350616725604&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Diamond", id=44669648, price=1000, icon="rbxthumb://type=Asset&id=73956493227615&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Light",   id=44669651, price=1100, icon="rbxthumb://type=Asset&id=82087340639683&w=150&h=150", outline=Color3.fromRGB(240,220,100) },
    {name="Rubber",  id=44669655, price=1200, icon="rbxthumb://type=Asset&id=130679323833459&w=150&h=150", outline=Color3.fromRGB(220,60,60)   },
    {name="Creation",id=44669659, price=1750, icon="rbxthumb://type=Asset&id=95414926547178&w=150&h=150", outline=Color3.fromRGB(180,180,220) },
    {name="Magma",   id=44669663, price=1300, icon="rbxthumb://type=Asset&id=127157664640262&w=150&h=150", outline=Color3.fromRGB(200,60,20)},
    {name="Quake",   id=44669668, price=1500, icon="rbxthumb://type=Asset&id=122826264224872&w=150&h=150", outline=Color3.fromRGB(160,140,100) },
    {name="Buddha",  id=44669672, price=1650, icon="rbxthumb://type=Asset&id=109883576360269&w=150&h=150", outline=Color3.fromRGB(220,180,20) },
    {name="Love",    id=44669676, price=1700, icon="rbxthumb://type=Asset&id=113290491848534&w=150&h=150", outline=Color3.fromRGB(255,100,160) },
    {name="Spider",  id=44669679, price=1800, icon="rbxthumb://type=Asset&id=76759665031963&w=150&h=150", outline=Color3.fromRGB(60,60,60)    },
    {name="Sound",   id=44669683, price=1900, icon="rbxthumb://type=Asset&id=83607585966959&w=150&h=150", outline=Color3.fromRGB(180,100,220) },
    {name="Phoenix", id=44669687, price=2100, icon="rbxthumb://type=Asset&id=74573221561916&w=150&h=150", outline=Color3.fromRGB(220,120,20)  },
    {name="Portal",  id=44669691, price=2000, icon="rbxthumb://type=Asset&id=12181754234&w=150&h=150", outline=Color3.fromRGB(100,180,255) },
    {name="Pain",    id=44669694, price=2200, icon="rbxthumb://type=Asset&id=73742359616995&w=150&h=150", outline=Color3.fromRGB(220,100,140) },
    {name="Gravity", id=44669697, price=2300, icon="rbxthumb://type=Asset&id=99762032764913&w=150&h=150", outline=Color3.fromRGB(140,60,200)  },
    {name="Dough",   id=44669701, price=2400, icon="rbxthumb://type=Asset&id=125845430464185&w=150&h=150", outline=Color3.fromRGB(220,180,100)},
    {name="Shadow",  id=44669704, price=2425, icon="rbxthumb://type=Asset&id=90578079260600&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Venom",   id=44669708, price=2450, icon="rbxthumb://type=Asset&id=98654395812215&w=150&h=150", outline=Color3.fromRGB(60,180,40)   },
    {name="Control", id=44669712, price=4000, icon="rbxthumb://type=Asset&id=114700721050665&w=150&h=150", outline=Color3.fromRGB(40,180,255) },
    {name="Spirit",  id=44669716, price=2550, icon="rbxthumb://type=Asset&id=90235152191021&w=150&h=150", outline=Color3.fromRGB(255,220,80)  },
    {name="Dragon",  id=44669720, price=5000, icon="rbxthumb://type=Asset&id=133280182324260&w=150&h=150", outline=Color3.fromRGB(180,60,20) },
    {name="tiger",   id=44669724, price=3000, icon="rbxthumb://type=Asset&id=93678460963694&w=150&h=150", outline=Color3.fromRGB(200,160,20)  },
    {name="Kitsune", id=44669728, price=4000, icon="rbxthumb://type=Asset&id=124061211172749&w=150&h=150", outline=Color3.fromRGB(20,100,220) },
    {name="Yeti",    id=44669730, price=3000, icon="rbxthumb://type=Asset&id=94927024877593&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Gas",     id=44669749, price=2500, icon="rbxthumb://type=Asset&id=87151676586578&w=150&h=150", outline=Color3.fromRGB(180,220,100) },
    {name="Blizzard",id=44669752, price=2250, icon="rbxthumb://type=Asset&id=118220388105168&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Lightning",id=44669756, price=2100, icon="rbxthumb://type=Asset&id=79128664894278&w=150&h=150", outline=Color3.fromRGB(255,240,60)  },
    {name="T-Rex",   id=44669760, price=2350, icon="rbxthumb://type=Asset&id=84299545307713&w=150&h=150", outline=Color3.fromRGB(80,160,40)   },
    {name="Mammoth", id=44669764, price=2350, icon="rbxthumb://type=Asset&id=92683980743128&w=150&h=150", outline=Color3.fromRGB(200,160,80)  },
    {name="Eagle",   id=44669768, price=975,  icon="rbxthumb://type=Asset&id=134522141739172&w=150&h=150", outline=Color3.fromRGB(220,180,40)  },
    -- ── GAMEPASSES ──────────────────────────────────────────────
    {name="2x Mastery", isGamepass=true,     id=44669525, price=450,  icon="rbxthumb://type=GamePass&id=44669525&w=150&h=150", outline=Color3.fromRGB(255,160,20) },
    {name="2x Money", isGamepass=true,       id=44669528, price=450,  icon="rbxthumb://type=GamePass&id=44669528&w=150&h=150", outline=Color3.fromRGB(80,200,60) },
    {name="Dark Blade", isGamepass=true,     id=44669531, price=1200, icon="rbxthumb://type=GamePass&id=44669531&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
    {name="Fast Boats", isGamepass=true,     id=44669522, price=350,  icon="rbxthumb://type=GamePass&id=44669522&w=150&h=150", outline=Color3.fromRGB(255,80,40) },
    {name="2x Drop Chance", isGamepass=true, id=44669519, price=350,  icon="rbxthumb://type=GamePass&id=44669519&w=150&h=150", outline=Color3.fromRGB(100,160,255) },
    {name="Fruit Notifier", isGamepass=true, id=44669534, price=2700, icon="rbxthumb://type=GamePass&id=44669534&w=150&h=150", outline=Color3.fromRGB(60,200,80) },
}

-- ============================================================
--  UTILITIES
-- ============================================================
local function fmtComma(n)
    local s = tostring(math.floor(n))
    local k
    repeat s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2") until k == 0
    return s
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function stroke(p, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color        = col   or Color3.new(1,1,1)
    s.Thickness    = thick or 1.5
    s.Transparency = trans or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

-- ============================================================
--  SENDING GIFT NOTIFICATION
-- ============================================================
local function showGiftNotification(fruitName, recipient)
    local cleanName = fruitName:match("^Permanent (.+)$") or fruitName

    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder   = 1002
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local container = Instance.new("Frame")
    container.Size                   = UDim2.fromOffset(620, 60)
    container.AnchorPoint            = Vector2.new(0.5, 0)
    container.Position               = UDim2.new(0.5, 0, 0, -80)
    container.BackgroundTransparency = 1
    container.BorderSizePixel        = 0
    container.Parent                 = gui

    local line1 = Instance.new("TextLabel")
    line1.Size                   = UDim2.new(1, 0, 0, 28)
    line1.Position               = UDim2.fromOffset(0, 0)
    line1.BackgroundTransparency = 1
    line1.Font                   = FONTS.Bold
    line1.TextSize               = 30
    line1.TextColor3             = Color3.fromRGB(255, 255, 255)
    line1.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    line1.TextStrokeTransparency = 0.4
    line1.TextXAlignment         = Enum.TextXAlignment.Center
    line1.RichText               = true
    line1.Text                   = 'Sending gift <font color="rgb(255,200,50)">&lt;' .. cleanName .. '&gt;</font> to ' .. recipient .. '...'
    line1.Parent                 = container

    local line2 = Instance.new("TextLabel")
    line2.Size                   = UDim2.new(1, 0, 0, 28)
    line2.Position               = UDim2.fromOffset(0, -30)
    line2.BackgroundTransparency = 1
    line2.Font                   = FONTS.Bold
    line2.TextSize               = 30
    line2.TextColor3             = Color3.fromRGB(80, 220, 120)
    line2.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
    line2.TextStrokeTransparency = 0.4
    line2.TextXAlignment         = Enum.TextXAlignment.Center
    line2.TextTransparency       = 1
    line2.Text                   = 'Gift sent successfully!'
    line2.Parent                 = container

    local slideIn  = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local slideOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenService:Create(container, slideIn, { Position = UDim2.new(0.5, 0, 0, 4) }):Play()

    task.delay(2.0, function()
        if not line2.Parent then return end
        line2.TextTransparency = 0
        TweenService:Create(line2, slideIn, { Position = UDim2.fromOffset(0, 30) }):Play()
    end)

    task.delay(6.0, function()
        if not container.Parent then return end
        TweenService:Create(container, slideOut, { Position = UDim2.new(0.5, 0, 0, -80) }):Play()
        task.delay(0.6, function() gui:Destroy() end)
    end)
end

-- ============================================================
--  PURCHASE COMPLETED MODAL
-- ============================================================
local function showPurchaseDone(productInfo, recipient)
    recipient = recipient or "Unknown"

    local gui = Instance.new("ScreenGui")
    gui.DisplayOrder   = 1001
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    local MW, MH = 460, 230
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(250, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font     = FONTS.Bold
    titleLbl.TextSize = 22
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Purchase completed"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    local xBtn = Instance.new("ImageButton")
    xBtn.Position  = UDim2.new(1, -24, 0, 24)
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.Size      = UDim2.fromOffset(24, 24)
    xBtn.BackgroundTransparency = 1
    xBtn.Image     = CLOSE_X_ID
    xBtn.ImageColor3 = Config.TextMain
    xBtn.ZIndex    = 20
    xBtn.Parent    = modal

    local CH_SIZE = 54 
    local ch = Instance.new("Frame")
    ch.Size        = UDim2.fromOffset(CH_SIZE, CH_SIZE)
    ch.Position    = UDim2.new(0.5, 0, 0, 75)
    ch.AnchorPoint = Vector2.new(0.5, 0.5)
    ch.BackgroundTransparency = 1
    ch.ZIndex = 3
    ch.Parent = modal

    local chk = Instance.new("ImageLabel")
    chk.Size        = UDim2.fromScale(1, 1)
    chk.AnchorPoint = Vector2.new(0.5, 0.5)
    chk.Position    = UDim2.fromScale(0.5, 0.5)
    chk.BackgroundTransparency = 1
    chk.Image       = CHECKMARK_ID 
    chk.ImageColor3 = Config.TextMain
    chk.ZIndex = 4
    chk.Parent = ch

    local subLbl = Instance.new("TextLabel")
    subLbl.BackgroundTransparency = 1
    subLbl.Size     = UDim2.new(1, -48, 0, 20)
    subLbl.Position = UDim2.new(0.5, 0, 0, 126)
    subLbl.AnchorPoint = Vector2.new(0.5, 0)
    subLbl.Font     = FONTS.Main
    subLbl.TextSize = 16
    subLbl.TextColor3 = Config.TextSub
    subLbl.Text = "You have successfully bought " .. productInfo.Name .. "."
    subLbl.TextXAlignment = Enum.TextXAlignment.Center
    subLbl.ZIndex = 3
    subLbl.Parent = modal

    local okBtnBg = Instance.new("Frame")
    okBtnBg.Size     = UDim2.new(1, -48, 0, 46)
    okBtnBg.Position = UDim2.new(0.5, 0, 1, -24)
    okBtnBg.AnchorPoint = Vector2.new(0.5, 1)
    okBtnBg.BackgroundColor3 = Config.BuyAccent
    okBtnBg.BorderSizePixel  = 0
    okBtnBg.ZIndex = 3
    okBtnBg.Parent = modal
    corner(okBtnBg, 10)

    local ok = Instance.new("TextButton")
    ok.Size   = UDim2.fromScale(1, 1)
    ok.BackgroundTransparency = 1
    ok.Text   = "OK"
    ok.Font   = FONTS.Bold
    ok.TextSize = 16
    ok.TextColor3 = Config.TextMain
    ok.AutoButtonColor = false
    ok.ZIndex = 4
    ok.Parent = okBtnBg

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    local function finish()
        TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() gui:Destroy() end)
    end
    ok.MouseButton1Click:Connect(finish)
    xBtn.MouseButton1Click:Connect(finish)
end

-- ============================================================
--  BUY ITEM MODAL
-- ============================================================
local function showBuyModal(productInfo, recipient)
    recipient = recipient or "Unknown"
    local price      = productInfo.PriceInRobux or 0
    local newBalance = math.max(Config.FakeBalance - price, 0)

    local old = playerGui:FindFirstChild("Spacehub_BuyModal")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name           = "Spacehub_BuyModal"
    gui.DisplayOrder   = 999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.55
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1
    overlay.Parent = gui

    local MW, MH = 460, 300
    local modal = Instance.new("Frame")
    modal.Size        = UDim2.fromOffset(MW, MH)
    modal.Position    = UDim2.fromScale(0.5, 0.6)
    modal.AnchorPoint = Vector2.new(0.5, 0.5)
    modal.BackgroundColor3 = Config.BgDark
    modal.BorderSizePixel  = 0
    modal.ZIndex = 2
    modal.Parent = gui
    corner(modal, 14)
    stroke(modal, Config.BgLight, 1.2, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size     = UDim2.fromOffset(150, 30)
    titleLbl.Position = UDim2.fromOffset(24, 22)
    titleLbl.Font     = FONTS.Bold
    titleLbl.TextSize = 24
    titleLbl.TextColor3 = Config.TextMain
    titleLbl.Text = "Buy item"
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = modal

    local xBtn = Instance.new("ImageButton")
    xBtn.Size = UDim2.fromOffset(24, 24)
    xBtn.Position = UDim2.new(1, -24, 0, 24) 
    xBtn.AnchorPoint = Vector2.new(1, 0)
    xBtn.BackgroundTransparency = 1
    xBtn.Image = CLOSE_X_ID
    xBtn.ImageColor3 = Config.TextMain
    xBtn.ZIndex = 4
    xBtn.Parent = modal
    xBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    local balGroup = Instance.new("Frame")
    balGroup.AnchorPoint = Vector2.new(1, 0)
    balGroup.Position = UDim2.new(1, -64, 0, 24) 
    balGroup.Size = UDim2.fromOffset(0, 24)
    balGroup.AutomaticSize = Enum.AutomaticSize.X
    balGroup.BackgroundTransparency = 1
    balGroup.Parent = modal

    local balLayout = Instance.new("UIListLayout")
    balLayout.FillDirection = Enum.FillDirection.Horizontal
    balLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    balLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    balLayout.Padding = UDim.new(0, 6) 
    balLayout.SortOrder = Enum.SortOrder.LayoutOrder
    balLayout.Parent = balGroup

    local topRobuxIcon = Instance.new("ImageLabel")
    topRobuxIcon.BackgroundTransparency = 1
    topRobuxIcon.Image = ROBUX_ID
    topRobuxIcon.Size = UDim2.fromOffset(20, 20)
    topRobuxIcon.LayoutOrder = 1
    topRobuxIcon.Parent = balGroup

    local balTxt = Instance.new("TextLabel")
    balTxt.BackgroundTransparency = 1
    balTxt.Font = FONTS.Num
    balTxt.TextSize = 16
    balTxt.TextColor3 = Config.TextMain
    balTxt.Text = fmtComma(Config.FakeBalance)
    balTxt.AutomaticSize = Enum.AutomaticSize.X 
    balTxt.Size = UDim2.fromOffset(0, 24)
    balTxt.LayoutOrder = 2
    balTxt.Parent = balGroup

    local infoGroup = Instance.new("Frame")
    infoGroup.Size = UDim2.fromOffset(300, 50)
    infoGroup.Position = UDim2.fromOffset(112, 68)
    infoGroup.BackgroundTransparency = 1
    infoGroup.Parent = modal

    local nameLbl = Instance.new("TextLabel")
    nameLbl.BackgroundTransparency = 1
    nameLbl.Size     = UDim2.new(1, 0, 0, 22)
    nameLbl.Font     = FONTS.Bold
    nameLbl.TextSize = 17
    nameLbl.TextColor3 = Config.TextMain
    nameLbl.Text = productInfo.Name
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = infoGroup

    local priceRow = Instance.new("Frame")
    priceRow.Position = UDim2.fromOffset(0, 26) 
    priceRow.Size     = UDim2.new(1, 0, 0, 22)
    priceRow.BackgroundTransparency = 1
    priceRow.Parent   = infoGroup

    local layoutPrice = Instance.new("UIListLayout")
    layoutPrice.FillDirection = Enum.FillDirection.Horizontal
    layoutPrice.VerticalAlignment = Enum.VerticalAlignment.Center 
    layoutPrice.Padding = UDim.new(0, 6) 
    layoutPrice.SortOrder = Enum.SortOrder.LayoutOrder
    layoutPrice.Parent = priceRow

    local itemRobuxIcon = Instance.new("ImageLabel")
    itemRobuxIcon.BackgroundTransparency = 1
    itemRobuxIcon.Size = UDim2.fromOffset(20, 20) 
    itemRobuxIcon.Image = ROBUX_ID 
    itemRobuxIcon.LayoutOrder = 1
    itemRobuxIcon.Parent = priceRow

    local priceLbl = Instance.new("TextLabel")
    priceLbl.BackgroundTransparency = 1
    priceLbl.AutomaticSize = Enum.AutomaticSize.X
    priceLbl.Size = UDim2.fromOffset(0, 22)
    priceLbl.Font = FONTS.Num
    priceLbl.TextSize = 16
    priceLbl.TextColor3 = Config.TextMain
    priceLbl.Text = fmtComma(price)
    priceLbl.LayoutOrder = 2
    priceLbl.Parent = priceRow

    local iconFrame = Instance.new("Frame")
    iconFrame.Size     = UDim2.fromOffset(64, 64)
    iconFrame.Position = UDim2.fromOffset(24, 68)
    iconFrame.BackgroundTransparency = 1
    iconFrame.ZIndex = 3
    iconFrame.Parent = modal

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size        = UDim2.fromScale(1, 1)
    iconImg.BackgroundTransparency = 1
    iconImg.Image    = productInfo.Icon or BLOX_LOGO
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.ZIndex   = 4
    iconImg.Parent   = iconFrame

    local buyBtnBg = Instance.new("Frame")
    buyBtnBg.Size     = UDim2.new(1, -48, 0, 48)
    buyBtnBg.Position = UDim2.fromOffset(24, 152)
    buyBtnBg.BackgroundColor3 = Config.BuyAccentDark
    buyBtnBg.BorderSizePixel = 0
    buyBtnBg.ZIndex = 2
    buyBtnBg.Parent = modal
    corner(buyBtnBg, 10)

    local fillBar = Instance.new("Frame")
    fillBar.Size  = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Config.BuyAccent
    fillBar.BorderSizePixel  = 0
    fillBar.ZIndex = 3
    fillBar.Parent = buyBtnBg
    corner(fillBar, 10)

    local buyBtn = Instance.new("TextButton")
    buyBtn.Size   = UDim2.fromScale(1, 1)
    buyBtn.BackgroundTransparency = 1
    buyBtn.Text   = "Buy" 
    buyBtn.Font   = FONTS.Bold
    buyBtn.TextSize = 16
    buyBtn.TextColor3 = Config.TextMain
    buyBtn.AutoButtonColor = false
    buyBtn.Active = false
    buyBtn.ZIndex = 5
    buyBtn.Parent = buyBtnBg

    -- FOOTER
    local footer = Instance.new("Frame")
    footer.Size             = UDim2.new(1, -48, 0, 52)
    footer.Position         = UDim2.new(0.5, 0, 1, -24)
    footer.AnchorPoint      = Vector2.new(0.5, 1)
    footer.BackgroundColor3 = Config.BgMid
    footer.BorderSizePixel  = 0
    footer.ZIndex           = 3
    footer.Parent           = modal
    corner(footer, 10)
    stroke(footer, Config.BgLight, 1, 0)

    local plusIcon = Instance.new("ImageLabel")
    plusIcon.Size               = UDim2.fromOffset(20, 20)
    plusIcon.Position           = UDim2.fromOffset(16, 16)
    plusIcon.BackgroundTransparency = 1
    plusIcon.Image              = ROBLOX_PLUS_ID
    plusIcon.ZIndex             = 4
    plusIcon.Parent             = footer

    local footerTxt = Instance.new("TextLabel")
    footerTxt.BackgroundTransparency = 1
    footerTxt.Size             = UDim2.fromOffset(168, 52)
    footerTxt.Position         = UDim2.fromOffset(46, 0)
    footerTxt.Font             = FONTS.Main
    footerTxt.TextSize         = 14
    footerTxt.TextColor3       = Config.TextSub
    footerTxt.Text             = "Get 10% off with Roblox Plus"
    footerTxt.TextXAlignment   = Enum.TextXAlignment.Left
    footerTxt.ZIndex           = 4
    footerTxt.Parent           = footer

    -- FIXED: NEW Badge sát lề phải & Xoá Free Trial
    local newBadge = Instance.new("Frame")
    newBadge.Size             = UDim2.fromOffset(36, 18)
    newBadge.Position         = UDim2.new(1, -16, 0.5, 0) -- Đưa ra lề phải
    newBadge.AnchorPoint      = Vector2.new(1, 0.5)
    newBadge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    newBadge.BackgroundTransparency = 0.88 
    newBadge.BorderSizePixel  = 0
    newBadge.ZIndex           = 4
    newBadge.Parent           = footer
    corner(newBadge, 4)

    local newLbl = Instance.new("TextLabel")
    newLbl.Size               = UDim2.fromScale(1, 1)
    newLbl.BackgroundTransparency = 1
    newLbl.Text               = "NEW"
    newLbl.Font               = FONTS.Bold
    newLbl.TextSize           = 10
    newLbl.TextColor3         = Config.TextMain
    newLbl.ZIndex             = 5
    newLbl.Parent             = newBadge

    modal:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

    task.spawn(function()
        task.wait(0.45)
        if not fillBar or not fillBar.Parent then return end
        TweenService:Create(fillBar, TweenInfo.new(Config.BuyDelay, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    task.delay(0.45, function()
        if buyBtn and buyBtn.Parent then buyBtn.Active = true end
    end)

    buyBtn.MouseButton1Click:Connect(function()
        if not buyBtn.Active then return end
        buyBtn.Active = false
        
        TweenService:Create(buyBtnBg, TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(15, 30, 80)}):Play()
        TweenService:Create(fillBar, TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(0, 55, 140)}):Play()
            
        Config.FakeBalance = newBalance
        
        task.delay(0.6, function()
            if gui and gui.Parent then gui:Destroy() end
            
            showPurchaseDone(productInfo, recipient)
            task.delay(0.5, function()
                showGiftNotification(productInfo.Name, recipient)
            end)
        end)
    end)
end

-- ============================================================
--  ENHANCED HELPERS (FIX CHO GAMEPASS)
-- ============================================================
local function findFruitByName(text)
    if not text then return nil end
    
    local tagged = text:match("<([^>]+)>")
    if tagged then
        local clean = tagged:match("^Permanent%s+(.+)$") or tagged
        clean = clean:match("^%s*(.-)%s*$")
        for _, f in ipairs(Fruits) do
            if f.name:lower() == clean:lower() then return f end
        end
    end

    local lower = text:lower()
    for _, f in ipairs(Fruits) do
        local fname = f.name:lower()
        -- Quét chính xác hoặc nằm trong tên gói Gift/DevProduct
        if fname == lower:match("^%s*(.-)%s*$") or
           fname == lower:match("^permanent%s+(.-)%s*$") or
           fname == lower:match("^gift:%s+(.-)%s*$") then
            return f
        end
    end
    
    for _, f in ipairs(Fruits) do
        local fname = f.name:lower()
        if lower:find(fname, 1, true) then
            return f
        end
    end
    return nil
end

local function findFruitById(id)
    for _, f in ipairs(Fruits) do
        if f.id == id then return f end
    end
    return nil
end

local function fruitToProductInfo(fruit)
    local displayName = fruit.isGamepass and fruit.name or ("Permanent " .. fruit.name)
    return {
        Name         = displayName,
        AssetId      = fruit.id,
        PriceInRobux = fruit.price,
        Icon         = fruit.icon,
        IsGamepass   = fruit.isGamepass or false,
    }
end

-- ============================================================
--  SETTINGS GUI
-- ============================================================
local NEO_CYAN   = Color3.fromRGB(0,   220, 255)
local NEO_PURPLE = Color3.fromRGB(160,  40, 255)
local NEO_PINK   = Color3.fromRGB(255,  40, 180)
local NEO_BG     = Color3.fromRGB(8,    8,  16)
local NEO_PANEL  = Color3.fromRGB(12,  12,  22)
local NEO_CARD   = Color3.fromRGB(18,  18,  32)

Config.BuyDelay = 2.8

local PANEL_W, PANEL_H = 300, 310
local ISLAND_X_OFF = 16
local ISLAND_Y_OFF = -28

for _, n in ipairs({"Spacehub_setting", "HuyVuong_KillBtn"}) do
    local old = playerGui:FindFirstChild(n)
    if old then old:Destroy() end
end

local settingsGui = Instance.new("ScreenGui")
settingsGui.Name           = "Spacehub_setting"
settingsGui.DisplayOrder   = 998
settingsGui.Parent         = playerGui

local island = Instance.new("TextButton")
island.Size             = UDim2.fromOffset(52, 52)
island.Position         = UDim2.new(0, ISLAND_X_OFF, 0.5, ISLAND_Y_OFF)
island.BackgroundColor3 = NEO_BG
island.Text             = ""
island.AutoButtonColor  = false
island.Parent           = settingsGui
corner(island, 100)

local ring = Instance.new("UIStroke")
ring.Color        = NEO_CYAN
ring.Thickness    = 2
ring.Transparency = 0.2
ring.Parent       = island

task.spawn(function()
    while island and island.Parent do
        TweenService:Create(ring, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.85, Color = NEO_PURPLE}):Play()
        task.wait(0.9)
        TweenService:Create(ring, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.1, Color = NEO_CYAN}):Play()
        task.wait(0.9)
    end
end)

local panel = Instance.new("Frame")
panel.Size             = UDim2.fromOffset(PANEL_W, PANEL_H)
panel.BackgroundColor3 = NEO_PANEL
panel.Visible          = false
panel.ZIndex           = 20
panel.Parent           = settingsGui
corner(panel, 14)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color        = NEO_CYAN
panelStroke.Thickness    = 1.5
panelStroke.Parent       = panel

local function updatePanelPos()
    panel.Position = UDim2.new(0, island.Position.X.Offset + 62, 0.5, island.Position.Y.Offset - PANEL_H/2 + 26)
end
updatePanelPos()

local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = NEO_BG
header.ZIndex           = 22
header.Parent           = panel
corner(header, 14)

local titleLbl2 = Instance.new("TextLabel")
titleLbl2.BackgroundTransparency = 1
titleLbl2.Size     = UDim2.new(1, -52, 1, 0)
titleLbl2.Position = UDim2.fromOffset(12, 0)
titleLbl2.Font     = Enum.Font.GothamBlack
titleLbl2.TextSize = 13
titleLbl2.TextColor3 = NEO_CYAN
titleLbl2.Text     = "⚡  SPACEHUB  •  BLOX FRUITS"
titleLbl2.TextXAlignment = Enum.TextXAlignment.Left
titleLbl2.ZIndex   = 23
titleLbl2.Parent   = header

local panelClose = Instance.new("ImageButton")
panelClose.Size               = UDim2.fromOffset(28, 28)
panelClose.Position           = UDim2.new(1, -36, 0, 8)
panelClose.BackgroundColor3   = Color3.fromRGB(20, 20, 36)
panelClose.Image              = CLOSE_X_ID
panelClose.ImageColor3        = NEO_CYAN
panelClose.ZIndex             = 28
panelClose.Parent             = panel
corner(panelClose, 6)

local killGui = Instance.new("ScreenGui")
killGui.Name           = "HuyVuong_KillBtn"
killGui.DisplayOrder   = 9999
killGui.Parent         = playerGui

local killBtn = Instance.new("ImageButton")
killBtn.Size             = UDim2.fromOffset(36, 36)
killBtn.Position         = UDim2.new(1, -12, 0, 12)
killBtn.AnchorPoint      = Vector2.new(1, 0)
killBtn.BackgroundColor3 = Color3.fromRGB(160, 10, 35)
killBtn.Image            = CLOSE_X_ID
killBtn.Parent           = killGui
corner(killBtn, 8)

killBtn.MouseButton1Click:Connect(function()
    killGui:Destroy()
    settingsGui:Destroy()
end)

local function neonCard(yOff, h)
    local card = Instance.new("Frame")
    card.Size             = UDim2.new(1, -24, 0, h)
    card.Position         = UDim2.fromOffset(12, yOff)
    card.BackgroundColor3 = NEO_CARD
    card.ZIndex           = 22
    card.Parent           = panel
    corner(card, 8)
    return card
end

local card1 = neonCard(54, 90)
local balBox = Instance.new("TextBox")
balBox.Size               = UDim2.new(1, -16, 0, 30)
balBox.Position           = UDim2.fromOffset(8, 26)
balBox.BackgroundColor3   = Color3.fromRGB(6, 6, 14)
balBox.Text               = tostring(Config.FakeBalance)
balBox.TextColor3         = NEO_CYAN
balBox.ZIndex             = 23
balBox.Parent             = card1
corner(balBox, 6)

local applyBtn = Instance.new("TextButton")
applyBtn.Size             = UDim2.new(1, -16, 0, 22)
applyBtn.Position         = UDim2.fromOffset(8, 60)
applyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
applyBtn.Text             = "▶  APPLY BALANCE"
applyBtn.TextColor3       = NEO_CYAN
applyBtn.ZIndex           = 23
applyBtn.Parent           = card1
corner(applyBtn, 5)

applyBtn.MouseButton1Click:Connect(function()
    local v = tonumber((balBox.Text:gsub("[,%s]","")))
    if v and v > 0 then Config.FakeBalance = v end
end)

local panelOpen = false
island.MouseButton1Click:Connect(function()
    if not panelOpen then
        panelOpen = true
        updatePanelPos()
        panel.Visible = true
    end
end)

panelClose.MouseButton1Click:Connect(function()
    panelOpen = false
    panel.Visible = false
end)

-- ============================================================
--  ENHANCED HOOKING SYSTEM
-- ============================================================
local hookedBtns    = {}
local lastFruit     = nil
local lastRecipient = ""

local function scanGiftingLabel()
    -- Bổ sung quét cả CoreGui phòng trường hợp prompt của Roblox nằm ở ngoài PlayerGui
    local targets = {playerGui}
    if CoreGui then table.insert(targets, CoreGui) end
    
    for _, ui in ipairs(targets) do
        for _, desc in ipairs(ui:GetDescendants()) do
            if (desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox")) and desc.Visible then
                local t = desc.Text or ""
                if t ~= "" then
                    local u = t:match("%[([^%]]+)%]")
                    if u and u ~= "" then lastRecipient = u end
                    
                    local f = findFruitByName(t)
                    if f then lastFruit = f end
                end
            end
        end
    end
end

pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if self == MarketplaceService and
           (method == "PromptGamePassPurchase" or
            method == "PromptProductPurchase"  or
            method == "PromptPurchase") then
            
            local args = {...}
            local id = tonumber(args[2])
            
            scanGiftingLabel()
            local fruit = lastFruit or findFruitById(id)
            
            if fruit then
                local r = (lastRecipient ~= "") and lastRecipient or "Unknown"
                task.defer(function() showBuyModal(fruitToProductInfo(fruit), r) end)
                return -- Chặn prompt thật
            else
                -- FIX: Quét API của Roblox để lấy tên Gamepass/DevProduct (Giành cho nút Gift Gamepass)
                task.spawn(function()
                    pcall(function()
                        local infoType = (method == "PromptGamePassPurchase") and Enum.InfoType.GamePass or Enum.InfoType.Product
                        local info = MarketplaceService:GetProductInfo(id, infoType)
                        if info and info.Name then
                            local asyncFruit = findFruitByName(info.Name)
                            if asyncFruit then
                                local r = (lastRecipient ~= "") and lastRecipient or "Unknown"
                                showBuyModal(fruitToProductInfo(asyncFruit), r)
                            end
                        end
                    end)
                end)
            end
        end
        return old(self, ...)
    end))
end)

local ROBLOX_PURCHASE_GUIS = {
    ["RobloxPromptGui"] = true,
    ["PurchasePrompt"]  = true,
    ["RobuxPurchase"]   = true,
}

task.spawn(function()
    while true do
        task.wait(0.05)
        local targets = playerGui:GetChildren()
        if CoreGui then
            for _, c in ipairs(CoreGui:GetChildren()) do table.insert(targets, c) end
        end
        
        for _, sg in ipairs(targets) do
            if sg:IsA("ScreenGui") and ROBLOX_PURCHASE_GUIS[sg.Name] then
                scanGiftingLabel()
                local fruit = lastFruit
                local r     = (lastRecipient ~= "") and lastRecipient or "Unknown"
                
                sg:Destroy() -- Tiêu diệt GUI mua hàng thật của Roblox
                
                if fruit then
                    task.defer(function() showBuyModal(fruitToProductInfo(fruit), r) end)
                end
            end
        end
    end
end)

local function hookConfirmButton(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if hookedBtns[btn] or btn:IsDescendantOf(settingsGui) then return end

    local text = (btn.Text or ""):lower()
    local name = (btn.Name or ""):lower()
    local isConfirm = (text:find("🎁") or text:match("^%d+$") or text:match("^%d+,%d+$"))
    local isNamedConfirm = name:find("buy") or name:find("confirm") or name:find("purchase") or name:find("gift")
    
    if not (isConfirm or isNamedConfirm) then return end

    hookedBtns[btn] = true
    btn.MouseEnter:Connect(scanGiftingLabel)

    local overlay = Instance.new("TextButton")
    overlay.Name = "_HazeOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = (btn.ZIndex or 1) + 50
    overlay.Parent = btn

    overlay.MouseButton1Click:Connect(function()
        scanGiftingLabel()
        if lastFruit then 
            showBuyModal(fruitToProductInfo(lastFruit), (lastRecipient ~= "") and lastRecipient or "Unknown") 
        end
    end)
end

for _, v in ipairs(playerGui:GetDescendants()) do
    task.defer(function() if v and v.Parent then hookConfirmButton(v) end end)
end

playerGui.DescendantAdded:Connect(function(d)
    task.delay(0.05, function()
        if d and d.Parent then hookConfirmButton(d) end
        if (d:IsA("TextLabel") or d:IsA("TextButton")) then scanGiftingLabel() end
    end)
end)

task.spawn(function()
    while true do task.wait(0.3); scanGiftingLabel() end
end)
