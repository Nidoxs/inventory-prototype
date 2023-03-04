-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local e = Roact.createElement

local function ItemSlot(props, hooks)
	local dragging, setDragging = hooks.useState(false)
	local draggerPosition, setDraggerPosition = hooks.useBinding(UDim2.new(0, 0))

	local index = props.index
	local item = props.item
	local empty = item.name == nil

	local ref = Roact.createRef()

	hooks.useEffect(function()
		if dragging then
			local updatePosition = RunService.RenderStepped:Connect(function()
				if ref:getValue() then
					local mouse = UserInputService:GetMouseLocation()
					setDraggerPosition(UDim2.fromOffset(mouse.X, mouse.Y))
				end
			end)

			return function()
				updatePosition:Disconnect()
			end
		end
	end, { dragging, ref })

	local onMouseEnter = hooks.useCallback(function()
		props.setIndexCurrentlyHovered(props.index)
	end, { props.setIndexCurrentlyHovered, props.index, dragging })

	local onMouseLeave = hooks.useCallback(function()
		props.setIndexCurrentlyHovered()
	end, { props.setIndexCurrentlyHovered, dragging })

	local inputBegan = hooks.useCallback(function(_, input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			setDragging(true)
		end
	end, {})

	local inputEnded = hooks.useCallback(function(_, input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if props.indexCurrentlyHovered then
				props.changeItemIndex(props.index, props.indexCurrentlyHovered)
			end

			setDragging(false)
		end
	end, { props.index, props.changeItemIndex, props.indexCurrentlyHovered })

	print("render")

	return e("Frame", {
		LayoutOrder = index,
		BackgroundTransparency = 0,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		UIStroke = dragging and e("UIStroke", {
			Thickness = 2,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(52, 52, 52),
			Transparency = Color3.fromRGB(0, 0, 0),
		}),

		SlotButton = e("TextButton", {
			[Roact.Ref] = ref,
			Text = empty and "[EMPTY]" or item.name,
			Visible = not dragging,
			Size = UDim2.fromScale(1, 1),
			TextSize = if empty then 6 else 12,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = if empty
				then Color3.fromRGB(50, 50, 50)
				elseif item.name == "Pear" then Color3.fromRGB(79, 124, 74)
				else Color3.fromRGB(125, 125, 125),
			[Roact.Event.MouseEnter] = onMouseEnter,
			[Roact.Event.MouseLeave] = onMouseLeave,
			[Roact.Event.InputBegan] = if not empty then inputBegan else nil,
			[Roact.Event.InputEnded] = if not empty then inputEnded else nil,
		}, {
			UICorner = e("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),

			IndexLabel = e("TextLabel", {
				Text = index,
				Position = UDim2.fromScale(0.5, 0.15),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				AnchorPoint = Vector2.new(0.5, 0),
				TextSize = 10,
				BackgroundTransparency = 1,
			}),

			Dragger = dragging and not empty and e("ScreenGui", {}, {
				Dragger = e("TextLabel", {
					Text = item.name,
					AnchorPoint = Vector2.new(0.5, 1),
					TextSize = if empty then 6 else 12,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Position = draggerPosition,
					Size = UDim2.fromOffset(80, 40),
					BackgroundColor3 = if empty then Color3.fromRGB(50, 50, 50) else Color3.fromRGB(125, 125, 125),
				}, {
					UICorner = e("UICorner", {
						CornerRadius = UDim.new(0, 8),
					}),

					UIStroke = e("UIStroke", {
						Thickness = 2,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Color3.fromRGB(255, 255, 255),
						Transparency = Color3.fromRGB(0, 0, 0),
					}),

					IndexLabel = e("TextLabel", {
						Text = index,
						Position = UDim2.fromScale(0.5, 0.2),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						AnchorPoint = Vector2.new(0.5, 0),
						TextSize = 10,
						BackgroundTransparency = 1,
					}),
				}),
			}),
		}),
	})
end

return Hooks.new(Roact)(ItemSlot, {
	componentType = "PureComponent",
})
