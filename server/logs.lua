local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['playermoney'] = '',
    ['playerinventory'] = '',
    ['robbing'] = '',
    ['cuffing'] = '',
    ['drop'] = '',
    ['trunk'] = '',
    ['stash'] = '',
    ['glovebox'] = '',
    ['banking'] = '',
    ['vehicleshop'] = '',
    ['vehicleupgrades'] = '',
    ['shops'] = '',
    ['dealers'] = '',
    ['storerobbery'] = '',
    ['bankrobbery'] = '',
    ['powerplants'] = '',
    ['death'] = '',
    ['joinleave'] = '',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = '',
    ['anticheat'] = '',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ['robbery'] = '',
    ['casino'] = '',
    ['traphouse'] = '',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ['twitter'] = 'https://discord.com/api/webhooks/979065203524247692/l5XiTeYes5jNr8Wp9sQqcBh7oB7t_CQSbKg2mHfHZnJov9zijbeFpRuTYv7QpJD3s0yH',
    ['qbjobs'] = '',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
    ['twitterblue'] = 2061822
}

-- RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
--     local tag = tagEveryone or false
--     local webHook = Webhooks[name] or Webhooks['default']
--     local embedData = {
--         {
--             ['title'] = title,
--             ['color'] = Colors[color] or Colors['default'],
--             ['footer'] = {
--                 ['text'] = os.date('%c'),
--             },
--             ['description'] = message,
--             ['author'] = {
--                 ['name'] = 'QBCore Logs',
--                 ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
--             },
--         }
--     }
--     PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
--     Citizen.Wait(100)
--     if tag then
--         PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
--     end
-- end)

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone, urls)        
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local url = urls or nil
        username = 'QB Logs'
        botname = 'QB Logs'
        avatar = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670'
        icon = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670'
    if name == 'twitter' then
        username = 'Twitter'
        botname = ''
        avatar = 'https://i.pinimg.com/736x/ee/af/9c/eeaf9ce3ab22ecb3904daea1b2eab04a.jpg'
    elseif name == 'discordia' then
        username = 'Discordia'
        botname = ''
        avatar = 'https://i.pinimg.com/originals/0d/8b/43/0d8b437a4c1c788f036590bc4b71ff55.png'
    end
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = botname,
                ['icon_url'] = icon,
            },
            ['image'] ={
                ['url'] = url
            }
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = username, avatar_url = avatar, embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = username, content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
