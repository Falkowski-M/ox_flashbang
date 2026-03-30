local flashSettings = {
    flashbangRadius = 18.0,
    flashbangDuration = 5.0,
    flashbangDelay = 5.0,
    searchRadius = 50.0
}
    
local IsPlayerBlinded = false
local hasFlash = false
local thrown = false
    
exports("IsPlayerBlinded", function()
    return IsPlayerBlinded
end)
    
function setCurrentWeapon(data)
    hasFlash = data?.name == 'WEAPON_FLASHBANG' and true or false
end
    
AddEventHandler('ox_inventory:currentWeapon', setCurrentWeapon)
    
function applyFlashbangScreenEffect(coords)
    local playerCoords = GetEntityCoords(cache.ped)  
    local dist = #(playerCoords - coords)  
    IsPlayerBlinded = true  
    duration = flashSettings.flashbangDuration  
    if dist <= 5.0 then  
        duration = flashSettings.flashbangDuration   
    elseif dist > 5.0 and dist <= flashSettings.flashbangRadius then  
        duration = 5.0 - (dist / 5.0) 
    end

    local fullWhiteTime = duration * 0.3
    local fadeOutTime = duration * 0.7
    local startTime = GetGameTimer()
    local fullWhiteEnd = startTime + (fullWhiteTime * 1000)
    local fadeOutStart = fullWhiteEnd
    local fadeOutEnd = startTime + (duration * 1000)

    while GetGameTimer() < fullWhiteEnd do
        DrawRect(0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
        Citizen.Wait(0)
    end

    while GetGameTimer() < fadeOutEnd do
        local progress = (GetGameTimer() - fadeOutStart) / (fadeOutTime * 1000)
        local alpha = math.floor(255 * (1 - progress))
        DrawRect(0.5, 0.5, 1.0, 1.0, 255, 255, 255, alpha)
        Citizen.Wait(0)
    end
    IsPlayerBlinded = false
 end
    
function playFlashbangSound(coords)
    local playerCoords = GetEntityCoords(cache.ped)
    local dist = #(playerCoords - coords)
    vol = 1.0
    vol = vol - dist / flashSettings.flashbangRadius 
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = 'flashbang',
        transactionVolume = vol
    })
 end
    
RegisterNetEvent('flashbang:explode', function(coords)
    local playerCoords = GetEntityCoords(cache.ped)
    if #(playerCoords - coords) <= flashSettings.flashbangRadius then
        local grenade = GetClosestObjectOfType(coords.x, coords.y, coords.z, 2.0, GetHashKey("w_ex_flashbang"), false, false, false)
        if DoesEntityExist(grenade) then
            AddExplosion(coords.x, coords.y, coords.z, 1, 0.0, true, false, 0.0)
            if HasEntityClearLosToEntity(cache.ped, grenade, 17) then
                local playerForward = GetEntityForwardVector(cache.ped)
                local toFlashbang = vector3(coords.x - playerCoords.x, coords.y - playerCoords.y, coords.z - playerCoords.z)
                toFlashbang = toFlashbang / #(toFlashbang)
                local dotProduct = playerForward.x * toFlashbang.x + playerForward.y * toFlashbang.y + playerForward.z * toFlashbang.z
                local angle = math.deg(math.acos(dotProduct))

                playFlashbangSound(coords)
                if angle <= 90 then
                    applyFlashbangScreenEffect(coords)
                end
            end
        end
    end
end)
    

    
local keybind = lib.addKeybind({
    name = 'rzucanie_flasha',
    description = 'rzuć fleszyka',
    defaultKey = 'MOUSE_LEFT',
    defaultMapper = 'MOUSE_BUTTON',
    onReleased = function(self)
        if hasFlash and IsPedWeaponReadyToShoot(cache.ped) and not thrown then
            Citizen.CreateThread(function()
                thrown = true
                Citizen.Wait(5000)
                thrown = false
            end)
            playerCoords = GetEntityCoords(cache.ped)
            playerhand = GetPedBoneCoords(cache.ped, 0xDEAD, 0.0, 0.0, 0.0)
            grenade = GetClosestObjectOfType(playerhand, flashSettings.searchRadius, GetHashKey("w_ex_flashbang"), false, false, false)
            a = 0
            while IsEntityAttachedToAnyPed(grenade) and a < 2000 do
                Citizen.Wait(0)
                grenade = GetClosestObjectOfType(playerhand, flashSettings.searchRadius, GetHashKey("w_ex_flashbang"), false, false, false)
                a += 1
            end
            grenade = GetClosestObjectOfType(playerhand, flashSettings.searchRadius, GetHashKey("w_ex_flashbang"), false, false, false)
            Citizen.Wait(flashSettings.flashbangDelay * 1000) 
            if DoesEntityExist(grenade) then
                grenadeCoords = GetEntityCoords(grenade)
                TriggerServerEvent('flashbang:detectExplosion', grenadeCoords)
            end
        end
    end
})