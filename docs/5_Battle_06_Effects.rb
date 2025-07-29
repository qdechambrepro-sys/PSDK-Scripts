module Battle
  # Module responsive of storing all the effects of the battle engine
  module Effects
    # Class responsive of handling the effects active on something (terrain, pokemon, bank position)
    class EffectsHandler
      # Create a new effect handler
      def initialize
      end
      # Update the counter of all effects
      def update_counter
      end
      # Tell if an effect is present
      # @param name [Symbol, nil] name of the effect. Ignored if a block is given.
      # @param block [Proc, nil] (optional) block testing each effect
      # @return [Boolean] if the effect is present
      # @yieldparam effect [EffectBase]
      def has?(name = nil, &block)
      end
      # Add an effect
      # @param effect [EffectBase]
      def add(effect)
      end
      # Replace the effects matching the block by the new one
      # @param effect [EffectBase]
      # @param block [Proc]
      def replace(effect, &block)
      end
      # Get an effect using its name or a block
      # @param name [Symbol, nil] name of the effect. Ignored if a block is given.
      # @param block [Proc, nil] (optional) block testing each effect
      # @return [EffectBase, nil]
      # @yieldparam effect [EffectBase]
      def get(name = nil, &block)
      end
      # Get every effects responding to a name or a block
      # @param name [Symbol, nil] name of the effects. Ignored if a block is given.
      # @param block [Proc, nil] (optional) block testing each effect
      # @return [Array<EffectBase>, Array<NilClass>]
      # @yieldparam effect [EffectBase]
      def get_all(name = nil, &block)
      end
      # Call something on all effects
      # @param block [Proc] block that is called for the each process
      # @yieldparam effect [Battle::Effects::EffectBase]
      # @note automatically calls deleted_dead_effects if a block is given
      def each(&block)
      end
      # Delete all the effect that should be deleted
      def deleted_dead_effects
      end
      # Delete specific dead effect
      # @param name [Symbol]
      def delete_specific_dead_effect(name)
      end
    end
    # Class describing all the effect ("abstract") and helping the handler to manage effect
    class EffectBase
      # Create a new effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      def initialize(logic)
      end
      # Function that sets the counter
      # @param counter [Integer] new counter value
      def counter=(counter)
      end
      # Function that updates the counter of the effect
      def update_counter
      end
      # Function telling if the effect should be removed from effects handler
      # @return [Boolean]
      def dead?
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
      # Kill the effect (in order to remove it from the effects handler)
      def kill
      end
      # Function called when the effect has been deleted from the effects handler
      def on_delete
      end
      # Function that tells if the move is affected by Rapid Spin
      # @return [Boolean]
      def rapid_spin_affected?
      end
      # Tell if the effect forces the next move
      # @return [Boolean]
      def force_next_move?
      end
      # Tell if the effect forces the next turn action into a Attack action
      # @return [Boolean]
      def force_next_turn_action?
      end
      # Tell if the effect make the pokemon out reach
      # @return [Boolean]
      def out_of_reach?
      end
      # Tell if the effect make the pokemon preparing an attack
      # @return [Boolean]
      def preparing_attack?
      end
      # Check if the attack can hit the pokemon. Should be called after testing out_of_reach?
      # @param name [Symbol]
      # @return [Boolean]
      def can_attack_hit_out_of_reach?(name)
      end
      # Tell if the given battler is targetted by the effect
      # @param battler [PFM::PokemonBattler]
      # @return [Boolean]
      def targetted?(battler)
      end
      # Function called when a held item wants to perform its action
      # @return [Boolean] weither or not the item can't proceed (true will stop the item)
      def on_held_item_use_prevention
      end
      # Function called after a battler proceed its two turn move's first turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>, nil]
      # @param skill [Battle::Move, nil]
      # @return [Boolean] weither or not the two turns move is executed in one turn
      def on_two_turn_shortcut(user, targets, skill)
      end
      # Check if the user of this ability ignore the center of attention in the enemy bank
      # @return [Boolean]
      def ignore_target_redirection?
      end
      # Apply the common effects of the item with Fling move effect
      # @param scene [Battle::Scene] battle scene
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def apply_common_effects_with_fling(scene, target, launcher, skill)
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
      # Function called when a stat_change is about to be applied
      # @param handler [Battle::Logic::StatChangeHandler]
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param power [Integer] power of the stat change
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [Integer, nil] if integer, it will change the power
      def on_stat_change(handler, stat, power, target, launcher, skill)
      end
      # Function called when a stat_change has been applied
      # @param handler [Battle::Logic::StatChangeHandler]
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param power [Integer] power of the stat change
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [Integer, nil] if integer, it will change the power
      def on_stat_change_post(handler, stat, power, target, launcher, skill)
      end
      # Function called when a pre_item_change is checked
      # @param handler [Battle::Logic::ItemChangeHandler]
      # @param db_symbol [Symbol] Symbol ID of the item
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the item change cannot be applied
      def on_pre_item_change(handler, db_symbol, target, launcher, skill)
      end
      # Function called when a post_item_change is checked
      # @param handler [Battle::Logic::ItemChangeHandler]
      # @param db_symbol [Symbol] Symbol ID of the item
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_item_change(handler, db_symbol, target, launcher, skill)
      end
      # Function called when a ability_change_prevention is checked
      # @param handler [Battle::Logic::AbilityChangeHandler]
      # @param db_symbol [Symbol] symbol of the ability to give
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the ability cannot be changed
      def on_ability_change_prevention(handler, target, launcher, skill)
      end
      # Function called when a pre_ability_change is checked
      # @param handler [Battle::Logic::AbilityChangeHandler]
      # @param db_symbol [Symbol] symbol of the ability to give
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_pre_ability_change(handler, db_symbol, target, launcher, skill)
      end
      # Function called when a post_ability_change is checked
      # @param handler [Battle::Logic::AbilityChangeHandler]
      # @param db_symbol [Symbol] symbol of the ability to give
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_ability_change(handler, db_symbol, target, launcher, skill)
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
      # Function called when a post_status_change is performed
      # @param handler [Battle::Logic::StatusChangeHandler]
      # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_status_change(handler, status, target, launcher, skill)
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
      # Function called after damages were applied and when target died (post_damage_death)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage_death(handler, hp, target, launcher, skill)
      end
      # Function called before drain were applied (to potentially prevent healing)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param hp_healed [Integer] number of hp healed
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [:prevent, nil] :prevent if the drain cannot be applied
      def on_drain_prevention(handler, hp, hp_healed, target, launcher, skill)
      end
      # Function called when testing if pokemon can switch regardless of the prevension.
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:passthrough, nil] if :passthrough, can_switch? will return true without checking switch_prevention
      def on_switch_passthrough(handler, pokemon, skill, reason)
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
      # @param handler [Battle::Logic::SwitchHandler]
      # @param who [PFM::PokemonBattler] Pokemon that is switched out
      # @param with [PFM::PokemonBattler] Pokemon that is switched in
      def on_switch_event(handler, who, with)
      end
      # Function called at the end of an action
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_post_action_event(logic, scene, battlers)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # Function called when a weather_prevention is checked
      # @param handler [Battle::Logic::WeatherChangeHandler]
      # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
      # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
      # @return [:prevent, nil] :prevent if the status cannot be applied
      def on_weather_prevention(handler, weather_type, last_weather)
      end
      # Function called after the weather was changed (on_post_weather_change)
      # @param handler [Battle::Logic::WeatherChangeHandler]
      # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
      # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
      def on_post_weather_change(handler, weather_type, last_weather)
      end
      # Function called when a fterrain_prevention is checked
      # @param handler [Battle::Logic::FTerrainChangeHandler]
      # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
      # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
      # @return [:prevent, nil] :prevent if the status cannot be applied
      def on_fterrain_prevention(handler, fterrain_type, last_fterrain)
      end
      # Function called after the terrain was changed
      # @param handler [Battle::Logic::FTerrainChangeHandler]
      # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
      # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
      def on_post_fterrain_change(handler, fterrain_type, last_fterrain)
      end
      # Function called before the accuracy check of a move is done
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param targets [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_pre_accuracy_check(logic, scene, targets, launcher, skill)
      end
      # Function called after the accuracy check of a move is done (and the move should land)
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param targets [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_accuracy_check(logic, scene, targets, launcher, skill)
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when we try to check if the target evades the move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @return [Boolean] if the target is evading the move
      def on_move_prevention_target(user, target, move)
      end
      # Function called when we try to get the definitive type of a move
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] expected target
      # @param move [Battle::Move]
      # @param type [Integer] current type of the move (potentially after effects)
      # @return [Integer, nil] new type of the move
      def on_move_type_change(user, target, move, type)
      end
      # Function called when we try to check if the user cannot use a move
      # @param user [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_disabled_check(user, move)
      end
      # Function called when we try to check if the effect changes the definitive priority of the move
      # @param user [PFM::PokemonBattler]
      # @param priority [Integer]
      # @param move [Battle::Move]
      # @return [Proc, nil]
      def on_move_priority_change(user, priority, move)
      end
      # Function called when we try to check if the Pokemon is immune to a move due to its effect
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @return [Boolean] if the target is immune to the move
      def on_move_ability_immunity(user, target, move)
      end
      # Function called when a Pokemon initialize a transformation
      # @param handler [Battle::Logic::TransformHandler]
      # @param target [PFM::PokemonBattler]
      def on_transform_event(handler, target)
      end
      # Function that computes an overwrite of the type multiplier
      # @param target [PFM::PokemonBattler]
      # @param target_type [Integer] one of the type of the target
      # @param type [Integer] one of the type of the move
      # @param move [Battle::Move]
      # @return [Float, nil] overwriten type multiplier
      def on_single_type_multiplier_overwrite(target, target_type, type, move)
      end
      # Function called before drain were applied (to change the number of hp healed)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      # @return [Float, Integer] multiplier
      def on_pre_drain(handler, hp, target, launcher, skill)
      end
      # Give the move base power mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def base_power_multiplier(user, target, move)
      end
      # Give the move [Spe]atk mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def sp_atk_multiplier(user, target, move)
      end
      # Give the move [Spe]def mutiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def sp_def_multiplier(user, target, move)
      end
      # Give the move mod1 mutiplier (before the +2 in the formula)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod1_multiplier(user, target, move)
      end
      # Give the move mod1 mutiplier (after the critical)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod2_multiplier(user, target, move)
      end
      # Give the move mod3 mutiplier (after everything)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move] move
      # @return [Float, Integer] multiplier
      def mod3_multiplier(user, target, move)
      end
      # Give the atk modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def atk_modifier
      end
      # Give the dfe modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfe_modifier
      end
      # Give the speed modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def spd_modifier
      end
      # Give the ats modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def ats_modifier
      end
      # Give the dfs modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfs_modifier
      end
      # Give the effect chance modifier given to the Pokémon with this effect
      # @param move [Battle::Move::Basic] the move the chance modifier will be applied to
      # @return [Float, Integer] multiplier
      def effect_chance_modifier(move)
      end
      # Return the chance of hit multiplier
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param move [Battle::Move]
      # @return [Float]
      def chance_of_hit_multiplier(user, target, move)
      end
      # Return the specific proceed_internal if the condition is fulfilled
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param move [Battle::Move]
      def specific_proceed_internal(user, targets, move)
      end
      # Return the new target if the conditions are fulfilled
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param move [Battle::Move]
      # @return [PFM::PokemonBattler] the new target if the conditions are fulfilled, the initial target otherwise
      def target_redirection(user, targets, move)
      end
      private
      # Function that disable all the hooks (putting aside on_delete)
      def disable_hooks
      end
    end
    # Class that describe an effect that is tied to a Pokemon
    class PokemonTiedEffectBase < EffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      def initialize(logic, pokemon)
      end
      # Function called when we the effect is passed to another pokemon via Baton Pass
      # @param with [PFM::PokemonBattler] pokemon switched in
      # @return [Boolean, nil] True if the effect is passed
      def on_baton_pass_switch(with)
      end
      private
      # Transfer the effect to the given pokemon via baton switch
      # @param with [PFM::Battler] the pokemon switched in
      # @return [Battle::Effects::PokemonTiedEffectBase, nil] the effect to give to the switched in pokemon when transferable via baton pass, nil otherwise
      def baton_switch_transfer(with)
      end
    end
    # Class that describe an effect that is tied to a position (& a bank)
    class PositionTiedEffectBase < EffectBase
      # Get the bank of the effect
      # @return [Integer]
      attr_reader :bank
      # Get the position of the effect
      # @return [Integer]
      attr_reader :position
      # Create a new position tied effect
      # @param logic [Battle::Logic] logic used to get all the handler in order to allow the effect to work
      # @param bank [Integer] bank where the effect is tied
      # @param position [Integer] position where the effect is tied
      def initialize(logic, bank, position)
      end
      private
      # Function that helps to get the pokemon related to the effect
      def affected_pokemon
      end
    end
  end
end
