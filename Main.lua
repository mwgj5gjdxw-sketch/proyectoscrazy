-- Apple Library MINI (Versión limpia y pequeña)

local library = {}

library.theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Tab = Color3.fromRGB(45, 45, 45),
    Button = Color3.fromRGB(60, 60, 60),
    Accent = Color3.fromRGB(0, 170, 255)
}

local UIS = game:GetService("UserInputService")

-- Crear Window
function library:init(title, splash, keybind)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AppleMiniUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 350, 0, 280)
    Main.Position = UDim2.new(0.5, -175, 0.5, -140)
    Main.BackgroundColor3 = library.theme.Background
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Text = title or "Apple UI"
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.BackgroundColor3 = library.theme.Tab
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 18
    Title.Parent = Main

    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(0, 100, 1, -35)
    Tabs.Position = UDim2.new(0, 0, 0, 35)
    Tabs.BackgroundColor3 = library.theme.Tab
    Tabs.BorderSizePixel = 0
    Tabs.Parent = Main

    local TabButtons = Instance.new("UIListLayout")
    TabButtons.Parent = Tabs
    TabButtons.Padding = UDim.new(0, 5)
    TabButtons.SortOrder = Enum.SortOrder.LayoutOrder

    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1, -100, 1, -35)
    Pages.Position = UDim2.new(0, 100, 0, 35)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    local window = {}

    function window:addTab(tabName)
        local tab = {}

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.BackgroundColor3 = library.theme.Button
        TabButton.TextColor3 = Color3.fromRGB(255,255,255)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.Text = tabName
        TabButton.Parent = Tabs

        local Page = Instance.new("ScrollingFrame")
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarThickness = 3
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.Parent = Pages

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.Padding = UDim.new(0, 6)

        TabButton.MouseButton1Click:Connect(function()
            for _, p in ipairs(Pages:GetChildren()) do
                if p:IsA("ScrollingFrame") then
                    p.Visible = false
                end
            end
            Page.Visible = true
        end)

        function tab:addButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 32)
            Btn.BackgroundColor3 = library.theme.Button
            Btn.TextColor3 = Color3.fromRGB(255,255,255)
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.Text = text
            Btn.Parent = Page

            Btn.MouseButton1Click:Connect(function()
                if callback then
                    pcall(callback)
                end
            end)
        end

        return tab
    end

    -- Toggle UI
    UIS.InputBegan:Connect(function(input)
        if keybind and input.KeyCode == keybind then
            Main.Visible = not Main.Visible
        end
    end)

    return window
end

return library
