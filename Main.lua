-- AppleLibrary MINI FUNCTIONAL Version

local lib = {}
lib._tabs = {}

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
    scrgui.Name = "ScreenGui"

    -- SPLASH
    if dosplash then
        local splash = Instance.new("Frame")
        splash.Name = "splash"
        splash.Parent = scrgui
        splash.AnchorPoint = Vector2.new(0.5, 0.5)
        splash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        splash.BackgroundTransparency = 0.6
        splash.Position = UDim2.new(0.5, 0, 2, 0)
        splash.Size = UDim2.new(0, 250, 0, 250)

        Instance.new("UICorner", splash).CornerRadius = UDim.new(0, 16)

        local sicon = Instance.new("ImageLabel")
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

    -- MAIN WINDOW
    local main = Instance.new("Frame")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    main.BackgroundTransparency = 0.15
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, 500, 0, 420)

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

    tp(main, UDim2.new(0.5,0,0.5,0), 0.5)

    -- DRAG
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
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
    end)

    -- SIDEBAR
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Parent = main
    sidebar.Size = UDim2.new(0, 150, 0, 410)
    sidebar.Position = UDim2.new(0, 10, 0, 10)
    sidebar.BackgroundTransparency = 1
    sidebar.AutomaticCanvasSize = "Y"
    sidebar.ScrollBarThickness = 2

    local sb_layout = Instance.new("UIListLayout")
    sb_layout.Parent = sidebar
    sb_layout.Padding = UDim.new(0, 6)
    sb_layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- WORKAREA
    local workarea = Instance.new("Frame")
    workarea.Parent = main
    workarea.Size = UDim2.new(0, 320, 0, 400)
    workarea.Position = UDim2.new(0, 170, 0, 10)
    workarea.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", workarea).CornerRadius = UDim.new(0,12)

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Parent = main
    title.Position = UDim2.new(0.4,0,0.03,0)
    title.Size = UDim2.new(0, 200, 0, 20)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = ti or "Apple MINI"
    title.TextSize = 18
    title.TextColor3 = Color3.fromRGB(0,0,0)

    -----------------------------------------------------
    --            TAB SYSTEM (FUNCIONA)
    -----------------------------------------------------
    function lib:addTab(name)
        local tab = {}

        local btn = Instance.new("TextButton")
        btn.Parent = sidebar
        btn.Size = UDim2.new(1, -10, 0, 28)
        btn.BackgroundColor3 = Color3.fromRGB(230,230,230)
        btn.Text = name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(60,60,60)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        local page = Instance.new("ScrollingFrame")
        page.Parent = workarea
        page.Size = UDim2.new(1, -10, 1, -10)
        page.Position = UDim2.new(0,5,0,5)
        page.Visible = false
        page.AutomaticCanvasSize = "Y"
        page.ScrollBarThickness = 3
        page.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout")
        layout.Parent = page
        layout.Padding = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            for _, other in pairs(workarea:GetChildren()) do
                if other:IsA("ScrollingFrame") then
                    other.Visible = false
                end
            end
            page.Visible = true
        end)

        function tab:addButton(text, callback)
            local b = Instance.new("TextButton")
            b.Parent = page
            b.Size = UDim2.new(1, -10, 0, 30)
            b.BackgroundColor3 = Color3.fromRGB(240,240,240)
            b.Text = text
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            b.TextColor3 = Color3.fromRGB(30,30,30)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

            b.MouseButton1Click:Connect(callback)
        end

        return tab
    end

    ------------------------------------------------------

    return lib
end

return lib
