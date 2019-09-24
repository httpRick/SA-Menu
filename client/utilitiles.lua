local screenW, screenH = guiGetScreenSize(  )
utilities = { cFunc = {} }
zoom = 0.0

if screenW < 1920 then
    zoom = math.min(2, 1920/screenW)
else
    zoom = 1.0
end

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY, debugging)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText (text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

utilities.cFunc["getScale"] = function(x, y, w, h, alignX, alignY)
    assert(x, "Bad argument @ 'scaleScreen' [Execpted number at argument 1, got "..tostring(x).."]")
    assert(tonumber(x), "Bad argument @ 'scaleScreen' [The argument 1 must be a number!]")
    assert(y, "Bad argument @ 'scaleScreen' [Execpted number at argument 2, got "..tostring(y).."]")
    assert(tonumber(y), "Bad argument @ 'scaleScreen' [The argument 2 must be a number!]")
    assert(w, "Bad argument @ 'scaleScreen' [Execpted number at argument 3, got "..tostring(w).."]")
    assert(tonumber(w), "Bad argument @ 'scaleScreen' [The argument 3 must be a number!]")
    assert(h, "Bad argument @ 'scaleScreen' [Execpted number at argument 4, got "..tostring(h).."]")
    assert(tonumber(h), "Bad argument @ 'scaleScreen' [The argument 4 must be a number!]")
    alignX = alignX or "left"
    alignY = alignY or "top"
    w = w/zoom
    h = h/zoom
    assert( (string.lower(alignX) == "left" or string.lower(alignX) == "center" or string.lower(alignX) == "right") , "Bad argument 5 @ scaleScreen (invalid type alignment X)")
    assert( (string.lower(alignY) == "top" or string.lower(alignY) == "center" or string.lower(alignY) == "bottom") , "Bad argument 5 @ scaleScreen (invalid type alignment X)")    
    if alignX == "left" then
        x = x/zoom
    elseif alignX == "center" then
        x = (screenW/2-w/2)-(x/zoom)
    elseif alignX == "right" then
        x = (screenW-w)-(x/zoom)
    end
    if alignY == "top" then
        y = y/zoom
    elseif alignY == "center" then
        y = (screenH/2-h/2)-(y/zoom)
    elseif alignY == "bottom" then
        y = (screenH-h)-(y/zoom)
    end
    return {x = x, y = y, w = w, h = h} 
end

addEventHandler( "onClientResourceStart", resourceRoot, function()
    if screenW < 1920 then
        zoom = math.min(2, 1920/screenW)
    else
        zoom = 1.0
    end
end)
