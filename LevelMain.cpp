#include <Outpost2DLL/Outpost2DLL.h>	// Main Outpost 2 header to interface with the game
#include <OP2Helper/OP2Helper.h>		// Optional header to make level building easier



// Note: These exports are required by Outpost2.exe from every level
//		 DLL. They give values for the map and tech trees used by the
//		 level and a description to place in the level listbox. The
//		 last export is used to define characteristics of the level.
//		 See RequiredExports.h for more details.
//		 ** Be sure to set these when you build your own level**
// Required data exports  (Description, Map, TechTree, GameType, NumPlayers)
ExportLevelDetails("6 Player, LastOne, '<map name>' map", "on6_01.map", "MULTITEK.TXT", MultiLastOneStanding, 6)
// Alternative style:
// Required data exports  (Description, Map, TechTree, GameType, NumPlayers, maxTechLevel, bUnitOnlyMission)
//ExportLevelDetailsEx("6 Player, LastOne, '<map name>' map", "on6_01.map", "MULTITEK.TXT", MultiLastOneStanding, 6, 12, false)



// Note: Place any global variables in the following struct so that your
//		level works right when saving and loading.
// Note: Feel free to rename the following struct and variable declaration to whatever you want
// Holder for global script variables (for Saved game files)
struct ScriptGlobal
{
};
ScriptGlobal scriptGlobal;



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


// Note: Called by Outpost 2 to obtain an area of the DLL's memory that
//		 needs to be saved/loaded to/from Saved Game files.
//		 Either or both values can be safely set to 0.
// Note: Setting bufferStart to 0 means no data (including the buffer size)
//		 is read or written to saved game files. Setting bufferStart to
//		 non-zero, and length to 0, causes the length to be saved and
//		 loaded from saved game files. (Uses extra 4 bytes)
// Note: This system implies all global level data must be statically sized.
//		 It also means the level doesn't know when it's about to be
//		 saved, or when it was just loaded.

Export void __cdecl GetSaveRegions(BufferDesc& bufferDesc)
{
	// Buffer for Saved Game files
	bufferDesc.bufferStart = &scriptGlobal;
	bufferDesc.length = sizeof(scriptGlobal);
}


// Note: This is a trigger callback function. This function is
//		 intentionally left empty and is used as the trigger
//		 callback function for triggers that don't want or need
//		 any special callback function.
// Note: The use of Export is used by all trigger functions
//		 to ensure they are exported correctly. (Although, 
//		 technically it's not needed in this case since this
//		 function has a function prototype defined in 
//		 RequiredExports.h which contains the SCRIPT_API macro
//		 in it. However, most other trigger callback functions
//		 won't have a function prototype anywhere (and you really
//		 don't need to declare a function prototype since you
//		 should never be calling a callback function yourself)
//		 so you should use the SCRIPT_API macro when you define
//		 the function.
//		 Might as well set a good example. =)

Export void NoResponseToTrigger()
{
}


