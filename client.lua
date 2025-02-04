----------------------- # ----------------------- # ----------------------- # -----------------------

local checkDistance = false
local lookUptable = {
    [1] = 1.0, [2] = 0.9, [3] = 0.8, [4] = 0.7, [5] = 0.6, [6] = 0.5,
    [7] = 0.4, [8] = 0.3, [9] = 0.2, [10] = 0.1, [11] = 0.0
}

----------------------- # ----------------------- # ----------------------- # -----------------------

---Plays the given audio
---@param data { file: string; volume: number }
local function playAudio(data)
    SendNUIMessage({
        action = "play",
        file = data.file,
        volume = data.volume
    })
end

---Plays the given audio in a range
---@param data { file: string; volume: number }
---@param coords vector3
---@param range number
local function playOnRange(data, coords, range)

    local volume = 0.0
    local playerPed = PlayerPedId()
    if #(coords - GetEntityCoords(playerPed)) < range then
        volume = data.volume
    end

    playAudio({ file = data.file, volume = volume })

    CreateThread(function ()
        checkDistance = true
        local division = range / 10.0
        while checkDistance do
            Wait(500)

            local dist = #(coords - GetEntityCoords(playerPed))

            if dist > range then
                goto skip
            end

            for i = 1, 11 do
                if dist < i * division and i < 11 then
                    break
                end
                SendNUIMessage({
                    action = "setVolume",
                    volume = lookUptable[i]
                })
                print("Changing volume to "..lookUptable[i])
            end

            ::skip::
        end
    end)
end

----------------------- # ----------------------- # ----------------------- # -----------------------

RegisterNetEvent("br_player:playAudio")
AddEventHandler("br_player:playAudio", playAudio)

RegisterNetEvent("br_player:playRange")
AddEventHandler("br_player:playRange", playOnRange)

----------------------- # ----------------------- # ----------------------- # -----------------------

RegisterNUICallback("finished", function (body, cb)
    checkDistance = false
    cb()
end)

----------------------- # ----------------------- # ----------------------- # -----------------------

exports("play", playAudio)

----------------------- # ----------------------- # ----------------------- # -----------------------