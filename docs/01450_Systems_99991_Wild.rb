module PFM
  # The wild battle management
  #
  # The main object is stored in $wild_battle and PFM.game_state.wild_battle
  class Wild_Battle
    # List of ability that force strong Pokemon to battle (Intimidation / Regard vif)
    WEAK_POKEMON_ABILITY = %i[intimidate keen_eye]
    # List of special wild battle that are actually fishing
    FISHING_BATTLES = %i[normal super mega]
    # List of Rod
    FISHING_TOOLS = %i[old_rod good_rod super_rod]
    # List of ability giving the max level of the pokemon we can encounter
    MAX_POKEMON_LEVEL_ABILITY = %i[hustle pressure vital_spirit]
    # Mapping allowing to get the correct tool based on the input
    TOOL_MAPPING = {normal: :old_rod, super: :good_rod, mega: :super_rod, rock: :rock_smash, headbutt: :headbutt}
    # List of Roaming Pokemon
    # @return [Array<PFM::Wild_RoamingInfo>]
    attr_reader :roaming_pokemons
    # List of Remaining creature groups
    # @return [Array<Studio::Group>]
    attr_reader :groups
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Get the history of the encounters wild Pokémon
    # @return [Array<Hash>]
    attr_reader :encounters_history
    # Create a new Wild_Battle manager
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state)
    end
    # Reset the wild battle
    def reset
    end
    # Load the groups of Wild Pokemon (map change/ time change)
    def load_groups
    end
    # Is a wild battle available ?
    # @return [Boolean]
    def available?
    end
    # Test if there's any fish battle available and start it if asked.
    # @param rod [Symbol] the kind of rod used to fish : :norma, :super, :mega
    # @param start [Boolean] if the battle should be started
    # @return [Boolean, nil] if there's a battle available
    def any_fish?(rod = :normal, start = false)
    end
    # Test if there's any hidden battle available and start it if asked.
    # @param rod [Symbol] the kind of rod used to fish : :rock, :headbutt
    # @param start [Boolean] if the battle should be started
    # @return [Boolean, nil] if there's a battle available
    def any_hidden_pokemon?(rod = :rock, start = false)
    end
    # Start a wild battle
    # @overload start_battle(id, level, *args)
    #   @param id [PFM::Pokemon] First Pokemon in the wild battle.
    #   @param level [Object] ignored
    #   @param args [Array<PFM::Pokemon>] other pokemon in the wild battle.
    #   @param battle_id [Integer] ID of the events to load for battle scenario
    # @overload start_battle(id, level, *args)
    #   @param id [Integer] id of the Pokemon in the database
    #   @param level [Integer] level of the first Pokemon
    #   @param args [Array<Integer, Integer>] array of id, level of the other Pokemon in the wild battle.
    #   @param battle_id [Integer] ID of the events to load for battle scenario
    def start_battle(id, level = 70, *others, battle_id: 1)
    end
    # Init a wild battle
    # @note Does not start the battle
    # @overload init_battle(id, level, *args)
    #   @param id [PFM::Pokemon] First Pokemon in the wild battle.
    #   @param level [Object] ignored
    #   @param args [Array<PFM::Pokemon>] other pokemon in the wild battle.
    # @overload init_battle(id, level, *args)
    #   @param id [Integer] id of the Pokemon in the database
    #   @param level [Integer] level of the first Pokemon
    #   @param args [Array<Integer, Integer>] array of id, level of the other Pokemon in the wild battle.
    def init_battle(id, level = 70, *others)
    end
    # Set the Battle::Info with the right information
    # @param battle_id [Integer] ID of the events to load for battle scenario
    # @return [Battle::Logic::BattleInfo, nil]
    def setup(battle_id = 1)
    end
    # Define a group of remaining wild battle
    # @param zone_type [Integer] type of the zone, see $env.get_zone_type to know the id
    # @param tag [Integer] terrain_tag on which the player should be to start a battle with wild Pokemon of this group
    # @param delta_level [Integer] the disparity of the Pokemon levels
    # @param vs_type [Integer] the vs_type the Wild Battle are
    # @param data [Array<Integer, Integer, Integer>, Array<Integer, Hash, Integer>] Array of id, level/informations, chance to see (Pokemon informations)
    def set(zone_type, tag, delta_level, vs_type, *data)
    end
    # Test if a Pokemon is a roaming Pokemon (Usefull in battle)
    # @param pokemon [PFM::Pokemon]
    # @return [Boolean]
    def roaming?(pokemon)
    end
    alias is_roaming? roaming?
    # Add a roaming Pokemon
    # @param chance [Integer] the chance divider to see the Pokemon
    # @param proc_id [Integer] ID of the Wild_RoamingInfo::RoamingProcs
    # @param pokemon_hash [Hash, PFM::Pokemon] hash to generate the mon (cf. PFM::Pokemon#generate_from_hash), or the Pokemon
    # @return [PFM::Pokemon] the generated roaming Pokemon
    def add_roaming_pokemon(chance, proc_id, pokemon_hash)
    end
    # Remove a roaming Pokemon from the roaming Pokemon array
    # @param pokemon [PFM::Pokemon] the Pokemon that should be removed
    def remove_roaming_pokemon(pokemon)
    end
    # Ability that increase the rate of any fishing rod # Glue / Ventouse
    FishIncRate = %i[sticky_hold suction_cups]
    # Check if a Pokemon can be fished there with a specific fishing rod type
    # @param type [Symbol] :mega, :super, :normal
    # @return [Boolean]
    def check_fishing_chances(type)
    end
    # yield a block on every available roaming Pokemon
    def each_roaming_pokemon
    end
    # Tell the roaming pokemon that the playe has look at their position
    def on_map_viewed
    end
    # Reset the history of the encounters wild Pokémon
    def reset_encounters_history
    end
    # Compute the fishing chain
    # @return [Integer] The total fishing chain (max 20)
    def compute_fishing_chain
    end
    # Method that prevent non wanted data save of the Wild_Battle object
    def begin_save
    end
    # Method that end the save state of the Wild_Battle object
    def end_save
    end
    private
    # Test if a roaming battle is available
    # @return [Boolean]
    def roaming_battle_available?
    end
    # Test if a remaining battle is available
    # @return [Boolean]
    def remaining_battle_available?
    end
    # Function that returns the Creature ability of the Creature triggering all the stuff related to ability
    # @return [Symbol] db_symbol of the ability
    def creature_ability
    end
    # Get the current selected group
    # @return [Studio::Group, nil]
    def current_selected_group
    end
    # Add an encounter in the history
    # @param creature [PFM::Pokemon]
    # @param group [Studio::Group]
    def add_encounter_history(creature, group)
    end
    # Check and reset if necessary the history of the encounters
    # @param group [Studio::Group]
    def can_encounters_history_reset?(group)
    end
    public
    # Hash describing which method to seek to change the Pokemon chances depending on the player's leading Pokemon's talent
    CHANGE_POKEMON_CHANCE = {keen_eye: :rate_intimidate_keen_eye, intimidate: :rate_intimidate_keen_eye, cute_charm: :rate_cute_charm, magnet_pull: :rate_magnet_pull, compound_eyes: :rate_compound_eyes, super_luck: :rate_compound_eyes, static: :rate_static, lightning_rod: :rate_static, flash_fire: :rate_flash_fire, synchronize: :rate_synchronize, storm_drain: :rate_storm_drain, harvest: :rate_harvest}
    private
    # Configure the creature array for later selection
    # @param creatures [Array<PFM::Pokemon>]
    # @return [Array<Array(PFM::Pokemon, Float)>] all creatures with their rate to get selected
    def configure_creature(creatures)
    end
    # Get rate for Intimidate/Keen Eye cases
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_intimidate_keen_eye(creature, main_creature)
    end
    # Get rate for Cute Charm case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_cute_charm(creature, main_creature)
    end
    # Get rate for Magnet Pull case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_magnet_pull(creature, main_creature)
    end
    # Get rate for Compound Eyes case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_compound_eyes(creature, main_creature)
    end
    # Get rate for Statik case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_static(creature, main_creature)
    end
    # Get rate for Storm Drain case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_storm_drain(creature, main_creature)
    end
    # Get rate for Flash Fire case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_flash_fire(creature, main_creature)
    end
    # Get rate for Harvest case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_harvest(creature, main_creature)
    end
    # Get rate for Synchronize case
    # @param creature [PFM::Pokemon] creature to select
    # @param main_creature [PFM::Pokemon] pokemon that caused the rate verification
    # @return [Float] new rate or 1
    def rate_synchronize(creature, main_creature)
    end
    # Select the creatures that will be in the battle
    # @param group [Studio::Group] the descriptor of the Wild group
    # @param creature_to_select [Array<Array(PFM::Pokemon, Float)>] list of Pokemon to select with their rates
    # @return [Array<PFM::Pokemon>]
    def select_creature(group, creature_to_select)
    end
    # Configure the wild battle
    # @param enemy_arr [Array<PFM::Pokemon>]
    # @param battle_id [Integer] ID of the events to load for battle scenario
    # @return [Battle::Logic::BattleInfo]
    def configure_battle(enemy_arr, battle_id)
    end
    # Configurate the ally trainer for the Wild Battle if an ally is specified
    # @param bi [Battle::Logic::BattleInfo]
    # @param allied_trainer_id [Integer]
    def add_ally_trainer(bi, allied_trainer_id)
    end
    # Check if repel is active
    # @return [Boolean]
    def repel_active?
    end
    # Check if the battle is a fishing battle
    # @return [Boolean]
    def fishing_battle?
    end
    public
    # List of abilities increasing the frequency of encounter
    ENCOUNTER_FREQ_INCREASE = {}
    # List of abilities decreasing the frequency of encounter
    ENCOUNTER_FREQ_DECREASE = {}
    # Make the encounter count for each groups
    # @param only_less_than_one [Boolean] if the function should only update the group encounter count that are less or equal than 1
    def make_encounter_count(only_less_than_one = false)
    end
    # Update encounter count for each groups
    def update_encounter_count
    end
    # Detect if a group has encounter
    # @return [Boolean]
    def group_encounter_detected?
    end
    # Get the index of the groups that might trigger a battle due to encounter steps depleted
    # @return [Array<Integer>]
    def detected_group_encounter_indexes
    end
    private
    # Compute the encounter count from average steps
    def encounter_count_from_average_steps(average_steps)
    end
    # Compute the encounter count factor
    # @return [Float, Integer]
    def encounter_count_factor
    end
    class << self
      # Register an ability that increase the encounter frequency
      # @param ability_db_symbol [Symbol, Array<Symbol>] db_symbol of the ability that increase the encounter frequency
      # @param block [Proc, nil] Additional condition needed to validate the ability effect
      def register_frequency_increase_ability(ability_db_symbol, &block)
      end
      # Register an ability that decrease the encounter frequency
      # @param ability_db_symbol [Symbol, Array<Symbol>] db_symbol of the ability that decrease the encounter frequency
      # @param block [Proc, nil] Additional condition needed to validate the ability effect
      def register_frequency_decrease_ability(ability_db_symbol, &block)
      end
    end
  end
  # Retro compatibility with saves
  Wild_Info = Object
  class GameState
    # The information about the Wild Battle
    # @return [PFM::Wild_Battle]
    attr_accessor :wild_battle
    on_player_initialize(:wild_battle) {@wild_battle = PFM::Wild_Battle.new(self) }
    on_expand_global_variables(:wild_battle) do
      $wild_battle = @wild_battle
      @wild_battle.game_state = self
    end
  end
  # Wild Roaming Pokemon informations
  # @author Nuri Yuri
  class Wild_RoamingInfo
    # The tag in which the Roaming Pokemon will appear
    # @return [Integer]
    attr_accessor :tag
    # The system_tag zone ID in which the Roaming Pokemon will appear
    # @return [Integer]
    attr_accessor :zone_type
    # The ID of the map in which the Roaming Pokemon will appear
    # @return [Integer]
    attr_accessor :map_id
    # The roaming Pokemon
    # @return [PFM::Pokemon]
    attr_reader :pokemon
    # The spotted state of the pokemon. True if the player look at the map position or after fighting the roaming pokemon
    # @return [Boolean]
    attr_accessor :spotted
    @@locked = true
    # Allow roaming informations to be updated
    def self.unlock
    end
    # Disallow roaming informations to be updated
    def self.lock
    end
    # Create a new Wild_RoamingInfo
    # @param pokemon [PFM::Pokemon] the roaming Pokemon
    # @param chance [Integer] the chance divider to see the Pokemon
    # @param zone_proc_id [Integer] ID of the Wild_RoamingInfo::RoamingProcs
    def initialize(pokemon, chance, zone_proc_id)
    end
    # Call the Roaming Proc to update the Roaming Pokemon zone information
    def update
    end
    # Test if the Pokemon is dead (delete from the stack)
    # @return [Boolean]
    def pokemon_dead?
    end
    # Test if the Roaming Pokemon is appearing (to start the battle)
    # @return [Boolean]
    def appearing?
    end
    # Test if the Roaming Pokemon could appear here
    # @return [Boolean]
    def could_appear?
    end
  end
end
Graphics.on_start do
  PFM::Wild_Battle.register_frequency_increase_ability(%i[no_guard illuminate arena_trap])
  PFM::Wild_Battle.register_frequency_decrease_ability(%i[white_smoke quick_feet stench])
  PFM::Wild_Battle.register_frequency_decrease_ability(:snow_cloak) {$env.hail? }
  PFM::Wild_Battle.register_frequency_decrease_ability(:sand_veil) {$env.sandstorm? }
end
# The procs of Roaming Pokemon.
#
# The proc takes the Wild_RoamingInfo in parameter and change the informations.
::PFM::Wild_RoamingInfo::RoamingProcs = [proc do |infos|
  infos.map_id = 1
  infos.zone_type = 1
  infos.tag = 1
end, proc do |infos|
  maps = [5, 20]
  if (infos.map_id == $game_map.map_id && infos.spotted) || infos.map_id == -1
    infos.map_id = (maps - [infos.map_id]).sample
    infos.spotted = false
  end
  infos.zone_type = 1
  infos.tag = 0
end]
