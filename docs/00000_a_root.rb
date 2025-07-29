# Class describing the PSDK Config
module ScriptLoader
  # PSDK config info so the game knows what's the context at start
  class PSDKConfig
    # @return [Integer] the window scale
    attr_reader :window_scale
    # @return [Boolean] if the game runs in fullscreen
    attr_reader :running_in_full_screen
    # @return [Boolean] if the game runs in VSYNC
    attr_reader :vsync_enabled
    # @return [Integer] OffsetX of all the viewports
    attr_reader :viewport_offset_x
    # @return [Integer] OffsetY of all the viewports
    attr_reader :viewport_offset_y
    # Tell if the game is in Release mode
    # @return [Boolean]
    def release?
    end
    # Tell if the game is in Debug mode
    # @return [Boolean]
    def debug?
    end
    # Function that choose the best resolution
    # @return [Array<Integer>]
    def choose_best_resolution
    end
    private
    # Function that fix the scale
    def fix_scale
    end
    # Function that fix the fullscreen
    def fix_full_screen
    end
    # Function that fix the vsync param
    def fix_vsync
    end
    # Return the editor resolution
    # @return [Array<Integer>]
    def editors_resolution
    end
    # Tell if the game is running an editor
    def running_editor?
    end
    # Function that tries to find the best resolution in all_res according to native & desired
    # @param native [Array<Integer>] native screen resolution
    # @param desired [Array<Integer>] desired screen resolution
    # @param all_res [Array<Array>] all the compatible resolution
    # @return [Array<Integer>]
    def find_best_matching_resolution(native, desired, all_res)
    end
  end
end
# Constant containing all the PSDK Config
PSDK_CONFIG = ScriptLoader::PSDKConfig.allocate
# Ruby Object class
class Object
  private
  # Is the game in debug ?
  # @return [Boolean]
  def debug?
  end
end
$DEBUG = false
# Module responsive of savely execute piece of code at the end of the whole script loading
module SafeExec
  # Safe constants to evaluate when everything is loaded
  SAFE_CONSTANTS = {}
  # List of safe piece of code to execute
  SAFE_CODE = {}
  module_function
  # Load the safe constants/codes and clear the hash
  def load
  end
end
# Safely define a constant (make its value valid once every scripts got loaded)
# @param name [Symbol] name of the constant in the class where it should be defined
# @param value [Proc] code to execute to give the proper constant value
# @note This is not suited for cyclic redundancy (C::A = D::B; D::B = C::E). The value should never be passed as &block.
#   The final value of the constant can be changed by calling safe_const again.
# @example Defining a constant dependant of a class that is not already loaded :
#   class MyClass
#     MY_CONST = safe_const(:MY_CONST) { DependingOnClass::OTHER_CONST * 3 }
#   end
#   # This prevents uninitialized constant DependingOnClass
def safe_const(name, &value)
end
# Safely execute a piece of code
# @param name [String] Name of the code if it needs to be removed
# @param value [Proc] code to execute
def safe_code(name, &value)
end
# Module responsive of adding the Hook functionality to a class and its childs
#
# How to use it:
#   # 1. Include the Hooks module to your class so exec_hooks become visible (and it's possible to register a hook)
#   include Hooks
#
#   # 2. Make a method that supports hooks
#   def my_method(params)
#     exec_hooks(NameOfTheClass, :name_of_prehook, binding) # Not mandatory
#     # do some stuff
#     exec_hooks(NameOfTheClass, :name_of_posthook, binding) # Not mandatory
#     return normal_return
#   rescue Hooks::ForceReturn => e
#     return e.data # What the hooks forced to return
#   end
#
#   # 3. To register a hook call the function from Hooks
#   Hooks.register(NameOfTheClass, :name_of_the_hook, 'Reason so you can delete it') do |hook_binding|
#     # Do something with self (object that called the hook) and hook_binding current binding
#   end
module Hooks
  # Exception that help managing overwritten return from Hooks
  class ForceReturn < StandardError
    # Data that should be returned
    attr_accessor :data
    # Reason that has forced the return
    attr_accessor :reason
    # Name of the hook that forced the return
    attr_accessor :hook_name
    # Constant value for hooks functionality
    CONST = new('Return forced')
  end
  # Extension adding reason parameter to blocks
  module Reason
    # Get the reason
    # @return [String]
    def reason
    end
    # Set the reason
    # @param reason [String]
    def reason=(reason)
    end
  end
  # Function that execute the hooks
  # @param klass [Class] class containing the hook information
  # @param name [Symbol] name of the hook list
  # @param method_binding [Binding] binding of the method so the hook can modify locals
  # @raise [ForceReturn]
  def exec_hooks(klass, name, method_binding)
  end
  # Function that force the return from the hook
  # @param object [Object] object to return
  def force_return(object)
  end
  class << self
    # Function that register a hook
    # @param klass [Class] class containing the hook information
    # @param name [Symbol] name of the hook list
    # @param reason [String] reason for the hook (so we can remove it)
    # @param block [Proc] actuall hook
    # @yield [hook_binding] hook called when requested
    # @yieldparam hook_binding [Binding] binding from the calling method
    def register(klass, name, reason = nil, &block)
    end
    # Function that removes a hook with a reason
    # @param klass [Class] class containing the hook information
    # @param name [Symbol] name of the hook list
    # @param reason [String] reason for the hook
    def remove(klass, name, reason = 'None')
    end
    # Function that removes a hook with a reason
    # @param klass [Class] class containing the hook information
    # @param reason [String] reason for the hook
    def remove_without_name(klass, reason = 'None')
    end
    # Function called when Hooks is included
    # @param klass [Class] klass receiving the hooks
    def included(klass)
    end
  end
