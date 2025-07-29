module PFM
  # The text parser of PSDK (retrieve text from Studio::Text)
  # @author Nuri Yuri
  module Text
    @variables = {}
    @plural = Array.new(7, false)
    # Pokemon Nickname var catcher
    PKNICK = Array.new(7) { |i| "[VAR PKNICK(000#{i})]" }
    # Pokemon name var catcher
    PKNAME = Array.new(7) { |i| "[VAR PKNAME(000#{i})]" }
    # Trainer name var catcher
    TRNAME = Array.new(7) { |i| "[VAR TRNAME(000#{i})]" }
    # Item var catcher
    ITEM2 = ['[VAR ITEM2(0000)]', '[VAR ITEM2(0001)]', '[VAR ITEM2(0002)]', '[VAR ITEM2(0003)]']
    # Definite article catcher
    ITEMPLUR1 = ['[VAR ITEMPLUR1]']
    # Move var catcher
    MOVE = ['[VAR MOVE(0000)]', '[VAR MOVE(0001)]', '[VAR MOVE(0002)]']
    # Number var catcher
    NUMB = [nil.to_s, '[VAR NUM1(0000)]', '[VAR NUM1(0001)]']
    # Number 3 var catcher
    NUM3 = ['[VAR NUM3(0000)]', '[VAR NUM3(0001)]', '[VAR NUM3(0002)]']
    # Number 2 var catcher
    NUM2 = ['[VAR NUM2(0000)]', '[VAR NUM2(0001)]', '[VAR NUM2(0002)]', '[VAR NUM2(0003)]']
    # Number 7 var catcher regexp
    NUM7R = /\[VAR NUM7[^\]]*\]/
    # Number x var catcher regexp
    NUMXR = /\[VAR NUM.[^\]]*\]/
    # Berry var catcher
    BERRY = [nil.to_s, nil.to_s, nil.to_s, nil.to_s, nil.to_s, nil.to_s, nil.to_s, '[VAR BERRY(0007)]']
    # Color var catcher
    COLOR = ['[VAR COLOR(0000)]', '[VAR COLOR(0001)]', '[VAR COLOR(0002)]', '[VAR COLOR(0003)]']
    # Location var catcher
    LOCATION = ['[VAR LOCATION(0000)]', '[VAR LOCATION(0001)]', '[VAR LOCATION(0002)]', '[VAR LOCATION(0003)]', '[VAR LOCATION(0004)]']
    # Ability var catcher
    ABILITY = ['[VAR ABILITY(0002)]', '[VAR ABILITY(0001)]', '[VAR ABILITY(0002)]']
    # Kaphotics decoded var clean regexp
    KAPHOTICS_Clean = /\[VAR [^\]]+\]/
    # /\[VAR .[A-Z\,\(\)a-z0-9]+\]/
    # Nummeric branch regexp catcher
    NUMBRNCH_Reg = /\[VAR NUMBRNCH\(....,....\)\][^\[]+/
    # Gender branch regexp catcher
    GENDBR_Reg = /\[VAR GENDBR\(....,....\)\][^\[]+/
    # Bell detector
    BELL_Reg = /\[VAR BE05\(([0-9]+)\)\]/
    # TODO!
    # Empty string (remove stuff)
    S_Empty = nil.to_s
    # Non breaking space '!' detector
    NBSP_B = / !/
    # Non breaking space '!' remplacement
    NBSP_R = ' !'
    # Automatic replacement of ... with the correct char
    Dot = ['...', '…']
    # Automatic replacement of the $ with a non breaking space $
    Money = [' $', ' $']
    module_function
    # Define generic constants adder to an object (Get var catcher easier)
    # @param obj [Class] the object that will receive constants
    def define_const(obj)
    end
    # Parse a text from the text database with specific informations
    # @param file_id [Integer] ID of the text file
    # @param text_id [Integer] ID of the text in the file
    # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
    # @return [String] the text parsed and ready to be displayed
    def parse(file_id, text_id, additionnal_var = nil)
    end
    # Parse a text from the text database with specific informations and a pokemon
    # @param file_id [Integer] ID of the text file
    # @param text_id [Integer] ID of the text in the file
    # @param pokemon [PFM::Pokemon] pokemon that will introduce an offset on text_id (its name is also used)
    # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
    # @return [String] the text parsed and ready to be displayed
    def parse_with_pokemon(file_id, text_id, pokemon, additionnal_var = nil)
    end
    # Detect if a Pokemon is an enemy Pokemon
    # @param pokemon [PFM::PokemonBattler]
    # @return [Boolean]
    def enemy_pokemon?(pokemon)
    end
    # Parse a text from the text database with 2 pokemon & specific information
    # @param file_id [Integer] ID of the text file
    # @param text_id [Integer] ID of the text in the file
    # @param pokemon1 [PFM::Pokemon] pokemon we're talking about
    # @param pokemon2 [PFM::Pokemon] pokemon who originated the "problem" (eg. bind)
    # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
    # @return [String] the text parsed and ready to be displayed
    def parse_with_2pokemon(file_id, text_id, pokemon1, pokemon2, additionnal_var)
    end
    # Parse a text from the text database with specific informations and two Pokemon
    # @param file_id [Integer] ID of the text file
    # @param text_id [Integer] ID of the text in the file
    # @param pokemon [PFM::Pokemon] pokemon that will introduce an offset on text_id (its name is also used)
    # @param pokemon2 [PFM::Pokemon] second pokemon that will introduce an offset on text_id (its name is also used)
    # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
    # @return [String] the text parsed and ready to be displayed
    def parse_with_pokemons(file_id, text_id, pokemon, pokemon2, additionnal_var = nil)
    end
    # Parse the NUMBRNCH (pural)
    # @param text [String] text that will be parsed
    # @note Sorry for the code, when I did that I wasn't in the "clear" period ^^'
    def parse_numbrnch(text)
    end
    # Parse the GENDBR (gender of the player, I didn't see other case)
    # @param text [String] text that will be parsed
    # @note Sorry for the code, when I did that I wasn't in the "clear" period ^^'
    def parse_gendbr(text)
    end
    # Perform the rest of the automatic parse (factorization)
    # @param text [String] text that will be parsed
    def parse_rest_of_thing(text)
    end
    # Define an automatic var catcher with its value
    # @param expr [String, Regexp] the var catcher that is replaced by the value
    # @param value [String] the value that replace the expr
    def set_variable(expr, value)
    end
    # Remove an automatic var catcher with its value
    # @param expr [String, Regexp] the var catcher that is replaced by a value
    def unset_variable(expr)
    end
    # Remove every automatic var catcher defined
    def reset_variables
    end
    # Set the numbranches to plural state
    # @param value_or_index [Integer, Boolean] the value for all branch or the index you want to set in pural
    # @param value [Boolean] the value when you choosed an index
    def set_plural(value_or_index = true, value = true)
    end
    # The \\ temporary replacement
    S_000 = "\x00"
    # Parse a string for a message
    # @param text [String] the message
    # @return [String] the parsed message
    def parse_string_for_messages(text)
    end
    # Detect a dialog text from message and return it instead of text
    # @param text [String]
    def detect_dialog(text)
    end
    # The InGame key name to their key value association
    GameKeys = {0 => 'KeyError', 'a' => :A, 'b' => :B, 'x' => :X, 'y' => :Y, 'l' => :L, 'r' => :R, 'l2' => :L2, 'r2' => :R2, 'select' => :SELECT, 'start' => :START, 'l3' => :L3, 'r3' => :R3, 'down' => :DOWN, 'left' => :LEFT, 'right' => :RIGHT, 'up' => :UP, 'home' => :HOME}
    # Return the real keyboard key name
    # @param name [String] the InGame key name
    # @return [String] the keyboard key name
    def get_key_name(name)
    end
    # Set the Pokemon Name variable
    # @param value [String, PFM::Pokemon]
    # @param index [Integer] index of the pkname variable
    def set_pkname(value, index = 0)
    end
    # Set the Pokemon Nickname variable
    # @param value [String, PFM::Pokemon]
    # @param index [Integer] index of the pknick variable
    def set_pknick(value, index = 0)
    end
    # Set the item name variable
    # @param value [String, Symbol, Integer]
    # @param index [Integer] index of the item variable
    def set_item_name(value, index = 0)
    end
    # Set the move name variable
    # @param value [String, Symbol, Integer]
    # @param index [Integer] index of the move variable
    def set_move_name(value, index = 0)
    end
    # Set the ability name variable
    # @param value [String, Symbol, Integer, PFM::Pokemon]
    # @param index [Integer] index of the move variable
    def set_ability_name(value, index = 0)
    end
    # Set the number1 variable
    # @param value [Integer, String]
    # @param index [Integer] index of the number1 variable
    def set_num1(value, index = 1)
    end
    # Set the number2 variable
    # @param value [Integer, String]
    # @param index [Integer] index of the number1 variable
    def set_num2(value, index = 0)
    end
    # Set the number2 variable
    # @param value [Integer, String]
    # @param index [Integer] index of the number1 variable
    def set_num3(value, index = 0)
    end
  end
  # Class that help to make choice inside Interfaces
  class Choice_Helper
    # Create a new Choice_Helper
    # @param klass [Class] class used to display the choice
    # @param can_cancel [Boolean] if the user can cancel the choice
    # @param cancel_index [Integer, nil] Index returned if the user cancel
    def initialize(klass, can_cancel = true, cancel_index = nil)
    end
    # Return the number of choices (for calculation)
    # @return [Integer]
    def size
    end
    # Cancel the choice from outside
    def cancel
    end
    # Register a choice
    # @param text [String]
    # @param disable_detect [#call, nil] handle to call to detect if the choice is disabled or not
    # @param on_validate [#call, nil] handle to call when the choice validated on this choice
    # @param color [Integer, nil] non default color to use on this choice
    # @param args [Array] arguments to send to the disable_detect and on_validate handler
    # @return [self]
    def register_choice(text, *args, disable_detect: nil, on_validate: nil, color: nil)
    end
    # Display the choice
    # @param viewport [Viewport] viewport in wich the choice is shown
    # @param x [Integer] x coordinate of the choice window
    # @param y [Integer] y coordinate of the choice window
    # @param width [Integer] width of the choice window
    # @param on_update [#call, nil] handle to call during choice update
    # @param align_right [Boolean] tell if the x/y coordinate are the top right coordinate of the choice
    # @param args [Array] argument to send to the on_update handle
    # @return [Integer] the choice made by the user
    def display_choice(viewport, x, y, width, *args, on_update: nil, align_right: false)
    end
    private
    # Build the choice window
    # @param viewport [Viewport] viewport in wich the choice is shown
    # @param x [Integer] x coordinate of the choice window
    # @param y [Integer] y coordinate of the choice window
    # @param width [Integer] width of the choice window
    # @param align_right [Boolean] tell if the x/y coordinate are the top right coordinate of the choice
    # @return [Yuki::ChoiceWindow]
    def build_choice_window(viewport, x, y, width, align_right)
    end
    # Check if the choice is validated (enabled and choosen by the player)
    # @param window [Choice_Window] the choice window
    def check_validate(window)
    end
    # Check if the choice is canceled by the user
    # @param window [Choice_Window] the choice window
    def check_cancel(window)
    end
    # Attempt to call the on_validate handle when the user has choosen an option
    # @param index [Integer] choice made by the user
    def call_validate_handle(index)
    end
  end
  # List of Processes that are called when a skill is used in map
  # Associate a skill id to a proc that take 3 parameter : pkmn(PFM::Pokemon), skill(PFM::Skill), test(Boolean)
  SKILL_PROCESS = {milk_drink: milk_drink = proc do |pkmn, _skill, test = false|
    next(:block) if pkmn.hp <= 0 && test
    next(:choice) if test
    if $actors[$scene.return_data] != pkmn && !pkmn.dead? && pkmn.hp != pkmn.max_hp
      heal_hp = pkmn.max_hp * 20 / 100
      $actors[$scene.return_data].hp -= heal_hp
      pkmn.hp += heal_hp
    else
      $scene.display_message(parse_text(22, 108))
    end
  end, soft_boiled: milk_drink, sweet_scent: proc do |_pkmn, _skill, test = false|
    next(false) if test
    if $env.normal?
      if $wild_battle.available?
        $game_system.map_interpreter.launch_common_event(Game_CommonEvent::WILD_BATTLE)
      else
        $scene.display_message(parse_text(39, 7))
      end
    else
      $scene.display_message(parse_text(39, 8))
    end
  end, fly: proc do |pkmn, _skill, test = false|
    next(false) if test
    if $game_switches[Yuki::Sw::Env_CanFly]
      GamePlay.open_town_map_to_fly($env.get_worldmap, pkmn)
      next(true)
    else
      next(:block)
    end
  end, surf: proc do |_pkmn, _skill, test = false|
    d = $game_player.direction
    x = $game_player.x
    y = $game_player.y
    z = $game_player.z
    new_x, new_y = $game_player.front_tile
    sys_tag = $game_map.system_tag(new_x, new_y)
    next(:block) unless $game_map.passable?(x, y, d, nil) && $game_map.passable?(new_x, new_y, 10 - d, $game_player) && z <= 1 && !$game_player.surfing? && Game_Character::SurfTag.include?(sys_tag)
    next(false) if test
    $game_temp.common_event_id = Game_CommonEvent::SURF_ENTER
    next(true)
  end}
  # The InGame Pokemon management
  # @author Nuri Yuri
  class Pokemon
    # List of chance to get a specific ability on Pokemon generation
    ABILITY_CHANCES = [49, 98, 100]
    # Unknown flag (should always be up in Pokemon)
    FLAG_UNKOWN_USE = 0x0080_0000
    # Flag telling the Pokemon comes from this game (this fangame)
    FLAG_FROM_THIS_GAME = 0x0040_0000
    # Flag telling the Pokemon has been caught by the player
    FLAG_CAUGHT_BY_PLAYER = 0x0020_0000
    # Flag telling the Pokemon comes from present time (used to distinguish pokemon imported from previous games)
    FLAG_PRESENT_TIME = 0x0010_0000
    # Flag that tells the Pokemon object to generate Shiny with IV starting at 15
    Shiny_IV = false
    # Create a new Pokemon with specific parameters
    # @param id [Integer, Symbol] ID of the Pokemon in the database
    # @param level [Integer] level of the Pokemon
    # @param force_shiny [Boolean] if the Pokemon have 100% chance to be shiny
    # @param no_shiny [Boolean] if the Pokemon have 0% chance to be shiny (override force_shiny)
    # @param form [Integer] Form index of the Pokemon (-1 = automatic generation)
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    # @option opts [String] :given_name Nickname of the Pokemon
    # @option opts [Integer, Symbol] :captured_with ID of the ball used to catch the Pokemon
    # @option opts [Integer] :captured_in ID of the zone where the Pokemon was caught
    # @option opts [Integer, Time] :captured_at Time when the Pokemon was caught
    # @option opts [Integer] :captured_level Level of the Pokemon when it was caught
    # @option opts [Integer] :egg_in ID of the zone where the egg was layed/found
    # @option opts [Integer, Time] :egg_at Time when the egg was layed/found
    # @option opts [Integer, String] :gender Forced gender of the Pokemon
    # @option opts [Integer] :nature Nature of the Pokemon
    # @option opts [Array<Integer>] :stats IV array ([hp, atk, dfe, spd, ats, dfs])
    # @option opts [Array<Integer>] :bonus EV array ([hp, atk, dfe, spd, ats, dfs])
    # @option opts [Integer, Symbol] :item ID of the item the Pokemon is holding
    # @option opts [Integer, Symbol] :ability ID of the ability the Pokemon has
    # @option opts [Integer] :rareness Rareness of the Pokemon (0 = not catchable, 255 = always catchable)
    # @option opts [Integer] :loyalty Happiness of the Pokemon
    # @option opts [Array<Integer, Symbol>] :moves Current Moves of the Pokemon (0 = default)
    # @option opts [Array(Integer, Integer)] :memo_text Text used for the memo ([file_id, text_id])
    # @option opts [String] :trainer_name Name of the trainer that caught / got the Pokemon
    # @option opts [Integer] :trainer_id ID of the trainer that caught / got the Pokemon
    def initialize(id, level, force_shiny = false, no_shiny = false, form = -1, opts = {})
    end
    # Initialize the egg process of the Pokemon
    # @param egg_how_obtained [Symbol] :reveived => When you received the egg (ex: Daycare), :found => When you found the egg (ex: On the map)
    def egg_init(egg_how_obtained = :received)
    end
    # Ends the egg process of the Pokemon
    def egg_finish
    end
    private
    # Method assigning the ID, level, shiny property
    # @param id [Integer, Symbol] ID of the Pokemon in the database
    # @param level [Integer] level of the Pokemon
    # @param force_shiny [Boolean] if the Pokemon have 100% chance to be shiny
    # @param no_shiny [Boolean] if the Pokemon have 0% chance to be shiny (override force_shiny)
    def primary_data_initialize(id, level, force_shiny, no_shiny)
    end
    # Code generation in order to get a shiny
    def code_initialize
    end
    # Number of attempt to generate a shiny
    # @return [Integer]
    def shiny_attempts
    end
    # Method that initialize the data related to caching
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def catch_data_initialize(opts)
    end
    # Method that initialize data related to form
    # @param form [Integer] Form index of the Pokemon (-1 = automatic generation)
    def form_data_initialize(form)
    end
    # Method that initialize the experience info of the Pokemon
    def exp_initialize
    end
    # Method that initialize the stat data
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def stat_data_initialize(opts)
    end
    # Method that initialize the EV data
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def ev_data_initialize(opts)
    end
    # Method that initialize the IV data
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def iv_data_initialize(opts)
    end
    # Method that initialize the move set
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def moves_initialize(opts)
    end
    # Method that initialize the held item
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def item_holding_initialize(opts)
    end
    # Method that initialize the ability
    # @param opts [Hash] Hash describing optional value you want to assign to the Pokemon
    def ability_initialize(opts)
    end
    public
    # ID of the Pokemon in the database
    # @return [Integer]
    attr_reader :id
    # Current Level of the Pokemon
    # @return [Integer]
    attr_reader :level
    # The total amount of exp the Pokemon got
    # @return [Integer]
    attr_accessor :exp
    # The current HP the Pokemon has
    # @return [Integer]
    attr_reader :hp
    # Code of the pokemon
    # @return [Integer]
    attr_accessor :code
    # Number of step before the egg hatch (thus the Pokemon is an egg)
    # @return [Integer]
    attr_accessor :step_remaining
    # ID of the item used to catch the Pokemon
    # @return [Integer]
    attr_accessor :captured_with
    # Zone (id) where the Pokemon was captured mixed with the Gemme 4.0 Flag
    # @return [Integer]
    attr_accessor :captured_in
    # Time when the Pokemon was captured (in seconds from jan 1970)
    # @return [Integer]
    attr_accessor :captured_at
    # Level of the Pokemon when the Pokemon was caught
    # @return [Integer]
    attr_accessor :captured_level
    # Zone (id) where the Egg has been obtained
    # @return [Integer]
    attr_accessor :egg_in
    # Time when the Egg has been obtained
    # @return [Integer]
    attr_accessor :egg_at
    # How the egg was obtained
    # @return [Symbol]
    attr_reader :egg_how_obtained
    # ID of the original trainer
    # @return [Integer]
    attr_writer :trainer_id
    # Name of the original trainer
    # @return [String]
    attr_accessor :trainer_name
    # The name given to the Pokemon
    # @return [String]
    attr_accessor :given_name
    # Gender of the Pokemon : 0 = no gender, 1 = male, 2 = female
    # @return [Integer]
    attr_reader :gender
    # Happiness/loyalty of the Pokemon (0 no bonds, 255 full bonds)
    # @return [Integer]
    attr_reader :loyalty
    # Form Index of the Pokemon, ex: Unkown A = 0, Unkown Z = 25
    # @return [Integer]
    attr_reader :form
    # HP Effort Value
    # @return [Integer]
    attr_accessor :ev_hp
    # ATK Effort Value
    # @return [Integer]
    attr_accessor :ev_atk
    # DFE Effort Value
    # @return [Integer]
    attr_accessor :ev_dfe
    # SPD Effort Value
    # @return [Integer]
    attr_accessor :ev_spd
    # ATS Effort Value
    # @return [Integer]
    attr_accessor :ev_ats
    # DFS Effort Value
    # @return [Integer]
    attr_accessor :ev_dfs
    # HP Individual Value
    # @return [Integer]
    attr_accessor :iv_hp
    # ATK Individual Value
    # @return [Integer]
    attr_accessor :iv_atk
    # DFE Individual Value
    # @return [Integer]
    attr_accessor :iv_dfe
    # SPD Individual Value
    # @return [Integer]
    attr_accessor :iv_spd
    # ATS Individual Value
    # @return [Integer]
    attr_accessor :iv_ats
    # DFS Individual Value
    # @return [Integer]
    attr_accessor :iv_dfs
    # ID of the Pokemon's nature (in the database)
    # @return [Integer]
    attr_writer :nature
    # The rate of HP the Pokemon has
    # @return [Float]
    attr_accessor :hp_rate
    # The rate of exp point the Pokemon has in its level
    # @return [Float]
    attr_accessor :exp_rate
    # ID of the item the Pokemon is holding
    # @return [Integer]
    attr_accessor :item_holding
    # First type ID of the Pokemon
    # @return [Integer]
    attr_writer :type1
    # Second type ID of the Pokemon
    # @return [Integer]
    attr_writer :type2
    # Third type ID of the Pokemon (moves/Mega)
    # @return [Integer]
    attr_writer :type3
    # Character filename of the Pokemon (FollowMe optimizations)
    # @return [String]
    attr_accessor :character
    # Memo text [file_id, text_id]
    # @return [Array<Integer>]
    attr_accessor :memo_text
    # List of Ribbon ID the Pokemon got
    # @return [Array<Integer>]
    attr_accessor :ribbons
    # List of Skill id the Pokemon learnt during its life
    # @return [Array<Integer>]
    attr_reader :skill_learnt
    # The current moveset of the Pokemon
    # @return [Array<PFM::Skill>] 4 or less moves
    attr_accessor :skills_set
    # Check whether the ability has been already used in battle
    # @return [Boolean]
    attr_accessor :ability_used
    # ID of the Pokemon ability in the database
    # @return [Integer]
    attr_writer :ability
    # Index of the ability in the Pokemon data
    # @return [Integer, nil]
    attr_accessor :ability_index
    # ID of the status of the Pokemon
    # @return [Integer]
    attr_accessor :status
    # Internal status counter that helps some status to terminate or worsen
    # @return [Integer]
    attr_accessor :status_count
    # The battle Stage of the Pokemon [atk, dfe, spd, ats, dfs, eva, acc]
    # @return [Array(Integer, Integer, Integer, Integer, Integer, Integer, Integer)]
    attr_accessor :battle_stage
    # The Pokemon critical modifier (always 0 but usable for scenaristic reasons...)
    # @return [Integer]
    attr_writer :critical_modifier
    def critical_modifier
    end
    # The position in the Battle, > 0 = actor, < 0 = enemy (index = -position-1), nil = not fighting
    # @return [Integer, nil]
    attr_accessor :position
    # If the pokemon is confused
    # @return [Boolean]
    attr_accessor :confuse
    # Number of turn the Pokemon has fought
    # @return [Integer]
    attr_accessor :battle_turns
    # Attack order value tells when the Pokemon attacks (used to test if attack before another pokemon)
    # @return [Integer]
    attr_accessor :attack_order
    # ID of the skill the Pokemon would like to use
    # @return [Integer]
    attr_accessor :prepared_skill
    # Real id of the Pokemon when used transform
    # @return [Integer, nil]
    attr_accessor :sub_id
    # Real code of the Pokemon when used transform (needed to test if roaming pokemon is ditto)
    # @return [Integer, nil]
    attr_accessor :sub_code
    # Real form index of the Pokemon when used transform (needed to test if roaming pokemon is ditto)
    # @return [Integer, nil]
    attr_accessor :sub_form
    # ID of the item the Pokemon is holding in battle
    # @return [Integer, nil]
    attr_accessor :battle_item
    # Various data information of the item during battle
    # @return [Array, nil]
    attr_accessor :battle_item_data
    # Get the primary data of the Pokemon
    # @return [Studio::CreatureForm]
    def primary_data
    end
    # Get the current data of the Pokemon
    # @return [Studio::CreatureForm]
    def data
    end
    alias get_data data
    # Give the maximum level of the Pokemon
    # @return [Integer]
    def max_level
    end
    # Set the maximum level of the Pokemon
    # @param level [Integer, nil]
    def max_level=(level)
    end
    # Get the shiny attribute
    # @return [Boolean]
    def shiny?
    end
    alias shiny shiny?
    # Set the shiny attribut
    # @param shiny [Boolean]
    def shiny=(shiny)
    end
    # Give the shiny rate for the Pokemon, The number should be between 0 & 0xFFFF.
    # 0 means absolutely no chance to be shiny, 0xFFFF means always shiny
    # @return [Integer]
    def shiny_rate
    end
    # Return the db_symbol of the Pokemon in the database
    # @return [Symbol]
    def db_symbol
    end
    # Tell if the Pokemon is an egg or not
    # @return [Boolean]
    def egg?
    end
    alias egg egg?
    # Set the captured_in flags (to know from which game the pokemon came from)
    # @param flag [Integer] the new flag
    def flags=(flag)
    end
    # Get Pokemon flags
    # @return [Integer]
    def flags
    end
    # Tell if the pokemon is from a past version
    # @return [Boolean]
    def from_past?
    end
    # Tell if the Pokemon is caught by the trainer
    # @return [Boolean]
    def caught_by_player?
    end
    # Get the zone id where the Pokemon has been found
    # @param special_zone [Integer, nil] if you want to use this function for stuff like egg_zone_id
    def zone_id(special_zone = nil)
    end
    # Set the gender of the Pokemon
    # @param gender [Integer]
    def gender=(gender)
    end
    alias set_gender gender=
    # Tell if the Pokemon is genderless
    # @return [Boolean]
    def genderless?
    end
    # Tell if the Pokemon is a male
    # @return [Boolean]
    def male?
    end
    # Tell if the Pokemon is a female
    # @return [Boolean]
    def female?
    end
    # Change the Pokemon Loyalty
    # @param loyalty [Integer] new loyalty value
    def loyalty=(loyalty)
    end
    # Return the nature data of the Pokemon
    # @return [Array<Integer>] [text_id, atk%, dfe%, spd%, ats%, dfs%]
    def nature
    end
    # Return the nature id of the Pokemon
    # @return [Integer]
    def nature_id
    end
    # Return the Pokemon rareness
    # @return [Integer]
    def rareness
    end
    # Change the Pokemon rareness
    # @param v [Integer, nil] the new rareness of the Pokemon
    def rareness=(v)
    end
    # Return the height of the Pokemon
    # @return [Numeric]
    def height
    end
    # Return the weight of the Pokemon
    # @return [Numeric]
    def weight
    end
    # Return the ball sprite name of the Pokemon
    # @return [String] Sprite to load in Graphics/ball/
    def ball_sprite
    end
    # Return the ball color of the Pokemon (flash)
    # @return [Color]
    def ball_color
    end
    # Return the normalized trainer id of the Pokemon
    # @return [Integer]
    def trainer_id
    end
    # Return if the Pokemon is from the player (he caught it)
    # @return [Boolean]
    def from_player?
    end
    # Return the db_symbol of the Pokemon's item held
    # @return [Symbol]
    def item_db_symbol
    end
    # Alias for item_holding
    # @return [Integer]
    def item_hold
    end
    # Return the current ability of the Pokemon
    # @return [Integer]
    def ability
    end
    # Return the db_symbol of the Pokemon's Ability
    # @return [Symbol]
    def ability_db_symbol
    end
    # Add a ribbon to the Pokemon
    # @param id [Integer] ID of the ribbon (in the ribbon text file)
    def add_ribbon(id)
    end
    # Has the pokemon got a ribbon ?
    # @return [Boolean]
    def ribbon_got?(id)
    end
    public
    # All possible attempt of finding an egg (for legacy)
    # @todo Change this later
    EGG_FILENAMES = ['egg_%<id>03d_%<form>02d', 'egg_%<id>03d', 'egg_%<name>s_%<form>02d', 'egg_%<name>s', 'egg']
    # Size of a battler
    BATTLER_SIZE = 96
    # Size of an icon
    ICON_SIZE = 32
    # Size of a footprint
    FOOT_SIZE = 16
    # Return the ball image of the Pokemon
    # @return [Texture]
    def ball_image
    end
    class << self
      # Icon filename of a Pokemon
      # @param id [Integer] ID of the Pokemon
      # @param form [Integer] form index of the Pokemon
      # @param female [Boolean] if the Pokemon is a female
      # @param shiny [Boolean] shiny state of the Pokemon
      # @param egg [Boolean] egg state of the Pokemon
      # @return [String]
      def icon_filename(id, form, female, shiny, egg)
      end
      # Return the front battler name
      # @param id [Integer] ID of the Pokemon
      # @param form [Integer] form index of the Pokemon
      # @param female [Boolean] if the Pokemon is a female
      # @param shiny [Boolean] shiny state of the Pokemon
      # @param egg [Boolean] egg state of the Pokemon
      # @return [String]
      def front_filename(id, form, female, shiny, egg)
      end
      # Return the front gif name
      # @param id [Integer] ID of the Pokemon
      # @param form [Integer] form index of the Pokemon
      # @param female [Boolean] if the Pokemon is a female
      # @param shiny [Boolean] shiny state of the Pokemon
      # @param egg [Boolean] egg state of the Pokemon
      # @return [String, nil]
      def front_gif_filename(id, form, female, shiny, egg)
      end
      # Return the back battler name
      # @param id [Integer] ID of the Pokemon
      # @param form [Integer] form index of the Pokemon
      # @param female [Boolean] if the Pokemon is a female
      # @param shiny [Boolean] shiny state of the Pokemon
      # @param egg [Boolean] egg state of the Pokemon
      # @return [String]
      def back_filename(id, form, female, shiny, egg)
      end
      # Return the back gif name
      # @param id [Integer] ID of the Pokemon
      # @param form [Integer] form index of the Pokemon
      # @param female [Boolean] if the Pokemon is a female
      # @param shiny [Boolean] shiny state of the Pokemon
      # @param egg [Boolean] egg state of the Pokemon
      # @return [String, nil]
      def back_gif_filename(id, form, female, shiny, egg)
      end
      # Display an error in case of missing resources and fallback to the default one
      # @param id [Integer, Symbol] ID of the Pokemon
      # @return [String]
      def missing_resources_error(id)
      end
      private
      # Find the correct filename in a collection (for legacy egg sprites checks)
      # @param formats [Array<String>]
      # @param format_arg [Hash]
      # @param cache_exist [Method, Proc]
      # @return [String, nil] formated filename if it exists
      def correct_filename_from(formats, format_arg, cache_exist)
      end
      # Check if the filename exists in the cache
      # @param filename [String]
      # @param cache_exist [Method, Proc]
      # @return [String, nil] filename if it exists
      def filename_exist(filename, cache_exist)
      end
    end
    # Return the icon of the Pokemon
    # @return [Texture]
    def icon
    end
    # Return the front battler of the Pokemon
    # @return [Texture]
    def battler_face
    end
    alias battler_front battler_face
    # Return the back battle of the Pokemon
    # @return [Texture]
    def battler_back
    end
    # Return the front offset y of the Pokemon
    # @return [Integer]
    def front_offset_y
    end
    # Return the character name of the Pokemon
    # @return [String]
    def character_name
    end
    # Return the cry file name of the Pokemon
    # @return [String]
    def cry
    end
    # Return the GifReader face of the Pokemon
    # @return [::Yuki::GifReader, nil]
    def gif_face
    end
    # Return the GifReader back of the Pokemon
    # @return [::Yuki::GifReader, nil]
    def gif_back
    end
    public
    # Return the list of EV the pokemon gives when beaten
    # @return [Array<Integer>] ev list (used in bonus functions) : [hp, atk, dfe, spd, ats, dfs]
    def battle_list
    end
    # Add ev bonus to a Pokemon (with item interaction : x2)
    # @param list [Array<Integer>] an ev list  : [hp, atk, dfe, spd, ats, dfs]
    # @return [Boolean, nil] if the ev had totally been added or not (nil = couldn't be added at all)
    def add_bonus(list)
    end
    # Add ev bonus to a Pokemon (without item interaction)
    # @param list [Array<Integer>] an ev list  : [hp, atk, dfe, spd, ats, dfs]
    # @return [Boolean, nil] if the ev had totally been added or not (nil = couldn't be added at all)
    def edit_bonus(list)
    end
    # Return the total amount of EV
    # @return [Integer]
    def total_ev
    end
    # Automatic ev adder using an index
    # @param index [Integer] ev index (see GameData::EV), should add 10. If index > 10 take index % 10 and add only 1 EV.
    # @param apply [Boolean] if the ev change is applied
    # @param count [Integer] number of EV to add
    # @return [Integer, false] if not false, the value of the current EV depending on the index
    def ev_check(index, apply = false, count = 1)
    end
    # Get and add EV
    # @param index [Integer] ev index (see GameData::EV)
    # @param evs [Integer] the total ev
    # @param value [Integer] the quantity of EV to add (if 0 no add)
    # @return [Integer]
    def ev_var(index, evs, value = 0)
    end
    # Safely add HP EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_hp(n, evs)
    end
    # Safely add ATK EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_atk(n, evs)
    end
    # Safely add DFE EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_dfe(n, evs)
    end
    # Safely add SPD EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_spd(n, evs)
    end
    # Safely add ATS EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_ats(n, evs)
    end
    # Safely add DFS EV
    # @param n [Integer] amount of EV to add
    # @param evs [Integer] total ev
    # @return [Boolean] if the ev has successfully been added
    def add_ev_dfs(n, evs)
    end
    public
    include Hooks
    # List of key in evolution Hash that corresponds to the expected ID when evolution is valid
    # @return [Array<Symbol>]
    SPECIAL_EVOLUTION_ID = %i[trade id]
    @evolution_criteria = {}
    @evolution_reason_required_criteria = {}
    class << self
      # List of evolution criteria
      # @return [Hash{ Symbol => Proc }]
      attr_reader :evolution_criteria
      # List of evolution criteria required for specific reason
      # @return [Hash{ Symbol => Array<Symbol> }]
      attr_reader :evolution_reason_required_criteria
      # Add a new evolution criteria
      # @param key [Symbol] hash key expected in special evolution
      # @param reasons [Array<Symbol>] evolution reasons that require this criteria in order to allow evolution
      # @param block [Proc] executed proc for special evolution test, will receive : value, extend_data, reason
      def add_evolution_criteria(key, reasons = nil, &block)
      end
    end
    # Return the base experience of the Pokemon
    # @return [Integer]
    def base_exp
    end
    # Return the exp curve type ID
    # @return [Integer]
    def exp_type
    end
    # Return the exp curve
    # @return [ExpList]
    def exp_list
    end
    # Return the required total exp (so including old levels) to increase the Pokemon's level
    # @return [Integer]
    def exp_lvl
    end
    # Return the text of the amount of exp the pokemon needs to go to the next level
    # @return [String]
    def exp_remaining_text
    end
    # Return the text of the current pokemon experience
    # @return [String]
    def exp_text
    end
    # Change the Pokemon total exp
    # @param v [Integer] the new exp value
    def exp=(v)
    end
    # Increase the level of the Pokemon
    # @return [Boolean] if the level has successfully been increased
    def level_up
    end
    # Update the PFM::Pokemon loyalty
    def update_loyalty
    end
    # Generate the level up stat list for the level up window
    # @return [Array<Array<Integer>>] list0, list1 : old, new basis value
    def level_up_stat_refresh
    end
    # Show the level up window
    # @param list0 [Array<Integer>] old basis stat list
    # @param list1 [Array<Integer>] new basis stat list
    # @param z_level [Integer] z superiority of the Window
    def level_up_window_call(list0, list1, z_level)
    end
    # Change the level of the Pokemon
    # @param lvl [Integer] the new level of the Pokemon
    def level=(lvl)
    end
    # Check if the Pokemon can evolve and return the evolve id if possible
    # @param reason [Symbol] evolve check reason (:level_up, :trade, :stone)
    # @param extend_data [Hash, nil] extend_data generated by an item
    # @return [Array<Integer, nil>, false] if the Pokemon can evolve, the evolve id, otherwise false
    def evolve_check(reason = :level_up, extend_data = nil)
    end
    add_evolution_criteria(:tradeWith, [:tradeWith]) { |value, extend_data, reason| extend_data&.db_symbol == value && reason == :tradeWith }
    add_evolution_criteria(:minLevel) { |value| @level >= value.to_i }
    add_evolution_criteria(:maxLevel) { |value| @level <= value.to_i }
    add_evolution_criteria(:itemHold) { |value| value == item_db_symbol }
    add_evolution_criteria(:minLoyalty) { |value| @loyalty >= value.to_i }
    add_evolution_criteria(:maxLoyalty) { |value| @loyalty <= value.to_i }
    add_evolution_criteria(:skill1) { |value| skill_learnt?(value) }
    add_evolution_criteria(:skill2) { |value| skill_learnt?(value) }
    add_evolution_criteria(:skill3) { |value| skill_learnt?(value) }
    add_evolution_criteria(:skill4) { |value| skill_learnt?(value) }
    add_evolution_criteria(:weather) { |value| $env.current_weather_db_symbol == value }
    add_evolution_criteria(:env) { |value| $game_player.system_tag == value }
    add_evolution_criteria(:gender) { |value| @gender == value }
    add_evolution_criteria(:stone, [:stone]) { |value, extend_data, reason| reason == :stone && value == extend_data }
    add_evolution_criteria(:dayNight) { |value| value == $game_variables[Yuki::Var::TJN_Tone] }
    add_evolution_criteria(:func) { |value| send(value) }
    add_evolution_criteria(:maps) { |value| value.include?($game_map.map_id) }
    add_evolution_criteria(:trade, [:trade]) { |_value, _extend_data, reason| reason == :trade }
    add_evolution_criteria(:id) {true }
    add_evolution_criteria(:form) {true }
    add_evolution_criteria(:switch) { |value| $game_switches[value] }
    add_evolution_criteria(:nature) { |value| nature_id == value }
    add_evolution_criteria(:gemme) {false }
    # Method that actually make a Pokemon evolve
    # @param id [Integer] ID of the Pokemon that evolve
    # @param form [Integer, nil] form of the Pokemon that evolve
    def evolve(id, form)
    end
    Hooks.register(PFM::Pokemon, :evolution, 'Shedinja Evolution') do
      next unless id == 291 && $actors.size < 6 && $bag.contain_item?(4)
      munja = dup
      munja.id = 292
      munja.hp = munja.max_hp
      munja.item_holding = 0
      $actors << munja
      $bag.remove_item(4, 1)
      $pokedex.mark_seen(292, forced: true)
      $pokedex.mark_captured(292)
    end
    # Change the id of the Pokemon
    # @param new_id [Integer] the new id of the Pokemon
    def id=(new_id)
    end
    # Update the Pokemon Ability
    def update_ability
    end
    # Check evolve condition to evolve in Hitmonlee (kicklee)
    # @return [Boolean] if the condition is valid
    def elv_kicklee
    end
    # Check evolve condition to evolve in Hitmonchan (tygnon)
    # @return [Boolean] if the condition is valid
    def elv_tygnon
    end
    # Check evolve condition to evolve in Hitmontop (Kapoera)
    # @return [Boolean] if the condition is valid
    def elv_kapoera
    end
    # Check evolve condition to evolve in Silcoon (Armulys)
    # @return [Boolean] if the condition is valid
    def elv_armulys
    end
    # Check evolve condition to evolve in Cascoon (Blindalys)
    # @return [Boolean] if the condition is valid
    def elv_blindalys
    end
    # Check evolve condition to evolve in Mantine
    # @return [Boolean] if the condition is valid
    def elv_demanta
    end
    # Check evolve condition to evolve in Pangoro (Pandarbare)
    # @return [Boolean] if the condition is valid
    def elv_pandarbare
    end
    # Check evolve condition to evolve in Malamar (Sepiatroce)
    # @note uses :DOWN to validate the evolve condition
    # @return [Boolean] if the condition is valid
    def elv_sepiatroce
    end
    # Check evolve condition to evolve in Sylveon (Nymphali)
    # @return [Boolean] if the condition is valid
    def elv_nymphali
    end
    # Check evolve condition to evolve in Toxtricity-amped (Salarsen-aigüe)
    # [0, 2, 3, 4, 6, 8, 9, 11, 13, 14, 19, 22, 24]
    # return [Boolean] if the condition is valid
    def elv_toxtricity_amped
    end
    # Check evolve condition when not in Toxtricity-amped (Salarsen-aigüe)
    def elv_toxtricity_low_key
    end
    # Check evolve condition for 99% of creatures
    # @return [Boolean] if the condition is valid
    def elv_99percent
    end
    # Check evolve condition for 1% of creatures
    # @return [Boolean] if the condition is valid
    def elv_1percent
    end
    public
    # Helper class helping to get exp values based on each kind of equation
    class ExpList
      include Enumerable
      # List of method name per kind of exp
      KIND_TO_METHOD = %i[exp_fast exp_normal exp_slow exp_parabolic exp_eratic exp_fluctuating]
      # Create a new ExpList
      # @param kind [Integer] kind of exp
      def initialize(kind)
      end
      # Get the total amount of exp to level up to the level parameter
      # @param level [Integer]
      # @return [Integer]
      def [](level)
      end
      # Iterate over all the experience curve
      # @yieldparam total_exp [Integer] the total exp at the current level
      def each
      end
      # Get the size of the exp list table for this curve
      def size
      end
      private
      def exp_fast(level)
      end
      def exp_normal(level)
      end
      def exp_slow(level)
      end
      def exp_parabolic(level)
      end
      def exp_eratic(level)
      end
      def exp_fluctuating(level)
      end
    end
    public
    # List of form calibration hook for Creatures that needs form calibration (when switching items, being place in computer or when team changes)
    FORM_CALIBRATE = {}
    # List of form generation hook for Creatures that needs an initial form when the PFM::Pokemon object is generated.
    FORM_GENERATION = {}
    # List of items (in the form index order) that change the form of Arceus
    ArceusItem = %i[__undef__ flame_plate splash_plate zap_plate meadow_plate icicle_plate fist_plate toxic_plate earth_plate sky_plate mind_plate insect_plate stone_plate spooky_plate draco_plate iron_plate dread_plate pixie_plate]
    # List of items (in the form index order) that change the form of Genesect
    GenesectModules = %i[__undef__ burn_drive chill_drive douse_drive shock_drive]
    # List of item (in the form index oreder) that change the form of Silvally
    SilvallyROM = %i[__undef__ fighting_memory flying_memory poison_memory ground_memory rock_memory bug_memory ghost_memory steel_memory __undef__ fire_memory water_memory grass_memory electric_memory psychic_memory ice_memory dragon_memory dark_memory fairy_memory]
    # List of items (in the form index order) that change the form of Ogerpon
    OGERPONMASK = %i[__undef__ wellspring_mask hearthflame_mask cornerstone_mask]
    # Change the form of the Pokemon
    # @note If the form doesn't exist, the form is not changed
    # @param value [Integer] the new form index
    def form=(value)
    end
    # Check if the Pokemon can mega evolve
    # @return [Integer, false] form index if the Pokemon can mega evolve, false otherwise
    def can_mega_evolve?
    end
    # Mega evolve the Pokemon (if possible)
    def mega_evolve
    end
    # Reset the Pokemon to its normal form after mega evolution
    def unmega_evolve
    end
    # Is the Pokemon mega evolved ?
    def mega_evolved?
    end
    # Absofusion of the Pokemon (if possible)
    # @param pokemon PFM::Pokemon The Pokemon used in the fusion
    def absofusion(pokemon)
    end
    # Separate (if possible) the Pokemon and restore the Pokemon used in the fusion
    def separate
    end
    # If the Pokemon is a absofusion
    def absofusionned?
    end
    # Automatically generate the form index of the Pokemon
    # @note It calls the block stored in the hash FORM_GENERATION where the key is the Pokemon db_symbol
    # @param form [Integer] if form != 0 does not generate the form (protection)
    # @return [Integer] the form index
    def form_generation(form, old_value = nil)
    end
    # Automatically calibrate the form of the Pokemon
    # @note It calls the block stored in the hash FORM_CALIBRATE where the key is the Pokemon db_symbol &
    #   the block parameter is the reason. The block should change @form
    # @param reason [Symbol] what called form_calibrate (:menu, :evolve, :load, ...)
    # @return [Boolean] if the Pokemon's form has changed
    def form_calibrate(reason = :menu)
    end
    # Calculate the form of deerling & sawsbuck
    # @return [Integer] the right form
    def current_deerling_form
    end
    # Determine the form of Shaymin
    # @param reason [Symbol]
    def shaymin_form(reason)
    end
    # Determine the form of the Kyurem
    # @param [Symbol] reason The db_symbol of the Pokemon used for the fusion
    def kyurem_form(reason)
    end
    # Determine the form of the Necrozma
    # @param [Symbol] reason The db_symbol of the Pokemon used for the fusion
    def necrozma_form(reason)
    end
    # Determine the form of the Zygarde
    # @param reason [Symbol]
    # @return [Integer] form of zygarde
    def zygarde_form(reason)
    end
    # Determine the form of Cramorant
    # @param reason [Symbol]
    def cramorant_form(reason)
    end
    # Determine the form of the Calyrex
    # @param [Symbol] reason The db_symbol of the Pokemon used for the fusion
    def calyrex_form(reason)
    end
    # Determine the form of Castform
    # @param reason [Symbol]
    def castform_form(reason)
    end
    FORM_GENERATION[:unown] = proc {@form = @code % 28 }
    FORM_GENERATION[:burmy] = FORM_GENERATION[:wormadam] = proc do
      env = $env
      if env.building?
        next(@form = 2)
      else
        if env.grass? || env.tall_grass? || env.very_tall_grass?
          next(@form = 0)
        end
      end
      next(@form = 1)
    end
    FORM_GENERATION[:cherrim] = proc {@form = $env.sunny? || $env.hardsun? ? 1 : 0 }
    FORM_GENERATION[:deerling] = FORM_GENERATION[:sawsbuck] = proc {@form = current_deerling_form }
    FORM_GENERATION[:meowstic] = proc {@form = @gender == 2 ? 1 : 0 }
    FORM_CALIBRATE[:giratina] = proc {@form = item_db_symbol == :griseous_orb ? 1 : 0 }
    FORM_CALIBRATE[:arceus] = proc {@form = ArceusItem.index(item_db_symbol).to_i }
    FORM_CALIBRATE[:shaymin] = proc { |reason| @form = shaymin_form(reason) }
    FORM_CALIBRATE[:genesect] = proc {@form = GenesectModules.index(item_db_symbol).to_i }
    FORM_CALIBRATE[:silvally] = proc {@form = SilvallyROM.index(item_db_symbol).to_i }
    FORM_CALIBRATE[:deerling] = FORM_CALIBRATE[:sawsbuck] = proc {@form = current_deerling_form }
    FORM_CALIBRATE[:darmanitan] = proc { |reason| @form = hp_rate <= 0.5 && reason == :battle ? @form | 1 : @form & ~1 }
    FORM_CALIBRATE[:tornadus] = proc { |reason| @form = reason == :therian ? 1 : 0 }
    FORM_CALIBRATE[:thundurus] = proc { |reason| @form = reason == :therian ? 1 : 0 }
    FORM_CALIBRATE[:landorus] = proc { |reason| @form = reason == :therian ? 1 : 0 }
    FORM_CALIBRATE[:kyurem] = proc { |reason| @form = kyurem_form(reason) }
    FORM_CALIBRATE[:keldeo] = proc {@form = find_skill(:secret_sword) ? 1 : 0 }
    FORM_CALIBRATE[:meloetta] = proc { |reason| @form = reason == :dance ? 1 : 0 }
    FORM_CALIBRATE[:aegislash] = proc { |reason| @form = reason == :blade ? 0 : 1 }
    FORM_CALIBRATE[:necrozma] = proc { |reason| @form = necrozma_form(reason) }
    FORM_CALIBRATE[:mimikyu] = proc { |reason| @form = reason == :battle ? 1 : 0 }
    FORM_CALIBRATE[:eiscue] = proc { |reason| @form = reason == :battle ? 1 : 0 }
    FORM_CALIBRATE[:zacian] = proc {@form = item_db_symbol == :rusted_sword ? 1 : 0 }
    FORM_CALIBRATE[:zamazenta] = proc {@form = item_db_symbol == :rusted_shield ? 1 : 0 }
    FORM_CALIBRATE[:calyrex] = proc { |reason| @form = calyrex_form(reason) }
    FORM_CALIBRATE[:groudon] = proc {@form = item_db_symbol == :red_orb ? 1 : 0 }
    FORM_CALIBRATE[:kyogre] = proc {@form = item_db_symbol == :blue_orb ? 1 : 0 }
    FORM_CALIBRATE[:wishiwashi] = proc { |reason| @form = hp_rate >= 0.25 && level >= 20 && reason == :battle ? 1 : 0 }
    FORM_CALIBRATE[:minior] = proc { |reason| @form = hp_rate <= 0.5 && reason == :battle ? @form | 1 : 0 }
    FORM_CALIBRATE[:zygarde] = proc { |reason| @form = zygarde_form(reason) }
    FORM_CALIBRATE[:morpeko] = proc { |reason| @form = reason == :battle ? 1 : 0 }
    FORM_CALIBRATE[:greninja] = proc { |reason| @form = reason == :battle ? 1 : 0 }
    FORM_CALIBRATE[:cramorant] = proc { |reason| @form = cramorant_form(reason) }
    FORM_CALIBRATE[:palafin] = proc { |reason| @form = reason == :hero ? 1 : 0 }
    FORM_CALIBRATE[:castform] = proc { |reason| @form = castform_form(reason) }
    FORM_CALIBRATE[:ogerpon] = proc {@form = OGERPONMASK.index(item_db_symbol).to_i }
    public
    # Learn a new skill
    # @param db_symbol [Symbol] db_symbol of the move in the database
    # @return [Boolean, nil] true = learnt, false = already learnt, nil = couldn't learn
    def learn_skill(db_symbol)
    end
    # Forget a skill by its id
    # @param db_symbol [Symbol] db_symbol of the move in the database
    # @param delete_from_learnt [Boolean] if the skill should be deleted from the skill_learnt attribute of the Pokemon
    def forget_skill(db_symbol, delete_from_learnt: false)
    end
    # Swap the position of two skills in the skills_set
    # @param index1 [Integer] Index of the first skill to swap
    # @param index2 [Integer] Index of the second skill to swap
    def swap_skills_index(index1, index2)
    end
    # Replace the skill at a specific index
    # @param index [Integer] index of the skill to replace by a new skill
    # @param db_symbol [Symbol] db_symbol of the move in the database
    def replace_skill_index(index, db_symbol)
    end
    # Has the pokemon already learnt a skill ?
    # @param db_symbol [Symbol] db_symbol of the move
    # @param only_in_move_set [Boolean] if the function only check in the current move set
    # @return [Boolean]
    def skill_learnt?(db_symbol, only_in_move_set: true)
    end
    alias has_skill? skill_learnt?
    # Find a skill in the moveset of the Pokemon
    # @param db_symbol [Symbol] db_symbol of the skill in the database
    # @return [PFM::Skill, false]
    def find_skill(db_symbol)
    end
    # Check if the Pokemon can learn a new skill and make it learn the skill
    # @param silent [Boolean] if the skill is automatically learnt or not (false = show skill learn interface & messages)
    # @param level [Integer] The level to check in order to learn the moves (<= 0 = evolution)
    def check_skill_and_learn(silent = false, level = @level)
    end
    # Can learn skill at this level
    # @param level [Integer]
    def can_learn_skill_at_this_level?(level = @level)
    end
    # Check if the Pokemon can learn a skill
    # @param db_symbol [Integer, Symbol] id or db_symbol of the move
    # @return [Boolean, nil] nil = learnt, false = cannot learn, true = can learn
    def can_learn?(db_symbol)
    end
    # Get the list of all the skill the Pokemon can learn again
    # @param mode [Integer] Define the moves that can be learnt again :
    #   1 = breed_moves + learnt + potentially_learnt
    #   2 = all moves
    #   other = learnt + potentially_learnt
    # @return [Array<Symbol>]
    def remindable_skills(mode = 0)
    end
    # Load the skill from an Array
    # @param skills [Array] the skills array (containing IDs or Symbols)
    def load_skill_from_array(skills)
    end
    alias moveset skills_set
    public
    # Return the base HP
    # @return [Integer]
    def base_hp
    end
    # Return the base ATK
    # @return [Integer]
    def base_atk
    end
    # Return the base DFE
    # @return [Integer]
    def base_dfe
    end
    # Return the base SPD
    # @return [Integer]
    def base_spd
    end
    # Return the base ATS
    # @return [Integer]
    def base_ats
    end
    # Return the base DFS
    # @return [Integer]
    def base_dfs
    end
    # Return the max HP of the Pokemon
    # @return [Integer]
    def max_hp
    end
    # Return the current atk
    # @return [Integer]
    def atk
    end
    # Return the current dfe
    # @return [Integer]
    def dfe
    end
    # Return the current spd
    # @return [Integer]
    def spd
    end
    # Return the current ats
    # @return [Integer]
    def ats
    end
    # Return the current dfs
    # @return [Integer]
    def dfs
    end
    # Return the atk stage
    # @return [Integer]
    def atk_stage
    end
    # Return the dfe stage
    # @return [Integer]
    def dfe_stage
    end
    # Return the spd stage
    # @return [Integer]
    def spd_stage
    end
    # Return the ats stage
    # @return [Integer]
    def ats_stage
    end
    # Return the dfs stage
    # @return [Integer]
    def dfs_stage
    end
    # Return the evasion stage
    # @return [Integer]
    def eva_stage
    end
    # Return the accuracy stage
    # @return [Integer]
    def acc_stage
    end
    # Change a stat stage
    # @param stat_id [Integer] id of the stat : 0 = atk, 1 = dfe, 2 = spd, 3 = ats, 4 = dfs, 5 = eva, 6 = acc
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_stat(stat_id, amount)
    end
    # Change the atk stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_atk(amount)
    end
    # Change the dfe stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_dfe(amount)
    end
    # Change the spd stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_spd(amount)
    end
    # Change the ats stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_ats(amount)
    end
    # Change the dfs stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_dfs(amount)
    end
    # Change the eva stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_eva(amount)
    end
    # Change the acc stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_acc(amount)
    end
    # Return the stage modifier (multiplier)
    # @param stage [Integer] the value of the stage
    # @return [Float] the multiplier
    def modifier_stage(stage)
    end
    # Return the atk modifier
    # @return [Float] the multiplier
    def atk_modifier
    end
    # Return the dfe modifier
    # @return [Float] the multiplier
    def dfe_modifier
    end
    # Return the spd modifier
    # @return [Float] the multiplier
    def spd_modifier
    end
    # Return the ats modifier
    # @return [Float] the multiplier
    def ats_modifier
    end
    # Return the dfs modifier
    # @return [Float] the multiplier
    def dfs_modifier
    end
    # Change the IV and update the statistics
    # @param list [Array<Integer>] list of new IV [hp, atk, dfe, spd, ats, dfs]
    def dv_modifier(list)
    end
    # Get the adjusted IV
    # @param value [Integer] the new value
    # @param old [Integer] the old value
    # @return [Integer] something between old and 31 (value in most case)
    def get_dv_value(value, old)
    end
    # Return the atk stat without battle modifier
    # @return [Integer]
    def atk_basis
    end
    # Return the dfe stat without battle modifier
    # @return [Integer]
    def dfe_basis
    end
    # Return the spd stat without battle modifier
    # @return [Integer]
    def spd_basis
    end
    # Return the ats stat without battle modifier
    # @return [Integer]
    def ats_basis
    end
    # Return the dfs stat without battle modifier
    # @return [Integer]
    def dfs_basis
    end
    # Change the HP value of the Pokemon
    # @note If v <= 0, the pokemon status become 0
    # @param v [Integer] the new HP value
    def hp=(v)
    end
    # Return the EV HP text
    # @return [String]
    def ev_hp_text
    end
    # Return the EV ATK text
    # @return [String]
    def ev_atk_text
    end
    # Return the EV DFE text
    # @return [String]
    def ev_dfe_text
    end
    # Return the EV SPD text
    # @return [String]
    def ev_spd_text
    end
    # Return the EV ATS text
    # @return [String]
    def ev_ats_text
    end
    # Return the EV DFS text
    # @return [String]
    def ev_dfs_text
    end
    # Return the IV HP text
    # @return [String]
    def iv_hp_text
    end
    # Return the IV ATK text
    # @return [String]
    def iv_atk_text
    end
    # Return the IV DFE text
    # @return [String]
    def iv_dfe_text
    end
    # Return the IV SPD text
    # @return [String]
    def iv_spd_text
    end
    # Return the IV ATS text
    # @return [String]
    def iv_ats_text
    end
    # Return the IV DFS text
    # @return [String]
    def iv_dfs_text
    end
    private
    # Return the text "EV: %d"
    # @return [String]
    def ev_text
    end
    # Return the text "IV: %d"
    # @return [String]
    def iv_text
    end
    # Calculate the stat according to the stat formula
    # @param base [Integer] base of the stat
    # @param iv [Integer] IV of the stat
    # @param ev [Integer] EV of the stat
    # @param nature_index [Integer] Index of the nature modifier in the nature array
    def calc_regular_stat(base, iv, ev, nature_index)
    end
    public
    # Is the Pokemon not able to fight
    # @return [Boolean]
    def dead?
    end
    # Is the Pokemon able to fight
    # @return [Boolean]
    def alive?
    end
    # Is the pokemon affected by a status
    # @return [Boolean]
    def status?
    end
    # Cure the Pokemon from its statues modifications
    def cure
    end
    # Is the Pokemon poisoned?
    # @return [Boolean]
    def poisoned?
    end
    # Empoison the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been empoisoned
    def status_poison(forcing = false)
    end
    # Can the Pokemon be poisoned ?
    # @return [Boolean]
    def can_be_poisoned?
    end
    # Is the Pokemon paralyzed?
    # @return [Boolean]
    def paralyzed?
    end
    # Paralyze the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been paralyzed
    def status_paralyze(forcing = false)
    end
    # Can the Pokemon be paralyzed?
    # @return [Boolean]
    def can_be_paralyzed?
    end
    # Is the Pokemon burnt?
    # @return [Boolean]
    def burn?
    end
    alias burnt? burn?
    # Burn the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been burnt
    def status_burn(forcing = false)
    end
    # Can the Pokemon be burnt?
    # @return [Boolean]
    def can_be_burn?
    end
    # Is the Pokemon asleep?
    # @return [Boolean]
    def asleep?
    end
    # Put the Pokemon to sleep
    # @param forcing [Boolean] force the new status
    # @param nb_turn [Integer, nil] number of turn the Pokemon will sleep
    # @return [Boolean] if the pokemon has been put to sleep
    def status_sleep(forcing = false, nb_turn = nil)
    end
    # Can the Pokemon be asleep?
    # @return [Boolean]
    def can_be_asleep?
    end
    # Check if the Pokemon is still asleep
    # @return [Boolean] true = the Pokemon is still asleep
    def sleep_check
    end
    # Is the Pokemon frozen?
    # @return [Boolean]
    def frozen?
    end
    # Freeze the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been frozen
    def status_frozen(forcing = false)
    end
    # Can the Pokemon be frozen?
    # @return [Boolean]
    def can_be_frozen?(skill_type = 0)
    end
    # Is the Pokemon in toxic state ?
    # @return [Boolean]
    def toxic?
    end
    # Intoxicate the Pokemon
    # @param forcing [Boolean] force the new status
    # @return [Boolean] if the pokemon has been intoxicated
    def status_toxic(forcing = true)
    end
    public
    # Return the current first type of the Pokemon
    # @return [Integer]
    def type1
    end
    # Return the current second type of the Pokemon
    # @return [Integer]
    def type2
    end
    # Return the current third type of the Pokemon
    # @return [Integer]
    def type3
    end
    # Is the Pokemon type normal ?
    # @return [Boolean]
    def type_normal?
    end
    # Is the Pokemon type fire ?
    # @return [Boolean]
    def type_fire?
    end
    alias type_feu? type_fire?
    # Is the Pokemon type water ?
    # @return [Boolean]
    def type_water?
    end
    alias type_eau? type_water?
    # Is the Pokemon type electric ?
    # @return [Boolean]
    def type_electric?
    end
    alias type_electrique? type_electric?
    # Is the Pokemon type grass ?
    # @return [Boolean]
    def type_grass?
    end
    alias type_plante? type_grass?
    # Is the Pokemon type ice ?
    # @return [Boolean]
    def type_ice?
    end
    alias type_glace? type_ice?
    # Is the Pokemon type fighting ?
    # @return [Boolean]
    def type_fighting?
    end
    alias type_combat? type_fighting?
    # Is the Pokemon type poison ?
    # @return [Boolean]
    def type_poison?
    end
    # Is the Pokemon type ground ?
    # @return [Boolean]
    def type_ground?
    end
    alias type_sol? type_ground?
    # Is the Pokemon type fly ?
    # @return [Boolean]
    def type_flying?
    end
    alias type_vol? type_flying?
    alias type_fly? type_flying?
    # Is the Pokemon type psy ?
    # @return [Boolean]
    def type_psychic?
    end
    alias type_psy? type_psychic?
    # Is the Pokemon type insect/bug ?
    # @return [Boolean]
    def type_bug?
    end
    alias type_insect? type_bug?
    # Is the Pokemon type rock ?
    # @return [Boolean]
    def type_rock?
    end
    alias type_roche? type_rock?
    # Is the Pokemon type ghost ?
    # @return [Boolean]
    def type_ghost?
    end
    alias type_spectre? type_ghost?
    # Is the Pokemon type dragon ?
    # @return [Boolean]
    def type_dragon?
    end
    # Is the Pokemon type steel ?
    # @return [Boolean]
    def type_steel?
    end
    alias type_acier? type_steel?
    # Is the Pokemon type dark ?
    # @return [Boolean]
    def type_dark?
    end
    alias type_tenebre? type_dark?
    # Is the Pokemon type fairy ?
    # @return [Boolean]
    def type_fairy?
    end
    alias type_fee? type_fairy?
    # Check the Pokemon type by the type ID
    # @param type [Integer] ID of the type in the database
    # @return [Boolean]
    def type?(type)
    end
    # Is the Pokemon typeless ?
    # @return [Boolean]
    def typeless?
    end
    # Is the user single typed ?
    # @return [Boolean]
    def single_type?
    end
    # Has the user a third type ?
    # @return [Boolean]
    def third_type?
    end
    public
    # PSP 0.7 ID Hash key
    G_ID = 'ID'
    # PSP 0.7 level Hash key
    G_NV = 'NV'
    # PSP 0.7 item hash key
    G_OBJ = 'OBJ'
    # PSP 0.7 stat hash key
    G_STAT = 'STAT'
    # PSP 0.7 move hash key
    G_MOVE = 'MOVE'
    # PSP 0.7 gender hash key
    G_GR = 'GR'
    # PSP 0.7 form hash key
    G_FORM = 'FORM'
    # PSP 0.7 shiny hash key
    G_SHINY = 'SHINY'
    class << self
      # Generate a Pokemon from a hash
      # @param hash [Hash] Hash describing optional value you want to assign to the Pokemon
      # @option hash [Integer, Symbol] :id ID of the Pokemon
      # @option hash [Integer] :level level of the Pokemon
      # @option hash [Boolean] :shiny if the pokemon will be shiny
      # @option hash [Boolean] :no_shiny if the pokemon will never be shiny
      # @option hash [Integer] :form form index of the Pokemon
      # @option hash [String] :given_name Nickname of the Pokemon
      # @option hash [Integer, Symbol] :captured_with ID of the ball used to catch the Pokemon
      # @option hash [Integer] :captured_in ID of the zone where the Pokemon was caught
      # @option hash [Integer, Time] :captured_at Time when the Pokemon was caught
      # @option hash [Integer] :captured_level Level of the Pokemon when it was caught
      # @option hash [Integer] :egg_in ID of the zone where the egg was layed/found
      # @option hash [Integer, Time] :egg_at Time when the egg was layed/found
      # @option hash [Integer, String] :gender Forced gender of the Pokemon
      # @option hash [Integer] :nature Nature of the Pokemon
      # @option hash [Array<Integer>] :stats IV array ([hp, atk, dfe, spd, ats, dfs])
      # @option hash [Array<Integer>] :bonus EV array ([hp, atk, dfe, spd, ats, dfs])
      # @option hash [Integer, Symbol] :item ID of the item the Pokemon is holding
      # @option hash [Integer, Symbol] :ability ID of the ability the Pokemon has
      # @option hash [Integer] :rareness Rareness of the Pokemon (0 = not catchable, 255 = always catchable)
      # @option hash [Integer] :loyalty Happiness of the Pokemon
      # @option hash [Array<Integer, Symbol>] :moves Current Moves of the Pokemon (0 = default)
      # @option hash [Array(Integer, Integer)] :memo_text Text used for the memo ([file_id, text_id])
      # @option hash [String] :trainer_name Name of the trainer that caught / got the Pokemon
      # @option hash [Integer] :trainer_id ID of the trainer that caught / got the Pokemon
      # @return [PFM::Pokemon]
      def generate_from_hash(hash)
      end
      private
      def psp_generate_from_hash(hash)
      end
    end
    public
    # Return the Pokemon name in the Pokedex
    # @return [String]
    def name
    end
    # Return the Pokemon name upcase in the Pokedex
    # @return [String]
    def name_upper
    end
    # Return the given name of the Pokemon (Pokedex name if no given name)
    # @return [String]
    def given_name
    end
    alias nickname given_name
    # Give a new name to the Pokemon
    # @param nickname [String] the new name of the Pokemon
    def given_name=(nickname)
    end
    alias nickname= given_name=
    # Convert the Pokemon to a string (battle debug)
    # @return [String]
    def to_s
    end
    # Return the text of the nature
    # @return [String]
    def nature_text
    end
    # Return the name of the zone where the Pokemon has been caught
    # @return [String]
    def captured_zone_name
    end
    # Return the name of the zone where the egg has been obtained
    # @return [String]
    def egg_zone_name
    end
    # Return the name of the item the Pokemon is holding
    # @return [String]
    def item_name
    end
    # Return the name of the current ability of the Pokemon
    # @return [String]
    def ability_name
    end
    # Reture the description of the current ability of the Pokemon
    # @return [String]
    def ability_descr
    end
    # Return the normalized text trainer id of the Pokemon
    # @return [String]
    def trainer_id_text
    end
    # Returns the level text
    # @return [String]
    def level_text
    end
    # Return the level text (to_pokemon_number)
    # @return [String]
    def level_pokemon_number
    end
    # Return the level text with "Level: " inside
    # @return [String]
    def level_text2
    end
    # Returns the HP text
    # @return [String]
    def hp_text
    end
    # Returns the HP text (to_pokemon_number)
    # @return [String]
    def hp_pokemon_number
    end
    # Return the text of the Pokemon ID
    # @return [String]
    def id_text
    end
    # Return the text of the Pokemon ID with N°
    # @return [String]
    def id_text2
    end
    # Return the text of the Pokemon ID to pokemon number
    # @return [String]
    def id_text3
    end
    private
    # Get the dex id of the Pokemon
    # @return [Integer]
    def dex_id
    end
    public
    # Tell if the Creature likes flavor
    # @param flavor [Symbol]
    def flavor_liked?(flavor)
    end
    # Tell if the Creature dislikes flavor
    # @param flavor [Symbol]
    def flavor_disliked?(flavor)
    end
    # Check if the Creature has a nature with no preferences
    def no_preferences?
    end
  end
  # The InGame skill/move information of a Pokemon
  # @author Nuri Yuri
  class Skill
    # The maximum number of PP the skill has
    # @return [Integer]
    attr_accessor :ppmax
    # The current number of PP the skill has
    # @return [Integer]
    attr_reader :pp
    # ID of the skill in the Database
    # @return [Integer]
    attr_reader :id
    # Create a new Skill information
    # @param db_symbol [Symbol] db_symbol of the skill/move in the database
    def initialize(db_symbol)
    end
    # Return the actual data of the move
    # @return [Studio::Move]
    def data
    end
    # Return the db_symbol of the skill
    # @return [Symbol]
    def db_symbol
    end
    # Return the name of the skill
    # @return [String]
    def name
    end
    # Return the symbol of the method to call in BattleEngine
    # @return [Symbol]
    def symbol
    end
    # Return the text of the power of the skill
    # @return [String]
    def power_text
    end
    # Return the text of the PP of the skill
    # @return [String]
    def pp_text
    end
    # Return the base power (Data power) of the skill
    # @return [Integer]
    def base_power
    end
    alias power base_power
    # Return the actual type ID of the skill
    # @return [Integer]
    def type
    end
    # Return the actual accuracy of the skill
    # @return [Integer]
    def accuracy
    end
    # Return the accuracy text of the skill
    # @return [String]
    def accuracy_text
    end
    # Return the skill description
    # @return [String]
    def description
    end
    # Return the ID of the common event to call on Map use
    # @return [Integer]
    def map_use
    end
    # Is the skill a specific type ?
    # @param type_id [Integer] ID of the type
    def type?(type_id)
    end
    # Change the PP
    # @param v [Integer] the new pp value
    def pp=(v)
    end
    # Get the ATK class for the UI
    # @return [Integer]
    def atk_class
    end
  end
end
