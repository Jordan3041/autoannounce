local m = {} -- <<< Don't! Config below.
-------------------------------[ CONFIG ]-------------------------------

--^0	White
--^1	Red
--^2	Green
--^3	Yellow
--^4	Blue
--^5	Light Blue
--^6	Purple
--^7	White
--^8	Orange
--^9	Grey

-- Delay between messages in minutes.
m.delay = 15

-- Prefix appears in front of each message. 
-- Suffix appears on the end of each message.
-- Leave a prefix/suffix empty ( '' ) to disable them.
m.prefix = '^6[AutoMessage] '
m.suffix = '^6.'

-- You can create unlimited messages.
-- You can use ^0-^9 in your messages to change text color.
m.messages = {   
    '^1Welcome to West Coast Roleplay! Let us know if you have any questions, comments, or concerns!',
    '^4To be part of a Law Enforcement department, you must join our discord and complete an application.',
    '^8Let staff know if you need any help, or have questions! We are here for everyone!',
    '^6This server is maintained by WCRP Staff. If you encounter any problems, please submit a ticket in our discord.',
    '^3Please review all server rules and guidlines to ensure you are in compliance.',
    '^2Staff are activley taking suggestions, if you have something you would like to see added in, submit the link to the discord suggestions channel.',
}

-- Player ignore list. These players wont get auto messages.
-- Remove all identifiers if you don't want an ignore list.
m.ignorelist = { 
    'ip:127.0.1.5',
    'steam:123456789123456',
    'license:1654687313215747944131321',
}
--------------------------------------------------------------------------

--------------------[ Script, Don't Configure This ]----------------------
local playerIdentifiers
local enableMessages = true
local timeout = m.delay * 1000 * 60 -- from ms, to sec, to min
local playerOnIgnoreList = false
RegisterNetEvent('setPlayerIdentifiers')
AddEventHandler('setPlayerIdentifiers', function(identifiers)
    playerIdentifiers = identifiers
end)
Citizen.CreateThread(function()
    while playerIdentifiers == {} or playerIdentifiers == nil do
        Citizen.Wait(1000)
        TriggerServerEvent('getPlayerIdentifiers')
    end
    for iid in pairs(m.ignorelist) do
        for pid in pairs(playerIdentifiers) do
            if m.ignorelist[iid] == playerIdentifiers[pid] then
                playerOnIgnoreList = true
                break
            end
        end
    end
    if not playerOnIgnoreList then
        while true do
            for i in pairs(m.messages) do
                if enableMessages then
                    chat(i)
                    print('[Announcement] Message #' .. i .. ' sent.')
                end
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(0)
        end
    else
        print('[Announcement] Player is on ignorelist, no announcements will be received.')
    end
end)
function chat(i)
    TriggerEvent('chatMessage', '', {255,255,255}, m.prefix .. m.messages[i] .. m.suffix)
end
RegisterCommand('automessage', function()
    enableMessages = not enableMessages
    if enableMessages then
        status = '^2enabled^5.'
    else
        status = '^1disabled^5.'
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, '^5[Announcement] automessages are now ' .. status)
end, false)
--------------------------------------------------------------------------
