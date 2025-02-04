----------------------- # ----------------------- # ----------------------- # -----------------------

---Only the specified player will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
---@param serverId number|string The player's id
local function playOnOne(file, volume, serverId)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("br_player:playAudio", serverId, file, volume)
end

---Every player in the server will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
local function playOnEveryone(file, volume)
    TriggerClientEvent("br_player:playAudio", -1, file, volume)
end

---Every player within the range will hear the audio
---@param file string The file name
---@param volume number The volume level (0.0 to 1.0)
---@param coords vector3 The origin coords
---@param range number The maximum range
local function playOnRange(file, volume, coords, range)
    TriggerClientEvent("br_player:playRange", -1, file, volume, coords, range)
end

---Stops the current audio playing on the client
---@param serverId number|string The player's id
local function stopOnOne(serverId)
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("br_player:stop", serverId)
end

---Stops the current audio playing on all them clients
local function stopOnEveryone()
    ---@diagnostic disable-next-line: param-type-mismatch
    TriggerClientEvent("br_player:stop", -1)
end

----------------------- # ----------------------- # ----------------------- # -----------------------

exports("single", playOnOne)
exports("everyone", playOnEveryone)
exports("range", playOnRange)
exports("stop", stopOnOne)
exports("stopEveryone", stopOnEveryone)

----------------------- # ----------------------- # ----------------------- # -----------------------