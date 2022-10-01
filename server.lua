ESX = nil 

Citizen.CreateThread(function() 
while ESX == nil do 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
Citizen.Wait(0) 
end 
end)

codeusetime = nil

RegisterNetEvent("checkcode")
AddEventHandler("checkcode", function(code)
    if code == Config.code then
        xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll('SELECT * FROM gusti_giveaway WHERE id = @id',{
            ['@id'] = xPlayer.getIdentifier()
        },
        function (result)
            if result[1] == nil then
            else
            codeusetime = (result[1].usetime)
            end

            if result[1] == nil then 
                MySQL.Async.execute('INSERT INTO gusti_giveaway (id, usetime) VALUES (@id, @usetime)',{ 
                    ['id'] = xPlayer.getIdentifier(),
                    ['usetime'] = 1
                })
            xPlayer.addMoney(Config.money)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = _U("Successfully"), length = 5000 })
            elseif codeusetime < Config.Maxuse then
                MySQL.Async.execute('UPDATE gusti_giveaway SET usetime = @usetime WHERE id = @id',{ 
                    ['@usetime'] = codeusetime + 1,
                    ['@id'] = xPlayer.getIdentifier()
                })
                xPlayer.addMoney(Config.money)
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = _U("Successfully"), length = 5000 })
            elseif codeusetime == Config.Maxuse then
                TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = _U("max_use"), length = 5000 })
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("error"), length = 5000 })
    end
end)


--[[ Version Checker ]]--
local version = "1.0.0"

if Config.CheckForUpdates then
    AddEventHandler("onResourceStart", function(resource)
        if resource == GetCurrentResourceName() then
            CheckFrameworkVersion()
        end
    end)
end

function CheckFrameworkVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/Gustiagung19/gusti-giveaway/master/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print("--------- ^4GUSTI GIVEAWAY VERSION^7 ---------")
            print("gusti-giveaway ^2is up to date^7 and ready to go!")
            print("Running on Version: ^2" .. version .."^7")
            print("^4https://github.com/Gustiagung19/gusti-giveaway^7")
            print("--------------------------------------------")
            print(" ")
        else
          print(" ")
          print("--------- ^4GUSTI GIVEAWAY VERSION^7 ---------")
          print("gusti-giveaway ^1is not up to date!^7 Please update!")
          print("Curent Version: ^1" .. version .. "^7 Latest Version: ^2" .. text .."^7")
          print("^4https://github.com/Gustiagung19/gusti-giveaway^7")
          print("--------------------------------------------")
          print(" ")
        end

    end, "GET", "", {})

end
