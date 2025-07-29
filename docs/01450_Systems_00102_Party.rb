module Util
  # Module adding the give / take item functionality to a scene
  module GiveTakeItem
    # Give an item to a Pokemon
    # @param pokemon [PFM::Pokemon] pokemon that will receive the item
    # @param item [Integer, Symbol] item to give, -1 to open the bag
    # @yieldparam pokemon [PFM::Pokemon] block we call with pokemon before and after the form calibration
    # @return [Boolean] if the item was given
    def givetake_give_item(pokemon, item = -1)
    end
    # Display the give item message
    # @param item1 [Integer] taken item
    # @param item2 [Integer] given item
    # @param pokemon [PFM::Pokemon] Pokemong getting the item
    def givetake_give_item_message(item1, item2, pokemon)
    end
    # Display the give item message to an egg
    # @param item [Integer] given item
    def givetake_give_egg_message(item)
    end
    # Update the bag and pokemon state when giving an item
    # @param item1 [Integer] taken item
    # @param item2 [Integer] given item
    # @param pokemon [PFM::Pokemon] Pokemong getting the item
    def givetake_give_item_update_state(item1, item2, pokemon)
    end
    # Action of taking the item from the Pokemon
    # @param pokemon [PFM::Pokemon] pokemon we take item from
    # @yieldparam pokemon [PFM::Pokemon] block we call with pokemon before and after the form calibration
    def givetake_take_item(pokemon)
    end
  end
