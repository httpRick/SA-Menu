Menu = {focus = false, select = 1.0}
Menu.fonts = {}
Menu.fonts.beckett = dxCreateFont("client/files/fonts/beckett.ttf", 35/zoom)
Menu.fonts.tahomaBold = dxCreateFont("client/files/fonts/tahoma-bold.ttf", 19/zoom)
Menu.fonts.openSansBold = dxCreateFont("client/files/fonts/openSans-Bold.ttf", 30/zoom)


Menu.cache = {}
addEvent("onClientMenuSelect", true)
addEvent("onClientMenuExit", true)

function createMenu(posX, posY, titleWindow, typeWindow)
    assert(tonumber(posX), "Bad argument @ 'createMenu' [The argument 1 must be a number!]")
    assert(posX, "Bad argument @ 'createMenu' [Execpted number at argument 1, got "..tostring(posX).."]")
    assert(tonumber(posY), "Bad argument @ 'createMenu' [The argument 2 must be a number!]")
    assert(posY, "Bad argument @ 'createMenu' [Execpted number at argument 2, got "..tostring(posY).."]")
    if titleWindow then
        assert(tostring(titleWindow) == titleWindow and not tonumber(titleWindow), "Bad argument @ 'createMenu' [The argument 3 must be a string!]")
    end
    local theMenu = createElement("SA-Menu")
    Menu.cache[theMenu] = {}
    Menu.cache[theMenu].this = theMenu
    Menu.cache[theMenu].attributes = {title = titleWindow, type = typeWindow or "default", horizontal = "left"}
    Menu.cache[theMenu].attributes.pos = {x = posX, y = posY}
    Menu.cache[theMenu].attributes.horizontalTitle = "center"
    Menu.cache[theMenu].items = {}
    Menu.cache[theMenu].scale = {}
    Menu.cache[theMenu].scale.body = utilities.cFunc["getScale"](Menu.cache[theMenu].attributes.pos.x, Menu.cache[theMenu].attributes.pos.y, 420, 35, Menu.cache[theMenu].attributes.horizontal)
    Menu.cache[theMenu].scale.title = utilities.cFunc["getScale"](Menu.cache[theMenu].attributes.pos.x, Menu.cache[theMenu].attributes.pos.y-25, 420, 35, Menu.cache[theMenu].attributes.horizontal)
    return theMenu
end