end
# Module responsive of giving access to various configuration contained into Data/configs
#
# @example How to create a basic configuration
#   module Configs
#     class MyConfigDescription
#       # Define attributes etc...
#       def initialize # <= Configs will call this without argument so you can set default value if file does not exist
#       end
#     end
#     # @!method self.my_config_accessor
#     #   @return [MyConfigDescription]
#     register(:my_config_accessor, 'my_config', :json, false, MyConfigDescription)
#   end
module Configs
  @all_registered_configs = {}
  # List of keys from file to ruby world
  KEY_TRANSLATIONS = {isMouseDisabled: :is_mouse_disabled, mouseSkin: :mouse_skin, gameResolution: :game_resolution, windowScale: :window_scale, isFullscreen: :is_fullscreen, isPlayerAlwaysCentered: :is_player_always_centered, tilemapSettings: :tilemap_settings, introMovieMapId: :intro_movie_map_id, bgmName: :bgm_name, bgmDuration: :bgm_duration, isLanguageSelectionEnabled: :language_selection_enabled, additionalSplashes: :additional_splashes, controlWaitTime: :control_wait, maximumSave: :maximum_save_count, saveKey: :save_key, saveHeader: :save_header, baseFilename: :base_filename, isCanSaveOnAnySave: :can_save_on_any_save, projectSplash: :project_splash, lineHeight: :line_height, scrollSpeed: :speed, leaderSpacing: :leader_spacing, chiefProjectTitle: :chief_project_title, chiefProjectName: :chief_project_name, gameCredits: :game_credits, pokemonMaxLevel: :max_level, isAlwaysUseForm0ForEvolution: :always_use_form0_for_evolution, isUseForm0WhenNoEvolutionData: :use_form0_when_no_evolution_data, maxBagItemCount: :max_bag_item_count, isSmoothTexture: :smooth_texture, isVsyncEnabled: :vsync_enabled, gameTitle: :game_title, gameVersion: :game_version, defaultLanguage: :default_language_code, choosableLanguageCode: :choosable_language_code, choosableLanguageTexts: :choosable_language_texts}
  # Name of the file that must exist if we want to successfully load scripts
  SCRIPTS_REQUIRED_CONFIG = 'Data/configs/display_config.json'
  class << self
    # Register a new config
    # @param name [Symbol] name of the config
    # @param filename [String] name of the file inside Data/configs
    # @param type [Symbol] type of the config file: :yml or :json
    # @param preload [Boolean] if the file need to be preloaded
    # @param klass [Class] class describing the config content
    def register(name, filename, type, preload, klass)
    end
    private
    # Function that loads the file data
    # @param name [Symbol] name of the file data to load
    # @return [Object, nil] whatever was loaded or initialized
    def load_file_data(name)
    end
    # Function that cleans the filename for rxdata files
    # @param filename [String]
    # @return [String]
    def clean_filename(filename)
    end
    # Function that load the config data in non-release mode
    # @param info [Hash]
    # @param rxdata_filename [String]
    # @param real_filename [String]
    def load_config_data(info, rxdata_filename, real_filename)
    end
  end
  # Module holding all the project config
  module Project
    # Device configuration
    class Devices
      # Is mouse disabled
      # @return [Boolean]
      attr_accessor :is_mouse_disabled
      # Skin of the mouse
      # @return [String]
      attr_accessor :mouse_skin
    end
    # Display configuration of the project
    class Display
      # Get the game resolution
      # @return [Point]
      attr_reader :game_resolution
      # Get the default window scale
      # @return [Integer]
      attr_accessor :window_scale
      # Is the game running in fullscreen
      # @return [Boolean]
      attr_accessor :is_fullscreen
      # Is the player always centered on the screen
      # @return [Boolean]
      attr_accessor :is_player_always_centered
      # Get the tilemap settings
      # @return [TilemapSettings]
      attr_reader :tilemap_settings
      # Data structure describing a point
      class Point
        # Get the x coodinate
        # @return [Integer]
        attr_reader :x
        # Get the y coordinate
        # @return [Integer]
        attr_reader :y
        def initialize(x, y)
        end
      end
      # Data class describing Tilemap configuration
      class TilemapSettings
        # Get the tilemap class
        # @return [String]
        attr_reader :tilemap_class
        # Get the size of the tilemap
        # @return [Point]
        attr_reader :tilemap_size
        # Get the number of frame autotiles does not animate
        # @return [Integer]
        attr_reader :autotile_idle_frame_count
        # Get the zoom of the tiles as character
        # @return [Float]
        attr_reader :character_tile_zoom
        # Get the zoom of the sprite as character
        # @return [Float]
        attr_reader :character_sprite_zoom
        # Get the center of the screen in sub pixel size
        # @return [Point]
        attr_reader :center
        # Get the map linker offset
        # @return [Point]
        attr_reader :map_linker_offset
        # Tell if the game uses the old map linker settings
        # @return [Boolean]
        attr_reader :uses_old_map_linker
        def initialize(v)
        end
      end
      def game_resolution=(res)
      end
      def tilemap_settings=(v)
      end
    end
    # Option configurations
    class GameOptions
      # Get the order of options
      # @return [Array<Symbol>]
      attr_reader :order
      def order=(v)
      end
      # Set the options of the game
      # @param v [nil]
      def options=(v)
      end
    end
    # Text display configurations
    class Texts
      # Get the font config
      # @return [Font]
      attr_reader :fonts
      # Get the message config
      # @return [Hash<String => MessageConfig>]
      attr_reader :messages
      # Get the choice config
      # @return [Hash<String => ChoiceConfig>]
      attr_reader :choices
      def fonts=(v)
      end
      def messages=(v)
      end
      def choices=(v)
      end
      # Font configuration
      class Font
        # Is the game supporting the pokemon number feature
        # @return [Boolean]
        attr_reader :supports_pokemon_number
        # Get all the ttf files the game uses
        # @return [Array<Hash>]
        attr_reader :ttf_files
        # Get all the alt size the game uses
        # @return [Array<Hash>]
        attr_reader :alt_sizes
        def initialize(v)
        end
      end
      # Configuration of choice box
      class ChoiceConfig
        # Get the window skin
        # @return [String, nil]
        attr_reader :window_skin
        # Get the border spacing
        # @return [Integer]
        attr_reader :border_spacing
        # Get the default font
        # @return [Integer]
        attr_reader :default_font
        # Get the default color
        # @return [Integer]
        attr_reader :default_color
        # Get the color_mapping
        # @return [Hash{ Integer => Integer }]
        attr_reader :color_mapping
        def initialize(v)
        end
      end
      # Configuration of messages boxes
      class MessageConfig < ChoiceConfig
        # Get the window skin of the name box
        # @return [String, nil]
        attr_reader :name_window_skin
        # Get the number of lines the message has
        # @return [Integer]
        attr_reader :line_count
        def initialize(v)
        end
      end
    end
    # Generic settings
    class Settings
      # Get the maximum level
      # @return [Integer]
      attr_accessor :max_level
      # Tell if evolution always uses form 0 to fetch evolution data
      # @return [Boolean]
      attr_accessor :always_use_form0_for_evolution
      # Tell if we use form 0 of current creature when current form has no data
      # @return [Boolean]
      attr_accessor :use_form0_when_no_evolution_data
      # Tell how much quantity of an item can be stored in the bag
      # @return [Integer]
      attr_accessor :max_bag_item_count
    end
    # Graphic configuration of the game
    class Graphic
      # Tell if the textures should be smooth
      # @return [Boolean]
      attr_accessor :smooth_texture
      # Tell if the vsync should be enabled
      # @return [Boolean]
      attr_accessor :vsync_enabled
    end
    # Information about the game
    class Infos
      # Get the game title
      # @return [String]
      attr_accessor :game_title
      # Get the game version
      # @return [Integer]
      attr_accessor :game_version
    end
    # Language configuration
    class Language
      # Give the default language code
      # @return [String]
      attr_accessor :default_language_code
      # Get the list of language user can choose
      # @return [Array<String>]
      attr_accessor :choosable_language_code
      # Get the name of the languages
      # @return [Array<String>]
      attr_accessor :choosable_language_texts
    end
  end
  register(:devices, 'devices_config', :json, false, Project::Devices)
  register(:display, 'display_config', :json, false, Project::Display)
  register(:game_options, 'game_options_config', :json, false, Project::GameOptions)
  register(:texts, 'texts_config', :json, false, Project::Texts)
  register(:settings, 'settings_config', :json, false, Project::Settings)
  register(:graphic, 'graphic_config', :json, false, Project::Graphic)
  register(:infos, 'infos_config', :json, false, Project::Infos)
  register(:language, 'language_config', :json, false, Project::Language)
