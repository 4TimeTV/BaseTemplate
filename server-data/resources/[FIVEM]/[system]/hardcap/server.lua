local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
  local cv = GetConvarInt('sv_maxclients', 32)

  print('Viens de se ^3connecter ^0: ' .. name .. '^7')

  if playerCount >= cv then
    print('Pleins. :(')

    setReason('Le serveur est pleins (' .. tostring(cv) .. ' joueurs).')
    CancelEvent()
  end
end)