function createItem(theMenu, left, right)
    if isElement(theMenu) and Menu.cache[theMenu] then
        table.insert(Menu.cache[theMenu].items, {left, right, createElement("SA-Item")})
        return Menu.cache[theMenu].items[#Menu.cache[theMenu].items][3]
    end
end

function destroyMenu(theMenu)
    if isElement(theMenu) and Menu.cache[theMenu] then
        Menu.cache[theMenu].attributes = {}
        Menu.cache[theMenu].scale = {}
        for i,v in ipairs(Menu.cache[theMenu].items) do
        	destroyElement( v[3] )
        end
        Menu.cache[theMenu].items = {}
        destroyElement(Menu.cache[theMenu].this)
        Menu.cache[theMenu] = {}
        if Menu.focus == theMenu then
            Menu.focus = false
        end
        collectgarbage()
        return true
    else
        return false
    end 
end

function showMenu(theMenu)
    if isElement(theMenu) and Menu.cache[theMenu] then
        if not Menu.focus then
            Menu.focus = theMenu
            addEventHandler( "onClientKey", root, onClientKeyMenu)
            addEventHandler( "onClientRender", root, onClientRenderMenu)
        else
            Menu.focus = theMenu
        end
        Menu.select = 1
    end
end

function hiddenMenu(theMenu)
    if isElement(theMenu) and Menu.cache[theMenu] then
        if Menu.focus then
            removeEventHandler( "onClientRender", root, onClientRenderMenu)
        end
    end
end

function setMenuType(theMenu, type)
    if isElement(theMenu) and Menu.cache[theMenu] then
        if type ~= "shop" and type ~= "default" then
            error("setMenuType Bad Type Menu")
        end
        Menu.cache[theMenu].attributes.type = type
    else
    	return false
    end
end

function setMenuColumn(theMenu, left, right)
    if isElement(theMenu) and Menu.cache[theMenu] then
    	if left then
        	Menu.cache[theMenu].attributes.column = {left, right}
    	else
    		Menu.cache[theMenu].attributes.column = false
    	end
    	return true
    else
    	return false
    end
end

function isMenuShowing(theMenu)
    if isElement(theMenu) and Menu.cache[theMenu] then
        return Menu.focus == Menu.cache[theMenu]
    end
end

function setMenuTitleAlign(theMenu)
	if isElement(theMenu) and Menu.cache[theMenu] then
		assert( (string.lower(alignX) == "left" or string.lower(alignX) == "right") , "Bad argument 2 @ setMenuTitleAlign (invalid type alignment X)")
		Menu.cache[theMenu].attributes.horizontalTitle = alignX
	end
end

function setMenuHorizontalAlign(theMenu, alignX)
	if isElement(theMenu) and Menu.cache[theMenu] then
		assert( (string.lower(alignX) == "left" or string.lower(alignX) == "right") , "Bad argument 2 @ setMenuHorizontalAlign (invalid type alignment X)")
		Menu.cache[theMenu].attributes.horizontal = alignX
		Menu.cache[theMenu].scale.body = utilities.cFunc["getScale"](Menu.cache[theMenu].attributes.pos.x, Menu.cache[theMenu].attributes.pos.y, 420, 35, Menu.cache[theMenu].attributes.horizontal)
    	Menu.cache[theMenu].scale.title = utilities.cFunc["getScale"](Menu.cache[theMenu].attributes.pos.x, Menu.cache[theMenu].attributes.pos.y-25, 420, 35, Menu.cache[theMenu].attributes.horizontal)
	end
end

function onClientRenderMenu()
    if Menu.focus and Menu.cache[Menu.focus] then
        dxDrawRectangle(Menu.cache[Menu.focus].scale.body.x, Menu.cache[Menu.focus].scale.body.y, Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(0, 0, 0, 150) )
        dxDrawBorderedText(2.0/zoom, Menu.cache[Menu.focus].attributes.title, Menu.cache[Menu.focus].scale.title.x, Menu.cache[Menu.focus].scale.title.y, Menu.cache[Menu.focus].scale.title.x+Menu.cache[Menu.focus].scale.title.w, Menu.cache[Menu.focus].scale.title.h, nil, 1.0, Menu.fonts.beckett, Menu.cache[Menu.focus].attributes.horizontalTitle)
        if Menu.cache[Menu.focus].attributes.type == "default" then
            for i,v in ipairs(Menu.cache[Menu.focus].items) do
                dxDrawRectangle(Menu.cache[Menu.focus].scale.body.x, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h)*(i), Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(0, 0, 0, 150) )
                dxDrawBorderedText(2.0/zoom, v[1], Menu.cache[Menu.focus].scale.body.x+27/zoom, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h)*(i), Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, i == Menu.select and tocolor(200, 200, 220) or tocolor(100, 100, 120), 1.0, Menu.fonts.tahomaBold, "left")
            end
        elseif Menu.cache[Menu.focus].attributes.type == "shop" then
        	local width = dxGetTextWidth( Menu.cache[Menu.focus].attributes.column[2], 1.0, Menu.fonts.tahomaBold )
            dxDrawRectangle(Menu.cache[Menu.focus].scale.body.x, Menu.cache[Menu.focus].scale.body.y+Menu.cache[Menu.focus].scale.body.h, Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(0, 0, 0, 150) )
            dxDrawBorderedText(2.0/zoom, Menu.cache[Menu.focus].attributes.column[1], Menu.cache[Menu.focus].scale.body.x+27/zoom, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h), Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(220, 220, 220), 1.0, Menu.fonts.tahomaBold, "left")
            dxDrawBorderedText(2.0/zoom, Menu.cache[Menu.focus].attributes.column[2], (Menu.cache[Menu.focus].scale.body.x+Menu.cache[Menu.focus].scale.body.w)-(27/zoom)-width, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h), Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(220, 220, 220), 1.0, Menu.fonts.tahomaBold, "left")
            for i,v in ipairs(Menu.cache[Menu.focus].items) do
            	local x, y, w, h = (Menu.cache[Menu.focus].scale.body.x+Menu.cache[Menu.focus].scale.body.w)-(27/zoom)-width, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h)*(i+1), width, Menu.cache[Menu.focus].scale.body.h
                dxDrawRectangle(Menu.cache[Menu.focus].scale.body.x, Menu.cache[Menu.focus].scale.body.y+(Menu.cache[Menu.focus].scale.body.h)*(i+1), Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, tocolor(0, 0, 0, 150) )
                dxDrawBorderedText(2.0/zoom, v[1], Menu.cache[Menu.focus].scale.body.x+27/zoom, y, Menu.cache[Menu.focus].scale.body.w, Menu.cache[Menu.focus].scale.body.h, i == Menu.select and tocolor(200, 200, 220) or tocolor(100, 100, 120), 1.0, Menu.fonts.tahomaBold, "left")
                dxDrawBorderedText(2.0/zoom, v[2], x, y, x+w, h, i == Menu.select and tocolor(200, 200, 220) or tocolor(100, 100, 120), 1.0, Menu.fonts.tahomaBold, "center")
            end
        end
    else
        removeEventHandler( "onClientKey", root, onClientKeyMenu)
        removeEventHandler( "onClientRender", root, onClientRenderMenu)
        removeEventHandler( "onClientRender", root, onClientRenderMenu)
    end
