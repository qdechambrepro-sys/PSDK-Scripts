module Battle
  # Generic class describing a move
  class Move
    include Hooks
    # @return [Hash{Symbol => Class}] list of the registered moves
    REGISTERED_MOVES = Hash.new(Move)
    # ID of the move in the database
    # @return [Integer]
    attr_reader :id
    # Number of pp the move currently has
    # @return [Integer]
    attr_reader :pp
    # Maximum number of ppg the move currently has
    # @return [Integer]
    attr_reader :ppmax
    # if the move has been used
    # @return [Boolean]
    attr_accessor :used
    # Number of time the move was used consecutively
    # @return [Integer]
    attr_accessor :consecutive_use_count
    # @return [Battle::Logic]
    attr_reader :logic
    # @return [Battle::Scene]
    attr_reader :scene
    # @return [Battle::Move]
    attr_accessor :original
    # Number of damage dealt last time the move was used (to be used with move history)
    # @return [Integer]
    attr_accessor :damage_dealt
    # The original target of the move (to be used with Magic Bounce/Coat)
    # @return [Array<PFM::PokemonBattler>]
    attr_accessor :original_target
    # Get the user of the move
    # @return [PFM::PokemonBattler, nil]
    attr_reader :user
    # Get the item effect of the thrown item (to be used with Fling)
    # @return [Battle::Effects::Item, nil]
    attr_reader :thrown_item_effect
    # Create a new move
    # @param db_symbol [Symbol] db_symbol of the move in the database
    # @param pp [Integer] number of pp the move currently has
    # @param ppmax [Integer] maximum number of pp the move currently has
    # @param scene [Battle::Scene] current battle scene
    def initialize(db_symbol, pp, ppmax, scene)
      data = data_move(db_symbol)
      @id = data.id
      @db_symbol = data.db_symbol
      @pp = pp
      @ppmax = ppmax
      @used = false
      @consecutive_use_count = 0
      @effectiveness = 1
      @damage_dealt = 0
      @original_target = []
      @scene = scene
      @logic = scene.logic
      @reloading = false
      @user = nil
      @thrown_item_effect = nil
    end
    # Format move for logging purpose
    # @return [String]
    def to_s
      "<PM:#{name},#{@consecutive_use_count} pp=#{@pp}>"
    end
    alias inspect to_s
    # Clone the move and give a reference to the original one
    def clone
      clone = super
      clone.original ||= self
      raise 'This function looks badly implement, just want to know where it is called'
    end
    # Return the data of the skill
    # @return [Studio::Move]
    def data
      return data_move(@db_symbol || @id)
    end
    # Return the name of the skill
    def name
      return data.name
    end
    # Return the skill description
    # @return [String]
    def description
      return data.description
    end
    # Return the battle engine method of the move
    # @return [Symbol]
    def be_method
      return data.be_method
    end
    alias symbol be_method
    # Return the text of the PP of the skill
    # @return [String]
    def pp_text
      "#{@pp} / #{@ppmax}"
    end
    # Return the actual base power of the move
    # @return [Integer]
    def power
      data.power
    end
    alias base_power power
    # Return the text of the power of the skill (for the UI)
    # @return [String]
    def power_text
      power = data.power
      return text_get(11, 12) if power == 0
      return power.to_s
    end
    # Return the current type of the move
    # @return [Integer]
    def type
      data_type(data.type).id
    end
    # Return the current accuracy of the move
    # @return [Integer]
    def accuracy
      data.accuracy
    end
    # Return the accuracy text of the skill (for the UI)
    # @return [String]
    def accuracy_text
      acc = data.accuracy
      return text_get(11, 12) if acc == 0
      return acc.to_s
    end
    # Return the priority of the skill
    # @param user [PFM::PokemonBattler] user for the priority check
    # @return [Integer]
    def priority(user = nil)
      priority = data.priority - Logic::MOVE_PRIORITY_OFFSET
      return priority unless user
      logic.each_effects(user) do |e|
        new_priority = e.on_move_priority_change(user, priority, self)
        return new_priority if new_priority
      end
      return priority
    end
    ## Move priority
    def relative_priority
      return priority + Logic::MOVE_PRIORITY_OFFSET
    end
    # Return the chance of effect of the skill
    # @return [Integer]
    def effect_chance
      return data.effect_chance == 0 ? 100 : data.effect_chance
    end
    # Get all the status effect of a move
    # @return [Array<Studio::Move::MoveStatus>]
    def status_effects
      return data.move_status
    end
    # Return the target symbol the skill can aim
    # @return [Symbol]
    def target
      return data.battle_engine_aimed_target
    end
    # Return the critical rate index of the skill
    # @return [Integer]
    def critical_rate
      return data.critical_rate
    end
    # Is the skill affected by gravity
    # @return [Boolean]
    def gravity_affected?
      return data.is_gravity
    end
    # Return the stat stage modifier the skill can apply
    # @return [Array<Studio::Move::BattleStageMod>]
    def battle_stage_mod
      return data.battle_stage_mod
    end
    # Is the skill direct ?
    # @return [Boolean]
    def direct?
      return data.is_direct
    end
    # Tell if the move is a mental move
    # @return [Boolean]
    def mental?
      return data.is_mental
    end
    # Is the skill affected by Mirror Move
    # @return [Boolean]
    def mirror_move_affected?
      return data.is_mirror_move
    end
    # Is the skill blocable by Protect and skill like that ?
    # @return [Boolean]
    def blocable?
      return data.is_blocable
    end
    # Does the skill has recoil ?
    # @return [Boolean]
    def recoil?
      false
    end
    # Returns the recoil factor
    # @return [Integer]
    def recoil_factor
      4
    end
    # Returns the drain factor
    # @return [Integer]
    def drain_factor
      2
    end
    # Is the skill a punching move ?
    # @return [Boolean]
    def punching?
      return data.is_punch
    end
    # Is the skill a sound attack ?
    # @return [Boolean]
    def sound_attack?
      return data.is_sound_attack
    end
    # Is the skill a slicing attack ?
    # @return [Boolean]
    def slicing_attack?
      return data.is_slicing_attack
    end
    # Does the skill unfreeze
    # @return [Boolean]
    def unfreeze?
      return data.is_unfreeze
    end
    # Is the skill a wind attack ?
    # @return [Boolean]
    def wind_attack?
      return data.is_wind
    end
    # Does the skill trigger the king rock
    # @return [Boolean]
    def trigger_king_rock?
      return data.is_king_rock_utility
    end
    # Is the skill snatchable ?
    # @return [Boolean]
    def snatchable?
      return data.is_snatchable
    end
    # Is the skill affected by magic coat ?
    # @return [Boolean]
    def magic_coat_affected?
      return data.is_magic_coat_affected
    end
    # Is the skill physical ?
    # @return [Boolean]
    def physical?
      return data.category == :physical
    end
    # Is the skill special ?
    # @return [Boolean]
    def special?
      return data.category == :special
    end
    # Is the skill status ?
    # @return [Boolean]
    def status?
      return data.category == :status
    end
    # Return the class of the skill (used by the UI)
    # @return [Integer] 1, 2, 3
    def atk_class
      return 2 if special?
      return 3 if status?
      return 1 if physical?
    end
    # Return the symbol of the move in the database
    # @return [Symbol]
    def db_symbol
      return @db_symbol
    end
    # Change the PP
    # @param value [Integer] the new pp value
    def pp=(value)
      @pp = value.to_i.clamp(0, @ppmax)
    end
    # Was the move a critical hit
    # @return [Boolean]
    def critical_hit?
      @critical
    end
    # Was the move super effective ?
    # @return [Boolean]
    def super_effective?
      @effectiveness >= 2
    end
    # Was the move not very effective ?
    # @return [Boolean]
    def not_very_effective?
      @effectiveness > 0 && @effectiveness < 1
    end
    # Tell if the move is a ballistic move
    # @return [Boolean]
    def ballistics?
      return data.is_ballistics
    end
    # Tell if the move is biting move
    # @return [Boolean]
    def bite?
      return data.is_bite
    end
    # Tell if the move is a dance move
    # @return [Boolean]
    def dance?
      return data.is_dance
    end
    # Tell if the move is a pulse move
    # @return [Boolean]
    def pulse?
      return data.is_pulse
    end
    # Tell if the move is a heal move
    # @return [Boolean]
    def heal?
      return data.is_heal
    end
    # Tell if the move is a two turn move
    # @return [Boolean]
    def two_turn?
      return data.is_charge
    end
    # Tell if the move is a powder move
    # @return [Boolean]
    def powder?
      return data.is_powder
    end
    # Tell if the move is a move that can bypass Substitute
    # @return [Boolean]
    def authentic?
      return data.is_authentic
    end
    # Tell if the move is a move is a recharge move
    # @return [Boolean]
    def recharge?
      return data.is_recharge
    end
    # Tell if the move is an OHKO move
    # @return [Boolean]
    def ohko?
      return false
    end
    # Tell if the move is a move that switch the user if that hit
    # @return [Boolean]
    def self_user_switch?
      return false
    end
    # Tell if the move is a move that forces target switch
    # @return [Boolean]
    def force_switch?
      return false
    end
    # Is the move doing something before any other moves ?
    # @return [Boolean]
    def pre_attack?
      return false
    end
    # Tells if the move hits multiple times
    # @return [Boolean]
    def multi_hit?
      return false
    end
    # Tell if the move will take two or more turns
    # @return [Boolean]
    def multi_turn?
      return false
    end
    # Tell that the move is a drain move
    # @return [Boolean]
    def drain?
      return false
    end
    # Tells if the move made contact with target
    # @return [Boolean]
    def made_contact?
      return false unless direct?
      return false if user&.has_ability?(:long_reach)
      return false if user&.hold_item?(:punching_glove) && punching?
      return true
    end
    # Get the effectiveness
    attr_reader :effectiveness
    class << self
      # Retrieve a registered move
      # @param symbol [Symbol] be_method of the move
      # @return [Class<Battle::Move>]
      def [](symbol)
        REGISTERED_MOVES[symbol]
      end
      # Register a move
      # @param symbol [Symbol] be_method of the move
      # @param klass [Class] class of the move
      def register(symbol, klass)
        raise format('%<klass>s is not a "Move" and cannot be registered', klass: klass) unless klass.ancestors.include?(Move)
        REGISTERED_MOVES[symbol] = klass
      end
    end
    # Range of the R random factor
    R_RANGE = 85..100
    # Method calculating the damages done by the actual move
    # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @note The formula is the following:
    #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
    #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
    # @return [Integer]
    def damages(user, target)
      log_data("\# damages(#{user}, #{target}) for #{db_symbol}")
      @effectiveness = 1
      @critical = logic.calc_critical_hit(user, target, critical_rate)
      log_data("@critical = #{@critical} \# critical_rate = #{critical_rate}")
      damage = user.level * 2 / 5 + 2
      log_data("damage = #{damage} \# #{user.level} * 2 / 5 + 2")
      damage = (damage * calc_base_power(user, target)).floor
      log_data("damage = #{damage} \# after calc_base_power")
      damage = (damage * calc_sp_atk(user, target)).floor / 50
      log_data("damage = #{damage} \# after calc_sp_atk / 50")
      damage = (damage / calc_sp_def(user, target)).floor
      log_data("damage = #{damage} \# after calc_sp_def")
      damage = (damage * calc_mod1(user, target)).floor + 2
      log_data("damage = #{damage} \# after calc_mod1 + 2")
      damage = (damage * calc_ch(user, target)).floor
      log_data("damage = #{damage} \# after calc_ch")
      damage = (damage * calc_mod2(user, target)).floor
      log_data("damage = #{damage} \# after calc_mod2")
      damage *= logic.move_damage_rng.rand(calc_r_range)
      damage /= 100
      log_data("damage = #{damage} \# after rng")
      types = definitive_types(user, target)
      damage = (damage * calc_stab(user, types)).floor
      log_data("damage = #{damage} \# after stab")
      damage = (damage * calc_type_n_multiplier(target, :type1, types)).floor
      log_data("damage = #{damage} \# after type1")
      damage = (damage * calc_type_n_multiplier(target, :type2, types)).floor
      log_data("damage = #{damage} \# after type2")
      damage = (damage * calc_type_n_multiplier(target, :type3, types)).floor
      log_data("damage = #{damage} \# after type3")
      damage = (damage * calc_mod3(user, target)).floor
      log_data("damage = #{damage} \# after mod3")
      target_hp = target.effects.get(:substitute).hp if target.effects.has?(:substitute) && !user.has_ability?(:infiltrator) && !authentic?
      target_hp ||= target.hp
      damage = damage.clamp(1, target_hp)
      log_data("damage = #{damage} \# after clamp")
      return damage
    end
    # Get the real base power of the move (taking in account all parameter)
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def real_base_power(user, target)
      return power
    end
    private
    # Base power calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_base_power(user, target)
      base_power = real_base_power(user, target)
      return logic.each_effects(user, target).reduce(base_power) do |product, e|
        (product * e.base_power_multiplier(user, target, self)).floor
      end
    end
    # [Spe]atk calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_sp_atk(user, target)
      ph_move = physical?
      result = calc_sp_atk_basis(user, target, ph_move)
      result = (result * calc_atk_stat_modifier(user, target, ph_move)).floor
      result = (result * calc_atk_stat_effect_modifier(user, target, ph_move)).floor
      logic.each_effects(user, target) do |e|
        result = (result * e.sp_atk_multiplier(user, target, self)).floor
      end
      return result
    end
    # Get the basis atk for the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_sp_atk_basis(user, target, ph_move)
      return ph_move ? user.atk_basis : user.ats_basis
    end
    # Statistic modifier calculation: ATK/ATS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_atk_stat_modifier(user, target, ph_move)
      modifier = ph_move ? user.atk_modifier : user.ats_modifier
      modifier = modifier > 1 ? modifier : 1 if critical_hit?
      return modifier
    end
    # Statistic effect modifier calculation: ATK/ATS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_atk_stat_effect_modifier(user, target, ph_move)
      modifier = 1
      logic.each_effects(user) do |e|
        modifier *= (ph_move ? e.atk_modifier : e.ats_modifier)
      end
      return modifier
    end
    EXPLOSION_SELF_DESTRUCT_MOVE = %i[explosion self_destruct]
    # [Spe]def calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_sp_def(user, target)
      ph_move = physical?
      result = calc_sp_def_basis(user, target, ph_move)
      result = (result * calc_def_stat_modifier(user, target, ph_move)).floor
      result = (result * calc_def_stat_effect_modifier(user, target, ph_move)).floor
      logic.each_effects(user, target) do |e|
        result = (result * e.sp_def_multiplier(user, target, self)).floor
      end
      return result
    end
    # Get the basis dfe/dfs for the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_sp_def_basis(user, target, ph_move)
      return ph_move ? target.dfe_basis : target.dfs_basis
    end
    # Statistic modifier calculation: DFE/DFS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_def_stat_modifier(user, target, ph_move)
      modifier = ph_move ? target.dfe_modifier : target.dfs_modifier
      modifier = modifier > 1 ? 1 : modifier if critical_hit?
      return modifier
    end
    # Statistic effect modifier calculation: DFE/DFS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_def_stat_effect_modifier(user, target, ph_move)
      modifier = 1
      logic.each_effects(target) do |e|
        modifier *= (ph_move ? e.dfe_modifier : e.dfs_modifier)
      end
      return modifier
    end
    # CH calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_ch(user, target)
      crit_dmg_rate = 1
      crit_dmg_rate *= 1.5 if critical_hit?
      crit_dmg_rate *= 1.5 if critical_hit? && user.has_ability?(:sniper)
      return crit_dmg_rate
    end
    # Mod1 multiplier calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod1(user, target)
      result = 1
      logic.each_effects(user, target) do |e|
        result *= e.mod1_multiplier(user, target, self)
      end
      result *= calc_mod1_tvt(target)
      return result
    end
    # Calculate the TVT mod
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod1_tvt(target)
      return 1 if one_target? || $game_temp.vs_type == 1
      if self.target == :all_foe
        count = logic.allies_of(target).size + 1
      else
        count = logic.adjacent_allies_of(target).size + 1
      end
      return count > 1 ? 0.75 : 1
    end
    # Mod2 multiplier calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod2(user, target)
      update_use_count(user)
      result = 1
      logic.each_effects(user, target) do |e|
        result *= e.mod2_multiplier(user, target, self)
      end
      return result
    end
    # Update the move use count
    # @param user [PFM::PokemonBattler] user of the move
    def update_use_count(user)
      if user.last_successful_move_is?(db_symbol)
        @consecutive_use_count += 1
      else
        @consecutive_use_count = 0
      end
    end
    # "Calc" the R range value
    # @return [Range]
    def calc_r_range
      R_RANGE
    end
    # Mod3 calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod3(user, target)
      result = 1
      logic.each_effects(user, target) do |e|
        result *= e.mod3_multiplier(user, target, self)
      end
      return result
    end
    public
    # Is the skill a specific type ?
    # @param type_id [Integer] ID of the type
    def type?(type_id)
      return type == type_id
    end
    # Is the skill typeless ?
    # @return [Boolean]
    def typeless?
      return type?(data_type(:__undef__).id)
    end
    # Is the skill type normal ?
    # @return [Boolean]
    def type_normal?
      return type?(data_type(:normal).id)
    end
    # Is the skill type fire ?
    # @return [Boolean]
    def type_fire?
      return type?(data_type(:fire).id)
    end
    alias type_feu? type_fire?
    # Is the skill type water ?
    # @return [Boolean]
    def type_water?
      return type?(data_type(:water).id)
    end
    alias type_eau? type_water?
    # Is the skill type electric ?
    # @return [Boolean]
    def type_electric?
      return type?(data_type(:electric).id)
    end
    alias type_electrique? type_electric?
    # Is the skill type grass ?
    # @return [Boolean]
    def type_grass?
      return type?(data_type(:grass).id)
    end
    alias type_plante? type_grass?
    # Is the skill type ice ?
    # @return [Boolean]
    def type_ice?
      return type?(data_type(:ice).id)
    end
    alias type_glace? type_ice?
    # Is the skill type fighting ?
    # @return [Boolean]
    def type_fighting?
      return type?(data_type(:fighting).id)
    end
    alias type_combat? type_fighting?
    # Is the skill type poison ?
    # @return [Boolean]
    def type_poison?
      return type?(data_type(:poison).id)
    end
    # Is the skill type ground ?
    # @return [Boolean]
    def type_ground?
      return type?(data_type(:ground).id)
    end
    alias type_sol? type_ground?
    # Is the skill type fly ?
    # @return [Boolean]
    def type_flying?
      return type?(data_type(:flying).id)
    end
    alias type_vol? type_flying?
    alias type_fly? type_flying?
    # Is the skill type psy ?
    # @return [Boolean]
    def type_psychic?
      return type?(data_type(:psychic).id)
    end
    alias type_psy? type_psychic?
    # Is the skill type insect/bug ?
    # @return [Boolean]
    def type_insect?
      return type?(data_type(:bug).id)
    end
    alias type_bug? type_insect?
    # Is the skill type rock ?
    # @return [Boolean]
    def type_rock?
      return type?(data_type(:rock).id)
    end
    alias type_roche? type_rock?
    # Is the skill type ghost ?
    # @return [Boolean]
    def type_ghost?
      return type?(data_type(:ghost).id)
    end
    alias type_spectre? type_ghost?
    # Is the skill type dragon ?
    # @return [Boolean]
    def type_dragon?
      return type?(data_type(:dragon).id)
    end
    # Is the skill type steel ?
    # @return [Boolean]
    def type_steel?
      return type?(data_type(:steel).id)
    end
    alias type_acier? type_steel?
    # Is the skill type dark ?
    # @return [Boolean]
    def type_dark?
      return type?(data_type(:dark).id)
    end
    alias type_tenebre? type_dark?
    # Is the skill type fairy ?
    # @return [Boolean]
    def type_fairy?
      return type?(data_type(:fairy).id)
    end
    alias type_fee? type_fairy?
    public
    # Function that calculate the type modifier (for specific uses)
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler]
    # @return [Float]
    def type_modifier(user, target)
      types = definitive_types(user, target)
      n = calc_type_n_multiplier(target, :type1, types) * calc_type_n_multiplier(target, :type2, types) * calc_type_n_multiplier(target, :type3, types)
      return n
    end
    # STAB calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param types [Array<Integer>] list of definitive types of the move
    # @return [Numeric]
    def calc_stab(user, types)
      if types.any? { |type| user.type1 == type || user.type2 == type || user.type3 == type }
        return 2 if user.has_ability?(:adaptability)
        return 1.5
      end
      return 1
    end
    # Get the types of the move with 1st type being affected by effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Array<Integer>] list of types of the move
    def definitive_types(user, target)
      type = self.type
      exec_hooks(Move, :move_type_change, binding)
      return [*type]
    ensure
      log_data(format('types = %<types>s # ie: %<ie>s', types: type.to_s, ie: [*type].map { |t| data_type(t).name }.join(', ')))
    end
    private
    # Calc TypeN multiplier of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param type_to_check [Symbol] type to check on the target
    # @param types [Array<Integer>] list of types the move has
    # @return [Numeric]
    def calc_type_n_multiplier(target, type_to_check, types)
      target_type = target.send(type_to_check)
      result = types.inject(1) { |product, type| product * calc_single_type_multiplier(target, target_type, type) }
      if @effectiveness >= 0
        @effectiveness *= result
        log_data("multiplier of #{type_to_check} (#{data_type(target_type).name}) = #{result} => new_eff = #{@effectiveness}")
      end
      return result
    end
    # Calc the single type multiplier
    # @param target [PFM::PokemonBattler] target of the move
    # @param target_type [Integer] one of the type of the target
    # @param type [Integer] one of the type of the move
    # @return [Float] definitive multiplier
    def calc_single_type_multiplier(target, target_type, type)
      exec_hooks(Move, :single_type_multiplier_overwrite, binding)
      return data_type(type).hit(data_type(target_type).db_symbol)
    rescue Hooks::ForceReturn => e
      log_data("\# calc_single_type_multiplier(#{target}, #{target_type}, #{type})")
      log_data("\# FR: calc_single_type_multiplier #{e.data} from #{e.hook_name} (#{e.reason})")
      return e.data
    end
    class << self
      # Function that registers a move_type_change hook
      # @param reason [String] reason of the move_type_change registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam target [PFM::PokemonBattler]
      # @yieldparam move [Battle::Move]
      # @yieldparam type [Integer] current type of the move
      # @yieldreturn [Integer, nil] new move type
      def register_move_type_change_hook(reason)
        Hooks.register(Move, :move_type_change, reason) do |hook_binding|
          result = yield(hook_binding.local_variable_get(:user), hook_binding.local_variable_get(:target), self, hook_binding.local_variable_get(:type))
          hook_binding.local_variable_set(:type, result) if result.is_a?(Integer)
        end
      end
      # Function that registers a single_type_multiplier_overwrite hook
      # @param reason [String] reason of the single_type_multiplier_overwrite registration
      # @yieldparam target [PFM::PokemonBattler]
      # @yieldparam target_type [Integer] one of the type of the target
      # @yieldparam type [Integer] one of the type of the move
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Float, nil] overwritten
      def register_single_type_multiplier_overwrite_hook(reason)
        Hooks.register(Move, :single_type_multiplier_overwrite, reason) do |hook_binding|
          result = yield(hook_binding.local_variable_get(:target), hook_binding.local_variable_get(:target_type), hook_binding.local_variable_get(:type), self)
          force_return(result) if result
        end
      end
    end
    Move.register_move_type_change_hook('PSDK Effect process') do |user, target, move, type|
      move.logic.each_effects(user, target) do |e|
        result = e.on_move_type_change(user, target, move, type)
        type = result if result.is_a?(Integer)
      end
      next(type)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Effect process') do |target, target_type, type, move|
      overwrite = nil
      move.logic.each_effects(target) do |e|
        next if overwrite
        result = e.on_single_type_multiplier_overwrite(target, target_type, type, move)
        overwrite = result if result
      end
      next(overwrite)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Freeze-Dry') do |_, target_type, _, move|
      next(2) if move.db_symbol == :freeze_dry && target_type == data_type(:water).id
      next(nil)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Thousand Arrows') do |target, _, _, move|
      next unless move.db_symbol == :thousand_arrows
      next if target.grounded?
      next unless target.type_flying?
      next(1)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Force Flying') do |target, _, type, move|
      next if target.grounded? || type != data_type(:ground).id || move.db_symbol == :thousand_arrows
      is_flying_type = target.type_flying?
      is_flying_item = target.hold_item?(:air_balloon)
      is_flying_ability = target.has_ability?(:levitate) && move&.user&.can_be_lowered_or_canceled?
      is_flying_effects = target.effects.has? { |effect| %i[magnet_rise telekinesis].include?(effect.name) }
      next unless is_flying_type || is_flying_item || is_flying_ability || is_flying_effects
      next(0)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Force Grounded') do |target, target_type, type|
      next unless target.grounded? || type == data_type(:ground).id
      next unless target_type == data_type(:flying).id
      next(1)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Ability: Scrappy Effect') do |_, target_type, type, move|
      next if target_type != data_type(:ghost).id
      next unless %i[normal fighting].include?(data_type(type).db_symbol)
      next unless %i[scrappy mind_s_eye].include?(move&.user&.battle_ability_db_symbol)
      next(1)
    end
    public
    # Return the chance of hit of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Float]
    def chance_of_hit(user, target)
      log_data("\# chance_of_hit(#{user}, #{target}) for #{db_symbol}")
      if bypass_chance_of_hit?(user, target)
        log_data('# chance_of_hit: bypassed')
        return 100
      end
      factor = logic.each_effects(user, target).reduce(1) { |product, e| product * e.chance_of_hit_multiplier(user, target, self) }
      factor *= accuracy_mod(user)
      factor *= evasion_mod(target)
      log_data("result = #{factor * accuracy}")
      return factor * accuracy
    end
    # Check if the move bypass chance of hit and cannot fail
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Boolean]
    def bypass_chance_of_hit?(user, target)
      return true if (status? && target == user) || accuracy <= 0
      return true if user.has_ability?(:no_guard) || target.has_ability?(:no_guard)
      return true if user.effects.get(:lock_on)&.target == target
      return true if target.effects.has?(:glaive_rush)
      return true if target.effects.has?(:telekinesis) && !ohko?
      return true if db_symbol == :toxic && user.type_poison?
      return true if db_symbol == :blizzard && $env.hail?
      return false
    end
    # Return the accuracy modifier of the user
    # @param user [PFM::PokemonBattler]
    # @return [Float]
    def accuracy_mod(user)
      return user.stat_multiplier_acceva(user.acc_stage)
    end
    # Return the evasion modifier of the target
    # @param target [PFM::PokemonBattler]
    # @return [Float]
    def evasion_mod(target)
      return target.stat_multiplier_acceva(-target.eva_stage)
    end
    public
    # List of symbol describe a one target aim
    OneTarget = %i[any_other_pokemon random_foe adjacent_pokemon adjacent_foe user user_or_adjacent_ally adjacent_ally]
    # List of symbol that doesn't show any choice of target
    TargetNoAsk = %i[adjacent_all_foe all_foe adjacent_all_pokemon all_pokemon user all_ally all_ally_but_user random_foe]
    # Does the skill aim only one Pokemon
    # @return [Boolean]
    def one_target?
      return OneTarget.include?(target)
    end
    alias is_one_target? one_target?
    # Check if an attack that targets multiple people is targeting only one
    # @param user [PFM::PokemonBattler] user of the move
    # @return [Boolean]
    def one_target_from_zone_attack(user)
      return battler_targets(user, logic).length == 1
    end
    # Does the skill doesn't show a target choice
    # @return [Boolean]
    def no_choice_skill?
      return TargetNoAsk.include?(target)
    end
    alias is_no_choice_skill? no_choice_skill?
    alias affects_bank? void_false
    # List the targets of this move
    # @param pokemon [PFM::PokemonBattler] the Pokemon using the move
    # @param logic [Battle::Logic] the battle logic allowing to find the targets
    # @return [Array<PFM::PokemonBattler>] the possible targets
    # @note use one_target? to select the target inside the possible result
    def battler_targets(pokemon, logic)
      case target
      when :adjacent_pokemon, :adjacent_all_pokemon
        return logic.adjacent_foes_of(pokemon).concat(logic.adjacent_allies_of(pokemon))
      when :adjacent_foe, :adjacent_all_foe
        return logic.adjacent_foes_of(pokemon)
      when :all_foe, :random_foe
        return logic.foes_of(pokemon)
      when :all_pokemon
        return logic.foes_of(pokemon).concat(logic.allies_of(pokemon)) << pokemon
      when :user
        return [pokemon]
      when :user_or_adjacent_ally
        return [pokemon].concat(logic.adjacent_allies_of(pokemon))
      when :adjacent_ally
        return logic.allies_of(pokemon)
      when :all_ally
        return [pokemon].concat(logic.allies_of(pokemon))
      when :all_ally_but_user
        return logic.allies_of(pokemon)
      when :any_other_pokemon
        return logic.foes_of(pokemon).concat(logic.allies_of(pokemon))
      end
      return [pokemon]
    end
    public
    # Tell if forced next move decreases PP
    # @return [Boolean]
    attr_accessor :forced_next_move_decrease_pp
    # Show the effectiveness message
    # @param effectiveness [Numeric]
    # @param target [PFM::PokemonBattler]
    def efficent_message(effectiveness, target)
      if effectiveness > 1
        scene.display_message_and_wait(parse_text_with_pokemon(19, 6, target))
      else
        if effectiveness > 0 && effectiveness < 1
          scene.display_message_and_wait(parse_text_with_pokemon(19, 15, target))
        end
      end
    end
    # Show the usage failure when move is not usable by user
    # @param user [PFM::PokemonBattler] user of the move
    def show_usage_failure(user)
      usage_message(user)
      scene.display_message_and_wait(parse_text(18, 74))
    end
    # Function starting the move procedure
    # @param user [PFM::PokemonBattler] user of the move
    # @param target_bank [Integer] bank of the target
    # @param target_position [Integer]
    def proceed(user, target_bank, target_position)
      return if user.hp <= 0
      @user = user
      @damage_dealt = 0
      possible_targets = battler_targets(user, logic).select { |target| target&.alive? }
      possible_targets.sort_by(&:spd)
      return proceed_one_target(user, possible_targets, target_bank, target_position) if one_target?
      possible_targets.reverse!
      possible_targets.select! { |pokemon| pokemon.bank == target_bank } unless no_choice_skill?
      specific_procedure = check_specific_procedure(user, possible_targets)
      return send(specific_procedure, user, possible_targets) if specific_procedure
      return proceed_internal(user, possible_targets)
    end
    # Proceed the procedure before any other attack.
    # @param user [PFM::PokemonBattler]
    def proceed_pre_attack(user)
      nil && user
    end
    private
    # Function starting the move procedure for 1 target
    # @param user [PFM::PokemonBattler] user of the move
    # @param possible_targets [Array<PFM::PokemonBattler>] expected targets
    # @param target_bank [Integer] bank of the target
    # @param target_position [Integer]
    def proceed_one_target(user, possible_targets, target_bank, target_position)
      right_target = possible_targets.find { |pokemon| pokemon.bank == target_bank && pokemon.position == target_position }
      right_target ||= possible_targets.find { |pokemon| pokemon.bank == target_bank && (pokemon.position - target_position).abs == 1 }
      right_target ||= possible_targets.find { |pokemon| pokemon.bank == target_bank }
      right_target = target_redirected(user, right_target)
      specific_procedure = check_specific_procedure(user, [right_target].compact)
      return send(specific_procedure, user, [right_target].compact) if specific_procedure
      return proceed_internal(user, [right_target].compact)
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal(user, targets)
      return user.add_move_to_history(self, targets) unless (actual_targets = proceed_internal_precheck(user, targets))
      post_accuracy_check_effects(user, actual_targets)
      post_accuracy_check_move(user, actual_targets)
      play_animation(user, targets)
      deal_damage(user, actual_targets) && effect_working?(user, actual_targets) && deal_status(user, actual_targets) && deal_stats(user, actual_targets) && deal_effect(user, actual_targets)
      user.add_move_to_history(self, actual_targets)
      user.add_successful_move_to_history(self, actual_targets)
      @scene.visual.set_info_state(:move_animation)
      @scene.visual.wait_for_animation
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array<PFM::PokemonBattler, nil] list of the right target to the move if success
    # @note this function is responsive of calling on_move_failure and checking all the things related to target/user in regard of move usability
    # @note it is forbiden to change anything in this function if you don't know what you're doing, the && and || are not ther because it's cute
    def proceed_internal_precheck(user, targets)
      return unless move_usable_by_user(user, targets) || (on_move_failure(user, targets, :usable_by_user) && false)
      usage_message(user)
      pre_accuracy_check_effects(user, targets)
      return scene.display_message_and_wait(parse_text(18, 106)) if targets.all?(&:dead?) && (on_move_failure(user, targets, :no_target) || true)
      if pp == 0 && !(user.effects.has?(&:force_next_move?) && !@forced_next_move_decrease_pp)
        return (scene.display_message_and_wait(parse_text(18, 85)) || true) && on_move_failure(user, targets, :pp) && nil
      end
      decrease_pp(user, targets)
      return unless !(actual_targets = proceed_move_accuracy(user, targets)).empty? || (on_move_failure(user, targets, :accuracy) && false)
      user, actual_targets = proceed_battlers_remap(user, actual_targets)
      actual_targets = accuracy_immunity_test(user, actual_targets)
      return if actual_targets.none? && (on_move_failure(user, targets, :immunity) || true)
      return actual_targets
    end
    # Test move accuracy
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array] the actual targets
    def proceed_move_accuracy(user, targets)
      if bypass_accuracy?(user, targets)
        log_data('# proceed_move_accuracy: bypassed')
        return targets
      end
      return targets.select do |target|
        accuracy_dice = logic.move_accuracy_rng.rand(100)
        hit_chance = chance_of_hit(user, target)
        log_data("\# target= #{target}, \# accuracy= #{hit_chance}, value = #{accuracy_dice} (testing=#{hit_chance > 0}, failure=#{accuracy_dice >= hit_chance})")
        if accuracy_dice >= hit_chance
          text = hit_chance > 0 ? 213 : 24
          scene.display_message_and_wait(parse_text_with_pokemon(19, text, target))
          next(false)
        end
        next(true)
      end
    end
    # Tell if the move accuracy is bypassed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Boolean]
    def bypass_accuracy?(user, targets)
      if targets.all? { |target| user.effects.get(:lock_on)&.target == target }
        log_data('# accuracy= 100 (:lock_on effect)')
        return true
      end
      return true if user.has_ability?(:no_guard) || targets.any? { |target| target.has_ability?(:no_guard) }
      return true if db_symbol == :blizzard && $env.hail?
      return true if accuracy <= 0
      return false
    end
    # Show the move usage message
    # @param user [PFM::PokemonBattler] user of the move
    def usage_message(user)
      @scene.visual.hide_team_info
      message = parse_text_with_pokemon(8999 - Studio::Text::CSV_BASE, 12, user, PFM::Text::PKNAME[0] => user.given_name, PFM::Text::MOVE[0] => name)
      scene.display_message_and_wait(message)
      PFM::Text.reset_variables
    end
    # Method that remap user and targets if needed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [PFM::PokemonBattler, Array<PFM::PokemonBattler>] user, targets
    def proceed_battlers_remap(user, targets)
      if snatchable? && logic.all_alive_battlers.any? { |pkm| pkm != user && pkm.effects.has?(:snatch) }
        snatcher = logic.all_alive_battlers.max_by { |pkm| pkm != user && pkm.effects.has?(:snatch) ? pkm.spd : -1 }
        snatcher.effects.get(:snatch).kill
        user.effects.add(Effects::Snatched.new(logic, user))
        logic.scene.display_message_and_wait(parse_text_with_2pokemon(19, 754, snatcher, user))
        return snatcher, [snatcher]
      end
      return user, targets
    end
    # Method responsive testing accuracy and immunity.
    # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array<PFM::PokemonBattler>]
    def accuracy_immunity_test(user, targets)
      return targets.select do |pokemon|
        if target_immune?(user, pokemon)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 210, pokemon))
          next(false)
        else
          if move_blocked_by_target?(user, pokemon)
            next(false)
          end
        end
        next(true)
      end
    end
    # Test if the target is immune
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def target_immune?(user, target)
      return true if prankster_immunity?(user, target)
      return true if powder? && target.type_grass? && user != target
      return true if user != target && ability_immunity?(user, target)
      return false if status?
      types = definitive_types(user, target)
      @effectiveness = -1
      return calc_type_n_multiplier(target, :type1, types) == 0 || calc_type_n_multiplier(target, :type2, types) == 0 || calc_type_n_multiplier(target, :type3, types) == 0
    end
    # Test if the target has an immunity due to the type of move & ability
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def ability_immunity?(user, target)
      logic.each_effects(target) do |e|
        return true if e.on_move_ability_immunity(user, target, self)
      end
      return false
    end
    # Test if the target has an immunity to the Prankster ability due to its type
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def prankster_immunity?(user, target)
      return false if user.bank == target.bank
      return false unless target.type_dark?
      return false unless user.ability_effect.db_symbol == :prankster
      return user.ability_effect.on_move_priority_change(user, 1, self) == 2
    end
    # Calls the pre_accuracy_check method for each effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def pre_accuracy_check_effects(user, targets)
      creatures = [user] + targets
      logic.each_effects(*creatures) do |e|
        e.on_pre_accuracy_check(logic, scene, targets, user, self)
      end
    end
    # Calls the post_accuracy_check method for each effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] expected targets
    def post_accuracy_check_effects(user, actual_targets)
      creatures = [user] + actual_targets
      logic.each_effects(*creatures) do |e|
        e.on_post_accuracy_check(logic, scene, actual_targets, user, self)
      end
    end
    # Decrease the PP of the move
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def decrease_pp(user, targets)
      return if user.effects.has?(&:force_next_move?) && !@forced_next_move_decrease_pp
      self.pp -= 1
      self.pp -= 1 if @logic.foes_of(user).any? { |foe| foe.alive? && foe.has_ability?(:pressure) }
    end
    # Function which permit things to happen before the move's animation
    def post_accuracy_check_move(user, actual_targets)
      return true
    end
    # Play the move animation
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def play_animation(user, targets)
      play_substitute_swap_animation(user)
      return unless $options.show_animation
      @scene.visual.set_info_state(:move_animation)
      @scene.visual.wait_for_animation
      play_animation_internal(user, targets)
      @scene.visual.set_info_state(:move, targets + [user])
      @scene.visual.wait_for_animation
    end
    # Play the move animation when having substitute
    # @param user [PFM::PokemonBattler] user of the move
    def play_substitute_swap_animation(user)
      return unless user.effects.has?(:substitute)
      return if user.effects.has?(:out_of_reach_base)
      user.effects.get(:substitute).play_substitute_animation(:from)
    end
    # Play the move animation (only without all the decoration)
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def play_animation_internal(user, targets)
      animations = MoveAnimation.get(self, :first_use)
      if animations
        MoveAnimation.play(animations, @scene.visual, user, targets)
      else
        @scene.visual.show_move_animation(user, targets, self)
      end
    end
    # Function that deals the damage to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_damage(user, actual_targets)
      return true
    end
    # Function applying recoil damage to the user
    # @param hp [Integer]
    # @param user [PFM::PokemonBattler]
    def recoil(hp, user)
      return false if user.has_ability?(:rock_head) && !%i[struggle shadow_rush shadow_end].include?(db_symbol)
      return special_recoil(hp, user) if user.has_ability?(:parental_bond)
      @logic.damage_handler.damage_change((hp / recoil_factor).to_i.clamp(1, Float::INFINITY), user)
      @scene.display_message_and_wait(parse_text_with_pokemon(19, 378, user))
    end
    # Function applying recoil damage to the user
    # @note Only for Parental Bond !!
    # @param hp [Integer]
    # @param user [PFM::PokemonBattler]
    def special_recoil(hp, user)
      if user.ability_effect.first_turn_recoil == 0
        user.ability_effect.first_turn_recoil = hp
        return false
      end
      hp += user.ability_effect.first_turn_recoil
      user.ability_effect.first_turn_recoil = 0
      @logic.damage_handler.damage_change((hp / recoil_factor).to_i.clamp(1, Float::INFINITY), user)
      @scene.display_message_and_wait(parse_text_with_pokemon(19, 378, user))
    end
    # Test if the effect is working
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    # @return [Boolean]
    def effect_working?(user, actual_targets)
      exec_hooks(Move, :effect_working, binding)
      return true
    end
    # Function that deals the status condition to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_status(user, actual_targets)
      return true if status_effects.empty?
      dice = @logic.generic_rng.rand(0...100)
      status = status_effects.find do |status_effect|
        next(true) if status_effect.luck_rate > dice
        dice -= status_effect.luck_rate
        next(false)
      end || status_effects[0]
      actual_targets.each do |target|
        @logic.status_change_handler.status_change_with_process(status.status, target, user, self)
      end
      return true
    end
    # Function that deals the stat to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_stats(user, actual_targets)
      return true if battle_stage_mod.empty?
      actual_targets.each do |target|
        battle_stage_mod.each do |stage|
          next if stage.count == 0
          @logic.stat_change_handler.stat_change_with_process(stage.stat, stage.count, target, user, self)
        end
      end
      return true
    end
    # Function that deals the effect to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_effect(user, actual_targets)
      return true
    end
    # Event called if the move failed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
    def on_move_failure(user, targets, reason)
      return false
    end
    # Function that execute another move (Sleep Talk, Metronome)
    # @param move [Battle::Move] has to be cloned before calling the method
    # @param target_bank [Integer]
    # @param target_position [Integer]
    def use_another_move(move, user, target_bank = nil, target_position = nil)
      if target_bank.nil? || target_position.nil?
        targets = move.battler_targets(user, @logic)
        if targets.any? { |target| target.bank != user.bank }
          choosen_target = targets.reject { |target| target.bank == user.bank }.first
        else
          choosen_target = targets.first
        end
        target_bank = choosen_target.bank
        target_position = choosen_target.position
      end
      action = Actions::Attack.new(@scene, move, user, target_bank, target_position)
      action.execute
    end
    # Return the new target if redirected or the initial target
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [PFM::PokemonBattler] the target
    def target_redirected(user, targets)
      logic.each_effects(*logic.adjacent_foes_of(user)) do |e|
        new_target = e.target_redirection(user, targets, self)
        return new_target if new_target
      end
      return targets
    end
    public
    # Check if an Effects imposes a specific proceed_internal
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Symbol, nil] the symbol of the proceed_internal to call, nil if no specific procedure
    def check_specific_procedure(user, targets)
      logic.each_effects(user) do |e|
        specific_procedure = e.specific_proceed_internal(user, targets, self)
        return specific_procedure if specific_procedure
      end
      return nil
    end
    # Internal procedure of the move for Parental Bond Ability
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal_parental_bond(user, targets)
      return user.add_move_to_history(self, targets) unless (actual_targets = proceed_internal_precheck(user, targets))
      post_accuracy_check_effects(user, actual_targets)
      post_accuracy_check_move(user, actual_targets)
      play_animation(user, targets)
      nb_loop = user.ability_effect&.number_of_attacks || 1
      nb_loop.times do |nb_attack|
        next unless nb_attack == 0 || ((one_target_from_zone_attack(user) || one_target?) && !multi_hit? && !status?)
        next(@scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => nb_attack.to_s))) if targets.any?(&:dead?)
        if nb_attack >= 1
          user.ability_effect&.activated = true
          scene.visual.show_ability(user)
        end
        user.ability_effect.attack_number = nb_attack
        deal_damage(user, actual_targets) && effect_working?(user, actual_targets) && deal_status(user, actual_targets) && deal_stats(user, actual_targets) && (user.ability_effect&.first_effect_can_be_applied?(be_method) || nb_attack > 0) && deal_effect(user, actual_targets)
      end
      @scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => nb_loop.to_s)) if user.ability_effect&.activated
      user.ability_effect&.activated = false
      user.add_move_to_history(self, actual_targets)
      user.add_successful_move_to_history(self, actual_targets)
      @scene.visual.set_info_state(:move_animation)
      @scene.visual.wait_for_animation
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal_dancer(user, targets)
      proceed_internal(user, targets)
      last_move = user.move_history.last
      last_successful_move = user.successful_move_history&.last
      user.move_history.pop if last_move.move == self && last_move.current_turn?
      user.successful_move_history.pop if last_successful_move&.move == self && last_successful_move.current_turn?
    end
    public
    # Function that tests if the user is able to use the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
    # @return [Boolean] if the procedure can continue
    def move_usable_by_user(user, targets)
      log_data("\# move_usable_by_user(#{user}, #{targets})")
      PFM::Text.set_variable(PFM::Text::PKNICK[0], user.given_name)
      PFM::Text.set_variable(PFM::Text::MOVE[1], name)
      exec_hooks(Move, :move_prevention_user, binding)
      return true
    rescue Hooks::ForceReturn => e
      log_data("\# FR: move_usable_by_user #{e.data} from #{e.hook_name} (#{e.reason})")
      return e.data
    ensure
      PFM::Text.reset_variables
    end
    # Function that tells if the move is disabled
    # @param user [PFM::PokemonBattler] user of the move
    # @return [Boolean]
    def disabled?(user)
      disable_reason(user) ? true : false
    end
    # Get the reason why the move is disabled
    # @param user [PFM::PokemonBattler] user of the move
    # @return [#call] Block that should be called when the move is disabled
    def disable_reason(user)
      return proc { } if pp == 0
      exec_hooks(Move, :move_disabled_check, binding)
      return nil
    rescue Hooks::ForceReturn => e
      log_data("\# disable_reason(#{user})")
      log_data("\# FR: disable_reason #{e.data} from #{e.hook_name} (#{e.reason})")
      return e.data
    end
    # Function that tests if the targets blocks the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] expected target
    # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
    # @return [Boolean] if the target evade the move (and is not selected)
    def move_blocked_by_target?(user, target)
      log_data("\# move_blocked_by_target?(#{user}, #{target})")
      exec_hooks(Move, :move_prevention_target, binding) if user != target
      return false
    rescue Hooks::ForceReturn => e
      log_data("\# FR: move_blocked_by_target? #{e.data} from #{e.hook_name} (#{e.reason})")
      return e.data
    end
    # Detect if the move is protected by another move on target
    # @param target [PFM::PokemonBattler]
    # @param symbol [Symbol]
    def blocked_by?(target, symbol)
      return blocable? && target.effects.has?(:protect) && target.last_successful_move_is?(symbol)
    end
    class << self
      # Function that registers a move_prevention_user hook
      # @param reason [String] reason of the move_prevention_user registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam targets [Array<PFM::PokemonBattler>]
      # @yieldparam move [Battle::Move]
      # @yieldreturn [:prevent, nil] :prevent if the move cannot continue
      def register_move_prevention_user_hook(reason)
        Hooks.register(Move, :move_prevention_user, reason) do |hook_binding|
          force_return(false) if yield(hook_binding.local_variable_get(:user), hook_binding.local_variable_get(:targets), self) == :prevent
        end
      end
      # Function that registers a move_disabled_check hook
      # @param reason [String] reason of the move_disabled_check registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Proc, nil] the code to execute if the move is disabled
      def register_move_disabled_check_hook(reason)
        Hooks.register(Move, :move_disabled_check, reason) do |hook_binding|
          result = yield(hook_binding.local_variable_get(:user), self)
          force_return(result) if result.respond_to?(:call)
        end
      end
      # Function that registers a move_prevention_target hook
      # @param reason [String] reason of the move_prevention_target registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam target [PFM::PokemonBattler] expected target
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Boolean] if the target is evading the move
      def register_move_prevention_target_hook(reason)
        Hooks.register(Move, :move_prevention_target, reason) do |hook_binding|
          force_return(true) if yield(hook_binding.local_variable_get(:user), hook_binding.local_variable_get(:target), self)
        end
      end
    end
    public
    module Mechanics
      # Preset used for counter attacks
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - counter_fails?(attacker, user, targets)
      module Counter
        # Function that tests if the user is able to use the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
        # @return [Boolean] if the procedure can continue
        def move_usable_by_user(user, targets)
          return false unless super
          return show_usage_failure(user) && false if counter_fails?(last_attacker(user), user, targets)
          return true
        end
        alias counter_move_usable_by_user move_usable_by_user
        # Method calculating the damages done by counter
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Integer]
        def damages(user, target)
          @effectiveness = 1
          @critical = false
          return 1 unless (attacker = last_attacker(user))
          log_data("damages = #{(attacker.move_history.last.move.damage_dealt * damage_multiplier).floor.clamp(1, target.hp)} \# after counter")
          return (attacker.move_history.last.move.damage_dealt * damage_multiplier).floor.clamp(1, target.hp)
        end
        alias counter_damages damages
        private
        # Test if the attack fails
        # @param attacker [PFM::PokemonBattler] the last attacker
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean] does the attack fails ?
        def counter_fails?(attacker, user, targets)
          log_error("#{self.class} should overwrite #{__method__}")
          return false
        end
        # Damage multiplier if the effect proc
        # @return [Integer, Float]
        def damage_multiplier
          2
        end
        # Method responsive testing accuracy and immunity.
        # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<PFM::PokemonBattler>]
        def accuracy_immunity_test(user, targets)
          super(user, [last_attacker(user)].compact)
        end
        alias counter_accuracy_immunity_test accuracy_immunity_test
        # Get the last pokemon that used a skill over the user
        # @param user [PFM::PokemonBattler]
        # @return [PFM::PokemonBattler, nil]
        def last_attacker(user)
          foes = logic.foes_of(user).sort { |a, b| b.attack_order <=> a.attack_order }
          attacker = foes.find { |foe| foe.move_history&.last&.targets&.include?(user) && foe.move_history.last.turn == $game_temp.battle_turn }
          return attacker
        end
        alias counter_last_attacker last_attacker
      end
      # Preset used for item based attacks
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      module ItemBased
        # Function that tests if the user is able to use the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
        # @return [Boolean] if the procedure can continue
        def move_usable_by_user(user, targets)
          return false unless super
          return show_usage_failure(user) && false unless valid_held_item?(user.item_db_symbol)
          return true
        end
        alias item_based_move_usable_by_user move_usable_by_user
        private
        # Method calculating the damages done by the actual move
        # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @note The formula is the following:
        #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
        #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
        # @return [Integer]
        def damages(user, target)
          power = super
          consume_item(user)
          return power
        end
        alias item_based_damages damages
        # Remove the item from the battler
        # @param battler [PFM::PokemonBattler]
        def consume_item(battler)
          return unless consume_item?
          return if battler.has_ability?(:parental_bond) && battler.ability_effect.number_of_attacks - battler.ability_effect.attack_number == 1
          @thrown_item_effect = battler.item_effect
          @logic.item_change_handler.change_item(:none, true, battler, battler, self)
        end
        # Tell if the move consume the item
        # @return [Boolean]
        def consume_item?
          log_error("#{__method__} should be overwritten by #{self.class}")
          return false
        end
        # Test if the held item is valid
        # @param name [Symbol]
        # @return [Boolean]
        def valid_held_item?(name)
          log_error("#{__method__} should be overwritten by #{self.class}")
          return false
        end
      end
      # Preset used for attacks with power based on held item.
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      # - private get_power_by_item
      module PowerBasedOnItem
        include ItemBased
        # Get the real base power of the move (taking in account all parameter)
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Integer]
        def real_base_power(user, target)
          return super unless valid_held_item?(user.item_db_symbol)
          log_data("power = #{get_power_by_item(user.item_db_symbol)} \# move based on held item")
          return get_power_by_item(user.item_db_symbol)
        end
        alias power_based_on_item_real_base_power real_base_power
        private
        # Get the real power of the move depending on the item
        # @param name [Symbol]
        # @return [Integer]
        def get_power_by_item(name)
          log_error("#{__method__} should be overwritten by #{self.class}")
          return 0
        end
      end
      # Preset used for attacks with power based on held item.
      # Should be included only in a Battle::Move class or a class with the same interface
      # The includer must overwrite the following methods:
      # - private consume_item?
      # - private valid_item_hold?
      # - private get_types_by_item
      module TypesBasedOnItem
        include ItemBased
        # Get the types of the move with 1st type being affected by effects
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Array<Integer>] list of types of the move
        def definitive_types(user, target)
          return super unless valid_held_item?(user.item_db_symbol)
          log_data("types = #{get_types_by_item(user.item_db_symbol)} \# move based on held item")
          return get_types_by_item(user.item_db_symbol)
        end
        alias types_based_on_item_definitive_types definitive_types
        private
        # Get the real types of the move depending on the item
        # @param name [Symbol]
        # @return [Array<Integer>]
        def get_types_by_item(name)
          log_error("#{__method__} should be overwritten by #{self.class}")
          return []
        end
      end
      # Move based on the location type
      #
      # **REQUIREMENTS**
      # - define element_table
      module LocationBased
        # Function that tests if the targets blocks the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] expected target
        # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
        # @return [Boolean] if the target evade the move (and is not selected)
        def move_blocked_by_target?(user, target)
          return super || element_by_location.nil?
        end
        alias lb_move_blocked_by_target? move_blocked_by_target?
        private
        # Return the current location type
        # @return [Symbol]
        def location_type
          return logic.field_terrain_effect.db_symbol unless logic.field_terrain_effect.none?
          return $game_map.location_type($game_player.x, $game_player.y)
        end
        # Find the element using the given location using randomness.
        # @return [object, nil]
        def element_by_location
          element_table[location_type]&.sample(random: logic.generic_rng)
        end
        # Element by location type.
        # @return [Hash<Symbol, Array<Symbol>]
        def element_table
          log_error("#{__method__} should be overwritten by #{self.class}.")
          {}
        end
      end
      # Move that takes two turns
      #
      # **REQUIREMENTS**
      # None
      module TwoTurn
        private
        # Internal procedure of the move
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @note If you are interrupted (see: interrupted?), we must reset @turn; otherwise,
        #       we will proceed to phase 2 the next time we make a move in two turns.
        def proceed_internal(user, targets)
          @turn = nil unless user.effects.has?(&:force_next_move?)
          unless move_usable_by_user(user, targets) || (on_move_failure(user, targets, :usable_by_user) && false)
            kill_turn1_effects(user)
            user.add_move_to_history(self, targets)
            return nil
          end
          usage_message(user)
          if targets.all?(&:dead?) && (on_move_failure(user, targets, :no_target) || true)
            kill_turn1_effects(user)
            scene.display_message_and_wait(parse_text(18, 106))
            user.add_move_to_history(self, targets)
            return nil
          end
          if pp == 0 && !(user.effects.has?(&:force_next_move?) && !@forced_next_move_decrease_pp)
            kill_turn1_effects(user)
            (scene.display_message_and_wait(parse_text(18, 85)) || true) && on_move_failure(user, targets, :pp)
            user.add_move_to_history(self, targets)
            return nil
          end
          @turn = (@turn || 0) + 1
          if @turn == 1
            decrease_pp(user, targets)
            play_animation_turn1(user, targets)
            proceed_message_turn1(user, targets)
            deal_effects_turn1(user, targets)
            @scene.visual.set_info_state(:move_animation)
            @scene.visual.wait_for_animation
            return prepare_turn2(user, targets) unless shortcut?(user, targets)
            @turn += 1
          end
          if @turn >= 2
            @turn = nil
            execution_turn(user, targets)
          end
        end
        # TwoTurn Move execution procedure
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def execution_turn(user, targets)
          unless !(actual_targets = proceed_move_accuracy(user, targets)).empty? || (on_move_failure(user, targets, :accuracy) && false)
            kill_turn1_effects(user)
            user.add_move_to_history(self, targets)
            return nil
          end
          user, actual_targets = proceed_battlers_remap(user, actual_targets)
          actual_targets = accuracy_immunity_test(user, actual_targets)
          if actual_targets.none? && (on_move_failure(user, targets, :immunity) || true)
            kill_turn1_effects(user)
            user.add_move_to_history(self, actual_targets)
            return nil
          end
          post_accuracy_check_effects(user, actual_targets)
          post_accuracy_check_move(user, actual_targets)
          play_animation(user, targets)
          kill_turn1_effects(user)
          deal_damage(user, actual_targets) && effect_working?(user, actual_targets) && deal_status(user, actual_targets) && deal_stats(user, actual_targets) && deal_effect(user, actual_targets)
          user.add_move_to_history(self, actual_targets)
          user.add_successful_move_to_history(self, actual_targets)
          @scene.visual.set_info_state(:move_animation)
          @scene.visual.wait_for_animation
        end
        # Check if the two turn move is executed in one turn
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean]
        def shortcut?(user, targets)
          @logic.each_effects(user) do |effect|
            return true if effect.on_two_turn_shortcut(user, targets, self)
          end
          return false
        end
        alias two_turns_shortcut? shortcut?
        # Add the effects to the pokemons (first turn)
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def deal_effects_turn1(user, targets)
          stat_changes_turn1(user, targets)&.each do |(stat, value)|
            @logic.stat_change_handler.stat_change_with_process(stat, value, user)
          end
        end
        alias two_turn_deal_effects_turn1 deal_effects_turn1
        # Give the force next move and other effects
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def prepare_turn2(user, targets)
          user.effects.add(Effects::ForceNextMoveBase.new(@logic, user, self, targets, turn_count))
          user.effects.add(Effects::OutOfReachBase.new(@logic, user, self, can_hit_moves)) if can_hit_moves
        end
        alias two_turn_prepare_turn2 prepare_turn2
        # Remove effects from the first turn
        # @param user [PFM::PokemonBattler]
        def kill_turn1_effects(user)
          user.effects.get(&:force_next_move?).kill if user.effects.has?(&:force_next_move?)
          user.effects.get(&:out_of_reach?).kill if user.effects.has?(&:out_of_reach?)
        end
        alias two_turn_kill_turn1_effects kill_turn1_effects
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def proceed_message_turn1(user, targets)
          nil
        end
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def play_animation_turn1(user, targets)
          play_substitute_swap_animation(user)
          return unless $options.show_animation
        end
        # Return the stat changes for the user
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<Array<[Symbol, Integer]>>] exemple : [[:dfe, -1], [:atk, 1]]
        def stat_changes_turn1(user, targets)
          nil
        end
        # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
        # @return [Array<Symbol>]
        def can_hit_moves
          nil
        end
        # Return the number of turns the effect works
        # @return Integer
        def turn_count
          return 2
        end
      end
    end
    public
    public
    public
    public
    # Class describing a basic move (damage + potential status + potential stat)
    class Basic < Move
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return true if status?
        raise 'Badly configured move, it should have positive power' if power < 0
        successful_damages = actual_targets.map do |target|
          hp = damages(user, target)
          damage_handler = @logic.damage_handler
          damage_handler.damage_change_with_process(hp, target, user, self) do
            scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target)) if critical_hit?
            efficent_message(effectiveness, target) if hp > 0
          end
          recoil(hp, user) if recoil? && damage_handler.instance_variable_get(:@reason).nil?
          next(false) if damage_handler.instance_variable_get(:@reason)
          next(true)
        end
        new_targets = actual_targets.map.with_index { |target, index| successful_damages[index] && target }.select { |target| target }
        actual_targets.clear.concat(new_targets)
        return successful_damages.include?(true)
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        n = 1
        scene.logic.each_effects(user).each do |e|
          n *= e.effect_chance_modifier(self)
        end
        return bchance?((effect_chance * n) / 100.0) && super
      end
    end
    # Class describing a basic move (damage + status + stat = garanteed)
    class BasicWithSuccessfulEffect < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        exec_hooks(Move, :effect_working, binding)
        return true
      end
    end
    Move.register(:s_basic, Basic)
    public
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class SelfStat < Basic
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        super(user, [user])
      end
    end
    # Class describing a self status move (damage + potential status + potential stat to user)
    class SelfStatus < Basic
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
        super(user, [user])
      end
    end
    Move.register(:s_self_stat, SelfStat)
    Move.register(:s_self_status, SelfStatus)
    public
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class StatusStat < Move
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        log_error 'Stat and Status move should not get power' if power > 0
        log_error 'Stat and Status move ignore effect chance!' if effect_chance.to_i.between?(1, 99)
        return true
      end
    end
    Move.register(:s_stat, StatusStat)
    Move.register(:s_status, StatusStat)
    public
    # Class describing a move hiting multiple time
    class MultiHit < Basic
      # Number of hit randomly picked from that array
      MULTI_HIT_CHANCES = [2, 2, 2, 3, 3, 5, 4, 3]
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        @user = user
        @actual_targets = actual_targets
        @nb_hit = 0
        @hit_amount = hit_amount(user, actual_targets)
        @hit_amount.times.count do |i|
          next(false) unless actual_targets.all?(&:alive?)
          next(false) if user.dead?
          @nb_hit += 1
          play_animation(user, actual_targets) if i > 0
          actual_targets.each do |target|
            hp = damages(user, target)
            @logic.damage_handler.damage_change_with_process(hp, target, user, self) do
              if critical_hit?
                scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
              else
                if hp > 0 && i == @hit_amount - 1
                  efficent_message(effectiveness, target)
                end
              end
            end
            recoil(hp, user) if recoil?
          end
          next(true)
        end
        @scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => @nb_hit.to_s))
        return false if user.dead?
        return true
      end
      # Check if this the last hit of the move
      # Don't call this method before deal_damage method call
      # @return [Boolean]
      def last_hit?
        return true if @user.dead?
        return true unless @actual_targets.all?(&:alive?)
        return @hit_amount == @nb_hit
      end
      # Tells if the move hits multiple times
      # @return [Boolean]
      def multi_hit?
        return true
      end
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
        return 5 if user.has_ability?(:skill_link)
        return MULTI_HIT_CHANCES.sample(random: @logic.generic_rng)
      end
    end
    # Class describing a move hitting twice
    class TwoHit < MultiHit
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
        return 2
      end
    end
    # Class describing a move hitting thrice
    class ThreeHit < MultiHit
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
        return 3
      end
    end
    # This method applies for triple kick and triple axel: power ramps up but the move stops if the subsequent attack misses.
    class TripleKick < MultiHit
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        final_power = power + (@nb_hit || 0) * power
        return final_power
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        @user = user
        @actual_targets = actual_targets
        @nb_hit = 0
        @hit_amount = hit_amount(user, actual_targets)
        @hit_amount.times.count do |i|
          break(false) unless actual_targets.all?(&:alive?)
          break(false) if user.dead?
          break(false) if i > 0 && !user.has_ability?(:skill_link) && (actual_targets = recalc_targets(user, actual_targets)).empty?
          play_animation(user, actual_targets) if i > 0
          actual_targets.each do |target|
            hp = damages(user, target)
            @logic.damage_handler.damage_change_with_process(hp, target, user, self) do
              if critical_hit?
                scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
              else
                if hp > 0 && i == @hit_amount - 1
                  efficent_message(effectiveness, target)
                end
              end
            end
            recoil(hp, user) if recoil?
          end
          @nb_hit += 1
          next(true)
        end
        @scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => @nb_hit.to_s))
        return false if user.dead?
        return true
      end
      # Recalculate the target each time it's needed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] the current targets we need the accuracy recalculation on
      # @return [Array] the targets hit after accuracy recalculation
      def recalc_targets(user, targets)
        return [] unless proceed_move_accuracy(user, targets).any? || (on_move_failure(user, targets, :accuracy) && false)
        user, targets = proceed_battlers_remap(user, targets)
        actual_targets = accuracy_immunity_test(user, targets)
        return [] if actual_targets.none? && (on_move_failure(user, targets, :immunity) || true)
        return actual_targets
      end
      def hit_amount(user, actual_targets)
        return 3
      end
    end
    # This method applies for Population Bomb: can hit up to 10 times, each subsequent hit checks accuracy.
    class PopulationBomb < TripleKick
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
        return 10
      end
    end
    # Class describing Water Shuriken : Changes power and number of hit depending on greninja's base or Ash form.
    class WaterShuriken < MultiHit
      # New version of the Greninja ability (9G+)
      BATTLE_BOND_GEN_NINE = false
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return super unless user.db_symbol == :greninja
        return super if user.form != 1 || BATTLE_BOND_GEN_NINE
        modified_power = 20
        log_data("Water Shuriken Power = #{modified_power}")
        return modified_power
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
        return super unless user.db_symbol == :greninja
        return super if user.form != 1 || BATTLE_BOND_GEN_NINE
        return 3
      end
    end
    Move.register(:s_multi_hit, MultiHit)
    Move.register(:s_2hits, TwoHit)
    Move.register(:s_3hits, ThreeHit)
    Move.register(:s_triple_kick, TripleKick)
    Move.register(:s_population_bomb, PopulationBomb)
    Move.register(:s_water_shuriken, WaterShuriken)
    public
    # Class describing a heal move
    class HealMove < Move
      # Function that return the immunity
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      def target_immune?(user, target)
        return true if super
        return %i[heal_pulse floral_healing].include?(db_symbol) && target.effects.has?(:substitute)
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          hp = target.max_hp / 2
          hp = hp * 3 / 2 if pulse? && user.has_ability?(:mega_launcher)
          logic.damage_handler.heal(target, hp)
        end
      end
      # Tell that the move is a heal move
      def heal?
        return true
      end
    end
    Move.register(:s_heal, HealMove)
    public
    class TwoTurnBase < Basic
      include Mechanics::TwoTurn
      private
      # List of move that can hit a Pokemon when he's out of reach
      #   CAN_HIT_BY_TYPE[oor_type] = [move db_symbol list]
      CAN_HIT_BY_TYPE = [%i[spikes toxic_spikes stealth_rock], %i[earthquake fissure magnitude spikes toxic_spikes stealth_rock], %i[gust gravity whirlwind thunder swift sky_uppercut twister smack_down hurricane thousand_arrows spikes toxic_spikes stealth_rock], %i[surf whirlpool spikes toxic_spikes stealth_rock], nil]
      # Out of reach moves to type
      #   OutOfReach[sb_symbol] => oor_type
      TYPES = {dig: 1, fly: 2, dive: 3, bounce: 2, phantom_force: 0, shadow_force: 0}
      # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
      # @return [Array<Symbol>]
      def can_hit_moves
        return CAN_HIT_BY_TYPE[TYPES[db_symbol] || 4]
      end
      # List all the text_id used to announce the waiting turn in TwoTurnBase moves
      ANNOUNCES = {bounce: [19, 544], dig: [19, 538], dive: [19, 535], electro_shot: [66, 1754], fly: [19, 529], freeze_shock: [59, 866], geomancy: [19, 1213], ice_burn: [19, 869], meteor_beam: [59, 2014], phantom_force: [19, 541], razor_wind: [19, 547], shadow_force: [19, 541], sky_attack: [19, 550], skull_bash: [19, 556], solar_beam: [19, 553]}
      # Move db_symbol to a list of stat and power
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      MOVE_TO_STAT = {electro_shot: [[:ats, 1]], meteor_beam: [[:ats, 1]], skull_bash: [[:dfe, 1]]}
      # Move db_symbol to a list of stat and power change on the user
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      def stat_changes_turn1(user, targets)
        return MOVE_TO_STAT[db_symbol]
      end
      # Display the message and the animation of the turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_message_turn1(user, targets)
        file_id, text_id = ANNOUNCES[db_symbol]
        return unless file_id && text_id
        @scene.display_message_and_wait(parse_text_with_pokemon(file_id, text_id, user))
      end
    end
    Move.register(:s_2turns, TwoTurnBase)
    public
    # Abstract class that manage logic of stage swapping moves
    class StatAndStageEdit < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |target| target.effects.has?(&:out_of_reach?) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(&:out_of_reach?)
          edit_stages(user, target)
        end
        return true
      end
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        log_error('Poorly implemented move: edit_stages(user, target) should have been overwritten in child class.')
      end
    end
    # Abstract class that manage logic of stage swapping moves and bypass accuracy calculation
    class StatAndStageEditBypassAccuracy < StatAndStageEdit
      # Tell if the move accuracy is bypassed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def bypass_accuracy?(user, targets)
        return true
      end
    end
    public
    # Class describing a Pledge move (moves combining for different effects)
    class Pledge < Basic
      # List the db_symbol for every Pledge moves
      # @return [Array<Symbol>]
      PLEDGE_MOVES = %i[water_pledge fire_pledge grass_pledge]
      # Return the combination for each effect triggered by Pledge combination
      # @return [Hash { Symbol => Array<Symbol, Array<>> }
      COMBINATION_LIST = {rainbow: %i[water_pledge fire_pledge], sea_of_fire: %i[fire_pledge grass_pledge], swamp: %i[grass_pledge water_pledge]}
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return check_order_of_attack(user, targets) if scene.logic.battle_info.vs_type > 1 && scene.logic.alive_battlers(user.bank).size >= 2
        return true
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return @combined_pledge ? 160 : super
      end
      # Function which permit things to happen before the move's animation
      def post_accuracy_check_move(user, actual_targets)
        scene.display_message_and_wait(parse_text(18, 193)) if @combined_pledge
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return false unless @combined_pledge
        comb_arr = [db_symbol, @combined_pledge]
        effect_symbol = nil
        COMBINATION_LIST.each { |key, value| effect_symbol = key if comb_arr & value == comb_arr }
        return unless effect_symbol
        send(effect_symbol, user, actual_targets)
        @combined_pledge = nil
        return true
      end
      # Register a Pledge move as one in the System
      # @param db_symbol [Symbol] db_symbol of the move
      def register_pledge_move(db_symbol)
        PLEDGE_MOVES << db_symbol unless PLEDGE_MOVES.include?(db_symbol)
      end
      # Register a pledge combination
      # @param effect_symbol [Symbol]
      # @param first_pledge_symbol [Symbol]
      # @param second_pledge_symbol
      def register_pledge_combination(effect_symbol, first_pledge_symbol, second_pledge_symbol)
        COMBINATION_LIST[effect_symbol] = [first_pledge_symbol, second_pledge_symbol]
      end
      private
      # Check the order to know if the user uses its Pledge Move or wait for the other to attack
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def check_order_of_attack(user, targets)
        allied_actions = scene.logic.turn_actions.select { |action| action.is_a?(Actions::Attack) && Actions::Attack.from(action).launcher.bank == user.bank }
        return true if allied_actions.size <= 1 || !allied_actions.all? { |action| PLEDGE_MOVES.include?(action.move.db_symbol) }
        other_move = (allied_actions.find { |action| action.launcher != user })
        other = other_move.launcher
        if user.attack_order < other.attack_order
          scene.display_message_and_wait(pledge_wait_text(user, other))
          user.add_successful_move_to_history(self, targets)
          return false
        else
          @combined_pledge = other_move.move.db_symbol
          return true
        end
      end
      # Get the right text depending on the user's side (and if it's a Trainer battle or not)
      # @param user [PFM::PokemonBattler]
      # @param other [PFM::PokemonBattler]
      # @return [String]
      def pledge_wait_text(user, other)
        text_id = (user.bank == 0 ? 1152 : (scene.logic.battle_info.trainer_battle? ? 1156 : 1158))
        parse_text(19, text_id, '[VAR PKNICK(0000)]' => user.given_name, '[VAR PKNICK(0001)]' => other.given_name)
      end
      # Create the Rainbow Effect
      # @param user [PFM::PokemonBattler]
      # @param _actual_targets [Array<PFM::PokemonBattler>]
      def rainbow(user, _actual_targets)
        return if logic.bank_effects[user.bank].has?(:rainbow)
        scene.logic.add_bank_effect(Battle::Effects::Rainbow.new(logic, user.bank))
      end
      # Create the SeaOfFire Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def sea_of_fire(_user, actual_targets)
        return if logic.bank_effects[actual_targets&.first&.bank].has?(:sea_of_fire)
        scene.logic.add_bank_effect(Battle::Effects::SeaOfFire.new(logic, actual_targets&.first&.bank))
      end
      # Create the Swamp Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def swamp(_user, actual_targets)
        return if logic.bank_effects[actual_targets&.first&.bank].has?(:swamp)
        scene.logic.add_bank_effect(Battle::Effects::Swamp.new(logic, actual_targets&.first&.bank))
      end
    end
    Move.register(:s_pledge, Pledge)
    public
    # Class managing ability changing moves
    class AbilityChanging < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| can_be_used?(user, target) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless can_be_used?(user, target)
          args = [receiver(user, target), ability_symbol(giver(user, target)), giver(user, target), self]
          @logic.ability_change_handler.apply_ability_change(*args) do
            post_ability_change_message(receiver(user, target), giver(user, target))
          end
        end
      end
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def can_be_used?(user, target)
        return false if user == target
        if is_a?(Battle::Move::SimpleBeam)
          return false if receiver(user, target).battle_ability_db_symbol == ability_symbol(giver(user, target))
          return false unless @logic.ability_change_handler.can_change_ability?(receiver(user, target), nil, self)
          return true
        end
        return false if ability_symbol(receiver(user, target)) == ability_symbol(giver(user, target))
        return false unless @logic.ability_change_handler.can_change_ability?(receiver(user, target), giver(user, target), self)
        return true
      end
      # Get the post ability change message
      # @param receiver [PFM::PokemonBattler] Ability receiver
      # @param giver [PFM::PokemonBattler] Potential ability giver
      # @return [String]
      # @note data_ability(ability_symbol(giver)).name to manage the Classic and Simple Beam cases
      def post_ability_change_message(receiver, giver)
        return parse_text_with_pokemon(19, 405, receiver, PFM::Text::ABILITY[1] => data_ability(ability_symbol(giver)).name)
      end
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(battler)
        return battler.battle_ability_db_symbol
      end
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(user, target)
        raise 'This method should be implemented in the subclass'
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(user, target)
        raise 'This method should be implemented in the subclass'
      end
    end
    # Class managing Entrainment move
    class Entrainment < AbilityChanging
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(_, target)
        return target
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(user, _)
        return user
      end
    end
    # Class managing Simple Beam move
    class SimpleBeam < Entrainment
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(_)
        return :simple
      end
    end
    # Class managing Worry Seed move
    class WorrySeed < SimpleBeam
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(_)
        return :insomnia
      end
    end
    # Class managing Role Play move
    class RolePlay < AbilityChanging
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(user, _)
        return user
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(_, target)
        return target
      end
    end
    # Class managing Doodle move
    class Doodle < RolePlay
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? do |target|
          @logic.alive_battlers(user.bank).none? do |battler|
            can_be_used?(battler, target)
          end
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          @logic.alive_battlers(user.bank).each do |battler|
            next unless can_be_used?(battler, target)
            args = [receiver(battler, target), ability_symbol(giver(battler, target)), giver(battler, target), self]
            @logic.ability_change_handler.apply_ability_change(*args) do
              post_ability_change_message(receiver(battler, target), giver(battler, target))
            end
          end
        end
      end
    end
    # Class managing Skill Swap move
    class SkillSwap < AbilityChanging
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless can_be_used?(user, target)
          @logic.ability_change_handler.apply_ability_swap(user, target, self)
        end
      end
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def can_be_used?(user, target)
        return false if user == target
        return false if ability_symbol(user) == ability_symbol(target)
        return false unless @logic.ability_change_handler.can_change_ability?(target, user, self)
        return false unless @logic.ability_change_handler.can_change_ability?(user, target, self)
        return true
      end
    end
    Move.register(:s_entrainment, Entrainment)
    Move.register(:s_simple_beam, SimpleBeam)
    Move.register(:s_worry_seed, WorrySeed)
    Move.register(:s_role_play, RolePlay)
    Move.register(:s_doodle, Doodle)
    Move.register(:s_skill_swap, SkillSwap)
    public
    # Class describing a move that drains HP
    class Absorb < Move
      # don't forget to add a "x.0" if the factor is a float, or it will be converted to 1 (= 100% damage-to-heal conversion)
      DRAIN_FACTORS = {draining_kiss: 4 / 3.0, oblivion_wing: 4 / 3.0}
      # Returns the drain factor
      # @return [Integer]
      def drain_factor
        DRAIN_FACTORS[db_symbol] || super
      end
      # Tell that the move is a drain move
      # @return [Boolean]
      def drain?
        return true
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false if target.has_ability?(:comatose) && be_method == :s_dream_eater
        return true if !target.asleep? && be_method == :s_dream_eater
        return super
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return true if status?
        raise 'Badly configured move, it should have positive power' if power < 0
        actual_targets.each do |target|
          hp = damages(user, target)
          @logic.damage_handler.drain_with_process(hp, target, user, self, hp_overwrite: hp, drain_factor: drain_factor) do
            if critical_hit?
              scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
            else
              if hp > 0
                efficent_message(effectiveness, target)
              end
            end
          end
          recoil(hp, user) if recoil?
        end
        return true
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        if user.effects.has?(:heal_block)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 893, user, '[VAR PKNICK(0000)]' => user.given_name, '[VAR MOVE(0001)]' => name))
          return false
        end
        return true if super
      end
    end
    Move.register(:s_absorb, Absorb)
    Move.register(:s_dream_eater, Absorb)
    public
    # Class managing Acrobatics move
    class Acrobatics < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power * 2 if user.item_effect.is_a?(Battle::Effects::Item::Gems) && user.item_consumed
        return power * 2 unless user.item_db_symbol != :__undef__
        return super
      end
    end
    Move.register(:s_acrobatics, Acrobatics)
    public
    # Class that manage the Acupressure move
    # @see https://bulbapedia.bulbagarden.net/wiki/Acupressure_(move)
    # @see https://pokemondb.net/move/acupressure
    # @see https://www.pokepedia.fr/Acupression
    class Acupressure < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        map_stages_id(user, targets)
        return show_usage_failure(user) && false if @stages_ids.empty?
        return true
      end
      # All the stages that the move can modify
      # @return [Array[Symbol]]
      def stages
        Logic::StatChangeHandler::ALL_STATS
      end
      # Map the stages ids of each target
      def map_stages_id(user, targets)
        select_stage = -> (target) { (Logic::StatChangeHandler::ALL_STATS.select { |s| @logic.stat_change_handler.stat_increasable?(s, target, user, self) }).sample(random: @logic.generic_rng) }
        @stages_ids = targets.map { |target| [target, select_stage.call(target)] }.to_h.compact
      end
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        if @stages_ids.nil?
          map_stages_id(user, actual_targets)
          return show_usage_failure(user) if @stages_ids.nil? || @stages_ids&.empty?
        end
        actual_targets.each do |target|
          next unless @stages_ids[target]
          @logic.stat_change_handler.stat_change(@stages_ids[target], 2, target, user, self)
        end
      end
    end
    Move.register(:s_acupressure, Acupressure)
    public
    # Move that give a third type to an enemy
    class AddThirdType < Move
      TYPES = {trick_or_treat: :ghost, forest_s_curse: :grass}
      TYPES.default = :normal
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.send(:"type_#{TYPES[db_symbol]}?")
        return true if target.has_ability?(:multitype) || target.has_ability?(:rks_system)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.type3 = new_type
          scene.display_message_and_wait(message(target))
        end
      end
      # Get the type given by the move
      # @return [Integer] the ID of the Type given by the move
      def new_type
        return data_type(TYPES[db_symbol] || 0).id
      end
      # Get the message text
      # @return [String]
      def message(target)
        return parse_text_with_pokemon(19, 902, target, '[VAR TYPE(0001)]' => data_type(new_type).name)
      end
    end
    Move.register(:s_add_type, AddThirdType)
    public
    # Me First move
    class AfterYou < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.empty? || logic.battler_attacks_after?(user, targets.first)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        attacks = logic.actions.select { |action| action.is_a?(Actions::Attack) }
        target_action = attacks.find { |action| action.launcher == target }
        return unless target_action
        logic.actions.delete(target_action)
        logic.actions << target_action
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1140, target))
      end
    end
    Move.register(:s_after_you, AfterYou)
    public
    class AlluringVoice < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.all? { |target| target.stat_history&.last&.current_turn? && target.stat_history&.last&.power&.positive? }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.stat_history&.last&.current_turn?
          next unless target.stat_history&.last&.power&.positive?
          next unless logic.status_change_handler.status_appliable?(status, target, user, self)
          logic.status_change_handler.status_change(status, target, user, self)
        end
      end
      # @return [Symbol] the status that will be applied to the pokemon
      def status
        return :confusion
      end
    end
    class BurningJealousy < AlluringVoice
      # @return [Symbol] the status that will be applied to the pokemon
      def status
        return :burn
      end
    end
    Move.register(:s_alluring_voice, AlluringVoice)
    Move.register(:s_burning_jealousy, BurningJealousy)
    public
    # Move that switches the user's position with its ally
    class AllySwitch < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if @logic.adjacent_allies_of(user).count != 1
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _)
        ally = @logic.adjacent_allies_of(user).first
        @logic.switch_battlers(user, ally)
        scene.visual.show_switch_form_animation(ally)
        scene.visual.show_switch_form_animation(user)
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1143, user, PFM::Text::PKNICK[1] => ally.given_name))
      end
    end
    Move.register(:s_ally_switch, AllySwitch)
    public
    # Class managing the Aqua Ring move
    class AquaRing < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.all? { |target| target.effects.has?(:aqua_ring) }
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:aqua_ring)
          target.effects.add(Effects::AquaRing.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 601, target))
        end
      end
    end
    Move.register(:s_aqua_ring, AquaRing)
    public
    # Assist move
    class Assist < Move
      CANNOT_BE_SELECTED_MOVES = %i[assist baneful_bunker beak_blast belch bestow bounce celebrate chatter circle_throw copycat counter covet destiny_bound detect dig dive dragon_tail endure feint fly focus_punch follow_me helping_hand hold_hands king_s_shield mat_block me_first metronome mimic mirror_coat mirror_move nature_power phantom_force protect rage_powder roar shadow_force shell_trap sketch sky_drop sleep_talk snatch spiky_shield spotlight struggle switcheroo thief transform trick whirlwind]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if usable_moves(user).empty?
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        skill = usable_moves(user).sample(random: @logic.generic_rng)
        move = Battle::Move[skill.be_method].new(skill.id, 1, 1, @scene)
        def move.move_usable_by_user(user, targets)
          return true
        end
        use_another_move(move, user)
      end
      # Function that list all the moves the user can pick
      # @param user [PFM::PokemonBattler]
      # @return [Array<Battle::Move>]
      def usable_moves(user)
        team = @logic.trainer_battlers.reject { |pkm| pkm == user }
        skills = team.flat_map(&:moveset).uniq(&:db_symbol)
        skills.reject! { |move| CANNOT_BE_SELECTED_MOVES.include?(move.db_symbol) }
        return skills
      end
    end
    Move.register(:s_assist, Assist)
    public
    # Class that manage Assurance move
    # @see https://bulbapedia.bulbagarden.net/wiki/Assurance_(move)
    # @see https://pokemondb.net/move/Assurance
    # @see https://www.pokepedia.fr/Assurance
    class Assurance < Basic
      # Base power calculation
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def calc_base_power(user, target)
        result = super
        damage_took = target.damage_history.any?(&:current_turn?)
        log_data("power = #{result * (damage_took ? 2 : 1)} \# after Move::Assurance calc")
        return result * (damage_took ? 2 : 1)
      end
    end
    Move.register(:s_assurance, Assurance)
    public
    # Move that inflict attract effect to the ennemy
    class Attract < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true unless user.gender * target.gender == 2
        return true if target.effects.has?(:attract)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::Attract.new(logic, target, user))
          scene.visual.show_status_animation(target, :attract)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 327, target))
          handle_destiny_knot_effect(user, target) if target.hold_item?(:destiny_knot)
        end
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def handle_destiny_knot_effect(user, target)
        return if user.effects.has?(:attract)
        user.effects.add(Effects::Attract.new(logic, user, target))
        scene.show_status_animation(target, :attract)
        scene.display_message_and_wait(parse_text_with_pokemon(19, 327, user))
      end
    end
    Move.register(:s_attract, Attract)
    public
    class AuraWheel < SelfStat
      # Hash containing each valid user and the move's type depending on the form
      # @return [Hash{Symbol => Hash}]
      VALID_USER = Hash.new
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless VALID_USER[user.db_symbol]
        return true
      end
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        return [data_type(VALID_USER[user.db_symbol][user.form]).id]
      end
      class << self
        # Register a valid user for this move
        # @param creature_db_symbol [Symbol] db_symbol of the new valid user
        # @param forms_and_types [Array<Array>] the array containing the informations
        # @param default [Symbol] db_symbol of the type by default for this user
        # @example : register_valid_user(:pikachu, [0, :electrik], [1, :psychic], [2, :fire], default: :electrik)
        # This will let Pikachu use the move, its form 0 will make the move Electrik type, form 1 Psychic type, its form 2 Fire type
        # and any other form will have Electrik type by default
        def register_valid_user(creature_db_symbol, *forms_and_types, default: nil)
          VALID_USER[creature_db_symbol] = forms_and_types.to_h
          VALID_USER[creature_db_symbol].default = default || forms_and_types.to_h.first[1]
        end
      end
      register_valid_user(:morpeko, [0, :electric], [1, :dark], default: :electrik)
    end
    Move.register(:s_aura_wheel, AuraWheel)
    public
    # Move that inflict Autotomize to the enemy bank
    class Autotomize < Move
      private
      MODIFIERS = %i[atk_stage dfe_stage ats_stage dfs_stage spd_stage eva_stage acc_stage]
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        target_stats_before = actual_targets.map { |target| [target, MODIFIERS.map { |stat| target.send(stat) }] }.to_h
        result = super
        actual_targets.select! { |target| target_stats_before[target] != MODIFIERS.map { |stat| target.send(stat) } }
        return result && !actual_targets.empty?
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          if (effect = target.effects.get(:autotomize))
            effect.launch_effect(self)
          else
            target.effects.add(Effects::Autotomize.new(@logic, target, self))
          end
        end
      end
    end
    Move.register(:s_autotomize, Autotomize)
    public
    # Class that manage Avalanche move
    # @see https://bulbapedia.bulbagarden.net/wiki/Avalanche_(move)
    # @see https://pokemondb.net/move/avalanche
    # @see https://www.pokepedia.fr/Avalanche
    class Avalanche < Basic
      # Base power calculation
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def calc_base_power(user, target)
        result = super
        damage_took = user.damage_history.any? { |dh| dh.current_turn? && dh.launcher == target }
        log_data("power = #{result * (damage_took ? 2 : 1)} \# after Move::Avalanche calc")
        return result * (damage_took ? 2 : 1)
      end
    end
    Move.register(:s_avalanche, Avalanche)
    public
    # Baton Pass causes the user to switch out for another Pokémon, passing any stat changes to the Pokémon that switches in.
    # @see https://pokemondb.net/move/baton-pass
    # @see https://bulbapedia.bulbagarden.net/wiki/Baton_Pass_(move)
    # @see https://www.pokepedia.fr/Relais
    class BatonPass < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        switchable_allies = logic.alive_battlers_without_check(user.bank).count { |pokemon| pokemon != user && pokemon.party_id == user.party_id }
        return show_usage_failure(user) && false unless switchable_allies > 0
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Battle::Effects::BatonPass.new(logic, target))
          logic.request_switch(target, nil)
        end
      end
    end
    Move.register(:s_baton_pass, BatonPass)
    public
    # Class that manage the move Beat Up
    # Beat Up inflicts damage on the target from the user, and each conscious Pokémon in the user's party that does not have a non-volatile status.
    # @see https://bulbapedia.bulbagarden.net/wiki/Beat_Up_(move)
    # @see https://pokemondb.net/move/beat-up
    # @see https://www.pokepedia.fr/Baston
    class BeatUp < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if (@bu_battlers = battlers_that_hit(user)).empty?
        return true
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        unless @bu_current_battler
          bu_power = 0
          @logic.all_battlers do |battler|
            bu_power += (battler.atk_basis / 10 + 5).ceil if battler.bank == user.bank
          end
          return bu_power
        end
        bu_power = (@bu_current_battler.atk_basis / 10 + 5).ceil
        log_data('power = %i # BeatUp from %s on %s (through %s)' % [bu_power, @bu_current_battler.name, target.name, user.name])
        return bu_power
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        nb_hit = @bu_battlers.size.times.count do |i|
          next(false) unless actual_targets.any?(&:alive?)
          play_animation(user, actual_targets) if i > 0
          @bu_current_battler = @bu_battlers[i]
          actual_targets.each do |target|
            next if target.dead?
            deal_damage_to_target(user, actual_targets, target)
          end
        end
        final_message(nb_hit)
      end
      # Function that deal the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @param target [PFM::PokemonBattler] the current target
      def deal_damage_to_target(user, actual_targets, target)
        hp = damages(user, target)
        @logic.damage_handler.damage_change_with_process(hp, target, user, self) do
          if critical_hit?
            critical_hit_message(target, actual_targets, target)
          else
            if hp > 0 && target == actual_targets.last
              efficent_message(effectiveness, target)
            end
          end
        end
        recoil(hp, user) if recoil?
      end
      # Function that retrieve the battlers that hit the targets
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Array[PFM::Battler]]
      def battlers_that_hit(user)
        logic.alive_battlers_without_check(user.bank)
      end
      # Display the right message in case of critical hit
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @param target [PFM::PokemonBattler] the current target
      # @return [String]
      def critical_hit_message(user, actual_targets, target)
        scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
      end
      # Display the message after all the hit have been performed
      # @param nb_hit [Integer] amount of hit performed
      def final_message(nb_hit)
        @scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => nb_hit.to_s))
      end
    end
    Move.register(:s_beat_up, BeatUp)
    public
    # Class managing the Pluck move
    class Belch < Basic
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return true if user.item_consumed && Effects::Item.new(logic, user, user.consumed_item).is_a?(Effects::Item::Berry)
        show_usage_failure(user)
        return false
      end
    end
    Move.register(:s_belch, Belch)
    public
    class BellyDrum < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        stats_changeable = stats.keys.none? { |stat| stat_changeable?(stat, user) }
        if user.hp_rate <= (1.0 / factor) || stats_changeable
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.hp_rate <= (1.0 / factor)
          hp = (target.max_hp / factor).floor
          logic.damage_handler.damage_change(hp, target)
          scene.display_message_and_wait(message(user, target)) if message(user, target)
          stats.each { |stat, power| logic.stat_change_handler.stat_change_with_process(stat, power, target, user, self) }
        end
      end
      # Check if a stat is changeable
      # @param stat [Symbol] the stat to check
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def stat_changeable?(stat, user)
        return true if user.has_ability?(:contrary)
        return logic.stat_change_handler.stat_increasable?(stat, user, user, self)
      end
      # The divisor used to calculate the HP cost
      # @return [Integer]
      def factor
        return 2
      end
      # Method containing stats and the power to raise them
      # @return [Hash<Symbol, Integer>]
      def stats
        return {atk: 12}
      end
      # Parse a text from the text database with specific informations and a pokemon
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [String, nil] the text parsed and ready to be displayed
      def message(user, target)
        return parse_text_with_pokemon(19, 613, target)
      end
    end
    class FilletAway < BellyDrum
      # Method containing stats and the power to raise them
      # @return [Hash<Symbol, Integer>]
      def stats
        return {atk: 2, ats: 2, spd: 2}
      end
      # Parse a text from the text database with specific informations and a pokemon
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [String, nil] the text parsed and ready to be displayed
      def message(user, target)
        return nil
      end
    end
    Move.register(:s_bellydrum, BellyDrum)
    Move.register(:s_fillet_away, FilletAway)
    public
    class Bestow < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless logic.item_change_handler.can_give_item?(user, targets.first)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        item = user.battle_item_db_symbol
        item_name = user.item_name
        logic.item_change_handler.change_item(item, true, target, user, self)
        logic.item_change_handler.change_item(:none, true, user, user, self)
        logic.terrain_effects.add(Battle::Effects::Bestow.new(logic, user, target, item))
        logic.scene.display_message_and_wait(give_text(target, user, item_name))
      end
      # Get the text displayed when the user gives its item to the target
      # @param target [Array<PFM::PokemonBattler>]
      # @param user [PFM::PokemonBattler] user of the move
      # @param item [String] the name of the item
      # @return [String] the text to display
      def give_text(target, user, item)
        return parse_text_with_2pokemon(19, 1117, target, user, PFM::Text::ITEM2[2] => item)
      end
    end
    Move.register(:s_bestow, Bestow)
    public
    # Bide Move
    class Bide < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
        return true
      end
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        return [0]
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return super if user.effects.get(:bide)&.unleach?
        return true
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if user.effects.get(:bide)&.unleach? && user.effects.get(:bide).damages == 0
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return if user.effects.has?(:bide)
        user.effects.add(Effects::Bide.new(logic, user, self, actual_targets, 3))
      end
      # Method calculating the damages done by counter
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        effect = user.effects.get(:bide)
        return ((effect&.damages || 1) * 2).clamp(1, Float::INFINITY)
      end
      # Method responsive testing accuracy and immunity.
      # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>]
      def accuracy_immunity_test(user, targets)
        attackers = (logic.foes_of(user) + logic.allies_of(user)).sort { |a, b| (b.attack_order || 0) <=> (a.attack_order || 0) }
        attacker = attackers.find { |foe| foe.move_history.last&.targets&.include?(user) && foe.move_history.last.turn == $game_temp.battle_turn }
        return [attacker || logic.foes_of(user).sample(random: logic.generic_rng)]
      end
      # Play the move animation (only without all the decoration)
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation_internal(user, targets)
        super if user.effects.has?(:bide) && user.effects.get(:bide).unleach?
      end
      # Show the move usage message
      # @param user [PFM::PokemonBattler] user of the move
      def usage_message(user)
        if !user.effects.has?(:bide)
          super
        else
          if user.effects.get(:bide).unleach?
            return scene.display_message_and_wait(parse_text_with_pokemon(19, 748, user))
          end
        end
        scene.display_message_and_wait(parse_text_with_pokemon(19, 745, user))
      end
    end
    Move.register(:s_bide, Bide)
    public
    # Move that binds the target to the field
    class Bind < Basic
      private
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        actual_targets.any? { |target| !target.type_ghost? && !target.effects.has?(:bind) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        turn_count = user.hold_item?(:grip_claw) ? 7 : logic.generic_rng.rand(4..5)
        actual_targets.each do |target|
          next if target.type_ghost? || target.effects.has?(:bind)
          target.effects.add(Effects::Bind.new(logic, target, user, turn_count, self))
        end
      end
    end
    Move.register(:s_bind, Bind)
    public
    # Move that deals damage from the user defense and not its attack statistics
    class BodyPress < Basic
      # Get the basis atk for the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_sp_atk_basis(user, target, ph_move)
        return user.dfe_basis
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
        return 1 if critical_hit?
        return user.dfe_modifier
      end
    end
    Move.register(:s_body_press, BodyPress)
    public
    # Class managing Brick Break move
    class BrickBreak < BasicWithSuccessfulEffect
      private
      WALLS = %i[light_screen reflect aurora_veil]
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        @logic.bank_effects[bank].each do |effect|
          next unless WALLS.include?(effect.name)
          case effect.name
          when :reflect
            @scene.display_message_and_wait(parse_text(18, bank == 0 ? 132 : 133))
          when :light_screen
            @scene.display_message_and_wait(parse_text(18, bank == 0 ? 136 : 137))
          else
            @scene.display_message_and_wait(parse_text(18, bank == 0 ? 140 : 141))
          end
          log_info("PSDK Brick Break: #{effect.name} effect removed.")
          effect.kill
        end
      end
    end
    class RagingBull < BrickBreak
      # @return [Array<Symbol]
      RAGING_BULL_USERS = %i[tauros]
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        return [type] unless RAGING_BULL_USERS.include?(user.db_symbol)
        case user.form
        when 1
          return [data_type(:fighting).id]
        when 2
          return [data_type(:fire).id]
        when 3
          return [data_type(:water).id]
        else
          return [type]
        end
      end
    end
    Move.register(:s_brick_break, BrickBreak)
    Move.register(:s_raging_bull, RagingBull)
    public
    # Power doubles if opponent's HP is 50% or less.
    class Brine < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return target.hp <= (target.max_hp / 2) ? power * 2 : power
      end
    end
    Move.register(:s_brine, Brine)
    public
    # Implement the Burn Up move
    class BurnUp < Basic
      # Text of the loss of our type after launching the attack
      TEXTS_IDS = {burn_up: [:parse_text_with_pokemon, 59, 1856], double_shock: [:parse_text_with_pokemon, 66, 1606]}
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless user.type?(type)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(Effects::BurnUp.new(@logic, user, turn_count, type))
        @scene.display_message_and_wait(send(*TEXTS_IDS[db_symbol], user)) if TEXTS_IDS[db_symbol]
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
        return Float::INFINITY
      end
    end
    Move.register(:s_burn_up, BurnUp)
    public
    # Camouflage causes the user to change its type based on the current terrain.
    # @see https://pokemondb.net/move/camouflage
    # @see https://bulbapedia.bulbagarden.net/wiki/Camouflage_(move)
    # @see https://www.pokepedia.fr/Camouflage
    class Camouflage < Move
      include Mechanics::LocationBased
      private
      # Play the move animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation(user, targets)
        super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        type = data_type(element_by_location).id
        actual_targets.each do |target|
          target.change_types(type)
          scene.display_message_and_wait(deal_message(user, target, type))
        end
      end
      def deal_message(user, target, type)
        parse_text_with_pokemon(19, 899, target, {'[VAR TYPE(0001)]' => data_type(type).name})
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
        TYPE_BY_LOCATION
      end
      class << self
        def reset
          const_set(:TYPE_BY_LOCATION, {})
        end
        def register(loc, type)
          TYPE_BY_LOCATION[loc] ||= []
          TYPE_BY_LOCATION[loc] << type
          TYPE_BY_LOCATION[loc].uniq!
        end
      end
      reset
      register(:__undef__, :normal)
      register(:regular_ground, :normal)
      register(:building, :normal)
      register(:grass, :grass)
      register(:desert, :ground)
      register(:cave, :rock)
      register(:water, :water)
      register(:shallow_water, :ground)
      register(:snow, :ice)
      register(:icy_cave, :ice)
      register(:volcanic, :fire)
      register(:burial, :ghost)
      register(:soaring, :flying)
      register(:misty_terrain, :fairy)
      register(:grassy_terrain, :grass)
      register(:electric_terrain, :electric)
      register(:psychic_terrain, :psychic)
      register(:space, :dragon)
      register(:ultra_space, :dragon)
    end
    register(:s_camouflage, Camouflage)
    public
    # Move that binds the target to the field
    class CantSwitch < Basic
      private
      # Function that return the immunity
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      def target_immune?(user, target)
        return true if super
        return true if target.type_ghost? && status?
        return false
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.all? { |target| !target.effects.has?(:cantswitch) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:cantswitch)
          target.effects.add(Effects::CantSwitch.new(logic, target, user, self))
          scene.display_message_and_wait(message(target))
        end
      end
      # Get the message text
      # @return [String]
      def message(target)
        return parse_text_with_pokemon(19, 875, target)
      end
    end
    Move.register(:s_cantflee, CantSwitch)
    public
    # Class managing captivate move
    class Captivate < Move
      private
      # Ability preventing the move from working
      BLOCKING_ABILITY = %i[oblivious]
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if user.gender == target.gender || target.gender == 0
        if user.can_be_lowered_or_canceled?(BLOCKING_ABILITY.include?(target.battle_ability_db_symbol))
          @scene.visual.show_ability(target)
          return true
        end
        return super
      end
    end
    Move.register(:s_captivate, Captivate)
    public
    # Move that give a third type to an enemy
    class ChangeType < Move
      TYPES = {soak: :water, magic_powder: :psychic}
      ABILITY_EXCEPTION = %i[multitype rks_system]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |t| t.effects.has?(:change_type) || condition(t) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:change_type) || condition(target)
          target.effects.add(Battle::Effects::ChangeType.new(logic, target, new_type))
          scene.display_message_and_wait(message(target))
        end
      end
      # Method that tells if the Move's effect can proceed
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def condition(target)
        return type_check(target) && target.type2 == 0 && target.type3 == 0 || ABILITY_EXCEPTION.include?(target.ability_db_symbol) || target.effects.has?(:substitute)
      end
      # Method that tells if the target already has the type
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def type_check(target)
        return target.type_water?
      end
      # Get the type given by the move
      # @return [Integer] the ID of the Type given by the move
      def new_type
        return data_type(TYPES[db_symbol] || 0).id
      end
      # Get the message text
      # @return [String]
      def message(target)
        return parse_text_with_pokemon(19, 899, target, '[VAR TYPE(0001)]' => data_type(new_type).name)
      end
    end
    Move.register(:s_change_type, ChangeType)
    public
    # Charge raises the user's Special Defense by one stage, and if this Pokémon's next move is a damage-dealing Electric-type attack, it will deal double damage.
    # @see https://pokemondb.net/move/charge
    # @see https://bulbapedia.bulbagarden.net/wiki/Charge_(move)
    # @see https://www.pokepedia.fr/Chargeur
    class Charge < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(effect_name)
          target.effects.add(create_effect(user, target))
          scene.display_message_and_wait(effect_message(user, target))
        end
      end
      # Symbol name of the effect
      # @return [Symbol]
      def effect_name
        :charge
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::EffectBase]
      def create_effect(user, target)
        Effects::Charge.new(@logic, target, 2)
      end
      # Message displayed when the effect is created
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [String]
      def effect_message(user, target)
        parse_text_with_pokemon(19, 664, target)
      end
    end
    Move.register(:s_charge, Charge)
    public
    # Chilly Reception sets the hail/snow, then the user switches out of battle.
    class ChillyReception < Move
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        nb_turn = user.hold_item?(:icy_rock) ? 8 : 5
        logic.weather_change_handler.weather_change_with_process(:hail, nb_turn)
        return false unless @logic.switch_handler.can_switch?(user, self)
        @logic.switch_request << {who: user}
      end
    end
    Move.register(:s_chilly_reception, ChillyReception)
    public
    class ClangorousSoul < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        can_change_atk = logic.stat_change_handler.stat_increasable?(:atk, user)
        can_change_ats = logic.stat_change_handler.stat_increasable?(:ats, user)
        can_change_dfe = logic.stat_change_handler.stat_increasable?(:dfe, user)
        can_change_dfs = logic.stat_change_handler.stat_increasable?(:dfs, user)
        can_change_spd = logic.stat_change_handler.stat_increasable?(:spd, user)
        stat_changeable = can_change_atk || can_change_ats || can_change_dfe || can_change_dfs || can_change_spd
        if user.hp_rate <= 0.33 || !stat_changeable
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        hp = (user.max_hp / 3).floor
        logic.damage_handler.damage_change(hp, user)
      end
    end
    Move.register(:s_clangorous_soul, ClangorousSoul)
    public
    # Move that sets the type of the Pokemon as type of the first move
    class Conversion < BasicWithSuccessfulEffect
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        target.type1 = user.moveset.first&.type || 0
        target.type2 = 0
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 899, target, '[VAR TYPE(0001)]' => data_type(target.type1).name))
      end
    end
    # Move that sets the type of the Pokemon as type of the last move used by target
    class Conversion2 < BasicWithSuccessfulEffect
      # Return the exceptions to the Conversion 2 effect
      MOVE_EXCEPTIONS = %i[revelation_dance struggle]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.none? { |target| target.move_history.any? && !MOVE_EXCEPTIONS.include?(target.move_history.last.db_symbol) && target.move_history.last.move.type != 0 }
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        last_move_user = actual_targets.max_by { |target| target.move_history.any? ? target.move_history.max_by(&:turn) : 0 }
        type = last_move_user.move_history&.last&.move&.type || 0
        user.type1 = random_resistances(type)
        user.type2 = 0
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 899, user, '[VAR TYPE(0001)]' => data_type(user.type1).name))
      end
      # Check the resistances to one type and return one random
      # @param move_type [Integer] type of the move used by the target
      # @return Integer
      def random_resistances(move_type)
        resistances = each_data_type.select { |type| data_type(move_type).hit(type.db_symbol) < 1 }
        return resistances.sample.id
      end
    end
    Move.register(:s_conversion, Conversion)
    Move.register(:s_conversion2, Conversion2)
    public
    # Move that inflict leech seed to the ennemy
    class CoreEnforcer < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| !target.effects.has?(:ability_suppressed) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:ability_suppressed)
          launchers = logic.turn_actions.map { |action| action.instance_variable_get(:@launcher) }
          launchers.first == user ? target.effects.add(Effects::AbilitySuppressed.new(@logic, target)) : next
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 565, target))
        end
      end
    end
    Move.register(:s_core_enforcer, CoreEnforcer)
    public
    class CorrosiveGas < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| @logic.item_change_handler.can_lose_item?(target, user) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless @logic.item_change_handler.can_lose_item?(target, user)
          @scene.display_message_and_wait(parse_text_with_2pokemon(59, 2022, user, target, PFM::Text::ITEM2[2] => target.item_name))
          @logic.item_change_handler.change_item(:none, false, target, user, self)
        end
      end
    end
    Move.register(:s_corrosive_gas, CorrosiveGas)
    public
    # Base class for counter moves, deals damage equal to 1.5/2x opponent's move.
    class CounterBase < Basic
      include Mechanics::Counter
      # Test if the attack fails based on common conditions
      # @param attacker [PFM::PokemonBattler] the last attacker
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean] does the attack fails ?
      def counter_fails_common?(attacker, user)
        return true unless attacker
        return true if logic.allies_of(user).include?(attacker)
        return true unless attacker.successful_move_history&.last&.turn == $game_temp.battle_turn
        return false
      end
    end
    # Class managing Counter move
    class Counter < CounterBase
      private
      # Test if the attack fails
      # @param attacker [PFM::PokemonBattler] the last attacker
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean] does the attack fails ?
      def counter_fails?(attacker, user, targets)
        return true if counter_fails_common?(attacker, user)
        return true if attacker.type_ghost?
        return true unless attacker.successful_move_history&.last&.move&.physical?
        return false
      end
    end
    # Class managing Mirror Coat move
    class MirrorCoat < CounterBase
      private
      # Test if the attack fails
      # @param attacker [PFM::PokemonBattler] the last attacker
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean] does the attack fails ?
      def counter_fails?(attacker, user, targets)
        return true if counter_fails_common?(attacker, user)
        return true if attacker.type_dark?
        return true unless attacker.successful_move_history&.last&.move&.special?
        return false
      end
    end
    # Class managing Metal Burst / Comeuppance moves
    class MetalBurst < CounterBase
      private
      # Test if the attack fails
      # @param attacker [PFM::PokemonBattler] the last attacker
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean] does the attack fails ?
      def counter_fails?(attacker, user, targets)
        return counter_fails_common?(attacker, user)
      end
      # Damage multiplier if the effect proc
      # @return [Integer, Float]
      def damage_multiplier
        return 1.5
      end
    end
    Move.register(:s_counter, Counter)
    Move.register(:s_mirror_coat, MirrorCoat)
    Move.register(:s_metal_burst, MetalBurst)
    public
    class CourtChange < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = @logic.foes_of(user).first
        @logic.switch_bank_effects(user.bank, target.bank)
        @scene.display_message_and_wait(parse_text_with_pokemon(59, 1970, user))
      end
    end
    Move.register(:s_court_change, CourtChange)
    public
    # Class managing Crafty Shield
    # Crafty Shield protects all Pokemon on the user bank from status moves
    class CraftyShield < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        actual_targets.each { |target| target.effects.add(Effects::CraftyShield.new(@logic, target)) }
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 211 : 212))
      end
    end
    Move.register(:s_crafty_shield, CraftyShield)
    public
    # Class managing Curse
    class Curse < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return true unless user.type_ghost?
        return show_usage_failure(user) && false if targets.all? { |target| target.effects.has?(:curse) }
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return false unless user.type_ghost?
        return true if super
        return scene.display_message_and_wait(parse_text_with_pokemon(19, 213, target)) && true if target.effects.has?(:curse)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.type_ghost? ? apply_ghost_type_effects(user, actual_targets) : apply_non_ghost_type_effects(user)
      end
      private
      # Function to apply effects for Ghost-type Pokémon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def apply_ghost_type_effects(user, actual_targets)
        hp = (user.max_hp / 2).clamp(1, user.hp)
        logic.damage_handler.damage_change(hp, user, user, self)
        actual_targets.each do |target|
          target.effects.add(Effects::Curse.new(logic, target))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1070, target, PFM::Text::PKNICK[0] => user.given_name, PFM::Text::PKNICK[1] => target.given_name))
        end
      end
      # Function to apply effects for non-Ghost-type Pokémon
      # @param user [PFM::PokemonBattler] user of the move
      def apply_non_ghost_type_effects(user)
        logic.stat_change_handler.stat_change_with_process(:spd, -1, user, user, self)
        logic.stat_change_handler.stat_change_with_process(:atk, 1, user, user, self)
        logic.stat_change_handler.stat_change_with_process(:dfe, 1, user, user, self)
      end
    end
    Move.register(:s_curse, Curse)
    public
    class CustomStatsBased < Basic
      # Physical moves that use the special attack
      ATS_PHYSICAL_MOVES = %i[psyshock secret_sword]
      # Special moves that use the attack
      ATK_SPECIAL_MOVES = []
      # Is the skill physical ?
      # @return [Boolean]
      def physical?
        return ATS_PHYSICAL_MOVES.include?(db_symbol)
      end
      # Is the skill special ?
      # @return [Boolean]
      def special?
        return ATK_SPECIAL_MOVES.include?(db_symbol)
      end
      # Get the basis atk for the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_sp_atk_basis(user, target, ph_move)
        return ph_move ? user.ats_basis : user.atk_basis
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
        modifier = ph_move ? user.ats_modifier : user.atk_modifier
        modifier = modifier > 1 ? modifier : 1 if critical_hit?
        return modifier
      end
      # Statistic effect modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_effect_modifier(user, target, ph_move)
        modifier = 1
        @logic.each_effects(user) do |e|
          modifier *= (ph_move ? e.ats_modifier : e.atk_modifier)
        end
        return modifier
      end
    end
    Move.register(:s_custom_stats_based, CustomStatsBased)
    Move.register(:s_psyshock, CustomStatsBased)
    public
    # Class managing Defog move
    class Defog < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        if $env.current_weather_db_symbol == weather_to_cancel
          handler.logic.weather_change_handler.weather_change(:none, 0)
          handler.scene.display_message_and_wait(weather_cancel_text)
        end
        user.effects.each { |e| e.kill if e.rapid_spin_affected? }
        logic.bank_effects.each_with_index do |bank_effect, bank_index|
          bank_effect.each do |e|
            e.kill if e.rapid_spin_affected?
            e.kill if bank_index != user.bank && effects_to_kill.include?(e.name)
          end
        end
      end
      # List of the effects to kill on the enemy board
      # @return [Array<Symbol>]
      def effects_to_kill
        return %i[light_screen reflect safeguard mist aurora_veil]
      end
      # The type of weather the Move can cancel
      # @return [Symbol]
      def weather_to_cancel
        return :fog
      end
      # The message displayed when the right weather is canceled
      # @return [String]
      def weather_cancel_text
        return parse_text(18, 98)
      end
    end
    Move.register(:s_defog, Defog)
    public
    # Class that manage DestinyBond move. Works together with Effects::DestinyBond.
    # @see https://pokemondb.net/move/destiny-bond
    # @see https://bulbapedia.bulbagarden.net/wiki/Destiny_Bond_(move)
    # @see https://www.pokepedia.fr/Lien_du_Destin
    class DestinyBond < Move
      private
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if target.effects.has?(:destiny_bond)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 626, user))
        user.effects.add(Effects::DestinyBond.new(logic, user))
      end
    end
    Move.register(:s_destiny_bond, DestinyBond)
    public
    # Disable move
    class Disable < Move
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        return failure_message unless target.move_history.last
        return failure_message if target.effects.has?(:disable)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          move = target.move_history&.last&.original_move
          next unless move
          message = parse_text_with_pokemon(19, 592, target, PFM::Text::MOVE[1] => move.name)
          target.effects.add(Effects::Disable.new(@logic, target, move))
          @scene.display_message_and_wait(message)
        end
      end
      private
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
        @logic.scene.display_message_and_wait(parse_text(18, 74))
        return true
      end
    end
    Move.register(:s_disable, Disable)
    public
    class DoubleIronBash < TwoHit
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return target.effects.has?(:minimize) ? power * 2 : power
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return target.effects.has?(:minimize) ? true : super
      end
    end
    Move.register(:s_double_iron_bash, DoubleIronBash)
    public
    # Class managing Dragon Cheer move
    class DragonCheer < Move
      UNSTACKABLE_EFFECTS = %i[dragon_cheer focus_energy triple_arrows]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? || targets.all? { |target| UNSTACKABLE_EFFECTS.any? { |e| target.effects.has?(e) } }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if UNSTACKABLE_EFFECTS.any? { |e| target.effects.has?(e) }
          target.effects.add(Effects::DragonCheer.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1047, target))
        end
      end
    end
    Move.register(:s_dragon_cheer, DragonCheer)
    public
    class DragonDarts < Basic
      private
      # Create a new move
      # @param db_symbol [Symbol] db_symbol of the move in the database
      # @param pp [Integer] number of pp the move currently has
      # @param ppmax [Integer] maximum number of pp the move currently has
      # @param scene [Battle::Scene] current battle scene
      def initialize(db_symbol, pp, ppmax, scene)
        super
        @allies_targets = nil
        @all_targets = nil
      end
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
        actual_targets = determine_targets(user, targets)
        return user.add_move_to_history(self, targets) unless actual_targets
        post_accuracy_check_effects(user, actual_targets)
        post_accuracy_check_move(user, actual_targets)
        play_animation(user, targets)
        deal_damage(user, actual_targets) && effect_working?(user, actual_targets) && deal_status(user, actual_targets) && deal_stats(user, actual_targets) && deal_effect(user, actual_targets)
        user.add_move_to_history(self, actual_targets)
        user.add_successful_move_to_history(self, actual_targets)
        @scene.visual.set_info_state(:move_animation)
        @scene.visual.wait_for_animation
      end
      # Determine which targets the user will focus
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>, nil]
      def determine_targets(user, targets)
        @allies_targets = nil
        original_targets = targets.first
        actual_targets = proceed_internal_precheck(user, targets)
        if $game_temp.vs_type == 1
          return actual_targets.empty? ? nil : actual_targets
        end
        return actual_targets if actual_targets && original_targets.bank == user.bank
        if actual_targets.nil? && original_targets.bank != user.bank
          return if original_targets.effects.has?(:center_of_attention)
          actual_targets = @logic.allies_of(original_targets, true)
          actual_targets = actual_targets.sample if actual_targets.length > 1
          actual_targets = proceed_internal_precheck(user, actual_targets)
          return actual_targets.nil? ? nil : actual_targets
        end
        unless original_targets.effects.has?(:center_of_attention)
          @allies_targets = @logic.allies_of(original_targets, true)
          @allies_targets = @allies_targets.sample if @allies_targets.length > 1
        end
        return actual_targets
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        @user = user
        @actual_targets = actual_targets
        @nb_hit = 0
        @hit_amount = 2
        @all_targets = nil
        @all_targets = actual_targets unless actual_targets.nil?
        @all_targets += @allies_targets unless @allies_targets.nil?
        @hit_amount.times do |i|
          target = @all_targets[i % @all_targets.size]
          next(false) unless target.alive?
          next(false) if user.dead?
          if @allies_targets == [target]
            result = proceed_internal_precheck(user, [target])
            return if result.nil?
          end
          @nb_hit += 1
          play_animation(user, [target]) if @nb_hit > 1
          hp = damages(user, target)
          @logic.damage_handler.damage_change_with_process(hp, target, user, self) do
            if critical_hit?
              scene.display_message_and_wait(@all_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
            else
              if hp > 0 && @nb_hit == @hit_amount
                efficent_message(effectiveness, target)
              end
            end
          end
          recoil(hp, user) if recoil?
        end
        @scene.display_message_and_wait(parse_text(18, 33, PFM::Text::NUMB[1] => @nb_hit.to_s))
        return false if user.dead?
        return true
      end
      # Check if this the last hit of the move
      # Don't call this method before deal_damage method call
      # @return [Boolean]
      def last_hit?
        return true if @user.dead?
        return true unless @all_targets.all?(&:alive?)
        return @hit_amount == @nb_hit
      end
      # Tells if the move hits multiple times
      # @return [Boolean]
      def multi_hit?
        return true
      end
    end
    Move.register(:s_dragon_darts, DragonDarts)
    public
    # Echoed Voice deals damage starting at base power 40, and increases by 40 each turn if used by any
    # Pokémon on the field, up to a maximum base power of 200.
    # @see https://pokemondb.net/move/echoed-voice
    # @see https://bulbapedia.bulbagarden.net/wiki/Echoed_Voice_(move)
    # @see https://www.pokepedia.fr/%C3%89cho_(capacit%C3%A9)
    class EchoedVoice < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        mod = logic.terrain_effects.get(:echoed_voice)&.successive_turns || 1
        real_power = (super + (echo_boost * mod)).clamp(0, max_power)
        log_data("power = #{real_power} \# echoed voice successive turns #{mod}")
        return real_power
      end
      private
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
        logic.terrain_effects.add(Effects::EchoedVoice.new(logic)) unless logic.terrain_effects.has?(:echoed_voice)
        logic.terrain_effects.get(:echoed_voice).increase
        super
      end
      # Boost added to the power for each turn where the move has been used
      # @return [Integer]
      def echo_boost
        40
      end
      # Maximum value of the power
      # @return [Integer]
      def max_power
        200
      end
    end
    register(:s_echo, EchoedVoice)
    public
    class EerieSpell < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.all? { |target| target.move_history.any? && target.skills_set[find_last_skill_position(target)]&.pp != 0 }
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          last_skill = find_last_skill_position(target)
          next if target.move_history.empty? || target.skills_set[last_skill].pp == 0
          num = 3.clamp(1, target.skills_set[last_skill].pp)
          target.skills_set[last_skill].pp -= num
          scene.display_message_and_wait(parse_text_with_pokemon(19, 641, target, PFM::Text::MOVE[1] => target.skills_set[last_skill].name, '[VAR NUM1(0002)]' => num.to_s))
        end
      end
      # Find the last skill used position in the moveset of the Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Integer]
      def find_last_skill_position(pokemon)
        pokemon.skills_set.each_with_index do |skill, i|
          return i if skill && skill.id == pokemon.move_history.last.move.id
        end
        return 0
      end
    end
    Move.register(:s_eerie_spell, EerieSpell)
    public
    # Move that inflict electrify to the ennemy
    class Electrify < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:change_type)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::Electrify.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1195, target))
        end
      end
    end
    Move.register(:s_electrify, Electrify)
    public
    class ElectroBall < Basic
      # List of all base power depending on the speed ration between target & user
      BASE_POWERS = [[0.25, 150], [0.33, 120], [0.5, 80], [1, 60], [Float::INFINITY, 40]]
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        ratio = target.spd / user.spd.to_f
        return BASE_POWERS.find { |(first)| first > ratio }&.last || 40
      end
    end
    Move.register(:s_electro_ball, ElectroBall)
    public
    # The user gathers electricity on the first turn, boosting its Sp. Atk stat, then fires a high-voltage shot on the next turn. The shot will be fired immediately in rain.
    class ElectroShot < TwoTurnBase
      # Check if the two turn move is executed in one turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def shortcut?(user, targets)
        return true if $env.rain? || $env.hardrain?
        super
      end
    end
    Move.register(:s_electro_shot, ElectroShot)
    public
    # Embargo prevents the target using any items for five turns. This includes both held items and items used by the trainer such as medicines.
    # @see https://pokemondb.net/move/embargo
    # @see https://bulbapedia.bulbagarden.net/wiki/Embargo_(move)
    # @see https://www.pokepedia.fr/Embargo
    class Embargo < Move
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        return true if target.effects.has?(effect_symbol)
        return false
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(effect_symbol)
          target.effects.add(create_effect(user, target))
          scene.display_message_and_wait(proc_message(user, target))
        end
      end
      # Symbol name of the effect
      # @return [Symbol]
      def effect_symbol
        :embargo
      end
      # Duration of the effect including the current turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::EffectBase]
      def create_effect(user, target)
        Effects::Embargo.new(logic, target, 5)
      end
      def proc_message(user, target)
        return parse_text_with_pokemon(19, 727, target)
      end
    end
    Move.register(:s_embargo, Embargo)
    public
    # Move that forces the target to use the move previously used during 3 turns
    class Encore < Move
      # List of move the target cannot use with encore
      NO_ENCORE_MOVES = %i[encore mimic mirror_move sketch struggle transform]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.empty?
        @verified = result = verify_targets(targets)
        show_usage_failure(user) unless result
        return result
      end
      private
      # Test if the move that should be forced is disallowed to be forced or not
      # @param db_symbol [Symbol]
      # @return [Boolean]
      def move_disallowed?(db_symbol)
        return NO_ENCORE_MOVES.include?(db_symbol)
      end
      # Verify all the targets and tell if the move can continue
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [Boolean]
      def verify_targets(targets)
        targets.any? do |target|
          next(false) unless target
          next(false) if cant_encore_target?(target)
          next(true)
        end
      end
      # Tell if the target can be Encore'd
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def cant_encore_target?(target)
        last_move = target.move_history.last
        has_forced_effect = target.effects.has? { |e| e.force_next_move? && !e.dead? }
        return true if !last_move || has_forced_effect || move_disallowed?(last_move.db_symbol) || last_move.original_move.pp <= 0
        return true if target.effects.has?(:shell_trap)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        if !@verified && verify_targets(actual_targets)
          show_usage_failure(user)
          @verified = nil
          return false
        end
        actual_targets.each do |target|
          next unless target && !cant_encore_target?(target)
          move_history = target.move_history.last
          target.effects.add(effect = create_effect(move_history.original_move, target, move_history.targets))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 559, target))
          if (index = logic.actions.find_index { |action| action.is_a?(Actions::Attack) && action.launcher == target })
            logic.actions[index] = effect.make_action
          end
        end
      end
      # Create the effect
      # @param move [Battle::Move] move that was used by target
      # @param target [PFM::PokemonBattler] target that used the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Effects::Encore]
      def create_effect(move, target, actual_targets)
        return Effects::Encore.new(logic, target, move, actual_targets)
      end
    end
    Move.register(:s_encore, Encore)
    public
    class Endeavor < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.all? { |target| user.hp >= target.hp }
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.hp > user.hp
          hp = target.hp - user.hp
          logic.damage_handler.damage_change(hp, target)
        end
      end
    end
    Move.register(:s_endeavor, Endeavor)
    public
    class Eruption < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return (power * user.hp_rate).clamp(1, Float::INFINITY)
      end
    end
    Move.register(:s_eruption, Eruption)
    public
    # class managing Fake Out move
    class FakeOut < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return unless super
        if user.turn_count > 1 || user.effects.has?(:instruct)
          show_usage_failure(user)
          return false
        end
        return true
      end
    end
    Move.register(:s_fake_out, FakeOut)
    public
    class FalseSwipe < Basic
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        hp_total = super
        hp_total = target.hp - 1 if hp_total >= target.hp && !target.effects.has?(:substitute)
        return hp_total
      end
    end
    Move.register(:s_false_swipe, FalseSwipe)
    public
    # Class managing moves that deal a status or flinch
    class Fangs < Basic
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
        return true if status_effects.empty?
        status = bchance?(0.5) ? status_effects[0].status : :flinch
        actual_targets.each do |target|
          @logic.status_change_handler.status_change_with_process(status, target, user, self)
        end
      end
    end
    Move.register(:s_a_fang, Fangs)
    public
    # Feint has an increased power if the target used Protect or Detect during this turn. It lift the effects of protection moves.
    # @see https://pokemondb.net/move/feint
    # @see https://bulbapedia.bulbagarden.net/wiki/Feint_(move)
    # @see https://www.pokepedia.fr/Ruse
    class Feint < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return increased_power if target.successful_move_history.any? && increased_power_move?(target.successful_move_history.last)
        return super
      end
      # Detect if the move is protected by another move on target
      # @param target [PFM::PokemonBattler]
      # @param symbol [Symbol]
      def blocked_by?(target, symbol)
        return false unless super
        return !target.effects.has?(:protect)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.each do |effect|
            next unless lifted_effect?(effect)
            effect.kill
            scene.display_message_and_wait(deal_message(user, target, effect))
          end
        end
      end
      INCREASED_POWER_MOVES = %i[s_protect s_crafty_shield]
      # Does the move increase the attack power ?
      # @param successful_move_history [PFM::PokemonBattler::SuccessfulMoveHistory]
      # @return [Boolean]
      def increased_power_move?(successful_move_history)
        successful_move_history.current_turn? && INCREASED_POWER_MOVES.include?(successful_move_history.move.be_method)
      end
      # Increased power value
      # @return [Integer]
      def increased_power
        50
      end
      LIFTED_EFFECTS = %i[protect crafty_shield]
      # Is the effect lifted by the move
      # @param effect [Battle::Effects::EffectBase]
      # @return [Boolean]
      def lifted_effect?(effect)
        LIFTED_EFFECTS.include?(effect.name)
      end
      # Message display when the move lift an effect
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param effect [Battle::Effects::EffectBase]
      # @return [String]
      def deal_message(user, target, effect)
        parse_text_with_pokemon(19, 526, target)
      end
    end
    Move.register(:s_feint, Feint)
    public
    class FellStinger < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any?(&:dead?)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        actual_targets.each do |target|
          next if target.alive?
          logic.stat_change_handler.stat_change_with_process(:atk, 3, user)
          if user.ability_effect.is_a?(Effects::Ability::Moxie)
            user.ability_effect.on_post_damage_death(logic.damage_handler, target.damage_history.last.damage, target, user, self)
          end
        end
      end
    end
    Move.register(:s_fell_stinger, FellStinger)
    public
    # Fickle Beam has 20% chance of doubling its base power.
    class FickleBeam < Basic
      # Function which permit things to happen before the move's animation
      def post_accuracy_check_move(user, actual_targets)
        @empowered = false
        if bchance?(0.3, logic)
          @empowered = true
          scene.display_message_and_wait(parse_text_with_pokemon(19, 547, user))
        end
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power * (@empowered ? 2 : 1)
      end
    end
    Move.register(:s_fickle_beam, FickleBeam)
    public
    class FinalGambit < Move
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        hp_dealt = user.hp
        logic.damage_handler.damage_change(hp_dealt, user)
        actual_targets.each do |target|
          scene.logic.damage_handler.damage_change_with_process(hp_dealt, target, user, self)
        end
      end
    end
    Move.register(:s_final_gambit, FinalGambit)
    public
    class FishiousRend < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        n = 1
        n *= damage_multiplier if logic.battler_attacks_before?(user, target) || target.switching?
        return super * n
      end
      private
      # Damage multiplier if the effect procs
      # @return [Integer, Float]
      def damage_multiplier
        return 2
      end
    end
    register(:s_fishious_rend, FishiousRend)
    public
    # Class managing fixed damages moves
    class FixedDamages < Basic
      FIXED_DMG_PARAM = {sonic_boom: 20, dragon_rage: 40}
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        @critical = false
        @effectiveness = 1
        dmg = FIXED_DMG_PARAM[db_symbol]
        log_data("Fixed Damages Move: #{dmg} HP")
        return dmg || 1
      end
    end
    Move.register(:s_fixed_damage, FixedDamages)
    public
    class Flail < Basic
      Flail_HP = [0.7, 0.35, 0.2, 0.10, 0.04, 0]
      Flail_Pow = [20, 40, 80, 100, 150, 200]
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        index = Flail_HP.find_index { |i| i < user.hp_rate }
        return Flail_Pow[index]
      end
    end
    Move.register(:s_flail, Flail)
    public
    # Flame Burst deals damage and will also cause splash damage to any Pokémon adjacent to the target.
    class FlameBurst < Basic
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        super
        actual_targets.each do |actual_target|
          targets = logic.adjacent_allies_of(actual_target)
          targets.each do |target|
            next if target.has_ability?(:magic_guard)
            hp = calc_splash_damage(target)
            logic.damage_handler.damage_change(hp, target)
          end
        end
      end
      private
      # Calculate the damage dealt by the splash
      # @param target [PFM::PokemonBattler] target of the splash
      # @return [Integer]
      def calc_splash_damage(target)
        return (target.max_hp / 16).clamp(1, target.hp)
      end
    end
    register(:s_flame_burst, FlameBurst)
    public
    # Power and effects depends on held item.
    class Fling < Basic
      include Mechanics::PowerBasedOnItem
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless @thrown_item_effect.respond_to?(:apply_common_effects_with_fling)
          @thrown_item_effect.apply_common_effects_with_fling(scene, target, user, self)
        end
      ensure
        @thrown_item_effect = nil
      end
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
        return true
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
        return (data_item(name).fling_power || 0) > 0
      end
      # Get the real power of the move depending on the item
      # @param name [Symbol]
      # @return [Integer]
      def get_power_by_item(name)
        return data_item(name).fling_power || 0
      end
    end
    Move.register(:s_fling, Fling)
    public
    # Flower Heal move
    class FloralHealing < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          hp = @logic.field_terrain_effect.grassy? ? target.max_hp * 2 / 3 : target.max_hp / 2
          logic.damage_handler.heal(target, hp)
        end
      end
    end
    Move.register(:s_floral_healing, FloralHealing)
    public
    # Class that manage the Flower Shield move
    # @see https://bulbapedia.bulbagarden.net/wiki/Flower_Shield_(move)
    # @see https://pokemondb.net/move/flower-shield
    # @see https://www.pokepedia.fr/Garde_Florale
    class FlowerShield < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user?(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless targets.any? { |target| target.type_grass? && !target.effects.has?(&:out_of_reach?) }
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return super || !target.type_grass? || target.effects.has?(&:out_of_reach?)
      end
      private
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        actual_targets.each do |target|
          @logic.stat_change_handler.stat_change_with_process(:dfe, 1, target, user, self)
        end
      end
    end
    Move.register(:s_flower_shield, FlowerShield)
    public
    # Move that has a flying type as second type
    class FlyingPress < Basic
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        super << data_type(second_type).id
      end
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        return target.effects.has?(:minimize) ? super * 2 : super
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true if target.effects.has?(:minimize)
        super
      end
      private
      # Get the second type of the move
      # @return [Symbol]
      def second_type
        return :flying
      end
    end
    Move.register(:s_flying_press, FlyingPress)
    public
    # Class managing Focus Energy move
    class FocusEnergy < Move
      UNSTACKABLE_EFFECTS = %i[dragon_cheer focus_energy triple_arrows]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |target| UNSTACKABLE_EFFECTS.any? { |e| target.effects.has?(e) } }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if UNSTACKABLE_EFFECTS.any? { |e| target.effects.has?(e) }
          target.effects.add(Effects::FocusEnergy.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1047, target))
        end
      end
    end
    Move.register(:s_focus_energy, FocusEnergy)
    public
    # Move that inflict Spikes to the enemy bank
    class FollowMe < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if logic.battle_info.vs_type == 1 || logic.battler_attacks_last?(user) || any_battler_with_follow_me_effect?(user)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(Effects::CenterOfAttention.new(logic, user, 1, self))
        scene.display_message_and_wait(parse_text_with_pokemon(19, 670, user))
      end
      # Test if any alive battler used followMe this turn
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def any_battler_with_follow_me_effect?(user)
        last_move_history = logic.adjacent_allies_of(user).map { |battler| battler.successful_move_history.last }.compact
        return last_move_history.any? { |move_history| move_history.current_turn? && move_history.move.be_method == :s_follow_me }
      end
    end
    Move.register(:s_follow_me, FollowMe)
    public
    # Class managing moves that force the target switch
    # Roar, Whirlwind, Dragon Tail, Circle Throw
    class ForceSwitch < BasicWithSuccessfulEffect
      # Tell if the move is a move that forces target switch
      # @return [Boolean]
      def force_switch?
        return true
      end
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return true unless be_method == :s_roar
        return show_usage_failure(user) && false unless can_be_used?(user, targets)
        return true
      end
      # Check if the move will fail when used
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean] if the procedure can continue
      def can_be_used?(user, targets)
        return false if targets.all? { |target| target.effects.has?(:crafty_shield) || target.has_ability?(:guard_dog) }
        return false if @logic.battle_info.trainer_battle? && targets.none? { |target| @logic.can_battler_be_replaced?(target) }
        return true
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true unless target.effects.has?(&:out_of_reach?) && be_method == :s_roar
        super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next(false) unless @logic.switch_handler.can_switch?(target, self) && user.alive?
          next(false) if target.effects.has?(:substitute) && be_method == :s_dragon_tail
          next(false) if target.has_ability?(:guard_dog)
          next(false) if @logic.switch_request.any? { |request| request[:who] == target }
          if !@logic.battle_info.trainer_battle? && @logic.alive_battlers_without_check(target.bank).size == 1 && target.bank == 1 && user.level >= target.level && !$game_switches[Yuki::Sw::BT_NoEscape]
            @battler_s = @scene.visual.battler_sprite(target.bank, target.position)
            @battler_s.flee_animation
            @logic.scene.visual.wait_for_animation
            @logic.battle_result = 1
          end
          rand_pkmn = (@logic.alive_battlers_without_check(target.bank).select { |p| p if p.party_id == target.party_id && p.position == -1 }).compact
          @logic.actions.reject! { |a| a.is_a?(Actions::Attack) && a.launcher == target }
          @logic.switch_request << {who: target, with: rand_pkmn.sample} unless rand_pkmn.empty?
        end
      end
    end
    Move.register(:s_dragon_tail, ForceSwitch)
    Move.register(:s_roar, ForceSwitch)
    public
    # Move that makes possible to hit Ghost type Pokemon with Normal or Fighting type moves
    class Foresight < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::Foresight.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 369, target))
        end
      end
    end
    Move.register(:s_foresight, Foresight)
    public
    # Class managing Foul Play move
    class FoulPlay < Basic
      # Get the basis atk for the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_sp_atk_basis(user, target, ph_move)
        return ph_move ? target.atk_basis : target.ats_basis
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
        return 1 if critical_hit?
        return ph_move ? target.atk_modifier : target.ats_modifier
      end
    end
    Move.register(:s_foul_play, FoulPlay)
    public
    class FreezyFrost < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return @logic.all_alive_battlers.each { |battler| battler.battle_stage.any? { |stage| stage != 0 } }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @logic.all_alive_battlers.each do |battler|
          next if battler.battle_stage.all?(&:zero?)
          battler.battle_stage.map! {0 }
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 195, battler))
        end
      end
    end
    Move.register(:s_freezy_frost, FreezyFrost)
    public
    class Frustration < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power = (255 - user.loyalty) / 2.5
        power.floor.clamp(1, 102)
        log_data("Frustration power: #{power}")
        return power
      end
    end
    Move.register(:s_frustration, Frustration)
    public
    # Move that inflict a critical hit
    class FullCrit < Basic
      # Return the critical rate index of the skill
      # @return [Integer]
      def critical_rate
        return 100
      end
    end
    Move.register(:s_full_crit, FullCrit)
    public
    # Fury Cutter starts with a base power of 10. Every time it is used successively, its power will double, up to a maximum of 160.
    # @see https://bulbapedia.bulbagarden.net/wiki/Fury_Cutter_(move)
    # @see https://pokemondb.net/move/fury-cutter
    # @see https://www.pokepedia.fr/Taillade
    class FuryCutter < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        successive_uses = (user.effects.get(effect_name)&.successive_uses || 0) + 1
        fury_cutter_power = (super * 2 ** (successive_uses - 1)).clamp(0, max_power)
        log_data('power = %i # %s effect %i successive uses' % [fury_cutter_power, effect_name, successive_uses])
        return fury_cutter_power
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(create_effect(user, actual_targets)) unless user.effects.has?(effect_name)
        user.effects.get(effect_name).increase
      end
      # Max base power of the move.
      # @return [Integer]
      def max_power
        160
      end
      # Class of the effect
      # @return [Symbol]
      def effect_name
        :fury_cutter
      end
      # Create the move effect object
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Battle::Effects::EffectBase]
      def create_effect(user, actual_targets)
        Battle::Effects::FuryCutter.new(logic, user, self)
      end
    end
    Move.register(:s_fury_cutter, FuryCutter)
    public
    class FusionFlare < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        n = 1
        n *= 2 if boosted_move?(user, target)
        return super * n
      end
      # Tell if the move will be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted_move?(user, target)
        other_move_actions = logic.turn_actions.select do |a|
          a.is_a?(Actions::Attack) && Actions::Attack.from(a).launcher != user && Actions::Attack.from(a).move.db_symbol == fusion_move
        end
        return false if other_move_actions.empty?
        return other_move_actions.any? do |move_action|
          other = Actions::Attack.from(move_action).launcher
          next(false) unless user.attack_order > other.attack_order && other.last_successful_move_is?(fusion_move)
          next(user.attack_order == other.attack_order.next)
        end
      end
      # Get the other move triggering the damage boost
      # @return [db_symbol]
      def fusion_move
        return :fusion_bolt
      end
    end
    class FusionBolt < FusionFlare
      def fusion_move
        return :fusion_flare
      end
    end
    Move.register(:s_fusion_flare, FusionFlare)
    Move.register(:s_fusion_bolt, FusionBolt)
    public
    # Future Sight deals damage, but does not hit until two turns after the move is used. 
    # If the opponent switched Pokémon in the meantime, the new Pokémon gets hit, 
    # with their type and stats taken into account.
    # @see https://pokemondb.net/move/future-sight
    # @see https://bulbapedia.bulbagarden.net/wiki/Future_Sight_(move)
    # @see https://www.pokepedia.fr/Prescience
    class FutureSight < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |t| @logic.position_effects[t.bank][t.position].has?(:future_sight) }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        log_data("FutureSight targets : #{actual_targets}")
        actual_targets.each do |target|
          next if @logic.position_effects[target.bank][target.position].has?(:future_sight)
          @logic.add_position_effect(create_effect(user, target))
          @scene.display_message_and_wait(deal_message(user, target))
        end
      end
      # Hash containing the countdown for each "Future Sight"-like move
      # @return [Hash]
      COUNTDOWN = {future_sight: 3, doom_desire: 3}
      # Return the right countdown depending on the move, or a static one
      # @return [Integer]
      def countdown
        return COUNTDOWN[db_symbol] || 3
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::PositionTiedEffectBase]
      def create_effect(user, target)
        Effects::FutureSight.new(@logic, target.bank, target.position, user, countdown, self)
      end
      # Message displayed when the effect is dealt
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      def deal_message(user, target)
        parse_text_with_pokemon(19, 1080, user)
      end
    end
    Move.register(:s_future_sight, FutureSight)
    public
    # Move that inflict leech seed to the ennemy
    class GastroAcid < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:ability_suppressed) || !@logic.ability_change_handler.can_change_ability?(target)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::AbilitySuppressed.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 565, target))
        end
      end
    end
    Move.register(:s_gastro_acid, GastroAcid)
    public
    # Gear Up move
    class GearUp < Move
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| %i[minus plus].include?(target.ability_db_symbol) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless %i[minus plus].include?(target.ability_db_symbol)
          scene.logic.stat_change_handler.stat_change_with_process(:atk, 1, target, user, self)
          scene.logic.stat_change_handler.stat_change_with_process(:ats, 1, target, user, self)
        end
      end
    end
    Move.register(:s_gear_up, GearUp)
    public
    # Accuracy depends of weather.
    # @see https://pokemondb.net/move/thunder
    # @see https://bulbapedia.bulbagarden.net/wiki/Bleakwind_Storm_(move)
    # @see https://bulbapedia.bulbagarden.net/wiki/Wildbolt_Storm_(move)
    # @see https://bulbapedia.bulbagarden.net/wiki/Sandsear_Storm_(move)
    # @see https://www.pokepedia.fr/Typhon_Hivernal
    # @see https://www.pokepedia.fr/Typhon_Fulgurant
    # @see https://www.pokepedia.fr/Typhon_Pyrosable
    # @note Springtide does NOT work the same.
    class GeniesStorm < Basic
      # Return the current accuracy of the move
      # @return [Integer]
      def accuracy
        al = @scene.logic.all_alive_battlers.any? { |battler| battler.has_ability?(:cloud_nine) || battler.has_ability?(:air_lock) }
        return super if al
        return 0 if $env.rain? || $env.hardrain?
        return super
      end
    end
    Move.register(:s_genies_storm, GeniesStorm)
    public
    # Class managing the Geomancy move
    # @see https://pokemondb.net/move/geomancy
    class Geomancy < TwoTurnBase
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          @logic.stat_change_handler.stat_change_with_process(:ats, 2, target, user, self)
          @logic.stat_change_handler.stat_change_with_process(:dfs, 2, target, user, self)
          @logic.stat_change_handler.stat_change_with_process(:spd, 2, target, user, self)
        end
      end
    end
    Move.register(:s_geomancy, Geomancy)
    public
    # Gigaton Hammer can't be selected twice in a row
    class GigatonHammer < Basic
      # Get the reason why the move is disabled
      # @param user [PFM::PokemonBattler] user of the move
      # @return [#call] Block that should be called when the move is disabled
      def disable_reason(user)
        return unless user.move_history&.last&.db_symbol == db_symbol
        return proc {@logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 911, user, PFM::Text::MOVE[1] => name)) }
      end
    end
    Move.register(:s_gigaton_hammer, GigatonHammer)
    public
    # Glaive Rush doubles the damage taken during the same turn and the turn after.
    class GlaiveRush < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(Effects::GlaiveRush.new(logic, user))
      end
    end
    Move.register(:s_glaive_rush, GlaiveRush)
    public
    class GlitzyGlow < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return !@logic.bank_effects[user.bank].has?(effect)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        turn_count = user.hold_item?(:light_clay) ? 8 : 5
        @logic.bank_effects[user.bank].add(class_effect.new(@logic, user.bank, 0, turn_count))
        @scene.display_message_and_wait(parse_text(18, message + user.bank.clamp(0, 1)))
      end
      # Get the effect to check
      def effect
        :light_screen
      end
      # Get the new effect to deal
      def class_effect
        Effects::LightScreen
      end
      # Get the message to display
      def message
        134
      end
    end
    class BaddyBad < GlitzyGlow
      # Get the effect to check
      def effect
        :reflect
      end
      # Get the new effect to deal
      def class_effect
        Effects::Reflect
      end
      # Get the message to display
      def message
        130
      end
    end
    Move.register(:s_glitzy_glow, GlitzyGlow)
    Move.register(:s_baddy_bad, BaddyBad)
    public
    class GravApple < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power *= 1.5 if @logic.terrain_effects.has?(:gravity)
        return power
      end
    end
    Move.register(:s_grav_apple, GravApple)
    public
    class Gravity < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if logic.terrain_effects.has?(:gravity)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.terrain_effects.add(Effects::Gravity.new(@scene.logic))
      end
    end
    Move.register(:s_gravity, Gravity)
    public
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class Growth < SelfStat
      def deal_stats(user, actual_targets)
        battle_stage_mod.each do |stage|
          if $env.sunny? || $env.hardsun?
            @logic.stat_change_handler.stat_change_with_process(stage.stat, 2, user, user, self)
          else
            @logic.stat_change_handler.stat_change_with_process(stage.stat, 1, user, user, self)
          end
        end
      end
    end
    Move.register(:s_growth, Growth)
    public
    # Class managing Grudge move
    class Grudge < Move
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.all? { |target| !target.effects.has?(:grudge) }
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:grudge)
          target.effects.add(Effects::Grudge.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 632, target))
        end
      end
    end
    Move.register(:s_grudge, Grudge)
    public
    class GyroBall < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power = 25 * (target.spd / user.spd)
        power.clamp(1, 150)
        log_data("Gyro Ball power: #{power}")
        return power
      end
    end
    Move.register(:s_gyro_ball, GyroBall)
    public
    # Class managing moves that deal damages equivalent level
    class HPEqLevel < Basic
      private
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        @critical = false
        @effectiveness = 1
        log_data("Damages equivalent to the user Level Move: #{user.level} HP")
        return user.level || 1
      end
    end
    # Class managing Psywave
    class Psywave < Basic
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        @critical = false
        @effectiveness = 1
        n = (user.level * (logic.move_damage_rng.rand(1..100) + 50) / 100).floor
        n.clamp(1, Float::INFINITY)
        log_data("Damages random between 0.5x and 1.5x of the user Level Move: #{n} HP")
        return n || 1
      end
    end
    Move.register(:s_psywave, Psywave)
    Move.register(:s_hp_eq_level, HPEqLevel)
    public
    # class managing HappyHour move
    class HappyHour < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return false if logic.terrain_effects.has?(:happy_hour)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param _user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(_user, _actual_targets)
        logic.terrain_effects.add(Effects::HappyHour.new(logic))
        scene.display_message_and_wait(parse_text(18, 255))
      end
    end
    Move.register(:s_happy_hour, HappyHour)
    public
    # Adds a layer of Stealth Rocks to the target if it lands.
    class StoneAxe < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        return if @logic.bank_effects[bank]&.get(:stealth_rock)
        @logic.add_bank_effect(Effects::StealthRock.new(@logic, bank, self))
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 162 : 163))
      end
      # Calculate the multiplier needed to get the damage factor of the Stealth Rock
      # @param target [PFM::PokemonBattler]
      # @return [Integer, Float]
      def calc_factor(target)
        type = [self.type]
        @effectiveness = -1
        n = calc_type_n_multiplier(target, :type1, type) * calc_type_n_multiplier(target, :type2, type) * calc_type_n_multiplier(target, :type3, type)
        return n
      end
    end
    # Adds a layer of Spikes to the target if it lands.
    class CeaselessEdge < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        return if @logic.bank_effects[bank]&.get(:spikes)&.max_power?
        if (effect = @logic.bank_effects[bank]&.get(:spikes))
          effect.empower
        else
          @logic.add_bank_effect(Effects::Spikes.new(@logic, bank))
        end
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 154 : 155))
      end
    end
    Move.register(:s_stone_axe, StoneAxe)
    Move.register(:s_ceaseless_edge, CeaselessEdge)
    public
    # Move that resets stats of all pokemon on the field
    class Haze < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return true if db_symbol != :haze
        if targets.none? { |target| target.battle_stage.any? { |stage| stage != 0 } }
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.battle_stage.none? { |stage| stage != 0 }
          target.battle_stage.map! {0 }
          scene.display_message_and_wait(parse_text_with_pokemon(19, 195, target))
        end
      end
    end
    Move.register(:s_haze, Haze)
    public
    # Class describing a heal move
    class HealBell < Move
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        if target.has_ability?(:soundproof)
          scene.visual.show_ability(target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 210, target))
          return true
        end
        return false
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets = scene.logic.all_battlers.select { |p| p.bank == user.bank && p.party_id == user.party_id && p.alive? } unless db_symbol == :refresh
        target_cure = false
        targets.each do |target|
          next if target.status == 0
          scene.logic.status_change_handler.status_change(:cure, target)
          target_cure = true
        end
        scene.display_message_and_wait(parse_text(18, 70)) unless target_cure
      end
    end
    Move.register(:s_heal_bell, HealBell)
    public
    # Move that rectricts the targets from healing in certain ways for five turns
    class HealBlock < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::HealBlock.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 884, target))
        end
      end
    end
    Move.register(:s_heal_block, HealBlock)
    public
    # Class describing a heal move
    class HealWeather < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          if $env.normal? || $env.strong_winds?
            hp = target.max_hp / 2
          else
            if $env.sunny? || $env.hardsun?
              hp = target.max_hp * 2 / 3
            else
              hp = target.max_hp / 4
            end
          end
          hp = hp * 3 / 2 if pulse? && user.has_ability?(:mega_launcher)
          logic.damage_handler.heal(target, hp)
        end
      end
    end
    Move.register(:s_heal_weather, HealWeather)
    public
    class HealingSacrifice < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        unless @logic.can_battler_be_replaced?(user)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          add_effect(target)
          logic.damage_handler.damage_change(target.hp, target)
          @logic.switch_request << {who: target}
        end
      end
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
        log_error('Move Implementation Error: add_effect should be overwritten in child class.')
      end
    end
    class HealingWish < HealingSacrifice
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
        target.effects.add(Effects::HealingWish.new(@logic, target))
      end
    end
    class LunarDance < HealingSacrifice
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
        target.effects.add(Effects::LunarDance.new(@logic, target))
      end
    end
    Move.register(:s_healing_wish, HealingWish)
    Move.register(:s_lunar_dance, LunarDance)
    public
    class HeavySlam < Basic
      MINIMUM_WEIGHT_PERCENT = [0.5, 0.3334, 0.25, 0.20]
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        target_weight = (target.weight != target.data.weight) ? (user.can_be_lowered_or_canceled? ? target.weight : target.data.weight) : target.weight
        weight_percent = target_weight.to_f / user.weight
        weight_index = MINIMUM_WEIGHT_PERCENT.find_index { |weight| weight_percent > weight } || MINIMUM_WEIGHT_PERCENT.size
        minimize_factor = target.effects.has?(:minimize) ? 2 : 1
        return (40 + 20 * weight_index) * minimize_factor
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true if target.effects.has?(:minimize)
        super
      end
    end
    Move.register(:s_heavy_slam, HeavySlam)
    public
    # In Double Battles, boosts the power of the partner's move.
    # @see https://pokemondb.net/move/helping-hand
    # @see https://bulbapedia.bulbagarden.net/wiki/Helping_Hand_(move)
    # @see https://www.pokepedia.fr/Coup_d%27Main
    class HelpingHand < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.reject { |t| t == user }.empty? || logic.battle_info.vs_type == 1 || targets.all? { |t| t.effects.has?(:helping_hand) }
          return show_usage_failure(user) && false
        end
        return true
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:helping_hand_mark)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:helping_hand)
          user.effects.add(create_effect(user, target))
          scene.display_message_and_wait(deal_message(user, target))
        end
      end
      # Create the effect given to the target
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] targets that will be affected by the move
      # @return [Effects::EffectBase]
      def create_effect(user, target)
        Effects::HelpingHand.new(logic, user, target, 1)
      end
      # Message displayed when the effect is dealt to the target
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def deal_message(user, target)
        parse_text_with_pokemon(19, 1050, user, PFM::Text::PKNICK[1] => target.given_name)
      end
    end
    Move.register(:s_helping_hand, HelpingHand)
    public
    # Move that inflict Hex to the enemy
    class Hex < BasicWithSuccessfulEffect
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        hp_dealt = super
        hp_dealt *= 2 if states.include?(Configs.states.symbol(target.status))
        hp_dealt *= 2 if target.has_ability?(:comatose)
        return hp_dealt
      end
      private
      # Return the States that triggers the x2 damages
      STATES = %i[burn paralysis sleep freeze poison toxic]
      # Return the STATES constant
      # @return [Array<Symbol>]
      def states
        STATES
      end
    end
    Move.register(:s_hex, Hex)
    public
    # Hidden Power deals damage, however its type varies for every Pokémon, depending on that Pokémon's Individual Values (IVs).
    # @see https://pokemondb.net/move/hidden-power
    # @see https://bulbapedia.bulbagarden.net/wiki/Hidden_Power_(move)
    # @see https://www.pokepedia.fr/Puissance_Cach%C3%A9e
    # @see https://bulbapedia.bulbagarden.net/wiki/Hidden_Power_(move)/Calculation
    class HiddenPower < Basic
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        index = 0
        iv_list.each_with_index { |iv, i| index += (user.send(iv) & 1) * 2 ** i }
        index = (index * (types_table.length - 1) / 63).floor
        type_id = types_table[index]
        log_data("Hidden power : internal index=#{index} > #{type_id}")
        return [data_type(type_id).id]
      end
      private
      # Hidden power move types
      # @return [Array<Symbol>] array of types
      TYPES_TABLE = %i[fighting flying poison ground rock bug ghost steel fire water grass electric psychic ice dragon dark]
      # Hidden power move types
      # @return [Array<Symbol>] array of types
      def types_table
        return TYPES_TABLE
      end
      # IVs weighted from the litest to the heaviest in type / damage calculation
      # @return [Array<Symbol>]
      IV_LIST = %i[iv_hp iv_atk iv_dfe iv_spd iv_ats iv_dfs]
      # IVs weighted from the litest to the heaviest in type / damage calculation
      # @return [Array<Symbol>]
      def iv_list
        return IV_LIST
      end
    end
    Move.register(:s_hidden_power, HiddenPower)
    public
    # Move that has a big recoil when fails
    class HighJumpKick < Basic
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
        return if %i[usable_by_user pp].include?(reason)
        return crash_procedure(user)
      end
      # Define the crash procedure when the move isn't able to connect to the target
      # @param user [PFM::PokemonBattler] user of the move
      def crash_procedure(user)
        hp = user.max_hp / 2
        logic.damage_handler.damage_change(hp, user)
        scene.display_message_and_wait(parse_text_with_pokemon(19, 908, user))
      end
    end
    Move.register(:s_jump_kick, HighJumpKick)
    public
    # Class managing moves that deal double power & cure status
    class HitThenCureStatus < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power * 2 if status_check(target)
        return super
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless status_check(target)
          @logic.status_change_handler.status_change(:cure, target, user)
        end
      end
      # Check the status
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
        log_error('Move Implementation Error: status_check should be overwritten in child class.')
      end
    end
    # Class managing Smelling Salts move
    class SmellingSalts < HitThenCureStatus
      # Check the status
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
        return target.paralyzed?
      end
    end
    # Class managing Wake-Up Slap move
    class WakeUpSlap < HitThenCureStatus
      # Check the status
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
        return target.asleep? || target.has_ability?(:comatose)
      end
    end
    Move.register(:s_smelling_salt, SmellingSalts)
    Move.register(:s_wakeup_slap, WakeUpSlap)
    public
    # Implement the Ice Spinner move
    class IceSpinner < Basic
      # Function that deals the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.fterrain_change_handler.fterrain_change_with_process(:none)
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return @logic.field_terrain_effect.any?
      end
    end
    # Implement the Stell Roller move
    class SteelRoller < IceSpinner
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if @logic.field_terrain_effect.none?
        return true
      end
    end
    Move.register(:s_ice_spinner, IceSpinner)
    Move.register(:s_steel_roller, SteelRoller)
    public
    # Class managing Imprison move
    class Imprison < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if user.effects.has?(:imprison)
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:imprison)
          user.effects.add(Effects::Imprison.new(@logic, user))
          @scene.display_message_and_wait(deal_message(user, target))
        end
      end
      # Message displayed when the effect is dealt
      # @param user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      # @return [String]
      def deal_message(user, actual_targets)
        return parse_text_with_pokemon(19, 586, user)
      end
    end
    Move.register(:s_imprison, Imprison)
    public
    # Class managing the Incinerate move
    class Incinerate < BasicWithSuccessfulEffect
      DESTROYABLE_ITEMS = %i[fire_gem water_gem electric_gem grass_gem ice_gem fighting_gem poison_gem ground_gem flying_gem psychic_gem bug_gem rock_gem ghost_gem dragon_gem dark_gem steel_gem normal_gem fairy_gem]
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        dmg = super
        if dmg > 0 && @logic.item_change_handler.can_lose_item?(target, user)
          if DESTROYABLE_ITEMS.include?(target.battle_item_db_symbol)
            @logic.item_change_handler.change_item(:none, true, target, user, self)
          else
            if target.hold_berry?(target.battle_item_db_symbol) && !target.effects.has?(:item_burnt)
              @scene.display_message_and_wait(parse_text_with_pokemon(19, 1114, target, PFM::Text::ITEM2[1] => target.item_name))
              target.effects.add(Effects::ItemBurnt.new(@logic, target))
            end
          end
        end
        return dmg
      end
    end
    Move.register(:s_incinerate, Incinerate)
    public
    # class managing Ingrain move
    class Ingrain < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |target| target.effects.has?(:ingrain) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:ingrain)
          target.effects.add(Effects::Ingrain.new(logic, target, user, self))
          scene.display_message_and_wait(message(user))
        end
      end
      # Get the message text
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def message(pokemon)
        return parse_text_with_pokemon(19, 736, pokemon)
      end
    end
    Move.register(:s_ingrain, Ingrain)
    public
    class Instruct < Move
      # @type [Array<Symbol>]
      NO_INSTRUCT_MOVES = %i[sketch transform mimic king_s_shield struggle instruct metronome assist me_first mirror_move nature_power sleep_talk]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| move_usable?(user, target) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          last_move = target.move_history.last.original_move
          target_bank = target.move_history.last.targets.first.bank
          target_position = target.move_history.last.targets.first.position
          logic.add_actions([Actions::Attack.new(scene, last_move, target, target_bank, target_position)])
          target.effects.add(Effects::Instruct.new(logic, target))
        end
      end
      private
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Boolean] if the procedure can continue
      def move_usable?(user, target)
        return false if target.effects.has?(&:preparing_attack?) || target.effects.has?(&:force_next_move?) || target.effects.has?(&:out_of_reach?)
        return false if target.move_history.none?
        last_move = target.move_history.last.original_move
        return false if last_move.pre_attack? || last_move.recharge? || last_move.two_turn? || last_move.multi_turn?
        return false if NO_INSTRUCT_MOVES.include?(last_move.db_symbol) || last_move.pp <= 0
        return false if target.moveset.none?(last_move)
        return true
      end
    end
    Move.register(:s_instruct, Instruct)
    public
    # Move increase changing all moves to electric for 1 turn
    class IonDeluge < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if logic.terrain_effects.has?(:ion_deluge)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.terrain_effects.add(Effects::IonDeluge.new(@scene.logic))
        scene.display_message_and_wait(parse_text(18, 257))
      end
    end
    Move.register(:s_ion_deluge, IonDeluge)
    public
    class IvyCudgel < Basic
      include Mechanics::TypesBasedOnItem
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
        return false
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
        return true
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a mask, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
        if IVYCUDGEL_TABLE.keys.include?(name)
          [data_type(IVYCUDGEL_TABLE[name]).id]
        else
          [data_type(:grass).id]
        end
      end
      # Table of move type depending on item
      # @return [Hash<Symbol, Symbol>]
      IVYCUDGEL_TABLE = {wellspring_mask: :water, hearthflame_mask: :fire, cornerstone_mask: :rock}
    end
    Move.register(:s_ivy_cudgel, IvyCudgel)
    public
    # Jaw Lock move
    class JawLock < Basic
      private
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return true unless user.effects.has?(:cantswitch) || actual_targets.any? { |target| target.effects.has?(:cantswitch) }
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        unless user.effects.has?(:cantswitch)
          user.effects.add(Effects::CantSwitch.new(logic, user, user, self))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 875, user))
        end
        actual_targets.each do |target|
          next if target.effects.has?(:cantswitch)
          target.effects.add(Effects::CantSwitch.new(logic, target, user, self))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 875, target))
        end
      end
    end
    Move.register(:s_jaw_lock, JawLock)
    public
    # Type depends on the Arceus Plate being held.
    # @see https://pokemondb.net/move/judgment
    # @see https://bulbapedia.bulbagarden.net/wiki/Judgment_(move)
    # @see https://www.pokepedia.fr/Jugement
    class Judgment < Basic
      include Mechanics::TypesBasedOnItem
      private
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
        false
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
        return true
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a plate, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
        if JUDGMENT_TABLE.keys.include?(name)
          [data_type(JUDGMENT_TABLE[name]).id]
        else
          [data_type(:normal).id]
        end
      end
      # Table of move type depending on item
      # @return [Hash<Symbol, Symbol>]
      JUDGMENT_TABLE = {flame_plate: :fire, splash_plate: :water, zap_plate: :electric, meadow_plate: :grass, icicle_plate: :ice, fist_plate: :fighting, toxic_plate: :poison, earth_plate: :ground, sky_plate: :flying, mind_plate: :psychic, insect_plate: :bug, stone_plate: :rock, spooky_plate: :ghost, draco_plate: :dragon, iron_plate: :steel, dread_plate: :dark, pixie_plate: :fairy}
    end
    Move.register(:s_judgment, Judgment)
    public
    # Move that inflict Knock Off to the ennemy
    class KnockOff < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return effect_working?(user, [target]) ? super * 1.5 : super
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| @logic.item_change_handler.can_lose_item?(target, user) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless @logic.item_change_handler.can_lose_item?(target, user)
          next if user.dead? && target.hold_item?(:rocky_helmet) || %i[rough_skin iron_barbs].include?(target.battle_ability_db_symbol)
          additionnal_variables = {PFM::Text::ITEM2[2] => target.item_name, PFM::Text::PKNICK[1] => target.given_name}
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1056, user, additionnal_variables))
          if target.from_party? && !target.effects.has?(:item_stolen)
            @logic.item_change_handler.change_item(:none, false, target, user, self)
            target.effects.add(Effects::ItemStolen.new(@logic, target))
          else
            @logic.item_change_handler.change_item(:none, true, target, user, self)
          end
        end
      end
    end
    Move.register(:s_knock_off, KnockOff)
    public
    # class managing Focus Energy
    class LaserFocus < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::LaserFocus.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1047, target))
        end
      end
    end
    Move.register(:s_laser_focus, LaserFocus)
    public
    class LashOut < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power unless user.stat_history&.last&.current_turn? && user.stat_history&.last&.power&.negative?
        log_data("power = #{power * 2} \# after Move::LashOut")
        return power * 2
      end
    end
    Move.register(:s_lash_out, LashOut)
    public
    class LastResort < Basic
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return failure(user) unless user.moveset.map(&:db_symbol).include?(:last_resort)
        return failure(user) if user.moveset.size == 1
        return failure(user) unless all_other_move_used?(user)
        return true
      end
      # Display the usage failure message and return false
      # @param user [PFM::PokemonBattler]
      # @return [false]
      def failure(user)
        show_usage_failure(user)
        return false
      end
      private
      # Test if the user has used all the other moves
      # @param user [PFM::PokemonBattler]
      def all_other_move_used?(user)
        moves = user.moveset.reject { |move| move == self }
        used_moves = user.move_history.map(&:original_move).uniq
        return (moves - used_moves).size <= 0
      end
    end
    Move.register(:s_last_resort, LastResort)
    public
    class LastRespects < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        ko_count = @logic.retrieve_party_from_battler(user).sum(&:ko_count)
        multiplier = (ko_count + 1).clamp(1, max)
        log_data("power = #{power * multiplier} \# after Move::LastRespects real_base_power")
        return power * multiplier
      end
      private
      # Returns the maximum value for the multiplier clamp.
      # @return [Integer]
      def max
        return 101
      end
    end
    Move.register(:s_last_respects, LastRespects)
    public
    # Move that inflict leech seed to the ennemy
    class LeechSeed < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:leech_seed_mark) || target.type_grass? || target.effects.has?(:substitute)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          @logic.add_position_effect(Effects::LeechSeed.new(@logic, user, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 607, target))
        end
      end
    end
    Move.register(:s_leech_seed, LeechSeed)
    public
    # Class describing a move that heals the user and its allies
    class LifeDew < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          hp = target.max_hp / 4
          logic.damage_handler.heal(target, hp)
        end
      end
    end
    Move.register(:s_life_dew, LifeDew)
    # Class describing a heal move
    class JungleHealing < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          hp = target.max_hp / 4
          logic.damage_handler.heal(target, hp)
          next if target.status == 0 || target.dead?
          scene.logic.status_change_handler.status_change(:cure, target)
        end
      end
    end
    Move.register(:s_jungle_healing, JungleHealing)
    public
    # Class managing Light Screen / Aurora Veil / Reflect moves
    class Reflect < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if logic.bank_effects[user.bank].has?(db_symbol) || (db_symbol == :aurora_veil && !$env.hail?)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        turn_count = user.hold_item?(:light_clay) ? 8 : 5
        if db_symbol == :light_screen
          logic.bank_effects[user.bank].add(Effects::LightScreen.new(logic, user.bank, 0, turn_count))
          scene.display_message_and_wait(parse_text(18, 134 + user.bank.clamp(0, 1)))
        else
          if db_symbol == :aurora_veil
            logic.bank_effects[user.bank].add(Effects::AuroraVeil.new(logic, user.bank, 0, turn_count))
            scene.display_message_and_wait(parse_text(18, 288 + user.bank.clamp(0, 1)))
          else
            logic.bank_effects[user.bank].add(Effects::Reflect.new(logic, user.bank, 0, turn_count))
            scene.display_message_and_wait(parse_text(18, 130 + user.bank.clamp(0, 1)))
          end
        end
      end
    end
    Move.register(:s_reflect, Reflect)
    public
    # class managing Lock-On and Mind Reader moves
    class LockOn < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if user.effects.get(:lock_on)&.target == target
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if user.effects.get(:lock_on)&.target == target
          user.effects.add(Effects::LockOn.new(@logic, user, target))
          text = parse_text_with_pokemon(19, target.bank == 0 ? 656 : 651, user, PFM::Text::PKNICK[0] => user.given_name, PFM::Text::PKNICK[1] => target.given_name)
          @scene.display_message_and_wait(text)
        end
      end
    end
    Move.register(:s_lock_on, LockOn)
    Move.register(:s_mind_reader, LockOn)
    public
    class LowKick < Basic
      MAXIMUM_WEIGHT = [10, 25, 50, 100, 200]
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        target_weight = (target.weight != target.data.weight) ? (user.can_be_lowered_or_canceled? ? target.weight : target.data.weight) : target.weight
        weight_index = MAXIMUM_WEIGHT.find_index { |weight| target_weight < weight } || MAXIMUM_WEIGHT.size
        return 20 + 20 * weight_index
      end
    end
    Move.register(:s_low_kick, LowKick)
    public
    # class managing HappyHour move
    class LuckyChant < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param _targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, _targets)
        return false unless super
        return false if logic.bank_effects[user.bank].has?(:lucky_chant)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _actual_targets)
        @logic.add_bank_effect(Effects::LuckyChant.new(@logic, user.bank))
        @scene.display_message_and_wait(parse_text(18, message_id + user.bank))
      end
      # ID of the message that is responsible for telling the beginning of the effect
      # @return [Integer]
      def message_id
        return 150
      end
    end
    Move.register(:s_lucky_chant, LuckyChant)
    public
    # Move that inflict Magic Coat to the user
    class MagicCoat < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if @logic.battler_attacks_last?(user)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::MagicCoat.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 761, target))
        end
      end
    end
    Move.register(:s_magic_coat, MagicCoat)
    public
    # Move that give a third type to an enemy
    class MagicPowder < ChangeType
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        if target.hold_item?(:safety_goggles)
          @logic.scene.visual.show_item(target)
          return true
        end
        return super ? true : false
      end
      # Method that tells if the target already has the type
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def type_check(target)
        return target.type_psychic?
      end
    end
    Move.register(:s_magic_powder, MagicPowder)
    public
    # Magic Room suppresses the effects of held items for all Pokémon for five turns.
    # @see https://pokemondb.net/move/magic-room
    # @see https://bulbapedia.bulbagarden.net/wiki/Magic_Room_(move)
    # @see https://www.pokepedia.fr/Zone_Magique
    class MagicRoom < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        if logic.terrain_effects.has?(:magic_room)
          logic.terrain_effects.get(:magic_room).kill
        else
          logic.terrain_effects.add(Effects::MagicRoom.new(logic, duration))
        end
      end
      # Duration of the effect
      # @return [Integer]
      def duration
        5
      end
    end
    register(:s_magic_room, MagicRoom)
    public
    class MagnetRise < Move
      # @type [Array<Symbol>]
      EFFECTS_TO_CHECK = %i[magnet_rise ingrain smack_down]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if EFFECTS_TO_CHECK.any? { |effect_name| targets.all? { |target| target.effects.has?(effect_name) } }
        return show_usage_failure(user) && false if targets.all? { |target| target.hold_item?(:iron_ball) }
        return show_usage_failure(user) && false if @logic.terrain_effects.has?(:gravity)
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if EFFECTS_TO_CHECK.any? { |effect_name| target.effects.has?(effect_name) }
          next if target.hold_item?(:iron_ball)
          target.effects.add(Effects::MagnetRise.new(logic, target, turn_count))
          @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 658, target))
        end
      end
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
        return 5
      end
    end
    Move.register(:s_magnet_rise, MagnetRise)
    public
    # Magnetic Flux move
    class MagneticFlux < Move
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        actual_targets.any? { |target| %i[plus minus].include?(target.ability_db_symbol) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless %i[plus minus].include?(target.ability_db_symbol)
          scene.logic.stat_change_handler.stat_change_with_process(:dfe, 1, target, user, self)
          scene.logic.stat_change_handler.stat_change_with_process(:dfs, 1, target, user, self)
        end
      end
    end
    Move.register(:s_magnetic_flux, MagneticFlux)
    public
    # Class managing Magnitude move
    # @see https://bulbapedia.bulbagarden.net/wiki/Magnitude_(move)
    # @see https://pokemondb.net/move/magnitude
    # @see https://www.pokepedia.fr/Ampleur
    class Magnitude < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return magnitude_table[3][1] unless @magnitude_found
        log_data("magnitude power #{@magnitude_found[1]} \# #{@magnitude_found}")
        power = @magnitude_found[1]
        @magnitude_found = nil
        return power
      end
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        return super(user, target) unless (e = target.effects.get(&:out_of_reach?)) && !e&.on_move_prevention_target(user, target, self)
        d = super(user, target)
        log_data("damage = #{d * 2} \# #{d} * 2 (magnitude overhall damages double when target is using dig)")
        return (d * 2).floor
      end
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        find_magnitude
        return true
      end
      def find_magnitude
        dice = logic.generic_rng.rand(100).floor
        @magnitude_found = magnitude_table.find { |row| row[0] > dice } || magnitude_table[0]
      end
      # Show the move usage message
      # @param user [PFM::PokemonBattler] user of the move
      def usage_message(user)
        super
        find_magnitude if @magnitude_found.nil?
        @scene.display_message_and_wait(parse_text(18, @magnitude_found[2]))
      end
      # Damage table
      # Array<[probability_of_100, power, text]>
      # Sum of probabilities must be 100
      MAGNITUDE_TABLE = [[5, 10, 108], [15, 30, 109], [35, 50, 110], [65, 70, 111], [85, 90, 112], [95, 110, 113], [100, 150, 114]]
      # Damage table
      # Array<[probability_of_100, power, text]>
      # Sum of probabilities must be 100
      def magnitude_table
        MAGNITUDE_TABLE
      end
    end
    Move.register(:s_magnitude, Magnitude)
    public
    # class managing Make It Rain move
    class MakeItRain < SelfStat
      private
      # Function that deals the effect (generates money the player gains at the end of battle)
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return unless user.from_party?
        money = user.level * 5
        total_money = money * actual_targets.size
        scene.battle_info.additional_money += total_money
        scene.display_message_and_wait(parse_text(18, 128))
      end
    end
    Move.register(:s_make_it_rain, MakeItRain)
    public
    # Me First move
    class MeFirst < Move
      CANNOT_BE_SELECTED_MOVES = %i[me_first sucker_punch fake_out]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.empty? || logic.battler_attacks_after?(user, targets.first) || CANNOT_BE_SELECTED_MOVES.include?(target_move(targets.first))
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that retrieve the target move from the action stack
      # @return [Symbol]
      def target_move(target)
        attacks = logic.actions.select { |action| action.is_a?(Actions::Attack) }
        attacks.find { |action| action.launcher == target }&.move&.db_symbol || CANNOT_BE_SELECTED_MOVES.first
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        skill = data_move(target_move(actual_targets.first))
        move = Battle::Move[skill.be_method].new(skill.db_symbol, 1, 1, @scene)
        def move.calc_mod2(user, target)
          super * 1.5
        end
        def move.chance_of_hit(user, target)
          return 100
        end
        use_another_move(move, user)
      end
    end
    Move.register(:s_me_first, MeFirst)
    public
    # class managing Memento move
    class Memento < Move
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        hp = user.max_hp
        logic.damage_handler.damage_change(hp, user)
      end
    end
    Move.register(:s_memento, Memento)
    public
    # Metronome move
    class Metronome < Move
      CANNOT_BE_SELECTED_MOVES = %i[after_you assist baneful_bunker beak_blast belch bestow celebrate chatter copycat counter covet crafty_shield destiny_bound detect diamond_storm endure feint fleur_cannon focus_punch follow_me freeze_shock helping_hand hold_hands hyperspace_fury hyperspace_hole ice_burn instruct king_s_shield light_of_ruin mat_block me_first metronome mimic mind_blown mirror_coat mirror_move nature_power photon_geyser plasma_fists protect quash quick_guard rage_powder relic_song secret_sword shell_trap sketch sleep_talk snarl snatch snore spectral_thief spiky_shield spotlight steam_eruption struggle switcheroo techno_blast thousand_arrows thousand_waves thief transform trick v_create wide_guard]
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        skill = each_data_move.reject { |i| CANNOT_BE_SELECTED_MOVES.include?(i.db_symbol) }.sample(random: @logic.generic_rng)
        move = Battle::Move[skill.be_method].new(skill.id, 1, 1, @scene)
        def move.usage_message(user)
          @scene.visual.hide_team_info
          scene.display_message_and_wait(parse_text(18, 126, '[VAR MOVE(0000)]' => name))
          PFM::Text.reset_variables
        end
        use_another_move(move, user)
      end
    end
    Move.register(:s_metronome, Metronome)
    public
    # Move that copies the last move of the choosen target
    class Mimic < Move
      NO_MIMIC_MOVES = %i[chatter metronome sketch struggle mimic]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.empty? || targets.first.move_history.empty? || NO_MIMIC_MOVES.include?(targets.first.move_history.last.move.db_symbol)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        mimic_move_index = user.moveset.index(self)
        return unless mimic_move_index
        user.mimic_move = [self, mimic_move_index]
        move = actual_targets.first.move_history.last.move
        user.moveset[mimic_move_index] = Move[move.be_method].new(move.id, 5, 5, scene)
        scene.display_message_and_wait(parse_text_with_pokemon(19, 688, user, PFM::Text::MOVE[1] => move.name))
      end
    end
    Move.register(:s_mimic, Mimic)
    public
    class MindBlown < Basic
      # Get the reason why the move is disabled
      # @param user [PFM::PokemonBattler] user of the move
      # @return [#call] Block that should be called when the move is disabled
      def disable_reason(user)
        damp_battlers = logic.all_alive_battlers.select { |battler| battler.has_ability?(:damp) }
        return super if damp_battlers.empty?
        return proc {@logic.scene.visual.show_ability(damp_battlers.first) && @logic.scene.display_message_and_wait(parse_text_with_pokemon(60, 508, user)) }
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        damp_battlers = logic.all_alive_battlers.select { |battler| battler.has_ability?(:damp) }
        unless damp_battlers.empty?
          @logic.scene.visual.show_ability(damp_battlers.first)
          return show_usage_failure(user) && false
        end
        return true
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
        return unless %i[accuracy immunity].include?(reason)
        return crash_procedure(user)
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        super ? true : crash_procedure(user) && false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        crash_procedure(user)
      end
      private
      # Define the crash procedure when the move isn't able to connect to the target
      # @param user [PFM::PokemonBattler] user of the move
      def crash_procedure(user)
        return if user.has_ability?(:wonder_guard)
        hp = user.max_hp / 2
        logic.damage_handler.damage_change(hp, user)
      end
    end
    Move.register(:s_mind_blown, MindBlown)
    Move.register(:s_steel_beam, MindBlown)
    Move.register(:s_chloroblast, MindBlown)
    public
    # Class that manage Minimize move
    class Minimize < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each { |target| target.effects.add(Effects::Minimize.new(@logic, target)) }
      end
    end
    Move.register(:s_minimize, Minimize)
    public
    # Move that makes possible to hit Dark type Pokemon with Psychic type moves
    class MiracleEye < Move
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::MiracleEye.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 369, target))
        end
      end
    end
    Move.register(:s_miracle_eye, MiracleEye)
    public
    # Move that mimics the last move of the choosen target
    class MirrorMove < Move
      COPY_CAT_MOVE_EXCLUDED = %i[baneful_bunker beak_blast behemoth_blade bestow celebrate chatter circle_throw copycat counter covet destiny_bond detect dragon_tail endure feint focus_punch follow_me helping_hand hold_hands king_s_shield mat_block assist me_first metronome mimic mirror_coat mirror_move protect rage_powder roar shell_trap sketch sleep_talk snatch struggle spiky_shield spotlight switcheroo thief transform trick whirlwind]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        last_used_move = last_move(user, targets)
        if !last_used_move || move_excluded?(last_used_move)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        move = last_move(user, actual_targets).dup
        def move.move_usable_by_user(user, targets)
          return true
        end
        use_another_move(move, user)
      end
      private
      # Tell if the move is usable or not
      # @param move [Battle::Move]
      # @return [Boolean]
      def move_excluded?(move)
        return !move.mirror_move_affected? if db_symbol == :mirror_move
        return COPY_CAT_MOVE_EXCLUDED.include?(move.db_symbol)
      end
      # Function that gets the last used move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Battle::Move, nil] the last move
      def last_move(user, targets)
        if db_symbol == :mirror_move
          return nil unless (target = targets.first)
          return nil unless (move_history = target.move_history.last)
          return nil if move_history.turn < ($game_temp.battle_turn - 1)
          return move_history.move
        end
        return copy_cat_last_move(user)
      end
      # Function that gets the last used move for copy cat
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Battle::Move, nil] the last move
      def copy_cat_last_move(user)
        battlers = logic.all_alive_battlers.select { |battler| battler != user }
        last_move_history = battlers.map { |battler| battler.move_history.last }.compact
        max_turn = last_move_history.map(&:turn).max
        last_turn_history = last_move_history.select { |history| history.turn == max_turn }
        last_history = last_turn_history.max_by(&:attack_order)
        return last_history&.move
      end
    end
    Move.register(:s_mirror_move, MirrorMove)
    public
    # Mist move
    class Mist < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if logic.bank_effects[user.bank].has?(:mist)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.map(&:bank).uniq.each do |bank|
          logic.bank_effects[bank].add(Effects::Mist.new(logic, bank))
          scene.display_message_and_wait(parse_text(18, bank == 0 ? 142 : 143))
        end
      end
    end
    Move.register(:s_mist, Mist)
    public
    # Move that lower the power of electric/fire moves
    class MudSport < Move
      # List of effect depending on db_symbol of the move
      # @return [Hash{ Symbol => Class<Battle::Effects::EffectBase> }]
      EFFECT_KLASS = {}
      # List of message used to declare the effect
      # @return [Hash{ Symbol => Integer }]
      EFFECT_MESSAGE = {}
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        if super
          effect_klass = EFFECT_KLASS[db_symbol]
          if logic.terrain_effects.each.any? { |effect| effect.class == effect_klass }
            show_usage_failure(user)
            return false
          end
          return true
        end
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.terrain_effects.add(EFFECT_KLASS[db_symbol].new(@scene.logic))
        scene.display_message_and_wait(parse_text(18, EFFECT_MESSAGE[db_symbol]))
      end
      class << self
        # Register an effect to a "MudSport" like move
        # @param db_symbol [Symbol] Symbol of the move
        # @param klass [Class<Battle::Effects::EffectBase>]
        # @param message_id [Integer] ID of the message to show in file 18 when effect is applied
        def register_effect(db_symbol, klass, message_id)
          EFFECT_KLASS[db_symbol] = klass
          EFFECT_MESSAGE[db_symbol] = message_id
        end
      end
      register_effect(:mud_sport, Effects::MudSport, 120)
      register_effect(:water_sport, Effects::WaterSport, 118)
    end
    Move.register(:s_thing_sport, MudSport)
    public
    # Type depends on the Sylvally ROM being held.
    # @see https://pokemondb.net/move/judgment
    # @see https://bulbapedia.bulbagarden.net/wiki/Judgment_(move)
    # @see https://www.pokepedia.fr/Jugement
    class MultiAttack < Basic
      include Mechanics::TypesBasedOnItem
      private
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
        false
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
        return true
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a memory, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
        if MEMORY_TABLE.keys.include?(name)
          [data_type(MEMORY_TABLE[name]).id]
        else
          [data_type(:normal).id]
        end
      end
      # Table of move type depending on item
      # @return [Hash<Symbol, Symbol>]
      MEMORY_TABLE = {fire_memory: :fire, water_memory: :water, electric_memory: :electric, grass_memory: :grass, ice_memory: :ice, fighting_memory: :fighting, poison_memory: :poison, ground_memory: :ground, flying_memory: :flying, psychic_memory: :psychic, bug_memory: :bug, rock_memory: :rock, ghost_memory: :ghost, dragon_memory: :dragon, steel_memory: :steel, dark_memory: :dark, fairy_memory: :fairy}
    end
    Move.register(:s_multi_attack, MultiAttack)
    public
    # Natural Gift deals damage with no additional effects. However, its type and base power vary depending on the user's held Berry. 
    # @see https://pokemondb.net/move/natural-gift
    # @see https://bulbapedia.bulbagarden.net/wiki/Natural_Gift_(move)
    # @see https://www.pokepedia.fr/Don_Naturel
    class NaturalGift < Basic
      include Mechanics::PowerBasedOnItem
      include Mechanics::TypesBasedOnItem
      private
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
        true
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
        NATURAL_GIFT_TABLE.keys.include?(name)
      end
      # Get the real power of the move depending on the item
      # @param name [Symbol]
      # @return [Integer]
      def get_power_by_item(name)
        NATURAL_GIFT_TABLE[name][0]
      end
      # Get the real types of the move depending on the item
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
        [data_type(NATURAL_GIFT_TABLE[name][1]).id]
      end
      class << self
        def reset
          const_set(:NATURAL_GIFT_TABLE, {})
        end
        def register(berry, power, type)
          NATURAL_GIFT_TABLE[berry] ||= []
          NATURAL_GIFT_TABLE[berry] = [power, type]
        end
      end
      reset
      register(:chilan_berry, 80, :normal)
      register(:cheri_berry, 80, :fire)
      register(:occa_berry, 80, :fire)
      register(:bluk_berry, 90, :fire)
      register(:watmel_berry, 100, :fire)
      register(:chesto_berry, 80, :water)
      register(:passho_berry, 80, :water)
      register(:nanab_berry, 90, :water)
      register(:durin_berry, 100, :water)
      register(:pecha_berry, 80, :electric)
      register(:wacan_berry, 80, :electric)
      register(:wepear_berry, 90, :electric)
      register(:belue_berry, 100, :electric)
      register(:rawst_berry, 80, :grass)
      register(:rindo_berry, 80, :grass)
      register(:pinap_berry, 90, :grass)
      register(:liechi_berry, 100, :grass)
      register(:aspear_berry, 80, :ice)
      register(:yache_berry, 80, :ice)
      register(:pomeg_berry, 90, :ice)
      register(:ganlon_berry, 100, :ice)
      register(:leppa_berry, 80, :fighting)
      register(:chople_berry, 80, :fighting)
      register(:kelpsy_berry, 90, :fighting)
      register(:salac_berry, 100, :fighting)
      register(:oran_berry, 80, :poison)
      register(:kebia_berry, 80, :poison)
      register(:qualot_berry, 90, :poison)
      register(:petaya_berry, 100, :poison)
      register(:persim_berry, 80, :ground)
      register(:shuca_berry, 80, :ground)
      register(:hondew_berry, 90, :ground)
      register(:apicot_berry, 100, :ground)
      register(:lum_berry, 80, :flying)
      register(:coba_berry, 80, :flying)
      register(:grepa_berry, 90, :flying)
      register(:lansat_berry, 100, :flying)
      register(:sitrus_berry, 80, :psychic)
      register(:payapa_berry, 80, :psychic)
      register(:tamato_berry, 90, :psychic)
      register(:starf_berry, 100, :psychic)
      register(:figy_berry, 80, :bug)
      register(:tanga_berry, 80, :bug)
      register(:cornn_berry, 90, :bug)
      register(:enigma_berry, 100, :bug)
      register(:wiki_berry, 80, :rock)
      register(:charti_berry, 80, :rock)
      register(:magost_berry, 90, :rock)
      register(:micle_berry, 100, :rock)
      register(:mago_berry, 80, :ghost)
      register(:kasib_berry, 80, :ghost)
      register(:rabuta_berry, 90, :ghost)
      register(:custap_berry, 100, :ghost)
      register(:aguav_berry, 80, :dragon)
      register(:haban_berry, 80, :dragon)
      register(:nomel_berry, 90, :dragon)
      register(:jaboca_berry, 100, :dragon)
      register(:iapapa_berry, 80, :dark)
      register(:colbur_berry, 80, :dark)
      register(:spelon_berry, 90, :dark)
      register(:rowap_berry, 100, :dark)
      register(:razz_berry, 80, :steel)
      register(:babiri_berry, 80, :steel)
      register(:pamtre_berry, 90, :steel)
      register(:roseli_berry, 80, :fairy)
      register(:kee_berry, 100, :fairy)
      register(:maranga_berry, 100, :dark)
    end
    Move.register(:s_natural_gift, NaturalGift)
    public
    # When Nature Power is used it turns into a different move depending on the current battle terrain.
    # @see https://pokemondb.net/move/nature-power
    # @see https://bulbapedia.bulbagarden.net/wiki/Nature_Power_(move)
    # @see https://www.pokepedia.fr/Force_Nature
    class NaturePower < Move
      include Mechanics::LocationBased
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        skill = data_move(element_by_location)
        log_data("nature power \# becomes #{skill.db_symbol}")
        move = Battle::Move[skill.be_method].new(skill.db_symbol, 1, 1, @scene)
        def move.usage_message(user)
          @scene.visual.hide_team_info
          scene.display_message_and_wait(parse_text(18, 127, '[VAR MOVE(0000)]' => name))
          PFM::Text.reset_variables
        end
        def move.move_usable_by_user(user, targets)
          return true
        end
        use_another_move(move, user)
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
        MOVES_TABLE
      end
      class << self
        def reset
          const_set(:MOVES_TABLE, {})
        end
        def register(loc, move)
          MOVES_TABLE[loc] ||= []
          MOVES_TABLE[loc] << move
          MOVES_TABLE[loc].uniq!
        end
      end
      reset
      register(:__undef__, :tri_attack)
      register(:regular_ground, :tri_attack)
      register(:building, :tri_attack)
      register(:grass, :energy_ball)
      register(:desert, :earth_power)
      register(:cave, :power_gem)
      register(:water, :hydro_pump)
      register(:shallow_water, :mud_bomb)
      register(:snow, :frost_breath)
      register(:icy_cave, :ice_beam)
      register(:volcanic, :lava_plume)
      register(:burial, :shadow_ball)
      register(:soaring, :air_slash)
      register(:misty_terrain, :moonblast)
      register(:grassy_terrain, :energy_ball)
      register(:electric_terrain, :thunderbolt)
      register(:psychic_terrain, :psychic)
      register(:space, :draco_meteor)
      register(:ultra_space, :psyshock)
    end
    Move.register(:s_nature_power, NaturePower)
    public
    # Move that makes possible to hit Ghost type Pokemon with Normal or Fighting type moves
    class Nightmare < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| target.asleep? || target.has_ability?(:comatose) }
        return show_usage_failure(user) && false if targets.all? { |target| target.effects.has?(:nightmare) }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.asleep? || target.has_ability?(:comatose)
          next if target.effects.has?(:nightmare)
          target.effects.add(Effects::Nightmare.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 321, target))
        end
      end
    end
    Move.register(:s_nightmare, Nightmare)
    public
    class NoRetreat < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if user.effects.has?(:no_retreat)
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(Effects::NoRetreat.new(logic, user, user, self)) if can_be_affected?(user)
      end
      # Check if the user can be affected by the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def can_be_affected?(user)
        return false if user.type_ghost?
        return false if user.effects.has?(:cantswitch)
        return true
      end
    end
    Move.register(:s_no_retreat, NoRetreat)
    public
    # Class managing OHKO moves
    class OHKO < Basic
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        super
        scene.display_message_and_wait(parse_text(18, 100)) if actual_targets.any?(&:dead?)
        return true
      end
      # Tell if the move is an OHKO move
      # @return [Boolean]
      def ohko?
        return true
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.type_ice? && db_symbol == :sheer_cold
        return super
      end
      # Return the chance of hit of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Float]
      def chance_of_hit(user, target)
        log_data("\# OHKO move: chance_of_hit(#{user}, #{target}) for #{db_symbol}")
        return 100 if bypass_chance_of_hit?(user, target)
        return (user.level < target.level ? 0 : (user.level - target.level) + 30)
      end
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        @critical = false
        @effectiveness = 1
        log_data('OHKO Move: 100% HP')
        return target.max_hp
      end
    end
    Move.register(:s_ohko, OHKO)
    public
    class Octolock < Basic
      private
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return failure_message if target.effects.has?(:bind)
        return super
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        actual_targets.any? { |target| !target.effects.has?(:bind) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:bind)
          target.effects.add(Effects::Octolock.new(logic, target, user, Float::INFINITY, self))
        end
      end
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
        @logic.scene.display_message_and_wait(parse_text(18, 74))
        return true
      end
    end
    Move.register(:s_octolock, Octolock)
    public
    class OrderUp < Basic
      COMMANDERS = {tatsugiri: {forms: [{form: 0, stats: {atk: 1}}, {form: 1, stats: {dfe: 1}}, {form: 2, stats: {spd: 1}}]}}
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return user.effects.has?(:commanded)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do
          next unless user.effects.has?(:commanded)
          commanding = logic.allies_of(user).find { |ally| ally.effects.has?(:commanding) }
          next unless commanding
          stats = COMMANDERS.dig(commanding.db_symbol, :forms)&.find { |form| form[:form] == commanding.form }&.dig(:stats)
          next unless stats
          stats.each { |stat, power| logic.stat_change_handler.stat_change_with_process(stat, power, user, user, self) }
        end
      end
    end
    Move.register(:s_order_up, OrderUp)
    public
    # Move that share HP between targets
    class PainSplit < Move
      # Check if the move bypass chance of hit and cannot fail
      # @param _user [PFM::PokemonBattler] user of the move
      # @param _target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(_user, _target)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        hp_total = 0
        actual_targets = [user].concat(actual_targets)
        actual_targets.each { |target| hp_total += target.effects.has?(:substitute) ? target.effects.get(:substitute).hp : target.hp }
        average_hp = (hp_total / actual_targets.size).to_i
        scene.display_message_and_wait(message)
        actual_targets.each { |target| adjust_hp(target, average_hp) }
      end
      # Get the message
      # @return [String] the text parsed and ready to be displayed
      def message
        return parse_text(18, 117)
      end
      # Adjusts the HP of the target based on the calculated average HP
      # @param target [PFM::PokemonBattler]
      # @param average_hp [Integer]
      def adjust_hp(target, average_hp)
        if target.effects.has?(:substitute) && !authentic?
          target.effects.get(:substitute).hp = average_hp.clamp(1, target.effects.get(:substitute).max_hp)
        else
          hp_difference = average_hp - target.hp
          hp_difference > 0 ? logic.damage_handler.heal(target, hp_difference) : logic.damage_handler.damage_change(hp_difference.abs, target)
        end
      end
    end
    Move.register(:s_pain_split, PainSplit)
    public
    # Parting Shot lowers the opponent's Attack and Special Attack by one stage each, then the user switches out of battle.
    # @see https://pokemondb.net/move/parting-shot
    # @see https://bulbapedia.bulbagarden.net/wiki/Parting_Shot_(move)
    # @see https://www.pokepedia.fr/Dernier_Mot
    class PartingShot < Move
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
        return true
      end
      private
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        @switchable = switchable?(actual_targets)
        super
      end
      # Function that if the Pokemon can be switched or not
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def switchable?(actual_targets)
        return false unless actual_targets.any? do |target|
          next(!target.has_ability?(:contrary) && battle_stage_mod.any? { |stage| logic.stat_change_handler.stat_decreasable?(stage.stat, target) } || target.has_ability?(:contrary) && battle_stage_mod.any? { |stage| logic.stat_change_handler.stat_increasable?(stage.stat, target) })
        end
        return false if actual_targets.all? { |target| target.has_ability?(:clear_body) }
        return false if actual_targets.all? { |target| logic.bank_effects[target.bank].has?(:mist) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return false unless @logic.switch_handler.can_switch?(user, self)
        return false unless @switchable
        @logic.switch_request << {who: user}
      end
    end
    Move.register(:s_parting_shot, PartingShot)
    public
    # Power doubles if the user was attacked first.
    # @see https://pokemondb.net/move/payback
    # @see https://bulbapedia.bulbagarden.net/wiki/Payback_(move)
    # @see https://www.pokepedia.fr/Repr%C3%A9sailles
    class PayBack < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        last_damage = user.damage_history.last
        mult = (last_damage&.current_turn? && last_damage&.launcher ? damage_multiplier : 1)
        log_data("real_base_power = #{super * mult} \# Payback multiplier: #{mult}")
        return super * mult
      end
      private
      # Damage multiplier if the effect proc
      # @return [Integer, Float]
      def damage_multiplier
        2
      end
    end
    Move.register(:s_payback, PayBack)
    public
    # class managing PayDay move
    class PayDay < BasicWithSuccessfulEffect
      private
      # Function that deals the effect (generates money the player gains at the end of battle)
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _actual_targets)
        return unless user.from_party?
        m = user.level * 5
        scene.battle_info.additional_money += m
        scene.display_message_and_wait(parse_text(18, 128))
      end
    end
    Move.register(:s_payday, PayDay)
    public
    # Any Pokemon in play when this attack is used faints in 3 turns.
    # @see https://pokemondb.net/move/perish-song
    # @see https://bulbapedia.bulbagarden.net/wiki/Perish_Song_(move)
    # @see https://www.pokepedia.fr/Requiem
    class PerishSong < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.any? { |target| target.effects.has?(:perish_song) } || user.effects.has?(:perish_song)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each { |target| target.effects.add(create_effect(user, target)) }
        @scene.display_message_and_wait(message_after_animation(user, actual_targets))
      end
      # Return the effect of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target that will be affected by the effect
      # @return [Effects::EffectBase]
      def create_effect(user, target)
        Effects::PerishSong.new(logic, target, 4)
      end
      # Return the parsed message to display once the animation is played
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [String]
      def message_after_animation(user, actual_targets)
        parse_text(18, 125)
      end
    end
    Move.register(:s_perish_song, PerishSong)
    public
    # @note This move becomes physical if the user's Atk is higher than its SpA; otherwise, it stays special.
    #       It considers the user's stat stage modifiers but not other effects like held items and abilities.
    # @see https://bulbapedia.bulbagarden.net/wiki/Photon_Geyser_(move)#Effect
    class PhotonGeyser < Basic
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @note The formula is the following:
      #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
      #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
      # @return [Integer]
      def damages(user, target)
        raw_atk = (user.atk_basis * user.atk_modifier).floor
        raw_ats = (user.ats_basis * user.ats_modifier).floor
        @physical = raw_atk > raw_ats
        @special = !@physical
        log_data("Photon Geyser's category: #{@physical ? :physical : :special}")
        return super
      end
      # Is the skill physical?
      # @return [Boolean]
      def physical?
        return @physical.nil? ? super : @physical
      end
      # Is the skill special?
      # @return [Boolean]
      def special?
        return @special.nil? ? super : @special
      end
    end
    Move.register(:s_photon_geyser, PhotonGeyser)
    public
    class PlasmaFists < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return !@logic.terrain_effects.has?(:ion_deluge)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @logic.terrain_effects.add(Effects::IonDeluge.new(@scene.logic))
        @scene.display_message_and_wait(parse_text(18, 257))
      end
    end
    Move.register(:s_plasma_fists, PlasmaFists)
    public
    # Class managing the Pluck move
    class Pluck < Basic
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return if user.dead?
        actual_targets.each do |target|
          next unless @logic.item_change_handler.can_lose_item?(target, user) && target.hold_berry?(target.battle_item_db_symbol)
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 776, user, PFM::Text::ITEM2[1] => target.item_name))
          if target.item_effect.is_a?(Effects::Item::Berry)
            user_effect = Effects::Item.new(logic, user, target.item_effect.db_symbol)
            user_effect.execute_berry_effect(force_heal: true, force_execution: true)
            if user.has_ability?(:cheek_pouch) && !user.effects.has?(:heal_block)
              @scene.visual.show_ability(user)
              @logic.damage_handler.heal(user, user.max_hp / 3)
            end
            user.effects.add(Effects::CudChewEffect.new(logic, user, user.ability_effect.turn_count, target.item_effect.db_symbol)) if user.has_ability?(:cud_chew)
          end
          @logic.item_change_handler.change_item(:none, true, target, user, self)
        end
      end
    end
    Move.register(:s_pluck, Pluck)
    public
    class PollenPuff < Basic
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        hp_dealt = super
        hp_dealt = 0 if logic.allies_of(user).include?(target)
        return hp_dealt
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless logic.allies_of(user).include?(target)
          next if user.effects.has?(:heal_block)
          next if target.effects.has?(:heal_block)
          hp = target.max_hp / 2
          logic.damage_handler.heal(target, hp)
        end
      end
    end
    Move.register(:s_pollen_puff, PollenPuff)
    public
    # Implements the Poltergeist move
    class Poltergeist < Basic
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| target.hold_item?(target.battle_item_db_symbol) }
        return true
      end
      # Function which permit things to happen before the move's animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] expected targets
      def post_accuracy_check_move(user, actual_targets)
        actual_targets.each do |target|
          @scene.display_message_and_wait(parse_text_with_pokemon(66, 1470, target, PFM::Text::ITEM2[1] => data_item(target.battle_item_db_symbol).name))
        end
      end
    end
    Move.register(:s_poltergeist, Poltergeist)
    public
    # Powder move
    class Powder < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.empty? || logic.battler_attacks_after?(user, targets.first) || targets.first.effects.has?(:powder)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        target.effects.add(Effects::Powder.new(@logic, target))
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1210, target))
      end
    end
    Move.register(:s_powder, Powder)
    public
    # User's own Attack and Defense switch.
    # @see https://pokemondb.net/move/power-trick
    # @see https://bulbapedia.bulbagarden.net/wiki/Power_Trick_(move)
    # @see https://www.pokepedia.fr/Astuce_Force
    class PowerTrick < StatAndStageEdit
      private
      # Apply the exchange
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        old_atk, old_dfe = target.atk_basis, target.dfe_basis
        target.atk_basis, target.dfe_basis = target.dfe_basis, target.atk_basis
        scene.display_message_and_wait(parse_text_with_pokemon(19, 773, target))
        log_data("power trick \# #{target.name} exchange atk and dfe (atk:#{old_atk} > #{target.atk_basis}) (dfe:#{old_dfe} > #{target.dfe_basis})")
      end
    end
    Move.register(:s_power_trick, PowerTrick)
    public
    class PreAttackBase < Basic
      # Is the move doing something before any other moves ?
      # @return [Boolean]
      def pre_attack?
        return true
      end
      # Proceed the procedure before any other attack.
      # @param user [PFM::PokemonBattler]
      def proceed_pre_attack(user)
        return unless can_pre_use_move?(user)
        pre_attack_effect(user)
        pre_attack_message(user)
        pre_attack_animation(user)
      end
      # Check if the user is able to display the message related to the move
      # @param user [PFM::PokemonBattler] user of the move
      def can_pre_use_move?(user)
        @enabled = false
        return false if user.frozen? || user.asleep?
        @enabled = true
        return true
      end
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
        return nil
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
        return nil
      end
      # Display the charging animation
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_animation(user)
        return nil
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.none? { |target| move_usable?(user, target) }
        return true
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
        return false unless @enabled
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        return true unless move_usable?(user, target)
        return false
      end
    end
    # Implement the Focus Punch move
    class FocusPunch < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
        return user.effects.add(Effects::FocusPunch.new(@logic, user))
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
        return @scene.display_message_and_wait(parse_text_with_pokemon(19, 616, user))
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
        return false unless super
        return false if disturbed?(user)
        return true
      end
      # Is the pokemon unable to proceed the attack ?
      # @param user [PFM::PokemonBattler]
      # @return [Boolean]
      def disturbed?(user)
        return user.damage_history.any?(&:current_turn?)
      end
    end
    # Implement the Beak Blast move
    class BeakBlast < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
        return user.effects.add(Effects::BeakBlast.new(@logic, user))
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
        return @scene.display_message_and_wait(parse_text_with_pokemon(59, 1880, user))
      end
    end
    # Implement the Shell Trap move
    class ShellTrap < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
        return user.effects.add(Effects::ShellTrap.new(logic, user))
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
        return @scene.display_message_and_wait(parse_text_with_pokemon(59, 1884, user))
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
        return false unless super
        return false if user.effects.has?(:shell_trap)
        return true
      end
      # Show the usage failure when move is not usable by user
      # @param user [PFM::PokemonBattler] user of the move
      def show_usage_failure(user)
        return scene.display_message_and_wait(parse_text_with_pokemon(59, 1888, user))
      end
    end
    Move.register(:s_focus_punch, FocusPunch)
    Move.register(:s_beak_blast, BeakBlast)
    Move.register(:s_shell_trap, ShellTrap)
    Move.register(:s_pre_attack_base, PreAttackBase)
    public
    class Present < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return @real_base_power if @real_base_power
        rng = logic.generic_rng.rand(1..100)
        log_data("Rng gave you: #{rng}")
        if rng <= 40
          return 40
        else
          if rng <= 70
            return 80
          else
            if rng <= 80
              return 120
            else
              return 0
            end
          end
        end
      end
      def power
        return @real_base_power || 0
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        @real_base_power = real_base_power(user, target)
        if @real_base_power > 0
          super
          return false
        end
        return true
      ensure
        @real_base_power = nil
      end
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          hp = (target.max_hp / 4).floor
          if target.effects.has?(:heal_block)
            log_data('Heal blocked')
            scene.display_message_and_wait(parse_text_with_pokemon(19, 890, target))
          else
            if target.hp == target.max_hp
              log_data('Target has MAX HP')
              scene.display_message_and_wait(parse_text_with_pokemon(19, 896, target))
            else
              log_data('Healing time')
              logic.damage_handler.heal(target, hp, test_heal_block: false)
            end
          end
        end
      end
    end
    Move.register(:s_present, Present)
    public
    # Protect move
    class Protect < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if user.turn_count > 1 && db_symbol == :mat_block
          show_usage_failure(user)
          return false
        end
        if logic.battler_attacks_last?(user)
          show_usage_failure(user)
          return false
        end
        turn = $game_temp.battle_turn
        consecutive_uses = user.successful_move_history.reverse.take_while do |history|
          if history.move.be_method == :s_protect
            turn -= 1
            next(turn == history.turn)
          end
        end
        unless bchance?(3 ** -(consecutive_uses.size).clamp(0, 6))
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::Protect.new(logic, target, self))
          scene.display_message_and_wait(deal_message(target))
        end
      end
      def deal_message(user)
        msg_id = 517
        msg_id = 511 if db_symbol == :endure
        msg_id = 800 if db_symbol == :quick_guard
        msg_id = 797 if db_symbol == :wide_guard
        return parse_text_with_pokemon(19, msg_id, user)
      end
    end
    Move.register(:s_protect, Protect)
    public
    # Class managing the Psych Up move
    class PsychUp < Move
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:crafty_shield)
        return super
      end
      private
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true unless target.effects.has?(&:out_of_reach?)
        super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.battle_stage.fill(0)
        actual_targets.each do |target|
          critical_effects_process(user, target)
          target.battle_stage.each_with_index do |value, index|
            next if value == 0
            user.set_stat_stage(index, value)
          end
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1053, user, PFM::Text::PKNICK[1] => target.given_name))
        end
      end
      # Function that checks the Critical Hit Rate Up effects (e.g. Focus Energy) and copies or clears from user.
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def critical_effects_process(user, target)
        effects = %i[focus_energy dragon_cheer].map! { |e| target.effects.get(e) }
        if effects.none?
          %i[focus_energy dragon_cheer].each { |e| user.effects.get(e)&.kill }
        else
          user.effects.add(effects.first)
        end
      end
    end
    Move.register(:s_psych_up, PsychUp)
    public
    # Class managing Psychic Noise move
    class PsychicNoise < Basic
      # Ability preventing the move from working
      BLOCKING_ABILITY = %i[aroma_veil]
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @prevent_effect = false
        actual_targets.each do |target|
          ally = @logic.allies_of(target).find { |a| BLOCKING_ABILITY.include?(a.battle_ability_db_symbol) }
          if user.can_be_lowered_or_canceled?(BLOCKING_ABILITY.include?(target.battle_ability_db_symbol))
            process_prevention(target, target)
          else
            if user.can_be_lowered_or_canceled? && ally
              process_prevention(target, ally)
            end
          end
          next if @prevent_effect
          target.effects.add(Effects::HealBlock.new(@logic, target, 3))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 884, target))
        end
      end
      # Function that does the stuff happening when the effect is unappliable
      # @param target [PFM::PokemonBattler] target of the move/effect
      # @param ability_owner [PFM::PokemonBattler] owner of the ability preventing the effect
      def process_prevention(target, ability_owner)
        @scene.visual.show_ability(ability_owner)
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 1183, target))
        @prevent_effect = true
      end
    end
    Move.register(:s_psychic_noise, PsychicNoise)
    public
    class PsychoShift < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.all? { |target| target.effects.has?(:substitute) } || right_status_symbol(user).nil?
          return show_usage_failure(user) && false
        end
        return true
      end
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true unless logic.status_change_handler.status_appliable?(right_status_symbol(user), target, user, self)
        return true if target.has_ability?(:comatose)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:substitute)
          logic.status_change_handler.status_change(right_status_symbol(user), target, user, self)
          logic.status_change_handler.status_change(:cure, user, user, self)
        end
      end
      # Get the right symbol for a status of a Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Symbol]
      def right_status_symbol(pokemon)
        return Configs.states.symbol(pokemon.status)
      end
    end
    Move.register(:s_psycho_shift, PsychoShift)
    public
    # Purify move
    class Purify < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return unless super
        return show_usage_failure(user) && false unless targets.any?(&:status?)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.status?
          @logic.status_change_handler.status_change_with_process(:cure, target, user, self)
        end
        hp = user.max_hp / 2
        logic.damage_handler.heal(user, hp)
      end
    end
    Move.register(:s_purify, Purify)
    public
    # Pursuit move, double the power if hitting switching out Pokemon
    class Pursuit < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return super * 2 if target.switching? && target.last_sent_turn != $game_temp.battle_turn
        return super
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @logic.actions.reject! { |a| a.is_a?(Actions::Switch) && actual_targets.include?(a.who) && a.who.dead? }
        return true
      end
    end
    Move.register(:s_pursuit, Pursuit)
    public
    # Quash move
    class Quash < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.empty? || logic.battler_attacks_after?(user, targets.first)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        attacks = logic.actions.select { |action| action.is_a?(Actions::Attack) }
        target_action = attacks.find { |action| action.launcher == target }
        return unless target_action
        logic.actions.delete(target_action)
        logic.actions.insert(0, target_action)
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1137, target))
      end
    end
    Move.register(:s_quash, Quash)
    public
    # Class managing moves that deal a status or flinch
    class Rage < BasicWithSuccessfulEffect
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return if user.effects.has?(:rage) && !user.effects.get(:rage).dead?
        user.effects.add(Effects::Rage.new(logic, user))
      end
    end
    Move.register(:s_rage, Rage)
    public
    # Class that manage Rage Fist move
    class RageFist < Basic
      # Base power calculation
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power = super
        damage_taken = user.damage_history.count(&:move)
        new_power = (power + damage_taken * 50).clamp(1, 350)
        log_data("power = #{new_power} \# after Move::RageFist calc")
        return new_power
      end
    end
    Move.register(:s_rage_fist, RageFist)
    public
    # Class managing Rapid Spin move
    class RapidSpin < BasicWithSuccessfulEffect
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.each { |e| e.kill if e.rapid_spin_affected? }
        logic.bank_effects[user.bank].each { |e| e.kill if e.rapid_spin_affected? }
      end
    end
    Move.register(:s_rapid_spin, RapidSpin)
    public
    # Move that has a little recoil when it hits the opponent
    class RecoilMove < Basic
      # List of factor depending on the move
      RECOIL_FACTORS = {brave_bird: 3, double_edge: 3, chloroblast: 2, flare_blitz: 3, head_charge: 4, head_smash: 2, light_of_ruin: 2, shadow_end: 2, shadow_rush: 16, struggle: 4, submission: 4, take_down: 4, volt_tackle: 3, wave_crash: 3, wild_charge: 4, wood_hammer: 3}
      # Tell that the move is a recoil move
      # @return [Boolean]
      def recoil?
        true
      end
      # Returns the recoil factor
      # @return [Integer]
      def recoil_factor
        RECOIL_FACTORS[db_symbol] || super
      end
      # Test if the recoil applies to user max hp
      def recoil_applies_on_user_max_hp?
        %i[struggle shadow_rush].include?(db_symbol)
      end
      # Test if teh recoil applis to user current hp
      def recoil_applies_on_user_hp?
        %i[shadow_end].include?(db_symbol)
      end
      # Function applying recoil damage to the user
      # @param hp [Integer]
      # @param user [PFM::PokemonBattler]
      def recoil(hp, user)
        hp = user.max_hp if recoil_applies_on_user_max_hp?
        hp = user.hp if recoil_applies_on_user_hp?
        super(hp, user)
      end
    end
    # Struggle Move
    class Struggle < RecoilMove
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
        [0]
      end
    end
    Move.register(:s_recoil, RecoilMove)
    Move.register(:s_struggle, Struggle)
    public
    class Recycle < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.none?(&:item_consumed)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.item_consumed && target.consumed_item != :__undef__
          @scene.logic.item_change_handler.change_item(target.consumed_item, true, target, user, self)
        end
      end
    end
    Move.register(:s_recycle, Recycle)
    public
    class ReflectType < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets.first
        return if target.typeless?
        return if always_failing_target.include?(target.db_symbol)
        user.type1 = target.type1 == 0 && target.type2 == 0 ? 1 : target.type1
        user.type2 = target.type2
        user.type3 = target.type3
        logic.scene.display_message_and_wait(message(user, target))
      end
      # Get the db_symbol of the Pokemon on which the move always fails
      # @return [Array<Symbol>]
      def always_failing_target
        return %i[arceus silvally]
      end
      # Get the right message to display
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def message(user, target)
        return parse_text_with_2pokemon(19, 1095, user, target)
      end
    end
    Move.register(:s_reflect_type, ReflectType)
    public
    # Relic Song is a damage-dealing Normal-type move introduced in Generation V. It is the signature move of Meloetta.
    # @see https://pokemondb.net/move/relic-song
    # @see https://bulbapedia.bulbagarden.net/wiki/Relic_Song_(move)
    # @see https://www.pokepedia.fr/Chant_Antique
    class RelicSong < Basic
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        super
        return unless user.db_symbol == :meloetta
        return if user.has_ability?(:sheer_force) && user.ability_effect&.activated?
        return if user.has_ability?(:parental_bond) && (user.ability_effect.number_of_attacks - user.ability_effect.attack_number != 1)
        return unless user.form_calibrate(:dance)
        scene.visual.battler_sprite(user.bank, user.position).pokemon = user
        scene.display_message_and_wait(parse_text(22, 157, ::PFM::Text::PKNAME[0] => user.given_name))
      end
    end
    Move.register(:s_relic_song, RelicSong)
    public
    class Reload < BasicWithSuccessfulEffect
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
        super
        return unless @reloading
        user.move_history.pop
        @reloading = false
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return false if user.effects.has?(:force_next_move_base)
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        user.effects.add(Effects::ForceNextMoveBase.new(@logic, user, self, actual_targets, turn_count))
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
        return unless reason == :usable_by_user
        return unless user.effects.has?(:force_next_move_base)
        @reloading = true
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 851, user))
      end
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
        return 2
      end
    end
    Move.register(:s_reload, Reload)
    public
    # Class managing Rest
    # @see https://bulbapedia.bulbagarden.net/wiki/Rest_(move)
    class Rest < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if user.has_ability?(:purifying_salt)
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        if target.has_ability?(:insomnia) || target.has_ability?(:vital_spirit) || target.has_ability?(:sweet_veil) || target.has_ability?(:comatose)
          scene.visual.show_ability(target)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 451, target))
          return true
        else
          if target.hp == target.max_hp
            scene.display_message_and_wait(parse_text_with_pokemon(19, 451, target))
            return true
          else
            if target.effects.has?(:heal_block)
              txt = parse_text_with_pokemon(19, 893, user, '[VAR PKNICK(0000)]' => user.given_name, '[VAR MOVE(0001)]' => name)
              scene.display_message_and_wait(txt)
              return true
            else
              if @logic.field_terrain_effect.misty? && target.affected_by_terrain?
                scene.display_message_and_wait(parse_text_with_pokemon(19, 845, target))
                return true
              else
                if @logic.field_terrain_effect.electric? && target.affected_by_terrain?
                  scene.display_message_and_wait(parse_text_with_pokemon(19, 1207, target))
                  return true
                else
                  if uproar?
                    scene.display_message_and_wait(parse_text_with_pokemon(19, 709, target))
                    return true
                  end
                end
              end
            end
          end
        end
        return false
      end
      # If a pokemon is using Uproar
      # @return [Boolean]
      def uproar?
        fu = @logic.all_alive_battlers.find { |pkm| pkm.effects.has?(:uproar) }
        return !fu.nil?
      end
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
        actual_targets.each do |target|
          scene.visual.show_info_bar(target)
          target.status_sleep(true, 3)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 306, target))
          hp = target.max_hp
          logic.damage_handler.heal(target, hp, test_heal_block: false) do
            scene.display_message_and_wait(parse_text_with_pokemon(19, 638, target))
          end
          target.item_effect.execute_berry_effect if target.item_effect.instance_of?(Effects::Item::StatusBerry::Chesto)
        end
      end
    end
    Move.register(:s_rest, Rest)
    public
    # Inflicts double damage if a teammate fainted on the last turn.
    class Retaliate < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        check = @logic.all_battlers.any? { |battler| battler.from_party? && battler.damage_history.any? { |history| history.ko && history.last_turn? } }
        return check ? power * 2 : power
      end
    end
    Move.register(:s_retaliate, Retaliate)
    public
    class Return < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power = (user.loyalty / 2.5).clamp(1, 255)
        log_data("Power of Return: #{power}")
        return power
      end
    end
    Move.register(:s_return, Return)
    public
    class RevelationDance < Basic
      def definitive_types(user, target)
        return [user.type1] if user.type1 && user.type1 != 0
        first_type, *rest = super
        return [first_type, *rest]
      end
    end
    Move.register(:s_revelation_dance, RevelationDance)
    public
    # Move that deals Revenge to the target
    class Revenge < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        check = user.damage_history.any? { |history| history.turn == $game_temp.battle_turn && history.launcher == target }
        return check ? power * 2 : power
      end
    end
    Move.register(:s_revenge, Revenge)
    public
    # Class that manage the Revival Blessing move
    # @see https://bulbapedia.bulbagarden.net/wiki/Revival_Blessing_(move)
    # @see https://pokemondb.net/move/Revival_Blessing
    # @see https://www.pokepedia.fr/Second_Souffle
    class RevivalBlessing < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if @logic.all_battlers.none? do |battler|
          next unless battler.bank == user.bank
          next unless battler.party_id == user.party_id
          next(battler.dead?)
        end
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        dead_party = @logic.all_battlers.select do |battler|
          next unless battler.bank == user.bank
          next unless battler.party_id == user.party_id
          next(battler.dead?)
        end
        if user.from_player_party?
          GamePlay.open_party_menu_to_revive_pokemon(@logic.all_battlers.select(&:from_player_party?))
          target = logic.all_alive_battlers.find do |battler|
            battler.position != -1 && @scene.visual.battler_sprite(battler.bank, battler.position).out?
          end
          summon_revived_ally(target) if target
        else
          target = dead_party.max_by(&:level)
          target.hp = target.max_hp / 2
          @scene.display_message_and_wait(parse_text_with_pokemon(66, 1590, target))
          summon_revived_ally(target) if target.position != -1
        end
      end
      private
      # If the target is the ally that just got KO'd in a double battle, it gets directly brought back
      # @param ally [PFM::PokemonBattler] ally revived by the move
      def summon_revived_ally(ally)
        @scene.visual.battler_sprite(ally.bank, ally.position).go_in
        logic.actions.reject! { |a| a.is_a?(Actions::Attack) && a.launcher == ally }
      end
    end
    Move.register(:s_revival_blessing, RevivalBlessing)
    public
    # Move that is used during 5 turn and get more powerfull until it gets interrupted
    class Rollout < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
        return true
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        rollout_effect = user.effects.get(effect_name)
        mod = rollout_effect.successive_uses if rollout_effect
        mod = (mod || 0) + 1 if user.successful_move_history.any? { |move| move.db_symbol == :defense_curl }
        return super * 2 ** (mod || 0)
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
        user.effects.get(effect_name)&.kill
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        rollout_effect = user.effects.get(effect_name)
        return rollout_effect.increase if rollout_effect
        effect = create_effect(user, actual_targets)
        user.effects.replace(effect, &:force_next_move?)
        effect.increase
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        return :rollout
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Effects::EffectBase]
      def create_effect(user, actual_targets)
        return Effects::Rollout.new(logic, user, self, actual_targets, 5)
      end
    end
    Move.register(:s_rollout, Rollout)
    Move.register(:s_ice_ball, Rollout)
    public
    class Roost < HealMove
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          hp = target.max_hp / 2
          target.effects.add(Effects::Roost.new(@logic, target, turn_count)) if logic.damage_handler.heal(target, hp)
        end
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
        return 1
      end
    end
    Move.register(:s_roost, Roost)
    public
    # Rototiller move
    class Rototiller < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if logic.all_alive_battlers.none?(&:type_grass?)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the stats to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        super(user, logic.all_alive_battlers.select { |target| target.type_grass? && target.grounded? })
      end
    end
    Move.register(:s_rototiller, Rototiller)
    public
    # Round deals damage. If multiple Pokémon on the same team use it in the same turn, the power doubles to 120 and the 
    # slower Pokémon move immediately after the fastest Pokémon uses it, regardless of their Speed.
    # @see https://pokemondb.net/move/round
    # @see https://bulbapedia.bulbagarden.net/wiki/Round_(move)
    # @see https://www.pokepedia.fr/Chant_Canon
    class Round < BasicWithSuccessfulEffect
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        mod = (any_allies_used_round?(user) ? 2 : 1)
        log_data("power * #{mod} \# round #{mod == 1 ? 'not' : ''} used by an ally this turn.")
        return super * mod
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.force_sort_actions do |a, b|
          next(a <=> b) unless a.is_a?(Actions::Attack) && b.is_a?(Actions::Attack)
          a_is_ally_and_round = logic.allies_of(user).include?(a.launcher) && a.move.db_symbol == :round
          b_is_ally_and_round = logic.allies_of(user).include?(b.launcher) && b.move.db_symbol == :round
          next(b.launcher.speed <=> a.launcher.speed) if a_is_ally_and_round && b_is_ally_and_round
          next(1) if a_is_ally_and_round
          next(-1) if b_is_ally_and_round
          next(a <=> b)
        end
      end
      # Test if any ally had used round in the current turn
      # @param user [PFM::PokemonBattler]
      # @return [Boolean]
      def any_allies_used_round?(user)
        logic.allies_of(user).any? do |ally|
          return true if ally.move_history.any? { |mh| mh.current_turn? && mh.move.db_symbol == :round }
        end
        return false
      end
    end
    register(:s_round, Round)
    public
    # Inflict Sacred Sword to an enemy (ignore evasion and defense stats change)
    class SacredSword < Basic
      # Return the evasion modifier of the target
      # @param _target [PFM::PokemonBattler]
      # @return [Float]
      def evasion_mod(_target)
        return 1
      end
      # Statistic modifier calculation: DFE/DFS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_def_stat_modifier(user, target, ph_move)
        return 1
      end
    end
    Move.register(:s_sacred_sword, SacredSword)
    public
    # The user's party is protected from status conditions.
    # @see https://pokemondb.net/move/safeguard
    # @see https://bulbapedia.bulbagarden.net/wiki/Safeguard
    # @see https://www.pokepedia.fr/Rune_Protect
    class Safeguard < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if logic.bank_effects[user.bank].has?(effect_name)
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if logic.bank_effects[target.bank].has?(effect_name)
          logic.bank_effects[target.bank].add(create_effect(user, target))
          scene.display_message_and_wait(parse_text(18, 138 + target.bank.clamp(0, 1)))
        end
      end
      # Duration of the effect including the current turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def create_effect(user, target)
        Effects::Safeguard.new(logic, target.bank, 0, 5)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :safeguard
      end
    end
    Move.register(:s_safe_guard, Safeguard)
    public
    # class managing Salt Cure move
    class SaltCure < BasicWithSuccessfulEffect
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:salt_cure)
          target.effects.add(Effects::SaltCure.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(66, 1594, target))
        end
      end
    end
    Move.register(:s_salt_cure, SaltCure)
    public
    class SappySeed < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| can_affect_target?(target) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless can_affect_target?(target)
          @logic.add_position_effect(Effects::LeechSeed.new(@logic, user, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 607, target))
        end
      end
      private
      # Check if the effect can affect the target
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def can_affect_target?(target)
        return false if target.dead? || target.type_grass?
        return false if target.effects.has? { |effect| %i[leech_seed_mark substitute].include?(effect.name) }
        return true
      end
    end
    Move.register(:s_sappy_seed, SappySeed)
    public
    # Inflicts Scale Shot to an enemy (multi hit + drops the defense and rises the speed of the user by 1 stage each)
    class ScaleShot < MultiHit
      private
      # Function that defines the number of hits
      def hit_amount(user, actual_targets)
        return 5 if user.has_ability?(:skill_link)
        return MULTI_HIT_CHANCES.sample(random: @logic.generic_rng)
      end
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
        super(user, [user])
      end
    end
    Move.register(:s_scale_shot, ScaleShot)
    public
    # Secret Power deals damage and has a 30% chance of inducing a secondary effect on the opponent, depending on the environment.
    # @see https://pokemondb.net/move/secret-power
    # @see https://bulbapedia.bulbagarden.net/wiki/Secret_Power_(move)
    # @see https://www.pokepedia.fr/Force_Cach%C3%A9e
    class SecretPower < BasicWithSuccessfulEffect
      include Mechanics::LocationBased
      private
      # Play the move animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation(user, targets)
        @secret_power = element_by_location
        mock = Move.new(@secret_power.mock, 1, 1, @scene)
        mock.send(:play_animation, user, targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return if logic.generic_rng.rand(100) > proc_chance
        actual_targets.each do |target|
          send(@secret_power.type, user, target, *@secret_power.params)
        end
      end
      # Change the target status
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param status [Symbol]
      def sp_status(user, target, status)
        logic.status_change_handler.status_change_with_process(status, target, user, self)
      end
      # Change a stat
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param stat [Symbol]
      # @param power [Integer]
      def sp_stat(user, target, stat, power)
        logic.stat_change_handler.stat_change_with_process(stat, power, target, user, self)
      end
      # Secret Power Card to pick
      class SPC
        attr_reader :mock, :type, :params
        # Create a new Secret Power possibility
        # @param mock [Symbol, Integer] ID or db_symbol of the animation move
        # @param type [Symbol] name of the function to call
        # @param params [Array<Object>] params to pass to the function
        def initialize(mock, type, *params)
          @mock = mock
          @type = type
          @params = params
        end
        def to_s
          "<SPC @mock=:#{@mock} @type=:#{@type} @params=#{@params}>"
        end
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
        SECRET_POWER_TABLE
      end
      # Chances of status/stat to proc out of 100
      # @return [Integer]
      def proc_chance
        30
      end
      class << self
        def reset
          const_set(:SECRET_POWER_TABLE, {})
        end
        # @param loc [Symbol] Name of the location type
        # @param mock [Symbol, Integer] ID or db_symbol of the move used for the animation
        # @param type [Symbol] name of the function to call
        # @param params [Array<Object>] params to pass to the function
        def register(loc, mock, type, *params)
          SECRET_POWER_TABLE[loc] ||= []
          SECRET_POWER_TABLE[loc] << SPC.new(mock, type, *params)
        end
      end
      reset
      register(:__undef__, :body_slam, :sp_status, :paralysis)
      register(:regular_ground, :body_slam, :sp_status, :paralysis)
      register(:building, :body_slam, :sp_status, :paralysis)
      register(:grass, :vine_whip, :sp_status, :sleep)
      register(:desert, :mud_slap, :sp_stat, :acc, -1)
      register(:cave, :rock_throw, :sp_status, :flinch)
      register(:water, :water_pulse, :sp_stat, :atk, -1)
      register(:shallow_water, :mud_shot, :sp_stat, :spd, -1)
      register(:snow, :avalanche, :sp_status, :freeze)
      register(:icy_cave, :ice_shard, :sp_status, :freeze)
      register(:volcanic, :incinerate, :sp_status, :burn)
      register(:burial, :shadow_sneak, :sp_status, :flinch)
      register(:soaring, :gust, :sp_stat, :spd, -1)
      register(:misty_terrain, :fairy_wind, :sp_stat, :ats, -1)
      register(:grassy_terrain, :vine_whip, :sp_status, :sleep)
      register(:electric_terrain, :thunder_shock, :sp_status, :paralysis)
      register(:psychic_terrain, :confusion, :sp_stat, :spd, -1)
    end
    Move.register(:s_secret_power, SecretPower)
    public
    # Move that execute Self-Destruct / Explosion
    class SelfDestruct < BasicWithSuccessfulEffect
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if scene.logic.all_alive_battlers.any? { |battler| battler.has_ability?(:damp) }
          show_usage_failure(user)
          decrease_pp(user, targets)
          return false
        end
        return true
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
        return false if reason != :immunity
        play_animation(user, targets)
        deal_effect(user, [])
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.damage_handler.damage_change(user.hp, user)
      end
    end
    register(:s_explosion, SelfDestruct)
    public
    class ShellSideArm < Basic
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @note The formula is the following:
      #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
      #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
      # @return [Integer]
      def damages(user, target)
        @physical = true
        @special = false
        physical_hp = super
        @physical = false
        @special = true
        special_hp = super
        if physical_hp > special_hp
          @physical = true
          @special = false
          return physical_hp
        else
          return special_hp
        end
      end
      # Is the skill physical ?
      # @return [Boolean]
      def physical?
        return @physical.nil? ? super : @physical
      end
      # Is the skill special ?
      # @return [Boolean]
      def special?
        return @special.nil? ? super : @special
      end
      # Is the skill direct ?
      # @return [Boolean]
      def direct?
        return @physical
      end
    end
    Move.register(:s_shell_side_arm, ShellSideArm)
    public
    # Class describing a heal move
    class ShoreUp < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          if $env.sandstorm?
            hp = target.max_hp * 2 / 3
          else
            hp = target.max_hp / 2
          end
          logic.damage_handler.heal(target, hp)
        end
      end
    end
    Move.register(:s_shore_up, ShoreUp)
    public
    # Sketch move
    class Sketch < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.first.move_history.empty? || !user.moveset.include?(self) || user.transform
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        move_index = user.moveset.index(self)
        target_move = actual_targets.first.move_history.last.move
        new_skill = PFM::Skill.new(target_move.id)
        new_move = Battle::Move[new_skill.symbol].new(new_skill.id, new_skill.pp, new_skill.ppmax, scene)
        user.moveset[move_index] = new_move
        user.original.skills_set[move_index] = new_skill unless scene.battle_info.max_level
        scene.display_message_and_wait(parse_text_with_pokemon(19, 691, user, PFM::Text::MOVE[1] => new_move.name))
      end
    end
    Move.register(:s_sketch, Sketch)
    public
    # Sky Drop Move
    # TODO: Need to be reworked
    class SkyDrop < TwoTurnBase
      private
      # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
      # @return [Array<Symbol>]
      CAN_HIT_MOVES = %i[gust hurricane sky_uppercut smack_down thousand_arrows thunder twister]
      # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
      # @return [Array<Symbol>]
      def can_hit_moves
        CAN_HIT_MOVES
      end
      # @param super_result [Boolean] the result of original method
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_userturn1(super_result, user, targets)
        return show_usage_failuer(user) && false if @logic.terrain_effects.has?(:gravity)
        return two_turn_move_usable_by_userturn1(super_result, user, targets)
      end
      # Display the message and the animation of the turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_message_turn1(user, targets)
        targets.each do |target|
          @scene.display_message_and_wait(parse_text_with_2pokemon(19, 1124, user, target))
        end
      end
      # Add the effects to the pokemons (first turn)
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def deal_effects_turn1(user, targets)
        two_turn_deal_effects_turn1(user, targets)
        targets.each do |target|
          target.effects.add(Effects::PreventTargetsMove.new(@logic, target, targets, 1))
        end
      end
    end
    Move.register(:s_sky_drop, SkyDrop)
    public
    # Sleep Talk move
    class SleepTalk < Move
      CANNOT_BE_SELECTED_MOVES = %i[assist belch bide bounce copycat dig dive freeze_shock fly focus_punch geomancy ice_burn me_first metronome sleep_talk mirror_move mimic phantom_force razor_wind shadow_force sketch skull_bash sky_attack sky_drop solar_beam uproar electro_shot]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return true if user.has_ability?(:comatose) && !usable_moves(user).empty?
        return false unless super
        return show_usage_failure(user) && false if !user.asleep? || usable_moves(user).empty?
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        move = usable_moves(user).sample(random: @logic.generic_rng).dup
        move = Battle::Move[move.be_method].new(move.id, move.ppmax, move.ppmax, @scene)
        def move.move_usable_by_user(user, targets)
          return true
        end
        use_another_move(move, user)
      end
      # Function that list all the moves the user can pick
      # @param user [PFM::PokemonBattler]
      # @return [Array<Battle::Move>]
      def usable_moves(user)
        user.skills_set.reject { |skill| CANNOT_BE_SELECTED_MOVES.include?(skill.db_symbol) }
      end
    end
    Move.register(:s_sleep_talk, SleepTalk)
    public
    # Move that deals damage and knocks the target to the ground
    class SmackDown < Basic
      private
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.none? { |target| ineffective_against_target?(target) } || !logic.terrain_effects.has?(:gravity)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if ineffective_against_target?(target)
          target.effects.add(Effects::SmackDown.new(logic, target))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1134, target))
        end
      end
      # Test if a specific effect is ineffective against a target
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def ineffective_against_target?(target)
        return true if target.dead?
        return true if target.grounded? && !target.effects.has?(:out_of_reach_base)
        return true if target.effects.has?(:substitute) && !authentic? || target.effects.has?(:ingrain)
        return true if target.hold_item?(:iron_ball)
        return false
      end
    end
    Move.register(:s_smack_down, SmackDown)
    public
    # Snatch moves first and steals the effects of the next status move used by the opponent(s) in that turn.
    # @see https://pokemondb.net/move/snatch
    # @see https://bulbapedia.bulbagarden.net/wiki/Snatch_(move)
    # @see https://www.pokepedia.fr/Saisie
    class Snatch < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if targets.all? { |pkm| pkm.effects.has?(effect_name) }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(effect_name)
          target.effects.add(create_effect(user, target))
          scene.display_message_and_wait(deal_message(user, target))
        end
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :snatch
      end
      # Create the effect
      # @return [Battle::Effects::EffectBase]
      def create_effect(user, target)
        return Effects::Snatch.new(logic, target)
      end
      # Message displayed when the move succeed
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def deal_message(user, target)
        parse_text_with_pokemon(19, 751, target)
      end
    end
    Move.register(:s_snatch, Snatch)
    public
    class Snore < Basic
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return true if user.has_ability?(:comatose)
        unless user.asleep?
          show_usage_failure(user)
          return false
        end
        return true
      end
    end
    Move.register(:s_snore, Snore)
    public
    # Solar Beam Move
    class SolarBeam < TwoTurnBase
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power2 = power
        power2 *= 0.5 if $env.sandstorm? || $env.hail? || $env.rain?
        return power2
      end
      private
      # Check if the two turn move is executed in one turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def shortcut?(user, targets)
        return true if $env.sunny? || $env.hardsun?
        super
      end
    end
    Move.register(:s_solar_beam, SolarBeam)
    public
    # Class that defines the move Sparkling Aria
    class SparklingAria < Basic
      # Function that indicates the status to check
      def status_condition
        return :burn
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.status == Configs.states.ids[status_condition]
          @logic.status_change_handler.status_change_with_process(:cure, target, user, self)
        end
      end
    end
    Move.register(:s_sparkling_aria, SparklingAria)
    public
    class SparklySwirl < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        targets = @logic.all_battlers.select { |p| p.bank == user.bank && p.party_id == user.party_id && p.alive? }
        return targets.any?(&:status?)
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        effect_targets = @logic.all_battlers.select { |p| p.bank == user.bank && (p.party_id == user.party_id || @logic.adjacent_allies_of(user).include?(p)) && p.alive? }
        effect_targets.each do |target|
          next unless target.status?
          @scene.logic.status_change_handler.status_change(:cure, target)
        end
      end
    end
    Move.register(:s_sparkly_swirl, SparklySwirl)
    public
    class SpectralThief < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| target.battle_stage.any?(&:positive?) }
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.battle_stage.any?(&:positive?)
          target.battle_stage.each_with_index do |stat_value, index|
            next unless stat_value.positive?
            user.set_stat_stage(index, stat_value)
            target.set_stat_stage(index, 0)
          end
          @scene.display_message_and_wait(parse_text_with_pokemon(59, 1934, user))
        end
      end
    end
    Move.register(:s_spectral_thief, SpectralThief)
    public
    # Move that inflict Spikes to the enemy bank
    class Spikes < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        target_bank = user.bank == 1 ? 0 : 1
        return true unless (effect = @logic.bank_effects[target_bank]&.get(:spikes))
        if effect.max_power?
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        if (effect = @logic.bank_effects[bank]&.get(:spikes))
          effect.empower
        else
          @logic.add_bank_effect(Effects::Spikes.new(@logic, bank))
        end
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 154 : 155))
      end
    end
    Move.register(:s_spike, Spikes)
    public
    # Spit Up deals varying damage depending on how many times the user used Stockpile.
    # @see https://pokemondb.net/move/spit-up
    # @see https://bulbapedia.bulbagarden.net/wiki/Spit_Up_(move)
    # @see https://www.pokepedia.fr/Rel%C3%A2che
    class SpitUp < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless user.effects.get(effect_name)&.usable?
        return true
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        effect = user.effects.get(effect_name)
        power = 100 * (effect&.stockpile || 1)
        log_data("\# power = #{power} <stockpile:#{effect&.stockpile || 1}>")
        return power
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return show_usage_failure(user) && false unless user.effects.get(effect_name)&.usable?
        user.effects.get(effect_name).use
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :stockpile
      end
    end
    Move.register(:s_split_up, SpitUp)
    public
    # Spite decreases the move's PP by exactly 4.
    # @see https://bulbapedia.bulbagarden.net/wiki/Spite_(move)
    # @see https://www.pokepedia.fr/Dépit
    class Spite < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.all? { |target| target.skills_set[find_last_skill_position(target)]&.pp == 0 || target.move_history.empty? }
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          last_skill = find_last_skill_position(target)
          next unless target.skills_set[last_skill].pp > 0
          num = 4.clamp(1, target.skills_set[last_skill].pp)
          target.skills_set[last_skill].pp -= num
          scene.display_message_and_wait(parse_text_with_pokemon(19, 641, target, PFM::Text::MOVE[1] => target.skills_set[last_skill].name, '[VAR NUM1(0002)]' => num.to_s))
        end
      end
      # Find the last skill used position in the moveset of the Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Integer]
      def find_last_skill_position(pokemon)
        return 0 if pokemon.move_history.empty?
        pokemon.skills_set.each_with_index do |skill, i|
          return i if skill && skill.id == pokemon.move_history.last.move.id
        end
        return 0
      end
    end
    Move.register(:s_spite, Spite)
    public
    # Class that manage the splash move
    # @see https://bulbapedia.bulbagarden.net/wiki/Splash_(move)
    # @see https://pokemondb.net/move/splash
    # @see https://www.pokepedia.fr/Trempette
    class Splash < Move
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @scene.display_message_and_wait(parse_text(18, 106))
      end
    end
    # Class that manage moves like Celebrate & Hold Hands
    class DoNothing < Move
      alias deal_effect void_true
    end
    Move.register(:s_splash, Splash)
    Move.register(:s_do_nothing, DoNothing)
    public
    # Class that manage the Power Split move
    # @see https://bulbapedia.bulbagarden.net/wiki/Power_Split_(move)
    # @see https://pokemondb.net/move/power-split
    # @see https://www.pokepedia.fr/Partage_Force
    class PowerSplit < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        user.atk_basis = target.atk_basis = ((user.atk_basis + target.atk_basis) / 2).floor
        user.ats_basis = target.ats_basis = ((user.ats_basis + target.ats_basis) / 2).floor
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1102, user))
      end
    end
    Move.register(:s_power_split, PowerSplit)
    # Class that manage the Guard Split move
    # @see https://bulbapedia.bulbagarden.net/wiki/Guard_Split_(move)
    # @see https://pokemondb.net/move/guard-split
    # @see https://www.pokepedia.fr/Partage_Garde
    class GuardSplit < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        user.dfe_basis = target.dfe_basis = ((user.dfe_basis + target.dfe_basis) / 2).floor
        user.dfs_basis = target.dfs_basis = ((user.dfs_basis + target.dfs_basis) / 2).floor
        scene.display_message_and_wait(parse_text_with_pokemon(19, 1105, user))
      end
    end
    Move.register(:s_guard_split, GuardSplit)
    public
    # Class that manage Heart Swap move
    # @see https://bulbapedia.bulbagarden.net/wiki/Heart_Swap_(move)
    # @see https://pokemondb.net/move/heart-swap
    # @see https://www.pokepedia.fr/Permuc%C5%93ur
    class HeartSwap < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        target.acc_stage, user.acc_stage = user.acc_stage, target.acc_stage
        target.atk_stage, user.atk_stage = user.atk_stage, target.atk_stage
        target.ats_stage, user.ats_stage = user.ats_stage, target.ats_stage
        target.dfe_stage, user.dfe_stage = user.dfe_stage, target.dfe_stage
        target.dfs_stage, user.dfs_stage = user.dfs_stage, target.dfs_stage
        target.eva_stage, user.eva_stage = user.eva_stage, target.eva_stage
        target.spd_stage, user.spd_stage = user.spd_stage, target.spd_stage
        scene.display_message_and_wait(parse_text_with_pokemon(19, 673, user))
      end
    end
    Move.register(:s_heart_swap, HeartSwap)
    # Class that manage Power Swap move
    # @see https://bulbapedia.bulbagarden.net/wiki/Power_Swap_(move)
    # @see https://pokemondb.net/move/power-swap
    # @see https://www.pokepedia.fr/Permuforce
    class PowerSwap < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        target.atk_stage, user.atk_stage = user.atk_stage, target.atk_stage
        target.ats_stage, user.ats_stage = user.ats_stage, target.ats_stage
        scene.display_message_and_wait(parse_text_with_pokemon(19, 676, user))
      end
    end
    Move.register(:s_power_swap, PowerSwap)
    # Class that manage Guard Swap move
    # @see https://bulbapedia.bulbagarden.net/wiki/Guard_Swap_(move)
    # @see https://pokemondb.net/move/guard-swap
    # @see https://www.pokepedia.fr/Permugarde
    class GuardSwap < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        target.dfe_stage, user.dfe_stage = user.dfe_stage, target.dfe_stage
        target.dfs_stage, user.dfs_stage = user.dfs_stage, target.dfs_stage
        scene.display_message_and_wait(parse_text_with_pokemon(19, 679, user))
      end
    end
    Move.register(:s_guard_swap, GuardSwap)
    class SpeedSwap < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
        user_old_spd, target_old_spd = user.spd_basis, target.spd_basis
        user.spd_basis, target.spd_basis = target.spd_basis, user.spd_basis
        log_data("speed swap of \##{target.name} exchanged the speeds stats (user speed:#{user_old_spd} > #{user.spd_basis}) (target speed:#{target_old_spd} > #{target.spd_basis})")
      end
    end
    Move.register(:s_speed_swap, SpeedSwap)
    public
    # Class managing Facade / InfernalParade / Bitter Malice moves
    class StatusBoostedMove < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power unless boosted?(user, target)
        new_power = power * factor
        log_data("power = #{new_power} \# after #{self.class} real_base_power")
        return new_power
      end
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
        raise 'This method should be implemented in the subclass'
      end
      # Returns the multiplier applied to the move's base power
      # @return [Integer]
      def factor
        return 2
      end
    end
    # Class managing Infernal Parade / Bitter Malice move
    class InfernalParade < StatusBoostedMove
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
        return target.status?
      end
    end
    # Class managing Facade move
    class Facade < StatusBoostedMove
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
        return user.burn? || user.paralyzed? || user.poisoned? || user.toxic?
      end
    end
    Move.register(:s_infernal_parade, InfernalParade)
    Move.register(:s_bitter_malice, InfernalParade)
    Move.register(:s_facade, Facade)
    public
    # Move that inflict Stealth Rock to the enemy bank
    class StealthRock < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        target_bank = user.bank == 1 ? 0 : 1
        if @logic.bank_effects[target_bank]&.get(:stealth_rock)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Calculate the multiplier needed to get the damage factor of the Stealth Rock
      # @param target [PFM::PokemonBattler]
      # @return [Integer, Float]
      def calc_factor(target)
        type = [self.type]
        @effectiveness = -1
        n = calc_type_n_multiplier(target, :type1, type) * calc_type_n_multiplier(target, :type2, type) * calc_type_n_multiplier(target, :type3, type)
        return n
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        @logic.add_bank_effect(Effects::StealthRock.new(@logic, bank, self))
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 162 : 163))
      end
    end
    Move.register(:s_stealth_rock, StealthRock)
    public
    # Move that inflict Sticky Web to the enemy bank
    class StickyWeb < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        target_bank = user.bank == 1 ? 0 : 1
        if @logic.bank_effects[target_bank]&.get(:sticky_web)
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        @logic.add_bank_effect(Effects::StickyWeb.new(@logic, bank, user))
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 214 : 215))
      end
    end
    Move.register(:s_sticky_web, StickyWeb)
    public
    # Stockpile raises the user's Defense and Special Defense by one stage each and charges up power for use with companion moves Spit Up or Swallow.
    # @see https://pokemondb.net/move/stockpile
    # @see https://bulbapedia.bulbagarden.net/wiki/Stockpile_(move)
    # @see https://www.pokepedia.fr/Stockage
    class Stockpile < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless targets.any? { |target| !target.effects.has?(effect_name) || target.effects.get(effect_name).increasable? }
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(create_effect(user, target)) unless target.effects.has?(effect_name)
          target.effects.get(effect_name).increase
        end
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :stockpile
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target that will be affected by the move
      def create_effect(user, target)
        return Effects::Stockpile.new(logic, target)
      end
    end
    Move.register(:s_stockpile, Stockpile)
    public
    class Stomp < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return super * 2 if target.effects.has?(:minimize)
        return super
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true if target.effects.has?(:minimize)
        super
      end
    end
    Move.register(:s_stomp, Stomp)
    public
    class StompingTantrum < Basic
      # Base power calculation
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return power unless boosted?(user, target)
        log_data("Stomping Tantrum : real_base_power = #{power * 2}")
        return power * 2
      end
      private
      # Determines if the power of Stomping Tantrum should be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def boosted?(user, target)
        user_last_move = user.move_history&.last
        user_last_successful_move = user.successful_move_history&.last
        return false if user_last_move.nil?
        return false if user_last_successful_move&.turn == user_last_move.turn
        return true
      end
    end
    register(:s_stomping_tantrum, StompingTantrum)
    public
    # Move that deals more damage if user has any stat boost
    class StoredPower < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        base_power = db_symbol == :punishment ? 60 : power
        stat_count = stat_increase_count(db_symbol == :punishment ? target : user)
        stat_count = stat_count.clamp(0, 7) if db_symbol == :punishment
        return 20 * stat_count + base_power
      end
      private
      # Get the number of increased stats
      # @param pokemon [PFM::PokemonBattler] Pokémon whose stats stages are checked
      # @return [Integer]
      def stat_increase_count(pokemon)
        return pokemon.battle_stage.select(&:positive?).sum
      end
    end
    Move.register(:s_stored_power, StoredPower)
    public
    # Class describing a move that drains HP
    class StrengthSap < Move
      # Tell that the move is a drain move
      # @return [Boolean]
      def drain?
        return true
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          atkdrained = user.hold_item?(:big_root) ? target.atk * 130 / 100 : target.atk
          if target.has_ability?(:liquid_ooze)
            @scene.visual.show_ability(target)
            logic.damage_handler.damage_change(atkdrained, user)
            @scene.display_message_and_wait(parse_text_with_pokemon(19, 457, user))
          else
            logic.damage_handler.heal(user, atkdrained)
          end
        end
        return true
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return show_usage_failure(user) && false if targets.all? do |target|
          (target.atk_stage == -6 && !target.effects.has?(:contrary)) || (target.atk_stage == 6 && target.effects.has?(:contrary))
        end
        return show_usage_failure(user) && false unless super
        return true
      end
    end
    Move.register(:s_strength_sap, StrengthSap)
    public
    # Stuff Cheeks move
    class StuffCheeks < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless user.hold_berry?(user.battle_item_db_symbol)
        return true
      end
      # Get the reason why the move is disabled
      # @param user [PFM::PokemonBattler] user of the move
      # @return [#call] Block that should be called when the move is disabled
      def disable_reason(user)
        return proc {@logic.scene.display_message_and_wait(parse_text_with_pokemon(60, 508, user)) } unless user.hold_berry?(user.battle_item_db_symbol)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.hold_berry?(target.battle_item_db_symbol)
          if target.item_effect.is_a?(Effects::Item::Berry)
            target.item_effect.execute_berry_effect(force_heal: true, force_execution: true)
            if target.has_ability?(:cheek_pouch) && !target.effects.has?(:heal_block)
              @scene.visual.show_ability(target)
              @logic.damage_handler.heal(target, target.max_hp / 3)
            end
            scene.logic.stat_change_handler.stat_change_with_process(:dfe, 2, target, user, self)
          end
          @logic.item_change_handler.change_item(:none, true, target, user, self)
        end
      end
    end
    Move.register(:s_stuff_cheeks, StuffCheeks)
    public
    # Move that put the mon into a substitute
    class Substitute < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if user.max_hp < factor
          show_usage_failure(user)
          return false
        end
        if user.hp_rate <= (1.0 / factor)
          usage_message(user)
          scene.display_message_and_wait(parse_text_with_pokemon(18, 129, user))
          return false
        end
        if user.effects.has?(:substitute)
          usage_message(user)
          scene.display_message_and_wait(parse_text_with_pokemon(19, 788, user))
          return false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do
          next if user.hp_rate <= (1.0 / factor)
          hp = (user.max_hp / factor).floor
          logic.damage_handler.damage_change(hp, user)
          user.effects.add(Effects::Substitute.new(logic, user))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 785, user))
        end
      end
      # Play the move animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation(user, targets)
        return scene.visual.battler_sprite(user.bank, user.position).switch_to_substitute_sprite unless $options.show_animation
        @scene.visual.set_info_state(:move_animation)
        @scene.visual.wait_for_animation
        logic.scene.visual.battler_sprite(user.bank, user.position).switch_to_substitute_animation
        scene.visual.wait_for_animation
        @scene.visual.set_info_state(:move, targets + [user])
        @scene.visual.wait_for_animation
      end
      private
      # The divisor used to calculate the HP cost for creating a substitute (1/4 of max HP)
      # @return [Integer]
      def factor
        return 4
      end
    end
    # Move that put the mon into a substitute and switches it out, giving its sub to the incoming Pokémon
    class ShedTail < Substitute
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
        return true
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false unless @logic.switch_handler.can_switch?(user, self)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        super
        actual_targets.each do |target|
          target.effects.add(Battle::Effects::ShedTail.new(logic, target))
          logic.request_switch(target, nil)
        end
      end
      # The divisor used to calculate the HP cost for creating a substitute (1/4 of max HP)
      # @return [Integer]
      def factor
        return 2
      end
    end
    Move.register(:s_substitute, Substitute)
    Move.register(:s_shed_tail, ShedTail)
    public
    class SuckerPunch < Basic
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.all? { |target| !logic.battler_attacks_after?(user, target) && target_move_is_status_move?(target) }
          return show_usage_failure(user) && false
        end
        return true
      end
      # Function that tells if the target is using a Move & if it's a status move
      # @return [Boolean]
      def target_move_is_status_move?(target)
        attacks = logic.actions.select { |action| action.is_a?(Actions::Attack) }
        return true unless (move = attacks.find { |action| action.launcher == target }&.move)
        return false if move&.db_symbol == :me_first
        return move&.status?
      end
    end
    Move.register(:s_sucker_punch, SuckerPunch)
    public
    # Move that is stronger if super effective
    class SuperDuperEffective < BasicWithSuccessfulEffect
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @note The formula is the following:
      #       (((((((Level * 2 / 5) + 2) * BasePower * [Sp]Atk / 50) / [Sp]Def) * Mod1) + 2) *
      #         CH * Mod2 * R / 100) * STAB * Type1 * Type2 * Mod3)
      # @return [Integer]
      def damages(user, target)
        damage = super
        return (damage * (super_effective? ? 5461.0 / 4096 : 1)).to_i
      end
    end
    Move.register(:s_super_duper_effective, SuperDuperEffective)
    public
    # Class managing Super Fang move
    class SuperFang < Basic
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        @critical = false
        @effectiveness = 1
        log_data("Forced HP Move: #{(target.hp / 2).clamp(1, Float::INFINITY)} HP")
        return (target.hp / 2).clamp(1, Float::INFINITY)
      end
    end
    Move.register(:s_super_fang, SuperFang)
    public
    # Swallow recovers a varying amount of HP depending on how many times the user has used Stockpile.
    # @see https://pokemondb.net/move/swallow
    # @see https://bulbapedia.bulbagarden.net/wiki/Swallow_(move)
    # @see https://www.pokepedia.fr/Avale
    class Swallow < HealMove
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        unless targets.any? { |target| target.effects.has?(effect_name) || target.effects.get(effect_name)&.usable? }
          return show_usage_failure(user) && false
        end
        return true
      end
      private
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          effect = target.effects.get(effect_name)
          next unless effect&.usable?
          hp = target.max_hp * (ratio[effect.stockpile] || 0)
          log_error("Poorly configured moves, healed hp should be above zero. <stockpile:#{effect.stockpile}, ratios:#{ratio}") if hp <= 0
          log_data("\# heal (swallow) #{hp}hp (stockpile:#{effect.stockpile}, ratio:#{ratio[effect.stockpile]}")
          if logic.damage_handler.heal(target, hp)
            effect.use
          end
        end
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :stockpile
      end
      # Healing value depending on stockpile
      # @return [Array]
      RATIO = [nil, 0.25, 0.5, 1]
      # Healing value depending on stockpile
      # @return [Array]
      def ratio
        RATIO
      end
    end
    Move.register(:s_swallow, Swallow)
    public
    class Switcheroo < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        unless @logic.item_change_handler.can_lose_item?(user) || targets.any? { |target| @logic.item_change_handler.can_lose_item?(target, user) }
          show_usage_failure(user)
          return false
        end
        return true
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target_item = target.battle_item_db_symbol
          user_item = user.battle_item_db_symbol
          @logic.item_change_handler.change_item(user_item, false, target, user, self)
          @logic.item_change_handler.change_item(target_item, false, user, user, self)
          @scene.display_message_and_wait(first_message(user))
          @scene.display_message_and_wait(second_message(user)) if target_item != :__undef__
        end
      end
      # First message displayed
      def first_message(pokemon)
        parse_text_with_pokemon(19, 682, pokemon)
      end
      # Second message displayed
      def second_message(pokemon)
        parse_text_with_pokemon(19, 685, pokemon, ::PFM::Text::ITEM2[1] => pokemon.item_name)
      end
    end
    Move.register(:s_trick, Switcheroo)
    public
    # class managing moves that damages all adjacent enemies that share one type with the user
    class Synchronoise < Basic
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if user.typeless? || targets.none? { |target| share_types?(user, target) }
          show_usage_failure(user)
          return false
        end
        return true if super
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        actual_targets.each do |target|
          next unless share_types?(user, target)
          hp = damages(user, target)
          @logic.damage_handler.damage_change_with_process(hp, target, user, self) do
            if critical_hit?
              scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
            else
              if hp > 0
                efficent_message(effectiveness, target)
              end
            end
          end
          recoil(hp, user) if recoil?
        end
        return true
      end
      # Tell if the user share on type with the target
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def share_types?(user, target)
        return target.type?(user.type1) || target.type?(user.type2) || (target.type?(user.type3) && user.type3 != 0)
      end
    end
    Move.register(:s_synchronoise, Synchronoise)
    public
    class SyrupBomb < BasicWithSuccessfulEffect
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          next if target.effects.has?(:syrup_bomb)
          target.effects.add(Effects::SyrupBomb.new(@logic, target, 3, user))
          @logic.scene.display_message_and_wait(parse_text_with_pokemon(66, 1746, target))
        end
      end
    end
    Move.register(:s_syrup_bomb, SyrupBomb)
    public
    # class managing Tailwind move
    class Tailwind < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param _targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, _targets)
        return false unless super
        return show_usage_failure(user) && false if logic.bank_effects[user.bank].has?(:tailwind)
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _actual_targets)
        @logic.add_bank_effect(Effects::Tailwind.new(@logic, user.bank))
        @scene.display_message_and_wait(parse_text(18, 146 + user.bank))
      end
    end
    Move.register(:s_tailwind, Tailwind)
    public
    # Class describing a heal move
    class TakeHeart < Move
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
        targets.each do |target|
          next unless target.status?
          scene.logic.status_change_handler.status_change(:cure, target)
        end
      end
    end
    Move.register(:s_take_heart, TakeHeart)
    public
    class TarShot < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:tar_shot)
          target.effects.add(Effects::TarShot.new(@logic, target, db_symbol))
        end
      end
    end
    Move.register(:s_tar_shot, TarShot)
    public
    # Taunt move
    class Taunt < Move
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:taunt)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          message = parse_text_with_pokemon(19, 568, target)
          target.effects.add(Effects::Taunt.new(@logic, target))
          @scene.display_message_and_wait(message)
        end
      end
    end
    Move.register(:s_taunt, Taunt)
    public
    # Teatime move
    class Teatime < Move
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return @scene.display_message_and_wait(parse_text(18, 106)) && false if actual_targets.none? { |target| target.hold_berry?(target.battle_item_db_symbol) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        @scene.display_message_and_wait(parse_text(60, 404))
        actual_targets.each do |target|
          next unless target.hold_berry?(target.battle_item_db_symbol)
          next unless target.item_effect.is_a?(Effects::Item::Berry)
          target_effect = Effects::Item.new(logic, target, target.item_effect.db_symbol)
          target_effect.execute_berry_effect(force_heal: true, force_execution: true)
          if target.has_ability?(:cheek_pouch) && !target.effects.has?(:heal_block)
            @scene.visual.show_ability(target)
            @logic.damage_handler.heal(target, target.max_hp / 3)
          end
        end
      end
    end
    Move.register(:s_teatime, Teatime)
    public
    class TechnoBlast < Basic
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        unless user.db_symbol == :genesect
          show_usage_failure(user)
          return false
        end
        return true if super
      end
    end
    Move.register(:s_techno_blast, TechnoBlast)
    public
    class Telekinesis < Move
      # @type [Array<Symbol>]
      POKEMON_UNAFFECTED = %i[diglett dugtrio sandygast palossand]
      # @type [Array<Symbol>]
      EFFECTS_TO_CHECK = %i[telekinesis ingrain smack_down]
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return show_usage_failure(user) && false if EFFECTS_TO_CHECK.any? { |effect_name| targets.all? { |target| target.effects.has?(effect_name) } }
        return show_usage_failure(user) && false if @logic.terrain_effects.has?(:gravity)
        return true
      end
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.db_symbol == :gengar && target.form == 30
        return true if POKEMON_UNAFFECTED.include?(target.db_symbol)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if EFFECTS_TO_CHECK.any? { |effect_name| target.effects.has?(effect_name) }
          target.effects.add(Effects::Telekinesis.new(logic, target, turn_count))
          @logic.scene.display_message_and_wait(parse_text_with_pokemon(19, 1146, target))
        end
      end
      private
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
        return 3
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        return :telekinesis
      end
    end
    Move.register(:s_telekinesis, Telekinesis)
    public
    # Class managing Teleport move
    class Teleport < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def effect_working?(user, targets)
        return false if $game_switches[Yuki::Sw::BT_NoEscape]
        reason = @logic.battle_info.trainer_battle? ? :switch : :flee
        targets.any? do |target|
          return true if target.hold_item?(:smoke_ball)
          return false unless @logic.switch_handler.can_switch?(target, self, reason: reason)
        end
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          if @logic.battle_info.trainer_battle?
            @logic.switch_request << {who: target}
          else
            @battler_s = @scene.visual.battler_sprite(target.bank, target.position)
            @battler_s.flee_animation
            @logic.scene.visual.wait_for_animation
            scene.display_message_and_wait(parse_text_with_pokemon(19, 767, target))
            @logic.battle_result = 1
          end
        end
      end
    end
    Move.register(:s_teleport, Teleport)
    public
    # Class managing the moves that get empowered by a specific field terrain
    class TerrainBoosting < Basic
      TERRAIN_MOVE = {psyblade: :electric_terrain}
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        return @logic.field_terrain_effect.db_symbol == TERRAIN_MOVE[db_symbol] ? power * 1.5 : power
      end
    end
    Move.register(:s_terrain_boosting, TerrainBoosting)
    public
    # Move that execute Misty Explosion
    class MistyExplosion < SelfDestruct
      def real_base_power(user, target)
        return power * 1.5 if @logic.field_terrain_effect.misty?
        return super
      end
    end
    register(:s_misty_explosion, MistyExplosion)
    # Move that execute Expanding Force
    class ExpandingForce < BasicWithSuccessfulEffect
      def real_base_power(user, target)
        return power * 1.5 if @logic.field_terrain_effect.psychic? && user.grounded?
        return super
      end
      def deal_effect(user, actual_targets)
        return unless user.grounded? && @logic.field_terrain_effect.psychic?
        targets = @logic.adjacent_allies_of(actual_targets.first)
        deal_damage(user, targets)
      end
    end
    register(:s_expanding_force, ExpandingForce)
    # Move that execute Rising Voltage
    class RisingVoltage < Basic
      def real_base_power(user, target)
        return power * 2 if @logic.field_terrain_effect.electric? && target.grounded?
        return super
      end
    end
    register(:s_rising_voltage, RisingVoltage)
    # Move that execute Grassy Glide
    class GrassyGlide < BasicWithSuccessfulEffect
      # Return the priority of the skill
      # @param user [PFM::PokemonBattler] user for the priority check
      # @return [Integer]
      def priority(user = nil)
        priority = super
        priority += 1 if priority < 14 && @logic.field_terrain_effect.grassy? && user&.grounded?
        return priority
      end
    end
    register(:s_grassy_glide, GrassyGlide)
    public
    class TerrainMove < Move
      TERRAIN_MOVES = {electric_terrain: :electric_terrain, grassy_terrain: :grassy_terrain, misty_terrain: :misty_terrain, psychic_terrain: :psychic_terrain}
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        turn_count = user.hold_item?(:terrain_extender) ? 8 : 5
        logic.fterrain_change_handler.fterrain_change_with_process(TERRAIN_MOVES[db_symbol], turn_count)
      end
    end
    Move.register(:s_terrain, TerrainMove)
    public
    class TerrainPulse < Basic
      # Return the current type of the move
      # @return [Integer]
      def type
        return data_type(:electric).id if @logic.field_terrain_effect.electric?
        return data_type(:grass).id if @logic.field_terrain_effect.grassy?
        return data_type(:psychic).id if @logic.field_terrain_effect.psychic?
        return data_type(:fairy).id if @logic.field_terrain_effect.misty?
        return data_type(data.type).id
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        base_power = user.grounded? && @logic.field_terrain_effect.any? ? 100 : 50
        return base_power
      end
    end
    Move.register(:s_terrain_pulse, TerrainPulse)
    public
    # Class managing the Thief move
    class Thief < BasicWithSuccessfulEffect
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless @logic.item_change_handler.can_lose_item?(target, user) && %i[none __undef__].include?(user.item_db_symbol)
          next if user.dead? && target.hold_item?(:rocky_helmet) || %i[rough_skin iron_barbs].include?(target.battle_ability_db_symbol)
          additionnal_variables = {PFM::Text::ITEM2[2] => target.item_name, PFM::Text::PKNICK[1] => target.given_name}
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1063, user, additionnal_variables))
          target_item = target.item_db_symbol
          if $game_temp.trainer_battle
            @logic.item_change_handler.change_item(target_item, false, user, user, self)
            if target.from_party? && !target.effects.has?(:item_stolen)
              @logic.item_change_handler.change_item(:none, false, target, user, self)
              target.effects.add(Effects::ItemStolen.new(@logic, target))
            else
              @logic.item_change_handler.change_item(:none, true, target, user, self)
            end
          else
            overwrite = user.from_party? && !target.from_party?
            @logic.item_change_handler.change_item(target_item, overwrite, user, user, self)
            @logic.item_change_handler.change_item(:none, overwrite, target, user, self)
          end
        end
      end
    end
    Move.register(:s_thief, Thief)
    public
    # Thrash Move
    class Thrash < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
        return true
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
        return if user.has_ability?(:dancer) && user.ability_effect.activated?
        effect = user.effects.get(:force_next_move_base)
        return if effect.nil?
        return effect.kill unless effect.triggered?
        logic.status_change_handler.status_change_with_process(:confusion, user, nil, self) unless user.confused?
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return !(user.has_ability?(:dancer) && user.ability_effect.activated?)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        effect = user.effects.get(:force_next_move_base)
        if effect
          logic.status_change_handler.status_change_with_process(:confusion, user, nil, self) if effect.triggered? && !user.confused?
        else
          user.effects.add(Effects::ForceNextMoveBase.new(logic, user, self, actual_targets, turn_count))
        end
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
        return @logic.generic_rng.rand(2..3)
      end
    end
    Move.register(:s_thrash, Thrash)
    Move.register(:s_outrage, Thrash)
    public
    class ThroatChop < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        return actual_targets.any? { |target| !target.effects.has?(:throat_chop) }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:throat_chop)
          target.effects.add(Effects::ThroatChop.new(logic, target, user, turn_count, self))
        end
      end
      private
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
        return 3
      end
    end
    Move.register(:s_throat_chop, ThroatChop)
    public
    # Accuracy depends of weather.
    # @see https://pokemondb.net/move/thunder
    # @see https://bulbapedia.bulbagarden.net/wiki/Thunder_(move)
    # @see https://www.pokepedia.fr/Fatal-Foudre
    class Thunder < Basic
      # Return the current accuracy of the move
      # @return [Integer]
      def accuracy
        al = @scene.logic.all_alive_battlers.any? { |battler| battler.has_ability?(:cloud_nine) || battler.has_ability?(:air_lock) }
        return super if al
        return 50 if $env.sunny? || $env.hardsun?
        return 0 if $env.rain? || $env.hardrain?
        return super
      end
    end
    Move.register(:s_thunder, Thunder)
    Move.register(:s_hurricane, Thunder)
    public
    # Class managing TidyUp move
    class TidyUp < BasicWithSuccessfulEffect
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        logic.all_alive_battlers.each do |b|
          b.effects.each { |e| e.kill if e.rapid_spin_affected? || e.name == :substitute }
          logic.bank_effects[b.bank].each { |e| e.kill if e.rapid_spin_affected? }
        end
      end
    end
    Move.register(:s_tidy_up, TidyUp)
    public
    # Class managing the Topsy-Turvy move
    class TopsyTurvy < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        return false if targets.all? { |target| target.battle_stage.all?(&:zero?) }
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.battle_stage.all?(&:zero?)
          target.battle_stage.each_with_index do |value, index|
            next if value == 0
            target.set_stat_stage(index, -value)
          end
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 1177, target))
        end
      end
    end
    Move.register(:s_topsy_turvy, TopsyTurvy)
    public
    class Torment < Move
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return true if target.effects.has?(:torment)
        return super
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          target.effects.add(Effects::Torment.new(@logic, target))
          @scene.display_message_and_wait(parse_text_with_pokemon(19, 577, target))
        end
      end
    end
    Move.register(:s_torment, Torment)
    public
    class ToxicThread < Move
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        cannot_stat = battle_stage_mod.all? { |stage| stage.count == 0 || !@logic.stat_change_handler.stat_decreasable?(stage.stat, target, user, self) }
        cannot_status = status_effects.all? { |status| status.luck_rate == 0 || !@logic.status_change_handler.status_appliable?(status.status, target, user, self) }
        return failure_message if cannot_stat && cannot_status
        return super
      end
      private
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
        logic.scene.display_message_and_wait(parse_text(18, 74))
        return true
      end
    end
    Move.register(:s_toxic_thread, ToxicThread)
    public
    # Move that inflict Toxic Spikes to the enemy bank
    class ToxicSpikes < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        target_bank = user.bank == 1 ? 0 : 1
        return show_usage_failure(user) && false if @logic.bank_effects[target_bank]&.get(:toxic_spikes)&.max_power?
        return true
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        bank = actual_targets.map(&:bank).first
        if (effect = @logic.bank_effects[bank]&.get(:toxic_spikes))
          effect.empower
        else
          @logic.add_bank_effect(Effects::ToxicSpikes.new(@logic, bank))
        end
        @scene.display_message_and_wait(parse_text(18, bank == 0 ? 158 : 159))
      end
    end
    Move.register(:s_toxic_spike, ToxicSpikes)
    public
    # Class managing moves that deal a status or flinch
    class Transform < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        unless logic.transform_handler.can_transform?(user)
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        return !logic.transform_handler.can_copy?(target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        target = actual_targets
        user.transform = target.sample(random: logic.generic_rng)
        scene.visual.show_switch_form_animation(user)
        scene.visual.wait_for_animation
        scene.display_message_and_wait(parse_text_with_2pokemon(*message_id, user, user.transform))
        user.effects.add(Effects::Transform.new(logic, user))
        user.type1 = data_type(:normal).id if user.transform.type1 == 0
      end
      # Return the text's CSV ids
      # @return [Array<Integer>]
      def message_id
        return 19, 644
      end
    end
    Move.register(:s_transform, Transform)
    public
    # Class managing moves that deal a status between three ones
    class TriAttack < Basic
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
        return true if status_effects.empty?
        status = %i[paralysis burn freeze].sample(random: @logic.generic_rng)
        actual_targets.each do |target|
          @logic.status_change_handler.status_change_with_process(status, target, user, self)
        end
      end
    end
    Move.register(:s_tri_attack, TriAttack)
    public
    # Move changing speed order of Pokemon
    class TrickRoom < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        effect_klass = Effects::TrickRoom
        if logic.terrain_effects.each.any? { |effect| effect.instance_of?(effect_klass) }
          logic.terrain_effects.each { |effect| effect&.kill if effect.instance_of?(effect_klass) }
          return false
        end
        logic.terrain_effects.add(Effects::TrickRoom.new(@scene.logic))
        scene.display_message_and_wait(parse_text_with_pokemon(19, 860, user))
      end
    end
    Move.register(:s_trick_room, TrickRoom)
    public
    # Class managing Triple Arrows move
    # We do not use effect_working because the attack must reduce the opponent's defensive stats
    # Even if we already have the critical hit rate increase activated.
    class TripleArrows < Basic
      # @return [Array<Symbol>]
      UNSTACKABLE_EFFECTS = %i[dragon_cheer focus_energy triple_arrows]
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do
          next if UNSTACKABLE_EFFECTS.any? { |effect_name| user.effects.has?(effect_name) }
          user.effects.add(Effects::TripleArrows.new(logic, user, turn_count))
          scene.display_message_and_wait(parse_text_with_pokemon(19, 1047, user))
        end
      end
      private
      # Return the turn countdown before the effect proc (including the current one)
      # @return [Integer]
      def turn_count
        return 4
      end
    end
    Move.register(:s_triple_arrows, TripleArrows)
    public
    # Trump Card inflicts more damage when fewer PP are left, as per the table.
    # @see https://pokemondb.net/move/trump-card
    # @see https://bulbapedia.bulbagarden.net/wiki/Trump_Card_(move)
    # @see https://www.pokepedia.fr/Atout
    class TrumpCard < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        res = power_table[pp] || default_power
        log_data("power = #{res} \# trump card (pp:#{pp})")
        return res
      end
      private
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
        return true unless target.effects.has?(&:out_of_reach?)
        super
      end
      # Power table
      # Array<Integer>
      POWER_TABLE = [200, 80, 60, 50]
      # Power table
      # @return [Array<Integer>]
      def power_table
        POWER_TABLE
      end
      # Power of the move if the power table is nil at pp index
      # @return [Integer]
      def default_power
        40
      end
    end
    register(:s_trump_card, TrumpCard)
    public
    # Class managing moves that allow a Pokemon to hit and switch
    class UTurn < Move
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
        return true
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
        return true if status?
        raise 'Badly configured move, it should have positive power' if power < 0
        actual_targets.each do |target|
          @hp = damages(user, target)
          @logic.damage_handler.damage_change_with_process(@hp, target, user, self) do
            if critical_hit?
              scene.display_message_and_wait(actual_targets.size == 1 ? parse_text(18, 84) : parse_text_with_pokemon(19, 384, target))
            else
              if @hp > 0
                efficent_message(effectiveness, target)
              end
            end
          end
          recoil(@hp, user) if recoil?
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return false unless @logic.switch_handler.can_switch?(user, self)
        return false if user.item_effect.is_a?(Effects::Item::RedCard)
        return false if actual_targets.any? { |target| target.item_effect.is_a?(Effects::Item::EjectButton) }
        return false if actual_targets.any? { |target| target.has_ability?(:emergency_exit) && (target.hp + @hp) > target.max_hp / 2 && target.alive? }
        @logic.switch_request << {who: user}
      end
    end
    Move.register(:s_u_turn, UTurn)
    public
    # Uproar inflicts damage for 3 turns. During this time, no Pokémon on the field will be able to sleep, and any sleeping Pokémon will be woken up.
    # @see https://pokemondb.net/move/uproar
    # @see https://bulbapedia.bulbagarden.net/wiki/Uproar_(move)
    # @see https://www.pokepedia.fr/Brouhaha
    class UpRoar < BasicWithSuccessfulEffect
      # List the targets of this move
      # @param pokemon [PFM::PokemonBattler] the Pokemon using the move
      # @param logic [Battle::Logic] the battle logic allowing to find the targets
      # @return [Array<PFM::PokemonBattler>] the possible targets
      # @note use one_target? to select the target inside the possible result
      def battler_targets(pokemon, logic)
        @uproaring = pokemon.effects.has?(effect_name)
        return super
      end
      # Return the target symbol the skill can aim
      # @return [Symbol]
      def target
        return @uproaring ? :adjacent_foe : super
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
        user.effects.get(effect_name)&.kill
        scene.display_message_and_wait(calm_down_message(user))
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        return if user.effects.has?(effect_name)
        user.effects.add(create_effect(user, actual_targets))
        logic.terrain_effects.add(Effects::UpRoar::SleepPrevention.new(logic, user))
      end
      # Method responsive testing accuracy and immunity.
      # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>]
      def accuracy_immunity_test(user, targets)
        [super.sample(random: logic.generic_rng)]
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
        :uproar
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets
      # @return [Effects::EffectBase]
      def create_effect(user, actual_targets)
        Effects::UpRoar.new(logic, user, self, actual_targets, 3)
      end
      # Message displayed when the move fails and the pokemon calm down
      # @param user [PFM::PokemonBattler] user of the move
      # @return [String]
      def calm_down_message(user)
        parse_text_with_pokemon(19, 718, user)
      end
    end
    Move.register(:s_uproar, UpRoar)
    public
    # class managing Fake Out move
    class UpperHand < BasicWithSuccessfulEffect
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.any? { |target| logic.battler_attacks_after?(user, target) || invalid_move?(target) }
          show_usage_failure(user)
          return false
        end
        return true
      end
      # Function that tells if the target is using an invalid move: either status, or not priority
      # @return [Boolean]
      def invalid_move?(target)
        attacks = logic.actions.select { |action| action.is_a?(Actions::Attack) }
        return true unless (move = attacks.find { |action| action.launcher == target }&.move)
        return move&.status? || (move && move.relative_priority < 1)
      end
    end
    Move.register(:s_upper_hand, UpperHand)
    public
    class VenomDrench < Move
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        if targets.none? { |target| target.poisoned? || target.toxic? }
          return show_usage_failure(user) && false
        end
        return true
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next unless target.poisoned? || target.toxic?
          logic.stat_change_handler.stat_change_with_process(:atk, -1, target, user)
          logic.stat_change_handler.stat_change_with_process(:ats, -1, target, user)
          logic.stat_change_handler.stat_change_with_process(:spd, -1, target, user)
        end
      end
    end
    Move.register(:s_venom_drench, VenomDrench)
    public
    # Class managing Venoshock move
    class Venoshock < Basic
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
        dmg = super
        dmg *= 2 if target.poisoned? || target.toxic?
        log_data("PSDK Venoshock Damages: #{dmg}")
        return dmg
      end
    end
    Move.register(:s_venoshock, Venoshock)
    public
    class WeatherBall < Basic
      # Return the current type of the move
      # @return [Integer]
      def type
        al = @scene.logic.all_alive_battlers.any? { |battler| battler.has_ability?(:cloud_nine) || battler.has_ability?(:air_lock) }
        return data_type(data.type).id if al
        return data_type(:fire).id if $env.sunny? || $env.hardsun?
        return data_type(:water).id if $env.rain? || $env.hardrain?
        return data_type(:ice).id if $env.hail?
        return data_type(:rock).id if $env.sandstorm?
        return data_type(data.type).id
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        base_power = $env.normal? ? 50 : 100
        return base_power
      end
    end
    Move.register(:s_weather_ball, WeatherBall)
    public
    class WeatherMove < Move
      WEATHER_MOVES = {rain_dance: :rain, sunny_day: :sunny, sandstorm: :sandstorm, hail: :hail, snowscape: :snow}
      WEATHER_ITEMS = {rain_dance: :damp_rock, sunny_day: :heat_rock, sandstorm: :smooth_rock, hail: :icy_rock, snowscape: :icy_rock}
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        nb_turn = user.hold_item?(WEATHER_ITEMS[db_symbol]) ? 8 : 5
        logic.weather_change_handler.weather_change_with_process(WEATHER_MOVES[db_symbol], nb_turn)
      end
    end
    Move.register(:s_weather, WeatherMove)
    public
    # Move that setup a Wish that heals the Pokemon at the target's position
    class Wish < Move
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
        !actual_targets.all? { |target| logic.bank_effects[target.bank].has?(:wish) && logic.bank_effects[target.bank].get(:wish).position == target.position }
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if logic.bank_effects[target.bank].has?(:wish) && logic.bank_effects[target.bank].get(:wish).position == target.position
          logic.bank_effects[target.bank].add(Battle::Effects::Wish.new(logic, target.bank, target.position, target.max_hp / 2))
        end
      end
    end
    Move.register(:s_wish, Wish)
    public
    # Wonder Room switches the Defense and Special Defense of all Pokémon in battle, for 5 turns.
    # @see https://pokemondb.net/move/wonder-room
    # @see https://bulbapedia.bulbagarden.net/wiki/Wonder_Room_(move)
    # @see https://www.pokepedia.fr/Zone_%C3%89trange/G%C3%A9n%C3%A9ration_6
    class WonderRoom < Move
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        if logic.terrain_effects.has?(:wonder_room)
          logic.terrain_effects.get(:wonder_room)&.kill
        else
          logic.terrain_effects.add(Effects::WonderRoom.new(logic, actual_targets, duration))
        end
      end
      # Duration of the effect
      # @return [Integer]
      def duration
        5
      end
    end
    register(:s_wonder_room, WonderRoom)
    public
    # Class managing Crush Grip / Wring Out moves
    class WringOut < Basic
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
        power = (max_power * target.hp_rate).clamp(1, Float::INFINITY)
        log_data("power = #{power} \# after #{self.class} real_base_power")
        return power
      end
      # Get the max power the moves can have
      # @return [Integer]
      def max_power
        return 120
      end
    end
    # Class managing Hard Press move
    class HardPress < WringOut
      # Get the max power the moves can have
      # @return [Integer]
      def max_power
        return 100
      end
    end
    Move.register(:s_wring_out, WringOut)
    Move.register(:s_hard_press, HardPress)
    public
    # Class that manage the Yawn skill, works together with the Effects::Drowsiness class
    # @see https://bulbapedia.bulbagarden.net/wiki/Yawn_(move)
    class Yawn < Move
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
        return false unless super
        target_with_ability = @logic.foes_of(user).find { |target| %i[sweet_veil flower_veil].include?(target.battle_ability_db_symbol) }
        if target_with_ability
          @logic.scene.visual.show_ability(target_with_ability)
          show_usage_failure(user)
          return false
        end
        if targets.any? { |target| @logic.bank_effects[target.bank].has?(:safeguard) || %i[electric_terrain misty_terrain].include?(logic.field_terrain) && target.grounded? }
          return show_usage_failure(user) && false
        end
        return true
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
        return true if super
        return failure_message(target) if target.status?
        return failure_message(target) if %i[drowsiness substitute].any? { |db_symbol| target.effects.has?(db_symbol) } || target.status?
        return failure_message(target) if %i[insomnia vital_spirit comatose].include?(target.battle_ability_db_symbol)
        return failure_message(target) if ($env.sunny? || $env.hardsun?) && target.has_ability?(:leaf_guard)
        return failure_message(target) if target.db_symbol == :minior && target.form == 0
        return false
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
        actual_targets.each do |target|
          next if target.effects.has?(:drowsiness)
          target.effects.add(Effects::Drowsiness.new(@logic, target, turn_count, user))
        end
      end
      # Return the turn countdown before the effect proc (including the current one)
      # @return [Integer]
      def turn_count
        2
      end
      # Display failure message
      # @param target [PFM::PokemonBattler] expected target
      # @return [Boolean] true if blocked
      def failure_message(target)
        @logic.scene.display_message_and_wait(parse_text_with_pokemon(59, 2048, target))
        return true
      end
    end
    Move.register(:s_yawn, Yawn)
  end
  Move.register_move_prevention_user_hook('PSDK Move prev user: Effects') do |user, targets, move|
    next(move.logic.each_effects(user, *targets) do |effect|
      result = effect.on_move_prevention_user(user, targets, move)
      break(result) if result
    end)
  end
  Move.register_move_prevention_target_hook('PSDK Move prev target: Effects') do |user, target, move|
    next(move.logic.each_effects(user, target) do |effect|
      break(true) if effect.on_move_prevention_target(user, target, move) == true
    end == true)
  end
  Move.register_move_disabled_check_hook('PSDK Move disable check: Effects') do |user, move|
    next(move.logic.each_effects(*move.logic.all_alive_battlers) do |effect|
      effect_proc = effect.on_move_disabled_check(user, move)
      break(effect_proc) if effect_proc.is_a?(Proc)
    end)
  end
  Move.register_move_disabled_check_hook('PSDK .24 moves disabled') do |_, move|
    next if move.class != Battle::Move
    next(proc {move.scene.display_message_and_wait('\\c[2]This move is not implemented!\\c[0]') })
  end
  Hooks.register(Move, :effect_working, 'Magic Bounce Ability') do |move_binding|
    move = self
    user = move_binding.local_variable_get(:user)
    actual_targets = move_binding.local_variable_get(:actual_targets)
    next unless move.magic_coat_affected?
    next unless user.can_be_lowered_or_canceled?(move.status? && actual_targets.any? { |target| target.has_ability?(:magic_bounce) })
    if move.affects_bank?
      blocker = actual_targets.find { |target| target.has_ability?(:magic_bounce) }
      move.scene.visual.show_ability(blocker)
      move.scene.visual.wait_for_animation
      @original_target = actual_targets
      actual_targets.clear << user
      next
    end
    actual_targets.map! do |target|
      next(target) unless target.has_ability?(:magic_bounce)
      move.scene.visual.show_ability(target)
      move.scene.visual.wait_for_animation
      @original_target << target
      next(user)
    end
  end
  Hooks.register(Move, :effect_working, 'Magic Coat effect') do |move_binding|
    move = self
    user = move_binding.local_variable_get(:user)
    actual_targets = move_binding.local_variable_get(:actual_targets)
    next unless move.magic_coat_affected?
    next unless user.can_be_lowered_or_canceled?(move.status? && actual_targets.any? { |target| target.effects.has?(:magic_coat) })
    if move.affects_bank?
      @original_target = actual_targets
      actual_targets.clear << user
      next
    end
    actual_targets.map! do |target|
      next(target) unless target.has_ability?(:magic_coat)
      @original_target << target
      next(user)
    end
  end
end
