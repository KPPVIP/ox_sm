local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local vSyncPogoda = false


local prox = 10.0
local isTalking = false
local ZablokujPozycje = false
local wszedlDoGry = false
local DuzaMapaPojazd = false
local pokazalHud = false
local przesunalHud = false
local oczekiwanie = 500

local inVeh = false
local distance = 0
local vehPlate

local x = 0.01135
local y = 0.002
hasKM = 0
showKM = 0

-- START


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShburasi45aredObjburasi45ect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	NetworkSetTalkerProximity(1.0)
end)

-- HUD


local vehicle, fuel, lockStatus, isRunning, showHud

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		
		vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if vehicle ~= 0 then 
			showHud = true 
			fuel = math.floor(GetVehicleFuelLevel(vehicle) + 0.0)	
			isRunning = GetIsVehicleEngineRunning(vehicle)
			lockStatus = GetVehicleDoorLockStatus(vehicle)
		else 
			showHud = false
		end
	end
end)

function PrzelaczRadar(on)
DisplayRadar(true)
	if on and not ZablokujPozycje then
		if przesunalHud == false then
			przesunalHud = true
			SendNUIMessage({action = "przesunHud", show = true})
		end
		
	elseif not ZablokujPozycje then
		if przesunalHud == true then
			przesunalHud = false
			SendNUIMessage({action = "przesunHud", show = false})
		end
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		SendNUIMessage({action = "toggleCar", show = showHud})
		
		if vehicle then
			SendNUIMessage({action = "engineSwitch", status = isRunning})
			SendNUIMessage({action = "lockSwitch", status = lockStatus})
			SendNUIMessage({action = "updateGas", key = "gas", value = fuel})
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local Ped = GetPlayerPed(-1)

		if vehicle then
			carSpeed = math.ceil(GetEntitySpeed(vehicle) * 2.0)
			SendNUIMessage({
				showhud = true,
				speed = carSpeed
			})
		end
	end
end)

  
  displayHud = true
	  
  function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
  end