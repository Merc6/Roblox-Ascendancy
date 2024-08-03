local template = {}

--[[
naming guidelines for in the template:
if it's a solo variable then use camelCase
if it's a table then use camelCase and suffix with 'Table'
]]

template.age = 1

template.currentQi = 0

template.maxQi = 0

template.realmTable = {['MajorRealm'] = 1, ['MinorRealm'] = 1}

template.auraColorTable = {0, 0, 0} -- in RGB format

template.isFirstJoin = true

template.path = 'Heavenly'

template.inventoryTable = {}

template.titleTable = {['CurrentEquipped'] = '', ['OwnedTitles'] = {}} 



return template
