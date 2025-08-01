ScriptLoader.load_tool('PARGV')
PARGV.parse
ScriptLoader.load_tool('Studio/Main') if PARGV.game_launched_by_studio?
ScriptLoader.load_tool('GameLoader/1_setupConstantAndLoadPath')
ScriptLoader.load_tool('GameLoader/2_displayException')
if File.exist?(File.join(PSDK_LIB_PATH, 'ruby-lib'))
  ScriptLoader.load_tool('GameLoader/3_load_ruby_lib')
end
ScriptLoader.load_tool('GameLoader/3_load_extensions')
ScriptLoader.load_tool('GameLoader/31_ruby_dependencies')
ScriptLoader.load_tool('GameLoader/32_console_uncompiled')
ScriptLoader.load_tool('GameLoader/40_load_data_uncompiled')
ScriptLoader.load_tool('GameLoader/z_eval_killer')
if PARGV.game_launched_by_studio?
  Studio.start
else
  ScriptLoader.load_tool('GameLoader/50_load_game_uncompiled')
end
