local function log(str) { printl("[vitems.nut] LOG: " + str); }
local function warn(str) { printl("[vitems.nut] WARN: " + str); }
local function erro(str) { printl("[vitems.nut] ERROR: " + str); }

IncludeScript("libs/tf-vitems/vitems/vitems_IdName.nut");


// playerTracker -> playerID -> weaponID -> AttributeIDs(From wiki)+"metaAttribs":{}
//                           -> playerID -> AttributeIDs(From wiki)+"metaAttribs":{}
//                           -> "metaAttribs":
//                                  +-> RemoveAttribsOnDeath = vitems_default_RemoveAttribsOnDeath
local playerTracker = {}


vitems_default_RemoveAttribsOnDeath <- false;

function getPlayerID(player)
{
    return player.GetScriptId();
}
function getWeaonID(weapon)
{
    return weapon.GetScriptId();
}
function addPlayerToTracker(playerID)
{
    playerTracker[playerID] <- {};
    playerTracker[playerID][playerID] <- {}
    playerTracker[playerID]["metaAttribs"] <- {};
    playerTracker[playerID]["metaAttribs"]["RemoveAttribsOnDeath"] <- vitems_default_RemoveAttribsOnDeath
}
function addPlayerWeaponToTracker(playerID, weaponID)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    playerTracker[playerID][weaponID] <- {};
    playerTracker[playerID][weaponID]["metaAttribs"] <- {};
}
function addPlayerWeaponAttributeToTracker(playerID, weaponID, attribID, attribVal)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(!(weaponID in playerTracker[playerID])) addPlayerWeaponToTracker(playerID, weaponID);
    playerTracker[playerID][weaponID][attribID] <- attribVal;
}
function setPlayerWeaponAttribute(playerID, weaponID, attribID, newVal)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(!(weaponID in playerTracker[playerID])) addPlayerWeaponToTracker(playerID, weaponID);
    if(!(attribID in playerTracker[playerID][weaponID])) 
    {
        addPlayerWeaponAttributeToTracker(playerID, weaponID, attribID, newVal);
        return;
    }
    playerTracker[playerID][weaponID][attribID] = newVal;
}
function setPlayerWeaponMetaAttribute(playerID, weaponID, metaKey, metaVal)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(!(weaponID in playerTracker[playerID])) addPlayerWeaponToTracker(playerID, weaponID);
    if(metaKey in playerTracker[playerID][weaponID]["metaAttribs"])
    {
        playerTracker[playerID][weaponID]["metaAttribs"][metaKey] = metaVal;
    }
    else
    {
        playerTracker[playerID][weaponID]["metaAttribs"][metaKey] <- metaVal;
    }
}
function setPlayerMetaAttribute(playerID, metaKey, metaVal)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(metaKey in playerTracker[playerID]["metaAttribs"])
    {
        playerTracker[playerID]["metaAttribs"][metaKey] = metaVal;
    }
    else
    {
        playerTracker[playerID]["metaAttribs"][metaKey] <- metaVal;
    }
}
function getPlayerAttributes(playerID)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    return playerTracker[playerID];
}
function getPlayerWeaponAttributes(playerID, weaponID)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(!(weaponID in playerTracker[playerID])) addPlayerWeaponToTracker(playerID, weaponID);
    return playerTracker[playerID][weaponID];
}
function getPlayerWeaponAttribute(playerID, weaponID, attribID)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    if(!(weaponID in playerTracker[playerID])) addPlayerWeaponToTracker(playerID, weaponID);
    if(!(attribID in playerTracker[playerID][weaponID])) return null;
    return playerTracker[playerID][weaponID][attribID];
}
function getPlayerWeaponMetaAttribute(playerID, weaponID, metaKey)
{
    local metaAttribs = getPlayerWeaponAttribute(playerID, weaponID, "metaAttribs");
    if (metaKey in metaAttribs) return metaAttribs[metaKey];
    return null;
}
function getPlayerMetaAttribute(playerID, metaKey)
{
    local metaAttribs = getPlayerAttributes(playerID)["metaAttribs"];
    if(metaKey in metaAttribs) return metaAttribs[metaKey];
    return null;
}
function resetPlayerAttributes(playerID)
{
    if(!(playerID in playerTracker)) return false;
    foreach(k,item in playerTracker[playerID])
    {
        if(k == "metaAttribs") continue;
        playerTracker[playerID][k] <- {};
    }
    return true;
}
// Only deletes from cache
function removePlayerWeaponAttribute(playerID, weaponID, attribID)
{
    if(weaponID == "metaAttribs") return false;
    if(!(playerID in playerTracker)) return false;
    if(!(weaponID in playerTracker[playerID]) && weaponID != null) return false;
    if(!(attribID in playerTracker[playerID][weaponID])) return true;
    
    // If weaponID is null, remove all occurences of the attribute in the player's weapons and player
    if(weaponID == null)
    {
        foreach (wID,attribs in playerTracker[playerID]) 
        {
            if (wID == "metaAttribs") continue;
            if (attribID in attribs)
            {
                if(attribID == "metaAttribs") continue;
                playerTracker[playerID][wID].rawdelete(attribID);
            }
        }
    }
    else
    {
        playerTracker[playerID][weaponID].rawdelete(attribID);
    }

    return true;
}

