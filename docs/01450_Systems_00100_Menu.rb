module UI
  # Button that is shown in the main menu
  class PSDKMenuButton < SpriteStack
    # Basic coordinate of the button on screen
    BASIC_COORDINATE = [192, 16]
    # Offset between each button
    OFFSET_COORDINATE = [0, 24]
    # Offset between selected position and unselected position
    SELECT_POSITION_OFFSET = [-6, 0]
    # List of text message to send in order to get the right text
    TEXT_MESSAGES = [[:text_get, 14, 1], [:text_get, 14, 0], [:text_get, 14, 2], [:text_get, 14, 3], [:text_get, 14, 5], [:text_get, 14, 4], [:ext_text, 9000, 26], [:text_get, 14, 2]]
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
  end
end
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
  #
  # Rewritten thanks to Jaizu demand
  class Menu < BaseCleanUpdate::FrameBalanced
    include MenuMixin
    # List of action according to the "image_index" to call
    ACTION_LIST = %i[open_dex open_party open_bag open_tcard open_option open_save open_quit]
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
    private
    # Animation played during enter sequence
    def update_entering_animation
    end
    # Animation played during the quit sequence
    def update_quitting_animation
    end
    # Create the conditional array telling which scene is enabled
    def init_conditions
    end
    # Init the image_indexes array
    def init_indexes
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
  end
end
GamePlay.menu_mixin = GamePlay::MenuMixin
GamePlay.menu_class = GamePlay::Menu
