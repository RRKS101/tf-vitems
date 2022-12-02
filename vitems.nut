local function log(str) { printl("[vitems.nut] LOG: " + str); }
local function warn(str) { printl("[vitems.nut] WARN: " + str); }
local function erro(str) { printl("[vitems.nut] ERROR: " + str); }

IncludeScript("libs/vitems/vitems_IdName.nut");


// playerTracker -> playerID -> weaponID -> AttributeIDs(From wiki)
//                           -> playerID -> AttributeIDs(From wiki)
//                           -> "RemoveAttribsOnDeath"=false
//                           -> ""
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
    playerTracker[playerID]["RemoveAttribsOnDeath"] <- vitems_default_RemoveAttribsOnDeath;
}
function addPlayerWeaponToTracker(playerID, weaponID)
{
    if(!(playerID in playerTracker)) addPlayerToTracker(playerID);
    playerTracker[playerID][weaponID] <- {};
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
function resetPlayerAttributes(playerID)
{
    if(!(playerID in playerTracker)) return null;
    foreach(k,item in playerTracker[playerID])
    {
        if(k == "RemoveAttribsOnDeath") continue;
        playerTracker[playerID][k] <- {};
    }
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

	if(getPlayerWeaponAttributes(player.GetScriptId(), "RemoveAttribsOnDeath"))
    {
        removeAllAttributes(player);
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