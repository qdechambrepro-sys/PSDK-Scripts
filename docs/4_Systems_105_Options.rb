module PFM
  # The options data
  #
  # The options are stored in $options and PFM.game_state.options
  # @author Nuri Yuri
  class Options
    # The volume of the BGM and ME
    # @return [Integer]
    attr_reader :music_volume
    # The volume of the BGS and SE
    # @return [Integer]
    attr_reader :sfx_volume
    # The speed of the message display
    # @return [Integer]
    attr_reader :message_speed
    # If the battle ask to switch pokemon or not
    # @return [Boolean]
    attr_accessor :battle_mode
    # If the battle show move animations
    # @return [Boolean]
    attr_accessor :show_animation
    # If the battle ask to rename Pokémon at capture
    # @return [Boolean]
    attr_accessor :catch_rename
    # The lang id of the Studio::Text loads
    # @return [String]
    attr_reader :language
    # The message frame
    # @return [String]
    attr_reader :message_frame
    # The display resolution
    # @return [Integer]
    attr_reader :screen_scale
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create a new Option object with a language
    # @param starting_language [String] the lang id the game will start
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(starting_language, game_state = PFM.game_state)
    end
    # Change the master volume
    # @param value [Integer] the new master volume
    def music_volume=(value)
    end
    # Change the SFX volume
    # @param value [Integer] the new sfx volume
    def sfx_volume=(value)
    end
    # Change both music & sfx volume at the same time
    # @param value [Integer] the new volume
    def master_volume=(value)
    end
    alias master_volume music_volume
    # Change the in game lang (reload the texts)
    # @param value [String] the new lang id
    def language=(value)
    end
    alias set_language language=
    # Change the message speed
    # @param value [Integer] the new message speed
    def message_speed=(value)
    end
    # Change the message frame
    # @param value [String] the new message frame
    def message_frame=(value)
    end
    # Change the display resolution
    # @param value [Integer] the new display resolution
    def screen_scale=(value)
    end
  end
  class GameState
    # The game options
    # @return [PFM::Options]
    attr_accessor :options
    on_player_initialize(:options) {@options = PFM.options_class.new(@starting_language, self) }
    on_expand_global_variables(:options) do
      $options = @options
      @options.game_state = self
    end
  end
end
PFM.options_class = PFM::Options
module UI
  module Options
    # Class that shows the option description
    class Description < SpriteStack
      # Create a new InfoWide
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      private
      def create_sprites
      end
    end
    # Arrow telling which option is selected
    class Arrow < Sprite
      # Create a new arrow
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the arrow animation
      def update
      end
    end
    # Button UI element
    class Button < SpriteStack
      # Offset Y of each options
      OPTION_OFFSET_Y = 40
      # Base X of each options
      OPTION_BASE_X = 19
      # Offset X of each options
      OPTION_OFFSET_X = 4
      # Option modified by the button
      # @return [GamePlay::Options::Helper]
      attr_reader :option
      # Current value shown by the button
      # @return [Option]
      attr_reader :value
      # Create a new Option Button
      # @param viewport [Viewport]
      # @param index [Integer] index of the option in the order
      # @param option [GamePlay::Options::Helper]
      def initialize(viewport, index, option)
      end
      # Return the value index
      # @return [Integer]
      def value_index
      end
      # Set the current value shown by the button
      # @param new_value [Object]
      def value=(new_value)
      end
      # Retreive the option value text
      # @return [String]
      def value_text
      end
      # Reload the name of the button for when the language is changed in the options
      def reload_texts
      end
    end
  end
  # Class that allow to see the KeyBinding for the PSDK virtual key
  #
  # This object has two indexes :
  #   - main_index : It's the index of the PSDK Key we want to see
  #   - key_index : It's the index of the Binding we want to change
  #       if key_index is negative, it's not showing the index sprite
  #
  # This object has a blink state linked to #update_blink allowing to tell the key is currently being edited
  class KeyBindingViewer < SpriteStack
    # X position of the first text
    FT_X = 12
    # X position of the second text
    ST_X = 72
    # X position of the last text & the first button
    LT_X = 208
    # Y position of the first key text
    FKT_Y = 26
    # @return [Boolean] if the UI is in blinking mode
    attr_reader :blinking
    # @return [Integer] the main index
    attr_reader :main_index
    # @return [Integer] the key index
    attr_reader :key_index
    # Create a new KeyBindingViewer
    def initialize(viewport)
    end
    # List of the Key to create with their information (PSDK name, Descr)
    KEYS = [[:A, 4, 13], [:B, 5, 14], [:X, 6, 15], [:Y, 7, 16], [:UP, 8, 17], [:DOWN, 9, 18], [:RIGHT, 10, 19], [:LEFT, 11, 20]]
    # Update the blink animation
    def update_blink
    end
    # Update all the buttons
    def update
    end
    # Set the blinking state
    # @param value [Boolean] the new blinking state
    def blinking=(value)
    end
    # Set the new main index value
    # @param value [Integer]
    def main_index=(value)
    end
    # Set the new key index value
    # @param value [Integer]
    def key_index=(value)
    end
    # Get the current key (to update the Input::Keys)
    # @return [Symbol]
    def current_key
    end
    # Get the current key index according to the button
    def current_key_index
    end
    private
    def create_sprites
    end
    # Create the top line
    def create_top_line
    end
    # Create all the key texts & button
    def create_keys
    end
    # Create a single key line
    # @param index [Integer] Index of the key in the array
    # @param name [Symbol] name of the key in Input
    # @param psdk_text_id [Integer] id of the text telling the name of the key
    # @param descr_text_id [Integer] id of the text telling what the key does
    def create_key(index, name, psdk_text_id, descr_text_id)
    end
  end
