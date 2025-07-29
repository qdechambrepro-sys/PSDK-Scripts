module Battle
  # Module responsive of mocking the battle scene so nothing happen on the reality
  #
  # How to use:
  #   scene = @scene.clone
  #   scene.extend(SceneMock)
  #
  # Note: super inside this script might call the original function
  module SceneMock
    class << self
      # Method called when a scene gets mocked (through extend)
      # @param mod [Battle::Scene]
      def extended(mod)
      end
    end
    # Get the mock actions
    # @return [Array<Hash>]
    attr_reader :mock_actions
    # Function that pushes an action to the action array (thing that happens during execution)
    # @param data [Hash]
    def mock_push_action(data)
    end
    # Function that clears the mock actions
    def mock_clear_actions
    end
    def message_window
    end
    def display_message_and_wait(*)
    end
    def display_message(*)
    end
    def update
    end
  end
  # Module responsive of mocking the battle visual so nothing happen on the reality
  #
  # Note: super inside this script might call the original function
  module VisualMock
    class << self
      # Method called when a visual gets mocked (through extend)
      # @param mod [Battle::Visual]
      def extended(mod)
      end
    end
    # Lock the battle scene
    def lock
    end
    # Show the ability animation
    # @param target [PFM::PokemonBattler]
    def show_ability(target)
    end
    # Show the exp distribution
    # @param exp_data [Hash{ PFM::PokemonBattler => Integer }] info about experience each pokemon should receive
    def show_exp_distribution(exp_data)
    end
    # Method that show the pokemon choice
    # @param forced [Boolean]
    # @param cannot_switch_index [Integer, nil] Index of the trapped party member if a switch cannot happen
    # @return [PFM::PokemonBattler, nil]
    def show_pokemon_choice(forced = false, cannot_switch_index: nil)
    end
    # Show a dedicated animation
    # @param target [PFM::PokemonBattler]
    # @param id [Integer]
    def show_rmxp_animation(target, id)
    end
    # Show the item user animation
    # @param target [PFM::PokemonBattler]
    def show_item(target)
    end
    # Refresh a specific bar (when Pokemon loses HP or change state)
    # @param pokemon [PFM::PokemonBattler] the pokemon that was shown by the bar
    def refresh_info_bar(pokemon)
    end
    # Show HP animations
    # @param targets [Array<PFM::PokemonBattler>]
    # @param hps [Array<Integer>]
    # @param effectiveness [Array<Integer, nil>]
    # @param messages [Proc] messages shown right before the post processing
    def show_hp_animations(targets, hps, effectiveness = [], &messages)
    end
    # Show the pokemon switch form animation
    # @param target [PFM::PokemonBattler]
    def show_switch_form_animation(target)
    end
    # Set the state info
    # @param state [Symbol] kind of state (:choice, :move, :move_animation)
    # @param pokemon [Array<PFM::PokemonBattler>] optional list of Pokemon to show (move)
    def set_info_state(state, pokemon = nil)
    end
    # Wait for all animation to end (non parallel one)
    def wait_for_animation
    end
    # Hide team info
    def hide_team_info
    end
    # Make a move animation
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>]
    # @param move [Battle::Move]
    def show_move_animation(user, targets, move)
    end
  end
  # Module responsive of mocking the battle logic so nothing happen on the reality
  #
  # Note: super inside this script might call the original function
  module LogicMock
    class << self
      # Method called when a visual gets mocked (through extend)
      # @param mod [Battle::Logic]
      def extended(mod)
      end
      # Mock the effect handler
      # @param handler [Effects::EffectsHandler]
      # @param battlers [Array<PFM::PokemonBattler>]
      def mock_effect_handler(handler, battlers)
      end
    end
    # Get a new weather change handler
    # @return [Battle::Logic::WeatherChangeHandler]
    def weather_change_handler
    end
    # Get a new field terrain change handler
    # @return [Battle::Logic::WeatherChangeHandler]
    def fterrain_change_handler
    end
    # Get the env object
    # @return [PFM::Environnement]
    attr_reader :env
  end
  # Module holding the whole AI code
  module AI
    # Base class of AI, it holds the most important data
    class Base
      include Hooks
      # Get the scene that initialized the AI
      # @return [Battle::Scene]
      attr_reader :scene
      # Get the bank the AI controls
      # @return [Integer]
      attr_reader :bank
      # Get the party the AI controls
      # @return [Integer]
      attr_reader :party_id
      @ai_class_by_level = {}
      # Create a new AI instance
      # @param scene [Battle::Scene] scene that hold the logic object
      # @param bank [Integer] bank where the AI acts
      # @param party_id [Integer] ID of the party the AI look for Pokemon info
      # @param level [Integer] level of tha AI
      def initialize(scene, bank, party_id, level)
      end
      # Get the action the AI wants to do
      # @return [Array<Actions::Base>]
      def trigger
      end
      class << self
        # Register a new AI
        # @param level [Integer] level of the AI
        # @param klass [Class<Base>]
        def register(level, klass)
        end
        # Get a registered AI
        # @param level [Integer] level of the AI
        # @return [Class<Battle::AI::Base>]
        def registered(level)
        end
      end
      # Get all Pokemon in the party of the AI
      # @return [Array<PFM::PokemonBattler>]
      def party
      end
      # Get all the controlled Pokemon
      # @return [Array<PFM::PokemonBattler>]
      def controlled_pokemon
      end
      private
      # Try to find the battle action for a dedicated pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Actions::Base, Array<Actions::Base>]
      # @note Actions are internally structured this way in the action array: [heuristic, action]
      def battle_action_for(pokemon)
      end
      # Function that returns a mocked version of the scene
      # @return [Battle::Scene<Battle::SceneMock>]
      def mocked_scene
      end
      # Function responsive of initializing all the IA capatibility flags
      def init_capability
      end
      # Get all the move the pokemon can use
      # @param pokemon [PFM::PokemonBattler]
      # @return [Array<Battle::Move>]
      def usable_moves(pokemon)
      end
      # Function that check if the move is not usable
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Boolean] if the move should be rejeced from the moveset
      def move_unusable?(pokemon, move)
      end
      public
      private
      POWER_MEAN = 200.0
      POWER_STD = 150 * Math.sqrt(2)
      # Get the move heuristic for a move
      # @param move [Battle::Move]
      # @return [AI::MoveHeuristicBase]
      def move_heuristic_object(move)
      end
      # List all the possible action for a move
      # @param move [Battle::Move]
      # @param pokemon [PFM::PokemonBattler]
      # @return [Array<[Float, Battle::Actions::Base]>]
      def move_action_for(move, pokemon)
      end
      # Process the move heuristic
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Float]
      def move_heuristic(move, user, target)
      end
      # Process the move effectiveness
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Float]
      def move_effectiveness(move, user, target)
      end
      # Process the move power
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param effectiveness [Float]
      # @return [Float]
      def move_power(move, user, target, effectiveness)
      end
      # Process the move status modifier
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Float]
      def move_status_modifier(move, user, target)
      end
      # Group the move actions when they're hitting several targets
      # @param actions [Array]
      # @return [Array]
      def group_move_action(actions)
      end
      # Filter the target a move can aim
      # @param targets [Array<PFM::PokemonBattler>]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Array<PFM::PokemonBattler>]
      def filter_targets(targets, pokemon, move)
      end
      public
      private
      # Find the mega evolve actions for the said Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Actions::Mega]
      def mega_evolve_action_for(pokemon)
      end
      public
      # Function returning pokemon to switch with on request
      # @param who [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler, nil]
      def request_switch(who)
      end
      private
      # Generate the switch action for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @param move_heuristics [Array<Float>]
      # @return [Array<[Float, Actions::Switch]>]
      def switch_actions_for(pokemon, move_heuristics)
      end
      # Function that clean the switch action:
      #  - Exclude duplicate switch in action
      #  - Ensure a Pokemon that is already on the field cannot get in the field
      # @param actions [Array<[Float, Actions::Switch]>]
      # @return [Array<[Float, Actions::Switch]>]
      def clean_switch_actions(actions)
      end
      # Function that clean the switch action for AI trigger
      #  - Exclude duplicate switch in action
      #  - Ensure a Pokemon that is already on the field cannot get in the field
      #  - Remove actions if the Pokemon was recently sent out and the random number was not less than 1
      # @param actions [Array<[Float, Actions::Switch]>]
      # @param force_switch [Boolean] if we ignore the fact switch can be performed or not and let the pokemon switch anyway
      # @return [Array<[Float, Actions::Switch]>]
      def clean_switch_trigger_actions(actions, force_switch = false)
      end
      # Function that tell if a Pokemon can be switched out based on the current turn & some random factor
      # @param action [Actions::Switch]
      # @return [Boolean]
      def can_switch_be_performed?(action)
      end
      # Generate the actual switch actions for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Array<[Float, Actions::Switch]>]
      def switch_actions_generate_for(pokemon)
      end
      # Get the danger factor of the Pokemon (depending on opponent)
      # @param pokemon [PFM::PokemonBattler]
      # @return [Float]
      def switch_danger_processing(pokemon)
      end
      # Get the opponent moves in order to choose if we switch or not
      # @param pokemon [PFM::PokemonBattler]
      # @return [Array<{ foe: PFM::PokemonBattler, move: Battle::Move }>]
      def switch_opponent_moves(pokemon)
      end
      public
      # List of boosting items
      BOOSTING_ITEMS = %i[x_attack x_sp_atk x_speed x_defense x_sp_def dire_hit guard_spec]
      # List of healing items
      HEALING_ITEMS = %i[full_restore hyper_potion energy_root moomoo_milk lemonade super_potion energy_powder soda_pop fresh_water potion berry_juice sweet_heart sitrus_berry oran_berry]
      # List of item that heal from poison
      POISON_HEAL_ITEMS = %i[antidote full_heal heal_powder lava_cookie old_gateau pecha_berry lum_berry casteliacone lumiose_galette shalour_sable]
      # List of item that heals from burn state
      BURN_HEAL_ITEMS = %i[burn_heal full_heal heal_powder lava_cookie old_gateau rawst_berry lum_berry casteliacone lumiose_galette shalour_sable]
      # List of item that heals from paralysis
      PARALYZE_HEAL_ITEMS = %i[paralyze_heal full_heal heal_powder lava_cookie old_gateau cheri_berry lum_berry casteliacone lumiose_galette shalour_sable]
      # List of item that heals from frozen state
      FREEZE_HEAL_ITEMS = %i[ice_heal full_heal heal_powder lava_cookie old_gateau aspear_berry lum_berry casteliacone lumiose_galette shalour_sable]
      # List of item that wake the Pokemon up
      WAKE_UP_ITEMS = %i[awakening full_heal heal_powder lava_cookie old_gateau blue_flute chesto_berry lum_berry casteliacone lumiose_galette shalour_sable]
      private
      # Generate the item action for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @param move_heuristics [Array<Float>]
      # @return [Array<[Float, Actions::Item]>]
      def item_actions_for(pokemon, move_heuristics)
      end
      # Generate the boost item action for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @param move_heuristics [Array<Float>]
      # @return [Array<[Float, Actions::Item]>]
      def boost_item_actions_for(pokemon, move_heuristics)
      end
      # Get the boost item interest factor
      # @param pokemon [PFM::PokemonBattler]
      # @return [Float]
      def boost_item_interest_factor_for(pokemon)
      end
      # Generate the heal item action for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @param move_heuristics [Array<Float>]
      # @return [Array<[Float, Actions::Item]>]
      def heal_item_actions_for(pokemon, move_heuristics)
      end
      # Generate the heal item action for the pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @param move_heuristics [Array<Float>]
      # @return [Array<[Float, Actions::Item]>]
      def status_heal_item_actions_for(pokemon, move_heuristics)
      end
      public
      private
      # Find the mega evolve actions for the said Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Array<[Float, Actions::Flee]>, nil]
      def flee_action_for(pokemon)
      end
    end
    # AI corresponding to the wild Pokemon
    class Wild < Base
      Base.register(0, self)
    end
    # AI corresponding to the youngster & similar trainers (base money < 20)
    class TrainerLv1 < Base
      private
      def init_capability
      end
      Base.register(1, self)
    end
    # AI corresponding to the bird keeper (base money < 36)
    class TrainerLv2 < Base
      private
      def init_capability
      end
      Base.register(2, self)
    end
    # AI coreresponding to sailor (base money < 48)
    class TrainerLv3 < Base
      private
      def init_capability
      end
      Base.register(3, self)
    end
    # AI corresponding to gambler (base money < 80)
    class TrainerLv4 < Base
      private
      def init_capability
      end
      Base.register(4, self)
    end
    # AI corresponding to Boss (base money < 100)
    class TrainerLv5 < Base
      private
      def init_capability
      end
      Base.register(5, self)
    end
    # AI corresponding to rival, gym leader, elite four (base money < 200)
    class TrainerLv6 < Base
      private
      def init_capability
      end
      Base.register(6, self)
    end
    # AI corresponding to champion (base money >= 200)
    class TrainerLv7 < Base
      private
      def init_capability
      end
      Base.register(7, self)
    end
    # AI corresponding to roaming Pokemon
    class RoamingWild < TrainerLv3
      private
      def init_capability
      end
      Base.register(-1, self)
    end
  end
end
