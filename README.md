# tf-vitems
#### A vscript library for managing attributes on items and players for Team Fortress 2

## Table Of Contents
 - [Why Does This Exist](README.md#L9)
 - [How To Install](README.md#L14)
 - [Examples](README.md#L21)

### Why Does This Exist
This is a library that I created for my own personal use to better enable me to create concepts like Uber Upgrades, Tower Defence, Weapon Leveling, etc. It has simplified aspects of my own code where I modify a players weapon attributes.

There are still may limitations to this library such as failing to account for static attributes (i.e; attributes on existing TF2 Items) and not having the ability to give players a completely custom weapon as well as other shortcommings that I am yet to experience. 

### How To Install
First Download The Repository And Copy `vitems.nut` and `vitems/` Into Your Projects Directory
Then Add The Following To The Top Of The Script Where You Would Like The Library To Be Loaded
```Squirrel
IncludeScript("vitems.nut");
```
Of course you can place the library into a `lib/` folder, however be sure to update the `IncludeScript` paramater to account for this change.

### Examples
Refer To [How To Install](https://github.com/RRKS101/tf-vitems/blob/main/README.md#L14) For Installation Steps - Its pretty simple.

#### Sample 1 - Increase Clip Size Of A Weapon
This sample uses a clip brush button that triggers on damage the below function
```Squirrel
function button_press()
{
    // Weird behaviour for first time button is damaged. Im a hammer noob :/
	if(activator == null) { printl("WARN: Button Was Pressed By Nothing. Boo!"); return; }  

    // Ensure that the activator is a player to prevent possible edge cases from arising
	if (!activator.IsPlayer()) { printl("WARN: Button Was Pressed By A Non-Player Entity"); return; }
	local player = activator;
    // Get the players ID using the getPlayerID function from vitems. 
    //  This function is an alias to entity.GetScriptId()
	local playerID = getPlayerID(player);

    // Get the players currently active weapon. There is likely a bug here where if the button is pressed by a projectile, 
    //  it is possible that they may have switched to a different weapon but oh well
	local weapon = activator.GetActiveWeapon();
    // If the player is dead when the button is triggered, 
    //  the above function will return null, this is a check for that case
	if (weapon == null) { printl("WARN: Player Did Not Have An Active Weapon. Did They Die?"); return; }
    // Get the weapons ID using the getWeaponID function from vitems. 
    //  This function is an alias to entity.GetScriptId()
	local weaponID = getWeaonID(weapon);

    // Get the clip size bonus attribute associated with the weapon
	local attribVal = getPlayerWeaponAttribute(playerID, weaponID, 4);
    // If it is null, i.e; the weapon does not have this custom attribute, then default to 1
	if (attribVal == null) attribVal = 1;
    // Increase the weapons current clip size by 25%
	setPlayerWeaponAttribute(playerID, weaponID, 4, attribVal+0.25);
	
    // Apply the changes to all attributes for this player. 
    //  Note that it takes a player reference/instance rather than ID
	applyPlayerAttributes(player);
}
```

For Documentation Of All Functions And Possible Edge Cases, Please Refer To The [Wiki](https://github.com/RRKS101/tf-vitems/wiki)
