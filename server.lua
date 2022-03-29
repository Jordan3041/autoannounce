-----------------------[ Script, Don't Configure this!]-------------------
RegisterServerEvent('getPlayerIdentifiers')
AddEventHandler('getPlayerIdentifiers', function()
    if GetPlayerIdentifiers(source) ~= nil then
        TriggerClientEvent('setPlayerIdentifiers', source, GetPlayerIdentifiers(source))
    end
end)
--------------------------------------------------------------------------