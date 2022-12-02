local function log(str) { printl("[vitems_IdName.nut] LOG: " + str); }
local function warn(str) { printl("[vitems_IdName.nut] WARN: " + str); }
local function erro(str) { printl("[vitems_IdName.nut] ERROR: " + str); }


local idToName = {};
idToName[0]     <- null;
idToName[1]     <- "damage penalty";
idToName[2]     <- "damage bonus";
idToName[3]     <- "clip size penalty";
idToName[4]     <- "clip size bonus";
idToName[5]     <- "fire rate penalty";
idToName[6]     <- "fire rate bonus";
idToName[7]     <- "heal rate penalty";
idToName[8]     <- "heal rate bonus";
idToName[9]     <- "ubercharge rate penalty";
idToName[10]    <- "ubercharge rate bonus";
idToName[11]    <- "overheal bonus";
idToName[12]    <- "overheal decay penalty";
idToName[13]    <- "overheal decay bonus";
idToName[14]    <- "overheal decay disabled";
idToName[15]    <- "crit mod disabled";
idToName[16]    <- "heal on hit for rapidfire";
idToName[17]    <- "add uber charge on hit";
idToName[18]    <- "medigun charge is crit boost";
idToName[19]    <- "tmp dmgbuff on hit";
idToName[20]    <- "crit vs burning players";
idToName[21]    <- "dmg penalty vs nonburning";
idToName[22]    <- "no crit vs nonburning";
idToName[23]    <- "mod flamethrower push"; // Disables airblast
idToName[24]    <- "mod flamethrower back crit";
idToName[25]    <- "hidden secondary max ammo penalty";
idToName[26]    <- "max health additive bonus";
idToName[27]    <- "alt-fire disabled";
idToName[28]    <- "crit mod disabled hidden";
idToName[29]    <- null
idToName[30]    <- "fists have radial buff";
idToName[31]    <- "critboost on kill";
idToName[32]    <- "slow enemy on hit";
idToName[33]    <- "set cloak is feign death";
idToName[34]    <- "mult cloak meter consume rate";
idToName[35]    <- "mult cloak meter regen rate";
idToName[36]    <- "spread penalty";
idToName[37]    <- "hidden primary max ammo bonus";
idToName[38]    <- "mod bat launches balls";
idToName[39]    <- "dmg penalty vs nonstunned";
idToName[40]    <- "zoom speed mod disabled";
idToName[41]    <- "sniper charge per sec";
idToName[42]    <- "sniper no headshots";
idToName[43]    <- "scattergun no reload single";
idToName[44]    <- "scattergun has knockback";
idToName[45]    <- "bullets per shot";
idToName[46]    <- "sniper zoom penalty";
idToName[47]    <- "sniper no charge";
idToName[48]    <- "set cloak is movement based";
idToName[49]    <- "no double jump";
idToName[50]    <- "absorb damage while cloaked";
idToName[51]    <- "revolver use hit locations";
idToName[52]    <- "backstab shield";
idToName[53]    <- "fire retardant";
idToName[54]    <- "move speed penalty";
idToName[55]    <- "obsolete ammo penalty";
idToName[56]    <- "jarate description";
idToName[57]    <- "health regen";
idToName[58]    <- "self dmg push force increased";
idToName[59]    <- "self dmg push force decreased";
idToName[60]    <- "dmg taken from fire reduced";
idToName[61]    <- "dmg taken from fire increased";
idToName[62]    <- "dmg taken from crit reduced";
idToName[63]    <- "dmg taken from crit increased";
idToName[64]    <- "dmg taken from blast reduced";
idToName[65]    <- "dmg taken from blast increased";
idToName[66]    <- "dmg taken from bullets reduced";
idToName[67]    <- "dmg taken from bullets increased";
idToName[68]    <- "increase player capture value";
idToName[69]    <- "health from healers decreased";
idToName[70]    <- "health from healers increased";
idToName[71]    <- "weapon burn dmg increased";
idToName[72]    <- "weapon burn dmg reduced";
idToName[73]    <- "weapon burn time increased";
idToName[74]    <- "weapon burn time reduced";
idToName[75]    <- "aiming movespeed increased";
idToName[76]    <- "maxammo primary increased";
idToName[77]    <- "maxammo primary reduced";
idToName[78]    <- "maxammo secondary increased";
idToName[79]    <- "maxammo secondary reduced";
idToName[80]    <- "maxammo metal increased";
idToName[81]    <- "maxammo metal reduced";
idToName[82]    <- "cloak consume rate increased";
idToName[83]    <- "cloak consume rate decreased";
idToName[84]    <- "cloak regen rate increased";
idToName[85]    <- "cloak regen rate decreased";
idToName[86]    <- "minigun spinup time increased";
idToName[87]    <- "minigun spinup time decreased";
idToName[88]    <- "max pipebombs increased";
idToName[89]    <- "max pipebombs decreased";
idToName[90]    <- "SRifle Charge rate increased";
idToName[91]    <- "SRifle Charge rate decreased";
idToName[92]    <- "Construction rate increased";
idToName[93]    <- "Construction rate decreased";
idToName[94]    <- "Repair rate increased";
idToName[95]    <- "Repair rate decreased";
idToName[96]    <- "Reload time increased";
idToName[97]    <- "Reload time decreased";
idToName[98]    <- "selfdmg on hit for rapidfire";
idToName[99]    <- "Blast radius increaded";
idToName[100]   <- "Blast radius decreased";
idToName[101]   <- "Projectile range increased";
idToName[102]   <- "Projectile range decreased";
idToName[103]   <- "Projectile speed increased";
idToName[104]   <- "Projectile speed decreased";
idToName[105]   <- "overheal penalty";
idToName[106]   <- "weapon spread bonus";
idToName[107]   <- "move speed bonus"
idToName[108]   <- "health from packs increased";
idToName[109]   <- "health from packs decreased";
idToName[110]   <- "heal on hit for slowfire";
idToName[111]   <- "selfdmg on hit for slowfire";
idToName[112]   <- "ammo regen";
idToName[113]   <- "metal regen";
idToName[114]   <- "mod mini-crit airborne";
idToName[115]   <- "mod shovel damage boost";
idToName[116]   <- "mod soldier buff type";
idToName[117]   <- "dmg falloff increased";
idToName[118]   <- "dmg falloff decreased"; 
idToName[119]   <- "sticky detonate mode";
idToName[120]   <- "sticky arm time penalty";
idToName[121]   <- "stickies detonate stickies";
idToName[122]   <- "mod demo buff type";
idToName[123]   <- "speed boost when active";
idToName[124]   <- "mod wrench builds minisentry";
idToName[125]   <- "max health additive penalty";
idToName[126]   <- "sticky arm time bonus";
idToName[127]   <- "sticky air burst mode";
idToName[128]   <- "provide on active";
idToName[129]   <- "health drain";
idToName[130]   <- "medic regen bonus";
idToName[131]   <- "medic regen penalty";
idToName[132]   <- "community description";
idToName[133]   <- "soilder modem index";
idToName[134]   <- "attach particle effect";
idToName[135]   <- "rocket jump damage reduction";
idToName[136]   <- "mod sentry killed revenge";
idToName[137]   <- "dmg bonus vs buildings";
idToName[138]   <- "dmg penalty vs players";
idToName[139]   <- "lunchbox adds maxhealth bonus";
idToName[140]   <- "hidden maxhealth non buffed";
idToName[141]   <- "selfmade description";
idToName[142]   <- "set item tint RGB";
idToName[143]   <- "custom employee number";
idToName[144]   <- "lunchbox adds minicrits";
idToName[145]   <- "taunt is highfive";
idToName[146]   <- "damage applies to sappers";
idToName[147]   <- "Wrench index";
idToName[148]   <- "building cost reduction";
idToName[149]   <- "bleeding duration";
idToName[150]   <- "turn to gold";
idToName[151]   <- "DEPRECATED socketed item definition id DEPRECATED";
idToName[152]   <- "custom texture lo";
idToName[153]   <- "cannot trade";
idToName[154]   <- "disguise on backstab";
idToName[155]   <- "cannot disguise";
idToName[156]   <- "silent killer";
idToName[157]   <- "disguise speed penalty";
idToName[158]   <- "add cloak on kill";
idToName[159]   <- "SET BONUS: cloak blink time penalty";
idToName[160]   <- "SET BONUS: quiet unstealth";
idToName[161]   <- "flame size penalty";
idToName[162]   <- "flame size bonus";
idToName[163]   <- "flame life penalty";
idToName[164]   <- "flame life bonus";
idToName[165]   <- "charged airblast";
idToName[166]   <- "add cloak on hit";
idToName[167]   <- "disguise damage reduction";
idToName[168]   <- "disguise no burn";
idToName[169]   <- "SET BONUS: dmg from sentry reduced";
idToName[170]   <- "airblast cost increased"
idToName[171]   <- "airblast cost decreased"
idToName[172]   <- "purchased"
idToName[173]   <- "flame ammopersec increased"
idToName[174]   <- "flame ammopersec decreased"
idToName[175]   <- "jarate duration"
idToName[176]   <- "SET BONUS: no death from headshots"
idToName[177]   <- "deploy time increased"
idToName[178]   <- "deploy time decreased"
idToName[179]   <- "minicrits become crits"
idToName[180]   <- "heal on kill"
idToName[181]   <- "no self blast dmg"
idToName[182]   <- "slow enemy on hit major"
idToName[183]   <- "aiming movespeed decreased"
idToName[184]   <- "duel loser account id"
idToName[185]   <- "event date"
idToName[186]   <- "gifter account id"
idToName[187]   <- "set supply crate series"
idToName[188]   <- "preserve ubercharge"
idToName[189]   <- "elevate quality"
idToName[190]   <- "active health regen"
idToName[191]   <- "active health degen"
idToName[192]   <- "referenced item id low"
idToName[193]   <- "referenced item id high"
idToName[194]   <- "referenced item def UPDATED"
idToName[195]   <- "always tradable"
idToName[196]   <- "noise maker"
idToName[197]   <- "halloween item"
idToName[198]   <- "collection bits DEPRECATED"
idToName[199]   <- "switch from wep deploy time decreased"
idToName[200]   <- "enables aoe heal"
idToName[201]   <- "gesture speed increase"
idToName[202]   <- "charge time increased"
idToName[203]   <- "drop health pack on kill"
idToName[204]   <- "hit self on miss"
idToName[205]   <- "dmg from ranged reduced"
idToName[206]   <- "dmg from melee increased"
idToName[207]   <- "blast dmg to self increased"
idToName[208]   <- "Set DamageType Ignite"
idToName[209]   <- "minicrit vs burning player"
idToName[210]   <- null
idToName[211]   <- "tradable after date"
idToName[212]   <- "force level display"
idToName[213]   <- null
idToName[214]   <- "kill eater"
idToName[215]   <- "apply z velocity on damage"
idToName[216]   <- "apply look velocity on damage"
idToName[217]   <- "sanguisuge"
idToName[218]   <- "mark for death"
idToName[219]   <- "decapitate type"
idToName[220]   <- "restore health on kill"
idToName[221]   <- "mult decloak rate"
idToName[222]   <- "mult sniper charge after bodyshot"
idToName[223]   <- "mult sniper charge after miss"
idToName[224]   <- "dmg bonus while half dead"
idToName[225]   <- "dmg penalty while half alive"
idToName[226]   <- "honourbound"
idToName[227]   <- "custom texture hi"
idToName[228]   <- "makers mark id"
idToName[229]   <- "unique craft index"
idToName[230]   <- "mod medic killed revenge"
idToName[231]   <- "medigun charge is megaheal"
idToName[232]   <- "mod medic killed minicrit boost"
idToName[233]   <- "mod medic healed damage bonus"
idToName[234]   <- "mod medic deploy time penalty"
idToName[235]   <- "mod shovel speed boost"
idToName[236]   <- "mod weapon blocks healing"
idToName[237]   <- "mult sniper charge after headshot"
idToName[238]   <- "minigun no spin sounds"
idToName[239]   <- "ubercharge rate bonus for healer"
idToName[240]   <- "reload time decreased while healed"
idToName[241]   <- "reload time increased hidden"
idToName[242]   <- "mod medic killed marked for death"
idToName[243]   <- "mod rage on hit penalty"
idToName[244]   <- "mod rage on hit bonus"
idToName[245]   <- "mod rage damage bonus"
idToName[246]   <- "mult charge turn control"
idToName[247]   <- "no charge impact range"
idToName[248]   <- "charge impact damage increased"
idToName[249]   <- "charge recharge rate increased"
idToName[250]   <- "air dash count"
idToName[251]   <- "speed buff ally"
idToName[252]   <- "damage force reduction"
idToName[253]   <- "mult cloak rate"
idToName[254]   <- null
idToName[255]   <- "airblast pushback scale"
idToName[256]   <- "mult airblast refire time"
idToName[257]   <- "airblast vertical pushback scale"
idToName[258]   <- "ammo becomes health"
idToName[259]   <- "boots falling stomp"
idToName[260]   <- "deflection size multiplier"
idToName[261]   <- "set item tint RGB 2"
idToName[262]   <- "saxxy award category"
idToName[263]   <- "melee bounds multiplier"
idToName[264]   <- "melee range multiplier"
idToName[265]   <- "mod mini-crit airborne deploy"
idToName[266]   <- "projectile penetration"
idToName[267]   <- "mod crit while airborne"
idToName[268]   <- "mult sniper charge penalty DISPLAY ONLY"
idToName[269]   <- "mod see enemy health"
idToName[270]   <- "powerup max charges"
idToName[271]   <- "powerup charges"
idToName[272]   <- "powerup duration"
idToName[273]   <- "critboost"
idToName[274]   <- "ubercharge"
idToName[275]   <- "cancel falling damage"
idToName[276]   <- "bidirectional teleport"
idToName[277]   <- "multiple sentries"
idToName[278]   <- "effect bar recharge rate increased"
idToName[279]   <- "maxammo grenades1 increased"
idToName[280]   <- "override projectile type"
idToName[281]   <- "energy weapon no ammo"
idToName[282]   <- "energy weapon charged shot"
idToName[283]   <- "energy weapon penetration"
idToName[284]   <- "energy weapon no hurt building"
idToName[285]   <- "energy weapon no deflect"
idToName[286]   <- "engy building health bonus"
idToName[287]   <- "engy sentry damage bonus"
idToName[288]   <- "no crit boost"
idToName[289]   <- "centerfire projectile"
idToName[290]   <- null
idToName[291]   <- null
idToName[292]   <- "kill eater score type"
idToName[293]   <- "kill eater score type 2"
idToName[294]   <- "kill eater 2"
idToName[295]   <- "has pipboy build interface"
idToName[296]   <- "sapper kills collect crits"
idToName[297]   <- "sniper only fire zoomed"
idToName[298]   <- "mod ammo per shot"
idToName[299]   <- "add onhit addammo"
idToName[300]   <- "electrical airblast DISPLAY ONLY"
idToName[301]   <- "mod use metal ammo type"
idToName[302]   <- "expiration date"
idToName[303]   <- "mod max primary clip override"
idToName[304]   <- "sniper full charge damage bonus"
idToName[305]   <- "sniper fires tracer"
idToName[306]   <- "sniper no headshot without full charge"
idToName[307]   <- "mod no reload DISPLAY ONLY"
idToName[308]   <- "sniper penetrate players when charged"
idToName[309]   <- "crit kill will gib"

function convertIDToName(id)
{
    if(!(id in idToName)) return null;
    return idToName[id];
}

function convertNameToID(name)
{
    foreach (k,v in idToName)
    {
        if (k == name) { return v; }
    }
    return 0;
}

log("Initialized!");