# San Andreas Menu (SA-MENU)


Interface appearance:
[![Actions Status](https://github.com/httpRick/SA-Menu/blob/master/screen.svg)](https://github.com/github/SA-Menu/actions)

## Client Functions

### createMenu
Paramters:
* float position X
* float position Y
* string title Menu
* strint type Menu 'default or shop' is the default mode is automatically selected
returns the created Menu item

```lua
createMenu(85, 350, "Example Menu")
```

## Clientside event

### onClientMenuSelect
Paramters:
* string Item1
* string Item2
returns the item that has been selected

```lua
function exampleSelect(theItem1, theItem2)
    print(theItem1, theItem2, "select this item")
end
addEventHandler("onClientMenuSelect", theItem, exampleSelect)
```

### onClientMenuExit
Paramters:
* the player who closed the menu
return A Menu element that has been closed is returned

```lua
function exampleEscape(theMenu)
    print(theMenu, "menu is closed")
end
addEventHandler("onClientMenuSelect", theItem, exampleEscape)
```
