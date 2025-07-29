# Module that contain helpers for various scripts
module Util
  # Item Helper
  # @author Nuri Yuri
  module Item
    # Use an item in a GamePlay::Base child class
    # @param item_id [Integer] ID of the item in the database
    # @return [PFM::ItemDescriptor::Wrapper, false] item descriptor wrapper if the item could be used
    def util_item_useitem(item_id, &result_process)
    end
    # Part where the extend_data request to open the party
    # @param extend_data [PFM::ItemDescriptor::Wrapper]
    # @param result_process [Proc, nil]
    # @return [PFM::ItemDescriptor::Wrapper, false]
    def util_item_open_party_sequence(extend_data, result_process)
    end
    # Part where the extend_data request to use the item
    # @param extend_data [PFM::ItemDescriptor::Wrapper]
    # @param result_process [Proc, nil]
    # @return [PFM::ItemDescriptor::Wrapper, false]
    def util_item_on_use_sequence(extend_data, result_process)
    end
  end
end
module PFM
  # InGame Bag management
  #
  # The global Bag object is stored in $bag and PFM.game_state.bag
  # @author Nuri Yuri
  class Bag
    # Last socket used in the bag
    # @return [Integer]
    attr_accessor :last_socket
    # Last index in the socket
    # @return [Integer]
    attr_accessor :last_index
    # If the bag is locked (and react as being empty)
    # @return [Boolean]
    attr_accessor :locked
    # Set the last battle item
    # @return [Symbol]
    attr_accessor :last_battle_item_db_symbol
    # Set the last ball used
    # @return [Symbol]
    attr_accessor :last_ball_used_db_symbol
    # Tell if the bag is alpha sorted
    # @return [Boolean]
    attr_accessor :alpha_sorted
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Number of shortcut
    SHORTCUT_AMOUNT = 4
    # Create a new Bag
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Convert bag to .26 format
    def convert_to_dot26
    end
    # If the bag contain a specific item
    # @param db_symbol [Symbol] db_symbol of the item
    # @return [Boolean]
    def contain_item?(db_symbol)
    end
    alias has_item? contain_item?
    # Tell if the bag is empty
    # @return [Boolean]
    def empty?
    end
    # The quantity of an item in the bag
    # @param db_symbol [Symbol] db_symbol of the item
    # @return [Integer]
    def item_quantity(db_symbol)
    end
    # Add items in the bag and trigger the right quest objective
    # @param db_symbol [Symbol] db_symbol of the item
    # @param nb [Integer] number of item to add
    def add_item(db_symbol, nb = 1)
    end
    alias store_item add_item
    # Remove items from the bag
    # @param db_symbol [Symbol] db_symbol of the item
    # @param nb [Integer] number of item to remove
    def remove_item(db_symbol, nb = 999)
    end
    alias drop_item remove_item
    # Get the order of items in a socket
    # @param socket [Integer, Symbol] ID of the socket
    # @return [Array]
    def get_order(socket)
    end
    # Reset the order of items in a socket
    # @param socket [Integer] ID of the socket
    # @return [Array] the new order
    def reset_order(socket)
    end
    alias sort_ids reset_order
    # Sort the item of a socket by their names
    # @param socket [Integer] ID of the socket
    # @param reverse [Boolean] if we want to sort reverse
    def sort_alpha(socket, reverse = false)
    end
    # Get the shortcuts
    # @return [Array<Symbol>]
    def shortcuts
    end
    alias get_shortcuts shortcuts
    # Get the last battle item
    # @return [Studio::Item]
    def last_battle_item
    end
    private
    # Make sure the item is in the order, if not add it
    # @param db_symbol [Symbol] db_symbol of the item
    def add_item_to_order(db_symbol)
    end
    # Make sure the item is not in the order anymore
    # @param db_symbol [Symbol] db_symbol of the item
    def remove_item_from_order(db_symbol)
    end
  end
  class GameState
    # The bag of the player
    # @return [PFM::Bag]
    attr_accessor :bag
    on_initialize(:bag) {@bag = PFM.bag_class.new(self) }
    on_expand_global_variables(:bag) do
      $bag = @bag
      $bag.game_state = self
      $bag.convert_to_dot26 if trainer.current_version < 6659
    end
  end
