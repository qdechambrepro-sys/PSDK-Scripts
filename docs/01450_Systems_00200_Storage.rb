module PFM
  # Player PC storage
  #
  # The main object is stored in $storage and PFM.game_state.storage
  # @author Nuri Yuri
  class Storage
    # Maximum amount of box
    MAX_BOXES = 15
    # Maximum amount of battle box
    MAX_BATTLE_BOX = 16
    # Size of a box
    BOX_SIZE = 30
    # Number of box theme (background : Graphics/PC/f_id, title : Graphics/PC/title_id
    NB_THEMES = 16
    # Tell if the Pokemon gets healed & cured when stored
    HEAL_AND_CURE_POKEMON = true
    # The party of the other actor (friend)
    # @return [Array<PFM::Pokemon>]
    attr_accessor :other_party
    # The id of the current box
    # @return [Integer]
    attr_accessor :current_box
    # The id of the current battle box
    # @return [Integer]
    attr_accessor :current_battle_box
    # The Let's Go Follower
    # @return [PFM::Pokemon]
    attr_accessor :lets_go_follower
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Get the battle boxes
    # @return [Array<BattleBox>]
    attr_accessor :battle_boxes
    # Create a new storage
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state)
    end
    # Auto convert the data to the new format
    def auto_convert
    end
    # Store a pokemon to the PC
    # @param pokemon [PFM::Pokemon] the Pokemon to store
    # @return [Boolean] if the Pokemon has been stored
    def store(pokemon)
    end
    # Get the current box object
    # @note Any modification will be ignored
    # @return [PFM::Storage::Box]
    def current_box_object
    end
    # Retrieve a box content
    # @param index [Integer] the index of the box
    # @return [Array<PFM::Pokemon, nil>]
    def get_box_content(index)
    end
    alias get_box get_box_content
    # Return a box name
    # @param index [Integer] the index of the box
    # @return [String]
    def get_box_name(index)
    end
    # Change the name of a box
    # @param index [Integer] the index of the box
    # @param name [String] the new name
    def set_box_name(index, name)
    end
    # Get the name of a box (initialize)
    # @param index [Integer] the index of the box
    def box_name_init(index)
    end
    # Get a box theme
    # @param index [Integer] the index of the box
    # @return [Integer] the id of the box theme
    def get_box_theme(index)
    end
    # Change the theme of a box
    # @param index [Integer] the index of the box
    # @param theme [Integer] the id of the box theme
    def set_box_theme(index, theme)
    end
    # Remove a Pokemon in the current box and return what whas removed at the index
    # @param index [Integer] index of the Pokemon in the current box
    # @return [PFM::Pokemon, nil] the pokemon removed
    def remove_pokemon_at(index)
    end
    alias remove remove_pokemon_at
    # Is the slot "index" containing a Pokemon ?
    # @param index [Integer] index of the entity in the current box
    # @return [Boolean]
    def slot_contain_pokemon?(index)
    end
    # Return the Pokemon at an index in the current box
    # @param index [Integer] index of the Pokemon in the current box
    # @return [PFM::Pokemon, nil]
    def info(index)
    end
    # Store a Pokemon at a specific index in the current box
    # @param pokemon [PFM::Pokemon] the Pokemon to store
    # @param index [Integer] index of the Pokemon in the current box
    # @note The pokemon is healed when stored
    def store_pokemon_at(pokemon, index)
    end
    # Return the amount of box in the storage
    # @return [Integer]
    def box_count
    end
    alias max_box box_count
    # Check if there's a Pokemon alive in the box (egg or not)
    # @return [Boolean]
    def any_pokemon_alive?
    end
    alias any_pokemon_alive any_pokemon_alive?
    # Count the number of Pokemon available in the box
    # @param include_dead [Boolean] if the counter include the "dead" Pokemon
    # @return [Integer]
    def count_pokemon(include_dead = true)
    end
    # Yield a block on each Pokemon of storage
    # @yieldparam pokemon [PFM::Pokemon]
    def each_pokemon
    end
    # Yield a block on each Pokemon of storage and check if any answers to the block
    # @yieldparam pokemon [PFM::Pokemon]
    # @return [Boolean]
    def any_pokemon?
    end
    # Delete a box
    # @param index [Integer] index of the box to delete
    def delete_box(index)
    end
    # Add a new box
    # @param name [String] name of the new box
    def add_box(name)
    end
    private
    # Store a pokemon in the current box
    # @param pokemon [PFM::Pokemon] the Pokemon to store
    # @return [Boolean] if the Pokemon has been stored
    def store_in_current_box(pokemon)
    end
    # Find a box with space and change @current_box if found
    # @return [Boolean] if a box with space could be found
    def switch_to_box_with_space
    end
    def update_event_variables
    end
    # Get the ID of the current box variable
    # @return [Integer]
    def gv_current_box
    end
    class << self
      # Get the box size
      # @return [Integer]
      def box_size
      end
    end
    public
    # Class responsive of storing various thing and holding some information about the storage
    class Box
      # Name of the storage
      # @return [String]
      attr_accessor :name
      # Theme of the storage
      # @return [Integer]
      attr_accessor :theme
      # Content of the storage
      # @return [Array<PFM::Pokemon>]
      attr_reader :content
      # Create a new box
      # @param box_size [Integer] size of the box
      # @param name [String] name of the box
      # @param theme [Integer] theme of the box
      # @param content_overload [Array] content to force in this object
      def initialize(box_size, name, theme, content_overload = nil)
      end
    end
    public
    # Class Responsive of holding a team that can be used for battles
    class BattleBox
      # Name of the storage
      # @return [String]
      attr_accessor :name
      # Content of the storage
      # @return [Array<PFM::Pokemon>]
      attr_reader :content
      # Create a new battle box
      # @param name [String] name of the box
      # @param content_overload [Array] content to force in this object
      def initialize(name, content_overload = nil)
      end
    end
  end
  class GameState
    # The PC storage of the player
    # @return [PFM::Storage]
    attr_accessor :storage
    on_player_initialize(:storage) {@storage = PFM.storage_class.new(self) }
    on_expand_global_variables(:storage) do
      $storage = @storage
      @storage.game_state = self
      @storage.auto_convert
    end
  end
