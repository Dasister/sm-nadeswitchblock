#pragma semicolon 1
#include <sourcemod>
#include <sdkhooks>

public Plugin:myinfo =
{
	name = "Block Nade-to-Pocket",
	author = "Dasister",
	description = "Blocks nade-to-pocket action",
	version =  "0.0.1",
	url = ""
};

const int g_iNumberOfWeaponsToBlockSwitchFromThrowingNade = 2;
const int g_iNumberOfWeaponsToBlockSwitchFrom = 4;

char g_sWeaponNames[2][64] = {
	"weapon_frag_us",
	"weapon_frag_ger"
};

char g_sWeaponNamesLive[4][64] = {
	"weapon_riflegren_us_live",
	"weapon_riflegren_ger_live",
	"weapon_frag_us_live",
	"weapon_frag_ger_live"
};

public OnPluginStart()
{	
    
}

public OnClientPutInServer(int client) 
{ 
    SDKHook(client, SDKHook_WeaponCanSwitchTo, Hook_WeaponCanSwitch); 
} 

public Action Hook_WeaponCanSwitch(int client, int weapon) 
{ 
    char sWeaponSwitchFrom[64];
    GetClientWeapon(client, sWeaponSwitchFrom, sizeof(sWeaponSwitchFrom)); 

    for (int i = 0; i < g_iNumberOfWeaponsToBlockSwitchFromThrowingNade; ++i) {
        if (StrEqual(sWeaponSwitchFrom, g_sWeaponNames[i]) && (GetClientButtons(client) & IN_ATTACK) == IN_ATTACK) {
    	    return Plugin_Handled;
        }
    }

    for (int i = 0; i < g_iNumberOfWeaponsToBlockSwitchFrom; ++i) {
        if (StrEqual(sWeaponSwitchFrom, g_sWeaponNamesLive[i])) {
    	    return Plugin_Handled;
        }
    }
    
    return Plugin_Continue;
}  
