-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local e = Roact.createElement
local ItemFragment = require(script.ItemFragment)

local function Inventory()
	return e("Frame", {
		Size = UDim2.fromOffset(400, 400),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}, {
		Items = e("Frame", {
			Size = UDim2.fromScale(1, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		}, {
			UIGridLayout = e("UIGridLayout", {
				CellSize = UDim2.fromOffset(60, 60),
				CellPadding = UDim2.fromOffset(10, 10),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			InventoryItems = e(ItemFragment),
		}),
	})
end

return Hooks.new(Roact)(Inventory)