function removePlayerAttribute(player, weaponID, attribID)
{
    if(weaponID == "metaAttribs") return;

    local attribName = convertIDToName(attribID);
    if(attribName == null) { warn("AttribID did not have an existing AttribName, and therefore could not be added/removed"); return; }

    local playerID = player.GetScriptId();
    if (playerID == null) { warn("A Player Doesn't Have An ID?"); return; }

    local playerAttribs = getPlayerAttributes(playerID);
	if (playerAttribs == null) { warn("A Player Did Not Have Any Attributes"); return; }

    local weapon = Entities.FindByClassnameWithin(null, "tf_weapon_*", player.GetOrigin(), 50);
    if(weapon == null) return;


    if(playerID == weaponID)
    {
        player.RemoveCustomAttribute(attribName);
    }
    else
    {
        while(weapon)
        {
            if(weapon.GetOwner() != null)
            {
                if(weapon.GetOwner().GetScriptId() == playerID && (weapon.GetScriptId() == weaponID || weaponID == null))
                {
                    if(weapon.GetScriptId() in playerAttribs)
                    {
                        if(attribID in playerAttribs[weapon.GetScriptId()])
                        {
                            if(attribID == "metaAttribs") continue;
                            weapon.RemoveAttribute(attribName);
                        }
                    }
                }
            }

            weapon = Entities.FindByClassnameWithin(weapon, "tf_weapon_*", player.GetOrigin(), 50);
        }
    }

    removePlayerWeaponAttribute(player.GetScriptId(), weaponID, attribID);
}
function applyPlayerAttributes(player)
{
    local playerID = player.GetScriptId();
    if (playerID == null) { warn("A Player Doesn't Have An ID?"); return; }

    local playerAttribs = getPlayerAttributes(playerID);
	if (playerAttribs == null) { warn("A Player Did Not Have Any Attributes"); return; }

    // Add Weapon Attributes
    local weapon = Entities.FindByClassnameWithin(null, "tf_weapon_*", player.GetOrigin(), 50);
    if(weapon == null) return;
    
    while(weapon)
    {
        if(weapon.GetOwner() != null)
        {
            if(weapon.GetOwner().GetScriptId() == playerID)
            {
                if(weapon.GetScriptId() in playerAttribs)
                {
                    foreach (attrib,val in playerAttribs[weapon.GetScriptId()]) 
                    {
                        if(attrib == "metaAttribs") continue;
                        local attribName = convertIDToName(attrib);
                        if (attribName != null)
                        {
                            weapon.AddAttribute(attribName, val, -1);
                        }
                    }
                }
            }
        }

        weapon = Entities.FindByClassnameWithin(weapon, "tf_weapon_*", player.GetOrigin(), 50);
    }

    // Add Player Attributes
    foreach (attrib,val in playerAttribs[playerID]) 
    {
        if(attrib == "metaAttribs") continue;
        local attribName = convertIDToName(attrib);
        if (attribName != null)
        {
            player.AddCustomAttribute(attribName, val, -1);
        }
    }
}

function removeAllAttributes(player)
{
    local playerID = player.GetScriptId();
    if (playerID == null) { warn("A Player Doesn't Have An ID?"); return; }

    local playerAttribs = getPlayerAttributes(playerID);
	if (playerAttribs == null) { warn("A Player Did Not Have Any Attributes"); return; }

    // Remove Weapon Attributes
    local weapon = Entities.FindByClassnameWithin(null, "tf_weapon_*", player.GetOrigin(), 50);
    if(weapon == null) return;
    
    while(weapon)
    {
        if(weapon.GetOwner() != null)
        {
            if(weapon.GetOwner().GetScriptId() == playerID)
            {
                if(weapon.GetScriptId() in playerAttribs)
                {
                    foreach (attrib,val in playerAttribs[weapon.GetScriptId()]) 
                    {
                        if(attrib == "metaAttribs") continue;
                        local attribName = convertIDToName(attrib);
                        if (attribName != null)
                        {
                            weapon.RemoveAttribute(attribName);
                        }
                    }
                }
            }
        }

        weapon = Entities.FindByClassnameWithin(weapon, "tf_weapon_*", player.GetOrigin(), 50);
    }

    // Remove Player Attributes
    foreach (attrib,val in playerAttribs[playerID]) 
    {
        if(attribID == "metaAttribs") continue;
        local attribName = convertIDToName(attrib);
        if (attribName != null)
        {
            player.RemoveCustomAttribute(attribName);
        }
    }

    // Remove Attributes From Tracker
    resetPlayerAttributes(playerID);
}

function OnGameEvent_player_death(params)
{
	local playerUID = params.userid;
	if(playerUID == null) { warn("Player Did Not Have A UserID?"); return; }

	local player = GetPlayerFromUserID(playerUID);
	if(player == null) { warn("A Player Died, But That Player Doesn't Exist?"); return; }
    if(!(player.GetScriptId() in playerTracker)) { return; }

    local playerID = player.GetScriptId();

	if(getPlayerMetaAttribute(player.GetScriptId(), "RemoveAttribsOnDeath") == true)
    {
        removeAllAttributes(player);
    }
    else
    {
        foreach (weaponID,v1 in playerTracker[playerID])
        {
            if(weaponID == "metaAttribs") continue;

            if (getPlayerWeaponMetaAttribute(playerID, weaponID, "RemoveAttribsOnDeath"))
            {
                // This is horrible!!!
                foreach (attribID, v2 in getPlayerWeaponAttributes(playerID, weaponID))
                {
                    if(attribID == "metaAttribs") continue;
                    removePlayerAttribute(player, weaponID, attribID);
                }
            }
        }
    }
}

function OnGameEvent_player_changeclass(params)
{
    local playerUID = params.userid;
	if(playerUID == null) { warn("Player Did Not Have A UserID?"); return; }

	local player = GetPlayerFromUserID(playerUID);
	if(player == null) { warn("A Player Died, But That Player Doesn't Exist?"); return; }

	removeAllAttributes(player);
}

__CollectGameEventCallbacks(this)


log("Initialized!")