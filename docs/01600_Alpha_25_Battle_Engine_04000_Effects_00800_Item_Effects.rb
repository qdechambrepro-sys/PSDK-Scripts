module Battle
  module Effects
    class Item < EffectBase
      # Get the db_symbol of the item
      # @return [Symbol]
      attr_reader :db_symbol
      # Get the target of the effect
      # @return [PFM::PokemonBattler]
      attr_reader :target
      @registered_items = {}
      # Create a new item effect
      # @param logic [Battle::Logic]
      # @param target [PFM::PokemonBattler]
      # @param db_symbol [Symbol] db_symbol of the item
      def initialize(logic, target, db_symbol)
      end
      class << self
        # Register a new item
        # @param db_symbol [Symbol] db_symbol of the item
        # @param klass [Class<Item>] class of the item effect
        def register(db_symbol, klass)
        end
        # Create a new Item effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        # @return [Item]
        def new(logic, target, db_symbol)
        end
      end
      class Berry < Item
        # List of berry flavors
        FLAVORS = %i[spicy dry sweet bitter sour]
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that consumes the berry
        # @param holder [PFM::PokemonBattler] pokemon holding the berry
        # @param launcher [PFM::PokemonBattler] potential user of the move
        # @param move [Battle::Move] potential move
        # @param should_confuse [Boolean] if the berry should confuse the Pokemon if he does not like the taste
        def consume_berry(holder, launcher = nil, move = nil, should_confuse: false)
        end
        # Function that tests if berry cannot be consumed
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        # @return [Boolean]
        def cannot_be_consumed?(force_execution = false)
        end
      end
      class Drives < Item
        # Function called when we try to get the definitive type of a move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @param type [Integer] current type of the move (potentially after effects)
        # @return [Integer, nil] new type of the move
        def on_move_type_change(user, target, move, type)
        end
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
        end
      end
      class ShockDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
        end
      end
      class BurnDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
        end
      end
      class ChillDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
        end
      end
      register(:douse_drive, Drives)
      register(:shock_drive, ShockDrive)
      register(:burn_drive, BurnDrive)
      register(:chill_drive, ChillDrive)
      class Gems < Item
        # List of conditions to yield the base power multiplier
        CONDITIONS = {}
        # List of multiplier if conditions are met
        MULTIPLIERS = Hash.new(1.3)
        # Function called before the accuracy check of a move is done
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param targets [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_pre_accuracy_check(logic, scene, targets, launcher, skill)
        end
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
        private
        # Check whether the launcher can use its gem
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        def usable_gem?(user, target, move)
        end
        class << self
          # Register an item with base power multiplier only
          # @param db_symbol [Symbol] db_symbol of the item
          # @param multiplier [Float] multiplier if condition met
          # @param klass [Class<BasePowerMultiplier>] klass to instanciate
          # @param block [Proc] condition to verify
          # @yieldparam user [PFM::PokemonBattler] user of the move
          # @yieldparam target [PFM::PokemonBattler] target of the move
          # @yieldparam move [Battle::Move] move
          # @yieldreturn [Boolean]
          def register(db_symbol, multiplier = nil, klass = Gems, &block)
          end
        end
        register(:fire_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:fire).id) }
        register(:water_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:water).id) }
        register(:electric_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:electric).id) }
        register(:grass_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:grass).id) }
        register(:ice_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:ice).id) }
        register(:fighting_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:fighting).id) }
        register(:poison_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:poison).id) }
        register(:ground_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:ground).id) }
        register(:flying_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:flying).id) }
        register(:psychic_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:psychic).id) }
        register(:bug_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:bug).id) }
        register(:rock_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:rock).id) }
        register(:ghost_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:ghost).id) }
        register(:dragon_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:dragon).id) }
        register(:dark_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:dark).id) }
        register(:steel_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:steel).id) }
        register(:fairy_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:fairy).id) }
        register(:normal_gem) { |user, target, move| move.definitive_types(user, target).include?(data_type(:normal).id) }
      end
      class HalfSpeed < Item
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:power_band, HalfSpeed)
      register(:power_belt, HalfSpeed)
      register(:power_bracer, HalfSpeed)
      register(:power_lens, HalfSpeed)
      register(:power_weight, HalfSpeed)
      register(:macho_brace, HalfSpeed)
      register(:iron_ball, HalfSpeed)
      class OranBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
        end
      end
      class SitrusBerry < OranBerry
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
        end
      end
      class BerryJuice < OranBerry
        def hp_healed
        end
      end
      class ConfusingBerries < OranBerry
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
        end
      end
      register(:oran_berry, OranBerry)
      register(:sitrus_berry, SitrusBerry)
      register(:berry_juice, BerryJuice)
      register(:figy_berry, ConfusingBerries)
      register(:wiki_berry, ConfusingBerries)
      register(:mago_berry, ConfusingBerries)
      register(:aguav_berry, ConfusingBerries)
      register(:iapapa_berry, ConfusingBerries)
      class HpTriggeredStatBerries < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
        end
        # Give the stat it should improve
        # @return [Symbol]
        def stat_improved
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
        end
        class Ganlon < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
          end
        end
        class Salac < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
          end
        end
        class Petaya < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
          end
        end
        class Apicot < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
          end
        end
        class Starf < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
          end
        end
      end
      register(:liechi_berry, HpTriggeredStatBerries)
      register(:ganlon_berry, HpTriggeredStatBerries::Ganlon)
      register(:salac_berry, HpTriggeredStatBerries::Salac)
      register(:petaya_berry, HpTriggeredStatBerries::Petaya)
      register(:apicot_berry, HpTriggeredStatBerries::Apicot)
      register(:starf_berry, HpTriggeredStatBerries::Starf)
      class AttackMultiplier < Item
        # List of conditions to yield the attack multiplier
        CONDITIONS = {}
        # List of multiplier if conditions are met
        MULTIPLIERS = Hash.new(2)
        # Give the move [Spe]atk mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_atk_multiplier(user, target, move)
        end
        class << self
          # Register an item with attack multiplier only
          # @param db_symbol [Symbol] db_symbol of the item
          # @param multiplier [Float] multiplier if condition met
          # @param klass [Class<AttackMultiplier>] klass to instanciate
          # @param block [Proc] condition to verify
          # @yieldparam user [PFM::PokemonBattler] user of the move
          # @yieldparam target [PFM::PokemonBattler] target of the move
          # @yieldparam move [Battle::Move] move
          # @yieldreturn [Boolean]
          def register(db_symbol, multiplier = nil, klass = AttackMultiplier, &block)
          end
        end
        class ChoiceAttackMultiplier < AttackMultiplier
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
          private
          # Checks if the user can use the move
          # @param user [PFM::PokemonBattler]
          # @param move [Battle::Move]
          # @return [Boolean]
          def can_be_used?(user, move)
          end
        end
        class SoulDew < AttackMultiplier
          # Give the move [Spe]def mutiplier
          # @param user [PFM::PokemonBattler] user of the move
          # @param target [PFM::PokemonBattler] target of the move
          # @param move [Battle::Move] move
          # @return [Float, Integer] multiplier
          def sp_def_multiplier(user, target, move)
          end
        end
        register(:choice_band, 1.5, ChoiceAttackMultiplier) { |_, _, move| move.physical? }
        register(:choice_specs, 1.5, ChoiceAttackMultiplier) { |_, _, move| move.special? }
        register(:thick_club) { |user, _, move| move.physical? && %i[cubone marowak].include?(user.db_symbol) }
        register(:deep_sea_tooth) { |user, _, move| move.special? && user.db_symbol == :clamperl }
        register(:soul_dew, 1.5, SoulDew) { |user, _, move| move.special? && %i[latios latias].include?(user.db_symbol) }
      end
      class BasePowerMultiplier < Item
        # List of conditions to yield the base power multiplier
        CONDITIONS = {}
        # List of multiplier if conditions are met
        MULTIPLIERS = Hash.new(1.2)
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
        end
        class << self
          # Register an item with base power multiplier only
          # @param db_symbol [Symbol] db_symbol of the item
          # @param multiplier [Float] multiplier if condition met
          # @param klass [Class<BasePowerMultiplier>] klass to instanciate
          # @param block [Proc] condition to verify
          # @yieldparam user [PFM::PokemonBattler] user of the move
          # @yieldparam target [PFM::PokemonBattler] target of the move
          # @yieldparam move [Battle::Move] move
          # @yieldreturn [Boolean]
          def register(db_symbol, multiplier = nil, klass = BasePowerMultiplier, &block)
          end
        end
        register(:sea_incense) { |_, _, move| move.type_water? }
        register(:odd_incense) { |_, _, move| move.type_psychic? }
        register(:rock_incense) { |_, _, move| move.type_rock? }
        register(:wave_incense) { |_, _, move| move.type_water? }
        register(:rose_incense) { |_, _, move| move.type_grass? }
        register(:silk_scarf) { |_, _, move| move.type_normal? }
        register(:charcoal) { |_, _, move| move.type_fire? }
        register(:mystic_water) { |_, _, move| move.type_water? }
        register(:magnet) { |_, _, move| move.type_electric? }
        register(:miracle_seed) { |_, _, move| move.type_grass? }
        register(:never_melt_ice) { |_, _, move| move.type_ice? }
        register(:black_belt) { |_, _, move| move.type_fighting? }
        register(:sharp_beak) { |_, _, move| move.type_flying? }
        register(:poison_barb) { |_, _, move| move.type_poison? }
        register(:soft_sand) { |_, _, move| move.type_ground? }
        register(:twisted_spoon) { |_, _, move| move.type_psychic? }
        register(:silver_powder) { |_, _, move| move.type_bug? }
        register(:hard_stone) { |_, _, move| move.type_rock? }
        register(:spell_tag) { |_, _, move| move.type_ghost? }
        register(:dragon_fang) { |_, _, move| move.type_dragon? }
        register(:black_glasses) { |_, _, move| move.type_dark? }
        register(:metal_coat) { |_, _, move| move.type_steel? }
        register(:muscle_band, 1.1) { |_, _, move| move.physical? }
        register(:wise_glasses, 1.1) { |_, _, move| move.special? }
        register(:flame_plate) { |_, _, move| move.type_fire? }
        register(:splash_plate) { |_, _, move| move.type_water? }
        register(:zap_plate) { |_, _, move| move.type_electric? }
        register(:meadow_plate) { |_, _, move| move.type_grass? }
        register(:icicle_plate) { |_, _, move| move.type_ice? }
        register(:fist_plate) { |_, _, move| move.type_fighting? }
        register(:toxic_plate) { |_, _, move| move.type_poison? }
        register(:earth_plate) { |_, _, move| move.type_ground? }
        register(:sky_plate) { |_, _, move| move.type_flying? }
        register(:mind_plate) { |_, _, move| move.type_psychic? }
        register(:insect_plate) { |_, _, move| move.type_bug? }
        register(:stone_plate) { |_, _, move| move.type_rock? }
        register(:spooky_plate) { |_, _, move| move.type_ghost? }
        register(:draco_plate) { |_, _, move| move.type_dragon? }
        register(:dread_plate) { |_, _, move| move.type_dark? }
        register(:iron_plate) { |_, _, move| move.type_steel? }
        register(:pixie_plate) { |_, _, move| move.type_fairy? }
        register(:adamant_orb) { |user, _, move| user.db_symbol == :dialga && (move.type_dragon? || move.type_steel?) }
        register(:lustrous_orb) { |user, _, move| user.db_symbol == :palkia && (move.type_dragon? || move.type_water?) }
        register(:griseous_orb) { |user, _, move| user.db_symbol == :giratina && (move.type_dragon? || move.type_ghost?) }
        register(:soul_dew) { |user, _, move| user.db_symbol == :latias && (move.type_dragon? || move.type_psychic?) }
        register(:soul_dew) { |user, _, move| user.db_symbol == :latios && (move.type_dragon? || move.type_psychic?) }
      end
      class DefenseMultiplier < Item
        # List of conditions to yield the defense multiplier
        CONDITIONS = {}
        # List of multiplier if conditions are met
        MULTIPLIERS = Hash.new(1.5)
        # Give the move [Spe]def mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def sp_def_multiplier(user, target, move)
        end
        class << self
          # Register an item with defense multiplier only
          # @param db_symbol [Symbol] db_symbol of the item
          # @param multiplier [Float] multiplier if condition met
          # @param klass [Class<DefenseMultiplier>] klass to instanciate
          # @param block [Proc] condition to verify
          # @yieldparam user [PFM::PokemonBattler] user of the move
          # @yieldparam target [PFM::PokemonBattler] target of the move
          # @yieldparam move [Battle::Move] move
          # @yieldreturn [Boolean]
          def register(db_symbol, multiplier = nil, klass = DefenseMultiplier, &block)
          end
        end
        class AssaultVest < DefenseMultiplier
          # Function called when we try to check if the user cannot use a move
          # @param user [PFM::PokemonBattler]
          # @param move [Battle::Move]
          # @return [Proc, nil]
          def on_move_disabled_check(user, move)
          end
        end
        register(:metal_powder) do |_, target|
          next(false) if target.db_symbol != :ditto
          next(target.move_history.none? do |move_history|
            move_history.db_symbol == :transform
          end)
        end
        register(:eviolite) do |_, target|
          next(target.data.evolutions.reject { |evo| evo.conditions.any? { |cnd| cnd[:type] == :gemme } }.any?)
        end
        register(:deep_sea_scale, 2) { |_, target, move| move.special? && target.db_symbol == :clamperl }
        register(:assault_vest, nil, AssaultVest) { |_, _, move| move.special? }
      end
      class StatusBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Tell which status the berry tries to fix
        # @return [Symbol]
        def healed_status
        end
        class Rawst < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
          end
        end
        class Pecha < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
          end
        end
        class Chesto < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
          end
        end
        class Cheri < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
          end
        end
      end
      register(:aspear_berry, StatusBerry)
      register(:rawst_berry, StatusBerry::Rawst)
      register(:pecha_berry, StatusBerry::Pecha)
      register(:chesto_berry, StatusBerry::Chesto)
      register(:cheri_berry, StatusBerry::Cheri)
      class TerrainSeeds < Item
        ITEM_DATA = {}
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
        end
        # Function called after the field terrain was changed (on_post_fterrain_change)
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        def on_post_fterrain_change(handler, fterrain_type, last_fterrain)
        end
        # Function processing the effect of the item
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        def use_item_effect(handler)
        end
        private
        class << self
          # @param db_symbol [Symbol] db_symbol of the item
          # @param terrain [Symbol] symbol of the terrain triggering the item
          # @param stat [Float] symbol of the stat raised by the item
          # @param klass [Class<TerrainSeeds>] klass to instanciate
          def register(db_symbol, terrain, stat, klass = TerrainSeeds)
          end
        end
        register(:grassy_seed, :grassy_terrain, :dfe)
        register(:electric_seed, :electric_terrain, :dfe)
        register(:psychic_seed, :psychic_terrain, :dfs)
        register(:misty_seed, :misty_terrain, :dfs)
      end
      class TypeResistingBerry < Berry
        # List of conditions to yield the attack multiplier
        CONDITIONS = {}
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        class << self
          # Register an item with defense multiplier only
          # @param db_symbol [Symbol] db_symbol of the item
          # @param klass [Class<TypeResistingBerry>] klass to instanciate
          # @param block [Proc] condition to verify
          # @yieldparam user [PFM::PokemonBattler] user of the move
          # @yieldparam target [PFM::PokemonBattler] target of the move
          # @yieldparam move [Battle::Move] move
          # @yieldreturn [Boolean]
          def register(db_symbol, klass = TypeResistingBerry, &block)
          end
        end
        register(:occa_berry) { |_, _, move| move.super_effective? && move.type_fire? }
        register(:passho_berry) { |_, _, move| move.super_effective? && move.type_water? }
        register(:wacan_berry) { |_, _, move| move.super_effective? && move.type_electric? }
        register(:rindo_berry) { |_, _, move| move.super_effective? && move.type_grass? }
        register(:yache_berry) { |_, _, move| move.super_effective? && move.type_ice? }
        register(:chople_berry) { |_, _, move| move.super_effective? && move.type_fighting? }
        register(:kebia_berry) { |_, _, move| move.super_effective? && move.type_poison? }
        register(:shuca_berry) { |_, _, move| move.super_effective? && move.type_ground? }
        register(:coba_berry) { |_, _, move| move.super_effective? && move.type_flying? }
        register(:payapa_berry) { |_, _, move| move.super_effective? && move.type_psychic? }
        register(:tanga_berry) { |_, _, move| move.super_effective? && move.type_bug? }
        register(:charti_berry) { |_, _, move| move.super_effective? && move.type_rock? }
        register(:kasib_berry) { |_, _, move| move.super_effective? && move.type_ghost? }
        register(:haban_berry) { |_, _, move| move.super_effective? && move.type_dragon? }
        register(:colbur_berry) { |_, _, move| move.super_effective? && move.type_dark? }
        register(:babiri_berry) { |_, _, move| move.super_effective? && move.type_steel? }
        register(:chilan_berry) { |_, _, move| move.type_normal? }
        register(:roseli_berry) { |_, _, move| move.super_effective? && move.type_fairy? }
      end
      class AirBalloon < Item
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
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
      end
      register(:air_balloon, AirBalloon)
      class BlackSludge < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:black_sludge, BlackSludge)
      class ChoiceScarf < Item
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
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
        private
        # Checks if the user can use the move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_be_used?(user, move)
        end
      end
      register(:choice_scarf, ChoiceScarf)
      class EjectButton < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:eject_button, EjectButton)
      class EnigmaBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Tell if the berry triggers
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(move)
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
        end
      end
      register(:enigma_berry, EnigmaBerry)
      class ExpertBelt < Item
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
        end
      end
      register(:expert_belt, ExpertBelt)
      class FlameOrb < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:flame_orb, FlameOrb)
      class FocusBand < Item
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
      register(:focus_band, FocusBand)
      class FocusSash < Item
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
      register(:focus_sash, FocusSash)
      class JabocaBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
        end
      end
      class RowapBerry < JabocaBerry
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
        end
      end
      register(:jaboca_berry, JabocaBerry)
      register(:rowap_berry, RowapBerry)
      class KeeBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Stat increased on hit
        # @return [Symbol]
        def stat_increased
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
        end
      end
      class MarangaBerry < KeeBerry
        # Stat increased on hit
        # @return [Symbol]
        def stat_increased
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
        end
      end
      register(:kee_berry, KeeBerry)
      register(:maranga_berry, MarangaBerry)
      class KingsRock < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:king_s_rock, KingsRock)
      register(:razor_fang, KingsRock)
      class LansatBerry < Berry
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
        end
      end
      register(:lansat_berry, LansatBerry)
      class LaxIncense < Item
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:lax_incense, LaxIncense)
      register(:bright_powder, LaxIncense)
      class Leftovers < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:leftovers, Leftovers)
      class LeppaBerry < Berry
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
        # Give the message
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move, nil] Potential move used
        # @return String
        def message(target, move)
        end
      end
      register(:leppa_berry, LeppaBerry)
      class LifeOrb < Item
        # Create a new Life Orb effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        def initialize(logic, target, db_symbol)
        end
        # Give the move mod1 mutiplier (after the critical)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod2_multiplier(user, target, move)
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
        private
        # Check if this the last hit of the move
        # @param skill [Battle::Move, nil] Potential move used
        def last_hit?(skill)
        end
        # Checks if the effect can be applied
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def can_apply_effect?(target, launcher, skill)
        end
      end
      register(:life_orb, LifeOrb)
      class LumBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
      end
      register(:lum_berry, LumBerry)
      class LuminousMoss < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
        end
        # Check if the change of stats is possible
        # @param handler [Battle::Logic::DamageHandler]
        # @param target [PFM::PokemonBattler]
        # @return [Boolean]
        def stat_changeable?(handler, target)
        end
      end
      class Snowball < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
        end
      end
      class AbsorbBulb < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
        end
      end
      class CellBattery < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
        end
      end
      register(:luminous_moss, LuminousMoss)
      register(:snowball, Snowball)
      register(:absorb_bulb, AbsorbBulb)
      register(:cell_battery, CellBattery)
      class MentalHerb < Item
        # List the db_symbol for every Mental effect
        # @return [Array<Symbol>]
        MENTAL_EFFECTS = %i[attract encore taunt torment heal_block disable]
        # Create a new item effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        def initialize(logic, target, db_symbol)
        end
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
        private
        # Function called to check and eliminate mental effects
        # @param effect_name [Symbol]
        def eliminate_effect(effect_name)
        end
      end
      register(:mental_herb, MentalHerb)
      class Metronome < Item
        # Give the move mod1 mutiplier (after the critical)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod2_multiplier(user, target, move)
        end
      end
      register(:metronome, Metronome)
      class MicleBerry < Berry
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
        private
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
        end
      end
      register(:micle_berry, MicleBerry)
      class PersimBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
        end
      end
      register(:persim_berry, PersimBerry)
      class PowerHerb < Item
        # Function called after a battler proceed its two turn move's first turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>, nil]
        # @param skill [Battle::Move, nil]
        # @return [Boolean, nil] weither or not the two turns move is executed in one turn
        def on_two_turn_shortcut(user, targets, skill)
        end
        EXCEPTIONS = %i[sky_drop]
        def exceptions
        end
      end
      register(:power_herb, PowerHerb)
      class QuickPowder < Item
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
        end
      end
      register(:quick_powder, QuickPowder)
      class RedCard < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:red_card, RedCard)
      class RockyHelmet < Item
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
      register(:rocky_helmet, RockyHelmet)
      class SafetyGoggles < Item
        # Function called when we try to check if the target evades the move
        # @param user [PFM::PokemonBattler]
        # @param target [PFM::PokemonBattler] expected target
        # @param move [Battle::Move]
        # @return [Boolean] if the target is evading the move
        def on_move_prevention_target(user, target, move)
        end
      end
      register(:safety_goggles, SafetyGoggles)
      class ShedShell < Item
        # Function called when testing if pokemon can switch regardless of the prevension.
        # @param handler [Battle::Logic::SwitchHandler]
        # @param pokemon [PFM::PokemonBattler]
        # @param skill [Battle::Move, nil] potential skill used to switch
        # @param reason [Symbol] the reason why the SwitchHandler is called
        # @return [:passthrough, nil] if :passthrough, can_switch? will return true without checking switch_prevention
        def on_switch_passthrough(handler, pokemon, skill, reason)
        end
      end
      register(:shed_shell, ShedShell)
      class ShellBell < Item
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
      register(:shell_bell, ShellBell)
      class StickyBarb < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
        alias on_post_damage_death on_post_damage
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:sticky_barb, StickyBarb)
      class ToxicOrb < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
        end
      end
      register(:toxic_orb, ToxicOrb)
      class WeaknessPolicy < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
        end
      end
      register(:weakness_policy, WeaknessPolicy)
      class WhiteHerb < Item
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
        end
      end
      register(:white_herb, WhiteHerb)
      class WideLens < Item
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:wide_lens, WideLens)
      class ZoomLens < Item
        # Return the chance of hit multiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move]
        # @return [Float]
        def chance_of_hit_multiplier(user, target, move)
        end
      end
      register(:zoom_lens, ZoomLens)
    end
  end
end
