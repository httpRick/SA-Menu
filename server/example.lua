function giveWeaponBuy(id, ammo, money)
	giveWeapon( source, id, ammo, true)
	takePlayerMoney( source, tonumber(money) )
end
addEvent("giveWeaponBuy", true)
addEventHandler("giveWeaponBuy", root, giveWeaponBuy)
