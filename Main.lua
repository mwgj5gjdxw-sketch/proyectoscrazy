-- AppleLibrary MINI Version

local lib = {}
local sections = {}
local workareas = {}
local notifs = {}
local visible = true
local dbcooper = false

local function tp(ins, pos, time)
    game:GetService("TweenService"):Create(
        ins,
        TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
        {Position = pos}
    ):Play()
end

function lib:init(ti, dosplash, visiblekey, deleteprevious)
    local cg = game:GetService("CoreGui")

    if cg:FindFirstChild("ScreenGui") and deleteprevious then
        tp(cg.ScreenGui.main, cg.ScreenGui.main.Position + UDim2.new(0,0,2,0), 0.5)
        game:GetService("Debris"):AddItem(cg.ScreenGui, 1)
    end

    local scrgui = Instance.new("ScreenGui")
    scrgui.Parent = cg

    -- Splash más pequeño
    if dosplash then
        local splash = Instance.new("Frame")
        splash.Name = "splash"
        splash.Parent = scrgui
        splash.AnchorPoint = Vector2.new(0.5, 0.5)
        splash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        splash.BackgroundTransparency = 0.6
        splash.Position = UDim2.new(0.5, 0, 2, 0)
        splash.Size = UDim2.new(0, 250, 0, 250)

        local uc = Instance.new("UICorner")
        uc.CornerRadius = UDim.new(0, 16)
        uc.Parent = splash

        local sicon = Instance.new("ImageLabel")
        sicon.Name = "sicon"
        sicon.Parent = splash
        sicon.AnchorPoint = Vector2.new(0.5, 0.5)
        sicon.BackgroundTransparency = 1
        sicon.Position = UDim2.new(0.5, 0, 0.5, 0)
        sicon.Size = UDim2.new(0, 120, 0, 120)
        sicon.Image = "rbxassetid://12621719043"

        splash:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "InOut", "Quart", 1)
        task.wait(1.5)
        splash:TweenPosition(UDim2.new(0.5, 0, 2, 0), "InOut", "Quart", 1)
        game:GetService("Debris"):AddItem(splash, 1)
    end

    -- MAIN (reducción grande)
    local main = Instance.new("Frame")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    main.BackgroundTransparency = 0.15
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, 500, 0, 420)

    local uc = Instance.new("UICorner")
    uc.CornerRadius = UDim.new(0, 14)
    uc.Parent = main

    -- Drag system
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
    end)

    ---------------------------
    -- WORKAREA reducída
    ---------------------------
    local workarea = Instance.new("Frame")
    workarea.Name = "workarea"
    workarea.Parent = main
    workarea.BackgroundColor3 = Color3.fromRGB(255,255,255)
    workarea.Position = UDim2.new(0.34, 0, 0, 0)
    workarea.Size = UDim2.new(0, 330, 0, 420)

    local wuc = Instance.new("UICorner")
    wuc.CornerRadius = UDim.new(0,14)
    wuc.Parent = workarea

    ---------------------------
    -- SEARCHBAR pequeña
    ---------------------------
    local search = Instance.new("Frame")
    search.Name = "search"
    search.Parent = main
    search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    search.Position = UDim2.new(0.03, 0, 0.1, 0)
    search.Size = UDim2.new(0, 180, 0, 28)

    local su = Instance.new("UICorner")
    su.CornerRadius = UDim.new(0, 8)
    su.Parent = search

    local searchicon = Instance.new("ImageButton")
    searchicon.Parent = search
    searchicon.BackgroundTransparency = 1
    searchicon.Position = UDim2.new(0.05, 0, 0.15, 0)
    searchicon.Size = UDim2.new(0, 16, 0, 16)
    searchicon.Image = "rbxassetid://2804603863"
    searchicon.ImageColor3 = Color3.fromRGB(95, 95, 95)

    local searchtextbox = Instance.new("TextBox")
    searchtextbox.Parent = search
    searchtextbox.BackgroundTransparency = 1
    searchtextbox.Position = UDim2.new(0.20, 0, 0, 0)
    searchtextbox.Size = UDim2.new(0, 140, 0, 28)
    searchtextbox.Font = Enum.Font.Gotham
    searchtextbox.PlaceholderText = "Search"
    searchtextbox.TextColor3 = Color3.fromRGB(95, 95, 95)
    searchtextbox.TextSize = 18
    searchtextbox.TextXAlignment = Enum.TextXAlignment.Left

    ---------------------------
    -- SIDEBAR reducida
    ---------------------------
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "sidebar"
    sidebar.Parent = main
    sidebar.Active = true
    sidebar.BackgroundTransparency = 1
    sidebar.Position = UDim2.new(0.03, 0, 0.18, 0)
    sidebar.Size = UDim2.new(0, 190, 0, 330)
    sidebar.CanvasSize = UDim2.new(0,0,0,0)
    sidebar.AutomaticCanvasSize = "Y"
    sidebar.ScrollBarThickness = 2

    local sb_layout = Instance.new("UIListLayout")
    sb_layout.Parent = sidebar
    sb_layout.SortOrder = Enum.SortOrder.LayoutOrder
    sb_layout.Padding = UDim.new(0,4)

    ---------------------------
    -- TOP MAC BUTTONS
    ---------------------------
    local buttons = Instance.new("Frame")
    buttons.Parent = main
    buttons.Size = UDim2.new(0, 80, 0, 40)
    buttons.BackgroundTransparency = 1

    local bl = Instance.new("UIListLayout")
    bl.Parent = buttons
    bl.FillDirection = Enum.FillDirection.Horizontal
    bl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    bl.Padding = UDim.new(0,8)

    -- Close
    local close = Instance.new("TextButton")
    close.Parent = buttons
    close.BackgroundColor3 = Color3.fromRGB(254, 94, 86)
    close.Size = UDim2.new(0, 14, 0, 14)
    close.Text = ""
    Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)
    close.MouseButton1Click:Connect(function()
        scrgui:Destroy()
    end)

    -- Minimize
    local minimize = Instance.new("TextButton")
    minimize.Parent = buttons
    minimize.BackgroundColor3 = Color3.fromRGB(255,189,46)
    minimize.Size = UDim2.new(0,14,0,14)
    minimize.Text = ""
    Instance.new("UICorner", minimize).CornerRadius = UDim.new(1,0)

    -- Resize
    local resize = Instance.new("TextButton")
    resize.Parent = buttons
    resize.BackgroundColor3 = Color3.fromRGB(39,200,63)
    resize.Size = UDim2.new(0,14,0,14)
    resize.Text = ""
    Instance.new("UICorner", resize).CornerRadius = UDim.new(1,0)

    ---------------------------
    -- TITLE reducido
    ---------------------------
    local title = Instance.new("TextLabel")
    title.Parent = main
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0.4, 0, 0.03, 0)
    title.Size = UDim2.new(0, 200, 0, 15)
    title.Font = Enum.Font.Gotham
    title.Text = ti or "AppleLibrary MINI"
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(0, 0, 0)

    ---------------------------------------------------
    -- Desde aquí ya puedes agregar Tabs/Buttons como siempre
    ---------------------------------------------------

    return lib
end

return lib
