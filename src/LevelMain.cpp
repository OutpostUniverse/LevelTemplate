#include <Outpost2DLL/Outpost2DLL.h>	// Main Outpost 2 header to interface with the game
#include <OP2Helper/OP2Helper.h>		// Optional header to make level building easier


// Note: These exports are required by Outpost2.exe from every level
//		 DLL. They give values for the map and tech trees used by the
//		 level and a description to place in the level listbox. The
//		 last export is used to define characteristics of the level.
//		 See RequiredExports.h for more details.
//		 ** Be sure to set these when you build your own level**
// Required data exports  (Description, Map, TechTree, GameType, NumPlayers)
ExportLevelDetails("6P, LoS, '<map name>'", "on6_01.map", "MULTITEK.TXT", MultiLastOneStanding, 6)
// Alternative style:
// Required data exports  (Description, Map, TechTree, GameType, NumPlayers, maxTechLevel, bUnitOnlyMission)
//ExportLevelDetailsEx("6P, LoS, '<map name>'", "on6_01.map", "MULTITEK.TXT", MultiLastOneStanding, 6, 12, false)


// Note: Place any global variables in the following struct so that your
//		level works right when saving and loading.
// Note: Feel free to rename the following struct and variable declaration to whatever you want
// Holder for global script variables (for Saved game files)
struct ScriptGlobal
{
} scriptGlobal;
// This macro automatically generates the GetSaveRegions export which tells Outpost2.exe about
// the scriptGlobal variable. Data in this struct is preserved during game save/load.
// Note: This implies all level data must be statically sized.
ExportSaveLoadData(scriptGlobal);


// Note: The following function is called once by Outpost2.exe when the
//		 level is first initialized. This is where you want to create
//		 all the initial units and structures as well as setup any 
//		 map/level environment settings such as day and night.
// Note: Returns true if level loaded successfully and is playable, false to abort
Export int InitProc()
{
	// **TODO**: Add your own code here.
	return true;	// Level loaded successfully
}


// Note: The following function seems to be intended for use in
//		 controlling an AI. It is called once every game cycle. 
//		 Use it for whatever code needs to run on a continual basis.
// Note: The standard level DLLs released by Sierra leave this function
//		 empty and handle all AI controls through triggers.
Export void AIProc() 
{
}


// Note: This is a trigger callback function. This function is
//		 intentionally left empty and is used as the trigger
//		 callback function for triggers that don't want or need
//		 any special callback function.
// Note: The use of Export is used by all trigger functions
//		 to ensure they are exported correctly.
Export void NoResponseToTrigger()
{
}


