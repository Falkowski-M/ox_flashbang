RegisterNetEvent('flashbang:detectExplosion', function(coords)
    for _, playerId in ipairs(GetPlayers()) do
        local target_coords = GetEntityCoords(GetPlayerPed(playerId))
        if #(coords - target_coords) <= 18.0 then
            TriggerClientEvent('flashbang:explode', playerId, coords)
        end
    end
end)