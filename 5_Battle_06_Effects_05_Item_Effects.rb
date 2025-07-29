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
        super(logic)
        @target = target
        @db_symbol = db_symbol
      end
      class << self
        # Register a new item
        # @param db_symbol [Symbol] db_symbol of the item
        # @param klass [Class<Item>] class of the item effect
        def register(db_symbol, klass)
          @registered_items[db_symbol] = klass
        end
        # Create a new Item effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        # @return [Item]
        def new(logic, target, db_symbol)
          klass = @registered_items[db_symbol] || Item
          object = klass.allocate
          object.send(:initialize, logic, target, db_symbol)
          return object
        end
      end
      class Berry < Item
        # List of berry flavors
        FLAVORS = %i[spicy dry sweet bitter sour]
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          return nil
        end
        private
        # Function that consumes the berry
        # @param holder [PFM::PokemonBattler] pokemon holding the berry
        # @param launcher [PFM::PokemonBattler] potential user of the move
        # @param move [Battle::Move] potential move
        # @param should_confuse [Boolean] if the berry should confuse the Pokemon if he does not like the taste
        def consume_berry(holder, launcher = nil, move = nil, should_confuse: false)
          @logic.item_change_handler.change_item(:none, true, holder, launcher, move) if holder.hold_item?(db_symbol)
          if should_confuse && (data = Yuki::Berries::BERRY_DATA[db_symbol])
            taste = FLAVORS.max_by { |flavor| data.send(flavor) } || FLAVORS.first
            return unless holder.flavor_disliked?(taste)
            return unless @logic.status_change_handler.status_appliable?(:confuse, holder, launcher, move)
            @logic.status_change_handler.status_change(:confusion, holder, launcher, move)
          end
          if holder.has_ability?(:cheek_pouch) && !holder.effects.has?(:heal_block)
            @logic.scene.visual.show_ability(holder)
            @logic.damage_handler.heal(holder, holder.max_hp / 3)
          end
        end
        # Function that tests if berry cannot be consumed
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        # @return [Boolean]
        def cannot_be_consumed?(force_execution = false)
          return false if force_execution
          return @logic.foes_of(@target).any? { |foe| %i[unnerve as_one].include?(foe.battle_ability_db_symbol) && foe.alive? }
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
          return if user != @target
          return unless user.db_symbol == :genesect && move.be_method == :s_techno_blast
          return new_move_type
        end
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
          return data_type(:water).id
        end
      end
      class ShockDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
          return data_type(:electric).id
        end
      end
      class BurnDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
          return data_type(:fire).id
        end
      end
      class ChillDrive < Drives
        private
        # Give the new move type if the drive works
        # @return [Integer]
        def new_move_type
          return data_type(:ice).id
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
          return unless targets.any? { |target| usable_gem?(launcher, target, skill) }
          logic.scene.visual.show_item(launcher)
          launcher.item_consumed = true
        end
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
          return super unless usable_gem?(user, target, move)
          @logic.item_change_handler.change_item(:none, true, user)
          return MULTIPLIERS[db_symbol]
        end
        private
        # Check whether the launcher can use its gem
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        def usable_gem?(user, target, move)
          return false if user != @target
          return false if move.ohko? || move.typeless? || move.be_method == :s_pledge
          return false unless CONDITIONS[db_symbol].call(user, target, move)
          return true
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
            Item.register(db_symbol, klass)
            CONDITIONS[db_symbol] = block
            MULTIPLIERS[db_symbol] = multiplier if multiplier
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
          return 0.5
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
          return if target != @target
          return unless launcher && skill
          return if %i[s_pluck].include?(skill.be_method)
          process_effect(target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          process_effect(@target, nil, nil)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          define_singleton_method(:hp_rate_trigger) {1 } if force_heal
          process_effect(@target, nil, nil, force_execution)
        end
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead? || target.hp_rate > hp_rate_trigger
          return if cannot_be_consumed?(force_execution)
          @logic.damage_handler.heal(target, hp_healed) do
            item_name = data_item(db_symbol).name
            @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 914, target, PFM::Text::ITEM2[1] => item_name))
          end
          consume_berry(target, launcher, skill, should_confuse: should_confuse)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return 0.5
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
          return @target.has_ability?(:ripen) ? 20 : 10
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
          return false
        end
      end
      class SitrusBerry < OranBerry
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
          return (@target.max_hp * 2 / 4).clamp(1, Float::INFINITY) if @target.has_ability?(:ripen)
          return (@target.max_hp / 4).clamp(1, Float::INFINITY)
        end
      end
      class BerryJuice < OranBerry
        def hp_healed
          return @target.has_ability?(:ripen) ? 40 : 20
        end
      end
      class ConfusingBerries < OranBerry
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return @target.has_ability?(:gluttony) ? 0.5 : 0.25
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
          return (@target.max_hp * 2 / 3).clamp(1, Float::INFINITY) if @target.has_ability?(:ripen)
          return (@target.max_hp / 3).clamp(1, Float::INFINITY)
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
          return true
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
          return if target != @target
          return unless launcher && skill
          process_effect(target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          process_effect(@target, nil, nil)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          define_singleton_method(:hp_rate_trigger) {1 } if force_heal
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead? || target.hp_rate > hp_rate_trigger
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill, should_confuse: should_confuse)
          power = target.has_ability?(:ripen) ? 2 : 1
          @logic.stat_change_handler.stat_change_with_process(stat_improved, power, target, launcher, skill)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return @target.has_ability?(:gluttony) ? 0.5 : 0.25
        end
        # Give the stat it should improve
        # @return [Symbol]
        def stat_improved
          return :atk
        end
        # Tell if the berry effect should confuse
        # @return [Boolean]
        def should_confuse
          return false
        end
        class Ganlon < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
            return :dfe
          end
        end
        class Salac < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
            return :spd
          end
        end
        class Petaya < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
            return :ats
          end
        end
        class Apicot < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
            return :dfs
          end
        end
        class Starf < HpTriggeredStatBerries
          # Give the stat it should improve
          # @return [Symbol]
          def stat_improved
            return Battle::Logic::StatChangeHandler::ALL_STATS.sample(random: @logic.generic_rng)
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
          return 1 if user != @target
          return 1 unless CONDITIONS[db_symbol].call(user, target, move)
          return MULTIPLIERS[db_symbol]
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
            Item.register(db_symbol, klass)
            CONDITIONS[db_symbol] = block
            MULTIPLIERS[db_symbol] = multiplier if multiplier
          end
        end
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
          return 1 if user != @target
          return 1 unless CONDITIONS[db_symbol].call(user, target, move)
          return MULTIPLIERS[db_symbol]
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
            Item.register(db_symbol, klass)
            CONDITIONS[db_symbol] = block
            MULTIPLIERS[db_symbol] = multiplier if multiplier
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
        register(:punching_glove, 1.1) { |_, _, move| move.punching? }
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
          return 1 if target != @target
          return 1 unless CONDITIONS[db_symbol].call(user, target, move)
          return MULTIPLIERS[db_symbol]
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
            Item.register(db_symbol, klass)
            CONDITIONS[db_symbol] = block
            MULTIPLIERS[db_symbol] = multiplier if multiplier
          end
        end
      end
      class StatusBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
          return if target != @target || status != healed_status
          process_effect(@target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          return unless target.status_effect.name == healed_status
          @logic.status_change_handler.status_change(:cure, target, launcher, skill)
        end
        # Tell which status the berry tries to fix
        # @return [Symbol]
        def healed_status
          return :freeze
        end
        class Rawst < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
            return :burn
          end
        end
        class Pecha < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
            return %i[poison toxic].include?(@target.status_effect.name) ? @target.status_effect.name : false
          end
        end
        class Chesto < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
            return :sleep
          end
        end
        class Cheri < StatusBerry
          # Tell which status the berry tries to fix
          # @return [Symbol]
          def healed_status
            return :paralysis
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
          return if with != @target || @logic.field_terrain == :none
          return unless @logic.field_terrain_effect.db_symbol == ITEM_DATA[@target.battle_item_db_symbol][:terrain]
          use_item_effect(handler)
        end
        # Function called after the field terrain was changed (on_post_fterrain_change)
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        # @param fterrain_type [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        # @param last_fterrain [Symbol] :none, :electric_terrain, :grassy_terrain, :misty_terrain, :psychic_terrain
        def on_post_fterrain_change(handler, fterrain_type, last_fterrain)
          return if fterrain_type != ITEM_DATA[@target.battle_item_db_symbol][:terrain]
          use_item_effect(handler)
        end
        # Function processing the effect of the item
        # @param handler [Battle::Logic::FTerrainChangeHandler]
        def use_item_effect(handler)
          handler.scene.visual.show_item(@target)
          handler.logic.stat_change_handler.stat_change_with_process(ITEM_DATA[@target.battle_item_db_symbol][:stat], 1, @target)
          @target.item_holding = @target.battle_item = 0
        end
        class << self
          # @param db_symbol [Symbol] db_symbol of the item
          # @param terrain [Symbol] symbol of the terrain triggering the item
          # @param stat [Float] symbol of the stat raised by the item
          # @param klass [Class<TerrainSeeds>] klass to instanciate
          def register(db_symbol, terrain, stat, klass = TerrainSeeds)
            Item.register(db_symbol, klass)
            ITEM_DATA[db_symbol] = {terrain: terrain, stat: stat}
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
          return 1 if cannot_be_consumed?
          return 1 if target != @target || !CONDITIONS[db_symbol].call(user, target, move)
          berry_name = data_item(db_symbol).name
          consume_berry(target, user, move)
          move.logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 219, target, PFM::Text::ITEM2[1] => berry_name))
          return 0.25 if target.has_ability?(:ripen)
          return 0.5
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
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
            Item.register(db_symbol, klass)
            CONDITIONS[db_symbol] = block
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
          return if with != @target || with.dead?
          return if with.grounded?
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 408, with))
        end
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target
          return unless launcher && skill
          return unless target.hold_item?(:air_balloon)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 411, target))
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
        alias on_post_damage_death on_post_damage
      end
      register(:air_balloon, AirBalloon)
      class BerserkGene < Item
        # Function called when a Pokemon has actually switched with another one
        # @param handler [Battle::Logic::SwitchHandler]
        # @param who [PFM::PokemonBattler] Pokemon that is switched out
        # @param with [PFM::PokemonBattler] Pokemon that is switched in
        def on_switch_event(handler, who, with)
          return unless with == @target
          handler.scene.visual.show_item(with)
          handler.logic.stat_change_handler.stat_change_with_process(:atk, 2, with)
          handler.logic.item_change_handler.change_item(:none, true, with)
          return if with.confused?
          with.effects.add(Battle::Effects::Confusion.new(handler.logic, with, 256))
          handler.scene.visual.show_rmxp_animation(with, 475)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 345, with))
        end
      end
      register(:berserk_gene, BerserkGene)
      class BigRoot < Item
        # Function called before drain were applied (to change the number of hp healed)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Float, Integer] multiplier
        def on_pre_drain(handler, hp, target, launcher, skill)
          return 1 unless launcher == @target
          return 1 unless skill
          return 1.3
        end
      end
      register(:big_root, BigRoot)
      class BlackSludge < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          if @target.type_poison?
            scene.visual.show_item(@target)
            logic.damage_handler.heal(@target, @target.max_hp / 16)
          else
            if !@target.has_ability?(:magic_guard)
              scene.display_message_and_wait(parse_text_with_pokemon(19, 1044, @target, PFM::Text::ITEM2[1] => @target.item_name))
              logic.damage_handler.damage_change((@target.max_hp / 8).clamp(1, Float::INFINITY), @target)
            end
          end
        end
      end
      register(:black_sludge, BlackSludge)
      class ChoiceItemMultiplier < Item
        # Function called when we try to use a move as the user (returns :prevent if user fails)
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>]
        # @param move [Battle::Move]
        # @return [:prevent, nil] :prevent if the move cannot continue
        def on_move_prevention_user(user, targets, move)
          return if can_be_used?(user, move)
          move.show_usage_failure(user)
          return :prevent
        end
        # Function called when we try to check if the user cannot use a move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Proc, nil]
        def on_move_disabled_check(user, move)
          return if can_be_used?(user, move)
          return proc {            move.scene.visual.show_item(user)
            move.scene.display_message_and_wait(parse_text_with_pokemon(19, 911, user, PFM::Text::MOVE[1] => move.name))
 }
        end
        # Checks if the user can use the move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_be_used?(user, move)
          last_move = user.move_history.reject { |m| m.db_symbol == :struggle }.last
          return true if user != @target
          return true if user.move_history.none?
          return true if move.db_symbol == :struggle
          return true if last_move.db_symbol == move.db_symbol
          return true if last_move.turn < user.last_sent_turn
          return false
        end
      end
      class ChoiceBand < ChoiceItemMultiplier
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
          return 1.5
        end
      end
      class ChoiceSpecs < ChoiceItemMultiplier
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def ats_modifier
          return 1.5
        end
      end
      class ChoiceScarf < ChoiceItemMultiplier
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
          return 1.5
        end
      end
      class AssaultVest < ChoiceItemMultiplier
        # Give the dfs modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfs_modifier
          return 1.5
        end
        # Checks if the user can use the move
        # @param user [PFM::PokemonBattler]
        # @param move [Battle::Move]
        # @return [Boolean]
        def can_be_used?(user, move)
          return true if user != @target
          return true unless move.status?
          if move.status?
            return true if user.has_ability?(:dancer) && user.ability_effect.activated?
            return true if user.effects.has?(:instruct)
            return true if move.db_symbol == :me_first
          end
          return false
        end
      end
      register(:choice_band, ChoiceBand)
      register(:choice_specs, ChoiceSpecs)
      register(:choice_scarf, ChoiceScarf)
      register(:assault_vest, AssaultVest)
      class DeepSeaScale < Item
        # Give the dfs modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfs_modifier
          return 2 if @target.db_symbol == :clamperl
          return super
        end
      end
      register(:deep_sea_scale, DeepSeaScale)
      class DeepSeaTooth < Item
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def ats_modifier
          return 2 if @target.db_symbol == :clamperl
          return super
        end
      end
      register(:deep_sea_tooth, DeepSeaTooth)
      class EjectButton < Item
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return if target != @target || launcher == target
          return unless launcher && skill
          return unless handler.logic.can_battler_be_replaced?(target)
          return if launcher.has_ability?(:sheer_force) && launcher.ability_effect&.activated?
          return if handler.logic.switch_request.any? { |request| request[:who] == target }
          handler.logic.actions.reject! { |a| a.is_a?(Actions::Attack) && a.launcher == target }
          handler.logic.switch_request << {who: target}
          handler.scene.visual.show_item(target)
          handler.logic.item_change_handler.change_item(:none, true, target)
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
          return if target != @target
          return unless launcher && skill
          process_effect(target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          define_singleton_method(:trigger?) { |_| true } if force_heal
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return unless trigger?(skill)
          return if cannot_be_consumed?(force_execution)
          @logic.damage_handler.heal(target, hp_healed) do
            item_name = data_item(db_symbol).name
            @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 914, target, PFM::Text::ITEM2[1] => item_name))
          end
          consume_berry(target, launcher, skill)
        end
        # Tell if the berry triggers
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(move)
          return move&.super_effective?
        end
        # Give the amount of HP healed
        # @return [Integer]
        def hp_healed
          return (@target.max_hp / 4).clamp(1, Float::INFINITY)
        end
      end
      register(:enigma_berry, EnigmaBerry)
      class Eviolite < Item
        # Give the dfe modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfe_modifier
          return 1.5 if @target.data.evolutions.reject { |evolution| evolution.conditions.any? { |condition| condition[:type] == :gemme } }.any?
          return super
        end
        alias dfs_modifier dfe_modifier
      end
      register(:eviolite, Eviolite)
      class ExpertBelt < Item
        # Give the move mod3 mutiplier (after everything)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod3_multiplier(user, target, move)
          return 1 if user != @target || !move.super_effective?
          return 1.2
        end
      end
      register(:expert_belt, ExpertBelt)
      class FlameOrb < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return if @target.has_ability?(:magic_guard)
          return unless logic.status_change_handler.status_appliable?(:burn, @target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 258, @target, PFM::Text::ITEM2[1] => @target.item_name))
          apply_common_effects_with_fling(scene, @target)
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          scene.logic.status_change_handler.status_change(:burn, target, launcher, skill)
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
          return unless target == @target
          return unless hp >= target.hp && bchance?(0.1, handler.logic)
          return unless launcher && skill
          return target.hp - 1
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
          return unless target == @target
          return if target.hp > hp || target.hp != target.max_hp
          return unless launcher && skill
          @show_message = true
          return target.hp - 1
        end
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return unless @show_message
          @show_message = false
          handler.scene.visual.show_item(target)
          handler.scene.display_message_and_wait(parse_text_with_pokemon(19, 514, target))
          handler.logic.item_change_handler.change_item(:none, true, target)
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
          return if target != @target || launcher == @target
          process_effect(target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          return unless launcher && trigger?(skill)
          @logic.damage_handler.damage_change((launcher.max_hp / 8).clamp(1, Float::INFINITY), launcher)
          @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 402, launcher))
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
          return skill&.physical? || false
        end
      end
      class RowapBerry < JabocaBerry
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
          return skill&.special? || false
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
          return if target != @target
          return if launcher.nil? || launcher.has_ability?(:sheer_force) && launcher.ability_effect.activated
          process_effect(target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          return unless launcher && trigger?(skill)
          power = target.has_ability?(:ripen) ? 2 : 1
          @logic.stat_change_handler.stat_change_with_process(stat_increased, power, target, launcher, skill)
        end
        # Stat increased on hit
        # @return [Symbol]
        def stat_increased
          return :dfe
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
          return skill&.physical? || false
        end
      end
      class MarangaBerry < KeeBerry
        # Stat increased on hit
        # @return [Symbol]
        def stat_increased
          return :dfs
        end
        # Tell if the berry triggers
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def trigger?(skill)
          return skill&.special? || false
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
          return if launcher != @target
          return unless skill&.trigger_king_rock? && launcher != target && bchance?(launcher.has_ability?(:serene_grace) ? 0.2 : 0.1, @logic)
          handler.scene.visual.show_item(launcher)
          apply_common_effects_with_fling(handler.scene, target, launcher, skill)
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          scene.logic.status_change_handler.status_change_with_process(:flinch, target, launcher, skill)
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
          return if target != @target
          process_effect(target, launcher, skill)
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          process_effect(@target, nil, nil)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          define_singleton_method(:hp_rate_trigger) {1 } if force_heal
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead? || target.hp_rate > hp_rate_trigger || target.effects.has?(:lansat_berry)
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          effect = PokemonTiedEffectBase.new(@logic, target)
          effect.define_singleton_method(:name) {:lansat_berry }
          target.effects.add(effect)
        end
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return @target.has_ability?(:gluttony) ? 0.5 : 0.25
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
          return 1 if target != @target
          return 0.9
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
          return unless battlers.include?(@target)
          return if @target.dead?
          logic.damage_handler.heal(@target, @target.max_hp / 16) do
            scene.display_message_and_wait(parse_text_with_pokemon(19, 914, @target, PFM::Text::ITEM2[1] => @target.item_name))
          end
        end
      end
      register(:leftovers, Leftovers)
      class LeppaBerry < Berry
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return if @target.moveset.none? { |move| move.pp == 0 }
          process_effect(@target, nil, nil)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          move = target.moveset.find { |s| s.pp == 0 }
          move ||= target.moveset.reject { |s| s.pp == s.ppmax }.min_by(&:pp)
          move ||= target.moveset.min_by(&:pp)
          if move
            move.pp += 10
            move.pp.clamp(0, move.ppmax)
            @logic.scene.display_message_and_wait(message(target, move))
          end
          consume_berry(target, launcher, skill)
        end
        # Give the message
        # @param target [PFM::PokemonBattler]
        # @param move [Battle::Move, nil] Potential move used
        # @return String
        def message(target, move)
          return parse_text_with_pokemon(19, 917, target, PFM::Text::ITEM2[1] => data_item(db_symbol).name, PFM::Text::MOVE[2] => move.name)
        end
      end
      register(:leppa_berry, LeppaBerry)
      class LifeOrb < Item
        # Create a new Life Orb effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        def initialize(logic, target, db_symbol)
          super
          @activated = false
          @show_message = false
        end
        # Give the move mod1 mutiplier (after the critical)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod2_multiplier(user, target, move)
          return 1.3 if user == @target
          return super
        end
        # Function called after damages were applied (post_damage, when target is still alive)
        # @param handler [Battle::Logic::DamageHandler]
        # @param hp [Integer] number of hp (damage) dealt
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_damage(handler, hp, target, launcher, skill)
          return unless can_apply_effect?(target, launcher, skill)
          @activated = true
        end
        alias on_post_damage_death on_post_damage
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return unless @activated
          return if @show_message
          hp = (@target.max_hp / 10).clamp(1, @target.hp)
          logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 1044, @target, PFM::Text::ITEM2[1] => @target.item_name))
          logic.damage_handler.damage_change(hp, @target)
          @show_message = true
        end
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if target.dead?
          return unless @activated
          @activated = false
          @show_message = false
        end
        private
        # Check if this the last hit of the move
        # @param skill [Battle::Move, nil] Potential move used
        def last_hit?(skill)
          return true unless skill.is_a?(Battle::Move::Basic::MultiHit)
          skill_multi_hit = skill
          return skill_multi_hit.last_hit?
        end
        # Checks if the effect can be applied
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def can_apply_effect?(target, launcher, skill)
          return false if launcher != @target || launcher == target
          return false if launcher.has_ability?(:magic_guard)
          return false if launcher.has_ability?(:sheer_force) && launcher.ability_effect&.activated?
          return false unless skill || last_hit?(skill)
          return false if @activated
          return true
        end
      end
      register(:life_orb, LifeOrb)
      class LightBall < Item
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          scene.logic.status_change_handler.status_change_with_process(:paralysis, target, launcher, skill)
        end
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
          return 2 if @target.db_symbol == :pikachu
          return super
        end
        alias ats_modifier atk_modifier
      end
      register(:light_ball, LightBall)
      class LumBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
          return if target != @target || status == :cure || status == :flinch
          process_effect(@target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          return unless launcher && skill
          @logic.status_change_handler.status_change(:confuse_cure, target, launcher, skill) if target.confused?
          @logic.status_change_handler.status_change(:cure, target, launcher, skill) if target.status?
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
          return if target != @target
          return unless expected_type?(skill) && stat_changeable?(handler, target) && launcher
          handler.scene.visual.show_item(target)
          handler.logic.stat_change_handler.stat_change_with_process(stat_improved, 1, target)
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :dfs
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
          return move&.type_water? || false
        end
        # Check if the change of stats is possible
        # @param handler [Battle::Logic::DamageHandler]
        # @param target [PFM::PokemonBattler]
        # @return [Boolean]
        def stat_changeable?(handler, target)
          stat_handler = handler.logic.stat_change_handler
          return target.has_ability?(:contrary) ? stat_handler.stat_decreasable?(stat_improved, target) : stat_handler.stat_increasable?(stat_improved, target)
        end
      end
      class Snowball < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :atk
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
          return move&.type_ice? || false
        end
      end
      class AbsorbBulb < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :ats
        end
      end
      class CellBattery < LuminousMoss
        private
        # Get the stat the item should improve
        # @return [Symbol]
        def stat_improved
          return :atk
        end
        # Tell if the used skill triggers the effect
        # @param move [Battle::Move, nil] Potential move used
        # @return [Boolean]
        def expected_type?(move)
          return move&.type_electric? || false
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
          super
          @used_once = false
        end
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return unless MENTAL_EFFECTS.any? { |effect| @target.effects.has?(effect) }
          apply_common_effects_with_fling(scene, @target)
          scene.visual.show_item(@target)
          logic.item_change_handler.change_item(:none, true, @target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1309, @target))
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          MENTAL_EFFECTS.each { |effect| eliminate_effect(effect, target) }
        end
        private
        # Function called to check and eliminate mental effects
        # @param effect_name [Symbol]
        # @param target [PFM::PokemonBattler]
        def eliminate_effect(effect_name, target)
          return if @used_once
          effect = target.effects.get(effect_name)
          return unless effect
          effect.kill
          @used_once = true
        end
      end
      register(:mental_herb, MentalHerb)
      class MetalPowder < Item
        # Give the dfe modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def dfe_modifier
          return 2 if @target.db_symbol == :ditto && @target.transform.nil?
          return super
        end
      end
      register(:metal_powder, MetalPowder)
      class Metronome < Item
        # Give the move mod1 mutiplier (after the critical)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def mod2_multiplier(user, target, move)
          return 1 if user != @target || move.consecutive_use_count == 0
          return 2 if move.consecutive_use_count >= 10
          return 1 + move.consecutive_use_count / 10.0
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
          return 1 if user != @target || user.hp_rate > hp_rate_trigger
          return 1.5
        end
        private
        # Give the hp rate that triggers the berry
        # @return [Float]
        def hp_rate_trigger
          return @target.has_ability?(:gluttony) ? 0.5 : 0.25
        end
      end
      register(:micle_berry, MicleBerry)
      class MirrorHerb < Item
        # Create a new item effect
        # @param logic [Battle::Logic]
        # @param target [PFM::PokemonBattler]
        # @param db_symbol [Symbol] db_symbol of the item
        def initialize(logic, target, db_symbol)
          super
          @stats = []
          @activated = false
        end
        # Check if the item effect is activated
        # @return [Boolean]
        def activated?
          return @activated
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
          return if target.bank == @target.bank
          return if target.hold_item?(:mirror_herb) && target.item_effect.activated?
          return unless power > 0
          @stats << [stat, power]
        end
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          deal_effect(logic, scene)
        end
        private
        # Deals the effect for Mirror Herb
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        def deal_effect(logic, scene)
          return if @stats.empty?
          @activated = true
          scene.visual.show_item(@target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1253, @target))
          @stats.each { |stat, power| logic.stat_change_handler.stat_change_with_process(stat, power, @target) }
          logic.item_change_handler.change_item(:none, true, @target)
        ensure
          @stats.clear
          @activated = false
        end
      end
      register(:mirror_herb, MirrorHerb)
      class PersimBerry < Berry
        # Function called when a post_status_change is performed
        # @param handler [Battle::Logic::StatusChangeHandler]
        # @param status [Symbol] :poison, :toxic, :confusion, :sleep, :freeze, :paralysis, :burn, :flinch, :cure
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def on_post_status_change(handler, status, target, launcher, skill)
          return if target != @target || status != :confusion
          process_effect(@target, launcher, skill)
        end
        # Function that executes the effect of the berry (for Pluck & Bug Bite)
        # @param force_heal [Boolean] tell if a healing berry should force the heal
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def execute_berry_effect(force_heal: false, force_execution: false)
          process_effect(@target, nil, nil, force_execution)
        end
        private
        # Function that process the effect of the berry (if possible)
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        # @param force_execution [Boolean] tell if the execution of the berry has to be forced
        def process_effect(target, launcher, skill, force_execution = false)
          return if target.dead?
          return if cannot_be_consumed?(force_execution)
          consume_berry(target, launcher, skill)
          return unless target.confused?
          @logic.status_change_handler.status_change(:confuse_cure, target, launcher, skill)
        end
      end
      register(:persim_berry, PersimBerry)
      class PoisonBarb < Item
        # Give the move base power mutiplier
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @param move [Battle::Move] move
        # @return [Float, Integer] multiplier
        def base_power_multiplier(user, target, move)
          return 1 if user != @target
          return 1 unless move.type_poison?
          return 1.2
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          scene.logic.status_change_handler.status_change(:poison, target, launcher, skill)
        end
      end
      register(:poison_barb, PoisonBarb)
      class PowerHerb < Item
        # Function called after a battler proceed its two turn move's first turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>, nil]
        # @param skill [Battle::Move, nil]
        # @return [Boolean, nil] weither or not the two turns move is executed in one turn
        def on_two_turn_shortcut(user, targets, skill)
          return if exceptions.include?(skill.db_symbol)
          @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 1028, user, PFM::Text::ITEM2[1] => user.item_name))
          @logic.item_change_handler.change_item(:none, true, user)
          return true
        end
        EXCEPTIONS = %i[sky_drop]
        def exceptions
          EXCEPTIONS
        end
      end
      register(:power_herb, PowerHerb)
      class QuickPowder < Item
        # Give the speed modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def spd_modifier
          return @target.db_symbol == :ditto ? 2 : 1
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
          return if target != @target || launcher == target
          return unless skill && launcher && handler.logic.can_battler_be_replaced?(launcher)
          return if launcher.has_ability?(:sheer_force) && launcher.ability_effect&.activated?
          return if handler.logic.switch_request.any? { |request| request[:who] == launcher }
          handler.scene.visual.show_item(target)
          rand_pkmn = (@logic.alive_battlers_without_check(launcher.bank).select { |p| p if p.party_id == launcher.party_id && p.position == -1 }).compact
          @logic.switch_request << {who: launcher, with: rand_pkmn.sample} unless rand_pkmn.empty? || launcher.has_ability?(:guard_dog)
          target.item_holding = target.battle_item = 0
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
          return if target != @target || launcher == target
          return unless skill&.made_contact? && launcher&.alive?
          handler.scene.visual.show_item(target)
          handler.logic.damage_handler.damage_change((launcher.max_hp / 6).clamp(1, Float::INFINITY), launcher)
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
          return if target != @target
          return move.powder?
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
          return if reason == :flee || pokemon != @target
          return if skill&.be_method == :s_teleport
          return :passthrough
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
          return if launcher != @target || launcher == target
          return if launcher.dead?
          return if launcher.has_ability?(:sheer_force) && launcher.ability_effect&.activated?
          return unless skill && hp >= 8
          return if launcher.hp == launcher.max_hp
          handler.scene.visual.show_item(launcher)
          handler.logic.damage_handler.heal(launcher, hp / 8)
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
          return unless launcher && skill&.made_contact? && launcher != target
          return if target != @target
          if launcher.item_db_symbol == :__undef__
            handler.logic.item_change_handler.change_item(:sticky_barb, false, launcher)
            handler.logic.item_change_handler.change_item(:none, false, target)
          end
        end
        alias on_post_damage_death on_post_damage
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return if @target.has_ability?(:magic_guard)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1044, @target, PFM::Text::ITEM2[1] => @target.item_name))
          logic.damage_handler.damage_change((@target.max_hp / 8).clamp(1, Float::INFINITY), @target)
        end
      end
      register(:sticky_barb, StickyBarb)
      class ThickClub < Item
        # Give the atk modifier over given to the Pokemon with this effect
        # @return [Float, Integer] multiplier
        def atk_modifier
          return 2 if %i[cubone marowak].include?(@target.db_symbol)
          return super
        end
      end
      register(:thick_club, ThickClub)
      class ThroatSpray < Item
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
          return unless logic.current_action.is_a?(Actions::Attack)
          return unless logic.current_action.launcher == @target
          return if @target.dead?
          return unless logic.can_battle_continue?
          move = logic.current_action&.move
          return unless move.sound_attack?
          scene.visual.show_item(@target)
          scene.visual.wait_for_animation
          logic.stat_change_handler.stat_change_with_process(:ats, 1, @target, no_message: true)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 950, @target, PFM::Text::ITEM2[1] => @target.item_name))
          logic.item_change_handler.change_item(:none, true, @target)
        end
      end
      register(:throat_spray, ThroatSpray)
      class ToxicOrb < Item
        # Function called at the end of a turn
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_end_turn_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return if @target.has_ability?(:magic_guard)
          return unless logic.status_change_handler.status_appliable?(:toxic, @target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 240, @target, PFM::Text::ITEM2[1] => @target.item_name))
          apply_common_effects_with_fling(scene, @target)
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          scene.logic.status_change_handler.status_change(:toxic, target, launcher, skill)
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
          return if target != @target
          return unless skill&.super_effective? && launcher
          handler.scene.visual.show_item(target)
          handler.logic.stat_change_handler.stat_change_with_process(:atk, 2, target)
          handler.logic.stat_change_handler.stat_change_with_process(:ats, 2, target)
          handler.logic.item_change_handler.change_item(:none, true, target)
        end
      end
      register(:weakness_policy, WeaknessPolicy)
      class WhiteHerb < Item
        # Function called at the end of an action
        # @param logic [Battle::Logic] logic of the battle
        # @param scene [Battle::Scene] battle scene
        # @param battlers [Array<PFM::PokemonBattler>] all alive battlers
        def on_post_action_event(logic, scene, battlers)
          return unless battlers.include?(@target)
          return if @target.dead?
          return if @target.battle_stage.none?(&:negative?)
          scene.visual.show_item(@target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1016, @target, PFM::Text::ITEM2[1] => @target.item_name))
          apply_common_effects_with_fling(scene, target)
          logic.item_change_handler.change_item(:none, true, @target)
        end
        # Apply the common effects of the item with Fling move effect
        # @param scene [Battle::Scene] battle scene
        # @param target [PFM::PokemonBattler]
        # @param launcher [PFM::PokemonBattler, nil] Potential launcher of a move
        # @param skill [Battle::Move, nil] Potential move used
        def apply_common_effects_with_fling(scene, target, launcher = nil, skill = nil)
          target.battle_stage.map! { |stage| stage.negative? ? 0 : stage }
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
          return 1 if user != @target
          return 1.1
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
          return 1 if user != @target
          return @logic.battler_attacks_after?(user, target) ? 1.2 : 1
        end
      end
      register(:zoom_lens, ZoomLens)
    end
  end
end
