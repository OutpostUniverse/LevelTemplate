# OP2 Blank Level Template - With Comments

## Requirements

* Windows (probably Windows 10).... Linux coming soon?
* [Build Tools for Visual Studio 2017](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017) - 2015 or a full Visual Studio install should work as well. For details checkout the [Using a different version of Build Tools for Visual Studio](#using-a-different-version-of-build-tools-for-visual-studio) section.
* [VS Code](https://code.visualstudio.com)
* [C/C++ VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)

## File Structure

The default checkout expects the following file structure. If you do not have this, you will need to modify all of the `.json` files in `.vscode` as well as the `Makefile`.

```
    <root> /
        Game / - Outpost 2 game install - https://svn.outpostuniverse.org:8443/!/#outpost2/view/head/GameDownload/Outpost2/trunk
            ...
            Outpost.exe
        API /
            OP2Helper / - https://github.com/OutpostUniverse/OP2Helper.git
            Outpost2DLL / - https://github.com/OutpostUniverse/Outpost2DLL.git
            ... Other API libraries ...
        Levels /
            LevelTemplate-Blank-Comments / - https://github.com/OutpostUniverse/LevelTemplate-Blank-Comments.git

```

## Usage

To get started, choose `File -> Open Folder...` and select `LevelTemplate-Blank-Comments`.

### Compiling Code

All of the code compiling is done via [NMAKE](https://docs.microsoft.com/en-us/cpp/build/nmake-reference?view=vs-2017) via [VS Code Tasks](https://code.visualstudio.com/docs/editor/tasks). Each task can be executed via the "Tasks: Run Task" command from the Command Palette (`CTRL+SHIFT+P`).

* Build Release - Builds the release version of your level `.dll`. Automatically deploys it to your OP2 game directory.

* Build Debug - Builds the debug version of you level `.dll` with debugging support. Automatically deploys it to your OP2 game directory.

* Clean - Deletes all of your built files from the project folder.

#### `tasks.json` and `Makefile`

The above tasks can be mapped directly to the `tasks.json` file in your `.vscode` folder. As you see in that file, each of them just initializes VS Build Tools and then runs a `nmake` task.

The `Makefile` in your project folder configures you `nmake` tasks. Some useful bits you may want to edit:

    OUTPUT_DLL = OP2Script.dll

The file name of your outpost DLL

    OUTPUT_BASE_DIR = build
    OUTPUT_DEBUG_DIR = $(OUTPUT_BASE_DIR)\debug
    OUTPUT_RELEASE_DIR = $(OUTPUT_BASE_DIR)\release

Path to your output directories

    INPUT_DIR = src

Input directory where all of your `.cpp` files live. `.cpp` files cannot be nested in folders.

The file name of your

    API_DIR = ..\..\API

Path to include that has all of your OP2 SDK code.

    GAME_DIR = ..\..\Game

Path to your OP2 game install.

    OP2_DLL = $(API_DIR)\Outpost2DLL\Lib\Outpost2DLL.lib

Path your `Outpost2DLL.lib` file.

    INCLUDES = \
    	/I include \
    	/I $(API_DIR) \

Paths to add your compile command to include. Should include your API directory as well as any additional directories with `.h` files you need to compile your source files.

    debug: $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL)
    	# Comment out below line to not copy DLL to Game directory
    	copy $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)

    release: $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL)
    	# Comment out below line to not copy DLL to Game directory
    	copy $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)

If you do not want to copy you built `.dll` to your game directory, copy out these lines.

#### Changing your VS Code IntelliSense include directories

If you change your `API_DIR` inside of your `Makefile`, you will likely need to change the paths VS Code uses to find code. To change that, open `.vscode/c_cpp_properties.json` and change the following value:

    "includePath": [
        "${workspaceFolder}/../../API/**",
        "${workspaceFolder}/../../**"
    ],

#### Using a different version of Build Tools for Visual Studio

If you already have Visual Studio installed or you have Build Tools for Visual Studio 2015 installed, you do not need to go about installing the 2017 version. To point your project to the version you have, you are going to want to open up your `.vscode/c_cpp_properties.json` file and change the following lines.

    // C++ Standard to use for IntelliSense
    "cppStandard": "c++17",

    // version of your Windows SDK for VS Code to use for IntelliSense and such
    // see https://en.wikipedia.org/wiki/Microsoft_Windows_SDK
    "windowsSdkVersion": "10.0.17134.0",

    // path to your cl.exe
    "compilerPath": "C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Tools/MSVC/14.15.26726/bin/Hostx64/x64/cl.exe",

You will also want to change the following line in your `.vscode/tasks.json` file as well. Set it to the path to your `vcvarsall.bat`.

    "vcvars": "\"C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\VC\\Auxiliary\\Build\\vcvarsall.bat\" x86",

### Launching OP2 / Debugging

The launch configuration to start OP2 with debugging support is already pre-configured. This is controlled by the `.vscode/launch.json` file. To start debugging just press `F5`. It will automatically compile your level DLL, deploy it to the game directory and start OP2 with debugging for your level DLL enabled.
