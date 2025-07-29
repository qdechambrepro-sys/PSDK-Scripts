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
      end
      # Is this heuristic ignoring effectiveness
      # @return [Boolean]
      def ignore_effectiveness?
      end
      # Is this heuristic ignoring power
      # @return [Boolean]
      def ignore_power?
      end
      # Is this heuristic ignoring power
      # @return [Boolean]
      def overwrite_move_kind_flag?
      end
      # Compute the heuristic
      # @param move [Battle::Move]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param ai [Battle::AI::Base]
      # @return [Float]
      def compute(move, user, target, ai)
      end
      class << self
        # Register a new move heuristic
        # @param db_symbol [Symbol] db_symbol of the move
        # @param klass [Class<MoveHeuristicBase>, nil] klass holding the logic for this heuristic
        # @param min_level [Integer] minimum level when the heuristic acts
        # @note If there's several min_level, the highest condition matching with current AI level is choosen.
        def register(db_symbol, klass, min_level = 0)
        end
        # Get a MoveHeuristic by db_symbol and level
        # @param db_symbol [Symbol] db_symbol of the move
        # @param level [Integer] level of the current AI
        # @return [MoveHeuristicBase]
        def new(db_symbol, level)
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
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(user)
        end
      end
      class TwoHit < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
        end
      end
      class ThreeHit < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
        end
      end
      class TripleKick < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
        end
      end
      class PopulationBomb < MultiHit
        # Process the power amplification according to potential hit amount
        # @param user [PFM::PokemonBattler]
        # @return [Float]
        def move_hit_multiplier(_)
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
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
      end
      register(:s_rest, Rest, 1)
      class SleepTalk < MoveHeuristicBase
        # Create a new Sleep Talk Heuristic
        def initialize
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
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
        end
      end
      class Nightmare < MoveHeuristicBase
        # Create a new Nightmare Heuristic
        def initialize
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
      end
      register(:s_sleep_talk, SleepTalk, 2)
      register(:s_snore, Snore, 2)
      register(:s_dream_eater, DreamEater, 2)
      register(:s_nightmare, Nightmare, 3)
      class HealingMoves < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
        # Test if sacrifice move should not be used
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def healing_sacrifice_clause(move, user, target, ai)
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
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
      end
      register(:s_heal_bell, CuringMove, 1)
      class ReflectMoves < MoveHeuristicBase
        # Create a new Rest Heuristic
        def initialize
        end
        # Compute the heuristic
        # @param move [Battle::Move]
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param ai [Battle::AI::Base]
        # @return [Float]
        def compute(move, user, target, ai)
        end
      end
      register(:s_reflect, ReflectMoves, 1)
    end
  end
end