end
# Namespace that contains modules and classes written by Nuri Yuri
# @author Nuri Yuri
module Yuki
  # Module that allows the game to write and Error.log file if the Exception is not a SystemExit or a Reset
  #
  # Creation date : 2013, update : 26/09/2017
  # @author Nuri Yuri
  module EXC
    # Name of the current Game/Software
    Software = 'Pokémon SDK'
    module_function
    # Method that runs #build_error_log if the Exception is not a SystemExit or a Reset.
    # @overload run(e)
    #   The log is sent to Error.log
    #   @param e [Exception] the exception thrown by Ruby
    # @overload run(e, io)
    #   The log is sent to an io
    #   @param e [Exception] the exception thrown by Ruby
    #   @param io [#<<] the io that receive the log
    def run(e, io = nil)
    end
    # Method that build the error log.
    # @param e [Exception] the exception thrown by Ruby
    # @return [String] the log readable by anybody
    def build_error_log(e)
    end
    # Function that corrects the source path
    # @param source_name [String] the source name path
    # @return [String] the fixed source name
    def fix_source_path(source_name)
    end
    # Sets the script used by the eval command
    # @param script [String, nil] the script used in the eval command
    def set_eval_script(script)
    end
    # Get the eval script used by the current eval command
    # @return [String, nil]
    def get_eval_script
    end
    # Build the SystemStackError message
    # @param e [SystemStackError]
    # @param str
    def build_system_stack_error_log(e, str)
    end
    # Function building the reproduction file
    # @param scene [Battle::Scene]
    def dot_25_battle_reproduction(scene)
    end
    # Function building the reproduction file for the Mining Game
    # @param grid_handler [PFM::MiningGame::GridHandler]
    def mining_game_reproduction(grid_handler)
    end
    # Function that shows the error window
    # @param log [String]
    def show_error_window(log)
    end
  end
  # Show an error window
  class ErrorWindow
    # Open the error window and let the user aknowledge it
    # @param error_text [String] Text stored inside Error.log
    # @param data_to_add [Array<String>] data to add to the error log as pictures
    def run(error_text, *data_to_add)
    end
    private
    # Function that generates the text to show
    # @param error_text [String]
    # @return [Array<String>]
    def cleanup_error_log(error_text)
    end
    # Function that shows the window and wait for the user to do something
    # @param texts_to_show [Array<String>] text to show into the window
    # @param images [Array<Image>]
    def show_window_and_wait(texts_to_show, images)
    end
    # Function that execute the window processing
    # @param texts_to_show [Array<String>] text to show into the window
    # @param images [Array<Image>]
    def show_window_and_wait_internal(texts_to_show, images)
    end
    # Function that updates the ingame graphics
    def update_graphics
    end
    # Function that create the text to show into the window
    # @param window [LiteRGSS::Window]
    # @param texts_to_show [Array<String>]
    def create_text(window, texts_to_show)
    end
    # Function that append the text to show with a message
    # @param input [String]
    # @return [String]
    def append_message(input)
    end
    # Function that displays the images in reverse order starting from bottom right of the screen
    # @param window [LiteRGSS::Window]
    # @param images [Array<Image>]
    # @return [Array<Texture>]
    def create_and_arrange_images(window, images)
    end
  end
end
# Function responsive of reloading the saved battle
def reload_battle
end
# Function responsive of reloading the saved mining game instance
# @return [PFM::MiningGame::GridHandler]
def reload_mining_game
end
