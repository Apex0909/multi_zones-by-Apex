local isMeldingVerstuurd = false -- puts isMeldingVerstuurd to false
local leaveMessage = 5000 -- Amount of miliseconds to show the "You just left the greenzone", feel free to change this to your liking!
local isLeaveMessagePresent = false -- The "You just left the redzone"
local speedInGZ = 13.0 -- The speed when you are in a greenzone
local speedNotInGZ = 97.2 -- The speed when you are not in any greenzone
local isInCityZone = false -- turns isInCityZone to false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if isInCityZone then
        	SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),speedInGZ)
        else
        	SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),speedNotInGZ)
        end

        local ped = GetEntityCoords(GetPlayerPed(-1))
        for zoneTitel, zoneData in pairs(Config.Greenzones) do
            if Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) < zoneData.Radius then

                DisableActions() -- runs line 74
                if isLeaveMessagePresent then
                    DrawTextOnScreen("YOU ARE IN A GREENZONE", 0.74, 0.95, 0, 255, 0, 200, 0.8, 7)
                end
                if isMeldingVerstuurd == false then -- The moment you enter the circle (coords), it will check if isMeldingVerstuurd is false, if so it will set it to true. (If it remains false it will continue to run it)
                    Wait(0)
                    isMeldingVerstuurd = true
                    EnteredGreenzone()   -- runs line 33
                end
            elseif Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) < (zoneData.Radius + 30) and Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) > zoneData.Radius then
                if isLeaveMessagePresent then
                    DrawTextOnScreen("YOU LEFT THE GREENZONE", 0.73, 0.95, 0, 255, 0, 200, 0.8, 7)
                end
                if isMeldingVerstuurd then
                    LeftGreenzone() -- runs line 43
                end
                isMeldingVerstuurd = false
            end

        end
    end
end)

function EnteredGreenzone()
    exports['mythic_notify']:DoHudText('success', 'You just entered the greenzone')
    PlaySound(-1, "CHARACTER_CHANGE_CHARACTER_01_MASTER", 0, 0, 0, 0)

    isLeaveMessagePresent = true
    Citizen.SetTimeout(leaveMessage, function() -- Wait the timer to be done
        isLeaveMessagePresent = false
    end)

    isInCityZone = true
end

function LeftGreenzone()
    exports['mythic_notify']:DoHudText('success', 'You just left the greenzone')
    PlaySound(-1, "CHARACTER_CHANGE_CHARACTER_01_MASTER", 0, 0, 0, 0)
    SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),speedNotInGZ)
    isLeaveMessagePresent = true
    Citizen.SetTimeout(leaveMessage, function() -- Wait the timer to be done
        isLeaveMessagePresent = false
    end)

    isInCityZone = false
end

function DisableActions()
    DisableControlAction(2, 37, true) -- Disable Weaponwheel
    DisablePlayerFiring(GetPlayerPed(-1),true) -- Disable firing
    DisableControlAction(0, 45, true) -- Disable reloading
    DisableControlAction(0, 24, true) -- Disable attacking
    DisableControlAction(0, 263, true) -- Disable melee attack 1
    DisableControlAction(0, 140, true) -- Disable light melee attack (r)
    DisableControlAction(0, 142, true) -- Disable left mouse button (pistol whack etc)

    for k, v in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(v)
        SetEntityNoCollisionEntity(GetPlayerPed(-1), GetVehiclePedIsIn(ped, false), true)
        SetEntityNoCollisionEntity(GetVehiclePedIsIn(ped, false), GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
    end
end

Citizen.CreateThread(function() -- Adds the blips
    for zoneTitel, zoneData in pairs(Config.Greenzones) do
      local GreenzoneBlip = AddBlipForRadius(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, zoneData.Radius)
    for zoneTitel, zoneData in pairs(Config.Redzones) do
      local RedzoneBlip = AddBlipForRadius(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, zoneData.Radius)
      SetBlipColour(GreenzoneBlip, 2)
      SetBlipAlpha(GreenzoneBlip, 100)

      SetBlipColour(RedzoneBlip, 1)
      SetBlipAlpha(RedzoneBlip, 100)
    end
  end
end)

function DrawTextOnScreen(text, x, y, r, g, b, a, s, font)
    SetTextColour(r, g, b, a)   -- Color
    SetTextFont(font)                      -- Font
    SetTextScale(s, s)              -- Scale
    SetTextCentre(false)                -- Align to center(?)
    SetTextDropshadow(0, 0, 0, 0, 255)  -- Shadow. Distance, R, G, B, Alpha.
    SetTextOutline()                    -- Necessary to give it an outline.
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)               -- Position
end
