class Object
  # Parse a text from the text database with specific informations and a pokemon
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param pokemon [PFM::Pokemon] pokemon that will introduce an offset on text_id (its name is also used)
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text_with_pokemon(file_id, text_id, pokemon, additionnal_var = nil)
    PFM::Text.parse_with_pokemon(file_id, text_id, pokemon, additionnal_var)
  end
  # Parse a text from the text database with 2 pokemon & specific information
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param pokemon1 [PFM::Pokemon] pokemon we're talking about
  # @param pokemon2 [PFM::Pokemon] pokemon who originated the "problem" (eg. bind)
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text_with_2pokemon(file_id, text_id, pokemon1, pokemon2, additionnal_var = nil)
    PFM::Text.parse_with_2pokemon(file_id, text_id, pokemon1, pokemon2, additionnal_var)
  end
  # Parse a text from the text database with specific informations
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text(file_id, text_id, additionnal_var = nil)
    PFM::Text.parse(file_id, text_id, additionnal_var)
  end
  # Get a text front the text database
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @return [String] the text
  def text_get(file_id, text_id)
    Studio::Text.get(file_id, text_id)
  end
  # Get a list of text from the text database
  # @param file_id [Integer] ID of the text file
  # @return [Array<String>] the list of text contained in the file.
  def text_file_get(file_id)
    Studio::Text.get_file(file_id)
  end
  # Clean an array containing object responding to #name (force utf-8)
  # @param arr [Array<#name>]
  # @return [arr]
  def _clean_name_utf8(arr)
    utf8 = Encoding::UTF_8
    arr.each { |o| o&.name&.force_encoding(utf8) }
    return arr
  end
  # Get a text front the external text database
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @return [String] the text
  def ext_text(file_id, text_id)
    Studio::Text.get_external(file_id, text_id)
  end
  # Play decision SE
  def play_decision_se
    $game_system&.se_play($data_system&.decision_se)
  end
  # Play cursor SE
  def play_cursor_se
    $game_system&.se_play($data_system&.cursor_se)
  end
  # Play buzzer SE
  def play_buzzer_se
    $game_system&.se_play($data_system&.buzzer_se)
  end
  # Play cancel SE
  def play_cancel_se
    $game_system&.se_play($data_system&.cancel_se)
  end
  # Play the Equip SE
  def play_equip_se
    $game_system&.se_play($data_system&.equip_se)
  end
  # Play the Shop SE
  def play_shop_se
    $game_system&.se_play($data_system&.shop_se)
  end
  # Play the Save SE
  def play_save_se
    $game_system&.se_play($data_system&.save_se)
  end
  # Play the Load SE
  def play_load_se
    $game_system&.se_play($data_system&.load_se)
  end
  # Play the Escape SE
  def play_escape_se
    $game_system&.se_play($data_system&.escape_se)
  end
  # Play the Actor collapse SE
  def play_actor_collapse_se
    $game_system&.se_play($data_system&.actor_collapse_se)
  end
  # Play the Enemy collapse SE
  def play_enemy_collapse_se
    $game_system&.se_play($data_system&.enemy_collapse_se)
  end
  # Attempt to get for the battles
  # @param rate [Float] number between 0 & 1 telling how much chance we have
  # @param logic [Battle::Logic]
  # @return [Boolean]
  def bchance?(rate, logic = nil)
    logic ||= @logic || ($scene.is_a?(Battle::Scene) ? $scene.logic : nil)
    raise 'bchance? called outside of Battle!' unless logic
    return logic.generic_rng.rand < rate
  end