end
PFM.bag_class = PFM::Bag
module UI
  # Module containing all the bag related UI
  module Bag
    # Utility showing the pocket list
    class PocketList < SpriteStack
      # @return [Integer] index of the current selected pocket
      attr_reader :index
      # Base coordinate of the active items
      ACTIVE_BASE_COORDINATES = [0, 192]
      # Base coordinate of the inactive items
      INACTIVE_BASE_COORDINATES = [0, 198]
      # Offset between each sprites
      OFFSET_X = 20
      # Array translating real pocket id to sprite piece
      POCKET_TRANSLATION = [0, 0, 1, 3, 5, 4, 2, 6, 7]
      # Name of the active image
      ACTIVE_IMAGE = 'bag/pockets_active'
      # Name of the inactive image
      INACTIVE_IMAGE = 'bag/pockets_inactive'
      # Create a new pocket list
      # @param viewport [Viewport]
      # @param pocket_indexes [Array<Integer>] each shown pocket by the UI
      def initialize(viewport, pocket_indexes)
      end
      # Set the index of the current selected pocket
      # @param index [Integer]
      def index=(index)
      end
      private
      # @param pocket_indexes [Array<Integer>] each shown pocket by the UI
      def create_sprites(pocket_indexes)
      end
      # Add a pocket sprite
      # @param pocket_id [Integer] real ID of the pocket
      # @return [Sprite]
      def add_pocket_sprite(pocket_id)
      end
    end
    # UI element showing the name of the Pocket in the bag
    class WinPocket < SpriteStack
      # Name of the background file
      BACKGROUND = 'bag/win_pocket'
      # Coordinate of the spritestack
      COORDINATES = 15, 4
      # Create a new WinPocket
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the text to show
      # @param text [String] the text to show
      def text=(text)
      end
      private
      def init_sprite
      end
      # Create the background sprite
      def create_background
      end
      # Create the text
      # @return [Text]
      def create_text
      end
    end
    # Scrollbar UI element for the bag
    class ScrollBar < SpriteStack
      # @return [Integer] current index of the scrollbar
      attr_reader :index
      # @return [Integer] number of possible indexes
      attr_reader :max_index
      # Number of pixel the scrollbar use to move the button
      HEIGHT = 160
      # Base Y for the scrollbar
      BASE_Y = 36
      # BASE X for the scrollbar
      BASE_X = 309
      # Background of the scrollbar
      BACKGROUND = 'bag/scroll'
      # Image of the button
      BUTTON = 'bag/button_scroll'
      # Create a new scrollbar
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the current index of the scrollbar
      # @param value [Integer] the new index
      def index=(value)
      end
      # Set the number of possible index
      # @param value [Integer] the new max index
      def max_index=(value)
      end
      private
      def init_sprite
      end
      # Create the background
      def create_background
      end
      # Create the button
      # @return [Sprite]
      def create_button
      end
    end
    # Class that show the bag sprite in the Bag UI
    class BagSprite < SpriteSheet
      # @return [Integer] the current socket index
      attr_reader :index
      # Array translating real pocket id to sprite piece
      POCKET_TRANSLATION = [0, 0, 1, 3, 5, 4, 2, 6, 7]
      # Coordinates of the bag
      COORDINATES = [71, 103]
      # Create a new Bah Sprite
      # @param viewport [Viewport]
      # @param pocket_indexes [Array<Integer>] each shown pocket by the UI
      def initialize(viewport, pocket_indexes)
      end
      # Set the current socket index
      def index=(value)
      end
      # Start the animation between socket
      def animate(target_index)
      end
      # Update the animation
      def update
      end
      # Test if the animation is done
      # @return [Boolean]
      def done?
      end
      # Test if the animation is at the middle of its progression
      # @return [Boolean]
      def mid?
      end
      private
      def init_sprite
      end
      # Return the bag filename
      # @return [String]
      def bag_filename
      end
    end
    # List of button showing the item name
    class ButtonList < Array
      # Number of button in the list
      AMOUNT = 9
      # Offset between each button
      BUTTON_OFFSET = 25
      # Offset between active button & inative button
      ACTIVE_OFFSET = -8
      # Base X coordinate
      BASE_X = 191
      # Base Y coordinate
      BASE_Y = 18
      # @return [Integer] index of the current active item
      attr_reader :index
      # Create a new ButtonList
      def initialize(viewport)
      end
      # Update the animation
      def update
      end
      # Test if the animation is done
      # @return [Boolean]
      def done?
      end
      # Set the current active item index
      # @param index [Integer]
      def index=(index)
      end
      # Move all the button up
      def move_up
      end
      # Move all the button down
      def move_down
      end
      # Set the item list
      # @param list [Array<Integer>]
      def item_list=(list)
      end
      # Return the delta index with mouse position
      # @return [Integer]
      def mouse_delta_index
      end
      private
      # Move up animation
      def move_up_animation
      end
      # Move down animation
      def move_down_animation
      end
      # Update the button texts
      def update_button_texts
      end
      # Get the button name
      # @param index [Integer]
      # @return [String, nil]
      def button_name(index)
      end
      # Return the start index of the list
      # @return [Integer]
      def start_index
      end
      # Button showing the item name
      class ItemButton < SpriteStack
        # Name of the button background
        BACKGROUND = 'bag/button_list'
        # @return [Integer] Index of the button in the list
        attr_accessor :index
        # Create a new Item button
        # @param viewport [Viewport]
        # @param index [Integer]
        def initialize(viewport, index)
        end
        # Is the button active
        def active?
        end
        # Set the button text
        # @param text [String, nil] the item name
        def text=(text)
        end
        # Reset the button coordinate
        def reset
        end
        private
        # Create the background of the button
        def create_background
        end
        # Create the text
        # @return [Text]
        def create_text
        end
      end
    end
    # Arrow telling which item is selected
    class Arrow < Sprite
      # Create a new arrow
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the arrow animation
      def update
      end
      private
      # Initialize the sprite
      def init_sprite
      end
      # Return the coordinate of the sprite
      # @return [Array<Integer>]
      def coordinates
      end
      # Return the name of the sprite
      # @return [String]
      def image_name
      end
    end
    # Class that shows the minimal item info
    class InfoCompact < SpriteStack
      # Mode of the bag
      # @return [Symbol]
      attr_reader :mode
      # Coordinate of the UI
      COORDINATES = 9, 145
      # Create a new InfoCompact
      # @param viewport [Viewport]
      # @param mode [Symbol] mode of the bag scene
      def initialize(viewport, mode)
      end
      # Change the item it shows
      # @param id [Integer] ID of the item to show
      def show_item(id)
      end
      private
      def init_sprite
      end
      def create_background
      end
      # @return [ItemSprite]
      def create_icon
      end
      # @return [Sprite]
      def create_cross
      end
      # @return [Text]
      def create_quantity_text
      end
      # @return [Text]
      def create_name_text
      end
      # @return [Text, nil]
      def create_price_text
      end
    end
    # Class that shows the full item info (descr)
    class InfoWide < SpriteStack
      # Mode of the bag
      # @return [Symbol]
      attr_reader :mode
      # Coordinate of the UI
      COORDINATES = 0, 33
      # Create a new InfoWide
      # @param viewport [Viewport]
      # @param mode [Symbol] mode of the bag scene
      def initialize(viewport, mode)
      end
      # Change the item it shows
      # @param id [Integer] ID of the item to show
      def show_item(id)
      end
      private
      def init_sprite
      end
      def create_background
      end
      # @return [ItemSprite]
      def create_icon
      end
      # @return [Sprite]
      def create_cross
      end
      # @return [Text]
      def create_quantity_text
      end
      # @return [Sprite]
      def create_favorite_icon
      end
      # @return [Text]
      def create_name_text
      end
      # @return [Text]
      def create_descr_text
      end
    end
    # Class that shows a search bar
    class SearchBar < SpriteStack
      # Coordinate of the search bar
      COORDINATES = 3, 220
      # @return [UI::UserInput] the search input object
      attr_reader :search_input
      # Create a new SearchBar
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the search bar
      def update
      end
      private
      def init_sprite
      end
      def create_background
      end
      # @return [UserInput]
      def create_user_input
      end
      # @return [KeyShortcut]
      def create_shortcut_image
      end
    end
  end
