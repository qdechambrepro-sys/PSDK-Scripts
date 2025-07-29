module GamePlay
  # Module defining the IO of the menu scene so user know what to expect
  module MenuMixin
    # Get the process that is executed when a skill is used somewhere
    # @return [Array, Proc]
    attr_accessor :call_skill_process
    # Execute the skill process
    def execute_skill_process
    end
  end
  # Main menu UI
  class Menu < BaseCleanUpdate
    include MenuMixin
    # List of action according to call based on button index
    ACTION_LIST = []
    # List of condition to verify in order to show/activate a button
    CONDITION_LIST = []
    # List of button overwrites
    BUTTON_OVERWRITES = []
    # Entering - leaving animation offset
    ENTERING_ANIMATION_OFFSET = 150
    # Entering - leaving animation duration
    ENTERING_ANIMATION_DURATION = 15
    # Create a new menu
    def initialize
    end
    # Create all the graphics
    def create_graphics
    end
    # End of the scene
    def main_end
    end
    # Update the input interaction
    # @return [Boolean] if no input was detected
    def update_inputs
    end
    # Update the mouse interaction
    # @param moved [Boolean] if the mouse moved
    # @return [Boolean]
    def update_mouse(moved)
    end
    # Update the graphics
    def update_graphics
    end
    # Overload the visible= to allow save to keep the curren background
    # @param value [Boolean]
    def visible=(value)
    end
    def fade_out(*)
    end
    def fade_in(*)
    end
    private
    # Animation played during enter sequence
    def update_entering_animation
    end
    def create_entering_animation
    end
    # Animation played during the quit sequence
    def update_quitting_animation
    end
    def create_quitting_animation
    end
    # Create the conditional array telling which scene is enabled
    def init_conditions
    end
    # Init the image_indexes array
    def init_indexes
    end
    def push_quit_at_the_end
    end
    # Create the background image (blur)
    def create_background
    end
    # Create the menu buttons
    def create_buttons
    end
    # Update the menu button states
    def update_buttons
    end
    # Init the entering animation
    def init_entering
    end
    # Perform the action to do at the current index
    def action
    end
    # Open the Dex UI
    def open_dex
    end
    # Open the Party_Menu UI
    def open_party
    end
    # Open the Bag UI
    def open_bag
    end
    # Open the TCard UI
    def open_tcard
    end
    # Open the Save UI
    def open_save
    end
    # Open the Options UI
    def open_option
    end
    # Quit the scene
    def open_quit
    end
    class << self
      # Register a button in the UI
      # @param action [Symbol] method to call when the button is clicked
      # @param condition [Proc] block called to verify the condition
      def register_button(action, &condition)
      end
      # Register a button overwrite
      # @param index [Integer] index of the button
      # @param block [Proc, nil] proc called to get the overwrite button class to use
      def register_button_overwrite(index, &block)
      end
      # Clear all the thing that was previously registered so you can do it your way
      def clear_previous_registers
      end
    end
    register_button(:open_dex) {$game_switches[Yuki::Sw::Pokedex] }
    register_button(:open_party) {$actors.any? }
    register_button(:open_bag) {!$bag.locked }
    register_button(:open_tcard) {true }
    register_button(:open_option) {true }
    register_button(:open_save) {!$game_system.save_disabled }
    register_button(:open_quit) {true }
    register_button_overwrite(2) {$trainer.playing_girl ? UI::GirlBagMenuButton : nil }
  end
end
GamePlay.menu_mixin = GamePlay::MenuMixin
GamePlay.menu_class = GamePlay::Menu
module UI
  # Button that is shown in the main menu
  class PSDKMenuButtonBase < SpriteStack
    # Basic coordinate of the button on screen
    BASIC_COORDINATE = [192, 16]
    # Offset between each button
    OFFSET_COORDINATE = [0, 24]
    # Offset between selected position and unselected position
    SELECT_POSITION_OFFSET = [-6, 0]
    # Angle variation of the icon in one direction
    ANGLE_VARIATION = 15
    # @return [Boolean] selected
    attr_reader :selected
    # Create a new PSDKMenuButton
    # @param viewport [Viewport]
    # @param real_index [Integer] real index of the button in the menu
    # @param positional_index [Integer] index used to position the button on screen
    def initialize(viewport, real_index, positional_index)
    end
    # Update the button animation
    def update
    end
    # Set the selected state
    # @param value [Boolean]
    def selected=(value)
    end
    private
    # Compute the button x, y coordinate on the screen based on index
    # @param index [Integer]
    # @return [Array<Integer>]
    def coordinates(index)
    end
    def create_sprites
    end
    def create_background
    end
    def create_icon
    end
    # Get the icon index
    # @return [Integer]
    def icon_index
    end
    def create_text
    end
    # Get the text based on the index
    # @return [Integer]
    def text
    end
    def create_animation
    end
  end
  # Button that is shown in the main menu for girl bag
  class GirlBagMenuButton < PSDKMenuButtonBase
    private
    # Get the icon index
    # @return [Integer]
    def icon_index
    end
  end
end
