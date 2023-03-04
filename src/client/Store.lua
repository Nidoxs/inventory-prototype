-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Packages.Rodux)

local Inventory = require(ReplicatedStorage.Client.InventoryReducer)

local store = Rodux.Store.new(Inventory.reducer, Inventory.default, {})

return store