end
PFM.storage_class = PFM::Storage
module UI
  # Module containg all the storage UI
  module Storage
    # Sprite showing the current box mode
    class ModeSprite < SpriteSheet
      # Get the mode
      # @return [Symbol]
      attr_reader :mode
      # List of sheet index for all modes
      SHEET_INDEXES = {pokemon: 3, item: 4, battle: 6, box: 5}
      # Constant telling how much section there's in the sprite
      SHEET_SIZE = [1, 7]
      # Create a new ModeSprite
      # @param viewport [Viewport] viewport used to display the sprite
      # @param mode_handler [ModeHandler] class responsive of handling the mode
      def initialize(viewport, mode_handler)
      end
      # Set the mode
      # @param mode [Symbol]
      def mode=(mode)
      end
      private
      # Set the right sprite position
      def position_sprite
      end
      # Load the texture
      def load_texture
      end
    end
    # Sprite showing the current selection mode
    class SelectionModeSprite < SpriteSheet
      # Get the current mode
      # @return [Symbol] :detailed, :fast, :grouped
      attr_reader :selection_mode
      # List of sheet index for all modes
      SHEET_INDEXES = {detailed: 0, fast: 1, grouped: 2}
      # Constant telling how much section there's in the sprite
      SHEET_SIZE = [1, 7]
      # Create a new SelectionModeSprite
      # @param viewport [Viewport] viewport used to display the sprite
      # @param mode_handler [ModeHandler] class responsive of handling the mode
      def initialize(viewport, mode_handler)
      end
      # Set the selection_mode
      # @param selection_mode [Symbol]
      def selection_mode=(selection_mode)
      end
      private
      # Set the right sprite position
      def position_sprite
      end
      # Load the texture
      def load_texture
      end
    end
    # Sprite showing the current selection mode
    class WinMode < SpriteSheet
      # Get the current mode
      # @return [Symbol] :pokemon, :item, :battle, :box
      attr_reader :mode
      # List of sheet index for all modes
      SHEET_INDEXES = {pokemon: 0, item: 1, battle: 2, box: nil}
      # Constant telling how much section there's in the sprite
      SHEET_SIZE = [1, 3]
      # Create a new ModeSprite
      # @param viewport [Viewport] viewport used to display the sprite
      # @param mode_handler [ModeHandler] class responsive of handling the mode
      def initialize(viewport, mode_handler)
      end
      # Set the mode
      # @param mode [Symbol]
      def mode=(mode)
      end
      private
      # Set the right sprite position
      def position_sprite
      end
      # Load the texture
      def load_texture
      end
    end
    # Background of the box
    class BoxBackground < ShaderedSprite
      # Get current box data
      # @return [PFM::Storage::Box]
      attr_reader :data
      # Set current box data
      # @param box [PFM::Storage::Box]
      def data=(box)
      end
    end
    # Background for the name of the box
    class BoxNameBackground < ShaderedSprite
      # Get current box data
      # @return [PFM::Storage::Box]
      attr_reader :data
      # Set current box data
      # @param box [PFM::Storage::Box]
      def data=(box)
      end
    end
    # Class responsive of showing a rapid search
    class RapidSearch < UI::SpriteStack
      # Create a new rapid search
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the user input
      def update
      end
      # Get the text of the user input
      # @return [String]
      def text
      end
      # Reset the search
      def reset
      end
      private
      def create_stack
      end
      def create_background
      end
      def create_user_input
      end
    end
    # Class responsive of showing a Detailed search
    class DetailedSearch < UI::SpriteStack
      # Name of the button image
      BUTTON_IMAGE = 'button_list_ext'
      # Create a new DetailedSearch
      # @param viewport [Viewport]
      def initialize(viewport)
      end
    end
    # Class responsive of showing the cursor
    class Cursor < ShaderedSprite
      # Get the index
      # @return [Integer]
      attr_reader :index
      # Get the inbox property /!\ Always update this before index
      # @return [Boolean]
      attr_reader :inbox
      # Get the select box mode
      # @return [Boolean]
      attr_reader :select_box
      # Get the current selection mode
      # @return [Symbol]
      attr_reader :selection_mode
      # Get the current mode
      # @return [Symbol]
      attr_reader :mode
      # Box initial position
      BOX_INITIAL_POSITION = [17, 42]
      # Party positions
      PARTY_POSITIONS = [[233, 50], [281, 66], [233, 98], [281, 115], [233, 146], [281, 162]]
      # List of graphics depending on the selection mode
      ARROW_IMAGES = {battle: 'pc/arrow_red', pokemon: 'pc/arrow_blue', grouped: 'pc/arrow_green', item: 'pc/arrow_yellow'}
      # Create a new cusror object
      # @param viewport [Viewport]
      # @param index [Integer] index of the cursor where it is
      # @param inbox [Boolean] If the cursor is in box or not
      # @param mode_handler [ModeHandler]
      def initialize(viewport, index, inbox, mode_handler)
      end
      # Update the animation
      def update
      end
      # Tell if the animation is done
      # @return [Boolean]
      def done?
      end
      # Get the max index
      # @return [Integer]
      def max_index
      end
      # Set the current index
      # @param index [Integer]
      def index=(index)
      end
      # Force an index (mouse operation)
      # @param inbox [Boolean]
      # @param index [Integer]
      def force_index(inbox, index)
      end
      # Set the inbox property
      # @param inbox [Boolean]
      def inbox=(inbox)
      end
      # Set the selec box property
      # @param select_box [Boolean]
      def select_box=(select_box)
      end
      # Set the current selection mode
      # @param selection_mode [Symbol]
      def selection_mode=(selection_mode)
      end
      # Set the current mode
      # @param mode [Symbol]
      def mode=(mode)
      end
      private
      def update_graphics
      end
      def update_position
      end
      def update_position_with_animation
      end
    end
    # Class responsive of handling the mode for the PC UI
    class ModeHandler
      # Get the current mode
      # @return [Symbol] :pokemon, :item, :battle, :box
      attr_reader :mode
      # List the available modes
      AVAILABLE_MODES = %i[pokemon item battle]
      # box mode disabled for now
      # Get the current selection mode
      # @return [Symbol] :detailed, :fast, :grouped
      attr_reader :selection_mode
      # List the available modes
      AVAILABLE_SELECTION_MODES = %i[detailed fast grouped]
      # Create a new Mode Handler
      # @param selection_mode [Symbol] :detailed, :fast or :grouped
      def initialize(mode, selection_mode)
      end
      # Add a mode ui
      # @param mode_ui [#mode=]
      def add_mode_ui(mode_ui)
      end
      # Add a selection mode ui
      # @param selection_mode_ui [#selection_mode=]
      def add_selection_mode_ui(selection_mode_ui)
      end
      # Set the mode of the UIs
      # @param mode [Symbol]
      def mode=(mode)
      end
      # Set the mode of the UIs
      # @param selection_mode [Symbol]
      def selection_mode=(selection_mode)
      end
      # Swap the mode
      # @return [Symbol]
      def swap_mode
      end
      # Swap the selection mode
      # @return [Symbol]
      def swap_selection_mode
      end
    end
    # Class that handle all the logic related to cursor movement between each party of the UI
    class CursorHandler
      # Create a cusor handler
      # @param cursor [Cursor]
      def initialize(cursor)
      end
      # Get the cursor mode
      # @return [Symbol] :box, :party, :box_choice
      def mode
      end
      # Get the index of the cursor
      # @return [Integer]
      def index
      end
      # Move the cursor to the right
      # @return [Boolean] if the action was a success
      def move_right
      end
      # Move the cursor to the left
      # @return [Boolean] if the action was a success
      def move_left
      end
      # Move the cursor up
      # @return [Boolean] if the action was a success
      def move_up
      end
      # Move the cursor down
      # @return [Boolean] if the action was a success
      def move_down
      end
      private
      # Move the cursor to the right in the box
      # @return [Boolean] if the action was a success
      def move_right_inbox
      end
      # Move the cursor to the right in the party
      # @return [Boolean] if the action was a success
      def move_right_party
      end
      # Move the cursor to the left in the box
      # @return [Boolean] if the action was a success
      def move_left_inbox
      end
      # Move the cursor to the left in the party
      # @return [Boolean] if the action was a success
      def move_left_party
      end
    end
    # Class responsive of handling the selection
    class SelectionHandler
      # Set the current storage object
      # @return [PFM::Storage]
      attr_writer :storage
      # Set the current cursor handler
      # @return [CursorHandler]
      attr_writer :cursor
      # Set the current party
      # @return [Array<PFM::Pokemon>]
      attr_writer :party
      # Create a new selection handler
      # @param mode_handler [ModeHandler] object responsive of handling the mode
      def initialize(mode_handler)
      end
      # Update the current selection
      def update_selection
      end
      # Tell if all selection are empty
      # @return [Boolean]
      def empty?
      end
      # Select or deselect the current index
      def select
      end
      # Move the current selection of pokemon to the current cursor
      # @return [Boolean] if the operation was a success
      def move_pokemon_to_cursor
      end
      # Move the current selection of items to the current cursor
      # @return [Boolean] if the operation was a success
      def move_items_to_cursor
      end
      # Release all selected Pokemon
      def release_selected_pokemon
      end
      # Clear the selection
      def clear
      end
      # Define the box selection display
      # @param box [#update_selection(arr)]
      def box_selection_display=(box)
      end
      # Define the party selection display
      # @param party_display [#update_selection(arr)]
      def party_selection_display=(party_display)
      end
      # Get all selected Pokemon
      # @return [Array<PFM::Pokemon>]
      def all_selected_pokemon
      end
      # Get all selected Pokemon in party
      # @return [Array<PFM::Pokemon>]
      def all_selected_pokemon_in_party
      end
      private
      # Get the selection size
      # @return [Integer]
      def selection_size
      end
      # Get the current object size
      # @return [Integer]
      def current_object_size
      end
      # Get the current object actual content size
      # @return [Integer]
      def current_object_content_size
      end
      # Get the current object setter
      # @return [#call(index, value)]
      def current_object_setter
      end
      # Get the current object getter
      # @return [#call(index)]
      def current_object_getter
      end
      # Iterate through all box selection
      # @yieldparam box [Array<PFM::Pokemon>] current box object
      # @yieldparam i [Integer] current selection
      def each_box_selection
      end
      # Iterate through all battle box selection
      # @yieldparam box [Array<PFM::Pokemon>] current battle box object
      # @yieldparam i [Integer] current selection
      def each_battle_selection
      end
      # Iterate through all party selection
      # @yieldparam party [Array<PFM::Pokemon>] current party object
      # @yieldparam i [Integer] current selection
      def each_party_selection
      end
      # Reset the form of the Pokemon
      # @param pokemon [PFM::Pokemon] the pokemon stored
      def reset_form(pokemon)
      end
    end
    # Stack responsive of showing the full PC UI
    class Composition < UI::SpriteStack
      # Get the mode handler
      # @return [ModeHandler]
      attr_reader :mode_handler
      # Get the party
      # @return [Array<PFM::Pokemon>]
      attr_reader :party
      # Get the storage object
      # @return [PFM::Storage]
      attr_reader :storage
      # Get the current box index
      # @return [Integer]
      attr_reader :box_index
      # Get the summary object
      # @return [Summary]
      attr_reader :summary
      # Get the cursor object
      # @return [CursorHandler]
      attr_reader :cursor_handler
      # Get the selection handler
      # @return [SelectionHandler]
      attr_reader :selection_handler
      # Y Offset of the cursor while inside of the box
      OFFSET_Y_CURSOR = [0, -1, -2, -3, -4, -5, -5, -4, -3, -2, -1, 0]
      # Y Offset of the cursor while outside of the box
      OFFSET_Y_CURSOR_OUT_OF_THE_BOX = [15, 30, 63, 79, 111, 126]
      # Create a new Composition
      # @param viewport [Viewport] viewport used to display the sprites
      # @param mode [Symbol] :pokemon, :item, :battle or :box
      # @param selection_mode [Symbol] :detailed, :fast or :grouped
      def initialize(viewport, mode, selection_mode)
      end
      # Update the composition state
      def update
      end
      # Tell if the animation is done
      # @return [boolean]
      def done?
      end
      # Start animation for right arrow
      # @param middle_animation [Yuki::Animation::TimedAnimation] animation played in the middle of this animation
      def animate_right_arrow(middle_animation = nil)
      end
      # Start animation for left arrow
      # @param middle_animation [Yuki::Animation::TimedAnimation] animation played in the middle of this animation
      def animate_left_arrow(middle_animation = nil)
      end
      # Set the storage object
      # @param storage [PFM::Storage]
      def storage=(storage)
      end
      # Set the party object
      # @param party [Array<PFM::Pokemon>]
      def party=(party)
      end
      # Tell if the mouse is hovering a pokemon sprite & update cursor index in consequence
      # @return [Boolean]
      def hovering_pokemon_sprite?
      end
      # Tell if the mouse hover the mode indicator
      # @return [Boolean]
      def hovering_mode_indicator?
      end
      # Tell if the mouse hover the selection mode indicator
      # @return [Boolean]
      def hovering_selection_mode_indicator?
      end
      # Tell if the box option is hovered
      # @return [Boolean]
      def hovering_box_option?
      end
      # Tell if the right arrow is hovered
      # @return [Boolean]
      def hovering_right_arrow?
      end
      # Tell if the left arrow is hovered
      # @return [Boolean]
      def hovering_left_arrow?
      end
      # Tell if the right arrow of party stack is hovered
      # @return [Boolean]
      def hovering_party_right_arrow?
      end
      # Tell if the left arrow of party stack is hovered
      # @return [Boolean]
      def hovering_party_left_arrow?
      end
      private
      def create_stack
      end
      def create_box_stack
      end
      def create_party_stack
      end
      def create_frames
      end
      def create_modes
      end
      def create_win_txt
      end
      def create_arrows
      end
      def create_summary
      end
      def create_cursor
      end
      # Function that moves the cursor according to the positioning of the cursor, creating the cursor moving up and down animation
      # @param index [Integer]
      def move_cursor(index)
      end
    end
    # Stack responsive of showing a box
    class BoxStack < UI::SpriteStack
      # Get the current mode
      # @return [Symbol]
      attr_reader :mode
      # Create a new box stack
      # @param viewport [Viewport]
      # @param mode_handler [ModeHandler] object responsive of handling the mode
      # @param selection_handler [SelectionHandler] object responsive of handling the selection
      def initialize(viewport, mode_handler, selection_handler)
      end
      # Tell if the name background is hovered in order to show the option menu
      # @return [Boolean]
      def box_option_hovered?
      end
      # Update the selection
      # @param selection [Array<Integer>] list of selected indexes
      def update_selection(selection)
      end
      # Update the data
      # @param data [PFM::Storage::Box]
      def data=(data)
      end
      # Make the pokemon gray depending on a criteria
      # @yieldparam pokemon [PFM::Pokemon]
      def gray_pokemon
      end
      # Set the mode
      # @param mode [Symbol]
      def mode=(mode)
      end
      # Get the Pokemon sprites
      # @return [Array<Sprite>]
      def pokemon_sprites
      end
      private
      def create_stack
      end
      def create_box_background
      end
      def create_box_name_background
      end
      def create_box_name
      end
      def create_slots
      end
      def create_select_button
      end
      def create_pokemons
      end
      # Update sprites to item mode
      def update_sprites_to_item
      end
      # Update sprites to other modes
      def update_sprites_to_other
      end
    end
    # Icon of a creature in the storage UI
    class PokemonIcon < UI::PokemonIconSprite
      def initialize(viewport, index)
      end
      # Set the box data
      # @param box [PFM::Storage::Box]
      def data=(box)
      end
      # Tell if the mouse is in the sprite
      def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
      end
    end
    # Icon of a held item in the storage UI
    class PokemonItemIcon < UI::ItemSprite
      def initialize(viewport, index)
      end
      # Set the box data
      # @param box [PFM::Storage::Box]
      def data=(box)
      end
    end
    # Stack responsive of showing a party
    class PartyStack < UI::SpriteStack
      # Get the current mode
      # @return [Symbol]
      attr_reader :mode
      # List of images according to the mode
      SLOT_IMAGES = {pokemon: 'pc/party_pkmn', item: 'pc/party_items', battle: 'pc/party_battle'}
      # List of coordinate for Pokemon sprite
      POKEMON_COORDINATES = [[224, 64], [272, 80], [224, 112], [272, 128], [224, 160], [272, 176]]
      # Create a new party stack
      # @param viewport [Viewport]
      # @param mode_handler [ModeHandler] object responsive of handling the mode
      # @param selection_handler [SelectionHandler] object responsive of handling the selection
      def initialize(viewport, mode_handler, selection_handler)
      end
      # Update the selection
      # @param selection [Array<Integer>] current selected Pokemon
      def update_selection(selection)
      end
      # Update the data
      # @param data [PFM::Storage::BattleBox]
      def data=(data)
      end
      # Make the pokemon gray depending on a criteria
      # @yieldparam pokemon [PFM::Pokemon]
      def gray_pokemon
      end
      # Set the mode
      # @param mode [Symbol]
      def mode=(mode)
      end
      # Get the Pokemon sprites
      # @return [Array<Sprite>]
      def pokemon_sprites
      end
      # Tell if the left arrow is hovered
      # @return [Boolean]
      def hovering_left_arrow?
      end
      # Tell if the right arrow is hovered
      # @return [Boolean]
      def hovering_right_arrow?
      end
      private
      def create_stack
      end
      def create_txt_party
      end
      def create_box_name
      end
      def create_slots
      end
      def create_select_button
      end
      def create_pokemons
      end
      def create_arrows
      end
      # Update sprites to item mode
      def update_sprites_to_item
      end
      # Update sprites to other modes
      def update_sprites_to_other
      end
    end
    # Stack responsive of showing a summary
    class Summary < UI::SpriteStack
      # Tell if the UI is reduced or not
      # @return [Boolean]
      attr_reader :reduced
      # Position of the summary depending on the state
      POSITION = [[210, 200], [210, 10]]
      # Position of the letter depending on the state
      LETTER_POSITION = [[1, 0], [95, 15]]
      # Time between each text transition
      TEXT_TRANSITION_TIME = 2
      # Create a new summary object
      # @param viewport [Viewport]
      # @param reduced [Boolean] if the UI is initially reduced or not
      def initialize(viewport, reduced)
      end
      # Update the composition state
      def update
      end
      # Set an object invisible if the Pokemon is an egg
      # @param object [#visible=] the object that is invisible if the Pokemon is an egg
      def no_egg(object)
      end
      # Update the shown pokemon
      def data=(pokemon)
      end
      # Tell if the animation is done
      # @return [boolean]
      def done?
      end
      # Reduce the UI (start animation)
      def reduce
      end
      # Show the UI (start animation)
      def show
      end
      private
      # Function that updates the text transition
      def update_text_transition
      end
      def create_stack
      end
      def create_background
      end
      def create_press_letter
      end
      def create_pokemon
      end
      def reset_text_visibility
      end
    end
  end
