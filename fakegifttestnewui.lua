--[[
SPAISPACEHUBZZZ fake gift v5 (Sharp UI + Static Checkmark + Gamepass Gift FIX + Old Settings + Processing UI Fixed 100%)
--]]

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService   = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui   = localPlayer:WaitForChild("PlayerGui")

-- ============================================================
--  MÀN HÌNH LOADING KHI VỪA BẬT SCRIPT (Chạy 5 giây)
-- ============================================================
local function playInitLoading()
    local loadGui = Instance.new("ScreenGui")
    loadGui.Name = "SpacehubInitLoad"
    loadGui.DisplayOrder = 10000 -- Đè lên mọi thứ
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
--  CONFIG & NEW IDs
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
    {name="Portal",  id=44669691, price=2000, icon="rbxthumb://type=Asset&id=94551022243633&w=150&h=150", outline=Color3.fromRGB(100,180,255) },
    {name="Pain",    id=44669694, price=2200, icon="rbxthumb://type=Asset&id=73742359616995&w=150&h=150", outline=Color3.fromRGB(220,100,140) },
    {name="Gravity", id=44669697, price=2300, icon="rbxthumb://type=Asset&id=99762032764913&w=150&h=150", outline=Color3.fromRGB(140,60,200)  },
    {name="Dough",   id=44669701, price=2400, icon="rbxthumb://type=Asset&id=122612389729719&w=150&h=150", outline=Color3.fromRGB(220,180,100)},
    {name="Shadow",  id=44669704, price=2425, icon="rbxthumb://type=Asset&id=90578079260600&w=150&h=150", outline=Color3.fromRGB(80,20,120)   },
    {name="Venom",   id=44669708, price=2450, icon="rbxthumb://type=Asset&id=98654395812215&w=150&h=150", outline=Color3.fromRGB(60,180,40)   },
    {name="Control", id=44669712, price=4000, icon="rbxthumb://type=Asset&id=114700721050665&w=150&h=150", outline=Color3.fromRGB(40,180,255) },
    {name="Spirit",  id=44669716, price=2550, icon="rbxthumb://type=Asset&id=90235152191021&w=150&h=150", outline=Color3.fromRGB(255,220,80)  },
    {name="Dragon",  id=44669720, price=5000, icon="rbxthumb://type=Asset&id=133280182324260&w=150&h=150", outline=Color3.fromRGB(180,60,20) },
    {name="tiger",   id=44669724, price=3000, icon="rbxthumb://type=Asset&id=93678460963694&w=150&h=150", outline=Color3.fromRGB(200,160,20)  },
    {name="Kitsune", id=44669728, price=4000, icon="rbxthumb://type=Asset&id=124061211172749&w=150&h=150", outline=Color3.fromRGB(20,100,220) },
    {name="Yeti",    id=44669730, price=3000, icon="rbxthumb://type=Asset&id=94927024877593&w=150&h=150", outline=Color3.fromRGB(160,220,255) },
    {name="Gas",     id=44669749, price=2500, icon="rbxthumb://type=Asset&id=122180016987387&w=150&h=150", outline=Color3.fromRGB(180,220,100) },
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

    local newBadge = Instance.new("Frame")
    newBadge.Size             = UDim2.fromOffset(36, 18)
    newBadge.Position         = UDim2.new(1, -16, 0.5, 0)
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
--  PROCESSING PURCHASE MODAL (ĐÃ FIX: XOÁ NỀN ĐEN 100%)
-- ============================================================
local function showProcessingModal(productInfo, recipient)
    local gui = Instance.new("ScreenGui")
    gui.Name           = "Spacehub_Processing"
    gui.DisplayOrder   = 1005
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent         = playerGui

    -    -- Thay đổi kích thước và vị trí tại đây
    local box = Instance.new("Frame")
    box.Size = UDim2.fromOffset(120, 120) -- Thu nhỏ kích thước khung (từ 160 xuống 120)
    box.Position = UDim2.fromScale(0.5, 0.5)
    box.AnchorPoint = Vector2.new(0.5, 0.5) -- Đảm bảo luôn ở giữa
    box.BackgroundTransparency = 1 
    box.BorderSizePixel = 0
    box.ZIndex = 2
    box.Parent = gui

    -- Chỉnh lại kích thước icon cho cân đối với khung mới
    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.fromOffset(60, 60) -- Thu nhỏ icon (từ 80 xuống 60)
    iconImg.Position = UDim2.new(0.5, 0, 0, 15) -- Dịch lên một chút
    -- ... các dòng còn lại giữ nguyên

    iconImg.AnchorPoint = Vector2.new(0.5, 0)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = productInfo.Icon or BLOX_LOGO
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.ZIndex = 3
    iconImg.Parent = box

    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, 0, 0, 30)
    textLbl.Position = UDim2.new(0.5, 0, 1, -40)
    textLbl.AnchorPoint = Vector2.new(0.5, 0)
    textLbl.BackgroundTransparency = 1
    textLbl.Font = FONTS.Main
    textLbl.TextSize = 16
    textLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLbl.TextStrokeTransparency = 0.5 -- Thêm tí viền bóng mờ cho chữ dễ đọc trên nền game
    textLbl.Text = "Processing Purchase"
    textLbl.ZIndex = 3
    textLbl.Parent = box

    task.spawn(function()
        local dots = {"", ".", "..", "..."}
        for i = 0, 8 do
            if not textLbl.Parent then break end
            textLbl.Text = "Processing Purchase" .. dots[(i % 4) + 1]
            task.wait(0.3)
        end
        if gui.Parent then gui:Destroy() end
        -- Hiện ra UI Buy
        showBuyModal(productInfo, recipient)
    end)
