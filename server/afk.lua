local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('KickForAFK', function()
	DropPlayer(source, Lang:t("text.afk_kick_message"))
end)

QBCore.Functions.CreateCallback('qb-afkkick:server:GetPermissions', function(source, cb)
    cb(QBCore.Functions.GetPermission(source))
end)

AddEventHandler('onResourceStart', function(resource) 
    if GetCurrentResourceName() ~= resource then return end
    for k, v in pairs(Config.ItemImages) do QBCore.Functions.CreateUseableItem(k, function(source) TriggerClientEvent("itemimage:client:showimage", source, k) end) end end)
