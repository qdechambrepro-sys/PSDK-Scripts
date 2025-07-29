module Battle
  module Effects
    class Status < EffectBase
      # Get the target of the effect
      # @return [PFM::PokemonBattler]
      attr_reader :target
      @registered_statuses = {}
      # Create a new status effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param status [Symbol] Symbol of the status
      def initialize(logic, target, status)
      end
      # Get the ID of the status
      # @return [Integer]
      def status_id
      end
      # Tell if the status effect is poisoning
      # @return [Boolean]
      def poison?
      end
      # Tell if the status effect is paralysis
      # @return [Boolean]
      def paralysis?
      end
      # Tell if the status effect is burn
      # @return [Boolean]
      def burn?
      end
      # Tell if the status effect is asleep
      # @return [Boolean]
      def asleep?
      end
      # Tell if the status effect is frozen
      # @return [Boolean]
      def frozen?
      end
      # Tell if the status effect is toxic
      # @return [Boolean]
      def toxic?
      end
      # Tell if the effect is a global poisoning effect (poison or toxic)
      # @return [Boolean]
      def global_poisoning?
      end
      class << self
        # Register a new status
        # @param status [Symbol] Symbol of the status
        # @param klass [Class<Status>] class of the status effect
        def register(status, klass)
        end
        # Create a new Status effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param status [Symbol] Symbol of the status
        # @return [Status]
        def new(logic, target, status)
        end
      end
      class Poison < Status
        # Prevent poison from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Apply poison effect on end of turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Return the Poison effect on HP of the Pokemon
        # @return [Integer] number of HP loosen
        def poison_effect
        end
      end
      register(:poison, Poison)
      class Paralysis < Status
        # Prevent paralysis from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Check if the pokemon cannot move due to paralysis
        # @return [Boolean]
        def paralysis_check
        end
      end
      register(:paralysis, Paralysis)
      class Burn < Status
        # Give the move mod1 mutiplier (before the +2 in the formula)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod1_multiplier(user, target, move)
        end
        # Prevent burn from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Apply burn effect on end of turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Return the Burn effect on HP of the Pokemon
        # @return [Integer] number of HP loosen
        def burn_effect
        end
      end
      register(:burn, Burn)
      class Asleep < Status
        # List of moves that works when the user is asleep
        SLEEPING_MOVES = %i[snore sleep_talk]
        # Prevent sleep from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Function to handle move prevention when the user is the target and is asleep
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [:prevent]
        def handle_sleep_prevention(user, move)
        end
        # Function to handle waking up the Pokémon
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [nil]
        def handle_wakeup(user, move)
        end
        # Function to remove the Nightmare effect from the Pokémon
        # @param user [PFM::PokemonBattler]
        def remove_nightmare_effect(user)
        end
      end
      register(:sleep, Asleep)
      class Frozen < Status
        # Prevent freeze from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Check if the Pokemon is still frozen
        # @return [Boolean]
        def froze_check
        end
      end
      register(:freeze, Frozen)
      class Toxic < Status
        # Create a new toxic effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param status_id [Integer] ID of the status
        def initialize(logic, target, status_id)
        end
        # Reset the toxic counter
        def reset
        end
        # Prevent toxic from being applied twice
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Apply toxic effect on end of turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function giving the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # Return the Poison effect on HP of the Pokemon (used solely by the Poison Heal ability)
        # @return [Integer] number of HP loosen
        def poison_effect
        end
        # Return the Poison effect on HP of the Pokemon
        # @return [Integer] number of HP loosen
        def toxic_effect
        end
      end
      register(:toxic, Toxic)
    end
  end
end
Hooks.register(PFM::PokemonBattler, :on_reset_states, 'PSDK reset toxic') do
  status_effect.reset if status_effect.is_a?(Battle::Effects::Status::Toxic)
end
