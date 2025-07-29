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