end

function onClientKeyMenu(button, press)
    if Menu.focus and Menu.cache[Menu.focus] then
        if button == "arrow_u" and press and #Menu.cache[Menu.focus].items > 1 then
            playSoundFrontEnd(3)
            Menu.select = Menu.select-1 < 1 and #Menu.cache[Menu.focus].items or Menu.select-1
        elseif button == "arrow_d" and press and #Menu.cache[Menu.focus].items > 1 then
            playSoundFrontEnd(3)
            Menu.select = Menu.select+1 > #Menu.cache[Menu.focus].items and 1 or Menu.select+1
        elseif button == "space" and press then
            playSoundFrontEnd(1)
            triggerEvent("onClientMenuSelect", Menu.cache[Menu.focus].items[Menu.select][3], localPlayer, Menu.cache[Menu.focus].items[Menu.select][1], Menu.cache[Menu.focus].items[Menu.select][2])
        elseif button == "enter" and press then
            playSoundFrontEnd(4)
            triggerEvent("onClientMenuExit", Menu.focus, localPlayer)
        end
    end
end


local tips = {str = false}
tips.body = utilities.cFunc["getScale"](85, 61, 524, 50)

function showTips(str)
	if not tips.str then
	tips.str = str
		addEventHandler( "onClientRender", root, onClientRenderTips)
	else
		tips.str = str
	end
end

function hiddenTips()
	if tips.str then
		removeEventHandler( "onClientRender", root, onClientRenderTips)
		tips.str = false
	end
end

local function searchNewLines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

function onClientRenderTips()
	if tips.str then
		local width = dxGetTextWidth( tips.str, 1.0, Menu.fonts.openSansBold)+15/zoom
		local height = dxGetFontHeight(1.0, Menu.fonts.openSansBold )
		local heightBody = tips.body.h
        if width > tips.body.w then
            heightBody = tips.body.h + height * math.floor(width/tips.body.w)
        end
		local lines = searchNewLines(tips.str)
		if #lines > 1 then
			heightBody = heightBody + (tips.body.h) * (#lines-1)
		end        
        local x, y, w, h = tips.body.x, tips.body.y, tips.body.w, heightBody
		dxDrawRectangle( x, y-10/zoom, w, h+30/zoom, tocolor(0, 0, 0, 150) )
		dxDrawText(tips.str, x+15/zoom, y, w, h, tocolor(220, 220, 220), 1.0, Menu.fonts.openSansBold, "left", "top", false, true)
	else
		removeEventHandler( "onClientRender", root, onClientRenderTips)
	end
end
