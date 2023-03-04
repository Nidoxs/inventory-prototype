-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Packages.Rodux)
local Sift = require(ReplicatedStorage.Packages.Sift)

local DEFAULT_INVENTORY = {
	items = {
		{ name = "Apple" },
		{ name = "Pear" },
		{ name = "Orange" },
		{ name = "Mango" },
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
	},
}

-- This entire example is all on the client, but this would be the server too (it'd be roughly similar
-- but would index a table of user id indexed inventories etc.)
local reducer = Rodux.createReducer(DEFAULT_INVENTORY, {
	itemIndexChanged = function(state, action)
		local currentIndex = action.currentIndex
		local newIndex = action.newIndex

		local itemInCurrentIndex = state.items[currentIndex]
		local itemInNewIndex = state.items[newIndex]

		local newState

		if itemInNewIndex.name == nil then
			-- empty
			newState = Sift.Dictionary.set(state, "items", Sift.Array.set(state.items, currentIndex, {}))
			newState =
				Sift.Dictionary.set(newState, "items", Sift.Array.set(newState.items, newIndex, itemInCurrentIndex))
		else
			newState = Sift.Dictionary.set(state, "items", Sift.Array.set(state.items, currentIndex, itemInNewIndex))
			newState =
				Sift.Dictionary.set(newState, "items", Sift.Array.set(newState.items, newIndex, itemInCurrentIndex))
		end

		return newState
	end,
})

return {
	default = DEFAULT_INVENTORY,
	reducer = reducer,
}
