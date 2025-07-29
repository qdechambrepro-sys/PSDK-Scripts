# Interpreter of the event script commands
class Interpreter < Interpreter_RMXP
  # Detect if the event can spot the player and move to the player
  # @param nb_pas [Integer] number of step the event should do to spot the player
  # @return [Boolean] if the event spot the player or not
  # @example To detect the player 7 tiles in front of the event, put in a condition :
  #   player_spotted?(7)
  # @author Nuri Yuri
  def player_spotted?(nb_pas)
  end
  alias trainer_spotted player_spotted?
  # Detect if the event can spot the player in a certain rect in frond of itself
  # @param nb_pas [Integer] number of step the event should do to spot the player
  # @param dist [Integer] distance in both side of the detection
  # @return [Boolean] if the event spot the player or not
  def player_spotted_rect?(nb_pas, dist)
  end
  alias trainer_spotted_rect player_spotted_rect?
  # Detect if the event can spot the player and move to the player with direction relative detection
  # @param up [Integer] number of step to the up direction
  # @param down [Integer] number of step to the down direction
  # @param left [Integer] number of step to the left direction
  # @param right [Integer] number of step to the right direction
  # @example The event turn left and bottom but does not have the same vision when turned bottom
  #   player_spotted_directional?(left: 7, bottom: 3)
  # @return [Boolean] if the event spotted the player
  def player_spotted_directional?(up: nil, down: nil, left: nil, right: nil)
  end
  # Detect the player in a specific direction
  # @param nb_pas [Integer] the number of step between the event and the player
  # @param direction [Symbol, Integer] the direction : :right, 6, :down, 2, :left, 4, :up or 8
  # @return [Boolean]
  # @author Nuri Yuri
  def detect_player(nb_pas, direction)
  end
  # Detect the player in a rectangle around the event
  # @param nx [Integer] the x distance of detection between the event and the player
  # @param ny [Integer] the y distance of detection between the event and the player
  # @return [Boolean]
  # @author Nuri Yuri
  def detect_player_rect(nx, ny)
  end
  # Detect the player in a circle around the event
  # @param r [Numeric] the square radius (r = R²) of the circle around the event
  # @return [Boolean]
  # @author Nuri Yuri
  def detect_player_circle(r)
  end
  # Delete the current event forever
  def delete_this_event_forever
  end
  # Delete the provided event forever
  # @param event_id [Integer]
  def delete_event_forever(event_id)
  end
  alias delete_event delete_event_forever
  # Wait for the end of the movement of this particular character
  # @param event_id [Integer] <default : calling event's> the id of the event to watch
  def wait_character_move_completion(event_id = @event_id)
  end
  alias attendre_fin_deplacement_cet_event wait_character_move_completion
  alias wait_event wait_character_move_completion
  alias attendre_event wait_character_move_completion
  # Detect if a specified tile (in layer 3) is in the specified zone
  # @param x [Integer] the coordinate x of the zone
  # @param y [Integer] the coordinate y of the zone
  # @param width [Integer] the width of the zone
  # @param height [Integer] the height of the zone
  # @param tile_id [Integer] the tile's id in the tileset
  # @return [Boolean] "true" if the tile is detected in the zone, else "false"
  # @example To detect if there is non-cracked ice floor tile in a zone going from
  #      X = 15 (included) to 24 and Y = 10 (included) to 15, you have to write : 
  #      detect_invalid_tile(15, 10, 10, 6, 394)
  #      To calculate tile_id the formula is this one : 384 + tileset_x + tileset_y * 8
  #      For example : the tile is the third of the second line we then have tileset_x = 2, tileset_y = 1 which gives 394.
  def detect_invalid_tile(x, y, width, height, tile_id)
  end
  # Save the current fog
  # @return [Array] the fog info
  def save_this_fog
  end
  # Clear the saved fog
  def clear_saved_fog
  end
  private
  # Tell if detecting the player is disabled
  # @return [Boolean]
  def player_detection_disabled?
  end
  public
  # Add a pokemon to the party or store it in the PC
  # @param pokemon_or_id [Integer, Symbol, PFM::Pokemon] the ID of the pokemon in the database or a Pokemon
  # @param level [Integer] the level of the Pokemon (if ID given)
  # @param shiny [Boolean, Integer] true means the Pokemon will be shiny, 0 means it'll have no chance to be shiny, other number are the chance (1 / n) the pokemon can be shiny.
  # @return [PFM::Pokemon, nil] if nil, the Pokemon couldn't be stored in the PC or added to the party. Otherwise it's the Pokemon that was added.
  # @author Nuri Yuri
  def add_pokemon(pokemon_or_id, level = 5, shiny = false)
  end
  alias ajouter_pokemon add_pokemon
  alias ajouter_stocker_pokemon add_pokemon
  # Store a Pokemon in the PC
  # @param pokemon_or_id [Integer, Symbol, PFM::Pokemon] the ID of the pokemon in the database or a Pokemon
  # @param level [Integer] the level of the Pokemon (if ID given)
  # @param shiny [Boolean, Integer] true means the Pokemon will be shiny, 0 means it'll have no chance to be shiny, other number are the chance (1 / n) the pokemon can be shiny.
  # @return [PFM::Pokemon, nil] if nil, the Pokemon couldn't be stored in the PC. Otherwise it's the Pokemon that was added.
  # @author Nuri Yuri
  def store_pokemon(pokemon_or_id, level = 5, shiny = false)
  end
  alias stocker_pokemon store_pokemon
  # Add a pokemon (#add_pokemon) with specific informations
  # @param hash [Hash] the parameters of the Pokemon, see PFM::Pokemon#generate_from_hash.
  # @return [PFM::Pokemon, nil] see #add_pokemon
  # @author Nuri Yuri
  def add_specific_pokemon(hash)
  end
  alias ajouter_pokemon_param add_specific_pokemon
  # withdraw a Pokemon from the Party
  # @param id [Integer, Symbol] the id of the Pokemon you want to withdraw
  # @param counter [Integer] the number of Pokemon with this id to withdraw
  # @author Nuri Yuri
  def withdraw_pokemon(id, counter = 1)
  end
  alias retirer_pokemon withdraw_pokemon
  # withdraw a Pokemon from the party at a specific position in the Party
  # @param index [Integer] the position (0~5) in the party.
  def withdraw_pokemon_at(index)
  end
  alias retirer_pokemon_index withdraw_pokemon_at
  # Learn a skill to a Pokemon
  # @param pokemon [PFM::Pokemon, Integer] the Pokemon that will learn the skill (use $actors[index] for a Pokemon in the party). An integer will automatically search into the party
  # @param id_skill [Integer, Symbol] the id of the skill in the database
  # @return [Boolean] if the move was learnt or not
  # @author Nuri Yuri
  def skill_learn(pokemon, id_skill)
  end
  alias enseigner_capacite skill_learn
  # Play the cry of a Pokemon
  # @param id [Integer, Symbol] the id of the Pokemon in the database
  # @param volume [Integer] the volume of the cry
  # @param tempo [Integer] the tempo/pitch of the cry
  def cry_pokemon(id, volume: 100, tempo: 100)
  end
  # Show the rename interface of a Pokemon
  # @param index_or_pokemon [Integer, PFM::Pokemon] the Pokemon or the index of the Pokemon in the party (0~5)
  # @param num_char [Integer] the number of character the Pokemon can have in its name.
  # @author Nuri Yuri
  def rename_pokemon(index_or_pokemon, num_char = 12)
  end
  alias renommer_pokemon rename_pokemon
  # Add a pokemon to the party or store it in the PC and rename it
  # @param pokemon_or_id [Integer, Symbol, PFM::Pokemon] the ID of the pokemon in the database or a Pokemon
  # @param level [Integer] the level of the Pokemon (if ID given)
  # @param shiny [Boolean, Integer] true means the Pokemon will be shiny, 0 means it'll have no chance to be shiny, other number are the chance (1 / n) the pokemon can be shiny.
  # @param num_char [Integer] the number of character the Pokemon can have in its name.
  # @return [PFM::Pokemon, nil] if nil, the Pokemon couldn't be stored in the PC or added to the party. Otherwise it's the Pokemon that was added.
  # @author Nuri Yuri
  def add_rename_pokemon(pokemon_or_id, level = 5, shiny = false, num_char = 12)
  end
  alias ajouter_renommer_pokemon add_rename_pokemon
  # Add an egg to the Party (or in the PC)
  # @param id [Integer, Hash, Symbol, PFM::Pokemon] the id of the Pokemon, its db_symbol, a hash describing it (see: #generate_from_hash), or the Pokemon itself
  # @param egg_how_obtained [Symbol] :reveived => When you received the egg (ex: Daycare), :found => When you found the egg (ex: On the map)
  # @return [PFM::Pokemon, nil]
  # @author Nuri Yuri
  def add_egg(id, egg_how_obtained = :received)
  end
  alias ajouter_oeuf add_egg
  # Start a wild battle
  # @author Nuri Yuri
  # @overload call_battle_wild(id, level, shiny, no_shiny)
  #   @param id [Integer, Symbol] id of the Pokemon in the database
  #   @param level [Integer] level of the Pokemon
  #   @param shiny [Boolean] if the Pokemon is shiny
  #   @param no_shiny [Boolean] if the Pokemon cannot be shiny
  # @overload call_battle_wild(id, level, *args)
  #   @param id [PFM::Pokemon, Symbol] First Pokemon in the wild battle.
  #   @param level [Object] ignored
  #   @param args [Array<PFM::Pokemon>] other pokemon in the wild battle.
  # @overload call_battle_wild(id, level, *args)
  #   @param id [Integer, Symbol] id of the Pokemon in the database
  #   @param level [Integer] level of the first Pokemon
  #   @param args [Array<Integer, Integer>] array of id, level of the other Pokemon in the wild battle.
  def call_battle_wild(id, level, *args)
  end
  alias demarrer_combat call_battle_wild
  # Save some Pokemon of the team somewhere and remove them from the party
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_party
  # @param indexes [Array, Range] list of index in the team
  # @param no_save [Boolean] if the Pokémon are not saved.
  # @author Nuri Yuri
  def steal_pokemon(indexes, id_storage = nil, no_save = false)
  end
  # Retrieve previously stolen Pokemon ( /!\ uses #add_pokemon)
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_party
  # @author Nuri Yuri
  def retrieve_stolen_pokemon(id_storage = nil)
  end
  alias retreive_stolen_pokemon retrieve_stolen_pokemon
  # Start an online Trade
  # @param server [Boolean] if the player is the server
  def start_trade(server)
  end
  # Show the Pokemon dex info
  # @overload show_pokemon(pokemon)
  #   @param pokemon [PFM::Pokemon] the Pokemon to show in the dex
  # @overload show_pokemon(pokemon_id)
  #   @param pokemon_id [Integer, Symbol] ID of the Pokemon in the dex
  def show_pokemon(pokemon_id)
  end
  # Returns the db_symbol of the type of the Pokemon's Hidden Power
  # @param index_or_pokemon [Integer, PFM::Pokemon] the Pokemon or the index of the Pokemon in the party (0~5)
  # @author Rey
  def pokemon_hidden_power(index_or_pokemon)
  end
  public
  # Try to add Pokemon to the party or store the Pokemon in the storage system
  # @param pokemon [PFM::Pokemon]
  # @return [PFM::Pokemon]
  def internal_add_pokemon_final(pokemon)
  end
  # Check the symbol of the Pokemon and send the Pokemon to method_name
  # @param pokemon_or_id [Symbol] Symbol ID of the Pokemon in the database
  # @param level [Integer] level of the Pokemon to add
  # @param shiny [Integer, Boolean] the shiny chance
  # @param method_name [Symbol] Method to use in order to add the Pokemon somewhere
  # @return [PFM::Pokemon]
  def internal_add_pokemon_check_symbol(pokemon_or_id, level, shiny, method_name)
  end
  # Check the input parameters and send the Pokemon to method_name
  # @param pokemon_id [Integer] ID of the Pokemon in the database
  # @param level [Integer] level of the Pokemon to add
  # @param shiny [Integer, Boolean] the shiny chance
  # @param method_name [Symbol] Method to use in order to add the Pokemon somewhere
  # @return [PFM::Pokemon]
  def internal_add_pokemon_check_level_shiny(pokemon_id, level, shiny, method_name)
  end
  # Try to add Pokemon to the party or store the Pokemon in the storage system
  # @param pokemon [PFM::Pokemon]
  # @return [PFM::Pokemon]
  def internal_store_pokemon_final(pokemon)
  end
  public
  # Call the move reminder UI with the choosen Pokemon and a specific mode (0 by default)
  # @param pokemon [PFM::Pokemon]
  # @param mode [Integer] see {GamePlay::Move_Reminder#initialize}
  # @return [Boolean] if the Pokemon learnt a move or not
  def move_reminder(pokemon = $actors[$game_variables[::Yuki::Var::Party_Menu_Sel]], mode = 0)
  end
  alias maitre_capacites move_reminder
  # Detect if the move reminder can remind a move to the selected pokemon
  # @param mode [Integer] see {GamePlay::Move_Reminder#initialize}
  # @return [Boolean] if the scene can be called
  def can_move_reminder_be_called?(mode = 0)
  end
  alias maitre_capacites_appelable? can_move_reminder_be_called?
  public
  # Return the current time in minute
  # @return [Integer]
  def current_time
  end
  # Store a timed event (will enable the desired local switch when the timer reached the amount of minutes)
  # @param amount_of_minutes [Integer] number of minute from now to enable the switch
  # @param local_switch_letter [String] letter of the local switch to enable in order to trigger the event
  # @param event_id [Integer] event id that should be activated
  # @param map_id [Integer] map where the event should be located
  # @example Setting an event in 24h for the current event (local switch D)
  #   trigger_event_in(24 * 60, 'D')
  def trigger_event_in(amount_of_minutes, local_switch_letter, event_id = @event_id, map_id = @map_id)
  end
  # Get the remaining time until the trigger (in minutes)
  # @param event_id [Integer] event id that should be activated
  # @param map_id [Integer] map where the event should be located
  # @return [Integer]
  def timed_event_remaining_time(event_id = @event_id, map_id = @map_id)
  end
  public
  # Return the $game_variables
  # @return [Game_Variables]
  def gv
  end
  # Return the $game_switches
  # @return [Game_Switches]
  def gs
  end
  # Return the $game_temp
  # @return [Game_Temp]
  def gt
  end
  # Return the $game_map
  # @return [Game_Map]
  def gm
  end
  # Return the $game_player
  # @return [Game_Player]
  def gp
  end
  # Return the $game_map.events[id]
  # @return [Game_Event]
  def ge(id = @event_id)
  end
  # Return the party object (game state)
  # @return [PFM::GameState]
  def party
  end
  # Return the NuriYuri::DynamicLight module
  # @return [NuriYuri::DynamicLight]
  def dynamic_light
  end
  alias dyn_light dynamic_light
  # Start the storage PC
  def start_pc
  end
  alias demarrer_pc start_pc
  # Show an emotion to an event or the player
  # @param type [Symbol] the type of emotion (see wiki)
  # @param char_id [Integer] the ID of the event (> 0), the current event (0) or the player (-1)
  # @param wait [Integer] the number of frame the event will wait after this command.
  # @param params [Hash] particle
  # @note The available emotion type are :
  #   - :exclamation
  #   - :exclamation2
  #   - :poison
  #   - :interrogation
  #   - :music
  #   - :love
  #   - :joy
  #   - :sad
  #   - :happy
  #   - :angry
  #   - :sulk
  #   - :nocomment
  # @example Displaying the poison emotion :
  #   emotion(:poison)
  # @example Displaying the poison emotion on the player (with offset) :
  #   emotion(:poison, -1, 34, oy_offset: 10)
  def emotion(type, char_id = 0, wait = 34, params = {})
  end
  # Show an emotion on multiple events and/or the player
  # @param type [Symbol] the type of emotion (see wiki)
  # @param chars_id [Array<Integer>] the ID of the event (> 0), the current event (0) or the player (-1)
  # @param wait [Integer] the number of frame the event will wait after this command.
  # @param params [Hash] particle
  # @note See the #emotion method comments for the available emotion type
  # @example Displaying the poison emotion on the player and multiple NPCs (with offset) :
  #   emotion_on_multiple_npc(:poison, [-1, 5, 8, 15], 34, oy_offset: 10)
  def emotion_on_multiple_npc(type, chars_id = [0], wait = 34, params = {})
  end
  alias emotion_on_multiple_pnj emotion_on_multiple_npc
  # List of command cods that needs to be skipped in order to detect the from event calling call
  FEC_SKIP_CODES = [108, 121, 122]
  # Check if the front event calls a common event (in its first non comment commands)
  # @param common_event [Integer] the id of the common event in the database
  # @return [Boolean]
  # @author Nuri Yuri
  def front_event_calling(common_event)
  end
  # Check if an event is calling a common event (in its first non comment commands)
  # @param common_event [Integer] the id of the common event
  # @param event_id [Integer] the id of the event on the MAP
  # @return [Boolean]
  def event_calling(common_event, event_id)
  end
  # Start a choice with more option than RMXP allows.
  # @param variable_id [Integer] the id of the Variable where the choice will be store.
  # @param cancel_type [Integer] the choice that cancel (-1 = no cancel)
  # @param choices [Array<String>] the list of possible choice.
  # @author Nuri Yuri
  def choice(variable_id, cancel_type, *choices)
  end
  # Open the world map
  # @param arg [Symbol] the mode of the world map, :view or :fly
  # @param wm_id [Integer] the world map id to display
  # @author Nuri Yuri
  def carte_du_monde(arg = :view, wm_id = $env.get_worldmap)
  end
  alias world_map carte_du_monde
  # Save the game without asking
  def force_save
  end
  alias forcer_sauvegarde force_save
  # Set the value of a self_switch
  # @param value [Boolean] the new value of the switch
  # @param self_switch [String] the name of the self switch ("A", "B", "C", "D")
  # @param event_id [Integer] the id of the event that see the self switch
  # @param map_id [Integer] the id of the map where the event see the self switch
  # @author Leikt
  def set_self_switch(value, self_switch, event_id = @event_id, map_id = @map_id)
  end
  alias set_ss set_self_switch
  # Get the value of a self_switch
  # @param self_switch [String] the name of the self switch ("A", "B", "C", "D")
  # @param event_id [Integer] the id of the event that see the self switch
  # @param map_id [Integer] the id of the map where the event see the self switch
  # @return [Boolean] the value of the self switch
  # @author Leikt
  def get_self_switch(self_switch, event_id = @event_id, map_id = @map_id)
  end
  alias get_ss get_self_switch
  # Show the party menu in order to select a Pokemon
  # @param id_var [Integer] id of the variable in which the index will be store (-1 = no selection)
  # @param party [Array<PFM::Pokemon>] the array of Pokemon to show in the menu
  # @param mode [Symbol] the mode of the Menu (:map, :menu, :item, :hold, :battle)
  # @param extend_data [Integer, PFM::ItemDescriptor::Wrapper, Array, Symbol] extend_data informations
  # @author Nuri Yuri
  def call_party_menu(id_var = ::Yuki::Var::Party_Menu_Sel, party = $actors, mode = :map, extend_data = nil)
  end
  alias appel_menu_equipe call_party_menu
  # Show the quest book
  def quest_book
  end
  alias livre_quetes quest_book
  alias quest_ui quest_book
  # Add a parallax
  # @overload add_parallax(image, x, y, z, zoom_x = 1, zoom_y = 1, opacity = 255, blend_type = 0)
  #   @param image [String] name of the image in Graphics/Pictures/
  #   @param x [Integer] x coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
  #   @param y [Integer] y coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
  #   @param z [Integer] z superiority in the tile viewport
  #   @param zoom_x [Numeric] zoom_x of the parallax
  #   @param zoom_y [Numeric] zoom_y of the parallax
  #   @param opacity [Integer] opacity of the parallax (0~255)
  #   @param blend_type [Integer] blend_type of the parallax (0, 1, 2)
  def add_parallax(*args)
  end
  # Return the PFM::Text module
  # @return [PFM::Text]
  def pfm_text
  end
  # Return the index of the choosen Pokemon or call a method of GameState to find the right Pokemon
  # @param method_name [Symbol] identifier of the method
  # @param args [Array] parameters to send to the method
  def pokemon_index(method_name, *args)
  end
  # Use path finding to locate the current event move else
  # @param to [Array<Integer, Integer>, Game_Character] the target, [x, y] or Game_Character object
  # @param radius [Integer] <default : 0> the distance from the target to consider it as reached
  # @param tries [Integer, Symbol] <default : 5> the number of tries allowed to this request, use :infinity to unlimited try count
  # @param type [Symbol]
  # @example find path to x=10 y=15 with an error radius of 5 tiles
  #   find_path(to:[10,15], radius:5)
  def find_path(to:, radius: 0, tries: Pathfinding::TRY_COUNT, type: nil)
  end
  # Shortcut for get_character(@event_id).stop_path
  def stop_path
  end
  # Shortcut defining the pathfinding request and wait for the end of the path following
  # @param x [Integer] x coords to reach
  # @param y [Integer] y coords to reach
  # @param ms [Integer] <default : 5> movement speed
  def fast_travel(x, y = nil, ms = 5)
  end
  # Shortcut for get_character(@event_id).animate_from_charset(*args)
  # @param lines [Array<Integer>] list of the lines to animates (0,1,2,3)
  # @param duration [Integer] duration of the animation in frame (60frame per secondes)
  # @param reverse [Boolean] <default: false> set it to true if the animation is reversed
  # @param repeat [Boolean] <default: false> set it to true if the animation is looped
  # @return [Boolean]
  def animate_from_charset(lines, duration, reverse: false, repeat: false, last_frame_delay: false)
  end
  # Wait for the end of the charset animation of this particular event
  # @param event_id [Integer] <default : calling event's> the id of the event to watch
  def wait_charset_animation(event_id = @event_id)
  end
  # Test if the Interpreter is currently waiting for an event
  # @return [Boolean]
  # @note This function automatically update the states it use if it returns false
  def waiting_animate_charset_event?
  end
  # Shortcut for wait_character_move_completion(0)
  # Wait for the end of the player movement
  def wait_for_player
  end
  alias attendre_joueur wait_for_player
  # Open the casino gameplay
  # @param arg [Symbol] the mode of the casino :voltorb_flip, :slotmachine, ...
  # @param speed [Integer] speed of the slot machine
  # @author Nuri Yuri
  def casino(arg = :voltorb_flip, speed = 2)
  end
  # Open the Hall of Fame UI
  # @param filename_bgm [String] the bgm to play during the Hall of Fame
  # @param context_of_victory [Symbol] the symbol to put as the context of victory
  def hall_of_fame(filename_bgm = 'audio/bgm/Hall-of-Fame', context_of_victory = :league)
  end
  # Open the Mining Game UI
  # @overload mining_game(item_count, music_filename = GamePlay::MiningGame::DEFAULT_MUSIC)
  #   @param item_count [Integer] the number of items to search
  #   @param music_filename [String] the filename of the music to play
  #   @param delete_after [Boolean] if the event should be deleted forever afterward
  #   @param grid_handler [PFM::MiningGame::GridHandler, nil] a specific GridHandler for this instance of the Mining Game
  # @overload mining_game(wanted_item_db_symbols, music_filename = GamePlay::MiningGame::DEFAULT_MUSIC)
  #   @param wanted_item_db_symbols [Array<Symbol>] the array containing the specific items (comprised between 1 and 5 items)
  #   @param music_filename [String] the filename of the music to play
  #   @param delete_after [Boolean] if the event should be deleted forever afterward
  #   @param grid_handler [PFM::MiningGame::GridHandler, nil] a specific GridHandler for this instance of the Mining Game
  def mining_game(param = nil, music_filename = GamePlay::MiningGame::DEFAULT_MUSIC, delete_after: true, grid_handler: nil)
  end
  # Mirror a RMXP Picture
  # @param id [Integer] the picture id
  # @param bool [Boolean] the mirroring state
  def mirror_picture(id, bool = true)
  end
  # Give a certain amount of exp to one Pokemon
  # @param index [Integer] the Pokemon index
  # @param amount [Integer] the amount of exp to give
  def give_exp(index, amount)
  end
  # Give a certain amount of exp to every Pokemon in party
  # @param amount [Integer] the amount of exp to give
  def give_exp_all(amount)
  end
  # Give a certain amount of level to one Pokemon
  # @param index [Integer] the Pokemon index
  # @param amount [Integer] the amount of level to give
  def give_level(index, amount)
  end
  # Give a certain amount of level to every Pokemon in party
  # @param amount [Integer] the amount of level to give
  def give_level_all(amount)
  end
  # Take a screenshot of the map and save it as a png
  # @param filename [String]
  # @param scale [Integer] the scale of the final screenshot (between 1 and 3, this helps to multiply 320*240 by a factor)
  def take_screenshot(filename = 'map_screenshot%d.png', scale = 1)
  end
  public
  # If the put item in pocket message is not shown
  MODE_SWOOSH = true
  # Add an item to the bag if possible, will delete the event forever
  # @param item_id [Integer, Symbol] id of the item in the database
  # @param no_delete [Boolean] bypass the deletion of the event
  # @param text_id [Integer] ID of the text used when the item is found
  # @param no_space_text_id [Integer] ID of the text when the player has not enough space in the bag
  # @param count [Integer] number of item to add
  # @param color [Integer] color to put on the item name
  def add_item(item_id, no_delete = false, text_id: 4, no_space_text_id: 7, color: 11, count: 1)
  end
  # Pick an item on the ground (and delete the event)
  # @param item_id [Integer, Symbol] id of the item in the database
  # @param count [Integer] number of item
  # @param no_delete [Boolean] if the event should not be delete forever
  def pick_item(item_id, count = 1, no_delete = false)
  end
  # Give an item to the player
  # @param item_id [Integer, Symbol] id of the item in the database
  # @param count [Integer] number of item
  def give_item(item_id, count = 1)
  end
  private
  # Show the too bad no space phrase in the add_item command
  # @param item_id [Integer]
  # @param no_space_text_id [Integer] ID of the text when the player has not enough space in the bag
  # @param color [Integer] color to put on the item name
  def add_item_no_space(item_id, no_space_text_id, color)
  end
  # Show the item got text
  # @param item_id [Integer]
  # @param text_id [Integer] ID of the text used when the item is found
  # @param color [Integer] color to put on the item name
  # @param end_color [Integer] color used after the item name
  # @return [Array<String, Integer>] the name of the item with the decoration and its socket
  def add_item_show_message_got(item_id, text_id, color, end_color = 10, count: 1)
  end
  public
  # Show a message with eventually a choice
  # @param string [String] message to show
  # @param cancel_type [Integer] option used to cancel (1 indexed position, 0 means no cancel)
  # @param choices [Array<String>] all the possible choice
  # @note This function should only be called from text events!
  # @example Simple message
  #   message("It's a message!")
  # @example Message from CSV files
  #   message(ext_text(csv_id, index))
  # @example Message with choice
  #   choice_result = message("You are wonkru or you are the enemy of wonkru!\nChoose !", 1, 'Wonkru', '*Knifed*')
  # @return [Integer] the choosen choice (0 indexed this time)
  def message(string, cancel_type = 0, *choices)
  end
  # Show a yes no choice
  # @param message [String] message shown by the event
  # @param yes [String] string used as yes
  # @param no [String] string used as no
  # @example Simple yes/no choice (in a condition)
  #   yes_no_choice('Do you want to continue?')
  # @example Boy/Girl choice (in a condition, validation will mean boy)
  #   yes_no_choice('Are you a boy?[WAIT 60] \nOr are you a girl?', 'Boy', 'Girl')
  # @return [Boolean] if the yes option was choosen
  def yes_no_choice(message, yes = nil, no = nil)
  end
  private
  # Call the RMXP message
  # @param message [String] message to display
  # @param start [Integer] choice start
  # @param choices [Array<String>] choices
  # @return [Integer]
  def rmxp_message(message, start, *choices)
  end
  public
  include Util::SystemMessage if const_defined?(:Util)
  # Name of the file used as Received Pokemon ME (with additional parameter like volume)
  RECEIVED_POKEMON_ME = ['audio/me/rosa_yourpokemonevolved', 80]
  # Header of the system messages
  SYSTEM_MESSAGE_HEADER = ':[windowskin=m_18]:\\c[10]'
  # Default BGM used for trainer battle (sent to AudioFile so no audio/bgm)
  DEFAULT_TRAINER_BGM = ['xy_trainer_battle', 100, 100]
  # Default eye bgm for trainer encounter (direct, requires audio/bgm)
  DEFAULT_EYE_BGM = ['audio/bgm/pkmrs-enc1', 100, 100]
  # Default exclamation SE for trainer encounter (direct, requires audio/se)
  DEFAULT_EXCLAMATION_SE = ['audio/se/015-jump01', 65, 95]
  # Duration of the exclamation particle
  EXCLAMATION_PARTICLE_DURATION = 54
  # Receive Pokemon sequence, when the player is given a Pokemon
  # @param pokemon_or_id [Integer, Symbol, PFM::Pokemon] the ID of the pokemon in the database or a Pokemon
  # @param level [Integer] the level of the Pokemon (if ID given)
  # @param shiny [Boolean, Integer] true means the Pokemon will be shiny, 0 means it'll have no chance to be shiny, other number are the chance (1 / n) the pokemon can be shiny.
  # @return [PFM::Pokemon, nil] if nil, the Pokemon couldn't be stored in the PC or added to the party. Otherwise it's the Pokemon that was added.
  def receive_pokemon_sequence(pokemon_or_id, level = 5, shiny = false)
  end
  # Show the "Pokemon was sent to BOX $" message
  # @param pokemon [PFM::Pokemon] Pokemon sent to the box
  def pokemon_stored_sequence(pokemon)
  end
  # Start a trainer battle
  # @param trainer_id [Integer] ID of the trainer in Studio
  # @param bgm [String, Array] BGM to play for battle
  # @param disable [String] Name of the local switch to disable (if defeat)
  # @param enable [String] Name of the local switch to enable (if victory)
  # @param troop_id [Integer] ID of the troop to use : 3 = trainer, 4 = Gym Leader, 5 = Elite, 6 = Champion
  # @example Start a simple trainer battle
  #   start_trainer_battle(5) # 5 is the trainer 5 in Studio
  # @example Start a trainer battle agains a gym leader
  #   start_trainer_battle(5, bgm: '28 Pokemon Gym', troop_id: 4)
  def start_trainer_battle(trainer_id, bgm: DEFAULT_TRAINER_BGM, disable: 'A', enable: 'B', troop_id: 3)
  end
  # Start a trainer battle
  # @param trainer_id [Integer] ID of the trainer in Studio
  # @param second_trainer_id [Integer] ID of the second trainer in Studio
  # @param bgm [String, Array] BGM to play for battle
  # @param disable [String] Name of the local switch to disable (if defeat)
  # @param enable [String] Name of the local switch to enable (if victory)
  # @param troop_id [Integer] ID of the troop to use : 3 = trainer, 4 = Gym Leader, 5 = Elite, 6 = Champion
  def start_double_trainer_battle(trainer_id, second_trainer_id, bgm: DEFAULT_TRAINER_BGM, disable: 'A', enable: 'B', troop_id: 3, &block)
  end
  # Start a trainer battle
  # @param trainer_id [Integer] ID of the trainer in Studio
  # @param second_trainer_id [Integer] ID of the second trainer in Studio
  # @param friend_trainer_id [Integer] ID of the friend trainer in Studio
  # @param bgm [String, Array] BGM to play for battle
  # @param disable [String] Name of the local switch to disable (if defeat)
  # @param enable [String] Name of the local switch to enable (if victory)
  # @param troop_id [Integer] ID of the troop to use : 3 = trainer, 4 = Gym Leader, 5 = Elite, 6 = Champion
  def start_double_trainer_battle_with_friend(trainer_id, second_trainer_id, friend_trainer_id, bgm: DEFAULT_TRAINER_BGM, disable: 'A', enable: 'B', troop_id: 3, &block)
  end
  # Sequence to call before start trainer battle
  # @param phrase [String] the full speech of the trainer
  # @param eye_bgm [String, Array, Integer] String => filepath, Array => filepath + volume + pitch, Integer => music from trainer resources
  # @param exclamation_se [String, Array] SE to play when the trainer detect the player
  # @example Simple eye sequence
  #   trainer_eye_sequence('Hello!')
  # @example Eye sequence with another eye_bgm
  #   trainer_eye_sequence('Hello!', eye_bgm: 'audio/bgm/pkmrs-enc7')
  def trainer_eye_sequence(phrase, eye_bgm: DEFAULT_EYE_BGM, exclamation_se: DEFAULT_EXCLAMATION_SE)
  end
  # Sequence that perform NPC trade
  # @param index [Integer] index of the Pokemon in the party
  # @param pokemon [PFM::Pokemon] Pokemon that is traded with
  def npc_trade_sequence(index, pokemon)
  end
  private
  def move_player_and_update_graphics
  end
  # Return the filename of the BGM depending on the parameter
  # @param eye_bgm [String, Array, Integer] String for direct filepath, integer for parsing the Studio database for the right file
  # @return [Array] the array containing the filepath of the BGM, the volume and the pitch
  def determine_eye_sequence_bgm(eye_bgm)
  end
  # Convert a trainer ID to something the Audio class will accept
  # @param id [Integer] the Studio trainer ID of the trainer
  # @return [String, nil] String if a music is properly setup, else nil
  def convert_trainer_id_to_bgm(id)
  end
  public
  # Open a shop
  # @overload open_shop(items, prices)
  #   @param symbol_or_list [Symbol]
  #   @param prices [Hash] (optional)
  # @overload open_shop(items,prices)
  #   @param symbol_or_list [Array<Integer, Symbol>]
  #   @param prices [Hash] (optional)
  def open_shop(symbol_or_list, prices = {}, show_background: true)
  end
  alias ouvrir_magasin open_shop
  # Create a limited shop (in the main PFM::Shop object)
  # @param symbol_of_shop [Symbol] the symbol to link to the new shop
  # @param items_sym [Array<Symbol, Integer>] the array containing the symbols/id of the items to sell
  # @param items_quantity [Array<Integer>] the array containing the quantity of the items to sell
  # @param shop_rewrite [Boolean] if the system must completely overwrite an already existing shop
  def add_limited_shop(symbol_of_shop, items_sym = [], items_quantity = [], shop_rewrite: false)
  end
  alias ajouter_un_magasin_limite add_limited_shop
  # Add items to a limited shop
  # @param symbol_of_shop [Symbol] the symbol of the existing shop
  # @param items_to_refill [Array<Symbol, Integer>] the array of the items' db_symbol/id
  # @param quantities_to_refill [Array<Integer>] the array of the quantity to refill
  def add_items_to_limited_shop(symbol_of_shop, items_to_refill = [], quantities_to_refill = [])
  end
  alias ajouter_objets_magasin add_items_to_limited_shop
  # Remove items from a limited shop
  # @param symbol_of_shop [Symbol] the symbol of the existing shop
  # @param items_to_remove [Array<Symbol, Integer>] the array of the items' db_symbol/id
  # @param quantities_to_remove [Array<Integer>] the array of the quantity to remove
  def remove_items_from_limited_shop(symbol_of_shop, items_to_remove, quantities_to_remove)
  end
  alias enlever_objets_magasin remove_items_from_limited_shop
  # Open a Pokemon shop
  # @overload open_shop(items, prices)
  #   @param symbol_or_list [Symbol]
  #   @param prices [Hash] (optional)
  #   @param show_background [Boolean] (optional)
  # @overload open_shop(items,prices)
  #   @param symbol_or_list [Array<Integer, Symbol>]
  #   @param prices [Array<Integer>]
  #   @param param [Array<Hash, Integer>]
  #   @param show_background [Boolean] (optional)
  def pokemon_shop_open(symbol_or_list, prices = [], param = [], show_background: true)
  end
  alias ouvrir_magasin_pokemon pokemon_shop_open
  # Create a limited Pokemon Shop
  # @param sym_new_shop [Symbol] the symbol to link to the new shop
  # @param list_id [Array<Integer>] the array containing the id of the Pokemon to sell
  # @param list_price [Array<Integer>] the array containing the prices of the Pokemon to sell
  # @param list_param [Array] the array containing the infos of the Pokemon to sell
  # @param list_quantity [Array<Integer>] the array containing the quantity of the Pokemon to sell
  # @param shop_rewrite [Boolean] if the system must completely overwrite an already existing shop
  def add_new_pokemon_shop(sym_new_shop, list_id, list_price, list_param, list_quantity = [], shop_rewrite: false)
  end
  alias ajouter_nouveau_magasin_pokemon add_new_pokemon_shop
  # Add Pokemon to a Pokemon Shop
  # @param symbol_of_shop [Symbol] the symbol of the shop
  # @param list_id [Array<Integer>] the array containing the id of the Pokemon to sell
  # @param list_price [Array<Integer>] the array containing the prices of the Pokemon to sell
  # @param list_param [Array] the array containing the infos of the Pokemon to sell
  # @param list_quantity [Array<Integer>] the array containing the quantity of the Pokemon to sell
  # @param pkm_rewrite [Boolean] if the system must completely overwrite the existing Pokemon
  def add_pokemon_to_shop(symbol_of_shop, list_id, list_price, list_param, list_quantity = [], pkm_rewrite: false)
  end
  alias ajouter_pokemon_au_magasin add_pokemon_to_shop
  # Remove Pokemon from a Pokemon Shop
  # @param symbol_of_shop [Symbol] the symbol of the existing shop
  # @param remove_list_mon [Array<Integer>] the array of the Pokemon id
  # @param param_form [Array<Hash>] the form of the Pokemon to delete (only if there is more than one form of a Pokemon in the list)
  # @param quantities_to_remove [Array<Integer>] the array of the quantity to remove
  def remove_pokemon_from_shop(symbol_of_shop, remove_list_mon, param_form, quantities_to_remove = [])
  end
  alias enlever_pokemon_du_magasin remove_pokemon_from_shop
  public
  # Save the bag somewhere and make it empty in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_bag
  # @author Beef'
  def empty_and_save_bag(id_storage = nil)
  end
  # Retrieve the saved bag when emptied ( /!\ empty the current bag)
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_bag
  # @author Beef'
  def retrieve_saved_bag(id_storage = nil)
  end
  # Combined the saved bag with the current bag
  # @param id_storage [String] the specific name of the storage, if nil $storage.other_bag is picked
  # @author Beef'
  def combine_with_saved_bag(id_storage = nil)
  end
  # Save the trainer somewhere and make it empty in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_trainer
  # @author Beef'
  def empty_and_save_trainer(id_storage = nil)
  end
  # Retrieve the saved trainer 
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_trainer
  # @author Beef'
  def retrieve_saved_trainer(id_storage = nil)
  end
  # Save the pokedex somewhere and make it empty in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_pokedex
  # @author Beef'
  def empty_and_save_pokedex(id_storage = nil)
  end
  # Retrieve the saved pokedex when emptied
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_pokedex
  # @author Beef'
  def retrieve_saved_pokedex(id_storage = nil)
  end
  # Combined the saved pokedex with the current pokedex
  # @param id_storage [String] the specific name of the storage, if nil $storage.other_pokedex is picked
  # @author Beef'
  def combine_with_saved_pokedex(id_storage = nil, empty_pokedex: false)
  end
  # Save the money somewhere and make it null in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_money
  # @author Beef'
  def empty_and_save_money(id_storage = nil)
  end
  # Retrieve the saved money 
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_money
  # @author Beef'
  def retrieve_saved_money(id_storage = nil)
  end
  # Combined the saved money with the current money 
  # @param id_storage [String] the specific name of the storage, if nil $storage.other_money is picked
  # @author Beef'
  def combine_with_saved_money(id_storage = nil)
  end
  # Save the appearance somewhere and set the default in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_appearance
  # @author Beef'
  def empty_and_save_appearance(id_storage = nil)
  end
  # Retrieve the saved appearance 
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_appearance
  # @author Beef'
  def retrieve_saved_appearance(id_storage = nil)
  end
  # Save the team somewhere and make it empty in the point of view of the player.
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_party
  # @author Nuri Yuri
  def empty_and_save_party(id_storage = nil)
  end
  # Retrieve the saved team when emptied ( /!\ empty the current team)
  # @param id_storage [String] the specific name of the storage, if nil sent to $storage.other_party
  # @author Nuri Yuri
  def retrieve_saved_party(id_storage = nil)
  end
  alias retreive_saved_party retrieve_saved_party
  # Shows a character, a default name, and asks the player for their name
  # @param default_name [String] the default name pre-filled in the name input screen
  # @param character_filename [String] the character displayed in the window. Is looking in graphics/characters already.
  # @param max_char [Integer] the maximum number of characters allowed.
  # @author Invatorzen
  # Example: name_player("Yuri", "npc_Biker")
  def name_player(default_name, character_filename, max_char = 12, &block)
  end
  # Switch from one player to another, in term of party, trainer, money, pokedex and appearance (all optional)
  # @param from_player_id [String] the specific name of the storage to save to.
  # @param to_player_id [String] the specific name of the storage to load from.
  # @author Beef'
  def switch_player(from_player_id, to_player_id, switch_bag: true, switch_party: true, switch_trainer: true, switch_appearance: true, switch_money: true, switch_pokedex: true)
  end
  # Switch from one player to another, in term of party, trainer, money, pokedex and appearance (all optional)
  # The Yuki::Var::Current_Player_ID must be defined beforehand
  # @param to_player_id [String] the specific name of the storage to load from.
  # @author Beef'
  def switch_player_safe(to_player_id, switch_bag: true, switch_party: true, switch_trainer: true, switch_appearance: true, switch_money: true, switch_pokedex: true)
  end
end
