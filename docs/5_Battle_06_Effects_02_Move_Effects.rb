module Battle
  module Effects
    # Implement the ability suppression (Gastro Acid)
    class AbilitySuppressed < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Implement the Aqua Ring effect
    class AquaRing < PokemonTiedEffectBase
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
      # Get the message text
      # @return [String]
      def message
      end
      # Get the HP factor delt by the move
      # @return [Integer]
      def hp_factor
      end
    end
    # Implement the attract effect
    class Attract < PokemonTiedEffectBase
      # Get the Pokemon who's this Pokemon is attracted to
      # @return [PFM::PokemonBattler]
      attr_reader :attracted_to
      # Create a new Pokemon Attract effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param attracted_to [PFM::PokemonBattler]
      def initialize(logic, target, attracted_to)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Autotomize < PokemonTiedEffectBase
      # Constant containing the weight for each Autotomize-like move
      WEIGHT_MOVES = {autotomize: 100}
      WEIGHT_MOVES.default = 100
      # Create a new autotomize effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move] the move that created the effect
      def initialize(logic, pokemon, move)
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Try to increase a stat of the Pokemon then change its weight
      # @param move [Battle::Move]
      def launch_effect(move)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      private
      # Return the weight loss for the move
      def weight(move)
      end
      # Get the right message to display
      # @return [String]
      def message
      end
    end
    class BatonPass < PokemonTiedEffectBase
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Switch the stages of the pokemons
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def switch_stages(handler, who, with)
      end
      # Switch the stages of the pokemons
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def switch_status(handler, who, with)
      end
      # Switch the effect from one to another
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def switch_effects(handler, who, with)
      end
    end
    # Implement the Beak Blast effect
    class BeakBlast < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called after damages were applied (post_damage, when target is still alive)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage(handler, hp, target, launcher, skill)
      end
      alias on_post_damage_death on_post_damage
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Tell if the effect make the pokemon preparing an attack
      # @return [Boolean]
      def preparing_attack?
      end
    end
    class Bestow < EffectBase
      # Initialize the effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param giver [PFM::PokemonBattler] the Pokemon that gives the item
      # @param receiver [PFM::PokemonBattler] the Pokemon that receives the item
      # @param item [Symbol] the db_symbol of the item
      def initialize(logic, giver, receiver, item)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Give the item back to the giver and clear the item of the receiver
      def give_back_item
      end
    end
    # Class that describe the bind effect
    class Bind < PokemonTiedEffectBase
      # Hash giving the message info based on the db_symbol of the move
      MESSAGE_INFO = {bind: [19, 806, true], wrap: [19, 813, true], fire_spin: [19, 830, false], clamp: [19, 820, true], whirlpool: [19, 827, false], sand_tomb: [19, 836, false], magma_storm: [19, 833, false], infestation: [19, 1234, true], octolock: [59, 1978, false], snap_trap: [59, 1974, false], thunder_cage: [59, 2052, true]}
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :origin
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      # @param turn_count [Integer]
      # @param move [Battle::Move] move responsive of the effect
      def initialize(logic, pokemon, origin, turn_count, move)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Function called when testing if pokemon can switch (when he couldn't passthrough)
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:prevent, nil] if :prevent, can_switch? will return false
      def on_switch_prevention(handler, pokemon, skill, reason)
      end
      # Function called when a Pokemon has actually switched with another one
      # @param _handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param _with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(_handler, who, _with)
      end
      # Tell if the effect is dead or must be cleared
      # @return [Boolean]
      def dead?
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      private
      # Get the message text
      # @return [String]
      def message
      end
      # Get the HP factor delt by the move
      # @return [Integer]
      def hp_factor
      end
    end
    # Class managing Burn Up Effect
    class BurnUp < PokemonTiedEffectBase
      include Mechanics::NeutralizeType
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param type [Integer] the current type of the move
      # @param turn_count [Integer]
      def initialize(logic, pokemon, turn_count, type)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Get the neutralized types
      # @return [Array<Integer>]
      def neutralyzed_types
      end
    end
    # CantSwitch Effect
    class CantSwitch < PokemonTiedEffectBase
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :origin
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      # @param move [Battle::Move] move responsive of the effect
      def initialize(logic, pokemon, origin, move)
      end
      # Function called when testing if pokemon can switch (when he couldn't passthrough)
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:prevent, nil] if :prevent, can_switch? will return false
      def on_switch_prevention(handler, pokemon, skill, reason)
      end
      # Function called when a Pokemon has actually switched with another one
      # @param _handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(_handler, who, with)
      end
      # Tell if the effect must be cleared
      # @return [Boolean]
      def dead?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
      # Get the message text
      # @return [String]
      def message
      end
    end
    class CenterOfAttention < PokemonTiedEffectBase
      # The move that caused this effect
      # @return [Symbol]
      attr_reader :origin_move
      # Moves that ignore this effect
      MOVES_IGNORING_THIS_EFFECT = %i[snipe_shot]
      # Create a new Center of Attention effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turn_count [Integer] amount of turn the effect is active
      # @param origin_move [Battle::Move] the move that caused this effect
      def initialize(logic, pokemon, turn_count, origin_move)
      end
      # Return the new target if the conditions are fulfilled
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param move [Battle::Move]
      # @return [PFM::PokemonBattler] the new target if the conditions are fulfilled, the initial target otherwise
      def target_redirection(user, targets, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Check if the user of the move has an immunity to powders moves
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def rage_powder_immunity?(user)
      end
    end
    # ChangeType Effects
    class ChangeType < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param type [Integer] the ID of the type to apply to the Pokemon
      def initialize(logic, pokemon, type)
      end
      # Function called when a Pokemon initialize a transformation
      # @param handler [Battle::Logic::TransformHandler]
      # @param target [PFM::PokemonBattler]
      def on_transform_event(handler, target)
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
    end
    class Charge < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turncount [Integer] amount of turn the effect is active
      def initialize(logic, pokemon, turncount)
      end
      # Give the move base power mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def base_power_multiplier(user, target, move)
      end
      # Name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Effect describing confusion
    class Confusion < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turn_count [Integer] number of turn for the confusion (not including current turn)
      def initialize(logic, pokemon, turn_count = logic.generic_rng.rand(1..4))
      end
      # Return the amount of damage the Pokemon receive from confusion
      # @return [Integer]
      def confuse_damage
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Get the damage chance (between 0 & 1) of the confusion
      # @return [Float]
      def damage_chance
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement Crafty Shield effect that protects Pokemon from status moves
    class CraftyShield < PokemonTiedEffectBase
      # Function called when we try to check if the target evades the move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @return [Boolean] if the target is evading the move
      def on_move_prevention_target(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Curse effect
    class Curse < PokemonTiedEffectBase
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Class that manage DestinyBond effect. Works together with Move::DestinyBond.
    # @see https://pokemondb.net/move/destiny-bond
    # @see https://bulbapedia.bulbagarden.net/wiki/Destiny_Bond_(move)
    # @see https://www.pokepedia.fr/Lien_du_Destin
    class DestinyBond < PokemonTiedEffectBase
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called after damages were applied and when target died (post_damage_death)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage_death(handler, hp, target, launcher, skill)
      end
      def name
      end
    end
    # Implement the Foresight effect
    # Foresight - Odor Sleuth
    class Disable < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move] move that is disabled
      def initialize(logic, pokemon, move)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Class managing Dragon Cheer move effect
    class DragonCheer < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @note Baton Pass isn't in gen IX so we have no information as of march 2024 of if it should be transferred.
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Drowsiness make the pokemon fall asleep after a certain amount of turns, applied by Yawn
    # @see https://bulbapedia.bulbagarden.net/wiki/Yawn_(move)
    class Drowsiness < PokemonTiedEffectBase
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :origin
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param counter [Integer] (default:2)
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      def initialize(logic, pokemon, counter, origin)
      end
      # If the effect can proc
      # @return [Boolean]
      def triggered?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
    end
    class EchoedVoice < EffectBase
      def initialize(logic)
      end
      # Increase the value of the successive turn
      def increase
      end
      # Number of consecutive turns where the effect has been updated
      # @return [Integer]
      def successive_turns
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      def name
      end
    end
    # Implement the change type effect (Electrify)
    class Electrify < PokemonTiedEffectBase
      # Get the type ID that replace the moves
      # @return [Integer]
      attr_reader :type
      # Create a new Electrify effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param type [Integer]
      def initialize(logic, target, type = data_type(:electric).id)
      end
      # Function called when we try to get the definitive type of a move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @param type [Integer] current type of the move (potentially after effects)
      # @return [Integer, nil] new type of the move
      def on_move_type_change(user, target, move, type)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Embargo prevents the target using any items for five turns. This includes both held items and items used by the trainer such as medicines.
    # @see https://pokemondb.net/move/embargo
    # @see https://bulbapedia.bulbagarden.net/wiki/Embargo_(move)
    # @see https://www.pokepedia.fr/Embargo
    class Embargo < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turncount [Integer]
      def initialize(logic, pokemon, turncount = 5)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
      # Message displayed when the effect prevent item usage
      # @return [String]
      def prevent_message
      end
      # Message displayed when the effect wear off
      # @return [String]
      def delete_message
      end
    end
    # Implement the flinch effect
    class Flinch < PokemonTiedEffectBase
      # Create a new Pokemon Attract effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      def initialize(logic, target)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when a status_prevention is checked
      # @param handler [Battle::Logic::StatusChangeHandler]
      # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the status cannot be applied
      def on_status_prevention(handler, status, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Class managing Focus Energy move effect
    class FocusEnergy < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Implement the Beak Blast effect
    class FocusPunch < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Tell if the effect make the pokemon preparing an attack
      # @return [Boolean]
      def preparing_attack?
      end
    end
    # Move that force the next move
    class ForceNextMoveBase < PokemonTiedEffectBase
      include Mechanics::ForceNextMove
      # Create a new Forced next move effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param turncount [Integer] number of turn the effect proc (including the current one)
      def initialize(logic, target, move, targets, turncount)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # If the effect can proc
      # @return [Boolean]
      def triggered?
      end
    end
    # Forced Next Move for rollout so it stores additional information
    class Rollout < PokemonTiedEffectBase
      include Mechanics::ForceNextMove
      include Mechanics::SuccessiveSuccessfulUses
      # Create a new Forced next move effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param turncount [Integer] (default: 5) number of turn the effect proc (including the current one)
      def initialize(logic, target, move, targets, turncount = 2)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Forced Next Move for previous move of target for 3 turns
    class Encore < PokemonTiedEffectBase
      include Mechanics::ForceNextMove
      # Create a new Forced next move effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param turncount [Integer] (default: 5) number of turn the effect proc (including the current one)
      def initialize(logic, target, move, targets, turncount = 3)
      end
      def on_delete
      end
      # Tell if the effect forces the next turn action into a Attack action
      # @return [Boolean]
      def force_next_turn_action?
      end
      # Get the class of the action
      # @return [Class<Actions::Attack>]
      def action_class
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Forced Next Move for Bide
    class Bide < PokemonTiedEffectBase
      include Mechanics::ForceNextMove
      # Get the number of damage the Pokemon got during this effect
      # @return [Integer]
      attr_accessor :damages
      # Create a new Forced next move effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param counter [Integer] number of turn the move is forced to be used (including the current one)
      # @param targets [Array<PFM::PokemonBattler>]
      def initialize(logic, target, move, targets, counter = 2)
      end
      # Function called after damages were applied (post_damage, when target is still alive)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage(handler, hp, target, launcher, skill)
      end
      # Tell if the bide can unleach
      # @return [Boolean]
      def unleach?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Foresight effect
    # Foresight - Odor Sleuth
    class Foresight < PokemonTiedEffectBase
      # Function that computes an overwrite of the type multiplier
      # @param target [PFM::PokemonBattler]
      # @param target_type [Integer] one of the type of the target
      # @param type [Integer] one of the type of the move
      # @param move [Battle::Move]
      # @return [Float, nil] overwriten type multiplier
      def on_single_type_multiplier_overwrite(target, target_type, type, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Effect that manage Fury Cutter effect
    class FuryCutter < PokemonTiedEffectBase
      include Mechanics::SuccessiveSuccessfulUses
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move]
      def initialize(logic, pokemon, move)
      end
      # Return the symbol of the effect.
      # @return [Symbol]
      def name
      end
    end
    class FutureSight < PositionTiedEffectBase
      # Create a new position tied effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param bank [Integer] bank where the effect is tied
      # @param position [Integer] position where the effect is tied
      # @param origin [PFM::PokemonBattler]
      # @param countdown [Integer] amount of turn before the effect proc (including the current one)
      # @param move [Battle::Move]
      def initialize(logic, bank, position, origin, countdown, move)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Find the defintive target
      # @return [PFM::PokemonBattler, nil]
      def find_target
      end
      # Message displayed when the effect proc
      # @return [String]
      def message(target)
      end
    end
    # Implement the Glaive Rush effect
    class GlaiveRush < PokemonTiedEffectBase
      # Function called at the end of an action
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_post_action_event(logic, scene, battlers)
      end
      # Give the move mod3 mutiplier (after everything)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod3_multiplier(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Gravity < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Return the chance of hit multiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move]
      # @return [Float]
      def chance_of_hit_multiplier(user, target, move)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Show the message when the effect gets deleted
      def on_delete
      end
      private
      # kill effects that force battlers to fly
      # @param battlers [Array<PFM::PokemonBattler>]
      def kill_flying_effects(battlers)
      end
    end
    # Implement the Grudge effect
    class Grudge < PokemonTiedEffectBase
      # Function called after damages were applied and when target died (post_damage_death)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage_death(handler, hp, target, launcher, skill)
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # HappyHour Effect
    class HappyHour < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Miracle Eye effect
    class HealBlock < PokemonTiedEffectBase
      # Create a new Pokemon HealBlock effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param turn_count [Integer]
      def initialize(logic, target, turn_count = 5)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Healing Wish Effect
    class HealingWish < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
    end
    class HelpingHand < PokemonTiedEffectBase
      include Mechanics::WithMarkedTargets
      # Create a new HelpingHand effect
      # @param logic [Battle::Logic]
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param duration [Integer]
      def initialize(logic, user, target, duration)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # @param target [PFM::PokemonBattler]
      # @param duration [Integer]
      # @return [EffectBase]
      def create_mark_effect(target, duration)
      end
      # Class marking the target of the HelpingHand so we cannot apply the effect twice
      class Mark < PokemonTiedEffectBase
        include Mechanics::Mark
        # Create a new mark
        # @param logic [Battle::Logic]
        # @param pokemon [PFM::PokemonBattler]
        # @param origin [HelpingHand] origin of the mark
        def initialize(logic, pokemon, origin, duration)
        end
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
        end
        # Name of the effect
        # @return [Symbol]
        def name
        end
      end
    end
    class Imprison < PokemonTiedEffectBase
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Boolean]
      def can_be_used?(user, move)
      end
    end
    # Ingrain Effect
    class Ingrain < CantSwitch
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      # @param move [Battle::Move] move responsive of the effect
      def initialize(logic, pokemon, origin, move)
      end
      # Function called when testing if pokemon can switch (when he couldn't passthrough)
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:prevent, nil] if :prevent, can_switch? will return false
      def on_switch_prevention(handler, pokemon, skill, reason)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Get the message text
      # @return [String]
      def message
      end
      # Get the flee message text
      # @return [String]
      def flee_message
      end
      # Get the HP factor delt by the move
      # @return [Integer]
      def hp_factor
      end
      # kill effects that force battlers to fly
      # @param battlers [PFM::PokemonBattler]
      def kill_flying_effects(pokemon)
      end
    end
    # Implement the Beak Blast effect
    class Instruct < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called at the end of an action
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_post_action_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # IonDeluge Effect
    class IonDeluge < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Function called when we try to get the definitive type of a move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @param type [Integer] current type of the move (potentially after effects)
      # @return [Integer, nil] new type of the move
      def on_move_type_change(user, target, move, type)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Item Burnt effect
    class ItemBurnt < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Item Stolen effect
    class ItemStolen < PokemonTiedEffectBase
      # Function called when a post_item_change is checked
      # @param handler [Battle::Logic::ItemChangeHandler]
      # @param db_symbol [Symbol] Symbol ID of the item
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_item_change(handler, db_symbol, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Laser Focus effect
    class LaserFocus < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      def initialize(logic, pokemon)
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Implementation of Leech Seed effect
    # This class drains the target hp to the Pokemon in the position of its user
    class LeechSeed < PositionTiedEffectBase
      include Mechanics::WithMarkedTargets
      # Create a new position LeechSeed effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param user [PFM::PokemonBattler] receiver of that effect
      # @param target [PFM::PokemonBattler] pokemon getting the damages
      def initialize(logic, user, target)
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Divisor factor of the drain
      # @return [Integer]
      def leech_power
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Class marking the target of the LeechSeed so we cannot apply the effect twice
      class Mark < PokemonTiedEffectBase
        include Mechanics::Mark
        # Create a new mark
        # @param logic [Battle::Logic]
        # @param pokemon [PFM::PokemonBattler]
        # @param origin [LeechSeed] origin of the mark
        # @param leech_power [Integer] base power of the leech
        def initialize(logic, pokemon, origin, leech_power)
        end
        # Function that tells if the move is affected by Rapid Spin
        # @return [Boolean]
        def rapid_spin_affected?
        end
        # Get the name of the effect
        # @return [Symbol]
        def name
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Transfer the effect to the given pokemon via baton switch
        # @param with [PFM::Battler] the pokemon switched in
        # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
        def baton_switch_transfer(with)
        end
      end
    end
    # Class managing Light Screen move effect
    class LightScreen < PositionTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param bank [Integer] bank where the effect is tied
      # @param position [Integer] position where the effect is tied
      # @param turn_count [Integer] number of turn for the confusion (not including current turn)
      def initialize(logic, bank, position, turn_count = 5)
      end
      # Give the move mod1 mutiplier (before the +2 in the formula)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod1_multiplier(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      private
      # ID of the message responsive of telling the end of the effect
      # @return [Integer]
      def message_id
      end
    end
    # Class managing Reflect move effect
    class Reflect < LightScreen
      # Give the move mod1 mutiplier (before the +2 in the formula)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod1_multiplier(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # ID of the message responsive of telling the end of the effect
      # @return [Integer]
      def message_id
      end
    end
    # Class managing Aurora Veil move effect
    class AuroraVeil < LightScreen
      # Give the move mod1 mutiplier (before the +2 in the formula)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod1_multiplier(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # ID of the message responsive of telling the end of the effect
      # @return [Integer]
      def message_id
      end
    end
    # Implement the Lock-On and Mind Reader effect
    class LockOn < PokemonTiedEffectBase
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :target
      # Create a new Pokemon Lock-On effect
      # @param logic [Battle::Logic]
      # @param user [PFM::PokemonBattler] pokemon aiming
      # @param target [PFM::PokemonBattler] pokemon aimed
      # @param turncount [Integer] (default: 2)
      def initialize(logic, user, target, turncount = 2)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    class LuckyChant < PositionTiedEffectBase
      # Create a new Lucky Chant effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      def on_delete
      end
      private
      # ID of the message that is responsible for telling the end of the effect
      # @return [Integer]
      def message_id
      end
    end
    # Lunar Dance Effect
    class LunarDance < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
    end
    # Implement the change type effect (Electrify)
    class MagicCoat < PokemonTiedEffectBase
      # Create a new Electrify effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      def initialize(logic, target)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class MagicRoom < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic, duration)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      def name
      end
      # Function called when a held item wants to perform its action
      # @return [Boolean] weither or not the item can't proceed (true will stop the item)
      def on_held_item_use_prevention
      end
    end
    # User becomes immune to Ground-type moves for N turns.
    class MagnetRise < PokemonTiedEffectBase
      include Mechanics::ForceFlying
      Mechanics::ForceFlying.register_force_flying_hook('PSDK flying: Magnet Rise', :magnet_rise)
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param duration [Integer] (default: 5) duration of the move (including the current turn)
      def initialize(logic, pokemon, duration = 5)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Message displayed when the effect wear off
      # @return [String]
      def on_delete_message
      end
    end
    # Implement the Minimize effect
    class Minimize < PokemonTiedEffectBase
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Miracle Eye effect
    class MiracleEye < PokemonTiedEffectBase
      # Function that computes an overwrite of the type multiplier
      # @param target [PFM::PokemonBattler]
      # @param target_type [Integer] one of the type of the target
      # @param type [Integer] one of the type of the move
      # @param move [Battle::Move]
      # @return [Float, nil] overwriten type multiplier
      def on_single_type_multiplier_overwrite(target, target_type, type, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Mist < PositionTiedEffectBase
      # Create a new Mist effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when a stat_decrease_prevention is checked
      # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the stat decrease cannot apply
      def on_stat_decrease_prevention(handler, stat, target, launcher, skill)
      end
    end
    # Effect lowering Electric moves
    class MudSport < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Give the move base power mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def base_power_multiplier(user, target, move)
      end
      # Show the message when the effect gets deleted
      def on_delete
      end
    end
    # Effect lowering Fire moves
    class WaterSport < MudSport
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Give the move base power mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def base_power_multiplier(user, target, move)
      end
      # Show the message when the effect gets deleted
      def on_delete
      end
    end
    # Implement the Nightmare effect
    class Nightmare < PokemonTiedEffectBase
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class NoRetreat < CantSwitch
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Octolock < Bind
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
    end
    # Implement the Out of Reach effect
    class OutOfReachBase < PokemonTiedEffectBase
      include Mechanics::OutOfReach
      # Create a new out reach effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param exceptions [Array<Symbol>] move that hit the target while out of reach
      # @param turncount [Integer] (default: 5) number of turn the effect proc (including the current one)
      def initialize(logic, pokemon, move, exceptions, turncount = 2)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Effect used by Perish Song move
    class PerishSong < EffectBase
      def origin
      end
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param pokemon [PFM::PokemonBattler] target that will be affected by the effect
      # @param countdown [Integer] number of turn before the effect proc (including the current one)
      def initialize(logic, pokemon, countdown)
      end
      # If the effect can proc
      # @return [Boolean]
      def triggered?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Implement the Powder effect
    class Powder < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class PreventTargetsMove < PokemonTiedEffectBase
      include Mechanics::WithTargets
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic, user, targets, duration = 1)
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
    end
    # Implement the Protect effect
    class Protect < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param move [Battle::Move] move that applied this effect
      def initialize(logic, pokemon, move)
      end
      # Function called when we try to check if the target evades the move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @return [Boolean] if the target is evading the move
      def on_move_prevention_target(user, target, move)
      end
      # Function called when we try to check if the move goes through protect
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @return [Boolean] if the move goes through protect
      def goes_through_protect?(user, target, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Handle the mirror armor effect (special case)
      # @param user [PFM::PokemonBattler, nil] Potential launcher of a move
      # @return [PFM::PokemonBattler, nil]
      def handle_mirror_armor_effect(user, target)
      end
      private
      # Function responsive of playing the protect effect if protect got triggered (inc. message)
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      def play_protect_effect(user, target, move)
      end
      @effect_classes = {}
      class << self
        # Register a Protect effect
        # @param db_symbol [Symbol] db_symbol of the move
        # @param klass [Class<Protect>] protect class
        def register(db_symbol, klass)
        end
        # Create a new effect
        # @param logic [Battle::Logic]
        # @param pokemon [PFM::PokemonBattler]
        # @param move [Battle::Move] move that applied this effect
        # @return [Protect]
        def new(logic, pokemon, move)
        end
      end
      # Implement the Spiky Shield effect
      class SpikyShield < Protect
        private
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:spiky_shield, SpikyShield)
      # Implement the King's Shield effect
      class KingsShield < Protect
        # Function called when we try to check if the move goes through protect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the move goes through protect
        def goes_through_protect?(user, target, move)
        end
        private
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:king_s_shield, KingsShield)
      # Implement the Silk Trap effect
      class SilkTrap < Protect
        # Function called when we try to check if the move goes through protect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the move goes through protect
        def goes_through_protect?(user, target, move)
        end
        private
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:silk_trap, SilkTrap)
      # Implement the Obstruct effect
      class Obstruct < SilkTrap
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
        private
        # Function called when we try to check if the Pokemon is immune to a move's types
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to a move's types
        def immune?(user, target, move)
        end
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:obstruct, Obstruct)
      # Implement the Baneful Bunker effect
      class BanefulBunker < Protect
        private
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:baneful_bunker, BanefulBunker)
      # Implement the Burning Bulwark effect
      class BurningBulwark < Protect
        # Function called when we try to check if the move goes through protect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the move goes through protect
        def goes_through_protect?(user, target, move)
        end
        private
        # Function responsive of playing the protect effect if protect got triggered (inc. message)
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        def play_protect_effect(user, target, move)
        end
      end
      Protect.register(:burning_bulwark, BurningBulwark)
      # Implement the Mat Block effect
      class MatBlock < Protect
        # Function that tests if the user is able to use the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
        # @return [Boolean] if the procedure can continue
        def move_usable_by_user(user, targets)
        end
        # Function called when we try to check if the move goes through protect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the move goes through protect
        def goes_through_protect?(user, target, move)
        end
      end
      Protect.register(:mat_block, MatBlock)
      # Implement the Mat Block effect
      class Endure < PokemonTiedEffectBase
        # Create a new Pokemon tied effect
        # @param logic [Battle::Logic]
        # @param pokemon [PFM::PokemonBattler]
        # @param move [Battle::Move] move that applied this effect
        def initialize(logic, pokemon, move)
        end
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
        end
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      Protect.register(:endure, Endure)
      # Implement the Quick Guard effect
      class QuickGuard < Protect
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
      end
      Protect.register(:quick_guard, QuickGuard)
      # Implement the Wide Guard effect
      class WideGuard < Protect
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
      end
      Protect.register(:wide_guard, WideGuard)
    end
    # Implement the Rage effect
    class Rage < PokemonTiedEffectBase
      # Function called after damages were applied (post_damage, when target is still alive)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage(handler, hp, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Class managing Roost Effect
    class Roost < PokemonTiedEffectBase
      include Mechanics::NeutralizeType
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turn_count [Integer]
      def initialize(logic, pokemon, turn_count)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Get the neutralized types
      # @return [Array<Integer>]
      def neutralyzed_types
      end
    end
    # The user's party is protected from status conditions.
    class Safeguard < LightScreen
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when a status_prevention is checked
      # @param handler [Battle::Logic::StatusChangeHandler]
      # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the status cannot be applied
      def on_status_prevention(handler, status, target, launcher, skill)
      end
      private
      # Items that procs status even with Safeguard activated
      # @return [Array<Symbol>]
      ITEM_EXCEPTIONS = %i[flame_orb toxic_orb]
      # Items that procs status even with Safeguard activated
      # @return [Array<Symbol>]
      MOVE_EXCEPTIONS = %i[petal_dance outrage thrash]
      # Items that procs status even with Safeguard activated
      # @return [Array<Symbol>]
      def item_exceptions
      end
      # Items that procs status even with Safeguard activated
      # @return [Array<Symbol>]
      def move_exceptions
      end
      # ID of the message responsive of telling the end of the effect
      # @return [Integer]
      def message_id
      end
      # ID of the message responsive of telling when the effect prevent a status
      def status_prevention_message_id
      end
    end
    # Implement the Salt Cure effect
    class SaltCure < PokemonTiedEffectBase
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class ShedTail < PokemonTiedEffectBase
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class ShellTrap < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called after damages were applied (post_damage, when target is still alive)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage(handler, hp, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Tell if the effect make the pokemon preparing an attack
      # @return [Boolean]
      def preparing_attack?
      end
    end
    # SmackDown Effect
    class SmackDown < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function that computes an overwrite of the type multiplier
      # @param target [PFM::PokemonBattler]
      # @param target_type [Integer] one of the type of the target
      # @param type [Integer] one of the type of the move
      # @param move [Battle::Move]
      # @return [Float, nil] overwriten type multiplier
      def on_single_type_multiplier_overwrite(target, target_type, type, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # kill effects that force pokemon to fly
      # @param pokemon [PFM::PokemonBattler]
      def kill_flying_effects(pokemon)
      end
    end
    class Snatch < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param turncount [Integer]
      def initialize(logic, pokemon, turncount = 1)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Snatched < Snatch
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Spikes < PositionTiedEffectBase
      # Get the Spike power
      # @return [Integer]
      attr_reader :power
      # Create a new spike effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Tell if the spikes are at max power
      # @return [Boolean]
      def max_power?
      end
      # Increase the spike power
      def empower
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
    end
    class StealthRock < PositionTiedEffectBase
      DMG_FACTOR = {0.25 => 3.125, 0.5 => 6.25, 1 => 12.5, 2 => 25, 4 => 50}
      # Create a new Sticky Web effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      # @param move [Battle::Move::StealthRock]
      def initialize(logic, bank, move)
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      private
      # Get the message text
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def message(pokemon)
      end
      # Get the damage message text
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def damage_message(pokemon)
      end
    end
    class StickyWeb < PositionTiedEffectBase
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :origin
      # Create a new Sticky Web effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      # @param origin [PFM::PokemonBattler] the Pokemon that launched the attack
      def initialize(logic, bank, origin)
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Get the message text
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def message(pokemon)
      end
    end
    # Stockpile raises the user's Defense and Special Defense by one stage each and charges up power for use with companion moves Spit Up or Swallow.
    # @see https://pokemondb.net/move/stockpile
    # @see https://bulbapedia.bulbagarden.net/wiki/Stockpile_(move)
    # @see https://www.pokepedia.fr/Stockage
    class Stockpile < PokemonTiedEffectBase
      # Return the amount in stockpile
      # @return [Integer]
      attr_reader :stockpile
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Is the effect increasable?
      # @return [Boolean]
      def increasable?
      end
      # Is the effect usable ?
      # @return [Boolean]
      def usable?
      end
      # Increase the stockpile value with animation
      # @param amount [Integer] (default: 1)
      # @return [Boolean] if the increase proc or not
      def increase(amount = 1)
      end
      # Function called when the effect is being used
      # @return [Boolean] if the effect has been used or not
      def use
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      # Maximum stockpile
      # @return [Integer]
      def maximum
      end
      private
      # Apply the change of the stat changes
      def edit_stages
      end
      # Reset the effect of stockpile on stat stage
      def restore_stages
      end
      # Message displayed after a pokemon stockpile
      # @return [String]
      def on_increase_message
      end
      # Message displayed when the stockpile is being cleared
      # @return [String]
      def on_clear_message
      end
    end
    # Implement the Substitute effect
    class Substitute < PokemonTiedEffectBase
      # Get the substitute hp
      # @return [Integer]
      attr_accessor :hp
      # Get the substitute max hp
      attr_reader :max_hp
      # @return [Array<Symbol>]
      CANT_IGNORE_SUBSTITUTE = %i[transform sky_drop]
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called when a stat_increase_prevention is checked
      # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the stat increase cannot apply
      def on_stat_increase_prevention(handler, stat, target, launcher, skill)
      end
      # Function called when a stat_decrease_prevention is checked
      # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the stat decrease cannot apply
      def on_stat_decrease_prevention(handler, stat, target, launcher, skill)
      end
      # Function called when a damage_prevention is checked
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
      def on_damage_prevention(handler, hp, target, launcher, skill)
      end
      # Function called when a status_prevention is checked
      # @param handler [Battle::Logic::StatusChangeHandler]
      # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the status cannot be applied
      def on_status_prevention(handler, status, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called at the end of an action
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_post_action_event(logic, scene, battlers)
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Play the right Substitute animation depending on the given reason
      # @param reason [Symbol] :to => from sprite to substitute, :from => from substitute to sprite
      def play_substitute_animation(reason = :from)
      end
      # Applies the sprite change directly
      # @param method_name [Symbol] :switch_from_substitute_animation, :switch_to_substitute_animation
      def direct_sprite_change(method_name)
      end
      # Force the reset of the user's sprite to its original sprite
      def reset_user_sprite
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon, nil if there is this effect isn't transferable via baton pass
      def baton_switch_transfer(with)
      end
    end
    # Implement the Syrup Bomb effect
    class SyrupBomb < PokemonTiedEffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param pokemon [PFM::PokemonBattler] target that will be affected by the effect
      # @param turn_count [Integer] number of turn before the effect proc (including the current one)
      # @param origin [PFM::PokemonBattler] battler that created the effect
      def initialize(logic, pokemon, turn_count, origin)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Tailwind < PositionTiedEffectBase
      # Create a new Tailwind effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Give the speed modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def spd_modifier
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
    end
    # TarShot Effect
    class TarShot < PokemonTiedEffectBase
      # Choose the type to add as a weakness according to the move_db_symbol used to add this weakness
      ADD_WEAKNESS_TO = {tar_shot: :fire}
      # Create a new TarShot effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param origin_move [Symbol] the move that caused this effect
      def initialize(logic, target, origin_move)
      end
      # Function that computes an overwrite of the type multiplier
      # @param target [PFM::PokemonBattler]
      # @param target_type [Integer] one of the type of the target
      # @param type [Integer] one of the type of the move
      # @param move [Battle::Move]
      # @return [Float, nil] overwriten type multiplier
      def on_single_type_multiplier_overwrite(target, target_type, type, move)
      end
      # Compare the added type weakness with all other types
      # @param type_added [Integer] type added by the move that caused this effect
      def type_check(type_added)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Taunt effect
    class Taunt < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Telekinesis < PokemonTiedEffectBase
      include Mechanics::ForceFlying
      Mechanics::ForceFlying.register_force_flying_hook('PSDK flying: Telekinesis', :telekinesis)
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param duration [Integer] (default: 3) duration of the move (including the current turn)
      def initialize(logic, pokemon, duration = 3)
      end
      # Function called at the end of an action
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      # @note Specific interaction with Mega Gengar, we pass into this function just after activating the mega (which is an action)
      def on_post_action_event(logic, scene, battlers)
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Message displayed when the effect wear off
      # @return [String]
      def on_delete_message
      end
    end
    class ThroatChop < PokemonTiedEffectBase
      # The Pokemon that launched the attack
      # @return [PFM::PokemonBattler]
      attr_reader :origin
      # Create a new Throat Chop effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      # @param turn_count [Integer]
      # @param move [Battle::Move] move responsive of the effect
      def initialize(logic, target, origin, turn_count, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # Implement the Torment effect
    class Torment < PokemonTiedEffectBase
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Boolean]
      def can_be_used?(user, move)
      end
    end
    class ToxicSpikes < PositionTiedEffectBase
      # Get the Toxic Spikes power
      # @return [Integer]
      attr_reader :power
      # Create a new spike effect
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Get the effect name
      # @return [Symbol]
      def name
      end
      # Increase the spike power
      def empower
      end
      # Tell if the toxic spikes are at max power
      # @return [Boolean]
      def max_power?
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
    end
    # Implement the Transform effect
    class Transform < PokemonTiedEffectBase
      # Function called when a Pokemon has actually switched with another one
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    # TrickRoom Effect
    class TrickRoom < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Show the message when the effect gets deleted
      def on_delete
      end
    end
    # Class managing Triple Arrows move effect
    class TripleArrows < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param counter [Integer]
      def initialize(logic, pokemon, counter)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] nil if the effect is not transferable, otherwise the effect
      def baton_switch_transfer(with)
      end
    end
    class UpRoar < PokemonTiedEffectBase
      include Mechanics::ForceNextMove
      # Create a new Forced next move effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param counter [Integer] number of turn the move is forced to be used (including the current one)
      # @param targets [Array<PFM::PokemonBattler>]
      def initialize(logic, target, move, targets, counter)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Is the effect in its last turn ?
      # @return [Boolean]
      def triggered?
      end
      # Name of the effect
      # @return [Symbol]
      def name
      end
      class SleepPrevention < EffectBase
        # Create a new effect
        # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
        # @param origin [PFM::PokemonBattler] origin of the effect
        def initialize(logic, origin)
        end
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Name of the effect
        # @return [Symbol]
        def name
        end
      end
      private
      # Wake up all the asleep pokemons
      def wake_up_pokemons
      end
      # Id of the message displayed when the uproar wake up a battler
      # @return [Integer]
      def wake_up_message_id
      end
      # Message displayed at the beginning of the uproar
      # @param user [PFM::PokemonBattler] the user of the upraor
      # @return [String]
      def provoke_message(user)
      end
      # Message displayed at the end of the turn when the uproar continue
      # @param user [PFM::PokemonBattler] the user of the upraor
      # @return [String]
      def continue_message(user)
      end
      # Message displayed at the end of the uproar
      # @param user [PFM::PokemonBattler] the user of the upraor
      # @return [String]
      def calm_down_message(user)
      end
    end
    class Wish < PositionTiedEffectBase
      # Create a new position tied effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param bank [Integer] bank where the effect is tied
      # @param position [Integer] position where the effect is tied
      def initialize(logic, bank, position, hp)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      def name
      end
      # Get the message text
      # @return [String]
      def message
      end
    end
    class WonderRoom < EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param duration [Integer] duration of the effect
      def initialize(logic, targets, duration)
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      def name
      end
      private
      # Switch the stats
      def switch_stats
      end
    end
    class Rainbow < PositionTiedEffectBase
      # Create a new Rainbow effect (Water Pledge + Fire Pledge)
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Give the effect chance modifier given to the Pokémon with this effect
      # @param move [Battle::Move::Basic] the move the chance modifier will be applied to
      # @return [Float, Integer] multiplier
      def effect_chance_modifier(move)
      end
      # Display the message associated with the effect's creation
      def effect_creation_text
      end
      # Method called when the Effect is deleted
      def on_delete
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class SeaOfFire < PositionTiedEffectBase
      # Create a new Sea of Fire effect (Grass Pledge + Fire Pledge)
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Display the message associated with the effect's creation
      def effect_creation_text
      end
      # Method called when the Effect is deleted
      def on_delete
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
      private
      # Return the damage dealt to a Pokémon by the Sea of Fire effect
      def sea_of_fire_effect(target)
      end
    end
    class Swamp < PositionTiedEffectBase
      # Create a Swamp effect (Grass Pledge + Water Pledge)
      # @param logic [Battle::Logic]
      # @param bank [Integer] bank where the effect acts
      def initialize(logic, bank)
      end
      # Give the speed modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def spd_modifier
      end
      # Display the message associated with the effect's creation
      def effect_creation_text
      end
      # Method called when the Effect is deleted
      def on_delete
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
  end
end
