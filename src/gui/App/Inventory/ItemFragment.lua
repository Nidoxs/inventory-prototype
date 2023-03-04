-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)
local RoduxHooks = require(ReplicatedStorage.Packages.RoduxHooks)

local e = Roact.createElement

local ItemSlot = require(script.Parent.ItemSlot)

local function ItemFragment(props, hooks)
	local indexCurrentlyHovered, setIndexCurrentlyHovered = hooks.useState()

	local dispatch = RoduxHooks.useDispatch(hooks)
	local items = RoduxHooks.useSelector(hooks, function(state)
		return state.items
	end)

	local changeItemIndex = hooks.useCallback(function(currentIndex, newIndex)
		dispatch({
			type = "itemIndexChanged",
			currentIndex = currentIndex,
			newIndex = newIndex,
		})
	end, { dispatch })

	local elements = {}

	for index, item in items do
		elements[index .. "_" .. (item.name or "EMPTY")] = e(ItemSlot, {
			item = item,
			index = index,
			indexCurrentlyHovered = indexCurrentlyHovered,
			setIndexCurrentlyHovered = setIndexCurrentlyHovered,
			changeItemIndex = changeItemIndex,
		})
	end

	return Roact.createFragment(elements)
end

return Hooks.new(Roact)(ItemFragment)
