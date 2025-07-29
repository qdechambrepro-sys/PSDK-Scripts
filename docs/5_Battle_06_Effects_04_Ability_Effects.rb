module Battle
  module Effects
    class Ability < EffectBase
      # Get the db_symbol of the ability
      # @return [Symbol]
      attr_reader :db_symbol
      # Get the target of the effect
      # @return [PFM::PokemonBattler]
      attr_reader :target
      # Detect if the ability affects allies
      # @return [Boolean]
      attr_reader :affect_allies
      @registered_abilities = {}
      # Create a new ability effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param db_symbol [Symbol] db_symbol of the ability
      def initialize(logic, target, db_symbol)
      end
      class << self
        # Register a new ability
        # @param db_symbol [Symbol] db_symbol of the ability
        # @param klass [Class<Ability>] class of the ability effect
        def register(db_symbol, klass)
        end
        # Create a new Ability effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        # @return [Ability]
        def new(logic, target, db_symbol)
        end
      end
      class BoostingMoveType < Ability
        # Initial condition to give the power increase
        POWER_INCREASE_CONDITION = Hash.new(proc {true })
        # Type condition to give the power increase
        TYPE_CONDITION = Hash.new(:normal)
        # Power increase if all condition are met
        POWER_INCREASE = Hash.new(1.5)
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
        class << self
          # Register a BoostingMoveType ability
          # @param db_symbol [Symbol] db_symbol of the ability
          # @param type [Symbol] move type getting power increase
          # @param multiplier [Float] multiplier if all condition are meet
          # @param block [Proc] additional condition
          # @yieldparam user [PFM::PokemonBattler]
          # @yieldparam target [PFM::PokemonBattler]
          # @yieldparam move [Battle::Move]
          # @yieldreturn [Boolean]
          def register(db_symbol, type, multiplier = nil, &block)
          end
        end
        register(:blaze, :fire) { |user| user.hp_rate <= 0.333 }
        register(:overgrow, :grass) { |user| user.hp_rate <= 0.333 }
        register(:torrent, :water) { |user| user.hp_rate <= 0.333 }
        register(:swarm, :bug) { |user| user.hp_rate <= 0.333 }
        register(:dragon_s_maw, :dragon)
        register(:steelworker, :steel)
        register(:transistor, :electric)
        register(:rocky_payload, :rock)
      end
      class ElectricSurge < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        private
        # Tell which fieldterrain will be set
        # @return [Symbol]
        def terrain_type
        end
      end
      register(:electric_surge, ElectricSurge)
      class GrassySurge < ElectricSurge
        private
        # Tell which fieldterrain will be set
        # @return [Symbol]
        def terrain_type
        end
      end
      register(:grassy_surge, GrassySurge)
      class MistySurge < ElectricSurge
        private
        # Tell which fieldterrain will be set
        # @return [Symbol]
        def terrain_type
        end
      end
      register(:misty_surge, MistySurge)
      class PsychicSurge < ElectricSurge
        private
        # Tell which fieldterrain will be set
        # @return [Symbol]
        def terrain_type
        end
      end
      register(:psychic_surge, PsychicSurge)
      # Base class for an ability that prevents and cures a non-volatile status condition on the Creature.
      class NonVolatileStatusImmunityBase < Ability
        # Function called when a Creature has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Creature that is switched out
        # @param with [PFM::PokemonBattler] Creature that is switched in
        def on_switch_event(handler, who, with)
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
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
        # Checks if the Creature has a non-volatile status condition this ability can cure
        # @param target [PFM::PokemonBattler]
        # @return [Boolean]
        def curable_status?(target)
        end
      end
      class Immunity < NonVolatileStatusImmunityBase
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
      end
      class Insomnia < NonVolatileStatusImmunityBase
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
      end
      class Limber < NonVolatileStatusImmunityBase
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
      end
      class MagmaArmor < NonVolatileStatusImmunityBase
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
      end
      class WaterVeil < NonVolatileStatusImmunityBase
        private
        # Non-volatile status conditions that should be prevented or cured
        # @return [Array<Symbol>] :poison, :toxic, :sleep, :freeze, :paralysis, :burn
        def status_to_kill
        end
        # ID of the text in the file to use for the status prevention message
        # @return [Integer]
        def text_id
        end
      end
      register(:immunity, Immunity)
      register(:insomnia, Insomnia)
      register(:vital_spirit, Insomnia)
      register(:limber, Limber)
      register(:magma_armor, MagmaArmor)
      register(:water_veil, WaterVeil)
      class ShadowTag < Ability
        # Function called when testing if pokemon can switch (when he couldn't passthrough)
        # @param handler [Battle::Logic::SwitchHandler]
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @param reason [Symbol] the reason why the SwitchHandler is called
        # @return [:prevent, nil] if :prevent, can_switch? will return false
        def on_switch_prevention(handler, pokemon, skill, reason)
        end
        private
        # Additional check that prevent effect
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @return [Boolean]
        def effect_prevented?(pokemon, skill)
        end
      end
      register(:shadow_tag, ShadowTag)
      class MagnetPull < ShadowTag
        private
        # Additional check that prevent effect
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @return [Boolean]
        def effect_prevented?(pokemon, skill)
        end
      end
      register(:magnet_pull, MagnetPull)
      class SuctionCups < ShadowTag
        private
        # Additional check that prevent effect
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @return [Boolean]
        # @note I think this ability is not designed to be implemented like this, it should kill the passthrough
        # @todo fix this ability
        def effect_prevented?(pokemon, skill)
        end
      end
      register(:suction_cups, SuctionCups)
      class ArenaTrap < ShadowTag
        private
        # Additional check that prevent effect
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @return [Boolean]
        def effect_prevented?(pokemon, skill)
        end
      end
      register(:arena_trap, ArenaTrap)
      class SuperEffectivePowerReduction < Ability
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:solid_rock, SuperEffectivePowerReduction)
      register(:filter, SuperEffectivePowerReduction)
      register(:prism_armor, SuperEffectivePowerReduction)
      class Drizzle < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        private
        # Tell the weather to set
        # @return [Symbol]
        def weather
        end
        # Tell which item increase the turn count
        # @return [Symbol]
        def item_db_symbol
        end
        # Tell which animation to play
        # @return [Integer]
        def animation_id
        end
      end
      register(:drizzle, Drizzle)
      class Drought < Drizzle
        private
        # Tell the weather to set
        # @return [Symbol]
        def weather
        end
        # Tell which item increase the turn count
        # @return [Symbol]
        def item_db_symbol
        end
        # Tell which animation to play
        # @return [Integer]
        def animation_id
        end
      end
      register(:drought, Drought)
      class SandStream < Drizzle
        private
        # Tell the weather to set
        # @return [Symbol]
        def weather
        end
        # Tell which item increase the turn count
        # @return [Symbol]
        def item_db_symbol
        end
        # Tell which animation to play
        # @return [Integer]
        def animation_id
        end
      end
      register(:sand_stream, SandStream)
      class SnowWarning < Drizzle
        private
        # Tell the weather to set
        # @return [Symbol]
        def weather
        end
        # Tell which item increase the turn count
        # @return [Symbol]
        def item_db_symbol
        end
        # Tell which animation to play
        # @return [Integer]
        def animation_id
        end
      end
      register(:snow_warning, SnowWarning)
      class ChangingMoveType < BoostingMoveType
        # List of type overwrite
        TYPES_OVERWRITES = Hash.new(:normal)
        # Function called when we try to get the definitive type of a move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @param type [Integer] current type of the move (potentially after effects)
        # @return [Integer, nil] new type of the move
        def on_move_type_change(user, target, move, type)
        end
        class << self
          # Register a ChangingMoveType ability
          # @param db_symbol [Symbol] db_symbol of the ability
          # @param type_overwrite [Symbol] move type overwrite for weather_ball
          # @param multiplier [Float] multiplier if all condition are meet
          # @param block [Proc] additional condition
          # @yieldparam user [PFM::PokemonBattler]
          # @yieldparam target [PFM::PokemonBattler]
          # @yieldparam move [Battle::Move]
          # @yieldreturn [Boolean]
          def register(db_symbol, type_overwrite, multiplier = 1.3, &block)
          end
        end
        register(:pixilate, :fairy)
        register(:refrigerate, :ice)
        register(:aerilate, :flying)
        register(:galvanize, :electric)
      end
      class Aftermath < Ability
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
      end
      register(:aftermath, Aftermath)
      class AirLock < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called when a weather_prevention is checked
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_weather_prevention(handler, weather_type, last_weather)
        end
      end
      register(:air_lock, AirLock)
      register(:cloud_nine, AirLock)
      class Analytic < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:analytic, Analytic)
      class AngerPoint < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:anger_point, AngerPoint)
      class AngerShell < Ability
        # Stats affected by ability activation
        STATS = {atk: 1, ats: 1, spd: 1, dfe: -1, dfs: -1}
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:anger_shell, AngerShell)
      class Anticipation < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:anticipation, Anticipation)
      class ApplyStatusToMoveTarget < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Check if conditions to apply status are valid
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def status_appliable?(handler, hp, launcher, target, skill)
        end
        # Return the status to apply
        # @return [Symbol]
        def status
        end
        # Get the message text
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [String, nil]
        def display_message(handler, hp, target, launcher, skill)
        end
        # Number between 0 & 1 telling how much chance we have
        # @return [Float]
        def rate
        end
      end
      class PoisonTouch < ApplyStatusToMoveTarget
        # Check if conditions to apply status are valid
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def status_appliable?(handler, _, launcher, target, skill)
        end
        # Return the status to apply
        # @return [Symbol]
        def status
        end
        # Get the message text
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [String, nil]
        def display_message(handler, _, target, _, _)
        end
      end
      class ToxicChain < ApplyStatusToMoveTarget
        # Check if conditions to apply status are valid
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def status_appliable?(handler, _, _, target, skill)
        end
        # Return the status to apply
        # @return [Symbol]
        def status
        end
      end
      register(:poison_touch, PoisonTouch)
      register(:toxic_chain, ToxicChain)
      class ArmorTail < Ability
        # Create a new Armor Tail effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
      end
      register(:armor_tail, ArmorTail)
      class Auras < Ability
        # List of messages shown when entering the field
        AURA_MESSAGES = {fairy_aura: 1205, dark_aura: 1201, aura_break: 1231}
        # Create a new PowerSpot effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:fairy_aura, Auras)
      register(:dark_aura, Auras)
      register(:aura_break, Auras)
      class BadDreams < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:bad_dreams, BadDreams)
      class BallFetch < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        private
        # Function that check if we can pick up Pokeball
        # @param logic [Battle::Logic] logic of the battle
        # @return [Boolean]
        def pick_up_possible?(logic)
        end
      end
      register(:ball_fetch, BallFetch)
      class Battery < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
        end
      end
      register(:battery, Battery)
      class BattleBond < Ability
        # New version of the Greninja ability (9G+)
        BATTLE_BOND_GEN_NINE = false
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        private
        # @type [Array<Symbol>]
        STATS_TO_INCREASE = %i[atk ats spd]
        # Function handling the new ability effect since 9G
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def new_ability_effect(handler, hp, target, launcher, skill)
        end
        # Function to manage form after knocking out a pokemon
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def form_calibrate(handler, hp, target, launcher, skill)
        end
        # Function to restore the original form after being knocked out
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def revert_original_form(handler, hp, target, launcher, skill)
        end
      end
      register(:battle_bond, BattleBond)
      class BeastBoost < Ability
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        private
        # @param spd [Integer] Return the current spd
        # @param dfs [Integer] Return the current dfs
        # @param ats [Integer] Return the current ats
        # @param dfe [Integer] Return the current dfe
        # @param atk [Integer] Return the current atk
        def boosted_stat(spd, dfs, ats, dfe, atk)
        end
      end
      register(:beast_boost, BeastBoost)
      class Berserk < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:berserk, Berserk)
      class BigPecks < Ability
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
      register(:big_pecks, BigPecks)
      class Bulletproof < Ability
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
      end
      register(:bulletproof, Bulletproof)
      class Chlorophyll < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:chlorophyll, Chlorophyll)
      class ClearBody < Ability
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
      register(:clear_body, ClearBody)
      class ColorChange < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:color_change, ColorChange)
      class Comatose < Ability
        STATUS = %i[toxic poison burn paralysis freeze sleep]
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:comatose, Comatose)
      class Commander < Ability
        COMMANDERS = {tatsugiri: {stats: {atk: 2, dfe: 2, ats: 2, dfs: 2, spd: 2}, ally: :dondozo}}
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:commander, Commander)
      class CompoundEyes < Ability
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:compound_eyes, CompoundEyes)
      class Contrary < Ability
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
        # Name of the effect
        # @return [Symbol]
        def name
        end
      end
      register(:contrary, Contrary)
      class Costar < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:costar, Costar)
      class CottonDown < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        private
        # Handle the mirror armor effect (special case)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @return [PFM::PokemonBattler, nil]
        def handle_mirror_armor_effect(launcher, target)
        end
      end
      register(:cotton_down, CottonDown)
      class CudChew < Ability
        # Function called when a pre_item_change is checked
        # @param handler [Battle::Logic::ItemChangeHandler]
        # @param db_symbol [Symbol] Symbol ID of the item
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the item change cannot be applied
        def on_pre_item_change(handler, db_symbol, target, launcher, skill)
        end
        # Return the turn countdown before the effect proc (including the current one)
        # @return [Integer]
        def turn_count
        end
      end
      register(:cud_chew, CudChew)
      class CuriousMedicine < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:curious_medicine, CuriousMedicine)
      class CursedBody < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:cursed_body, CursedBody)
      class CuteCharm < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:cute_charm, CuteCharm)
      class Dancer < Ability
        # If the talent is activated or not
        # @return [Boolean]
        attr_writer :activated
        # Create a new Dancer effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Return the specific proceed_internal if the condition is fulfilled
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        def specific_proceed_internal(user, targets, move)
        end
        # If Dancer is currently activated
        # @return [Boolean]
        def activated?
        end
        alias activated activated?
      end
      register(:dancer, Dancer)
      class DauntlessShield < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:dauntless_shield, DauntlessShield)
      class Defeatist < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:defeatist, Defeatist)
      class Defiant < Ability
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
        # Stat changed by the ability
        # @return [symbol] of the stat
        def stat_changed
        end
      end
      class Competitive < Defiant
        # Stat changed by the ability
        # @return [symbol] of the stat
        def stat_changed
        end
      end
      register(:defiant, Defiant)
      register(:competitive, Competitive)
      class Disguise < Ability
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, _hp, target, launcher, skill)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        private
        # Recovers its original types
        # @param target [PFM::PokemonBattler]
        def reset_types(target)
        end
      end
      register(:disguise, Disguise)
      class Download < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:download, Download)
      class DrySkin < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
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
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:dry_skin, DrySkin)
      class EffectSpore < Ability
        # @return [Hash{Symbol => Symbol}]
        CAN_BE_METHODS = {poison: :can_be_poisoned?, sleep: :can_be_asleep?, paralysis: :can_be_paralyzed?}
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:effect_spore, EffectSpore)
      class Electromorphosis < Ability
        # Create a new Electromorphosis effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
        end
      end
      register(:electromorphosis, Electromorphosis)
      class EmbodyAspect < Ability
        # Returns the stat boosted by the ability and the corresponding text.
        # @return [Array<Hash<Symbol, Integer>>]
        FORMS_DATA = {hearthflame_mask: {stat: :atk, text: 1734}, wellspring_mask: {stat: :dfs, text: 1742}, cornerstone_mask: {stat: :dfe, text: 1738}}
        FORMS_DATA.default = {stat: :spd, text: 1730}
        # Teal (Grass)
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:embody_aspect, EmbodyAspect)
      class EmergencyExit < Ability
        # Create a new Emergency Exit effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Check if a move will prevents the ability from triggering
        # @param hp [Integer] number of hp (damage) dealt
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def skill_prevention?(hp, skill)
        end
        # Check if an item effect prevents the ability from triggering
        # @param target [PFM::PokemonBattler]
        # @return [Boolean]
        def item_prevention?(target)
        end
      end
      register(:emergency_exit, EmergencyExit)
      register(:wimp_out, EmergencyExit)
      class FlameBody < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:flame_body, FlameBody)
      class FlareBoost < Ability
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
        end
      end
      register(:flare_boost, FlareBoost)
      class FlashFire < Ability
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
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
        # Function called when a stat_increase_prevention is checked
        # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
        # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the stat increase cannot apply
        def on_stat_increase_prevention(handler, stat, target, launcher, skill)
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
        # Give the move mod1 mutiplier (before the +2 in the formula)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod1_multiplier(user, target, move)
        end
        # Reset the boost when leaving battle
        def reset
        end
      end
      register(:flash_fire, FlashFire)
      class FlowerGift < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a creature has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Creature that is switched out
        # @param with [PFM::PokemonBattler] Creature that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the weather was changed (on_post_weather_change)
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        def on_post_weather_change(handler, weather_type, last_weather)
        end
        # Function called when a pre_ability_change is checked
        # @param handler [Battle::Logic::AbilityChangeHandler]
        # @param _db_symbol [Symbol] Symbol ID of the ability to give
        # @param target [PFM::PokemonBattler]
        # @param _launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param _skill [Battle::Move, nil] Potential move used
        def on_pre_ability_change(handler, _db_symbol, target, _launcher, _skill)
        end
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
        # Give the dfs modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfs_modifier
        end
        private
        # Change the target to its appropriate form according to the weather
        # @param handler [Battle::Logic::ChangeHandlerBase]
        # @param target [PFM::PokemonBattler]
        def handle_weather_form(handler, target)
        end
        # Handle the target's form change
        # @param handler [Battle::Logic::ChangeHandlerBase]
        # @param target [PFM::PokemonBattler]
        # @param reason [Symbol] which form
        # @param show_ability [Boolean] whether to display the target's ability
        def handle_form(handler, target, reason, show_ability: true)
        end
        # Symbol for Cherrim's Sunshine Form
        # @return [Symbol]
        def sunshine
        end
        # Symbol for Cherrim's Overcast Form
        # @return [Symbol]
        def overcast
        end
      end
      register(:flower_gift, FlowerGift)
      class FlowerVeil < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:flower_veil, FlowerVeil)
      class Fluffy < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:fluffy, Fluffy)
      class Forecast < Ability
        # @return [Array<Symbol>]
        WEATHERS = %i[rain hardrain sunny hardsun hail snow]
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the weather was changed (on_post_weather_change)
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        def on_post_weather_change(handler, weather_type, last_weather)
        end
        # Function called when a pre_ability_change is checked
        # @param handler [Battle::Logic::AbilityChangeHandler]
        # @param _db_symbol [Symbol] Symbol ID of the ability to give
        # @param target [PFM::PokemonBattler]
        # @param _launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param _skill [Battle::Move, nil] Potential move used
        def on_pre_ability_change(handler, _db_symbol, target, _launcher, _skill)
        end
        private
        # Handle the right change of form in relation to the weather
        # @param handler [Battle::Logic::SwitchHandler]
        # @param battler [PFM::PokemonBattler]
        def handle_weather_form(handler, battler)
        end
        # Handle the change of form
        # @param handler [Battle::Logic::SwitchHandler]
        # @param battler [PFM::PokemonBattler]
        # @param form_number [Integer]
        # @param reason [Symbol]
        # @param show_ability [Boolean]
        def handle_form(handler, battler, form_number, reason, show_ability: true)
        end
      end
      register(:forecast, Forecast)
      class Forewarn < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:forewarn, Forewarn)
      class FriendGuard < Ability
        # Create a new FriendGuard effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:friend_guard, FriendGuard)
      class Frisk < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:frisk, Frisk)
      class FullMetalBody < Ability
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
      register(:full_metal_body, FullMetalBody)
      class FurCoat < Ability
        # Give the dfe modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfe_modifier
        end
      end
      register(:fur_coat, FurCoat)
      class GaleWings < Ability
        # Function called when we try to check if the effect changes the definitive priority of the move
        # @param user [PFM::PokemonBattler]
        # @param priority [Integer]
        # @param move [Battle::Move]
        # @return [Proc, nil]
        def on_move_priority_change(user, priority, move)
        end
      end
      register(:gale_wings, GaleWings)
      class GoodAsGold < Ability
        # Returns a list of moves that fail when targeting Good as Gold
        # @return [Array<Symbol>]
        MOVES_AFFECTED = %i[memento curse strength_sap]
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
      end
      register(:good_as_gold, GoodAsGold)
      class Gooey < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        private
        # Handle the mirror armor effect (special case)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @return [PFM::PokemonBattler, nil]
        def handle_mirror_armor_effect(launcher, target)
        end
      end
      register(:gooey, Gooey)
      register(:tangling_hair, Gooey)
      class GorillaTactics < Ability
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
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
        private
        # Checks if the user can use the move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_be_used?(user, move)
        end
      end
      register(:gorilla_tactics, GorillaTactics)
      class GrassPelt < Ability
        # Give the dfe modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfe_modifier
        end
      end
      register(:grass_pelt, GrassPelt)
      class GuardDog < Ability
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
        # Name of the effect
        # @return [Symbol]
        def name
        end
      end
      register(:guard_dog, GuardDog)
      class GulpMissile < Ability
        FORM_ARROKUDA = :arrokuda
        FORM_PIKACHU = :pikachu
        BASE_FORM = :base
        TRIGGER_SKILLS = %i[surf waterfall]
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        private
        # Catch a different prey according to the current HP
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def catch_prey(handler, hp, target, launcher, skill)
        end
        # Spit out the prey, causing damage and additional effects depending on the form
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def spit_out_prey(handler, hp, target, launcher, skill)
        end
        # Handle the mirror armor effect (special case)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @return [PFM::PokemonBattler, nil]
        def handle_mirror_armor_effect(launcher, target)
        end
      end
      register(:gulp_missile, GulpMissile)
      class Guts < Ability
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
      end
      register(:guts, Guts)
      class HadronEngine < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Give the ats modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def ats_modifier
        end
      end
      register(:hadron_engine, HadronEngine)
      class Harvest < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:harvest, Harvest)
      # At the end of each turn, Healer has a 30% chance of curing an adjacent ally's status condition.
      # @see https://pokemondb.net/ability/healer
      # @see https://bulbapedia.bulbagarden.net/wiki/Healer_(Ability)
      # @see https://www.pokepedia.fr/Cœur_Soin
      class Healer < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:healer, Healer)
      class Heatproof < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:heatproof, Heatproof)
      class Hospitality < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:hospitality, Hospitality)
      class HungerSwitch < Ability
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
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
      end
      register(:hunger_switch, HungerSwitch)
      class Hustle < Ability
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:hustle, Hustle)
      class Hydration < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:hydration, Hydration)
      class HyperCutter < Ability
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
      register(:hyper_cutter, HyperCutter)
      class IceBody < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:ice_body, IceBody)
      class IceFace < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
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
        # Function called after the weather was changed (on_post_weather_change)
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        def on_post_weather_change(handler, weather_type, last_weather)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
      end
      register(:ice_face, IceFace)
      class IceScales < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:ice_scales, IceScales)
      class Imposter < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Return the text's CSV ids
        # @return [Array<Integer>]
        def message_id
        end
      end
      register(:imposter, Imposter)
      # Defines the Innards Out ability
      class InnardsOut < Ability
        # Create a new ability effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
      end
      register(:innards_out, InnardsOut)
      class InnerFocus < Ability
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:inner_focus, InnerFocus)
      class Intimidate < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # @return [Boolean] if the ability is currently activated
        def activated?
        end
      end
      register(:intimidate, Intimidate)
      class IntrepidSword < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:intrepid_sword, IntrepidSword)
      class IronFist < Ability
        # Get the base power multiplier of this ability
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:iron_fist, IronFist)
      class Justified < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:justified, Justified)
      class KeenEye < Ability
        # Function called when a stat_decrease_prevention is checked
        # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
        # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the stat decrease cannot apply
        def on_stat_decrease_prevention(handler, stat, target, launcher, skill)
        end
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:keen_eye, KeenEye)
      register(:mind_s_eye, KeenEye)
      class LeafGuard < Ability
        # List of messages when leaf guard is active
        STATUS_LEAF_GUARD_MSG = {poison: 252, toxic: 252, sleep: 318, freeze: 300, paralysis: 285, burn: 270}
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:leaf_guard, LeafGuard)
      class Libero < Ability
        NO_ACTIVATION_MOVES = %i[s_struggle s_metronome s_me_first s_assist s_mirror_move s_nature_power s_sleep_talk]
        # Function called before the accuracy check of a move is done
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param targets [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_pre_accuracy_check(logic, scene, targets, launcher, skill)
        end
      end
      register(:libero, Libero)
      register(:protean, Libero)
      class LightningRod < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
        private
        # Check the type of the move
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def move_check?(move)
        end
      end
      register(:lightning_rod, LightningRod)
      class StormDrain < LightningRod
        private
        # Check the type of the move
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def move_check?(move)
        end
      end
      register(:storm_drain, StormDrain)
      class LiquidOoze < Ability
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
      end
      register(:liquid_ooze, LiquidOoze)
      class LiquidVoice < Ability
        # Function called when we try to get the definitive type of a move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @param type [Integer] current type of the move (potentially after effects)
        # @return [Integer, nil] new type of the move
        def on_move_type_change(user, target, move, type)
        end
      end
      register(:liquid_voice, LiquidVoice)
      class MarvelScale < Ability
        # Give the dfe modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfe_modifier
        end
      end
      register(:marvel_scale, MarvelScale)
      class MegaLauncher < Ability
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:mega_launcher, MegaLauncher)
      class MentalImmunityBase < Ability
        # List of mental effects
        # @return [Array<Symbol>]
        MENTAL_EFFECTS = %i[attract encore taunt torment heal_block disable]
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
      end
      class Oblivious < MentalImmunityBase
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
      end
      class AromaVeil < MentalImmunityBase
        # Create a Aroma Veil effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
      end
      register(:oblivious, Oblivious)
      register(:aroma_veil, AromaVeil)
      class Mimicry < Ability
        # Types based on terrains
        TYPES = {psychic_terrain: :psychic, misty_terrain: :fairy, grassy_terrain: :grass, electric_terrain: :electric}
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the terrain was changed
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        def on_post_fterrain_change(handler, fterrain_type, last_fterrain)
        end
        private
        # Function for changing to a new type due to an active terrain
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        # @param target [PFM::PokemonBattler]
        # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        def change_on_active_terrain(handler, target, fterrain_type)
        end
        # Message text for changing to a new type.
        # @param target [PFM::PokemonBattler]
        # @param new_type [Integer] ID of the new type
        # @return [String]
        def changed_type_message(target, new_type)
        end
        # Message text for reverting to the original type.
        # @param target [PFM::PokemonBattler]
        # @return [String]
        def original_type_message(target)
        end
      end
      register(:mimicry, Mimicry)
      class MirrorArmor < Ability
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
      end
      register(:mirror_armor, MirrorArmor)
      class MoldBreaker < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        private
        # ID of the text file for the on-switch message.
        # @return [Integer]
        def file_id
        end
        # ID of the text in the file for the on-switch message.
        # @return [Integer]
        def text_id
        end
      end
      class Teravolt < MoldBreaker
        def text_id
        end
      end
      class Turboblaze < MoldBreaker
        def text_id
        end
      end
      register(:mold_breaker, MoldBreaker)
      register(:teravolt, Teravolt)
      register(:turboblaze, Turboblaze)
      class Moody < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:moody, Moody)
      class MotorDrive < Ability
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
        end
      end
      register(:motor_drive, MotorDrive)
      class Moxie < Ability
        # Create a new Moxie effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        # The stat that will be boosted
        def boosted_stat
        end
      end
      class GrimNeigh < Moxie
        # The stat that will be boosted
        def boosted_stat
        end
      end
      register(:moxie, Moxie)
      register(:chilling_neigh, Moxie)
      register(:grim_neigh, GrimNeigh)
      class Multiscale < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:multiscale, Multiscale)
      register(:shadow_shield, Multiscale)
      # Class managing Mummy ability
      class Mummy < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        alias on_post_damage_death on_post_damage
        # Get the post ability change message
        # @param receiver [PFM::PokemonBattler] Ability receiver
        # @param giver [PFM::PokemonBattler] Potential ability giver
        # @return [String]
        def post_ability_change_message(receiver, giver)
        end
      end
      # Class managing Lingering Aroma ability
      class LingeringAroma < Mummy
        # Get the post ability change message
        # @param receiver [PFM::PokemonBattler] Ability receiver
        # @param giver [PFM::PokemonBattler] Potential ability giver
        # @return [String]
        def post_ability_change_message(receiver, giver)
        end
      end
      register(:mummy, Mummy)
      register(:lingering_aroma, LingeringAroma)
      class NaturalCure < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:natural_cure, NaturalCure)
      class Neuroforce < Ability
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:neuroforce, Neuroforce)
      class NeutralizingGas < Ability
        # Create a new Neutralizing Gas effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # If Neutralizing Gas is currently activated by this pokemon
        # @return [Boolean]
        def activated?
        end
        alias activated activated?
        private
        # Suppress the ability of each battlers except the user if the conditions are fullfilled
        # @param handler [Battle::Logic::SwitchHandler]
        def suppress_abilities(handler, who, with)
        end
        # Retrieve the ability of each battlers except the user if the conditions are fullfilled
        # @param handler [Battle::Logic::SwitchHandler]
        def retrieve_abilities(handler, who, with)
        end
      end
      register(:neutralizing_gas, NeutralizingGas)
      class Normalize < Ability
        # Function called when we try to get the definitive type of a move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @param type [Integer] current type of the move (potentially after effects)
        # @return [Integer, nil] new type of the move
        def on_move_type_change(user, target, move, type)
        end
      end
      register(:normalize, Normalize)
      class Opportunist < Ability
        COPIED_EFFECTS = {focus_energy: {effect_class: Effects::FocusEnergy, text_id: 1047}, dragon_cheer: {effect_class: Effects::DragonCheer, text_id: 1047}}
        # Create a new Opportunist effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # @return [Boolean] if the ability is currently activated
        def activated?
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
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
      end
      register(:opportunist, Opportunist)
      class OrichalcumPulse < Drought
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
      end
      register(:orichalcum_pulse, OrichalcumPulse)
      # A Pokémon with Overcoat does not take damage from the weather conditions sandstorm and hailstorm.
      # Also protects from powder and spore moves, as well as Effect Spore.
      # @see https://pokemondb.net/ability/overcoat
      # @see https://bulbapedia.bulbagarden.net/wiki/Overcoat_(Ability)
      # @see https://www.pokepedia.fr/Envelocape
      class Overcoat < Ability
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
      end
      register(:overcoat, Overcoat)
      class OwnTempo < Ability
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:own_tempo, OwnTempo)
      class ParentalBond < Ability
        # Constant telling the be_method of the moves not affected by Parental Bond
        # @return [Array<Symbol>]
        ONLY_ONE_ATTACK = %i[s_solar_beam s_2turns s_endeavor s_ohko s_fling s_explosion s_final_gambit s_uproar s_rollout s_ice_ball s_relic_sound s_electro_shot]
        # Constant telling which be_method can activate their effect on the second attack only
        # @return [Array<Symbol>]
        ONLY_ON_SECOND_ATTACK = %i[s_secret_power s_u_turn s_thief s_pluck s_smelling_salt s_wakeup_slap s_knock_off s_scald s_smack_down s_burn_up s_bind s_fury_cutter s_split_up s_reload s_outrage s_present s_pledge]
        # If the talent is activated or not
        # @return [Boolean]
        attr_writer :activated
        # Returns the amount of damage the launcher must take from the recoil
        # @return [Integer]
        attr_accessor :first_turn_recoil
        # Which attack number are we currently on this turn?
        # @return [Integer]
        attr_accessor :attack_number
        # Create a new Parental Bond effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        def activated?
        end
        alias activated activated?
        # Return the specific proceed_internal if the condition is fulfilled
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        def specific_proceed_internal(user, targets, move)
        end
        # Get the name of the effect
        # @return [Symbol]
        def name
        end
        # Returns the number of attack this Ability causes
        # @return [Integer]
        def number_of_attacks
        end
        # Check if the actual move can activate its have his effect activated
        # @return [Boolean]
        def first_effect_can_be_applied?(be_method)
        end
        # Check if the actual move need the initial procedure (Parental Bond not working on it)
        # @return [Boolean]
        def excluded?(be_method)
        end
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:parental_bond, ParentalBond)
      class PastelVeil < Ability
        # Poison status
        POISON = %i[poison toxic]
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:pastel_veil, PastelVeil)
      class PerishBody < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Return the effect of the ability
        # @param target [PFM::PokemonBattler] target that will be affected by the effect
        # @return [Effects::EffectBase]
        def effect(target)
        end
      end
      register(:perish_body, PerishBody)
      class Pickpocket < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function returning the file number and the line id of the text
        # @return [Array<Integer>]
        def steal_text
        end
      end
      register(:pickpocket, Pickpocket)
      class Magician < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function returning the file number and the line id of the text
        # @return [Array<Integer>]
        def steal_text
        end
      end
      register(:magician, Magician)
      class Plus < Ability
        # Give the ats modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def ats_modifier
        end
      end
      register(:plus, Plus)
      register(:minus, Plus)
      class PoisonPoint < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:poison_point, PoisonPoint)
      class PoisonPuppeteer < Ability
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
      end
      register(:poison_puppeteer, PoisonPuppeteer)
      class PowerConstruct < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
      end
      register(:power_construct, PowerConstruct)
      # Class managing Power of Alchemy / Receiver abilities
      class PowerOfAlchemy < Ability
        # Create a new PowerOfAlchemy effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        # Get the post ability change message
        # @param receiver [PFM::PokemonBattler] Ability receiver
        # @param giver [PFM::PokemonBattler] Potential ability giver
        # @return [String]
        # @note The following error is for French only
        def post_ability_change_message(receiver, giver)
        end
      end
      register(:power_of_alchemy, PowerOfAlchemy)
      register(:receiver, PowerOfAlchemy)
      class PowerSpot < Ability
        # Create a new PowerSpot effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:power_spot, PowerSpot)
      class Prankster < Ability
        # Function called when we try to check if the effect changes the definitive priority of the move
        # @param user [PFM::PokemonBattler]
        # @param priority [Integer]
        # @param move [Battle::Move]
        # @return [Proc, nil]
        def on_move_priority_change(user, priority, move)
        end
      end
      register(:prankster, Prankster)
      class Pressure < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:pressure, Pressure)
      class DesolateLand < Ability
        # Liste des temps qui peuvent changer
        WEATHERS = %i[hardsun hardrain strong_winds]
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
        # Function called after the weather was changed (on_post_weather_change)
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        def on_post_weather_change(handler, weather_type, last_weather)
        end
        private
        # Weather concerned
        # @return [Symbol] weather symbol
        def env
        end
        # Weather setting ability
        # @return [Symbol] ability db_symbol
        def primal_weather_ability?(pokemon)
        end
        # Weather setup animation id
        # @return [Integer] id
        def anim
        end
        # Weather clear text line
        # @return [Integer] id
        def msg
        end
      end
      register(:desolate_land, DesolateLand)
      class PrimordialSea < DesolateLand
        private
        # Weather concerned
        # @return [db_symbol] weather
        def env
        end
        # Weather setting ability
        # @return [Symbol] ability db_symbol
        def primal_weather_ability?(pokemon)
        end
        # Weather setup animation id
        # @return [Integer] id
        def anim
        end
        # Weather clear text line
        # @return [Integer] id
        def msg
        end
      end
      register(:primordial_sea, PrimordialSea)
      class DeltaStream < DesolateLand
        private
        # Weather concerned
        # @return [db_symbol] weather
        def env
        end
        # Weather setting ability
        # @return [Symbol] ability db_symbol
        def primal_weather_ability?(pokemon)
        end
        # Weather setup animation id
        # @return [Integer] id
        def anim
        end
        # Weather clear text line
        # @return [Integer] id
        def msg
        end
      end
      register(:delta_stream, DeltaStream)
      class Protosynthesis < Ability
        # @return [Hash{ Symbol => Integer }] A hash mapping stats to their corresponding text IDs.
        TEXTS_IDS = {atk: 1702, dfe: 1706, ats: 1710, dfs: 1714, spd: 1718}
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the weather was changed (on_post_weather_change)
        # @param handler [Battle::Logic::WeatherChangeHandler]
        # @param weather_type [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        # @param last_weather [Symbol] :none, :rain, :sunny, :sandstorm, :hail, :fog
        def on_post_weather_change(handler, weather_type, last_weather)
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
        private
        # Plays pokemon ability effect
        # @param handler [Battle::Logic::SwitchHandler]
        # @param pokemon [PFM::PokemonBattler]
        # @param reason [Symbol] the reason of the proc
        def play_ability_effect(handler, pokemon, reason)
        end
        # Function called to increase the pokémon's highest stat
        # @return [Symbol] the highest stat
        def highest_stat_boosted
        end
      end
      register(:protosynthesis, Protosynthesis)
      class PunkRock < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:punk_rock, PunkRock)
      class PurePower < Ability
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
      end
      register(:pure_power, PurePower)
      register(:huge_power, PurePower)
      class PurifyingSalt < Ability
        # A constant mapping status effects to their respective message IDs
        # @return [Hash{Symbol => Array<Integer>}]
        STATUS_MESSAGES = {burn: [19, 270], freeze: [19, 300], paralysis: [19, 285], poison: [19, 252], sleep: [19, 318], toxic: [19, 252]}
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
        end
      end
      register(:purifying_salt, PurifyingSalt)
      class QuarkDrive < Ability
        # @return [Hash{ Symbol => Integer }] A hash mapping stats to their corresponding text IDs.
        TEXTS_IDS = {atk: 1702, dfe: 1706, ats: 1710, dfs: 1714, spd: 1718}
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the terrain was changed
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        def on_post_fterrain_change(handler, fterrain_type, last_fterrain)
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
        private
        # Plays pokemon ability effect
        # @param handler [Battle::Logic::SwitchHandler]
        # @param pokemon [PFM::PokemonBattler]
        # @param reason [Symbol] the reason of the proc
        def play_ability_effect(handler, pokemon, reason)
        end
        # Function called to increase the pokemon's highest stat
        # @return [Symbol] the highest stat
        def highest_stat_boosted
        end
      end
      register(:quark_drive, QuarkDrive)
      class QueenlyMajesty < Ability
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
      end
      register(:queenly_majesty, QueenlyMajesty)
      register(:dazzling, QueenlyMajesty)
      class QuickFeet < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:quick_feet, QuickFeet)
      class RainDish < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:rain_dish, RainDish)
      class Rattled < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
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
      end
      register(:rattled, Rattled)
      class Reckless < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:reckless, Reckless)
      class Regenerator < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:regenerator, Regenerator)
      class Ripen < Ability
        # Function called when a pre_item_change is checked
        # @param handler [Battle::Logic::ItemChangeHandler]
        # @param db_symbol [Symbol] Symbol ID of the item
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_pre_item_change(handler, db_symbol, target, launcher, skill)
        end
      end
      register(:ripen, Ripen)
      class Rivalry < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:rivalry, Rivalry)
      class RoughSkin < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        alias on_post_damage_death on_post_damage
      end
      register(:rough_skin, RoughSkin)
      register(:iron_barbs, RoughSkin)
      class SandForce < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:sand_force, SandForce)
      class SandRush < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:sand_rush, SandRush)
      class SandSpit < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:sand_spit, SandSpit)
      class SandVeil < Ability
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:sand_veil, SandVeil)
      class SapSipper < Ability
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
      end
      register(:sap_sipper, SapSipper)
      class ScreenCleaner < Ability
        WALLS = %i[light_screen reflect aurora_veil]
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called to suppr the reflect effect
        # @param bank [Integer] bank of the battlers
        def suppr_reflect(bank)
        end
      end
      register(:screen_cleaner, ScreenCleaner)
      class SeedSower < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:seed_sower, SeedSower)
      class SereneGrace < Ability
        # Give the effect chance modifier given to the Pokémon with this effect
        # @param move [Battle::Move::Basic] the move the chance modifier will be applied to
        # @return [Float, Integer] multiplier
        def effect_chance_modifier(move)
        end
      end
      register(:serene_grace, SereneGrace)
      class Sharpness < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:sharpness, Sharpness)
      class ShedSkin < Ability
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:shed_skin, ShedSkin)
      class SheerForce < Ability
        # If the ability is activated or not
        # @return [Boolean]
        attr_writer :activated
        # Create a new Sheer Force effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # If Sheer Force is currently activated
        # @return [Boolean]
        def activated?
        end
        alias activated activated?
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
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
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
        end
        # Get the name of the effect
        # @return [Symbol]
        def name
        end
        private
        # The status that can be boosted by Sheer Force
        # @return [Array<Symbol>]
        STATUS_DB_SYMBOL = %i[poison toxic sleep freeze paralysis burn flinch].freeze
        # Check if the move can be boosted by Sheer Force
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Boolean] true if the move can be boosted by Sheer Force, false otherwise
        def can_be_boosted?(user, target, move)
        end
      end
      register(:sheer_force, SheerForce)
      class ShieldDust < Ability
        # Function called when a stat_decrease_prevention is checked
        # @param handler [Battle::Logic::StatChangeHandler] handler use to test prevention
        # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the stat decrease cannot apply
        def on_stat_decrease_prevention(handler, stat, target, launcher, skill)
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
      end
      register(:shield_dust, ShieldDust)
      class Simple < Ability
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
      end
      register(:simple, Simple)
      class SlowStart < Ability
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
        end
        alias spd_modifier atk_modifier
      end
      register(:slow_start, SlowStart)
      class SlushRush < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:slush_rush, SlushRush)
      class SnowCloak < Ability
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:snow_cloak, SnowCloak)
      class SolarPower < Ability
        # Give the ats modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def ats_modifier
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:solar_power, SolarPower)
      class SoulHeart < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called after damages were applied and when target died (post_damage_death)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage_death(handler, hp, target, launcher, skill)
        end
      end
      register(:soul_heart, SoulHeart)
      class Soundproof < Ability
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
      end
      register(:soundproof, Soundproof)
      class SpeedBoost < Ability
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
      register(:speed_boost, SpeedBoost)
      class Stakeout < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:stakeout, Stakeout)
      class Stalwart < Ability
        # Check if the user of this ability ignore the center of attention in the enemy bank
        # @return [Boolean]
        def ignore_target_redirection?
        end
      end
      register(:stalwart, Stalwart)
      register(:propeller_tail, Stalwart)
      class Stamina < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:stamina, Stamina)
      # Stance Change allows Aegislash to switch between its Shield Forme and Blade Forme.
      # @see https://pokemondb.net/ability/stance-change
      # @see https://bulbapedia.bulbagarden.net/wiki/Stance_Change_(Ability)
      # @see https://www.pokepedia.fr/Déclic_Tactique
      class StanceChange < Ability
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        private
        # Apply Blade Form
        def blade
        end
        # Apply Shield Form
        def shield
        end
        # Apply change form
        # @param text_id [Integer] id of the message text
        def apply_change_form(text_id)
        end
      end
      register(:stance_change, StanceChange)
      class Static < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:static, Static)
      class Steadfast < Ability
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
      end
      register(:steadfast, Steadfast)
      class SteamEngine < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:steam_engine, SteamEngine)
      class SteelySpirit < Ability
        # Create a new SteelySpirit effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:steely_spirit, SteelySpirit)
      class Stench < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:stench, Stench)
      class StrongJaw < Ability
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:strong_jaw, StrongJaw)
      class Sturdy < Ability
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
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
      register(:sturdy, Sturdy)
      class SupersweetSyrup < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:supersweet_syrup, SupersweetSyrup)
      class SupremeOverlord < Ability
        # Create a new SupremeOverlord effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
        end
      end
      register(:supreme_overlord, SupremeOverlord)
      class SurgeSurfer < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:surge_surfer, SurgeSurfer)
      class SweetVeil < Ability
        # Create a new FlowerGift effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
      end
      register(:sweet_veil, SweetVeil)
      class SwiftSwim < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:swift_swim, SwiftSwim)
      class Symbiosis < Ability
        # List of moves that cause the talent to proceed after the target has taken damage
        DEFERRED_MOVES = %i[fling natural_gift]
        # List of methods that make the target invalid
        INVALID_BE_METHOD = %i[s_knock_off s_thief]
        # Create a new Symbiosis effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
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
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        private
        # Check if we can give our object to the target that just lost it
        # @param handler [Battle::Logic::DamageHandler]
        # @param ally [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def valid_target?(handler, ally, skill)
        end
        # Check if the object should be given after the target turn
        # @param ally [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def should_activate?(ally, skill)
        end
        # Method that gives the item
        # @param handler [Battle::Logic::DamageHandler]
        # @param ally [PFM::PokemonBattler]
        def transfer_item(handler, ally)
        end
      end
      register(:symbiosis, Symbiosis)
      class Synchronize < Ability
        # List of status Synchronize is applying
        SYNCHRONIZED_STATUS = %i[poison toxic paralysis burn]
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
      end
      register(:synchronize, Synchronize)
      class TabletsOfRuin < Ability
        # Create a new Tablets of Ruin effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function responsible for applying the effect
        # @param handler [Battle::Logic::SwitchHandler]
        # @param owner [PFM::PokemonBattler]
        def set_effect(handler, owner)
        end
        # Function responsible for removing the effect
        # @param handler [Battle::Logic::SwitchHandler]
        # @param owner [PFM::PokemonBattler]
        def remove_effect(handler, owner)
        end
        # If Tablets of Ruin is currently activated by this pokemon
        # @return [Boolean]
        def activated?
        end
        alias activated activated?
        # Class of the Effect given by this ability
        def effect_class
        end
        # Get the file ID
        # @return [Integer]
        def file_id
        end
        # Get the text ID
        # @return [Integer]
        def text_id
        end
      end
      class BeadsOfRuin < TabletsOfRuin
        # Class of the Effect given by this ability
        def effect_class
        end
        # Get the text ID
        # @return [Integer]
        def text_id
        end
      end
      class VesselOfRuin < TabletsOfRuin
        # Class of the Effect given by this ability
        def effect_class
        end
        # Get the text ID
        # @return [Integer]
        def text_id
        end
      end
      class SwordOfRuin < VesselOfRuin
        # Class of the Effect given by this ability
        def effect_class
        end
        # Get the text ID
        # @return [Integer]
        def text_id
        end
      end
      register(:tablets_of_ruin, TabletsOfRuin)
      register(:beads_of_ruin, BeadsOfRuin)
      register(:vessel_of_ruin, VesselOfRuin)
      register(:sword_of_ruin, SwordOfRuin)
      class TangledFeet < Ability
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:tangled_feet, TangledFeet)
      class Technician < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:technician, Technician)
      # A Pokemon with Telepathy avoids damaging moves used by its allies.
      # @see https://pokemondb.net/ability/telepathy
      # @see https://bulbapedia.bulbagarden.net/wiki/Telepathy_(Ability)
      class Telepathy < Ability
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
        end
      end
      register(:telepathy, Telepathy)
      class TeraShift < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:tera_shift, TeraShift)
      class TeraShell < Ability
        # Function that computes an overwrite of the type multiplier
        # @param target [PFM::PokemonBattler]
        # @param target_type [Integer] one of the type of the target
        # @param type [Integer] one of the type of the move
        # @param move [Battle::Move]
        # @return [Float, nil] overwriten type multiplier
        def on_single_type_multiplier_overwrite(target, target_type, type, move)
        end
      end
      register(:tera_shell, TeraShell)
      class TeraformZero < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:teraform_zero, TeraformZero)
      class ThermalExchange < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
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
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
      end
      register(:thermal_exchange, ThermalExchange)
      class ThickFat < Ability
        # List of types affected by thick fat
        THICK_FAT_TYPES = %i[fire ice]
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:thick_fat, ThickFat)
      class TintedLens < Ability
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:tinted_lens, TintedLens)
      class ToughClaws < Ability
        # Get the base power multiplier of this move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Float]
        def base_power_multiplier(user, target, move)
        end
      end
      register(:tough_claws, ToughClaws)
      class ToxicBoost < Ability
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
        end
      end
      register(:toxic_boost, ToxicBoost)
      class ToxicDebris < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:toxic_debris, ToxicDebris)
      # Class managing Trace ability
      class Trace < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Get the post ability change message
        # @param receiver [PFM::PokemonBattler] Ability receiver
        # @param giver [PFM::PokemonBattler] Potential ability giver
        # @return [String]
        def post_ability_change_message(receiver, giver)
        end
      end
      register(:trace, Trace)
      class Triage < Ability
        # Function called when we try to check if the effect changes the definitive priority of the move
        # @param user [PFM::PokemonBattler]
        # @param priority [Integer]
        # @param move [Battle::Move]
        # @return [Proc, nil]
        def on_move_priority_change(user, priority, move)
        end
      end
      register(:triage, Triage)
      class Truant < Ability
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
        end
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:truant, Truant)
      class VoltAbsorb < Ability
        # Function called when we try to check if the effect changes the definitive priority of the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_prevention_target(user, target, move)
        end
        # Function that checks the type of the move
        # @param move [Battle::Move]
        # @return [Boolean]
        def check_move_type?(move)
        end
        # Returns the factor used for healing
        # @return [Integer]
        def factor
        end
      end
      class WaterAbsorb < VoltAbsorb
        # Function that checks the type of the move
        # @param move [Battle::Move]
        # @return [Boolean]
        def check_move_type?(move)
        end
      end
      class EarthEater < VoltAbsorb
        # Function that checks the type of the move
        # @param move [Battle::Move]
        # @return [Boolean]
        def check_move_type?(move)
        end
      end
      register(:volt_absorb, VoltAbsorb)
      register(:water_absorb, WaterAbsorb)
      register(:earth_eater, EarthEater)
      class Unaware < Ability
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
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:unaware, Unaware)
      class Unburden < Ability
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
        # Function called when a post_item_change is checked
        # @param handler [Battle::Logic::ItemChangeHandler]
        # @param db_symbol [Symbol] Symbol ID of the item
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_item_change(handler, db_symbol, target, launcher, skill)
        end
        # Reset the boost when leaving battle
        def reset
        end
      end
      register(:unburden, Unburden)
      class Unnerve < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
      end
      register(:unnerve, Unnerve)
      class VictoryStar < Ability
        # Create a new VictoryStar effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the ability
        def initialize(logic, target, db_symbol)
        end
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:victory_star, VictoryStar)
      class WanderingSpirit < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        alias on_post_damage_death on_post_damage
      end
      register(:wandering_spirit, WanderingSpirit)
      class WaterBubble < Ability
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
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
      end
      register(:water_bubble, WaterBubble)
      class WaterCompaction < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:water_compaction, WaterCompaction)
      class WeakArmor < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:weak_armor, WeakArmor)
      class WellBakedBody < Ability
        # Function called when a damage_prevention is checked
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, Integer, nil] :prevent if the damage cannot be applied, Integer if the hp variable should be updated
        def on_damage_prevention(handler, hp, target, launcher, skill)
        end
      end
      register(:well_baked_body, WellBakedBody)
      class WhiteSmoke < Ability
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
      register(:white_smoke, WhiteSmoke)
      class WindPower < Ability
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
        # Create the effect
        # @param target [PFM::PokemonBattler] expected target
        # @return [Effects::EffectBase]
        def create_effect(target)
        end
      end
      register(:wind_power, WindPower)
      class WindRider < Ability
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_prevention_target(user, target, move)
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
        # Function grouping the actions related to Wind Rider's activation
        def trigger_effect
        end
      end
      register(:wind_rider, WindRider)
      class WonderGuard < Ability
        # Function called when we try to check if the Pokemon is immune to a move due to its effect
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def on_move_ability_immunity(user, target, move)
        end
        # Function called when we try to check if the move is blocked by Wonder Guard
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean] if the target is immune to the move
        def blocked?(user, move, target)
        end
      end
      register(:wonder_guard, WonderGuard)
      class WonderSkin < Ability
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:wonder_skin, WonderSkin)
      class ZenMode < Ability
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
        private
        def transform
        end
        def back
        end
      end
      register(:zen_mode, ZenMode)
      class Schooling < ZenMode
        private
        def transform
        end
        def back
        end
      end
      register(:schooling, Schooling)
      class ShieldsDown < ZenMode
        # Function called when a status_prevention is checked
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [:prevent, nil] :prevent if the status cannot be applied
        def on_status_prevention(handler, status, target, launcher, skill)
        end
        def transform
        end
        def back
        end
      end
      register(:shields_down, ShieldsDown)
      class ZeroToHero < Ability
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Check whether the ability should be activated when the pokémon returns to battle
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        def should_activate?(who)
        end
        # Proceed with the change of form
        # @param handler [Battle::Logic::SwitchHandler]
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def switch_form(handler, with)
        end
      end
      register(:zero_to_hero, ZeroToHero)
      class AsOne < Moxie
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # The stat that will be boosted
        # @return [Symbol]
        def boosted_stat
        end
      end
      register(:as_one, AsOne)
    end
    class Commanding < OutOfReachBase
      include Mechanics::ForceNextMove
      def initialize(logic, pokemon)
      end
      # Make the empty action that is forced by this effect
      # @return [Actions::NoAction]
      def make_action
      end
      # Function called when we try to use a move as the user (returns :prevent if user fails)
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param move [Battle::Move]
      # @return [:prevent, nil] :prevent if the move cannot continue
      def on_move_prevention_user(user, targets, move)
      end
      # Function called when testing if pokemon can switch (when he couldn't passthrough)
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:prevent, nil] if :prevent, can_switch? will return false
      def on_switch_prevention(handler, pokemon, skill, reason)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class Commanded < PokemonTiedEffectBase
      def initialize(logic, pokemon, ally)
      end
      # Function called when testing if pokemon can switch (when he couldn't passthrough)
      # @param handler [Battle::Logic::SwitchHandler]
      # @param pokemon [PFM::PokemonBattler]
      # @param skill [Battle::Move, nil] potential skill used to switch
      # @param reason [Symbol] the reason why the SwitchHandler is called
      # @return [:prevent, nil] if :prevent, can_switch? will return false
      def on_switch_prevention(handler, pokemon, skill, reason)
      end
      # Function called after damages were applied and when target died (post_damage_death)
      # @param handler [Battle::Logic::DamageHandler]
      # @param hp [Integer] number of hp (damage) dealt
      # @param target [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
      # @param skill [Battle::Move, nil] Potential move used
      def on_post_damage_death(handler, hp, target, launcher, skill)
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class CudChewEffect < PokemonTiedEffectBase
      # Create a new Pokemon tied effect
      # @param logic [Battle::Logic]
      # @param pokemon [PFM::PokemonBattler]
      # @param counter [Integer] (default:2)
      # @param origin [PFM::PokemonBattler] Pokemon that used the move dealing this effect
      def initialize(logic, pokemon, counter, consumed_item)
      end
      # Function called at the end of a turn
      # @param logic [Battle::Logic] logic of the battle
      # @param scene [Battle::Scene] battle scene
      # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
      def on_end_turn_event(logic, scene, battlers)
      end
      # If the effect can proc
      # @return [Boolean]
      def triggered?
      end
      # Get the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class TabletsOfRuin < EffectBase
      # Give the atk modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def atk_modifier
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class BeadsOfRuin < EffectBase
      # Give the dfs modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfs_modifier
      end
      # Give the dfe modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfe_modifier
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class VesselOfRuin < EffectBase
      # Give the ats modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def ats_modifier
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
    class SwordOfRuin < EffectBase
      # Give the dfs modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfs_modifier
      end
      # Give the dfe modifier over given to the Pokemon with this effect
      # @return [Float, Integer] multiplier
      def dfe_modifier
      end
      # Function giving the name of the effect
      # @return [Symbol]
      def name
      end
    end
  end
end
Hooks.register(PFM::PokemonBattler, :on_reset_states, 'PSDK reset FlashFire') do
  ability_effect.reset if ability_effect.is_a?(Battle::Effects::Ability::FlashFire)
end
Hooks.register(PFM::PokemonBattler, :on_reset_states, 'PSDK reset Unburden') do
  ability_effect.reset if ability_effect.is_a?(Battle::Effects::Ability::Unburden)
end
