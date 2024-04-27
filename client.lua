local isIdDisplaying = false

RegisterKeyMapping('toggleid', 'Show players ID', 'keyboard', 'pageup')

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlPressed(0, 188) then
            isIdDisplaying = true
        else
            isIdDisplaying = false
        end

        if isIdDisplaying then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            
            DrawPlayerId(playerCoords.x, playerCoords.y, playerCoords.z + 1.2, GetPlayerServerId(PlayerId()))

            for _, player in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(player)
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(playerCoords - targetCoords)

                if distance < 20.0 and playerPed ~= targetPed then
                    
                    DrawPlayerId(targetCoords.x, targetCoords.y, targetCoords.z + 1.2, GetPlayerServerId(player))
                end
            end
        end
    end
end)

function DrawPlayerId(x, y, z, id)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(tostring(id))
        DrawText(_x, _y)
    end
end