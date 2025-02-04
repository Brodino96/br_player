----------------------- # ----------------------- # ----------------------- # -----------------------

---Only the specified player will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
---@param serverId number|string The player's id
local function playOnOne(file, volume, serverId)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("br_player:playAudio", serverId, { file = file, volume = volume })
end

---Every player in the server will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
local function playOnEveryone(file, volume)
    TriggerClientEvent("br_player:playAudio", -1, { file = file, volume = volume })
end

---Every player within the range will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
---@param coords vector3 The origin coords
---@param range number The maximum range
local function playOnRange(file, volume, coords, range)
    TriggerClientEvent("br_player:playRange", -1, { file = file, volume = volume }, coords, range)
end

----------------------- # ----------------------- # ----------------------- # -----------------------

exports("single", playOnOne)
exports("everyone", playOnEveryone)
exports("range", playOnRange)

----------------------- # ----------------------- # ----------------------- # -----------------------