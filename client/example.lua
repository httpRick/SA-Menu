Ammunation = {Menu = {}}
Ammunation.config = {
	["9mm"] = {price = 200, round =	30, id = 22},
	["Silenced 9mm"] =	{price = 600, round = 30, id = 23},
	["Desert Eagle"] =	{price = 1200, round = 15, id = 24},
	["Tec9"] =	{price = 300, round = 60, id = 32},
	["Micro SMG"] =	{price = 500, round = 60, id = 28},
	["Shotgun"] =	{price = 600, round = 15, id = 25},
	["Sawnoff Shotgun"] =	{price = 800, round = 12, id = 26},
	["Combat Shotgun"] =	{price = 1000, round = 10, id = 27},
	["Grenades"] =	{price = 300, round = 5, 16},
	["Remote Explosives"] =	{price = 2000, round = 1, id = 39},
	["Body Armor"] =	{price = 200, ronud = 1, id = -1},
	["SMG"] =	{price = 2000, round = 90, id = 29},
	["Rifle"] = {price = 1000, round = 20, id = 33},
	["Sniper rifle"] =	{price = 5000, round = 10, id = 34},
	["AK47"] =	{price = 3500, round = 120, id = 30},
	["M4"] =	{price = 4500, round = 150, id = 31},
}



Ammunation.Menu[1] = {}
Ammunation.Menu[1].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[1].Items = {}
Ammunation.Menu[1].Items[1] = createItem(Ammunation.Menu[1].window,"Pistols")
Ammunation.Menu[1].Items[2] = createItem(Ammunation.Menu[1].window,"Micro SMGs")
Ammunation.Menu[1].Items[3] = createItem(Ammunation.Menu[1].window,"Shotguns")
Ammunation.Menu[1].Items[4] = createItem(Ammunation.Menu[1].window,"Thrown")
Ammunation.Menu[1].Items[5] = createItem(Ammunation.Menu[1].window,"Armor")
Ammunation.Menu[1].Items[6] = createItem(Ammunation.Menu[1].window,"SMG")
Ammunation.Menu[1].Items[7] = createItem(Ammunation.Menu[1].window,"Rifles")
Ammunation.Menu[1].Items[8] = createItem(Ammunation.Menu[1].window,"Assault")

Ammunation.Menu[2] = {}
Ammunation.Menu[2].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[2].Items = {}
Ammunation.Menu[2].Items[1] = createItem(Ammunation.Menu[2].window,"9mm")
Ammunation.Menu[2].Items[2] = createItem(Ammunation.Menu[2].window,"Silenced 9mm")
Ammunation.Menu[2].Items[3] = createItem(Ammunation.Menu[2].window,"Desert Eagle")

Ammunation.Menu[3] = {}
Ammunation.Menu[3].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[3].Items = {}
Ammunation.Menu[3].Items[1] = createItem(Ammunation.Menu[3].window,"Tec9")
Ammunation.Menu[3].Items[2] = createItem(Ammunation.Menu[3].window,"Micro SMG")

Ammunation.Menu[3] = {}
Ammunation.Menu[3].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[3].Items = {}
Ammunation.Menu[3].Items[1] = createItem(Ammunation.Menu[3].window,"Tec9")
Ammunation.Menu[3].Items[2] = createItem(Ammunation.Menu[3].window,"Micro SMG")

Ammunation.Menu[4] = {}
Ammunation.Menu[4].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[4].Items = {}
Ammunation.Menu[4].Items[1] = createItem(Ammunation.Menu[4].window,"Shotgun")
Ammunation.Menu[4].Items[2] = createItem(Ammunation.Menu[4].window,"Sawnoff Shotgun")
Ammunation.Menu[4].Items[3] = createItem(Ammunation.Menu[4].window,"Combat Shotgun")

Ammunation.Menu[5] = {}
Ammunation.Menu[5].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[5].Items = {}
Ammunation.Menu[5].Items[1] = createItem(Ammunation.Menu[5].window,"Grenades")
Ammunation.Menu[5].Items[2] = createItem(Ammunation.Menu[5].window,"Remote Explosives")

Ammunation.Menu[6] = {}
Ammunation.Menu[6].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[6].Items = {}
Ammunation.Menu[6].Items[1] = createItem(Ammunation.Menu[6].window,"Body Armor")

Ammunation.Menu[7] = {}
Ammunation.Menu[7].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[7].Items = {}
Ammunation.Menu[7].Items[1] = createItem(Ammunation.Menu[7].window,"SMG")

Ammunation.Menu[8] = {}
Ammunation.Menu[8].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[8].Items = {}
Ammunation.Menu[8].Items[1] = createItem(Ammunation.Menu[8].window,"Rifle")
Ammunation.Menu[8].Items[2] = createItem(Ammunation.Menu[8].window,"Sniper rifle")

Ammunation.Menu[9] = {}
Ammunation.Menu[9].window = createMenu(85, 350, "Ammu-Nation")
Ammunation.Menu[9].Items = {}
Ammunation.Menu[9].Items[1] = createItem(Ammunation.Menu[9].window,"AK47")
Ammunation.Menu[9].Items[2] = createItem(Ammunation.Menu[9].window,"M4")


function createWeaponOffer(str, price, id)
	Ammunation.Menu[10] = {}
	Ammunation.Menu[10].window = createMenu(85, 350, "Ammu-Nation")
	Ammunation.Menu[10].Items = {}
	Ammunation.Menu[10].Items[1] = createItem(Ammunation.Menu[10].window, str, price.."$")
	showTips("SPACE Buy\nRETURN Back.")
	setMenuColumn(Ammunation.Menu[10].window, "Weapon", "Cost")
	setMenuType(Ammunation.Menu[10].window, "shop")
	showMenu(Ammunation.Menu[10].window)

	addEventHandler("onClientMenuSelect", Ammunation.Menu[10].Items[1], function()
		if getPlayerMoney(localPlayer) >= Ammunation.config[str].price then
			triggerServerEvent("giveWeaponBuy", localPlayer, Ammunation.config[str].id, Ammunation.config[str].round, Ammunation.config[str].price)
		end
	end)

	addEventHandler("onClientMenuExit", Ammunation.Menu[10].window, function()
		showMenu(Ammunation.Menu[id].window)
		showTips("Use UP and DOWN to select a weapon.\nSPACE Select\nRETURN Quit.")
		destroyMenu(Ammunation.Menu[10].window)
	end)
end

addEventHandler("onClientMenuExit", Ammunation.Menu[1].window, function()
	hiddenMenu(Ammunation.Menu[1].window)
	hiddenTips()
end)

function showAmmunationMenu()
	showTips("Use UP and DOWN to select a weapon.\nSPACE Select\nRETURN Quit.")
	showMenu(Ammunation.Menu[1].window)
end

for i=1,8 do
	if i ~= 1 then
		for n,v in ipairs(Ammunation.Menu[i].Items) do
			addEventHandler("onClientMenuSelect", Ammunation.Menu[i].Items[n], function(_, str)
				createWeaponOffer(str, Ammunation.config[str].price, i)
			end)
		end
	end
	local a = i+1
	addEventHandler("onClientMenuSelect", Ammunation.Menu[1].Items[i], function()
		showMenu(Ammunation.Menu[a].window)
	end)
end
for i=2,9 do
	addEventHandler("onClientMenuExit", Ammunation.Menu[i].window, showAmmunationMenu)
end

showAmmunationMenu()
