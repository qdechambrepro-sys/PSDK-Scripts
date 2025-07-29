module Battle
  module AI
    # Class responsive of handling the heuristics of moves
    class MoveHeuristicBase
      @move_heuristics = {}
      # Create a new MoveHeusristicBase
      # @param ignore_effectiveness [Boolean] if this heuristic ignore effectiveness (wants to compute it themself)
      # @param ignore_power [Boolean] if this heuristic ignore power (wants to compute it themself)
      # @param overwrite_move_kind_flag [Boolean] if the effect overwrite (to true) the can see move kind flag
      def initialize(ignore_effectiveness = false, ignore_power = false, overwrite_move_kind_flag = false)
        @ignore_effectiveness = ignore_effectiveness
        @ignore_power = ignore_power
        @overwrite_move_kind_flag = overwrite_move_kind_flag
      end
      # Is this heuristic ignoring effectiveness
      # @return [Boolean]
      def ignore_effectiveness?
        return @ignore_effectiveness
      end
      # Is this heuristic ignoring power
      # @return [Boolean]
      def ignore_power?
        return @ignore_power
      end
      # Is this heuristic ignoring power
      # @return [Boolean]
      def overwrite_move_kind_flag?
        return @overwrite_move_kind_flag
      end
      # Compute the heuristic
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param ai [Battle::AI::Base]
      # @return [Float]
      def compute(move, user, target, ai)
        return 1.0 if move.status?
        return Math.sqrt(move.special? ? user.ats_basis / target.dfs_basis.to_f : user.atk_basis / target.dfe_basis.to_f)
      end
      class << self
        # Register a new move heuristic
        # @param db_symbol [Symbol] db_symbol of the move
        # @param klass [Class<MoveHeuristicBase>, nil] klass holding the logic for this heuristic
        # @param min_level [Integer] minimum level when the heuristic acts
        # @note If there's several min_level, the highest condition matching with current AI level is choosen.
        def register(db_symbol, klass, min_level = 0)
          @move_heuristics[db_symbol] ||= []
          @move_heuristics[db_symbol].delete_if { |entry| entry[:min_level] == min_level }
          @move_heuristics[db_symbol] << {min_level: min_level, klass: klass} if klass
          @move_heuristics[db_symbol].sort_by! { |entry| -entry[:min_level] }
        end
        # Get a MoveHeuristic by db_symbol and level
        # @param db_symbol [Symbol] db_symbol of the move
        # @param level [Integer] level of the current AI
        # @return [MoveHeuristicBase]
        def new(db_symbol, level)
          klass = @move_heuristics[db_symbol]&.find { |entry| entry[:min_level] <= level }
          klass = klass ? klass[:klass] : self
          heuristic = klass.allocate
          heuristic.send(:initialize)
          return heuristic
        end
      end
      # Class describing the heuristic of a move that hits multiple times
      # @note This class is used for moves like Fury Swipes, Rock Blast, etc.
      #       these moves have very low power but can hit multiple times,
      #       effectively having always low heuristic despite potential strong power.
      #       Minimum AI level: 3 -> "can_see_move_kind" set to true.
      class MultiHit < MoveHeuristicBase
        POWER_MEAN = 200.0
        POWER_STD = 150 * Math.sqrt(2)
        # Create a new Multi Hit Move Heuristic
        def initialize
          super(false, true, false)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          effectiveness = move.calc_stab(user, move.definitive_types(user, target)) * move.type_modifier(user, target)
          power_multiplier = move_hit_multiplier(user)
          power = move.real_base_power(user, target) * power_multiplier
          est_damage = 0.75 + 0.125 * (1 + Math.erf((power * effectiveness - POWER_MEAN) / POWER_STD))
          return super * est_damage
        end
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(user)
          hit_amount = 3.0
          hit_amount = 4.5 if user.hold_item?(:loaded_dice)
          hit_amount = 5.0 if user.has_ability?(:skill_link)
          return hit_amount
        end
      end
      class TwoHit < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
          return 2.0
        end
      end
      class ThreeHit < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
          return 3.0
        end
      end
      class TripleKick < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
          return 6.0
        end
      end
      class PopulationBomb < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
          return 10.0
        end
      end
      register(:s_multi_hit, MultiHit, 3)
      register(:s_2hits, TwoHit, 3)
      register(:s_3hits, ThreeHit, 3)
      register(:s_triple_kick, TripleKick, 3)
      register(:s_population_bomb, PopulationBomb, 3)
      register(:s_water_shuriken, MultiHit, 3)
      class Rest < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          boost = user.status_effect.instance_of?(Effects::Status) ? 0 : 1
          return (1 - user.hp_rate) * 2 + boost
        end
      end
      register(:s_rest, Rest, 1)
      class SleepTalk < MoveHeuristicBase
        # Create a new Sleep Talk Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          return ai.scene.logic.generic_rng.rand(0.10) + 0.60 if user.has_ability?(:comatose)
          low_odd = ai.scene.logic.generic_rng.rand(0.25) + 0.25
          return low_odd unless user.asleep? && user.sleep_turns < 3
          return 1.0
        end
      end
      class Snore < MoveHeuristicBase
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          low_odd = ai.scene.logic.generic_rng.rand(0.25) + 0.25
          return super if user.has_ability?(:comatose)
          return low_odd unless user.asleep? && user.sleep_turns < 3
          return Math.sqrt(super)
        end
      end
      class DreamEater < MoveHeuristicBase
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          return super if target.has_ability?(:comatose) || (target.asleep? && target.sleep_turns < 3)
          low_odd = ai.scene.logic.generic_rng.rand(0.25) + 0.25
          return low_odd
        end
      end
      class Nightmare < MoveHeuristicBase
        # Create a new Nightmare Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          low_odd = ai.scene.logic.generic_rng.rand(0.25) + 0.25
          high_odd = 1.0 - target.sleep_turns / 8.0
          return Math.exp((user.last_sent_turn - $game_temp.battle_turn + 1) / 10.0) * 0.85 if target.has_ability?(:comatose)
          return target.asleep? ? high_odd : low_odd
        end
      end
      register(:s_sleep_talk, SleepTalk, 2)
      register(:s_snore, Snore, 2)
      register(:s_dream_eater, DreamEater, 2)
      register(:s_nightmare, Nightmare, 3)
      class HealingMoves < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          return 0 if target.effects.has?(:heal_block)
          return 0 if target.bank != user.bank
          return 0 if move.db_symbol == :heal_pulse && target.effects.has?(:substitute)
          return 0 if healing_sacrifice_clause(move, user, target, ai)
          return (1 - target.hp_rate) * 2
        end
        # Test if sacrifice move should not be used
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def healing_sacrifice_clause(move, user, target, ai)
          return move.is_a?(Move::HealingSacrifice) && ai.scene.logic.can_battler_be_replaced?(target) && ai.scene.logic.allies_of(target).none? { |pokemon| pokemon.hp_rate <= 0.75 && pokemon.party_id == target.party_id }
        end
      end
      register(:s_heal, HealingMoves, 1)
      register(:s_heal_weather, HealingMoves, 1)
      register(:s_roost, HealingMoves, 1)
      register(:s_healing_wish, HealingMoves, 1)
      register(:s_lunar_dance, HealingMoves, 1)
      class CuringMove < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          return 0 if target.effects.has?(:heal_block)
          return 0 if target.has_ability?(:soundproof)
          return 0 if target.dead? || target.status == 0
          return 0.75 + ai.scene.logic.move_damage_rng.rand(0..0.25)
        end
      end
      register(:s_heal_bell, CuringMove, 1)
      class ReflectMoves < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
          super(true, true, true)
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
          return 0 if ai.scene.logic.bank_effects[user.bank].has?(move.db_symbol) || (move.db_symbol == :aurora_veil && !$env.hail?)
          return 0.80 if move.db_symbol == :light_screen && ai.scene.logic.foes_of(user).none? { |foe| foe.moveset.none?(&:special?) }
          return 0.80 if move.db_symbol == :reflect && ai.scene.logic.foes_of(user).none? { |foe| foe.moveset.none?(&:physical?) }
          return 0.90 + ai.scene.logic.move_damage_rng.rand(0..0.10)
        end
      end
      register(:s_reflect, ReflectMoves, 1)
    end
  end
end
