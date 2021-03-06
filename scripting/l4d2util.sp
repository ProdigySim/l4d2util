#pragma semicolon 1

#define __IN_L4D2UTIL__

#include <l4d2util>
#include "rounds.inc"
#include "tanks.inc"
#include "weapons.inc"

new const String:sLibraryName[] = "l4d2util";

public Plugin:myinfo = {
    name = "L4D2 Utilities",
    author = "E'rybody",
    description = "Useful functions and forwards for Left 4 Dead 2 Sourcemod plugins",
    version = "1.0",
    url = "https://github.com/Jahze/l4d2util"
}

public OnPluginStart() {
    L4D2Util_Weapons_Init();
    L4D2Util_Tanks_Init();
    
    HookEvent("round_start", L4D2Util_RoundStart);
    HookEvent("round_end", L4D2Util_RoundEnd);
    HookEvent("tank_spawn", L4D2Util_TankSpawn);
    HookEvent("player_death", L4D2Util_PlayerDeath);
}

public OnMapEnd() {
    L4D2Util_Rounds_OnMapEnd();
}

public APLRes:AskPluginLoad2(Handle:hPlugin, bool:bLateLoad, String:sError[], iErrMax) {
    L4D2Util_Weapons_CreateNatives();
    
    L4D2Util_Rounds_CreateForwards();
    L4D2Util_Tanks_CreateForwards();
    
    RegPluginLibrary(sLibraryName);
    
    return APLRes_Success;
}

public Action:L4D2Util_RoundStart(Handle:event, const String:name[], bool:dontBroadcast) {
    L4D2Util_Rounds_OnRoundStart();
    L4D2Util_Tanks_OnRoundStart();
}

public Action:L4D2Util_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast) {
    L4D2Util_Rounds_OnRoundEnd();
}

public Action:L4D2Util_TankSpawn(Handle:event, const String:name[], bool:dontBroadcast) {
    new iTank = GetClientOfUserId(GetEventInt(event, "userid"));
    
    L4D2Util_Tanks_TankSpawn(iTank);
}

public Action:L4D2Util_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast) {
    new iPlayer = GetClientOfUserId(GetEventInt(event, "userid"));
    
    L4D2Util_Tanks_PlayerDeath(iPlayer);
}