end

-- ============================================================
--  HELPERS
-- ============================================================
local sortedFruits = {}
for _, f in ipairs(Fruits) do table.insert(sortedFruits, f) end
table.sort(sortedFruits, function(a, b) return #a.name > #b.name end)

local function findFruitByName(text)
    if not text then return nil end

    local fromTag = text:match("<Permanent%s+(.-)>") or text:match("Permanent%s+(%a+)")
    if fromTag then
        local clean = fromTag:match("^%s*(.-)%s*$")
        for _, f in ipairs(sortedFruits) do
            if f.name:lower() == clean:lower() then return f end
        end
    end

    local lower = text:lower()
    for _, f in ipairs(sortedFruits) do
        if f.name:lower() == lower:match("^%s*(.-)%s*$") then return f end
    end

    for _, f in ipairs(sortedFruits) do
        local fname = f.name:lower()
        if lower:match("[^%a%d]" .. fname .. "[^%a%d]")
            or lower:match("^" .. fname .. "[^%a%d]")
            or lower:match("[^%a%d]" .. fname .. "$")
            or lower:match("^" .. fname .. "$") then
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
        Outline      = fruit.outline,
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

Config.BuyDelay = 3

local PANEL_W, PANEL_H = 300, 310
local ISLAND_X_OFF = 16
local ISLAND_Y_OFF = -28

for _, n in ipairs({"Spacehub_setting", "HuyVuong_setting", "HuyVuong_KillBtn"}) do
    local old = playerGui:FindFirstChild(n)
    if old then old:Destroy() end
end

local settingsGui = Instance.new("ScreenGui")
settingsGui.Name           = "Spacehub_setting"
settingsGui.DisplayOrder   = 998
settingsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
settingsGui.ResetOnSpawn   = false
settingsGui.Parent         = playerGui

local island = Instance.new("TextButton")
island.Size             = UDim2.fromOffset(52, 52)
island.Position         = UDim2.new(0, ISLAND_X_OFF, 0.5, ISLAND_Y_OFF)
island.BackgroundColor3 = NEO_BG
island.Text             = ""
island.AutoButtonColor  = false
island.ZIndex           = 30
island.Parent           = settingsGui
corner(island, 100)

local islandGlow = Instance.new("ImageLabel")
islandGlow.Size               = UDim2.fromOffset(76, 76)
islandGlow.AnchorPoint        = Vector2.new(0.5, 0.5)
islandGlow.Position           = UDim2.fromScale(0.5, 0.5)
islandGlow.BackgroundTransparency = 1
islandGlow.Image              = "rbxassetid://5028857084"
islandGlow.ImageColor3        = NEO_CYAN
islandGlow.ImageTransparency  = 0.35
islandGlow.ZIndex              = 29
islandGlow.Parent              = island

local islandIcon = Instance.new("ImageLabel")
islandIcon.Size               = UDim2.fromOffset(30, 30)
islandIcon.AnchorPoint        = Vector2.new(0.5, 0.5)
islandIcon.Position           = UDim2.fromScale(0.5, 0.5)
islandIcon.BackgroundTransparency = 1
islandIcon.Image              = "rbxassetid://7072706620"
islandIcon.ImageColor3        = NEO_CYAN
islandIcon.ZIndex              = 31
islandIcon.Parent              = island

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
panel.BorderSizePixel  = 0
panel.Visible          = false
panel.ZIndex           = 20
panel.Parent           = settingsGui
corner(panel, 14)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color        = NEO_CYAN
panelStroke.Thickness    = 1.5
panelStroke.Transparency = 0.1
panelStroke.Parent       = panel

local scanline = Instance.new("ImageLabel")
scanline.Size               = UDim2.fromScale(1, 1)
scanline.BackgroundTransparency = 1
scanline.Image              = "rbxassetid://6630607298"
scanline.ImageTransparency  = 0.92
scanline.ZIndex              = 21
scanline.Parent              = panel

local function updatePanelPos()
    local ix = island.Position.X.Offset
    local iy = island.Position.Y.Offset
    panel.Position = UDim2.new(0, ix + 62, 0.5, iy - PANEL_H/2 + 26)
end
updatePanelPos()

local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = NEO_BG
header.BorderSizePixel  = 0
header.ZIndex           = 22
header.Parent           = panel
corner(header, 14)

local headerFix = Instance.new("Frame")
headerFix.Size             = UDim2.new(1, 0, 0.5, 0)
headerFix.Position         = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = NEO_BG
headerFix.BorderSizePixel  = 0
headerFix.ZIndex           = 22
headerFix.Parent           = header

local headerLine = Instance.new("Frame")
headerLine.Size             = UDim2.new(1, 0, 0, 2)
headerLine.Position         = UDim2.new(0, 0, 1, -2)
headerLine.BackgroundColor3 = NEO_CYAN
headerLine.BorderSizePixel  = 0
headerLine.ZIndex           = 23
headerLine.Parent           = header

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
panelClose.AutoButtonColor    = false
panelClose.ZIndex             = 28
panelClose.Parent             = panel
corner(panelClose, 6)
stroke(panelClose, NEO_CYAN, 1, 0.4)

local killGui = Instance.new("ScreenGui")
killGui.Name           = "HuyVuong_KillBtn"
killGui.DisplayOrder   = 9999
killGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
killGui.ResetOnSpawn   = false
killGui.Parent         = playerGui

local killBtn = Instance.new("ImageButton")
killBtn.Size             = UDim2.fromOffset(36, 36)
killBtn.Position         = UDim2.new(1, -12, 0, 12)
killBtn.AnchorPoint      = Vector2.new(1, 0)
killBtn.BackgroundColor3 = Color3.fromRGB(160, 10, 35)
killBtn.Image            = CLOSE_X_ID
killBtn.ImageColor3      = Color3.new(1, 1, 1)
killBtn.AutoButtonColor  = false
killBtn.ZIndex           = 1
killBtn.Parent           = killGui
corner(killBtn, 8)
stroke(killBtn, Color3.fromRGB(255, 60, 80), 2, 0)

task.spawn(function()
    while killBtn and killBtn.Parent do
        TweenService:Create(killBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {BackgroundColor3 = Color3.fromRGB(220, 20, 55)}):Play()
        task.wait(1)
        TweenService:Create(killBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {BackgroundColor3 = Color3.fromRGB(140, 5, 25)}):Play()
        task.wait(1)
    end
end)

killBtn.MouseButton1Click:Connect(function()
    killGui:Destroy()
    settingsGui:Destroy()
end)

local function neonCard(yOff, h)
    local card = Instance.new("Frame")
    card.Size             = UDim2.new(1, -24, 0, h)
    card.Position         = UDim2.fromOffset(12, yOff)
    card.BackgroundColor3 = NEO_CARD
    card.BorderSizePixel  = 0
    card.ZIndex           = 22
    card.Parent           = panel
    corner(card, 8)
    local cs = Instance.new("UIStroke")
    cs.Color        = NEO_PURPLE
    cs.Thickness    = 1
    cs.Transparency = 0.5
    cs.Parent       = card
    return card
end

local function neonLabel(parent, txt, yOff, size, col)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size     = UDim2.new(1, -12, 0, 18)
    l.Position = UDim2.fromOffset(8, yOff)
    l.Font     = Enum.Font.GothamBold
    l.TextSize = size or 10
    l.TextColor3 = col or Color3.fromRGB(140, 200, 255)
    l.Text     = txt
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex   = 23
    l.Parent   = parent
    return l
end

local card1 = neonCard(54, 90)
neonLabel(card1, "◈  FAKE ROBUX BALANCE", 6, 10, NEO_CYAN)

local balBox = Instance.new("TextBox")
balBox.Size               = UDim2.new(1, -16, 0, 30)
balBox.Position           = UDim2.fromOffset(8, 26)
balBox.BackgroundColor3   = Color3.fromRGB(6, 6, 14)
balBox.BorderSizePixel    = 0
balBox.Text               = tostring(Config.FakeBalance)
balBox.PlaceholderText    = "e.g. 5000000"
balBox.Font               = Enum.Font.GothamMedium
balBox.TextSize           = 13
balBox.TextColor3         = NEO_CYAN
balBox.PlaceholderColor3  = Color3.fromRGB(60, 80, 100)
balBox.ClearTextOnFocus   = false
balBox.ZIndex             = 23
balBox.Parent             = card1
corner(balBox, 6)
stroke(balBox, NEO_CYAN, 1, 0.4)

local applyBtn = Instance.new("TextButton")
applyBtn.Size             = UDim2.new(1, -16, 0, 22)
applyBtn.Position         = UDim2.fromOffset(8, 60)
applyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
applyBtn.Text             = "▶  APPLY BALANCE"
applyBtn.Font             = Enum.Font.GothamBlack
applyBtn.TextSize         = 10
applyBtn.TextColor3       = NEO_CYAN
applyBtn.AutoButtonColor  = false
applyBtn.ZIndex           = 23
applyBtn.Parent           = card1
corner(applyBtn, 5)
stroke(applyBtn, NEO_CYAN, 1, 0.3)

local applyDebounce = false
applyBtn.MouseButton1Click:Connect(function()
    if applyDebounce then return end
    applyDebounce = true
    local raw = balBox.Text:gsub("[,%s]","")
    local v = tonumber(raw)
    if v and v > 0 then Config.FakeBalance = v end
    applyBtn.Text             = "✔  APPLIED!"
    applyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
    stroke(applyBtn, Color3.fromRGB(0, 255, 120), 1, 0.1)
    task.delay(1.5, function()
        if not applyBtn or not applyBtn.Parent then return end
        applyBtn.Text             = "▶  APPLY BALANCE"
        applyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 120)
        stroke(applyBtn, NEO_CYAN, 1, 0.3)
        applyDebounce = false
    end)
end)