end
module GamePlay
  # Mixin allowing people to know what's the output of the Option scene
  module OptionsMixin
    # List of options that were modifies
    # @return [Array<Symbol>]
    attr_reader :modified_options
  end
  class Options < BaseCleanUpdate::FrameBalanced
    # List of valid option type
    VALID_OPTION_TYPE = %i[choice slider]
    # How to get message frames
    MESSAGE_FRAME = 'GameData::Windows::MESSAGE_FRAME'
    # How to get message frame names
    MESSAGE_FRAME_NAMES = 'GameData::Windows::MESSAGE_FRAME_NAMES'
    # All the pre-defined options
    PREDEFINED_OPTIONS = {message_speed: [:message_speed, :choice, [1, 2, 3], [[:text_get, 42, 4], [:text_get, 42, 5], [:text_get, 42, 6]], [:text_get, 42, 3], [:text_get, 42, 7], :message_speed], message_frame: [:message_frame, :choice, MESSAGE_FRAME, MESSAGE_FRAME_NAMES, [:ext_text, 9000, 165], [:ext_text, 9000, 166], :message_frame], volume: [:volume, :slider, {min: 0, max: 100, increment: 1}, '%d%%', [:ext_text, 9000, 29], [:ext_text, 9000, 30], :master_volume], battle_animation: [:battle_animation, :choice, [true, false], [[:text_get, 42, 9], [:text_get, 42, 10]], [:text_get, 42, 8], [:text_get, 42, 11], :show_animation], battle_style: [:battle_style, :choice, [true, false], [[:text_get, 42, 13], [:text_get, 42, 14]], [:text_get, 42, 12], [:text_get, 42, 15], :battle_mode], screen_scale: [:screen_scale, :choice, [1, 2, 3, 4], [[:ext_text, 9008, 2], [:ext_text, 9008, 3], [:ext_text, 9008, 4], [:ext_text, 9008, 5]], [:ext_text, 9008, 1], [:ext_text, 9008, 0], :screen_scale], language: [:language, :choice, 'Configs#language#choosable_language_code', 'Configs#language#choosable_language_texts', [:ext_text, 9000, 167], [:ext_text, 9000, 168], :language]}
    private
    # Add an option to the option stack
    # @param name [Symbol] name used in order to "sort" the options
    # @param type [Symbol] type of option (:choice, :slider)
    # @param options_info [Array, Hash, String] info telling the option system what value to take
    # @param options_text [Array, String] texts or getter used to show the values
    # @param option_name [Array, String] GamePlay::Base#get_text argument for the option name
    # @param option_descr [Array, String] GamePlay::Base#get_text argument for the option description
    # @param attribute [Symbol] attribute used inside $options
    # @note If the parameter name is not inside Configs.game_options.order this option will not be shown
    def add_option(name, type, options_info, options_text, option_name, option_descr, attribute)
    end
    # Parser allowing to retrieve the right value
    # @param str [String]
    def parse_string(str)
    end
    # Option helper allowing to work with a specific option (get next value, set it etc...)
    class Helper
      # Option type
      # @return [Symbol]
      attr_reader :type
      # Option values
      # @return [Array]
      attr_reader :values
      # Option value text(s)
      # @return [Array<String>, String]
      attr_accessor :values_text
      # Option name
      # @return [String]
      attr_accessor :name
      # Option description
      # @return [String]
      attr_accessor :description
      # Option getter (on $options)
      # @return [Symbol]
      attr_reader :getter
      # Option setter (on $options)
      # @return [Symbol]
      attr_reader :setter
      # Create a new option
      # @param args [Array] options arguments
      def initialize(*args)
      end
      # Retreive the current value
      # @return [Object]
      def current_value
      end
      # Retreive the next value
      # @return [Object]
      def next_value
      end
      # Retreive the prev value
      # @return [Object]
      def prev_value
      end
      # Update the option value
      # @param new_value [Object]
      def update_value(new_value)
      end
    end
    public
    include OptionsMixin
    # List of action the mouse can perform with ctrl button
    ACTIONS = %i[save_options save_options save_options save_options]
    # Maximum number of button shown in the UI for options (used to calculate arrow position)
    MAX_BUTTON_SHOWN = 4
    # Create a new Options scene
    def initialize
    end
    # Update the options input
    def update_inputs
    end
    # Update the mouse interactions
    # @param moved [Boolean] if the mouse moved durring the frame
    # @return [Boolean] if the thing after can update
    def update_mouse(moved)
    end
    # Update the options graphics
    def update_graphics
    end
    private
    def load_options
    end
    def create_graphics
    end
    def create_viewport
    end
    def create_base_ui
    end
    # Get the button text for the generic UI
    # @return [Array<String>]
    def button_texts
    end
    def create_description
    end
    def create_buttons
    end
    def create_frame
    end
    def update_list
    end
    # Function that try to update the option value
    # @return [Boolean]
    def update_input_option_value
    end
    # Reload the texts of the UI dynamically when the language is changed
    def reload_texts
    end
    # Method that save the options and quit the scene
    # @return [false]
    def save_options
    end
    # Return the current option
    # @return [GamePlay::Options::Helper]
    def current_option
    end
  end
  # Class that show the KeyBinding UI and allow to change it
  class KeyBinding < BaseCleanUpdate::FrameBalanced
    # List of keys use by the 3 modes
    KEYS = [%i[A RIGHT DOWN B]] * 3
    # List of mouse action in navigation mode
    MOUSE_ACTION_NAV = %i[action_a_nav action_a_nav action_down_nav action_b_nav]
    # List of mouse action in selection mode
    MOUSE_ACTION_SEL = %i[action_a_sel action_right_sel action_down_sel action_b_sel]
    # List of mouse action in blink mode
    MOUSE_ACTION_BLK = %i[action_b_blink action_b_blink action_b_blink action_b_blink]
    # List of keys to check when trying to overwrite an input
    KEYS_TO_CHECK = %i[A B X Y UP DOWN RIGHT LEFT]
    # Create a new KeyBinding UI
    def initialize
    end
    # Create the grahics of the KeyBinding scene
    def create_graphics
    end
    # Update the graphics
    def update_graphics
    end
    # Update the inputs
    def update_inputs
    end
    # Update the mouse
    # @param _moved [Boolean] if the mouse moved
    def update_mouse(_moved)
    end
    private
    # Update the inputs during the naviation
    def update_navigation_input
    end
    # When the player presses A in navigation mode
    def action_a_nav
    end
    # When the player presses DOWN in navigation mode
    def action_down_nav
    end
    # When the player presses B in navigation mode
    def action_b_nav
    end
    # Update the key selection
    def update_key_selection
    end
    # When the player presses A in selection mode
    def action_a_sel
    end
    # When the player presses RIGHT in selection mode
    def action_right_sel
    end
    # When the player presses DOWN in selection mode
    def action_down_sel
    end
    # When the player presses B in selection mode
    def action_b_sel
    end
    # Update the key detection during the UI blinking
    def update_key_binding
    end
    # When the player presses "B" in blink mode
    def action_b_blink
    end
    # Validate the key change
    # @param key_value [Integer] the value of the key in Keyboard
    def validate_key(key_value)
    end
    # Check if the key is already assigned to another option
    # @param key_value [Integer] the value of the key in Keyboard
    def find_already_assigned_key(key_value)
    end
    # Create the base ui
    def create_base_ui
    end
    # Create the overlay sprite
    def create_overlay
    end
    # Create the UI
    def create_ui
    end
    # Get the button text for the generic UI
    # @return [Array<Array<String>>]
    def button_texts
    end
    public
    class << self
      # Load the Inputs
      def load_inputs
      end
      # Perform the internal operation of loading the inputs
      def load_inputs_internal
      end
      # Test if the axis from JSON data is valid
      def is_axis_valid?(data, axis_attr)
      end
      # Normalize the Input::Keys contents in order to have a correct display in the UI
      def normalize_inputs
      end
      # Save the inputs in the right file
      def save_inputs
      end
      # Return the filename with path of the inputs.yml file
      def input_filename
      end
    end
    Graphics.on_start {load_inputs }
  end
end
GamePlay.options_mixin = GamePlay::OptionsMixin
GamePlay.options_class = GamePlay::Options
