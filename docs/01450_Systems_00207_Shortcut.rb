module UI
  # UI component that shows a shortcut item
  class ShortcutElement < SpriteStack
    # Offset Y to prevent UI element to overlap with BaseUI
    OFFSET_Y = 28
    # @return [Integer] Index of the button in the list
    attr_accessor :index
    # Create a new Item sell button
    # @param viewport [Viewport] the viewport in which the SpriteStack will be displayed
    # @param index [Integer] index used to align the element in the UI
    # @param item_id [Integer, Symbol] ID of the item to show
    # @param key [Symbol] the key the player has to press
    def initialize(viewport, index, item_id, key)
    end
    private
    def create_background
    end
    def create_item_name
    end
    def create_quantity
    end
    def create_key
    end
    def create_icon
    end
    def adjust_position(background)
    end
  end
end
module GamePlay
  # Scene responsive of showing the shortcut menu
  class Shortcut < BaseCleanUpdate::FrameBalanced
    include ::Util::Item
    # List of shortcut key by index
    SHORTCUT_KEYS = %i[UP LEFT DOWN RIGHT]
    # List of key => method used by automatic_input_update
    AIU_KEY2METHOD = {B: :action_b, Y: :action_b}
    # Actions on mouse ctrl
    ACTIONS = %i[action_b action_b action_b action_b]
    # Create the shortcut scene
    def initialize
    end
    # Update the inputs of the scene
    def update_inputs
    end
    # Update the mouse interaction
    def update_mouse(moved)
    end
    private
    def action_b
    end
    def use(index)
    end
    def create_graphics
    end
    def create_background
    end
    def create_elements
    end
    # Create the base UI of the slot machine
    def create_base_ui
    end
    # Get the button text for the generic UI
    # @return [Array<String>]
    def button_texts
    end
  end
end
GamePlay.shortcut_class = GamePlay::Shortcut