local card2 = neonCard(154, 116)
neonLabel(card2, "⏱  BUY DELAY (seconds)", 6, 10, NEO_PINK)

local delayDisplay = Instance.new("TextLabel")
delayDisplay.BackgroundTransparency = 1
delayDisplay.Size     = UDim2.fromOffset(48, 32)
delayDisplay.Position = UDim2.new(0.5, -24, 0, 22)
delayDisplay.Font     = Enum.Font.GothamBlack
delayDisplay.TextSize = 26
delayDisplay.TextColor3 = NEO_PINK
delayDisplay.Text     = tostring(Config.BuyDelay) .. "s"
delayDisplay.TextXAlignment = Enum.TextXAlignment.Center
delayDisplay.ZIndex   = 23
delayDisplay.Parent   = card2

local minusBtn = Instance.new("TextButton")
minusBtn.Size             = UDim2.fromOffset(34, 34)
minusBtn.Position         = UDim2.fromOffset(10, 20)
minusBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 28)
minusBtn.Text             = "−"
minusBtn.Font             = Enum.Font.GothamBold
minusBtn.TextSize = 22
minusBtn.TextColor3       = NEO_PINK
minusBtn.AutoButtonColor  = false
minusBtn.ZIndex           = 23
minusBtn.Parent           = card2
corner(minusBtn, 6)
stroke(minusBtn, NEO_PINK, 1, 0.3)

