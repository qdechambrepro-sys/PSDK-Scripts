module Battle
  module Effects
    module Mechanics
      # Effect mechanics that make the pokemon flies
      # When including this mechanics :
      # - overwrite on_proc_message
      # - overwrite on_delete_message
      # - call Effects::Mechanics::ForceFlying.register_force_flying_hook in the class
      module ForceFlying
        # Create a new Pokemon tied effect
        # @param pokemon [PFM::PokemonBattler]
        # @param name [Symbol] giving the name of the effect
        # @param duration [Integer] duration of the effect (including the current turn)
        def force_flying_initialize(pokemon, name, duration)
        end
        # Function called when the effect has been deleted from the effects handler
        def on_delete
        end
        alias force_flying_on_delete on_delete
        private
        # Transfer the effect to the given pokemon via baton switch
        # @param with [PFM::PokemonBattler] the pokemon switched in
        # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
        def baton_switch_transfer(with)
        end
        alias force_flying_baton_switch_transfer baton_switch_transfer
        # Message displayed when the effect wear off
        # @return [String, nil]
        def on_delete_message
        end
        class << self
          # Make to pokemon flying in grounded? test
          # @param reason [String] reason of the hook
          # @param name [Symbol] name of the effect
          def register_force_flying_hook(reason, name)
          end
        end
      end
      # Give functions to manage a move that force the next one. Must be used in a EffectBase child class.
      module ForceNextMove
        # Get the move the Pokemon has to use
        # @return [Battle::Move]
        attr_reader :move
        # Get the targets of the move
        # @return [Array<PFM::PokemonBattler>]
        attr_reader :targets
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        # Tell if the effect forces the next move
        # @return [Boolean]
        def force_next_move?
        end
        # Tell if the effect forces the next turn action into a Attack action
        # @return [Boolean]
        def force_next_turn_action?
        end
        # Function that updates the counter of the effect
        def update_counter
        end
        # List of move that must be paused when user is asleep/frozen/flinched
        MOVES_PAUSED = %i[freeze_shock geomancy ice_burn razor_wind skull_bash sky_attack solar_beam electro_shot]
        # Function that tells us if we should pause the move or not
        # @param user [PFM::PokemonBattler] user of the move
        def paused?(user)
        end
        # Function that tells us if we should interrupt the move or not
        # @param user [PFM::PokemonBattler] user of the move
        def interrupted?(user)
        end
        # Make the Attack action that is forced by this effect
        # @return [Actions::Attack]
        def make_action
        end
        # Get the class of the action
        # @return [Class<Actions::Attack>]
        def action_class
        end
        private
        # Create a new Forced next move effect
        # @param move [Battle::Move]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param counter [Integer] number of turn the move is forced to be used
        def init_force_next_move(move, targets, counter)
        end
      end
      # Effect linked to another, if the other die, this one dies too.
      #
      # **Requirement**
      # - Call initialize_mark
      module Mark
        # Get the origin mark
        # @return [EffectBase]
        attr_reader :mark_origin
        # Initialize the mechanic
        # @param origin [EffectBase]
        def initialize_mark(origin)
        end
        # Tell if the effect is dead
        # @return [Boolean]
        def dead?
        end
        alias mark_dead? dead?
      end
      # Neutralize Type Effect
      #
      # **Includer requirements**
      # - call neutralize_type_initialize
      # - def neutralyzed_type
      module NeutralizeType
        # Create a new effect
        # @param target [PFM::PokemonBattler]
        # @param turn_count [Integer]
        def neutralize_type_initialize(target, turn_count)
        end
        # Show the message when the effect gets deleted
        def on_delete
        end
        alias neutralize_type_on_delete on_delete
        private
        # Get the neutralized types
        # @return [Array<Integer>]
        def neutralyzed_types
        end
      end
      # Make the pokemon out of reach
      #
      # **Requirement**
      # - Call initialize_out_of_reach
      module OutOfReach
        # Get the move the Pokemon has to use
        # @return [Battle::Move]
        attr_reader :move
        # Init the mechanic
        # @param pokemon [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @param exceptions [Array<Symbol>] move that hit the target while out of reach
        # @param counter [Integer] number of turn the user is out_of_reach
        def initialize_out_of_reach(pokemon, move, exceptions, counter = 2)
        end
        # Tell if the effect make the pokemon out reach
        # @return [Boolean]
        def out_of_reach?
        end
        alias oor_out_of_reach? out_of_reach?
        # Function that updates the counter of the effect
        def update_counter
        end
        # List of move that must be paused when user is asleep/frozen/flinched
        MOVES_PAUSED = %i[freeze_shock geomancy ice_burn razor_wind skull_bash sky_attack solar_beam electro_shot]
        # Function that tells us if we should interrupt the move or not
        # @param user [PFM::PokemonBattler] user of the move
        def interrupted?(user)
        end
        # Check if the attack can hit the pokemon. Should be called after testing out_of_reach?
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_hit_while_out_of_reach?(move)
        end
        alias oor_can_hit_while_out_of_reach? can_hit_while_out_of_reach?
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
        alias oor_on_move_prevention_target on_move_prevention_target
      end
      module SuccessiveSuccessfulUses
        # Return the number of successive successful use of the move.
        # @return [Integer]
        def successive_uses
        end
        # Increase the successive uses by one
        def increase
        end
        private
        # Init the successive uses module
        # @param pokemon [PFM::PokemonBattler]
        # @param move [Battle::Move]
        def init_successive_successful_uses(pokemon, move)
        end
        # List of the moves that don't break the continuity and don't increment
        ACCEPTED_MOVES = %i[mirror_move]
        # List of the moves that don't break the continuity and don't increment
        # @return [Array[Symbol]]
        def accepted_moves
        end
      end
      # Store targets informations
      #
      # **Requirement**
      # - Call initialize_with_targets
      module WithTargets
        # Init the mechanic
        # @param targets [Array<PFM::PokemonBattler>, PFM::PokemonBattler] battler targetted by the effect
        def initialize_with_targets(targets)
        end
        # Tell if the given battler is targetted by the effect
        # @param battler [PFM::PokemonBattler]
        # @return [Boolean]
        def targetted?(battler)
        end
        alias with_targets_targetted? targetted?
      end
      # Store targets informations
      #
      # **Requirement**
      # - Call initialize_with_marked_targets
      #
      # **Initialization exemple**
      # ```ruby
      # # Inside EffectBase child class
      # initialize_with_marked_targets(targets) { |target| YourMarkEffect.new(logic, self, user, target) }
      # ```
      module WithMarkedTargets
        include Mechanics::WithTargets
        # Initialize the mechanic
        # @param user [PFM::PokemonBattler, nil]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param block [Proc] block taking one argument (PFM::PokemonBattler) and return an EffectBase
        def initialize_with_marked_targets(user, targets, &block)
        end
        # The launcher of this effect
        # @return [PFM::PokemonBattler, nil]
        def launcher
        end
        # Tell if the effect is dead
        # @return [Boolean]
        def dead?
        end
        alias wmt_dead? dead?
      end
    end
  end
end
