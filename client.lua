----------------------- # ----------------------- # ----------------------- # -----------------------

local checkDistance = false
local lookUptable = {
    [1] = 0.0, [2] = 0.1, [3] = 0.2, [4] = 0.3, [5] = 0.4, [6] = 0.5,
    [7] = 0.6, [8] = 0.7, [9] = 0.8, [10] = 0.9, [11] = 1.0
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

            for i = 1, 10 do
                local section = division * (11 - i)

                if dist >= section then
                    SendNUIMessage({
                        action = "setVolume",
                        volume = lookUptable[i]
                    })
                    break
                end
            end
        end
    end)
end

---Stops the current audio
local function stopAudio()
    SendNUIMessage({
        action = "stop"
    })
end

----------------------- # ----------------------- # ----------------------- # -----------------------

RegisterNetEvent("br_player:playAudio")
AddEventHandler("br_player:playAudio", playAudio)

RegisterNetEvent("br_player:playRange")
AddEventHandler("br_player:playRange", playOnRange)

RegisterNetEvent("br_player:stop")
AddEventHandler("br_player:stop", stopAudio)

----------------------- # ----------------------- # ----------------------- # -----------------------

RegisterNUICallback("finished", function (body, cb)
    cb(0)
    checkDistance = false
end)

----------------------- # ----------------------- # ----------------------- # -----------------------

exports("play", playAudio)
exports("stop", stopAudio)

----------------------- # ----------------------- # ----------------------- # -----------------------