local plusBtn = Instance.new("TextButton")
plusBtn.Size             = UDim2.fromOffset(34, 34)
plusBtn.Position         = UDim2.new(1, -44, 0, 20)
plusBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 28)
plusBtn.Text             = "+"
plusBtn.Font             = Enum.Font.GothamBold
plusBtn.TextSize = 22
plusBtn.TextColor3       = NEO_PINK
plusBtn.AutoButtonColor  = false
plusBtn.ZIndex           = 23
plusBtn.Parent           = card2
corner(plusBtn, 6)
stroke(plusBtn, NEO_PINK, 1, 0.3)

minusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay > 1 then
        Config.BuyDelay = Config.BuyDelay - 1
        delayDisplay.Text = tostring(Config.BuyDelay) .. "s"
    end
end)
plusBtn.MouseButton1Click:Connect(function()
    if Config.BuyDelay < 30 then
        Config.BuyDelay = Config.BuyDelay + 1
        delayDisplay.Text = tostring(Config.BuyDelay) .. "s"
    end
end)

local presets = {1, 3, 5, 10}
local presetRow = Instance.new("Frame")
presetRow.Size             = UDim2.new(1, -16, 0, 24)
presetRow.Position         = UDim2.fromOffset(8, 82)
presetRow.BackgroundTransparency = 1
presetRow.ZIndex           = 23
presetRow.Parent           = card2

