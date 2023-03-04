-- Nidoxs // March 4th 2023
-- Rough Prototype
-- Code / approach is not perfect, the prototype is just for illustrating the approach

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local RoduxHooks = require(ReplicatedStorage.Packages.RoduxHooks)

local e = Roact.createElement

local UI = {}

local Inventory = require(ReplicatedStorage.Gui.App.Inventory)

function UI.mount()
	local store = require(ReplicatedStorage.Client.Store)

	local app = e("ScreenGui", {
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
	}, {
		Store = e(RoduxHooks.Provider, {
			store = store,
		}, {
			Inventory = e(Inventory),
		}),
	})

	Roact.mount(app, Players.LocalPlayer.PlayerGui, "InventoryPrototype")
end

return UI
