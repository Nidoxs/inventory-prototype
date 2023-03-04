-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Inventory = require(script.Parent)

return {
	summary = "Inventory prototype",
	story = Roact.createElement(Inventory),
}
