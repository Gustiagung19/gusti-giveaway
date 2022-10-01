RegisterCommand("giveaway",function(args,rawCommand)
    TriggerServerEvent("checkcode",rawCommand[1])
end)
