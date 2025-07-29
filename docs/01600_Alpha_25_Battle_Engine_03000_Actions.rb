module Battle
  # Module containing the action classes for the battle
  module Actions
    # Base class for all actions
    class Base
      # Creates a new action
      # @param scene [Battle::Scene]
      def initialize(scene)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Tell if the action is valid
      # @return [Boolean]
      def valid?
      end
      # Execute the action
      def execute
      end
    end
    # Class describing the Attack Action
    class Attack < Base
      # Get the move of this action
      # @return [Battle::Move]
      attr_reader :move
      # Get the user of this move
      # @return [PFM::PokemonBattler]
      attr_reader :launcher
      # Tell if pursuit on this action is enabled
      # @return [Boolean]
      attr_accessor :pursuit_enabled
      # Tell if this action can ignore speed of the other pokemon
      # @return [Boolean]
      attr_accessor :ignore_speed
      # Create a new attack action
      # @param scene [Battle::Scene]
      # @param move [Battle::Move]
      # @param launcher [PFM::PokemonBattler]
      # @param target_bank [Integer] bank the move aims
      # @param target_position [Integer] position the move aims
      def initialize(scene, move, launcher, target_bank, target_position)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Get the priority of the move
      # @return [Integer]
      def priority
      end
      # Get the target of the move
      # @return [PFM::PokemonBattler, nil]
      def target
      end
      # Execute the action
      def execute
      end
      # Function that manages the effect of the dancer ability
      def dancer_sub_launchers
      end
      # Define which Pokémon should go first if either of them or both have the ability Mycelium Might.
      # @param attack [Battle::Actions::Attack]
      # @return [Integer]
      def mycelium_might_priority(attack)
      end
      # Action describing the action forced by Encore
      class Encore < Attack
        # Execute the action
        def execute
        end
      end
    end
    # Class describing the Pre Attacks Action
    class PreAttack < Base
      # Create a new attack action
      # @param scene [Battle::Scene]
      def initialize(scene, attack_actions)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Execute the action
      def execute
      end
    end
    # Class describing the Mega Evolution action
    class Mega < Base
      # Get the user of this action
      # @return [PFM::PokemonBattler]
      attr_reader :user
      # Create a new mega evolution action
      # @param scene [Battle::Scene]
      # @param user [PFM::PokemonBattler]
      def initialize(scene, user)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Execute the action
      def execute
      end
      private
      # Get the mega evolve message
      # @return [String]
      def message
      end
    end
    # Class describing the usage of an Item
    class Item < Base
      # Get the Pokemon responsive of the item usage
      # @return [PFM::PokemonBattler]
      attr_reader :user
      # Get the item wrapper executing the action
      # @return [PFM::ItemDescriptor::Wrapper]
      attr_reader :item_wrapper
      # Create a new item action
      # @param scene [Battle::Scene]
      # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
      # @param bag [PFM::Bag]
      # @param user [PFM::PokemonBattler] pokemon responsive of the usage of the item (to help sorting alg.)
      def initialize(scene, item_wrapper, bag, user)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Execute the action
      def execute
      end
    end
    # Class describing the usage of switching out a Pokemon
    class Switch < Base
      # Get the Pokemon who's being switched
      # @return [PFM::PokemonBattler]
      attr_reader :who
      # Get the Pokemon with the Pokemon is being switched
      # @return [PFM::PokemonBattler]
      attr_reader :with
      # Create a new switch action
      # @param scene [Battle::Scene]
      # @param who [PFM::PokemonBattler] who's being switched out
      # @param with [PFM::PokemonBattler] with who the Pokemon is being switched
      def initialize(scene, who, with)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Execute the action
      def execute
      end
      private
      # Wait for the sprite animation to be done
      # @param sprite [#done?]
      # @param visual [Battle::Visual]
      def wait_for(sprite, visual)
      end
      # Show the switch out message
      def switch_out_message
      end
      # Show the switch in message
      def switch_in_message
      end
      # Tell if the Pokemon was forced to switch
      # @param who [PFM::PokemonBattler] the switched out Pokemon
      # @return [Boolean]
      def forced_switch?(who)
      end
    end
    # Class describing the Flee action
    class Flee < Base
      # Get the pokemon trying to flee
      # @return [PFM::PokemonBattler]
      attr_reader :target
      # Create a new flee action
      # @param scene [Battle::Scene]
      # @param target [PFM::PokemonBattler]
      def initialize(scene, target)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Constant telling the priority applied to a Fleeing action for a Roaming Pokemon
      # @return [Integer]
      PRIORITY_ROAMING_FLEE = -7
      # Give the comparison result for a Roaming Pokemon
      # @param attack [Attack] other action
      # @return [Integer]
      # @note Based on Gen 5 mechanism as Gen 6 mechanism isn't a real Roaming feature
      # In Gen 5, a Roaming Pokemon trying to escape has a Priority of -7
      def roaming_comparison_result(attack)
      end
      # Execute the action
      # @param from_scene [Boolean] if the action was triggered during the player choice
      def execute(from_scene = false)
      end
      private
      # Execute the action if the pokemon is from party
      def execute_from_scene
      end
    end
    # Class describing the activation message of item granting priority
    class HighPriorityItem < Base
      # Create a new high priority item action
      # @param scene [Battle::Scene]
      # @param holder [PFM::PokemonBattler]
      def initialize(scene, holder)
      end
      # Compare this action with another
      # @param other [Base] other action
      # @return [Integer]
      def <=>(other)
      end
      # Execute the action
      def execute
      end
    end
  end
end
