OUTPUT_NAME = OP2Script
OUTPUT_DLL = $(OUTPUT_NAME).dll
OUTPUT_BASE_DIR = build
OUTPUT_DEBUG_DIR = $(OUTPUT_BASE_DIR)\debug
OUTPUT_RELEASE_DIR = $(OUTPUT_BASE_DIR)\release
INPUT_DIR = src

API_DIR = ..\..\API
GAME_DIR = ..\..\Game
OP2_DLL = $(API_DIR)\Outpost2DLL\Lib\Outpost2DLL.lib

INCLUDES = \
	/I include \
	/I $(API_DIR) \

create_dirs:
	@if not exist $(OUTPUT_BASE_DIR) mkdir $(OUTPUT_BASE_DIR)
	@if not exist $(OUTPUT_DEBUG_DIR) mkdir $(OUTPUT_DEBUG_DIR)
	@if not exist $(OUTPUT_RELEASE_DIR) mkdir $(OUTPUT_RELEASE_DIR)

clean:
	@if exist $(OUTPUT_RELEASE_DIR) rmdir /S /Q $(OUTPUT_RELEASE_DIR)
	@if exist $(OUTPUT_DEBUG_DIR) rmdir /S /Q $(OUTPUT_DEBUG_DIR)
	@if exist $(OUTPUT_BASE_DIR) rmdir /S /Q $(OUTPUT_BASE_DIR)

{$(INPUT_DIR)\}.cpp{$(OUTPUT_DEBUG_DIR)\}.obj::
	$(CPP) /c $< /JMC /GS /analyze- /W3 /Zc:wchar_t $(INCLUDES) /ZI /Gm- /Od /Fd$(OUTPUT_DEBUG_DIR)\vc141.pdb /Zc:inline /fp:precise /D "_WINDLL" /D "_MBCS" /errorReport:prompt /WX- /Zc:forScope /RTC1 /Gd /Oy- /MTd /FC /EHsc /nologo /Fo$(OUTPUT_DEBUG_DIR)\ /Fp$(OUTPUT_DEBUG_DIR)\$(OUTPUT_NAME).pch /diagnostics:classic

{$(INPUT_DIR)\}.cpp{$(OUTPUT_RELEASE_DIR)\}.obj::
	$(CPP) /c $< /GS /analyze- /W3 /Gy /Zc:wchar_t $(INCLUDES) /Zi /Gm- /O2 /Fd$(OUTPUT_RELEASE_DIR)\vc141.pdb /Zc:inline /fp:precise /D "_WINDLL" /D "_MBCS" /errorReport:prompt /WX- /Zc:forScope /Gd /Oy- /Oi /MT /FC /EHsc /nologo /Fo$(OUTPUT_RELEASE_DIR)\ /Fp$(OUTPUT_RELEASE_DIR)\$(OUTPUT_NAME).pch /diagnostics:classic

compile_debug: create_dirs $(OUTPUT_DEBUG_DIR)\*.obj

compile_release: create_dirs $(OUTPUT_RELEASE_DIR)\*.obj

$(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL): compile_debug
	link.exe $(OUTPUT_DEBUG_DIR)\*.obj /OUT:$(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL) /NXCOMPAT /PDB:$(OUTPUT_DEBUG_DIR)\$(OUTPUT_NAME).pdb /DYNAMICBASE:NO "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" $(OP2_DLL) /IMPLIB:$(OUTPUT_DEBUG_DIR)\$(OUTPUT_NAME).lib /DEBUG /DLL /BASE:"0x11000000" /MACHINE:X86 /SAFESEH:NO /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /ManifestFile:$(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL).intermediate.manifest /ERRORREPORT:PROMPT /NOLOGO /TLBID:1

$(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL): compile_release
	link.exe $(OUTPUT_RELEASE_DIR)\*.obj /OUT:$(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL) /NXCOMPAT /DYNAMICBASE:NO "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" $(OP2_DLL) /IMPLIB:$(OUTPUT_RELEASE_DIR)\$(OUTPUT_NAME).lib /DLL /BASE:"0x11000000" /MACHINE:X86 /SAFESEH:NO /OPT:REF /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /ManifestFile:$(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL).intermediate.manifest /OPT:ICF /ERRORREPORT:PROMPT /NOLOGO /TLBID:1

debug: $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL)
	copy $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)

release: $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL)
	copy $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)