end
module UI
  # UI part displaying the generic information of the Pokemon in the Summary
  class Summary_Top < SpriteStack
    # List of Pokemon that shouldn't show the gender sprite
    NO_GENDER = %i[nidoranf nidoranm]
    # Create a new Memo UI for the summary
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Set the Pokemon shown
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    # Update the graphics
    def update_graphics
    end
    private
    def init_sprite
    end
    # @return [PokemonFaceSprite]
    def create_sprite
    end
    # @return [SymText]
    def create_name_text
    end
    # @return [GenderSprite]
    def create_gender
    end
    # @return [RealHoldSprite]
    def create_item
    end
    # @return [Sprite]
    def create_ball
    end
    # @return [Sprite]
    def create_star
    end
    def create_status
    end
  end
  # UI part displaying the "Memo" of the Pokemon in the Summary
  class Summary_Memo < SpriteStack
    # Create a new Memo UI for the summary
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Set an object invisible if the Pokemon is an egg
    # @param object [#visible=] the object that is invisible if the Pokemon is an egg
    def no_egg(object)
    end
    # Define the pokemon shown by this UI
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    # Change the visibility of the UI
    # @param value [Boolean] new visibility
    def visible=(value)
    end
    # Initialize the Memo part
    def init_memo
    end
    # Load the text info
    # @param pokemon [PFM::Pokemon]
    def load_text_info(pokemon)
    end
    # Load the text info when it's an egg
    # @param pokemon [PFM::Pokemon]
    def load_egg_text_info(pokemon)
    end
    private
    def fix_level_text_position
    end
    def init_sprite
    end
    def create_background
    end
    def create_text_info
    end
    def create_exp_bar
    end
    # Search for the right text based on the Pokémon's data
    # @param pokemon [PFM::Pokemon]
    # @return [Integer]
    def egg_text_info(pokemon)
    end
    # Search for the right text based on the number of remaining steps
    # @param pokemon [PFM::Pokemon]
    # @return [Integer]
    def step_remaining_message(pokemon)
    end
  end
  # UI part displaying the Stats of a Pokemon in the Summary
  class Summary_Stat < SpriteStack
    # Show the IV ?
    SHOW_IV = true
    # Show the EV ?
    SHOW_EV = true
    # Create a new Stat UI for the summary
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Set the Pokemon shown by the UI
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    private
    # @param creature [PFM::Pokemon]
    def fix_nature_texts(creature)
    end
    def init_sprite
    end
    def create_background
    end
    def init_ability
    end
    def create_hp_bg
    end
    # Init the stat texts
    def init_stats
    end
    # Create the HP Bar for the pokemon Copy/Paste from Menu_Party
    # @return [UI::Bar]
    def create_hp_bar
    end
    # Init the ev/iv texts
    def init_ev_iv
    end
  end
  # Window responsive of displaying the Level Up information when a Pokemon levels up
  class LevelUpWindow < UI::Window
    # Create a new Level Up Window
    # @param viewport [Viewport] viewport in which the Pokemon is shown
    # @param pokemon [PFM::Pokemon] Pokemon that is currently leveling up
    # @param list0 [Array] old basis stats
    # @param list1 [Array] new basis stats
    def initialize(viewport, pokemon, list0, list1)
    end
    # Update the Pokemon Icon animation
    def update
    end
    private
    # Create all the sprites inside the window
    def create_sprites
    end
    # Create the Pokemon Icon sprite
    def create_pokemon_icon
    end
    # Create the Pokemon Name sprite
    def create_pokemon_name
    end
    # Create all the stats texts
    def create_stats_texts
    end
    # width of the Window
    def window_width
    end
    # Height of the Window
    def window_height
    end
    # X position of the Window
    def window_x
    end
    # Y position of the Window
    def window_y
    end
  end
  # UI part displaying the Skills of the Pokemon in the Summary
  class Summary_Skills < SpriteStack
    # @return [Integer] The index of the move
    attr_reader :index
    # @return [Array<UI::Summary_Skill>] The skills
    attr_reader :skills
    # Create a new Skills UI for the summary
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Set the data of the UI
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    # Set the visibility of the UI
    # @param value [Boolean] new visibility
    def visible=(value)
    end
    # Set the index of the shown move
    # @param index [Integer]
    def index=(index)
    end
    private
    def init_sprite
    end
    # Return the background name
    # @return [String]
    def background_name
    end
    # Update the skills shown in the UI
    # @param pokemon [PFM::Pokemon]
    def update_skills(pokemon)
    end
    # Init the texts of the UI
    def init_texts
    end
    # Init the skills of the UI
    def init_skills
    end
    # Fix the index value
    # @param index [Integer] requested index
    # @return [Integer] fixed index
    def fix_index(index)
    end
    # Fix the index value when index < 0
    # @param index [Integer] requested index
    # @param max_index [Integer] the maximum index
    # @return [Integer] the new index
    def fix_index_minus(index, max_index)
    end
    # Fix the index value when index > max_index
    # @param index [Integer] requested index
    # @param _max_index [Integer] the maximum index
    # @return [Integer] the new index
    def fix_index_plus(index, _max_index)
    end
  end
  # UI part displaying a Skill in the Summary_Skills UI
  class Summary_Skill < SpriteStack
    # Array describing the various coordinates of the skills in the UI
    FINAL_COORDINATES = [[28, 138], [174, 138], [28, 170], [174, 170]]
    # Color when it's selected
    SELECTED_COLOR = Color.new(0, 200, 0, 255)
    # Color when it's not selected
    NO_SELECT_COLOR = Color.new(0, 0, 0, 0)
    # @return [Boolean] if the move is currently selected
    attr_reader :selected
    # @return [Boolean] if the move is currently being moved
    attr_reader :moving
    # Create a new skill
    # @param viewport [Viewport]
    # @param index [Integer] index of the skill in the UI
    def initialize(viewport, index)
    end
    # Set the skill data
    # @param skill [PFM::Skill]
    def data=(skill)
    end
    # Set the visibility of the sprite
    # @param value [Boolean] new visibility
    def visible=(value)
    end
    # Get the visibility of the sprite
    # @return [Boolean]
    def visible
    end
    # Define if the skill is selected
    # @param selected [Boolean]
    def selected=(selected)
    end
    # Define if the skill is being moved
    # @param moving [Boolean]
    def moving=(moving)
    end
    private
    def create_sprites
    end
    # Return the name of the selector file
    # @return [String]
    def selector_name
    end
    # Return the name of the method used to get the PP text
    # @return [Symbol]
    def pp_method
    end
  end
  # UI displaying the Reminding move list
  class Summary_Remind < Summary_Skills
    # @return [Integer] maximum number of moves shown in the screen
    MAX_MOVES = 5
    # @return [Integer] mode passed to the {PFM::Pokemon#remindable_skills} method
    attr_accessor :mode
    # @return [Array<PFM::Skill>] list of learnable moves
    attr_reader :learnable_skills
    # Create a new Summary_Remind UI for the summary
    # @param viewport [Viewport]
    # @param pokemon [PFM::Pokemon] Pokemon that should relearn some skills
    def initialize(viewport, pokemon)
    end
    # Set the Pokemon shown
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    # Set the index of the shown move
    # @param index [Integer]
    def index=(index)
    end
    # Update the skills shown in the UI
    # @param pokemon [PFM::Pokemon]
    def update_skills(pokemon = @data)
    end
    # Update the graphics
    def update_graphics
    end
    private
    def fix_gender_position
    end
    # @param creature [PFM::Pokemon]
    def fix_nature_texts(creature)
    end
    def init_sprite
    end
    # Return the background name
    # @return [String]
    def background_name
    end
    # Init the skills of the UI
    def init_skills
    end
    # Init the Pokemon Info
    def init_pokemon_info
    end
    # Init the stat texts
    def init_stats
    end
    # Update the skill list
    def update_skill_list
    end
    # Fix the index value
    # @param index [Integer] requested index
    # @return [Integer] fixed index
    def fix_index(index)
    end
    # Fix the @offset_index value
    # @param index [Integer] fixed index
    # @param max_index [Integer] last possible index
    def fix_offset_index(index, max_index)
    end
  end
  # UI part displaying a Skill in the Summary_Remind UI
  class Remind_Skill < Summary_Skill
    # Create a new skill
    # @param viewport [Viewport]
    # @param index [Integer] index of the skill in the UI
    def initialize(viewport, index)
    end
    private
    # Return the name of the selector file
    # @return [String]
    def selector_name
    end
    # Return the name of the method used to get the PP text
    # @return [Symbol]
    def pp_method
    end
  end
  # Button that show basic information of a Pokemon
  class TeamButton < SpriteStack
    # Get the Item text to perform specific operations
    # @return [SymText]
    attr_reader :item_text
    # List of the Y coordinate of the button (index % 6), relative to the contents definition !
    CoordinatesY = [0, 24, 64, 88, 128, 152]
    # List of the X coordinate of the button (index % 2), relative to the contents definition !
    CoordinatesX = [0, 160]
    # List of the Y coordinate of the background textures
    TextureBackgroundY = [0, 56, 112, 168]
    # Height of the background texture
    TextureBackgroundHeight = 56
    # Get the selected state of the sprite
    # @return [Boolean]
    attr_reader :selected
    # Create a new Team button
    # @param viewport [Viewport] viewport where to show the button
    # @param index [Integer] Index of the button in the team
    def initialize(viewport, index)
    end
    # Set the data of the SpriteStack
    # @param data [PFM::Pokemon]
    def data=(data)
    end
    # Update the background according to the selected state
    def update_background
    end
    # Set the selected state of the sprite
    # @param v [Boolean]
    def selected=(v)
    end
    # Show the item name
    def show_item_name
    end
    # Hide the item name
    def hide_item_name
    end
    # Refresh the button
    def refresh
    end
    # Update the graphics
    def update_graphics
    end
    private
    def update_item_text_visibility
    end
    def initial_coordinates
    end
    def create_sprites
    end
    # Position adjustment
    def fix_initial_position_cause_dev_is_lazy
    end
    # Return the background name
    # @return [String] name of the background
    def background_name
    end
    # Create the HP Bar for the pokemon
    # @return [UI::Bar]
    def create_hp_bar
    end
  end