for i, sec in ipairs(presets) do
    local pb = Instance.new("TextButton")
    pb.Size             = UDim2.new(0.23, -3, 1, 0)
    pb.Position         = UDim2.new((i-1)*0.25, 2, 0, 0)
    pb.BackgroundColor3 = Color3.fromRGB(10, 10, 24)
    pb.Text             = sec .. "s"
    pb.Font             = Enum.Font.GothamBold
    pb.TextSize         = 11
    pb.TextColor3       = NEO_PINK
    pb.AutoButtonColor  = false
    pb.ZIndex           = 24
    pb.Parent           = presetRow
    corner(pb, 5)
    stroke(pb, NEO_PINK, 1, 0.55)
    pb.MouseButton1Click:Connect(function()
        Config.BuyDelay = sec
        delayDisplay.Text = sec .. "s"
    end)
end

local panelOpen = false
local dragMoved = false

do
    local dragging  = false
    local dragStart = nil
    local startPos  = nil

    island.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragMoved = false
            dragStart = i.Position
            startPos  = island.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType == Enum.UserInputType.MouseMovement or
           i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - dragStart
            if math.abs(d.X) > 6 or math.abs(d.Y) > 6 then
                dragMoved = true
                island.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + d.X,
                    startPos.Y.Scale, startPos.Y.Offset + d.Y)
                updatePanelPos()
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or
           i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

island.MouseButton1Click:Connect(function()
    if dragMoved then return end
    if not panelOpen then
        panelOpen = true
        updatePanelPos()
        panel.Size             = UDim2.fromOffset(0, 0)
        panel.BackgroundTransparency = 1
        panel.Visible          = true
        TweenService:Create(panel,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.fromOffset(PANEL_W, PANEL_H)}):Play()
        TweenService:Create(panel,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}):Play()
        panelStroke.Transparency = 1
        TweenService:Create(panelStroke,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Transparency = 0.1}):Play()
    end
end)

panelClose.MouseButton1Click:Connect(function()
    panelOpen = false
    TweenService:Create(panel,
        TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(panelStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Transparency = 1}):Play()
    task.delay(0.23, function()
        if panel and panel.Parent then panel.Visible = false end
    end)
end)

-- ============================================================
--  HOOK
-- ============================================================
local hookedBtns    = {}
local lastFruit     = nil
local lastRecipient = ""