end
# Module holding all the scenes of the game
module GamePlay
  class << self
    # Get the current scene
    # @return [Base]
    # @raise [TypeError] if the current scene is not a Base (should not happen under normal circumstance)
    def current_scene
      raise TypeError, 'Current scene is not a GamePlay::Base' unless $scene.is_a?(Base)
      return $scene
    end
    # Get the menu scene mixin
    # @return [Class<MenuMixin>]
    attr_accessor :menu_mixin
    # Get the menu scene
    # @return [Class<Menu>]
    attr_accessor :menu_class
    # Open the menu class
    # @yieldparam menu_scene [MenuMixin]
    def open_menu(&block)
      current_scene.call_scene(menu_class, &block)
    end
    # Get the current bag scene mixin (telling IO)
    # @return [Module<BagMixin>]
    attr_accessor :bag_mixin
    # Get the current bag scene
    # @return [Class<Bag>]
    attr_accessor :bag_class
    # Get the current battle bag class
    # @return [Class<Battle_Bag>]
    attr_accessor :battle_bag_class
    # Open the Bag UI (let the player manage what he wants to do in the bag)
    def open_bag
      current_scene.call_scene(bag_class)
    end
    # Open the Battle Bag UI (and let the player choose an item)
    # @param team [Array<PFM::PokemonBattler>]
    # @yieldparam battle_bag_scene [BagMixin]
    def open_battle_bag(team, &block)
      current_scene.call_scene(battle_bag_class, team, &block)
    end
    # Open the Bag UI to give an item to a Pokemon
    # @yieldparam bag_scene [BagMixin]
    def open_bag_to_give_item_to_pokemon(&block)
      current_scene.call_scene(bag_class, :hold, &block)
    end
    # Open the Bag UI to plant a berry
    # @yieldparam bag_scene [BagMixin]
    def open_bag_to_plant_berry(&block)
      current_scene.call_scene(bag_class, :berry, &block)
    end
    # Open the Bag UI to sell item
    def open_bag_to_sell_item
      current_scene.call_scene(bag_class, :shop)
    end
    # Open the bag UI to choose any item
    # @yieldparam bag_scene [BagMixin]
    def open_bag_to_choose_item(&block)
      current_scene.call_scene(bag_class, :map, &block)
    end
    # Get the storage class
    # @return [Class<PokemonStorage>]
    attr_accessor :pokemon_storage_class
    # Get the storage scene mixin for trading
    # @return [Class<PokemonTradeStorage>]
    attr_accessor :pokemon_trade_storage_mixin
    # Get the storage class for trading
    # @return [Class<PokemonTradeStorageMixin>]
    attr_accessor :pokemon_trade_storage_class
    # Open the Pokemon Storage System UI
    def open_pokemon_storage_system
      current_scene.call_scene(pokemon_storage_class)
    end
    # Open the Pokemon Storage System UI for trade
    # @yieldparam pss_scene [PokemonTradeStorageMixin]
    def open_pokemon_storage_system_for_trade(&block)
      current_scene.call_scene(pokemon_trade_storage_class, &block)
    end
    # Get the Dex class
    # @return [Class<Dex>]
    attr_accessor :dex_class
    # Open the dex (to view any Pokemon)
    def open_dex
      current_scene.call_scene(dex_class)
    end
    # Open the dex to show a specific Pokemon
    # @param pokemon [PFM::Pokemon]
    def open_dex_to_show_pokemon(pokemon)
      current_scene.call_scene(dex_class, pokemon)
    end
    # Open the dex to show a specific page
    # @param page_id [Integer]
    def open_dex_to_show_page(page_id)
      current_scene.call_scene(dex_class, page_id)
    end
    # Get the party menu scene mixin
    # @return [Class<PartyMenuMixin>]
    attr_accessor :party_menu_mixin
    # Get the party menu scene
    # @return [Class<Party_Menu>]
    attr_accessor :party_menu_class
    # Open the party menu to see the Pokemon and manage them
    # @param party [Array<PFM::Pokemon>] party to manage
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu(party = PFM.game_state.actors, &block)
      current_scene.call_scene(party_menu_class, party, :menu, &block)
    end
    # Open the party menu to use an item over a Pokemon
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper] item_wrapper to use
    # @param party [Array<PFM::Pokemon>] party to manage
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_use_item(item_wrapper, party = PFM.game_state.actors, &block)
      current_scene.call_scene(party_menu_class, party, :item, item_wrapper, &block)
    end
    # Open the party menu to give a item to a Pokemon
    # @param item_db_symbol [Symbol, Integer] db_symbol of the item to use
    # @param party [Array<PFM::Pokemon>] party to manage
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_give_item_to_pokemon(item_db_symbol, party = PFM.game_state.actors, &block)
      item_id = data_item(item_db_symbol).id
      current_scene.call_scene(party_menu_class, party, :hold, item_id, &block)
    end
    # Open the party menu to switch a Pokemon into battle
    # @param party [Array<PFM::Pokemon>] party to manage
    # @param forced_switch [Boolean] if the switch is forced
    # @param cannot_switch_index [Integer, nil] Index of the trapped party member if a switch cannot happen
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_switch(party, forced_switch, cannot_switch_index, &block)
      current_scene.call_scene(party_menu_class, party, :battle, cannot_switch_index, no_leave: forced_switch, &block)
    end
    # Open the party menu to select a Pokemon
    # @param party [Array<PFM::Pokemon>] party to manage
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_select_pokemon(party, &block)
      current_scene.call_scene(party_menu_class, party, :map, &block)
    end
    # Open the party menu to select a party
    # @param party [Array<PFM::Pokemon>] party to in which you want to pick Pokemon
    # @param amount [Integer] amount of Pokemon to select
    # @param excluded_pokemon [Array<Symbol>, nil] list of Pokemon db_symbol that are not allowed
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_select_a_party(party, amount, excluded_pokemon = nil, &block)
      PFM.game_state.game_variables[Yuki::Var::Max_Pokemon_Select] = amount
      excluded_pokemon_ids = excluded_pokemon&.map { |symbol| data_creature(symbol).id }
      current_scene.call_scene(party_menu_class, party, :select, excluded_pokemon_ids, &block)
    end
    # Open the party menu to absofusion Pokemons
    # @param party [Array<PFM::Pokemon>] party that contains the Pokemon to absofusion
    # @param pokemon_db_symbol [Symbol] db_symbol of the Pokemon to fusion
    # @param allowed_db_symbol [Array<Symbol>] list of Pokemon allowed to fusion with the Pokemon to fusion
    def open_party_menu_to_absofusion_pokemon(party, pokemon_db_symbol, allowed_db_symbol)
      current_scene.call_scene(party_menu_class, party, :absofusion, [pokemon_db_symbol, allowed_db_symbol])
    end
    # Open the party menu to separate Pokemons
    # @param party [Array<PFM::Pokemon>] party that contains the Pokemon to separate
    # @param pokemon_db_symbol [Symbol] db_symbol of the Pokemon to separate
    def open_party_menu_to_separate_pokemon(party, pokemon_db_symbol)
      current_scene.call_scene(party_menu_class, party, :separate, pokemon_db_symbol)
    end
    # Open the party menu to revive Pokemons
    # @param party [Array<PFM::Pokemon>] party that contains the Pokemon to revive
    # @yieldparam party_menu_scene [PartyMenuMixin]
    def open_party_menu_to_revive_pokemon(party, &block)
      current_scene.call_scene(party_menu_class, party, :revival_blessing, &block)
    end
    # Get the Summary scene
    # @return [Class<Summary>]
    attr_accessor :summary_class
    # Open the summary of a Pokemon
    # @param pokemon [PFM::Pokemon] pokemon to view
    # @param party [Array<PFM::Pokemon>] party of the pokemon to view
    def open_summary(pokemon, party = [pokemon])
      party = party.compact
      party.insert(0, pokemon) unless party.include?(pokemon)
      current_scene.call_scene(summary_class, pokemon, :view, party)
    end
    # Get the payer information scene
    # @return [Class<TCard>]
    attr_accessor :player_info_class
    # Open the player information scene
    def open_player_information
      current_scene.call_scene(player_info_class)
    end
    # Get the option setting scene mixin
    # @return [Class<OptionsMixin>]
    attr_accessor :options_mixin
    # Get the option setting scene
    # @return [Class<Options>]
    attr_accessor :options_class
    # Open the option scene
    # @yieldparam option_scene [OptionsMixin]
    def open_options(&block)
      current_scene.call_scene(options_class, &block)
    end
    # Get the item shop scene
    # @return [Class<Shop>]
    attr_accessor :shop_class
    # Get the pokemon shop scene
    # @return [Class<Pokemon_Shop>]
    attr_accessor :pokemon_shop_class
    # Open the shop scene
    # @param item_list [Array<Integer>] list of item to sell
    # @param price_overwrites [Hash{ Integer => Integer }] price for each items (id)
    # @param show_background [Boolean] if background is shown
    def open_shop(item_list, price_overwrites = {}, show_background: true)
      current_scene.call_scene(shop_class, item_list, price_overwrites, show_background: show_background)
    end
    # Open the shop using a limited shop stored in game_state.shop
    # @param shop_symbol [Symbol] symbol of the shop in game_state.shop
    # @param price_overwrites [Hash{ Integer => Integer }] price for each items (id)
    # @param show_background [Boolean] if background is shown
    def open_existing_shop(shop_symbol, price_overwrites = {}, show_background: true)
      current_scene.call_scene(shop_class, shop_symbol, price_overwrites, show_background: show_background)
    end
    # Open the pokemon shop scene
    # @param pokemon_ids [Array<Integer>]
    # @param pokemon_prices [Array<Integer>]
    # @param pokemon_levels [Array<Integer, Hash>]
    # @param show_background [Boolean] if background is shown
    def open_pokemon_shop(pokemon_ids, pokemon_prices, pokemon_levels, show_background: true)
      current_scene.call_scene(pokemon_shop_class, pokemon_ids, pokemon_prices, pokemon_levels, show_background: show_background)
    end
    # Open the Pokemon shop scene using a limited shop stored in game_state.shop
    # @param shop_symbol [Symbol] symbol of the shop in game_state.shop
    # @param price_overwrites [Hash{ Integer => Integer }] price for each Pokemon (id)
    # @param show_background [Boolean] if background is shown
    def open_existing_pokemon_shop(shop_symbol, price_overwrites = {}, show_background: true)
      current_scene.call_scene(pokemon_shop_class, shop_symbol, price_overwrites, show_background: show_background)
    end
    # Get the hall of fame scene
    # @return [Class<Hall_of_Fame>]
    attr_accessor :hall_of_fame_class
    # Open the hall of fame scene
    # @param filename_bgm [String] the bgm to play during the Hall of Fame
    # @param context_of_victory [Symbol] the symbol to put as the context of victory
    def open_hall_of_fame(filename_bgm = 'audio/bgm/Hall-of-Fame', context_of_victory = :league)
      current_scene.call_scene(hall_of_fame_class, filename_bgm, context_of_victory)
    end
    # Get the string input scene mixin
    # @return [Class<NameInputMixin>]
    attr_accessor :string_input_mixin
    # Get the string input scene
    # @return [Class<NameInput>]
    attr_accessor :string_input_class
    # Open the name input for a character/player
    # @param default_name [String]
    # @param max_char [Integer]
    # @param character_filename [String, nil]
    # @yieldparam [NameInputMixin]
    def open_character_name_input(default_name, max_char, character_filename, custom_message = nil, &block)
      custom_message ||= [43, 0] if PFM.game_state.game_temp.name_actor_id == 1
      phrase = custom_message && text_get(*custom_message)
      current_scene.call_scene(string_input_class, default_name, max_char, character_filename, phrase: phrase, &block)
    end
    # Open the name input for a Pokemon
    # @param pokemon [PFM::Pokemon]
    # @param num_char [Integer] the number of character the Pokemon can have in its name.
    # @yieldparam [NameInputMixin]
    def open_pokemon_name_input(pokemon, num_char = 12, &block)
      PFM::Text.set_pkname(pokemon.name)
      phrase = PFM::Text.parse(43, 5)
      current_scene.call_scene(string_input_class, pokemon.given_name, num_char, pokemon, phrase: phrase, &block)
    end
    # Open the name input for a box
    # @param box_name [String]
    # @param max_char [Integer]
    # @param box_filename [String]
    # @yieldparam [NameInputMixin]
    def open_box_name_input(box_name, max_char = 12, box_filename = 'pc_psdk', &block)
      phrase = text_get(43, 10)
      current_scene.call_scene(string_input_class, box_name, max_char, box_filename, phrase: phrase, &block)
    end
    # Get the move teaching scene mixin
    # @return [Class<MoveTeachingMixin>]
    attr_accessor :move_teaching_mixin
    # Get the move teaching scene
    # @return [Class<MoveTeaching>]
    attr_accessor :move_teaching_class
    # Open the move teaching scene
    # @param pokemon [PFM::Pokemon] pokemon to teach the move
    # @param skill [Symbol, Integer] db_symbol of the skill to learn
    # @yieldparam move_teaching_scene [MoveTeachingMixin]
    def open_move_teaching(pokemon, skill, &block)
      current_scene.call_scene(move_teaching_class, pokemon, skill, &block)
    end
    # Get the move reminder scene mixin
    # @return [Class<MoveReminderMixin>]
    attr_accessor :move_reminder_mixin
    # Get the move reminder scene
    # @return [Class<Move_Reminder>]
    attr_accessor :move_reminder_class
    # Open the move reminder scene
    # @param pokemon [PFM::Pokemon] pokemon to remind a move
    # @param mode [Integer] 0 = bread_moves + learnt + potentially_learnt, 2 = all moves, other = learnt + potentially_learnt
    # @yieldparam move_teaching_scene [MoveReminderMixin]
    def open_move_reminder(pokemon, mode = 0, &block)
      current_scene.call_scene(move_reminder_class, pokemon, mode, &block)
    end
    # Get the evolve scene mixin
    # @return [Class<EvolveMixin>]
    attr_accessor :evolve_mixin
    # Get the evolve scene
    # @return [Class<Evolve>]
    attr_accessor :evolve_class
    # Get the hatch scene
    # @return [Class<Hatch>]
    attr_accessor :hatch_class
    # Open the evolve scene
    # @param pokemon [PFM::Pokemon] pokemon to evolve
    # @param id [Integer] ID of the evolution
    # @param form [Integer, nil] form of the evolution
    # @param forced [Boolean] if the evolution is forced
    # @yieldparam [EvolveMixin]
    def make_pokemon_evolve(pokemon, id, form = nil, forced = false, &block)
      current_scene.call_scene(evolve_class, pokemon, id, form, forced, &block)
    end
    # Open the hatch scene
    # @param pokemon [PFM::Pokemon] pokemon to hatch
    def make_egg_hatch(pokemon)
      current_scene.call_scene(hatch_class, pokemon)
    end
    # Get the town map scene
    # @return [Class<WorldMap>]
    attr_accessor :town_map_class
    # Open the town map
    # @param world_map_id [Integer] ID of the worldmap to view
    def open_town_map(world_map_id = PFM.game_state.env.get_worldmap)
      current_scene.call_scene(town_map_class, :view, world_map_id, :map)
    end
    # Open the town map to use fly
    # @param world_map_id [Integer] ID of the worldmap to view
    # @param pokemon [PFM::Pokemon, Symbol] Pokemon that uses fly
    def open_town_map_to_fly(world_map_id = PFM.game_state.env.get_worldmap, pokemon = :map)
      current_scene.call_scene(town_map_class, :fly, world_map_id, pokemon)
    end
    # Get the shortcut scene
    # @return [Class<Shortcut>]
    attr_accessor :shortcut_class
    # Open the shortcut scene
    def open_shortcut
      current_scene.call_scene(shortcut_class)
    end
    # Get the Quest scene
    # @return [Class<QuestUI>]
    attr_accessor :quest_ui_class
    # Open the QuestUI scene
    def open_quest_ui(quests = PFM.game_state.quests)
      current_scene.call_scene(quest_ui_class, quests)
    end
    # Get the HMBarScene scene
    # @return [Class<HMBarScene>]
    attr_accessor :hm_bar_scene_class
    def open_hm_bar_scene(reason, scene_to_update = nil)
      current_scene.call_scene(hm_bar_scene_class, reason, scene_to_update)
    end
  end