end
module GamePlay
  # Module defining the IO of the bag scene so user know what to expect
  #
  # This mixin should also be used to check if the bag scene is right:
  # @example
  #   Check the current scene is the bag
  #     GamePlay.current_scene.is_a?(GamePlay.bag_mixin)
  module BagMixin
    # ID of the item selected
    # @return [Symbol, Integer]
    attr_accessor :return_data
    # Wrapper of the choosen item in battle
    # @return [PFM::ItemDescriptor::Wrapper, nil]
    attr_accessor :battle_item_wrapper
    # Get the mode in which the bag was started
    # @return [Symbol]
    attr_reader :mode
    # Get the selected item db_symbol
    # @return [Symbol]
    def selected_item_db_symbol
    end
  end
  # Scene responsive of displaying the bag
  #
  # The bag has various modes :
  #   - :menu : when opened from the menu
  #   - :battle : when opened from the battle
  #   - :berry : when opened to plant berry
  #   - :hold : when opened to give an item to a Pokemon
  #   - :shop : when opened to sell item
  #   - :map : when an event request an item
  class Bag < BaseCleanUpdate::FrameBalanced
    include BagMixin
    # List of pocket name
    POCKET_NAMES = [nil.to_s, [:text_get, 15, 4], [:text_get, 15, 1], [:text_get, 15, 5], [:text_get, 15, 3], [:text_get, 15, 8], [:text_get, 15, 0], [:ext_text, 9000, 150], [:ext_text, 9000, 151]]
    # List of pocket index the player can see according to the modes
    POCKETS_PER_MODE = {menu: [1, 2, 6, 3, 5, 4, 8], battle: [1, 2, 6, 4], berry: [4], hold: [1, 2, 6, 4], shop: [1, 2, 6, 3, 4]}
    POCKETS_PER_MODE.default = POCKETS_PER_MODE[:menu]
    # ID of the favorite pocket (shortcut)
    FAVORITE_POCKET_ID = 8
    # Create a new Bag Scene
    # @param mode [Symbol] mode of the bag scene allowing to choose the pocket to show
    def initialize(mode = :menu)
    end
    private
    # Ensure we store all the information for the next time we open the bag
    def main_end
    end
    # Load the list of item (ids) for the current pocket
    def load_item_list
    end
    alias reload_item_list load_item_list
    # Load the pockets index & names
    def load_pockets
    end
    # Get the actual pocket ID
    def pocket_id
    end
    # Change the pocket
    # @param new_index [Integer] new pocket index
    def change_pocket(new_index)
    end
    public
    include UI::Bag
    # List of button text according to the mode
    CTRL_TEXTS_PER_MODE = {menu: [[:ext_text, 9000, 152], info = [:ext_text, 9000, 153], sort = [:ext_text, 9000, 154], [:ext_text, 9000, 115]], battle: [[:ext_text, 9000, 159], info, sort, cancel = [:ext_text, 9000, 17]], berry: [[:ext_text, 9000, 156], info, sort, cancel], hold: [[:ext_text, 9000, 157], info, sort, cancel], shop: [[:ext_text, 9000, 155], info, sort, cancel], map: [[:ext_text, 9000, 158], info, sort, cancel]}
    CTRL_TEXTS_PER_MODE.default = CTRL_TEXTS_PER_MODE[:menu]
    # Update the bag graphics
    def update_graphics
    end
    private
    # Create all the graphics for the UI
    def create_graphics
    end
    # Create the base ui
    def create_base_ui
    end
    # Fetch the button text
    # @return [Array<String>]
    def button_texts
    end
    # Create the frame
    def create_frame
    end
    # Create the pocket UI
    def create_pocket_ui
    end
    # Update the pocket name
    def update_pocket_name
    end
    # Create the scroll bar
    def create_scroll_bar
    end
    # Update the scroll bar max index
    def update_scroll_bar
    end
    # Create the bag sprite
    def create_bag_sprite
    end
    # Create the item list
    def create_item_list
    end
    # Update the item list
    def update_item_button_list
    end
    # Create the arrow
    def create_arrow
    end
    # Update the arrow
    def update_arrow
    end
    # Create the info
    def create_info
    end
    # Update the visibility of info box according to the mode
    def update_info_visibility
    end
    # Update the info shown in the info box
    def update_info
    end
    # Create the shadow helping to focus on the important thing
    def create_shadow
    end
    # Show the shadow
    def show_shadow_frame
    end
    # Hide the shadow
    def hide_shadow_frame
    end
    # Create the search bar
    def create_search
    end
    public
    # Update the bag inputs
    def update_inputs
    end
    private
    # Input update related to the socket index
    # @return [Boolean] if other update can be done
    def update_socket_input
    end
    # Input update related to the item list
    # @return [Boolean] if another update can be done
    def update_list_input
    end
    # Update the search input
    # @return [Boolean] if the other action can be performed
    def update_search
    end
    # Update CTRL button (A/B/X/Y)
    def update_ctrl_button
    end
    # Action related to B button
    def action_b
    end
    # Action related to A button
    def action_a
    end
    # Action related to X button
    def action_x
    end
    # Action related to Y button
    def action_y
    end
    public
    private
    # Start the Pocket change animation
    # @param new_index [Integer] the new pocket index
    def animate_pocket_change(new_index)
    end
    # Start the move up/down animation
    # @param delta [Integer] number of time to move up/down
    def animate_list_index_change(delta)
    end
    public
    # Constant that list all the choice method called when the player press A
    # depending on the bag mode
    CHOICE_MODE_A = {menu: :choice_a_menu, berry: :choice_a_berry, hold: :choice_a_hold, shop: :choice_a_shop, map: :choice_a_map, battle: :choice_a_battle}
    CHOICE_MODE_A.default = CHOICE_MODE_A[:menu]
    # Constant that list all the choice called when the player press Y
    # depending on the bag mode
    CHOICE_MODE_Y = {menu: :choice_y_menu}
    CHOICE_MODE_Y.default = CHOICE_MODE_Y[:menu]
    # Index of the search choice when pressing Y
    SEARCH_CHOICE_INDEX = 3
    private
    # Choice shown when you press A on menu mode
    def choice_a_menu
    end
    # Choice shown when you press Y on menu mode
    def choice_y_menu
    end
    # Choice when the player press A in berry/map mode
    def choice_a_berry
    end
    alias choice_a_map choice_a_berry
    # Choice when the player press A in Hold mode
    def choice_a_hold
    end
    # Choice when the player press A in shop mode
    def choice_a_shop
    end
    # Choice when the player press A in battle
    def choice_a_battle
    end
    public
    include Util::Item
    private
    # When player wants to use the item
    def use_item
    end
    # When player wants to use the item
    def use_item_in_battle
    end
    # Make sure the bag UI gets update after an action
    # @param index [Integer] previous index value
    def update_bag_ui_after_action(index)
    end
    # When the player wants to give an item
    def give_item
    end
    # When the player wants to register an item
    def register_item
    end
    # Process method that set the new shortcut
    # @param db_symbol [Symbol] db_symbol of the item to register
    # @param index [Integer] index of the shortcut to change
    def set_shortcut(db_symbol, index)
    end
    # When the player wants to unregister an item
    def unregister_item
    end
    # When the player wants to throw an item
    def throw_item
    end
    # When the player wants to sort the item by name
    def sort_name
    end
    # When the player wants to sort the item by number
    def sort_number
    end
    # When the player wants to sort by favorites
    def sort_favorites
    end
    # When the player wants to search an item
    def search_item
    end
    # When the search gets a new character
    # @param _full_text [String] current text in search
    # @param char [String] added char
    def search_add(_full_text, char)
    end
    # When the search removes a character
    # @param _full_text [String] current text in search
    # @param _char [String] removed char
    def search_rem(_full_text, _char)
    end
    # Update the search info
    def update_search_info
    end
    # When the player wants to sell an item
    def sell_item
    end
    public
    # List of action the mouse can perform with ctrl button
    ACTIONS = %i[action_a action_x action_y action_b]
    # Tell if the mouse over is enabled
    MOUSE_OVER_ENABLED = false
    # Update the mouse interactions
    # @param moved [Boolean] if the mouse moved durring the frame
    # @return [Boolean] if the thing after can update
    def update_mouse(moved)
    end
    private
    # Part where we update the mouse ctrl button
    def update_ctrl_button_mouse
    end
    # Part where we update the current pocket index
    def update_pocket_input
    end
    # Part where we try to update the list index
    def update_mouse_list
    end
    # Part where we try to update the list index if the mouse wheel change
    def update_mouse_index
    end
    # Update the list index according to a delta with mouse interaction
    # @param delta [Integer] number of index we want to add / remove
    def update_mouse_delta_index(delta)
    end
  end
  # Battle specialization of the bag
  class Battle_Bag < Bag
    # Create a new Battle_Bag
    # @param team [Array<PFM::PokemonBattler>] party that use this bag UI
    def initialize(team)
    end
    # Load the list of item (ids) for the current pocket
    def load_item_list
    end
    alias reload_item_list load_item_list
  end
end
GamePlay.bag_mixin = GamePlay::BagMixin
GamePlay.bag_class = GamePlay::Bag
GamePlay.battle_bag_class = GamePlay::Battle_Bag