local function scanGiftingLabel()
    for _, desc in ipairs(playerGui:GetDescendants()) do
        if (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
            local t = desc.Text or ""
            if t:find("Gifting") and t:find("%[") then
                local u = t:match("%[(.-)%]")
                if u and u ~= "" then lastRecipient = u end
                local tagged = t:match("<(.-)>")
                if tagged then
                    local clean = tagged:match("^Permanent%s+(.+)$") or tagged
                    clean = clean:match("^%s*(.-)%s*$")
                    for _, f in ipairs(sortedFruits) do
                        if f.name:lower() == clean:lower() then
                            lastFruit = f
                            break
                        end
                    end
                    if not lastFruit then
                        local afterBracket = t:match("%]%s*(.+)$") or t
                        local f = findFruitByName(afterBracket)
                        if f then lastFruit = f end
                    end
                else
                    local afterBracket = t:match("%]%s*(.+)$") or t
                    local f = findFruitByName(afterBracket)
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
            scanGiftingLabel()
            local id    = tonumber(select(2, ...))
            local fruit = (id and findFruitById(id)) or lastFruit
            if fruit then
                local r = lastRecipient ~= "" and lastRecipient or "Unknown"
                task.defer(function() showProcessingModal(fruitToProductInfo(fruit), r) end)
                return
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
        for _, sg in ipairs(playerGui:GetChildren()) do
            if sg:IsA("ScreenGui") and ROBLOX_PURCHASE_GUIS[sg.Name] then
                scanGiftingLabel()
                local fruit = lastFruit
                local r     = lastRecipient ~= "" and lastRecipient or "Unknown"
                sg:Destroy()
                if fruit then
                    task.defer(function() showProcessingModal(fruitToProductInfo(fruit), r) end)
                end
            end
        end
    end
end)

local function hookConfirmButton(btn)
    if not (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return end
    if hookedBtns[btn] then return end
    if btn:IsDescendantOf(settingsGui) then return end
    local sg = btn:FindFirstAncestorWhichIsA("ScreenGui")
    if sg and (sg.Name:find("HazeHub") or sg.Name:find("HuyVuong") or sg.Name:find("Spacehub")) then return end
    if btn:FindFirstChild("_HazeOverlay") then return end

    local text = (btn.Text or ""):lower()
    
    if text == "gift" or text == "tặng quà" or text == "tặng" then return end

    local name = (btn.Name or ""):lower()

    local isInsideGiftModal = false
    local p = btn.Parent
    for _ = 1, 8 do
        if not p then break end
        if p:IsA("TextLabel") or p:IsA("TextButton") then
            local t = (p.Text or ""):lower()
            if t:find("send a gift") or t:find("gifting") then
                isInsideGiftModal = true; break
            end
        end
        for _, ch in ipairs(p:GetChildren()) do
            if (ch:IsA("TextLabel") or ch:IsA("TextButton")) then
                local t = (ch.Text or ""):lower()
                if t:find("send a gift") or t:find("gifting") then
                    isInsideGiftModal = true; break
                end
            end
        end
        if isInsideGiftModal then break end
        p = p.Parent
    end

    local isConfirm      = (text:find("🎁") or text:match("^%d+$") or text:match("^%d+,%d+$")) and true or false
    local isNamedConfirm = name:find("buy") or name:find("confirm") or name:find("purchase") or name:find("gift") or name:find("price") or name:find("robux")

    if not (isInsideGiftModal or isConfirm or isNamedConfirm) then return end

    hookedBtns[btn] = true
    btn.MouseEnter:Connect(function() scanGiftingLabel() end)

    local overlay = Instance.new("TextButton")
    overlay.Name = "_HazeOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = (btn.ZIndex or 1) + 50
    overlay.Parent = btn

    pcall(function()
        if getconnections then
            for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do pcall(function() conn:Disable() end) end
            for _, conn in ipairs(getconnections(btn.Activated))         do pcall(function() conn:Disable() end) end
        end
    end)

    overlay.MouseButton1Click:Connect(function()
        scanGiftingLabel()
        local fruit = lastFruit
        local r     = lastRecipient ~= "" and lastRecipient or "Unknown"
        if fruit then showProcessingModal(fruitToProductInfo(fruit), r) end
    end)
end

for _, v in ipairs(playerGui:GetDescendants()) do
    task.defer(function() if v and v.Parent then hookConfirmButton(v) end end)
end

playerGui.DescendantAdded:Connect(function(d)
    task.delay(0.05, function()
        if d and d.Parent then hookConfirmButton(d) end
        if (d:IsA("TextLabel") or d:IsA("TextButton")) then
            local t = d.Text or ""
            if t:find("Gifting") and t:find("Permanent") then scanGiftingLabel() end
        end
    end)
end)

task.spawn(function()
    while true do task.wait(0.3); scanGiftingLabel() end
end)