end
# Module that define inGame data / script interface
module PFM
  class << self
    # Get the game state
    # @return [GameState]
    attr_accessor :game_state
    # Get the class handling the bag data in the game
    # @return [Class<Bag>]
    attr_accessor :bag_class
    # Get the class handling the Pokemon Storage System data in the game
    # @return [Class<Storage>]
    attr_accessor :storage_class
    # Get the class handling the Dex data in the game
    # @return [Class<Pokedex>]
    attr_accessor :dex_class
    # Get the class handling the player info in the game
    # @return [Class<Trainer>]
    attr_accessor :player_info_class
    # Get the class handling the option in the game
    # @return [Class<Options>]
    attr_accessor :options_class
    # Get the class handling the daycare in the game
    # @return [Class<Daycare>]
    attr_accessor :daycare_class
    # Get the class handling the environment in the game
    # @return [Class<Environment>]
    attr_accessor :environment_class
    # Get the class handling the shop in the game
    # @return [Class<Shop>]
    attr_accessor :shop_class
    # Get the class handling the nuzlocke in the game
    # @return [Class<Nuzlocke>]
    attr_accessor :nuzlocke_class
    # Get the class handling the hall of fame in the game
    # @return [Class<Hall_of_Fame>]
    attr_accessor :hall_of_fame_class
  end
end
# Class in charge of generating random numbers
#
# Here PSDK will store constants to make separate random generators
class Random
  # WILD_BATTLE random generator
  WILD_BATTLE = new
  # IV hp random generator
  IV_HP = new
  # IV atk random generator
  IV_ATK = new
  # IV dfe random generator
  IV_DFE = new
  # IV spd random generator
  IV_SPD = new
  # IV ats random generator
  IV_ATS = new
  # IV dfs random generator
  IV_DFS = new
  # Mining Game's items random generator
  MINING_GAME_ITEM = new
  # Mining Game's tiles random generator
  MINING_GAME_TILES = new
  # Mining Game's obstacles random generator
  MINING_GAME_OBSTACLES = new
end