end
module GamePlay
  # Storage scene
  class PokemonStorage < BaseCleanUpdate
    # List of keys supported by the base UI depending on the mode
    BASE_UI_KEYS = [regular = %i[A X Y B], regular, %i[A L R B], regular, regular, regular, %i[A LEFT RIGHT B], regular]
    # List of texts shown by the base UI depending on the mode
    BASE_UI_TEXTS = [regular = [[:ext_text, 9007, 14], [:get_text, nil], [:ext_text, 9007, 16], [:ext_text, 9007, 15]], regular, [[:ext_text, 9007, 14], [:ext_text, 9007, 18], [:ext_text, 9007, 19], [:ext_text, 9007, 15]], [[:ext_text, 9007, 14], [:ext_text, 9007, 23], [:ext_text, 9007, 16], [:ext_text, 9007, 20]], [[:ext_text, 9007, 14], [:get_text, nil], [:ext_text, 9007, 16], [:ext_text, 9007, 20]], [[:ext_text, 9007, 17], [:get_text, nil], [:ext_text, 9007, 16], [:ext_text, 9007, 20]], [[:ext_text, 9007, 21], [:ext_text, 9007, 18], [:ext_text, 9007, 19], [:ext_text, 9007, 15]], [[:get_text, nil], [:get_text, nil], [:get_text, nil], [:ext_text, 9007, 22]]]
    # Hash describing which mode to choose in the base UI when we're in detailed mode
    MODE_TO_BASE_UI_MODE = {pokemon: 0, item: 1, battle: 2}
    # Create a new Storage Scene
    # @param storage [PFM::Storage] the current storage object
    # @param party [Array<PFM::Pokemon>]
    def initialize(storage = $storage, party = $actors)
    end
    # Update the graphics of the Storage scene
    def update_graphics
    end
    private
    def create_graphics
    end
    def create_composition
    end
    def create_base_ui
    end
    # Get all the base UI texts
    # @return [Array<Array<String>>]
    def base_ui_texts
    end
    public
    # Refresh everything in the UI
    def refresh
    end
    private
    # Function responsive of changing the box
    # @param moved_right [Boolean] if the player supposedly pressed right
    def change_box(moved_right)
    end
    # Function that updates the box shown
    def update_box_shown
    end
    # Update the summary
    def update_summary
    end
    # Clear the selection
    def clear_selection
    end
    # Update the mode of the base_ui
    def update_mode
    end
    # Tell if we can leave the storage
    # @return [Boolean]
    def can_leave_storage?
    end
    # Tell if the current box is not empty
    # @return [Boolean]
    def current_box_non_empty?
    end
    # Tell if the pokemon can be released
    def pokemon_can_be_released?
    end
    public
    # List of Action depending on the selection mode
    SELECTION_MODE_ACTIONS = {detailed: :action_a_detailed, fast: :action_a_fast, grouped: :action_a_grouped}
    # List of method called by automatic_input_update when pressing on a key
    AIU_KEY2METHOD = {A: :action_a, B: :action_b, X: :action_x, Y: :action_y, L: :action_l, R: :action_r, L2: :action_l2, R2: :action_r2, LEFT: :action_left, RIGHT: :action_right, UP: :action_up, DOWN: :action_down}
    # Update the input of the scene
    def update_inputs
    end
    private
    # When the player press B we quit the computer
    def action_b
    end
    # When the player press A we act depending on the state
    def action_a
    end
    # When the player press X
    def action_x
    end
    # When the player press A in detailed selection
    def action_a_detailed
    end
    # When the player press A in fast mode, we select and then swap
    def action_a_fast
    end
    # Action when the player need to swap pokemon (in fast mode)
    def action_a_fast_swap
    end
    # Action when the player press A in grouped mode
    def action_a_grouped
    end
    # When the player press RIGHT
    def action_right
    end
    # When the player press LEFT
    def action_left
    end
    # When the player press UP
    def action_up
    end
    # When the player press DOWN
    def action_down
    end
    # When player press L we update the battle_box index
    def action_l
    end
    # When player press R we update the battle_box index
    def action_r
    end
    # When player press R2, the mode changes
    def action_r2
    end
    # When player press L2, the selection mode changes
    def action_l2
    end
    # When the player press Y, the summary is shown
    def action_y
    end
    public
    # Update the mouse action
    def update_mouse(moved)
    end
    private
    # Action when clicking left
    def mouse_left_action
    end
    # Action when clicking right
    def mouse_right_action
    end
    # Action when the mouse moved
    def mouse_moved_action
    end
    # Action when a Mouse.wheel event appear
    def mouse_wheel_action
    end
    public
    # List of options shown when choosing the box option
    CHOICE_BOX_OPTIONS = [[:text_get, 33, 45], [:text_get, 33, 44], [:ext_text, 9007, 3], [:text_get, 33, 38]]
    # Message shown when choosing the box option
    MESSAGE_BOX_OPTIONS = [:ext_text, 9007, 0]
    # "What to do with %<box>s?"
    # List of options shown when choosing something for a single pokemon
    SINGLE_POKEMON_CHOICE = [[:text_get, 33, 39], [:text_get, 33, 41], [:text_get, 33, 80], [:text_get, 33, 79], [:text_get, 33, 42], [:text_get, 33, 81]]
    # Message shown when manipulating a single Pokemon
    SINGLE_POKEMON_MESSAGE = [:ext_text, 9007, 1]
    # "What to do with %<name>s?"
    # Message shown when we manipulate various Pokemon
    SELECTED_POKEMON_MESSAGE = [:ext_text, 9007, 2]
    private
    # Choice shown when we want to change box option
    def choice_box_option
    end
    # Get the choice coordinates
    # @param choices [PFM::Choice_Helper]
    # @return [Array(Integer, Integer)]
    def choice_coordinates(choices)
    end
    # Choice shown when we didn't selected any pokemon
    def choice_single_pokemon
    end
    # Choice shown when we selected various pokemon
    def choice_selected_pokemon
    end
    public
    include Util::GiveTakeItem
    # Message shown when we want to rename a box
    BOX_NAME_MESSAGE = [:ext_text, 9007, 4]
    # Message shown when choosing the theme
    BOX_THEME_CHOICE_MESSAGE = [:ext_text, 9007, 5]
    # Message shown when we want to give a name to the new box
    BOX_NEW_NAME_MESSAGE = [:ext_text, 9007, 6]
    # New box name
    BOX_NEW_DEFAULT_NAME = [:ext_text, 9007, 7]
    # Message shown to confirm if we want to remove the box
    REMOVE_BOX_MESSAGE = [:ext_text, 9007, 8]
    # Choice option for remove box confirmation
    REMOVE_BOX_CHOICES = [[:text_get, 33, 84], [:text_get, 33, 83]]
    # Message shown when we want to move a Pokemon
    MOVE_POKEMON_MESSAGE = [:ext_text, 9007, 9]
    # Message shown when we want to move several Pokemon
    MOVE_SELECTED_POKEMON_MESSAGE = [:ext_text, 9007, 10]
    # Message shown when we try to release a Pokemon
    RELEASE_POKEMON_MESSAGE1 = [:ext_text, 9007, 11]
    # Choice option for release pokemon confirmation
    RELEASE_POKEMON_CHOICES = [[:text_get, 33, 84], [:text_get, 33, 83]]
    # Message shown when we try to release several Pokemon
    RELEASE_SELECTED_POKEMON_MESSAGE = [:ext_text, 9007, 12]
    private
    # Change the current box name
    def change_box_name
    end
    # Change the current box theme
    def change_box_theme
    end
    # Get the number of themes
    def max_theme_index
    end
    # Add a new box
    def add_new_box
    end
    # Remove the box
    def remove_box
    end
    # Move the selected Pokemon
    def move_pokemon
    end
    # Show the summary of a Pokemon
    def show_pokemon_summary
    end
    # Give an item to a Pokemon
    def give_item_to_pokemon
    end
    # Take item from Pokemon
    def take_item_from_pokemon
    end
    # Release a Pokemon
    def release_pokemon
    end
    # Move all selected Pokemon
    def move_selected_pokemon
    end
    # Show the summary of the selected Pokemon
    def show_selected_pokemon_summary
    end
    # Release the selected Pokemon
    def release_selected_pokemon
    end
  end
  # Mixin definin the Input/Output of the PokemonTradeStorage class
  module PokemonTradeStorageMixin
    # Get the selected Pokemon index (1~30) = current box, (31~36) = party
    # @return [Integer, nil]
    attr_reader :return_data
    # Tell if a Pokemon was selected
    # @return [Boolean]
    def pokemon_selected?
    end
    # Get the selected Pokemon
    # @return [PFM::Pokemon, nil]
    def selected_pokemon
    end
    # Tell if the selected Pokemon is from box
    # @return [Boolean]
    def pokemon_selected_in_box?
    end
    # Tell if the selected Pokemon is from party
    # @return [Boolean]
    def pokemon_selected_in_party?
    end
  end
  # Storage scene in trading context
  class PokemonTradeStorage < PokemonStorage
    include PokemonTradeStorageMixin
    # Message shown to tell to choose a Pokemon
    CHOOSE_POKEMON_MESSAGE = [:ext_text, 9007, 13]
    # "Choose a Pokemon to trade."
    # List of option when pressing A
    TRADE_OPTIONS = [[:ext_text, 9000, 90], [:text_get, 33, 41], [:text_get, 33, 82]]
    private
    def create_graphics
    end
    def show_pokemon_choice
    end
    alias action_x play_buzzer_se
    alias action_a_detailed play_buzzer_se
    alias action_a_fast play_buzzer_se
    alias action_a_fast_swap play_buzzer_se
    alias action_a_grouped play_buzzer_se
    alias action_l play_buzzer_se
    alias action_r play_buzzer_se
    alias action_r2 play_buzzer_se
    alias action_l2 play_buzzer_se
    def action_a
    end
    def action_b
    end
    def choice_trade
    end
    def trade_pokemon
    end
  end
end
GamePlay.pokemon_storage_class = GamePlay::PokemonStorage
GamePlay.pokemon_trade_storage_mixin = GamePlay::PokemonTradeStorageMixin
GamePlay.pokemon_trade_storage_class = GamePlay::PokemonTradeStorage
