OUTPUT_DLL = OP2Script.dll
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
	$(CPP) /c /Od /MDd /W3 /D "_MBCS" /Fo:$(OUTPUT_DEBUG_DIR)\ $(INCLUDES) $<

{$(INPUT_DIR)\}.cpp{$(OUTPUT_RELEASE_DIR)\}.obj::
	$(CPP) /c /O2 /MD /GL /W3 /D "_MBCS" /Fo:$(OUTPUT_RELEASE_DIR)\ $(INCLUDES) $<

compile_debug: create_dirs $(OUTPUT_DEBUG_DIR)\*.obj

compile_release: create_dirs $(OUTPUT_RELEASE_DIR)\*.obj

$(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL): compile_debug
	link.exe /DLL /BASE:0x11000000 /DEBUG /OUT:$(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL) $(OP2_DLL) $(OUTPUT_DEBUG_DIR)\*.obj

$(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL): compile_release
	link.exe /DLL /BASE:0x11000000 /OUT:$(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL) $(OP2_DLL) $(OUTPUT_RELEASE_DIR)\*.obj

debug: $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL)
	copy $(OUTPUT_DEBUG_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)

release: $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL)
	copy $(OUTPUT_RELEASE_DIR)\$(OUTPUT_DLL) $(GAME_DIR)\$(OUTPUT_DLL)
