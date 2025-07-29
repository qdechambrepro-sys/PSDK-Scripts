module Battle
  class Move
    module Mechanics
      # Preset used for counter attacks
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - counter_fails?(attacker, user, targets)
      module Counter
        # Function that tests if the user is able to use the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
        # @return [Boolean] if the procedure can continue
        def move_usable_by_user(user, targets)
        end
        alias counter_move_usable_by_user move_usable_by_user
        # Method calculating the damages done by counter
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Integer]
        def damages(user, target)
        end
        alias counter_damages damages
        private
        # Test if the attack fails
        # @param attacker [PFM::PokemonBattler] the last attacker
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean] does the attack fails ?
        def counter_fails?(attacker, user, targets)
        end
        # Damage multiplier if the effect proc
        # @return [Integer, Float]
        def damage_multiplier
        end
        # Method responsive testing accuracy and immunity.
        # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<PFM::PokemonBattler>]
        def accuracy_immunity_test(user, targets)
        end
        alias counter_accuracy_immunity_test accuracy_immunity_test
        # Get the last pokemon that used a skill over the user
        # @param user [PFM::PokemonBattler]
        # @return [PFM::PokemonBattler, nil]
        def last_attacker(user)
        end
        alias counter_last_attacker last_attacker
      end
      # Preset used for item based attacks
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      module ItemBased
        # Function that tests if the user is able to use the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
        # @return [Boolean] if the procedure can continue
        def move_usable_by_user(user, targets)
        end
        alias item_based_move_usable_by_user move_usable_by_user
        private
        # Method calculating the damages done by the actual move
        # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @note The formula is the following:
        #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
        #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
        # @return [Integer]
        def damages(user, target)
        end
        alias item_based_damages damages
        # Remove the item from the battler
        # @param battler [PFM::PokemonBattler]
        def consume_item(battler)
        end
        # Tell if the move consume the item
        # @return [Boolean]
        def consume_item?
        end
        # Test if the held item is valid
        # @param name [Symbol]
        # @return [Boolean]
        def valid_held_item?(name)
        end
      end
      # Preset used for attacks with power based on held item.
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      # - private get_power_by_item
      module PowerBasedOnItem
        include ItemBased
        # Get the real base power of the move (taking in account all parameter)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Integer]
        def real_base_power(user, target)
        end
        alias power_based_on_item_real_base_power real_base_power
        private
        # Get the real power of the move depending on the item
        # @param name [Symbol]
        # @return [Integer]
        def get_power_by_item(name)
        end
      end
      # Preset used for attacks with power based on held item.
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      # - private get_types_by_item
      module TypesBasedOnItem
        include ItemBased
        # Get the types of the move with 1st type being affected by effects
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Array<Integer>] list of types of the move
        def definitive_types(user, target)
        end
        alias types_based_on_item_definitive_types definitive_types
        private
        # Get the real types of the move depending on the item
        # @param name [Symbol]
        # @return [Array<Integer>]
        def get_types_by_item(name)
        end
      end
      # Move based on the location type
      #
      # **REQUIREMENTS**
      # - define element_table
      module LocationBased
        # Function that tests if the targets blocks the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] expected target
        # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
        # @return [Boolean] if the target evade the move (and is not selected)
        def move_blocked_by_target?(user, target)
        end
        alias lb_move_blocked_by_target? move_blocked_by_target?
        private
        # Return the current location type
        # @return [Symbol]
        def location_type
        end
        # Find the element using the given location using randomness.
        # @return [object, nil]
        def element_by_location
        end
        # Element by location type.
        # @return [Hash<Symbol, Array<Symbol>]
        def element_table
        end
      end
      # Move that takes two turns
      #
      # **REQUIREMENTS**
      # None
      module TwoTurn
        private
        # Internal procedure of the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note If you are interrupted (see: interrupted?), we must reset @turn; otherwise,
        #       we will proceed to phase 2 the next time we make a move in two turns.
        def proceed_internal(user, targets)
        end
        # TwoTurn Move execution procedure
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def execution_turn(user, targets)
        end
        # Check if the two turn move is executed in one turn
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean]
        def shortcut?(user, targets)
        end
        alias two_turns_shortcut? shortcut?
        # Add the effects to the pokemons (first turn)
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def deal_effects_turn1(user, targets)
        end
        alias two_turn_deal_effects_turn1 deal_effects_turn1
        # Give the force next move and other effects
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def prepare_turn2(user, targets)
        end
        alias two_turn_prepare_turn2 prepare_turn2
        # Remove effects from the first turn
        # @param user [PFM::PokemonBattler]
        def kill_turn1_effects(user)
        end
        alias two_turn_kill_turn1_effects kill_turn1_effects
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def proceed_message_turn1(user, targets)
        end
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def play_animation_turn1(user, targets)
        end
        # Return the stat changes for the user
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<Array<[Symbol, Integer]>>] exemple : [[:dfe, -1], [:atk, 1]]
        def stat_changes_turn1(user, targets)
        end
        # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
        # @return [Array<Symbol>]
        def can_hit_moves
        end
        # Return the number of turns the effect works
        # @return Integer
        def turn_count
        end
      end
    end
    # Class describing a basic move (damage + potential status + potential stat)
    class Basic < Move
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
    end
    # Class describing a basic move (damage + status + stat = garanteed)
    class BasicWithSuccessfulEffect < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
    end
    Move.register(:s_basic, Basic)
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class SelfStat < Basic
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
      end
    end
    # Class describing a self status move (damage + potential status + potential stat to user)
    class SelfStatus < Basic
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
      end
    end
    Move.register(:s_self_stat, SelfStat)
    Move.register(:s_self_status, SelfStatus)
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class StatusStat < Move
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
    end
    Move.register(:s_stat, StatusStat)
    Move.register(:s_status, StatusStat)
    # Class describing a move hiting multiple time
    class MultiHit < Basic
      # Number of hit randomly picked from that array
      MULTI_HIT_CHANCES = [2, 2, 2, 3, 3, 5, 4, 3]
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Check if this the last hit of the move
      # Don't call this method before deal_damage method call
      # @return [Boolean]
      def last_hit?
      end
      # Tells if the move hits multiple times
      # @return [Boolean]
      def multi_hit?
      end
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
      end
    end
    # Class describing a move hitting twice
    class TwoHit < MultiHit
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
      end
    end
    # Class describing a move hitting thrice
    class ThreeHit < MultiHit
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
      end
    end
    # This method applies for triple kick and triple axel: power ramps up but the move stops if the subsequent attack misses.
    class TripleKick < MultiHit
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Recalculate the target each time it's needed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] the current targets we need the accuracy recalculation on
      # @return [Array] the targets hit after accuracy recalculation
      def recalc_targets(user, targets)
      end
      def hit_amount(user, actual_targets)
      end
    end
    # This method applies for Population Bomb: can hit up to 10 times, each subsequent hit checks accuracy.
    class PopulationBomb < TripleKick
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
      end
    end
    # Class describing Water Shuriken : Changes power and number of hit depending on greninja's base or Ash form.
    class WaterShuriken < MultiHit
      # New version of the Greninja ability (9G+)
      BATTLE_BOND_GEN_NINE = false
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
      end
    end
    Move.register(:s_multi_hit, MultiHit)
    Move.register(:s_2hits, TwoHit)
    Move.register(:s_3hits, ThreeHit)
    Move.register(:s_triple_kick, TripleKick)
    Move.register(:s_population_bomb, PopulationBomb)
    Move.register(:s_water_shuriken, WaterShuriken)
    # Class describing a heal move
    class HealMove < Move
      # Function that return the immunity
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      def target_immune?(user, target)
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
      end
      # Tell that the move is a heal move
      def heal?
      end
    end
    Move.register(:s_heal, HealMove)
    class TwoTurnBase < Basic
      include Mechanics::TwoTurn
      private
      # List of move that can hit a Pokemon when he's out of reach
      #   CAN_HIT_BY_TYPE[oor_type] = [move db_symbol list]
      CAN_HIT_BY_TYPE = [%i[spikes toxic_spikes stealth_rock], %i[earthquake fissure magnitude spikes toxic_spikes stealth_rock], %i[gust gravity whirlwind thunder swift sky_uppercut twister smack_down hurricane thousand_arrows spikes toxic_spikes stealth_rock], %i[surf whirlpool spikes toxic_spikes stealth_rock], nil]
      # Out of reach moves to type
      #   OutOfReach[sb_symbol] => oor_type
      TYPES = {dig: 1, fly: 2, dive: 3, bounce: 2, phantom_force: 0, shadow_force: 0}
      # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
      # @return [Array<Symbol>]
      def can_hit_moves
      end
      # List all the text_id used to announce the waiting turn in TwoTurnBase moves
      ANNOUNCES = {bounce: [19, 544], dig: [19, 538], dive: [19, 535], freeze_shock: [59, 866], geomancy: [19, 1213], ice_burn: [19, 869], meteor_beam: [59, 2014], phantom_force: [19, 541], razor_wind: [19, 547], shadow_force: [19, 541], sky_attack: [19, 550], skull_bash: [19, 556], solar_beam: [19, 553], fly: [19, 529]}
      # Move db_symbol to a list of stat and power
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      MOVE_TO_STAT = {electro_shot: [[:ats, 1]], meteor_beam: [[:ats, 1]], skull_bash: [[:dfe, 1]]}
      # Move db_symbol to a list of stat and power change on the user
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      def stat_changes_turn1(user, targets)
      end
      # Display the message and the animation of the turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_message_turn1(user, targets)
      end
    end
    Move.register(:s_2turns, TwoTurnBase)
    # Abstract class that manage logic of stage swapping moves
    class StatAndStageEdit < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
      end
    end
    # Abstract class that manage logic of stage swapping moves and bypass accuracy calculation
    class StatAndStageEditBypassAccuracy < StatAndStageEdit
      # Tell if the move accuracy is bypassed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def bypass_accuracy?(user, targets)
      end
    end
    # Class describing a Pledge move (moves combining for different effects)
    class Pledge < Basic
      # List the db_symbol for every Pledge moves
      # @return [Array<Symbol>]
      PLEDGE_MOVES = %i[water_pledge fire_pledge grass_pledge]
      # Return the combination for each effect triggered by Pledge combination
      # @return [Hash { Symbol => Array<Symbol, Array<>> }
      COMBINATION_LIST = {rainbow: %i[water_pledge fire_pledge], sea_of_fire: %i[fire_pledge grass_pledge], swamp: %i[grass_pledge water_pledge]}
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      # Function which permit things to happen before the move's animation
      def post_accuracy_check_move(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Register a Pledge move as one in the System
      # @param db_symbol [Symbol] db_symbol of the move
      def register_pledge_move(db_symbol)
      end
      # Register a pledge combination
      # @param effect_symbol [Symbol]
      # @param first_pledge_symbol [Symbol]
      # @param second_pledge_symbol
      def register_pledge_combination(effect_symbol, first_pledge_symbol, second_pledge_symbol)
      end
      private
      # Check the order to know if the user uses its Pledge Move or wait for the other to attack
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def check_order_of_attack(user, targets)
      end
      # Get the right text depending on the user's side (and if it's a Trainer battle or not)
      # @param user [PFM::PokemonBattler]
      # @param other [PFM::PokemonBattler]
      # @return [String]
      def pledge_wait_text(user, other)
      end
      # Create the Rainbow Effect
      # @param user [PFM::PokemonBattler]
      # @param _actual_targets [Array<PFM::PokemonBattler>]
      def rainbow(user, _actual_targets)
      end
      # Create the SeaOfFire Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def sea_of_fire(_user, actual_targets)
      end
      # Create the Swamp Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def swamp(_user, actual_targets)
      end
    end
    Move.register(:s_pledge, Pledge)
  end
end