end
module GamePlay
  # Module defining the IO of the PartyMenu
  module PartyMenuMixin
    # Return data of the Party Menu
    # @return [Integer]
    attr_accessor :return_data
    # Return the skill process to call
    # @return [Array(Proc, PFM::Pokemon, PFM::Skill), Proc, nil]
    attr_accessor :call_skill_process
    # Tell if a Pokemon was selected
    # @return [Boolean]
    def pokemon_selected?
    end
    # Tell if a party was selected
    # @return [Boolean]
    def party_selected?
    end
    # Get all the selected Pokemon
    # @return [Array<PFM::Pokemon>]
    def selected_pokemons
    end
  end
  # Class that display the Party Menu interface and manage user inputs
  #
  # This class has several modes
  #   - :map => Used to select a Pokemon in order to perform stuff
  #   - :menu => The normal mode when opening this interface from the menu
  #   - :battle => Select a Pokemon to send to battle
  #   - :item => Select a Pokemon in order to use an item on it (require extend data : hash)
  #   - :hold => Give an item to the Pokemon (requires extend data : item_id)
  #   - :select => Select a number of Pokemon for a temporary team.
  #     (Number defined by $game_variables[6] and possible list of excluded Pokemon requires extend data : array)
  #
  # This class can also show an other party than the player party,
  # the party paramter is an array of Pokemon upto 6 Pokemon
  class Party_Menu < BaseCleanUpdate::FrameBalanced
    include PartyMenuMixin
    # Color mapping for the result of on_creature_choice
    ON_POKEMON_CHOICE_COLOR_MAPPING = {true => 1, false => 2, nil => 3}
    # Message mapping for the result of on_creature_choice in apt detect
    ON_POKEMON_CHOICE_MESSAGE_MAPPING = {true => 143, false => 144, nil => 142}
    # Selector Rect info
    # @return [Array]
    SelectorRect = [[0, 0, 132, 52], [0, 64, 132, 52]]
    # Height of the frame Image to actually display (to prevent button from being hidden / shadowed).
    # Set nil to keep the full height
    FRAME_HEIGHT = 214
    # Create a new Party_Menu
    # @param party [Array<PFM::Pokemon>] list of Pokemon in the party
    # @param mode [Symbol] :map => from map (select), :menu => from menu, :battle => from Battle, :item => Use an item,
    #                      :hold => Hold an item, :choice => processing a choice related proc (do not use)
    # @param extend_data [Integer, PFM::ItemDescriptor::Wrapper, Array, Symbol] extend_data informations
    # @param no_leave [Boolean] tells the interface to disallow leaving without choosing
    def initialize(party, mode = :map, extend_data = nil, no_leave: false)
    end
    # Update the inputs
    def update_inputs
    end
    # Update the mouse
    # @param _moved [Boolean] if the mouse moved
    def update_mouse(_moved)
    end
    # Update the scene graphics during an animation or something else
    def update_graphics
    end
    alias update_during_process update_graphics
    private
    # Create the UI graphics
    def create_graphics
    end
    # Create the base UI
    def create_base_ui
    end
    # Retrieve the button texts according to the mode
    # @return [Array<String>]
    def button_texts
    end
    # Adjust the button display
    def auto_adjust_button
    end
    # Create the frame sprites
    def create_frames
    end
    # Create the team buttons
    def create_team_buttons
    end
    # Create the selector
    def create_selector
    end
    # Initialize the win_text according to the mode
    def init_win_text
    end
    # Function that update the team button when extend_data is correct
    def extend_data_button_update
    end
    # Function that updates the text displayed in the team button when in :select mode
    def select_pokemon_button_update
    end
    # Update the selector
    def update_selector
    end
    # Show the item name
    def show_item_name
    end
    # Hide the item name
    def hide_item_name
    end
    # Show the black frame for the currently selected Pokemon
    def show_black_frame
    end
    # Hide the black frame for the currently selected Pokemon
    def hide_black_frame
    end
    # Fix special characters used in some Studio texts
    def fix_number(string)
    end
    # Refresh all team buttons, update the selector and reset the index to 0
    def refresh_team_buttons
    end
    public
    # Array of actions to do according to the pressed button
    Actions = %i[action_A action_X action_Y action_B]
    # Action triggered when A is pressed
    def action_A
    end
    # Action when A is pressed and the mode is menu
    def action_A_menu
    end
    # Action triggered when B is pressed
    def action_B
    end
    # Function that detect no_leave and forbit the B action to process
    # @return [Boolean] true = no leave, false = process normally
    def no_leave_B
    end
    # Action triggered when X is pressed
    def action_X
    end
    # Action triggered when Y is pressed
    def action_Y
    end
    # Update the mouse interaction with the ctrl buttons
    def update_mouse_ctrl
    end
    # Update the movement of the Cursor
    def update_selector_move
    end
    # Update the movement of the selector with the mouse
    def update_mouse_selector_move
    end
    # Update the selector coordinates
    def update_selector_coordinates(*)
    end
    # Select the current pokemon to move with an other pokemon
    def action_move_current_pokemon
    end
    public
    include Util::GiveTakeItem
    # List of all choice method to call according to the current mode
    CHOICE_METHODS = {menu: :show_menu_mode_choice, choice: :show_choice_mode_choice, battle: :show_battle_mode_choice, item: :show_item_mode_choice, hold: :show_hold_mode_choice, select: :show_select_mode_choice, absofusion: :process_absofusion_mode, separate: :process_separate_mode}
    # Show the proper choice
    def show_choice
    end
    # Return the skill color
    # @return [Integer]
    def skill_color
    end
    # Show the choice when party is in mode :menu
    def show_menu_mode_choice
    end
    # Update the scene during a choice
    # @param choices [PFM::Choice_Helper] choice interface to be able to cancel
    def update_menu_choice(choices)
    end
    # Return the choice coordinates according to the current selected Pokemon
    # @param choices [PFM::Choice_Helper] choice interface to be able to cancel
    # @return [Array(Integer, Integer)]
    def get_choice_coordinates(choices)
    end
    # Action of using a move of the current Pokemon
    # @param move_index [Integer] index of the move in the Pokemon moveset
    def use_pokemon_skill(move_index)
    end
    # Action of launching the Pokemon Summary
    # @param mode [Symbol] mode used to launch the summary
    # @param extend_data [PFM::ItemDescriptor::Wrapper, nil] the extended data used to launch the summary
    def launch_summary(mode = :view, extend_data = nil)
    end
    # Action of launching the Pokemon Reminder
    # @param mode [Integer] mode used to launch the reminder
    def launch_reminder(mode = 0)
    end
    # Action of deselecting the follower
    def deselect_follower
    end
    # Action of selecting the follower
    def select_follower
    end
    # Action of giving an item to the Pokemon
    # @param item2 [Integer] id of the item to give
    # @note if item2 is -1 it'll call the Bag interface to get the item
    def give_item(item2 = -1)
    end
    # Action of taking the item from the Pokemon
    def take_item
    end
    # Method telling if the Pokemon has no item or not
    # @return [Boolean]
    def current_pokemon_has_no_item
    end
    # Show the choice when the party is in mode :battle
    def show_battle_mode_choice
    end
    # When the player want to send a specific Pokemon to battle
    def on_send_pokemon
    end
    # Show the choice when the party is in mode :choice
    def show_choice_mode_choice
    end
    # Event that triggers when the player choose on which pokemon to apply the move
    def on_skill_choice
    end
    # Show the choice when the party is in mode :item
    def show_item_mode_choice
    end
    # Event that triggers when the player choose on which pokemon to use the item
    def on_item_use_choice
    end
    # Show the choice when the party is in mode :hold
    def show_hold_mode_choice
    end
    # Event that triggers when the player choose on which pokemon to give the item
    def on_item_give_choice
    end
    # Show the choice when the party is in mode :select
    def show_select_mode_choice
    end
    # Event that triggers when a Pokemon is selected in :select mode
    def on_select
    end
    # Check if the temporary team contains the right number of Pokemon
    # @param caller [Symbol] used to determine the caller of the method
    # return Boolean
    def enough_pokemon?(caller = :validate)
    end
    # Check if the $game_variables[6]'s value is between 1 and 6
    # If not, call action_B to exit to map
    # return Boolean
    def check_select_mon_var
    end
    # Show the choice when the party is in mode :map
    def show_map_mode_choice
    end
    # Event that triggers when the player has choosen a Pokemon
    def on_map_choice
    end
    # Process the switch between two pokemon
    def process_switch
    end
    # Process the switch between the items of two pokemon
    def process_item_switch
    end
    # Process the fusion when the party is in mode :absofusion
    def process_absofusion_mode
    end
    # Process the separation when the party is in mode :separate
    def process_separate_mode
    end
  end
  # Scene displaying the Summary of a Pokemon
  class Summary < BaseCleanUpdate::FrameBalanced
    # @return [Integer] Last state index in this scene
    LAST_STATE = 2
    # Array of Key to press
    KEYS = [%i[DOWN LEFT RIGHT B], %i[DOWN LEFT RIGHT B], %i[A LEFT RIGHT B], %i[A LEFT RIGHT B], %i[A LEFT RIGHT B], %i[A LEFT RIGHT B]]
    # Text base indexes in the file
    TEXT_INDEXES = [[112, 113, 114, 115], [112, 116, 113, 115], [117, 114, 116, 115], [118, nil, nil, 13], [119, nil, nil, 13], [nil, nil, nil, 13]]
    # @return [Integer] Index of the choosen skill of the Pokemon
    attr_accessor :skill_selected
    # Create a new sumarry Interface
    # @param pokemon [PFM::Pokemon] Pokemon currently shown
    # @param mode [Symbol] :view if it's about viewing a Pokemon, :skill if it's about choosing the skill of the Pokemon
    # @param party [Array<PFM::Pokemon>] the party (allowing to switch Pokemon)
    # @param extend_data [PFM::ItemDescriptor::Wrapper, nil] the extend data information when we are in :skill mode
    def initialize(pokemon, mode = :view, party = [pokemon], extend_data = nil)
    end
    private
    # Create all the UI of the scene & set their default content
    def create_graphics
    end
    # Create the generic base
    def create_base
    end
    # Create the various UI
    def create_uis
    end
    # Create the top UI
    def create_top_ui
    end
    # Initialize the win_text according to the mode
    def init_win_text
    end
    # Update the UI visibility according to the index
    def update_ui_visibility
    end
    # Update the Pokemon shown in the UIs
    def update_pokemon
    end
    # Update the control button state
    def update_ctrl_state
    end
    # Retrieve the ID state of the ctrl button
    # @return [Integer] a number sent to @base_ui.mode to choose the texts to show
    def ctrl_id_state
    end
    # Load all the text for the scene
    # @return [Array<Array<String>>]
    def load_texts
    end
    public
    # Update the input interactions
    def update_inputs
    end
    # Update the graphics
    def update_graphics
    end
    # Update the mouse
    # @param _moved [Boolean] if the mouse moved during the current frame
    def update_mouse(_moved)
    end
    private
    # Update the inputs in skill mode
    def update_inputs_skill
    end
    # Perform the validation of the update_inputs_skills
    def update_inputs_skills_validation
    end
    # Update the move index from inputs
    def update_inputs_move_index
    end
    # Update the inputs in view mode
    def update_inputs_view
    end
    # Update the basic inputs
    # @param allow_up_down [Boolean] if the player can press UP / DOWN in this method
    # @return [Boolean] if a key was pressed
    def update_inputs_basic(allow_up_down = true)
    end
    # When the player wants to see another Pokemon
    def update_switch_pokemon
    end
    # Update when we are in the move section
    def update_inputs_skill_ui
    end
    # Perform the task to do when the player press A on the skill ui
    def update_input_a_skill_ui
    end
    public
    # Actions to do on the button according to the actual ID state of the buttons
    ACTIONS = [%i[mouse_next mouse_left mouse_right mouse_quit], %i[mouse_next mouse_left mouse_right mouse_quit], %i[mouse_a mouse_left mouse_right mouse_quit], %i[mouse_a object_id object_id mouse_cancel], %i[mouse_a object_id object_id mouse_cancel], %i[object_id object_id object_id mouse_quit]]
    # List of the translated coordinates that gives a new move index
    TRANSLATED_MOUSE_COORD_DETECTION = [[x02 = 8..21, y01 = 18..23], [x13 = 24..37, y01], [x02, y23 = 25..30], [x13, y23]]
    private
    # Update the mouse action inside the moves buttons
    def update_mouse_move_button
    end
    # Update the mouse action inside a move button
    # @param skill [UI::Summary_Skill] skill button
    # @param index [Integer] index of the button in the stack
    def update_mouse_in_skill_button(skill, index)
    end
    # Try to quick switch moves using the tiny buttons
    # @param skill [UI::Summary_Skill] skill button
    # @param index [Integer] index of the button in the stack
    def update_mouse_switch_skill(skill, index)
    end
    # Update the mouse interaction with the ctrl buttons
    def update_mouse_ctrl
    end
    # Action performed when the player press on the [A] button with the mouse
    def mouse_a
    end
    # Action performed when the player press on the [<] button with the mouse
    def mouse_left
    end
    # Action performed when the player press on the [>] button with the mouse
    def mouse_right
    end
    # Action performed when the player press on the [v] button with the mouse
    def mouse_next
    end
    # Action performed when the player press on the [B] quit button with the mouse
    def mouse_quit
    end
    # Action performed when the player press on the [B] cancel button with the mouse
    def mouse_cancel
    end
  end
end
GamePlay.party_menu_mixin = GamePlay::PartyMenuMixin
GamePlay.party_menu_class = GamePlay::Party_Menu
GamePlay.summary_class = GamePlay::Summary
