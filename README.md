# San Andreas Menu (SA-MENU)


### Screen:
[![Actions Status](https://github.com/httpRick/SA-Menu/blob/master/screen.svg)](https://github.com/github/SA-Menu/actions)

## Client Functions

### createMenu
Paramters:
* float position X
* float position Y
* string title Menu
* strint type Menu 'default or shop' is the default mode is automatically selected
returns the created Menu

```lua
createMenu(85, 350, "Example Menu")
```

### createItem
Paramters:
* element Menu
* string left Item
* string right Item
returns the created Menu item

```lua
local theMenu = createMenu(85, 350, "Example Menu")
createItem(theMenu, "Left item", "Right item")
```

### destroyMenu
Paramters:
* element Menu
returns true if the item is destroyed returns false if no item is found
```lua
local theMenu = createMenu(85, 350, "Example Menu")
destroyMenu(theMenu)
```

### showMenu
Paramters:
* element Menu
returns true if the item is destroyed returns false if no item is found
```lua
local theMenu = createMenu(85, 350, "Example Menu")
showMenu(theMenu)
```

### hiddenMenu
Paramters:
* element Menu
returns true if the item is destroyed returns false if no item is found
```lua
local theMenu = createMenu(85, 350, "Example Menu")
hiddenMenu(theMenu)
```

### setMenuType
Paramters:
* element Menu
* string Menu type
Available menu types are: "default", "shop"
returns true if a good type is input, otherwise false
```lua
local theMenu = createMenu(85, 350, "Example Menu")
setTypeMenu(theMenu, "shop")
```
### setMenuColumn
Paramters:
* element Menu
* string left column
* string right column
![#f03c15]Only for the store type
```lua
local theMenu = createMenu(85, 350, "Example Menu")
setTypeMenu(theMenu, "shop")
setMenuColumn(theMenu, "Products", "Price")
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
return a Menu element that has been closed is returned

```lua
function exampleEscape(theMenu)
    print(theMenu, "menu is closed")
end
addEventHandler("onClientMenuSelect", theMenu, exampleEscape)
```
