/***************************************************************************************

	Copyright (C) 2012 BCServ (plugins@bcserv.eu)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
***************************************************************************************/

/***************************************************************************************


	C O M P I L E   O P T I O N S


***************************************************************************************/
// enforce semicolons after each code statement
#pragma semicolon 1

/***************************************************************************************


	P L U G I N   I N C L U D E S


***************************************************************************************/
#include <sourcemod>
#include <sdktools>
#include <smlib>
#include <smlib/pluginmanager>


/***************************************************************************************


	P L U G I N   I N F O


***************************************************************************************/
public Plugin:myinfo = {
	name 						= "Block Spectator Sprinting",
	author 						= "Chanz",
	description 				= "Blocks the sprint button for spectators",
	version 					= "1.0",
	url 						= "http://bcserv.eu/"
}

/***************************************************************************************


	P L U G I N   D E F I N E S


***************************************************************************************/


/***************************************************************************************


	G L O B A L   V A R S


***************************************************************************************/
// Server Variables


// Plugin Internal Variables


// Console Variables
new Handle:g_cvarEnable 					= INVALID_HANDLE;


// Console Variables: Runtime Optimizers
new g_iPlugin_Enable 					= 1;


// Timers


// Library Load Checks


// Game Variables


// Map Variables


// Client Variables


// M i s c


/***************************************************************************************


	F O R W A R D   P U B L I C S


***************************************************************************************/
public OnPluginStart()
{
	// Initialization for SMLib
	PluginManager_Initialize("block-spectator-sprinting", "[SM] ");
	
	// Translations
	// LoadTranslations("common.phrases");
	
	
	// Command Hooks (AddCommandListener) (If the command already exists, like the command kill, then hook it!)
	
	
	// Register New Commands (PluginManager_RegConsoleCmd) (If the command doesn't exist, hook it here)
	
	
	// Register Admin Commands (PluginManager_RegAdminCmd)
	
	
	// Cvars: Create a global handle variable.
	g_cvarEnable = PluginManager_CreateConVar("enable", "1", "Enables or disables this plugin");
	
	
	// Hook ConVar Change
	HookConVarChange(g_cvarEnable, ConVarChange_Enable);
	
	
	// Event Hooks
	
	
	// Library
	
	
	/* Features
	if(CanTestFeatures()){
		
	}
	*/
	
	// Create ADT Arrays
	
	
	// Timers
	
	
}

public OnMapStart()
{
	// hax against valvefail (thx psychonic for fix)
	if (GuessSDKVersion() == SOURCE_SDK_EPISODE2VALVE) {
		SetConVarString(Plugin_VersionCvar, Plugin_Version);
	}
}

public OnConfigsExecuted()
{
	// Set your ConVar runtime optimizers here
	g_iPlugin_Enable = GetConVarInt(g_cvarEnable);
	
}

public Action:OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon, &subtype, &cmdnum, &tickcount, &seed, mouse[2]){

	if (g_iPlugin_Enable != 1) {
		return Plugin_Continue;
	}

	if (!Client_IsValid(client)) {
		return Plugin_Continue;
	}

	if (IsPlayerAlive(client)) {
		return Plugin_Continue;
	}

	new team = GetClientTeam(client);

	if (team == TEAM_SPECTATOR) {
		buttons &= ~IN_SPEED;
		return Plugin_Changed;
	}

	return Plugin_Continue;
}


/**************************************************************************************


	C A L L B A C K   F U N C T I O N S


**************************************************************************************/
/**************************************************************************************

	C O N  V A R  C H A N G E

**************************************************************************************/
/* Example Callback Con Var Change*/
public ConVarChange_Enable(Handle:cvar, const String:oldVal[], const String:newVal[])
{
	g_iPlugin_Enable = StringToInt(newVal);
}



/**************************************************************************************

	C O M M A N D S

**************************************************************************************/
/* Example Command Callback
public Action:Command_(client, args)
{
	
	return Plugin_Handled;
}
*/


/**************************************************************************************

	E V E N T S

**************************************************************************************/
/* Example Callback Event
public Action:Event_Example(Handle:event, const String:name[], bool:dontBroadcast)
{

}
*/


/***************************************************************************************


	P L U G I N   F U N C T I O N S


***************************************************************************************/



/***************************************************************************************

	S T O C K

***************************************************************************************/


