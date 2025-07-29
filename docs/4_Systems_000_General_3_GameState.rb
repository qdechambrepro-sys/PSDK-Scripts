module PFM
  # The game informations and Party management
  #
  # The global object is stored in PFM.game_state
  # @author Nuri Yuri
  class GameState
    # Constant containing all the proc to call when creating a new GameState object (for battle)
    ON_INITIALIZE = {}
    # Constant containing all the proc to call when creating a new GameState object (for the player)
    ON_PLAYER_INITIALIZE = {}
    # Constant containing all the proc to call when expanding the global variables
    ON_EXPAND_GLOBAL_VARIABLES = {}
    class << self
      # Add a new proc on initialize (for battle)
      # @param name [Symbol] name of the block to add
      # @param block [Proc] proc to execute with the GameState context
      def on_initialize(name, &block)
      end
      # Add a new proc on player initialize (for the player)
      # @param name [Symbol] name of the block to add
      # @param block [Proc] proc to execute with the GameState context
      def on_player_initialize(name, &block)
      end
      # Add a new proc on global variable expand
      # @param name [Symbol] name of the block to add
      # @param block [Proc] proc to execute with the GameState context
      def on_expand_global_variables(name, &block)
      end
    end
    # The Pokemon of the Player
    # @return [Array<PFM::Pokemon>]
    attr_accessor :actors
    on_initialize(:actors) do
      @actors = []
    end
    on_expand_global_variables(:actors) do
      $actors = @actors
    end
    # The number of steps the repel will work
    # @return [Integer]
    attr_reader :repel_count
    on_initialize(:repel_count) {@repel_count = 0 }
    # The number of steps the player did
    # @return [Integer]
    attr_accessor :steps
    on_initialize(:steps) {@steps = 0 }
    # If the repel is on cooldown
    # @return [Boolean]
    attr_accessor :repel_step_cooldown
    on_initialize(:repel_step_cooldown) {@repel_step_cooldown = false }
    # The $game_variables
    # @return [Game_Variables]
    attr_accessor :game_variables
    on_player_initialize(:game_variables) do
      @game_variables = Game_Variables.new
      $game_variables ||= @game_variables
    end
    on_expand_global_variables(:game_variables) do
      $game_variables = @game_variables
    end
    # The $game_switches
    # @return [Game_Switches]
    attr_accessor :game_switches
    on_player_initialize(:game_switches) do
      @game_switches = Game_Switches.new
      $game_switches ||= @game_switches
    end
    on_expand_global_variables(:game_switches) do
      $game_switches = @game_switches
    end
    # The $game_self_switches
    # @return [Game_SelfSwitches]
    attr_accessor :game_self_switches
    on_player_initialize(:game_self_switches) {@game_self_switches = Game_SelfSwitches.new }
    on_expand_global_variables(:game_self_switches) do
      $game_self_switches = @game_self_switches
    end
    # The $game_self_variables
    # @return [Game_SelfVariables]
    attr_accessor :game_self_variables
    on_player_initialize(:game_self_variables) {@game_self_variables = Game_SelfVariables.new }
    on_expand_global_variables(:game_self_variables) do
      $game_self_variables = @game_self_variables
    end
    # The $game_system
    # @return [Game_System]
    attr_accessor :game_system
    on_player_initialize(:game_system) {@game_system = Game_System.new }
    on_expand_global_variables(:game_system) do
      $game_system = @game_system
    end
    # The $game_screen
    # @return [Game_Screen]
    attr_accessor :game_screen
    on_player_initialize(:game_screen) {@game_screen = Game_Screen.new }
    on_expand_global_variables(:game_screen) do
      $game_screen = @game_screen
    end
    # The $game_actors
    # @return [Game_Actors]
    attr_accessor :game_actors
    on_player_initialize(:game_actors) {@game_actors = Game_Actors.new }
    on_expand_global_variables(:game_actors) do
      $game_actors = @game_actors
    end
    # The $game_party
    # @return [Game_Party]
    attr_accessor :game_party
    on_player_initialize(:game_party) {@game_party = Game_Party.new }
    on_expand_global_variables(:game_party) do
      $game_party = @game_party
    end
    on_player_initialize(:game_troop) {@game_troop = Game_Troop.new }
    on_expand_global_variables(:game_troop) {$game_troop = @game_troop }
    # The $game_map
    # @return [Game_Map]
    attr_accessor :game_map
    on_player_initialize(:game_map) {@game_map = Game_Map.new }
    on_expand_global_variables(:game_map) do
      $game_map = @game_map
    end
    # The $game_player
    # @return [Game_Player]
    attr_accessor :game_player
    on_player_initialize(:game_player) {@game_player = Game_Player.new }
    on_expand_global_variables(:game_player) do
      $game_player = @game_player
    end
    # The $game_temp
    # @return [Game_Temp]
    attr_accessor :game_temp
    on_player_initialize(:game_temp) {@game_temp = Game_Temp.new }
    on_expand_global_variables(:game_temp) do
      $game_temp = @game_temp
    end
    # The nuzlocke logic
    # @return [Nuzlocke]
    attr_accessor :nuzlocke
    on_player_initialize(:nuzlocke) {@nuzlocke = PFM.nuzlocke_class.new(self) }
    on_expand_global_variables(:nuzlocke) do
      @nuzlocke ||= PFM.nuzlocke_class.new(self)
      @nuzlocke.graveyard ||= []
      @nuzlocke.game_state = self
    end
    # The pathfinding requests
    # @return [Array<Object>]
    attr_accessor :pathfinding_requests
    on_player_initialize(:pathfinding_requests) {@pathfinding_requests = Pathfinding::DEFAULT_SAVE }
    on_expand_global_variables(:pathfinding_requests) {@pathfinding_requests ||= Pathfinding::DEFAULT_SAVE }
    # Name of the time set to use (nil = default)
    # @return [Symbol, nil]
    attr_accessor :tint_time_set
    # User data
    # @return [Hash]
    attr_reader :user_data
    on_player_initialize(:user_data) {@user_data = {} }
    on_expand_global_variables(:user_data) do
      @user_data ||= {}
      $user_data = @user_data
    end
    # Maximum level an allied Pokemon can reach
    # @return [Integer]
    attr_accessor :level_max_limit
    on_player_initialize(:level_max_limit) {@level_max_limit = Configs.settings.max_level }
    on_expand_global_variables(:level_max_limit) {@level_max_limit ||= Configs.settings.max_level }
    # The in game berry data
    # @return [Hash]
    attr_accessor :berries
    on_player_initialize(:berries) {@berries = {} }
    # Create a new Pokemon Party
    # @param battle [Boolean] if its a party of a NPC battler
    # @param starting_language [String] the lang id of the game described by this object
    def initialize(battle = false, starting_language = 'en')
    end
    private
    # Initialize the game state variable
    def game_state_initialize
    end
    # Perform the RMXP bootup
    def rmxp_boot
    end
    public
    # Expand the global variable with the instance variables of the object
    def expand_global_var
    end
    # Update the processing of the repel
    def repel_update
    end
    # Update section to detect if a wild battle must start
    # @note this methods calls common event 1 if a battle must start
    def battle_starting_update
    end
    # Update the processing of the poison event
    def poison_update
    end
    # Abilities that increase the hatch speed
    FASTER_HATCH_ABILITIES = %i[magma_armor flame_body steam_engine]
    # Update the remaining steps of all the Egg to hatch
    def hatch_check_update
    end
    # Update the loyalty process of the pokemon
    def loyalty_update
    end
    # Tell if EventTasks can't process
    # @return [Boolean]
    def cant_process_event_tasks?
    end
    # Increase the @step and manage events that trigger each steps
    # @return [Array] informations about events that has been triggered.
    def increase_steps
    end
    # Change the repel_count
    # @param v [Integer]
    def repel_count=(v)
    end
    alias set_repel_count repel_count=
    alias get_repel_count repel_count
    # Tell the state of the cooldown provided by cancelling a Repel check
    # @return [Boolean]
    def repel_on_cooldown?
    end
    # Return the money the player has
    # @return [Integer]
    def money
    end
    # Change the money the player has
    # @param v [Integer]
    def money=(v)
    end
    # Add money
    # @param n [Integer] amount of money to add
    def add_money(n)
    end
    # Lose money
    # @param n [Integer] amount of money to lose
    def lose_money(n)
    end
    # Load some parameters (audio volume & text)
    def load_parameters
    end
    public
    # Return the size of the party
    # @return [Integer]
    def size
    end
    # Is the party empty ?
    # @return [Boolean]
    def empty?
    end
    # Is the party full ?
    # @return [Boolean]
    def full?
    end
    # Is the party not able to start a battle ?
    # @return [Boolean]
    def dead?
    end
    # Is the party able to start a battle ?
    # @return [Boolean]
    def alive?
    end
    # Number of pokemon alive in the party
    # @param max [Integer] the number of Pokemon to check from the begining of the party
    def pokemon_alive(max = @actors.size)
    end
    # Index of the first pokemon alive in the party
    def first_pokemon_alive_index
    end
    # Test if a specific Pokémon is able to fight or not
    # @param id [Integer] ID of the Pokemon
    # @return [Boolean]
    # @example Checking if Pikachu is alive in the party
    #   PFM.game_state.specific_alive?(25)
    # @example Checking if alolan Meowth is alive in the party
    #   PFM.game_state.specific_alive?(52) { |pokemon| pokemon.form == 1 }
    def specific_alive?(id)
    end
    # Add a Pokemon to the party (also update the Pokedex Informations)
    # @param pkmn [PFM::Pokemon]
    # @return [Boolean, Integer] Box index if stored in a box, false if failed, true if stored in the Party
    def add_pokemon(pkmn)
    end
    # Remove a pokemon from the party
    # @param var [Integer, Symbol] the var value (index or id)
    # @param by_id [Boolean] if the pokemon are removed by their id
    # @param all [Boolean] if every pokemon that has the id are removed
    def remove_pokemon(var, by_id = false, all = false)
    end
    # Switch pokemon in the party
    # @param first [Integer] index of the first pokemon to switch
    # @param second [Integer] index of the second pokemon to switch
    def switch_pokemon(first, second)
    end
    # Check if the player has a specific Pokemon in its party
    # @param id [Integer, Symbol] id of the Pokemon in the database
    # @param level [Integer, nil] the level required
    # @param form [Integer, nil] the form of the Pokemon
    # @param shiny [Boolean, nil] if the Pokemon should be shiny or not
    # @param index [Boolean] if you want an index when found
    # @return [Boolean, Integer] if the Pokemon has been found
    def contain_matching_pokemon?(id, level = nil, form = nil, shiny = nil, index: false)
    end
    alias has_pokemon? contain_matching_pokemon?
    # Check if the player has enough Pokemon to choose in its party
    # Doesn't count banned Pokemon
    # @param arr [Array] ids of the banned Pokemon
    def contain_enough_selectable_pokemon?(arr = [])
    end
    alias has_enough_selectable_pokemon? contain_enough_selectable_pokemon?
    # Find a specific Pokemon index in the party
    # @param id [Integer, Symbol] id of the Pokemon in the database
    # @param level [Integer, nil] the level required
    # @param form [Integer, nil] the form of the Pokemon
    # @param shiny [Boolean, nil] if the Pokemon should be shiny or not
    # @return [Integer, false] index of the Pokemon in the party
    def pokemon_index(id, level = nil, form = nil, shiny = nil)
    end
    # Heal the pokemon in the Party
    def heal_party
    end
    # Return the maximum level of the Pokemon in the Party
    # @return [Integer]
    def max_level
    end
    # Check if the party has a Pokemon with a specific skill
    # @param id [Integer, Symbol] ID of the skill in the database
    # @param index [Boolean] if the method return the index of the Pokemon that has the skill
    # @return [Boolean, Integer]
    def contain_pokemon_with_the_skill?(id, index = false)
    end
    alias has_skill? contain_pokemon_with_the_skill?
    # Get the index of the Pokemon that has the specified skill
    # @param id [Integer, Symbol] ID of the skill in the database
    # @return [Integer, false]
    def pokemon_skill_index(id)
    end
    # Check if the party has a Pokemon with a specific ability
    # @param id [Integer, Symbol] ID of the ability in the database
    # @param index [Boolean] if the method return the index of the Pokemon that has the ability
    # @return [Boolean, Integer]
    def contain_pokemon_with_the_ability?(id, index = false)
    end
    alias has_ability? contain_pokemon_with_the_ability?
    # Get the index of the Pokemon that has the specified ability
    # @param id [Integer, Symbol] ID of the ability in the database
    # @return [Integer, false]
    def pokemon_ability_index(id)
    end
    # Checks if one Pokemon of the party can learn the requested skill.
    # @overload can_learn?(id)
    #   @param id [Integer, Symbol] the id of the skill in the database
    #   @return [Boolean]
    # @overload can_learn?(id, index)
    #   Returns the position of the first pokemon that meets conditions
    #   @param id [Integer, Symbol] the id of the skill in the database
    #   @param index [true] indicating to return the index
    #   @return [Integer, false]
    def can_learn?(id, index = false)
    end
    # Return the index of the Pokemon who can learn the specified skill
    # @param id [Integer, Symbol] the id of the skill in the database
    # @return [Integer, false]
    def can_learn_index(id)
    end
    # Checks if one Pokemon of the party can learn or has learnt the requested skill.
    # @overload can_learn_or_learnt?(id)
    #   @param id [Integer, Symbol] the id of the skill in the database
    #   @return [Boolean]
    # @overload can_learn_or_learnt?(id, index)
    #   Returns the position of the first pokemon that meets conditions
    #   @param id [Integer, Symbol] the id of the skill in the database
    #   @param index [true] indicating to return the index
    #   @return [Integer, false]
    def can_learn_or_learnt?(id, index = false)
    end
    # Return the index of the Pokemon who can learn or has learn the specified skill
    # @param id [Integer, Symbol] the id of the skill in the database
    # @return [Integer, false]
    def can_learn_or_learnt_index(id)
    end
    # Return the Pokemon that match the specific criteria
    # @param criteria [Hash] list of property linked to a value to check in order to find the Pokemon
    # @return [PFM::Pokemon, nil]
    def find_pokemon(criteria)
    end
    # Return the two adjacent pokemon in the party of the provided pokemon.
    # @note Empty array is returned if the pokemon is alone in its party. One pokemon is returned if there are 2 pokemon in the party.
    # @note Empty array is returned if the provided pokemon is not in the party.
    # @param pokemon [PFM::Pokemon]
    # @return [Array<PFM::Pokemon>]
    def adjacent_in_party(pokemon)
    end
  end
  # Alias for old saves
  Pokemon_Party = GameState
end
# Global accessor for the game state
# @return [PFM::GameState, nil]
def game_state
end
