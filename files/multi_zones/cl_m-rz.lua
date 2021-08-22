local isMeldingVerstuurd = false -- Puts isMeldingVerstuurd to false
local leaveMessage = 5000 -- Amount of miliseconds to show the "You just left the redzone", you can change this to your liking
local isLeaveMessagePresent = false -- The "You just left the redzone"

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetEntityCoords(GetPlayerPed(-1))
        for zoneTitel, zoneData in pairs(Config.Redzones) do
        local playercoords = GetEntityCoords(PlayerPedId())
          if GetDistanceBetweenCoords(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, playercoords, false) < 250 then
            DrawMarker(28, zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, --[[scalex]]zoneData.Radius, --[[scaley]]zoneData.Radius, --[[scalez]]zoneData.Radius, 255, 0, 0, 40, false, true, 2, nil, nil, false)
          end
            if Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) < zoneData.Radius then
                DrawTextOnScreen("YOU ARE IN A REDZONE", 0.77, 0.95, 255, 0, 0, 200, 0.8, 7)
                if isMeldingVerstuurd == false then -- The moment you enter the circle (coords), it will check if isMeldingVerstuurd is false, if so it will set it to true. (If it remains false it will continue to run it)
                    Wait(0)
                    isMeldingVerstuurd = true
                    EnteredRedzone()   -- runs line 33
                end
            elseif Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) < (zoneData.Radius + 30) and Vdist(zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, ped) > zoneData.Radius then
                if isLeaveMessagePresent then
                    DrawTextOnScreen("YOU LEFT THE REDZONE", 0.75, 0.95, 255, 0, 0, 200, 0.8, 7)
                end
                if isMeldingVerstuurd then
                    LeftRedzone() -- runs line 43
                end
                isMeldingVerstuurd = false
            end
        end
    end
end)

function EnteredRedzone()
    exports['mythic_notify']:DoHudText('error', 'You just entered the redzone')
    PlaySound(-1, "CHARACTER_CHANGE_CHARACTER_01_MASTER", 0, 0, 0, 0) -- Comment this line out if you don't want this sound to be played when entering a redzone
        isLeaveMessagePresent = true
end

function LeftRedzone()
    exports['mythic_notify']:DoHudText('error', 'You just left the redzone')
    PlaySound(-1, "CHARACTER_CHANGE_CHARACTER_01_MASTER", 0, 0, 0, 0) -- Comment this line out if you don't want this sound to be played when leaving a redzone
    Citizen.SetTimeout(leaveMessage, function() -- Wait the timer to be done
        isLeaveMessagePresent = false
    end)
end

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
