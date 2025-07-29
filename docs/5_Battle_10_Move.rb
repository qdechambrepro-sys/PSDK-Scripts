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
    end
    # Format move for logging purpose
    # @return [String]
    def to_s
    end
    alias inspect to_s
    # Clone the move and give a reference to the original one
    def clone
    end
    # Return the data of the skill
    # @return [Studio::Move]
    def data
    end
    # Return the name of the skill
    def name
    end
    # Return the skill description
    # @return [String]
    def description
    end
    # Return the battle engine method of the move
    # @return [Symbol]
    def be_method
    end
    alias symbol be_method
    # Return the text of the PP of the skill
    # @return [String]
    def pp_text
    end
    # Return the actual base power of the move
    # @return [Integer]
    def power
    end
    alias base_power power
    # Return the text of the power of the skill (for the UI)
    # @return [String]
    def power_text
    end
    # Return the current type of the move
    # @return [Integer]
    def type
    end
    # Return the current accuracy of the move
    # @return [Integer]
    def accuracy
    end
    # Return the accuracy text of the skill (for the UI)
    # @return [String]
    def accuracy_text
    end
    # Return the priority of the skill
    # @param user [PFM::PokemonBattler] user for the priority check
    # @return [Integer]
    def priority(user = nil)
    end
    ## Move priority
    def relative_priority
    end
    # Return the chance of effect of the skill
    # @return [Integer]
    def effect_chance
    end
    # Get all the status effect of a move
    # @return [Array<Studio::Move::MoveStatus>]
    def status_effects
    end
    # Return the target symbol the skill can aim
    # @return [Symbol]
    def target
    end
    # Return the critical rate index of the skill
    # @return [Integer]
    def critical_rate
    end
    # Is the skill affected by gravity
    # @return [Boolean]
    def gravity_affected?
    end
    # Return the stat stage modifier the skill can apply
    # @return [Array<Studio::Move::BattleStageMod>]
    def battle_stage_mod
    end
    # Is the skill direct ?
    # @return [Boolean]
    def direct?
    end
    # Tell if the move is a mental move
    # @return [Boolean]
    def mental?
    end
    # Is the skill affected by Mirror Move
    # @return [Boolean]
    def mirror_move_affected?
    end
    # Is the skill blocable by Protect and skill like that ?
    # @return [Boolean]
    def blocable?
    end
    # Does the skill has recoil ?
    # @return [Boolean]
    def recoil?
    end
    # Returns the recoil factor
    # @return [Integer]
    def recoil_factor
    end
    # Returns the drain factor
    # @return [Integer]
    def drain_factor
    end
    # Is the skill a punching move ?
    # @return [Boolean]
    def punching?
    end
    # Is the skill a sound attack ?
    # @return [Boolean]
    def sound_attack?
    end
    # Is the skill a slicing attack ?
    # @return [Boolean]
    def slicing_attack?
    end
    # Does the skill unfreeze
    # @return [Boolean]
    def unfreeze?
    end
    # Is the skill a wind attack ?
    # @return [Boolean]
    def wind_attack?
    end
    # Does the skill trigger the king rock
    # @return [Boolean]
    def trigger_king_rock?
    end
    # Is the skill snatchable ?
    # @return [Boolean]
    def snatchable?
    end
    # Is the skill affected by magic coat ?
    # @return [Boolean]
    def magic_coat_affected?
    end
    # Is the skill physical ?
    # @return [Boolean]
    def physical?
    end
    # Is the skill special ?
    # @return [Boolean]
    def special?
    end
    # Is the skill status ?
    # @return [Boolean]
    def status?
    end
    # Return the class of the skill (used by the UI)
    # @return [Integer] 1, 2, 3
    def atk_class
    end
    # Return the symbol of the move in the database
    # @return [Symbol]
    def db_symbol
    end
    # Change the PP
    # @param value [Integer] the new pp value
    def pp=(value)
    end
    # Was the move a critical hit
    # @return [Boolean]
    def critical_hit?
    end
    # Was the move super effective ?
    # @return [Boolean]
    def super_effective?
    end
    # Was the move not very effective ?
    # @return [Boolean]
    def not_very_effective?
    end
    # Tell if the move is a ballistic move
    # @return [Boolean]
    def ballistics?
    end
    # Tell if the move is biting move
    # @return [Boolean]
    def bite?
    end
    # Tell if the move is a dance move
    # @return [Boolean]
    def dance?
    end
    # Tell if the move is a pulse move
    # @return [Boolean]
    def pulse?
    end
    # Tell if the move is a heal move
    # @return [Boolean]
    def heal?
    end
    # Tell if the move is a two turn move
    # @return [Boolean]
    def two_turn?
    end
    # Tell if the move is a powder move
    # @return [Boolean]
    def powder?
    end
    # Tell if the move is a move that can bypass Substitute
    # @return [Boolean]
    def authentic?
    end
    # Tell if the move is a move is a recharge move
    # @return [Boolean]
    def recharge?
    end
    # Tell if the move is an OHKO move
    # @return [Boolean]
    def ohko?
    end
    # Tell if the move is a move that switch the user if that hit
    # @return [Boolean]
    def self_user_switch?
    end
    # Tell if the move is a move that forces target switch
    # @return [Boolean]
    def force_switch?
    end
    # Is the move doing something before any other moves ?
    # @return [Boolean]
    def pre_attack?
    end
    # Tells if the move hits multiple times
    # @return [Boolean]
    def multi_hit?
    end
    # Tell if the move will take two or more turns
    # @return [Boolean]
    def multi_turn?
    end
    # Tell that the move is a drain move
    # @return [Boolean]
    def drain?
    end
    # Tells if the move made contact with target
    # @return [Boolean]
    def made_contact?
    end
    # Get the effectiveness
    attr_reader :effectiveness
    class << self
      # Retrieve a registered move
      # @param symbol [Symbol] be_method of the move
      # @return [Class<Battle::Move>]
      def [](symbol)
      end
      # Register a move
      # @param symbol [Symbol] be_method of the move
      # @param klass [Class] class of the move
      def register(symbol, klass)
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
    end
    # Get the real base power of the move (taking in account all parameter)
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def real_base_power(user, target)
    end
    private
    # Base power calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_base_power(user, target)
    end
    # [Spe]atk calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_sp_atk(user, target)
    end
    # Get the basis atk for the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_sp_atk_basis(user, target, ph_move)
    end
    # Statistic modifier calculation: ATK/ATS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_atk_stat_modifier(user, target, ph_move)
    end
    # Statistic effect modifier calculation: ATK/ATS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_atk_stat_effect_modifier(user, target, ph_move)
    end
    EXPLOSION_SELF_DESTRUCT_MOVE = %i[explosion self_destruct]
    # [Spe]def calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Integer]
    def calc_sp_def(user, target)
    end
    # Get the basis dfe/dfs for the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_sp_def_basis(user, target, ph_move)
    end
    # Statistic modifier calculation: DFE/DFS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_def_stat_modifier(user, target, ph_move)
    end
    # Statistic effect modifier calculation: DFE/DFS
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param ph_move [Boolean] true: physical, false: special
    # @return [Integer]
    def calc_def_stat_effect_modifier(user, target, ph_move)
    end
    # CH calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_ch(user, target)
    end
    # Mod1 multiplier calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod1(user, target)
    end
    # Calculate the TVT mod
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod1_tvt(target)
    end
    # Mod2 multiplier calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod2(user, target)
    end
    # Update the move use count
    # @param user [PFM::PokemonBattler] user of the move
    def update_use_count(user)
    end
    # "Calc" the R range value
    # @return [Range]
    def calc_r_range
    end
    # Mod3 calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Numeric]
    def calc_mod3(user, target)
    end
    public
    # Is the skill a specific type ?
    # @param type_id [Integer] ID of the type
    def type?(type_id)
    end
    # Is the skill typeless ?
    # @return [Boolean]
    def typeless?
    end
    # Is the skill type normal ?
    # @return [Boolean]
    def type_normal?
    end
    # Is the skill type fire ?
    # @return [Boolean]
    def type_fire?
    end
    alias type_feu? type_fire?
    # Is the skill type water ?
    # @return [Boolean]
    def type_water?
    end
    alias type_eau? type_water?
    # Is the skill type electric ?
    # @return [Boolean]
    def type_electric?
    end
    alias type_electrique? type_electric?
    # Is the skill type grass ?
    # @return [Boolean]
    def type_grass?
    end
    alias type_plante? type_grass?
    # Is the skill type ice ?
    # @return [Boolean]
    def type_ice?
    end
    alias type_glace? type_ice?
    # Is the skill type fighting ?
    # @return [Boolean]
    def type_fighting?
    end
    alias type_combat? type_fighting?
    # Is the skill type poison ?
    # @return [Boolean]
    def type_poison?
    end
    # Is the skill type ground ?
    # @return [Boolean]
    def type_ground?
    end
    alias type_sol? type_ground?
    # Is the skill type fly ?
    # @return [Boolean]
    def type_flying?
    end
    alias type_vol? type_flying?
    alias type_fly? type_flying?
    # Is the skill type psy ?
    # @return [Boolean]
    def type_psychic?
    end
    alias type_psy? type_psychic?
    # Is the skill type insect/bug ?
    # @return [Boolean]
    def type_insect?
    end
    alias type_bug? type_insect?
    # Is the skill type rock ?
    # @return [Boolean]
    def type_rock?
    end
    alias type_roche? type_rock?
    # Is the skill type ghost ?
    # @return [Boolean]
    def type_ghost?
    end
    alias type_spectre? type_ghost?
    # Is the skill type dragon ?
    # @return [Boolean]
    def type_dragon?
    end
    # Is the skill type steel ?
    # @return [Boolean]
    def type_steel?
    end
    alias type_acier? type_steel?
    # Is the skill type dark ?
    # @return [Boolean]
    def type_dark?
    end
    alias type_tenebre? type_dark?
    # Is the skill type fairy ?
    # @return [Boolean]
    def type_fairy?
    end
    alias type_fee? type_fairy?
    public
    # Function that calculate the type modifier (for specific uses)
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler]
    # @return [Float]
    def type_modifier(user, target)
    end
    # STAB calculation
    # @param user [PFM::PokemonBattler] user of the move
    # @param types [Array<Integer>] list of definitive types of the move
    # @return [Numeric]
    def calc_stab(user, types)
    end
    # Get the types of the move with 1st type being affected by effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Array<Integer>] list of types of the move
    def definitive_types(user, target)
    end
    private
    # Calc TypeN multiplier of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @param type_to_check [Symbol] type to check on the target
    # @param types [Array<Integer>] list of types the move has
    # @return [Numeric]
    def calc_type_n_multiplier(target, type_to_check, types)
    end
    # Calc the single type multiplier
    # @param target [PFM::PokemonBattler] target of the move
    # @param target_type [Integer] one of the type of the target
    # @param type [Integer] one of the type of the move
    # @return [Float] definitive multiplier
    def calc_single_type_multiplier(target, target_type, type)
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
      end
      # Function that registers a single_type_multiplier_overwrite hook
      # @param reason [String] reason of the single_type_multiplier_overwrite registration
      # @yieldparam target [PFM::PokemonBattler]
      # @yieldparam target_type [Integer] one of the type of the target
      # @yieldparam type [Integer] one of the type of the move
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Float, nil] overwritten
      def register_single_type_multiplier_overwrite_hook(reason)
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
    end
    # Check if the move bypass chance of hit and cannot fail
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] target of the move
    # @return [Boolean]
    def bypass_chance_of_hit?(user, target)
    end
    # Return the accuracy modifier of the user
    # @param user [PFM::PokemonBattler]
    # @return [Float]
    def accuracy_mod(user)
    end
    # Return the evasion modifier of the target
    # @param target [PFM::PokemonBattler]
    # @return [Float]
    def evasion_mod(target)
    end
    public
    # List of symbol describe a one target aim
    OneTarget = %i[any_other_pokemon random_foe adjacent_pokemon adjacent_foe user user_or_adjacent_ally adjacent_ally]
    # List of symbol that doesn't show any choice of target
    TargetNoAsk = %i[adjacent_all_foe all_foe adjacent_all_pokemon all_pokemon user all_ally all_ally_but_user random_foe]
    # Does the skill aim only one Pokemon
    # @return [Boolean]
    def one_target?
    end
    alias is_one_target? one_target?
    # Check if an attack that targets multiple people is targeting only one
    # @param user [PFM::PokemonBattler] user of the move
    # @return [Boolean]
    def one_target_from_zone_attack(user)
    end
    # Does the skill doesn't show a target choice
    # @return [Boolean]
    def no_choice_skill?
    end
    alias is_no_choice_skill? no_choice_skill?
    alias affects_bank? void_false
    # List the targets of this move
    # @param pokemon [PFM::PokemonBattler] the Pokemon using the move
    # @param logic [Battle::Logic] the battle logic allowing to find the targets
    # @return [Array<PFM::PokemonBattler>] the possible targets
    # @note use one_target? to select the target inside the possible result
    def battler_targets(pokemon, logic)
    end
    public
    # Tell if forced next move decreases PP
    # @return [Boolean]
    attr_accessor :forced_next_move_decrease_pp
    # Show the effectiveness message
    # @param effectiveness [Numeric]
    # @param target [PFM::PokemonBattler]
    def efficent_message(effectiveness, target)
    end
    # Show the usage failure when move is not usable by user
    # @param user [PFM::PokemonBattler] user of the move
    def show_usage_failure(user)
    end
    # Function starting the move procedure
    # @param user [PFM::PokemonBattler] user of the move
    # @param target_bank [Integer] bank of the target
    # @param target_position [Integer]
    def proceed(user, target_bank, target_position)
    end
    # Proceed the procedure before any other attack.
    # @param user [PFM::PokemonBattler]
    def proceed_pre_attack(user)
    end
    private
    # Function starting the move procedure for 1 target
    # @param user [PFM::PokemonBattler] user of the move
    # @param possible_targets [Array<PFM::PokemonBattler>] expected targets
    # @param target_bank [Integer] bank of the target
    # @param target_position [Integer]
    def proceed_one_target(user, possible_targets, target_bank, target_position)
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal(user, targets)
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array<PFM::PokemonBattler, nil] list of the right target to the move if success
    # @note this function is responsive of calling on_move_failure and checking all the things related to target/user in regard of move usability
    # @note it is forbiden to change anything in this function if you don't know what you're doing, the && and || are not ther because it's cute
    def proceed_internal_precheck(user, targets)
    end
    # Test move accuracy
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array] the actual targets
    def proceed_move_accuracy(user, targets)
    end
    # Tell if the move accuracy is bypassed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Boolean]
    def bypass_accuracy?(user, targets)
    end
    # Show the move usage message
    # @param user [PFM::PokemonBattler] user of the move
    def usage_message(user)
    end
    # Method that remap user and targets if needed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [PFM::PokemonBattler, Array<PFM::PokemonBattler>] user, targets
    def proceed_battlers_remap(user, targets)
    end
    # Method responsive testing accuracy and immunity.
    # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Array<PFM::PokemonBattler>]
    def accuracy_immunity_test(user, targets)
    end
    # Test if the target is immune
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def target_immune?(user, target)
    end
    # Test if the target has an immunity due to the type of move & ability
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def ability_immunity?(user, target)
    end
    # Test if the target has an immunity to the Prankster ability due to its type
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def prankster_immunity?(user, target)
    end
    # Calls the pre_accuracy_check method for each effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def pre_accuracy_check_effects(user, targets)
    end
    # Calls the post_accuracy_check method for each effects
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] expected targets
    def post_accuracy_check_effects(user, actual_targets)
    end
    # Decrease the PP of the move
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def decrease_pp(user, targets)
    end
    # Function which permit things to happen before the move's animation
    def post_accuracy_check_move(user, actual_targets)
    end
    # Play the move animation
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def play_animation(user, targets)
    end
    # Play the move animation when having substitute
    # @param user [PFM::PokemonBattler] user of the move
    def play_substitute_swap_animation(user)
    end
    # Play the move animation (only without all the decoration)
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def play_animation_internal(user, targets)
    end
    # Function that deals the damage to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_damage(user, actual_targets)
    end
    # Function applying recoil damage to the user
    # @param hp [Integer]
    # @param user [PFM::PokemonBattler]
    def recoil(hp, user)
    end
    # Function applying recoil damage to the user
    # @note Only for Parental Bond !!
    # @param hp [Integer]
    # @param user [PFM::PokemonBattler]
    def special_recoil(hp, user)
    end
    # Test if the effect is working
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    # @return [Boolean]
    def effect_working?(user, actual_targets)
    end
    # Function that deals the status condition to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_status(user, actual_targets)
    end
    # Function that deals the stat to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_stats(user, actual_targets)
    end
    # Function that deals the effect to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_effect(user, actual_targets)
    end
    # Event called if the move failed
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
    def on_move_failure(user, targets, reason)
    end
    # Function that execute another move (Sleep Talk, Metronome)
    # @param move [Battle::Move] has to be cloned before calling the method
    # @param target_bank [Integer]
    # @param target_position [Integer]
    def use_another_move(move, user, target_bank = nil, target_position = nil)
    end
    # Return the new target if redirected or the initial target
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [PFM::PokemonBattler] the target
    def target_redirected(user, targets)
    end
    public
    # Check if an Effects imposes a specific proceed_internal
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @return [Symbol, nil] the symbol of the proceed_internal to call, nil if no specific procedure
    def check_specific_procedure(user, targets)
    end
    # Internal procedure of the move for Parental Bond Ability
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal_parental_bond(user, targets)
    end
    # Internal procedure of the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal_dancer(user, targets)
    end
    public
    # Function that tests if the user is able to use the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
    # @return [Boolean] if the procedure can continue
    def move_usable_by_user(user, targets)
    end
    # Function that tells if the move is disabled
    # @param user [PFM::PokemonBattler] user of the move
    # @return [Boolean]
    def disabled?(user)
    end
    # Get the reason why the move is disabled
    # @param user [PFM::PokemonBattler] user of the move
    # @return [#call] Block that should be called when the move is disabled
    def disable_reason(user)
    end
    # Function that tests if the targets blocks the move
    # @param user [PFM::PokemonBattler] user of the move
    # @param target [PFM::PokemonBattler] expected target
    # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
    # @return [Boolean] if the target evade the move (and is not selected)
    def move_blocked_by_target?(user, target)
    end
    # Detect if the move is protected by another move on target
    # @param target [PFM::PokemonBattler]
    # @param symbol [Symbol]
    def blocked_by?(target, symbol)
    end
    class << self
      # Function that registers a move_prevention_user hook
      # @param reason [String] reason of the move_prevention_user registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam targets [Array<PFM::PokemonBattler>]
      # @yieldparam move [Battle::Move]
      # @yieldreturn [:prevent, nil] :prevent if the move cannot continue
      def register_move_prevention_user_hook(reason)
      end
      # Function that registers a move_disabled_check hook
      # @param reason [String] reason of the move_disabled_check registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Proc, nil] the code to execute if the move is disabled
      def register_move_disabled_check_hook(reason)
      end
      # Function that registers a move_prevention_target hook
      # @param reason [String] reason of the move_prevention_target registration
      # @yieldparam user [PFM::PokemonBattler]
      # @yieldparam target [PFM::PokemonBattler] expected target
      # @yieldparam move [Battle::Move]
      # @yieldreturn [Boolean] if the target is evading the move
      def register_move_prevention_target_hook(reason)
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
        end
        alias counter_move_usable_by_user move_usable_by_user
        # Method calculating the damages done by counter
        # @param user [PFM::PokemonBattler] user of the move
        # @param target [PFM::PokemonBattler] target of the move
        # @return [Integer]
        def damages(user, target)
        end
        alias counter_damages damages
        private
        # Test if the attack fails
        # @param attacker [PFM::PokemonBattler] the last attacker
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean] does the attack fails ?
        def counter_fails?(attacker, user, targets)
        end
        # Damage multiplier if the effect proc
        # @return [Integer, Float]
        def damage_multiplier
        end
        # Method responsive testing accuracy and immunity.
        # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<PFM::PokemonBattler>]
        def accuracy_immunity_test(user, targets)
        end
        alias counter_accuracy_immunity_test accuracy_immunity_test
        # Get the last pokemon that used a skill over the user
        # @param user [PFM::PokemonBattler]
        # @return [PFM::PokemonBattler, nil]
        def last_attacker(user)
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
        end
        alias item_based_damages damages
        # Remove the item from the battler
        # @param battler [PFM::PokemonBattler]
        def consume_item(battler)
        end
        # Tell if the move consume the item
        # @return [Boolean]
        def consume_item?
        end
        # Test if the held item is valid
        # @param name [Symbol]
        # @return [Boolean]
        def valid_held_item?(name)
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
        end
        alias power_based_on_item_real_base_power real_base_power
        private
        # Get the real power of the move depending on the item
        # @param name [Symbol]
        # @return [Integer]
        def get_power_by_item(name)
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
        end
        alias types_based_on_item_definitive_types definitive_types
        private
        # Get the real types of the move depending on the item
        # @param name [Symbol]
        # @return [Array<Integer>]
        def get_types_by_item(name)
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
        end
        alias lb_move_blocked_by_target? move_blocked_by_target?
        private
        # Return the current location type
        # @return [Symbol]
        def location_type
        end
        # Find the element using the given location using randomness.
        # @return [object, nil]
        def element_by_location
        end
        # Element by location type.
        # @return [Hash<Symbol, Array<Symbol>]
        def element_table
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
        end
        # TwoTurn Move execution procedure
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def execution_turn(user, targets)
        end
        # Check if the two turn move is executed in one turn
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Boolean]
        def shortcut?(user, targets)
        end
        alias two_turns_shortcut? shortcut?
        # Add the effects to the pokemons (first turn)
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def deal_effects_turn1(user, targets)
        end
        alias two_turn_deal_effects_turn1 deal_effects_turn1
        # Give the force next move and other effects
        # @param user [PFM::PokemonBattler] user of the move
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def prepare_turn2(user, targets)
        end
        alias two_turn_prepare_turn2 prepare_turn2
        # Remove effects from the first turn
        # @param user [PFM::PokemonBattler]
        def kill_turn1_effects(user)
        end
        alias two_turn_kill_turn1_effects kill_turn1_effects
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def proceed_message_turn1(user, targets)
        end
        # Display the message and the animation of the turn
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        def play_animation_turn1(user, targets)
        end
        # Return the stat changes for the user
        # @param user [PFM::PokemonBattler]
        # @param targets [Array<PFM::PokemonBattler>] expected targets
        # @return [Array<Array<[Symbol, Integer]>>] exemple : [[:dfe, -1], [:atk, 1]]
        def stat_changes_turn1(user, targets)
        end
        # Return the list of the moves that can reach the pokemon event in out_of_reach, nil if all attack reach the user
        # @return [Array<Symbol>]
        def can_hit_moves
        end
        # Return the number of turns the effect works
        # @return Integer
        def turn_count
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
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
    end
    # Class describing a basic move (damage + status + stat = garanteed)
    class BasicWithSuccessfulEffect < Basic
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
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
      end
    end
    # Class describing a self status move (damage + potential status + potential stat to user)
    class SelfStatus < Basic
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
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
      end
      # Check if this the last hit of the move
      # Don't call this method before deal_damage method call
      # @return [Boolean]
      def last_hit?
      end
      # Tells if the move hits multiple times
      # @return [Boolean]
      def multi_hit?
      end
      private
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
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
      end
    end
    # This method applies for triple kick and triple axel: power ramps up but the move stops if the subsequent attack misses.
    class TripleKick < MultiHit
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Recalculate the target each time it's needed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] the current targets we need the accuracy recalculation on
      # @return [Array] the targets hit after accuracy recalculation
      def recalc_targets(user, targets)
      end
      def hit_amount(user, actual_targets)
      end
    end
    # This method applies for Population Bomb: can hit up to 10 times, each subsequent hit checks accuracy.
    class PopulationBomb < TripleKick
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
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
      end
      # Get the number of hit the move can perform
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Integer]
      def hit_amount(user, actual_targets)
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
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
      end
      # Tell that the move is a heal move
      def heal?
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
      end
      # List all the text_id used to announce the waiting turn in TwoTurnBase moves
      ANNOUNCES = {bounce: [19, 544], dig: [19, 538], dive: [19, 535], electro_shot: [66, 1754], fly: [19, 529], freeze_shock: [59, 866], geomancy: [19, 1213], ice_burn: [19, 869], meteor_beam: [59, 2014], phantom_force: [19, 541], razor_wind: [19, 547], shadow_force: [19, 541], sky_attack: [19, 550], skull_bash: [19, 556], solar_beam: [19, 553]}
      # Move db_symbol to a list of stat and power
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      MOVE_TO_STAT = {electro_shot: [[:ats, 1]], meteor_beam: [[:ats, 1]], skull_bash: [[:dfe, 1]]}
      # Move db_symbol to a list of stat and power change on the user
      # @return [Hash<Symbol, Array<Array[Symbol, Power]>]
      def stat_changes_turn1(user, targets)
      end
      # Display the message and the animation of the turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_message_turn1(user, targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
      end
    end
    # Abstract class that manage logic of stage swapping moves and bypass accuracy calculation
    class StatAndStageEditBypassAccuracy < StatAndStageEdit
      # Tell if the move accuracy is bypassed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def bypass_accuracy?(user, targets)
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
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      # Function which permit things to happen before the move's animation
      def post_accuracy_check_move(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Register a Pledge move as one in the System
      # @param db_symbol [Symbol] db_symbol of the move
      def register_pledge_move(db_symbol)
      end
      # Register a pledge combination
      # @param effect_symbol [Symbol]
      # @param first_pledge_symbol [Symbol]
      # @param second_pledge_symbol
      def register_pledge_combination(effect_symbol, first_pledge_symbol, second_pledge_symbol)
      end
      private
      # Check the order to know if the user uses its Pledge Move or wait for the other to attack
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def check_order_of_attack(user, targets)
      end
      # Get the right text depending on the user's side (and if it's a Trainer battle or not)
      # @param user [PFM::PokemonBattler]
      # @param other [PFM::PokemonBattler]
      # @return [String]
      def pledge_wait_text(user, other)
      end
      # Create the Rainbow Effect
      # @param user [PFM::PokemonBattler]
      # @param _actual_targets [Array<PFM::PokemonBattler>]
      def rainbow(user, _actual_targets)
      end
      # Create the SeaOfFire Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def sea_of_fire(_user, actual_targets)
      end
      # Create the Swamp Effect
      # @param _user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      def swamp(_user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def can_be_used?(user, target)
      end
      # Get the post ability change message
      # @param receiver [PFM::PokemonBattler] Ability receiver
      # @param giver [PFM::PokemonBattler] Potential ability giver
      # @return [String]
      # @note data_ability(ability_symbol(giver)).name to manage the Classic and Simple Beam cases
      def post_ability_change_message(receiver, giver)
      end
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(battler)
      end
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(user, target)
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(user, target)
      end
    end
    # Class managing Entrainment move
    class Entrainment < AbilityChanging
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(_, target)
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(user, _)
      end
    end
    # Class managing Simple Beam move
    class SimpleBeam < Entrainment
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(_)
      end
    end
    # Class managing Worry Seed move
    class WorrySeed < SimpleBeam
      # Function that returns the battle ability of a battler
      # @param battler [PFM::PokemonBattler]
      # @return [Symbol]
      def ability_symbol(_)
      end
    end
    # Class managing Role Play move
    class RolePlay < AbilityChanging
      # Function that returns the receiver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def receiver(user, _)
      end
      # Function that returns the giver of the ability
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [PFM::PokemonBattler]
      def giver(_, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
    end
    # Class managing Skill Swap move
    class SkillSwap < AbilityChanging
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Checks if the user can use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def can_be_used?(user, target)
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
      end
      # Tell that the move is a drain move
      # @return [Boolean]
      def drain?
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
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
      end
      # All the stages that the move can modify
      # @return [Array[Symbol]]
      def stages
      end
      # Map the stages ids of each target
      def map_stages_id(user, targets)
      end
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the type given by the move
      # @return [Integer] the ID of the Type given by the move
      def new_type
      end
      # Get the message text
      # @return [String]
      def message(target)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # @return [Symbol] the status that will be applied to the pokemon
      def status
      end
    end
    class BurningJealousy < AlluringVoice
      # @return [Symbol] the status that will be applied to the pokemon
      def status
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Function that list all the moves the user can pick
      # @param user [PFM::PokemonBattler]
      # @return [Array<Battle::Move>]
      def usable_moves(user)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def handle_destiny_knot_effect(user, target)
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
      end
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that deal the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @param target [PFM::PokemonBattler] the current target
      def deal_damage_to_target(user, actual_targets, target)
      end
      # Function that retrieve the battlers that hit the targets
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Array[PFM::Battler]]
      def battlers_that_hit(user)
      end
      # Display the right message in case of critical hit
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @param target [PFM::PokemonBattler] the current target
      # @return [String]
      def critical_hit_message(user, actual_targets, target)
      end
      # Display the message after all the hit have been performed
      # @param nb_hit [Integer] amount of hit performed
      def final_message(nb_hit)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Check if a stat is changeable
      # @param stat [Symbol] the stat to check
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def stat_changeable?(stat, user)
      end
      # The divisor used to calculate the HP cost
      # @return [Integer]
      def factor
      end
      # Method containing stats and the power to raise them
      # @return [Hash<Symbol, Integer>]
      def stats
      end
      # Parse a text from the text database with specific informations and a pokemon
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [String, nil] the text parsed and ready to be displayed
      def message(user, target)
      end
    end
    class FilletAway < BellyDrum
      # Method containing stats and the power to raise them
      # @return [Hash<Symbol, Integer>]
      def stats
      end
      # Parse a text from the text database with specific informations and a pokemon
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [String, nil] the text parsed and ready to be displayed
      def message(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the text displayed when the user gives its item to the target
      # @param target [Array<PFM::PokemonBattler>]
      # @param user [PFM::PokemonBattler] user of the move
      # @param item [String] the name of the item
      # @return [String] the text to display
      def give_text(target, user, item)
      end
    end
    Move.register(:s_bestow, Bestow)
    public
    # Bide Move
    class Bide < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
      end
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Method calculating the damages done by counter
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
      end
      # Method responsive testing accuracy and immunity.
      # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>]
      def accuracy_immunity_test(user, targets)
      end
      # Play the move animation (only without all the decoration)
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation_internal(user, targets)
      end
      # Show the move usage message
      # @param user [PFM::PokemonBattler] user of the move
      def usage_message(user)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      def deal_message(user, target, type)
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
      end
      class << self
        def reset
        end
        def register(loc, type)
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
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the message text
      # @return [String]
      def message(target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Method that tells if the Move's effect can proceed
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def condition(target)
      end
      # Method that tells if the target already has the type
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def type_check(target)
      end
      # Get the type given by the move
      # @return [Integer] the ID of the Type given by the move
      def new_type
      end
      # Get the message text
      # @return [String]
      def message(target)
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
      end
      # Symbol name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::EffectBase]
      def create_effect(user, target)
      end
      # Message displayed when the effect is created
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [String]
      def effect_message(user, target)
      end
    end
    Move.register(:s_charge, Charge)
    public
    # Chilly Reception sets the hail/snow, then the user switches out of battle.
    class ChillyReception < Move
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Check the resistances to one type and return one random
      # @param move_type [Integer] type of the move used by the target
      # @return Integer
      def random_resistances(move_type)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Damage multiplier if the effect proc
      # @return [Integer, Float]
      def damage_multiplier
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Function to apply effects for Ghost-type Pokémon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def apply_ghost_type_effects(user, actual_targets)
      end
      # Function to apply effects for non-Ghost-type Pokémon
      # @param user [PFM::PokemonBattler] user of the move
      def apply_non_ghost_type_effects(user)
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
      end
      # Is the skill special ?
      # @return [Boolean]
      def special?
      end
      # Get the basis atk for the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_sp_atk_basis(user, target, ph_move)
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
      end
      # Statistic effect modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_effect_modifier(user, target, ph_move)
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
      end
      # List of the effects to kill on the enemy board
      # @return [Array<Symbol>]
      def effects_to_kill
      end
      # The type of weather the Move can cancel
      # @return [Symbol]
      def weather_to_cancel
      end
      # The message displayed when the right weather is canceled
      # @return [String]
      def weather_cancel_text
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
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
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
      end
      # Determine which targets the user will focus
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>, nil]
      def determine_targets(user, targets)
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Check if this the last hit of the move
      # Don't call this method before deal_damage method call
      # @return [Boolean]
      def last_hit?
      end
      # Tells if the move hits multiple times
      # @return [Boolean]
      def multi_hit?
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
      end
      private
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
      end
      # Boost added to the power for each turn where the move has been used
      # @return [Integer]
      def echo_boost
      end
      # Maximum value of the power
      # @return [Integer]
      def max_power
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Find the last skill used position in the moveset of the Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Integer]
      def find_last_skill_position(pokemon)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Symbol name of the effect
      # @return [Symbol]
      def effect_symbol
      end
      # Duration of the effect including the current turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::EffectBase]
      def create_effect(user, target)
      end
      def proc_message(user, target)
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
      end
      private
      # Test if the move that should be forced is disallowed to be forced or not
      # @param db_symbol [Symbol]
      # @return [Boolean]
      def move_disallowed?(db_symbol)
      end
      # Verify all the targets and tell if the move can continue
      # @param targets [Array<PFM::PokemonBattler>]
      # @return [Boolean]
      def verify_targets(targets)
      end
      # Tell if the target can be Encore'd
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def cant_encore_target?(target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Create the effect
      # @param move [Battle::Move] move that was used by target
      # @param target [PFM::PokemonBattler] target that used the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Effects::Encore]
      def create_effect(move, target, actual_targets)
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
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Detect if the move is protected by another move on target
      # @param target [PFM::PokemonBattler]
      # @param symbol [Symbol]
      def blocked_by?(target, symbol)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      INCREASED_POWER_MOVES = %i[s_protect s_crafty_shield]
      # Does the move increase the attack power ?
      # @param successful_move_history [PFM::PokemonBattler::SuccessfulMoveHistory]
      # @return [Boolean]
      def increased_power_move?(successful_move_history)
      end
      # Increased power value
      # @return [Integer]
      def increased_power
      end
      LIFTED_EFFECTS = %i[protect crafty_shield]
      # Is the effect lifted by the move
      # @param effect [Battle::Effects::EffectBase]
      # @return [Boolean]
      def lifted_effect?(effect)
      end
      # Message display when the move lift an effect
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @param effect [Battle::Effects::EffectBase]
      # @return [String]
      def deal_message(user, target, effect)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
      end
    end
    Move.register(:s_fell_stinger, FellStinger)
    public
    # Fickle Beam has 20% chance of doubling its base power.
    class FickleBeam < Basic
      # Function which permit things to happen before the move's animation
      def post_accuracy_check_move(user, actual_targets)
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
    end
    Move.register(:s_fickle_beam, FickleBeam)
    public
    class FinalGambit < Move
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Damage multiplier if the effect procs
      # @return [Integer, Float]
      def damage_multiplier
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
      end
      private
      # Calculate the damage dealt by the splash
      # @param target [PFM::PokemonBattler] target of the splash
      # @return [Integer]
      def calc_splash_damage(target)
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
      end
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
      end
      # Get the real power of the move depending on the item
      # @param name [Symbol]
      # @return [Integer]
      def get_power_by_item(name)
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
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
      private
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
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
      end
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
      end
      private
      # Get the second type of the move
      # @return [Symbol]
      def second_type
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Test if any alive battler used followMe this turn
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def any_battler_with_follow_me_effect?(user)
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
      end
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Check if the move will fail when used
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean] if the procedure can continue
      def can_be_used?(user, targets)
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Statistic modifier calculation: ATK/ATS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_atk_stat_modifier(user, target, ph_move)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    Move.register(:s_frustration, Frustration)
    public
    # Move that inflict a critical hit
    class FullCrit < Basic
      # Return the critical rate index of the skill
      # @return [Integer]
      def critical_rate
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Max base power of the move.
      # @return [Integer]
      def max_power
      end
      # Class of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the move effect object
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Battle::Effects::EffectBase]
      def create_effect(user, actual_targets)
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
      end
      # Tell if the move will be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted_move?(user, target)
      end
      # Get the other move triggering the damage boost
      # @return [db_symbol]
      def fusion_move
      end
    end
    class FusionBolt < FusionFlare
      def fusion_move
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Hash containing the countdown for each "Future Sight"-like move
      # @return [Hash]
      COUNTDOWN = {future_sight: 3, doom_desire: 3}
      # Return the right countdown depending on the move, or a static one
      # @return [Integer]
      def countdown
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Effects::PositionTiedEffectBase]
      def create_effect(user, target)
      end
      # Message displayed when the effect is dealt
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      def deal_message(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the effect to check
      def effect
      end
      # Get the new effect to deal
      def class_effect
      end
      # Get the message to display
      def message
      end
    end
    class BaddyBad < GlitzyGlow
      # Get the effect to check
      def effect
      end
      # Get the new effect to deal
      def class_effect
      end
      # Get the message to display
      def message
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
    end
    Move.register(:s_gravity, Gravity)
    public
    # Class describing a self stat move (damage + potential status + potential stat to user)
    class Growth < SelfStat
      def deal_stats(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    # Class managing Psywave
    class Psywave < Basic
      # Method calculating the damages done by the actual move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param _user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(_user, _actual_targets)
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
      end
      # Calculate the multiplier needed to get the damage factor of the Stealth Rock
      # @param target [PFM::PokemonBattler]
      # @return [Integer, Float]
      def calc_factor(target)
      end
    end
    # Adds a layer of Spikes to the target if it lands.
    class CeaselessEdge < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
      end
    end
    class HealingWish < HealingSacrifice
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
      end
    end
    class LunarDance < HealingSacrifice
      # Add the effect to the Pokemon
      # @param target [PFM::PokemonBattler]
      def add_effect(target)
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
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
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
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Create the effect given to the target
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler] targets that will be affected by the move
      # @return [Effects::EffectBase]
      def create_effect(user, target)
      end
      # Message displayed when the effect is dealt to the target
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def deal_message(user, target)
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
      end
      private
      # Return the States that triggers the x2 damages
      STATES = %i[burn paralysis sleep freeze poison toxic]
      # Return the STATES constant
      # @return [Array<Symbol>]
      def states
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
      end
      private
      # Hidden power move types
      # @return [Array<Symbol>] array of types
      TYPES_TABLE = %i[fighting flying poison ground rock bug ghost steel fire water grass electric psychic ice dragon dark]
      # Hidden power move types
      # @return [Array<Symbol>] array of types
      def types_table
      end
      # IVs weighted from the litest to the heaviest in type / damage calculation
      # @return [Array<Symbol>]
      IV_LIST = %i[iv_hp iv_atk iv_dfe iv_spd iv_ats iv_dfs]
      # IVs weighted from the litest to the heaviest in type / damage calculation
      # @return [Array<Symbol>]
      def iv_list
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
      end
      # Define the crash procedure when the move isn't able to connect to the target
      # @param user [PFM::PokemonBattler] user of the move
      def crash_procedure(user)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Check the status
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
      end
    end
    # Class managing Smelling Salts move
    class SmellingSalts < HitThenCureStatus
      # Check the status
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
      end
    end
    # Class managing Wake-Up Slap move
    class WakeUpSlap < HitThenCureStatus
      # Check the status
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean] tell if the Pokemon has this status
      def status_check(target)
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
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Message displayed when the effect is dealt
      # @param user [PFM::PokemonBattler]
      # @param actual_targets [Array<PFM::PokemonBattler>]
      # @return [String]
      def deal_message(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the message text
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def message(pokemon)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @return [Boolean] if the procedure can continue
      def move_usable?(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
    end
    Move.register(:s_ion_deluge, IonDeluge)
    public
    class IvyCudgel < Basic
      include Mechanics::TypesBasedOnItem
      # Tell if the item is consumed during the attack
      # @return [Boolean]
      def consume_item?
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a mask, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a plate, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
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
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Display the usage failure message and return false
      # @param user [PFM::PokemonBattler]
      # @return [false]
      def failure(user)
      end
      private
      # Test if the user has used all the other moves
      # @param user [PFM::PokemonBattler]
      def all_other_move_used?(user)
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
      end
      private
      # Returns the maximum value for the multiplier clamp.
      # @return [Integer]
      def max
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    Move.register(:s_life_dew, LifeDew)
    # Class describing a heal move
    class JungleHealing < HealMove
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _actual_targets)
      end
      # ID of the message that is responsible for telling the beginning of the effect
      # @return [Integer]
      def message_id
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Method that tells if the target already has the type
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def type_check(target)
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
      end
      # Duration of the effect
      # @return [Integer]
      def duration
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
      end
      private
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      def find_magnitude
      end
      # Show the move usage message
      # @param user [PFM::PokemonBattler] user of the move
      def usage_message(user)
      end
      # Damage table
      # Array<[probability_of_100, power, text]>
      # Sum of probabilities must be 100
      MAGNITUDE_TABLE = [[5, 10, 108], [15, 30, 109], [35, 50, 110], [65, 70, 111], [85, 90, 112], [95, 110, 113], [100, 150, 114]]
      # Damage table
      # Array<[probability_of_100, power, text]>
      # Sum of probabilities must be 100
      def magnitude_table
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
      end
      private
      # Function that retrieve the target move from the action stack
      # @return [Symbol]
      def target_move(target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
    end
    Move.register(:s_mimic, Mimic)
    public
    class MindBlown < Basic
      # Get the reason why the move is disabled
      # @param user [PFM::PokemonBattler] user of the move
      # @return [#call] Block that should be called when the move is disabled
      def disable_reason(user)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Define the crash procedure when the move isn't able to connect to the target
      # @param user [PFM::PokemonBattler] user of the move
      def crash_procedure(user)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Tell if the move is usable or not
      # @param move [Battle::Move]
      # @return [Boolean]
      def move_excluded?(move)
      end
      # Function that gets the last used move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Battle::Move, nil] the last move
      def last_move(user, targets)
      end
      # Function that gets the last used move for copy cat
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Battle::Move, nil] the last move
      def copy_cat_last_move(user)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      class << self
        # Register an effect to a "MudSport" like move
        # @param db_symbol [Symbol] Symbol of the move
        # @param klass [Class<Battle::Effects::EffectBase>]
        # @param message_id [Integer] ID of the message to show in file 18 when effect is applied
        def register_effect(db_symbol, klass, message_id)
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
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
      end
      # Get the real types of the move depending on the item, type of the corresponding item if a memory, normal otherwise
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
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
      end
      # Test if the held item is valid
      # @param name [Symbol]
      # @return [Boolean]
      def valid_held_item?(name)
      end
      # Get the real power of the move depending on the item
      # @param name [Symbol]
      # @return [Integer]
      def get_power_by_item(name)
      end
      # Get the real types of the move depending on the item
      # @param name [Symbol]
      # @return [Array<Integer>]
      def get_types_by_item(name)
      end
      class << self
        def reset
        end
        def register(berry, power, type)
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
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
      end
      class << self
        def reset
        end
        def register(loc, move)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Check if the user can be affected by the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @return [Boolean]
      def can_be_affected?(user)
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
      end
      # Tell if the move is an OHKO move
      # @return [Boolean]
      def ohko?
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Return the chance of hit of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Float]
      def chance_of_hit(user, target)
      end
      # Method calculating the damages done by the actual move
      # @note : I used the 4th Gen formula : https://www.smogon.com/dp/articles/damage_formula
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def damages(user, target)
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
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the message
      # @return [String] the text parsed and ready to be displayed
      def message
      end
      # Adjusts the HP of the target based on the calculated average HP
      # @param target [PFM::PokemonBattler]
      # @param average_hp [Integer]
      def adjust_hp(target, average_hp)
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
      end
      private
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
      end
      # Function that if the Pokemon can be switched or not
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def switchable?(actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Damage multiplier if the effect proc
      # @return [Integer, Float]
      def damage_multiplier
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the effect of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target that will be affected by the effect
      # @return [Effects::EffectBase]
      def create_effect(user, target)
      end
      # Return the parsed message to display once the animation is played
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [String]
      def message_after_animation(user, actual_targets)
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
      end
      # Is the skill physical?
      # @return [Boolean]
      def physical?
      end
      # Is the skill special?
      # @return [Boolean]
      def special?
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function which permit things to happen before the move's animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] expected targets
      def post_accuracy_check_move(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    Move.register(:s_power_trick, PowerTrick)
    public
    class PreAttackBase < Basic
      # Is the move doing something before any other moves ?
      # @return [Boolean]
      def pre_attack?
      end
      # Proceed the procedure before any other attack.
      # @param user [PFM::PokemonBattler]
      def proceed_pre_attack(user)
      end
      # Check if the user is able to display the message related to the move
      # @param user [PFM::PokemonBattler] user of the move
      def can_pre_use_move?(user)
      end
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
      end
      # Display the charging animation
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_animation(user)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
    end
    # Implement the Focus Punch move
    class FocusPunch < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
      end
      # Is the pokemon unable to proceed the attack ?
      # @param user [PFM::PokemonBattler]
      # @return [Boolean]
      def disturbed?(user)
      end
    end
    # Implement the Beak Blast move
    class BeakBlast < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
      end
    end
    # Implement the Shell Trap move
    class ShellTrap < PreAttackBase
      # Class of the Effect given by this move
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_effect(user)
      end
      # Display the charging message
      # @param user [PFM::PokemonBattler] user of the move
      def pre_attack_message(user)
      end
      # Tell if the move is usable
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def move_usable?(user, target)
      end
      # Show the usage failure when move is not usable by user
      # @param user [PFM::PokemonBattler] user of the move
      def show_usage_failure(user)
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
      end
      def power
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      def deal_message(user)
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
      end
      private
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Function that checks the Critical Hit Rate Up effects (e.g. Focus Energy) and copies or clears from user.
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def critical_effects_process(user, target)
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
      end
      # Function that does the stuff happening when the effect is unappliable
      # @param target [PFM::PokemonBattler] target of the move/effect
      # @param ability_owner [PFM::PokemonBattler] owner of the ability preventing the effect
      def process_prevention(target, ability_owner)
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
      end
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Get the right symbol for a status of a Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Symbol]
      def right_status_symbol(pokemon)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Returns the recoil factor
      # @return [Integer]
      def recoil_factor
      end
      # Test if the recoil applies to user max hp
      def recoil_applies_on_user_max_hp?
      end
      # Test if teh recoil applis to user current hp
      def recoil_applies_on_user_hp?
      end
      # Function applying recoil damage to the user
      # @param hp [Integer]
      # @param user [PFM::PokemonBattler]
      def recoil(hp, user)
      end
    end
    # Struggle Move
    class Struggle < RecoilMove
      # Get the types of the move with 1st type being affected by effects
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Array<Integer>] list of types of the move
      def definitive_types(user, target)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Get the db_symbol of the Pokemon on which the move always fails
      # @return [Array<Symbol>]
      def always_failing_target
      end
      # Get the right message to display
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def message(user, target)
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
      end
    end
    Move.register(:s_relic_song, RelicSong)
    public
    class Reload < BasicWithSuccessfulEffect
      # Internal procedure of the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_internal(user, targets)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
      end
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
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
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
      # If a pokemon is using Uproar
      # @return [Boolean]
      def uproar?
      end
      # Function that deals the status condition to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_status(user, actual_targets)
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
      end
    end
    Move.register(:s_return, Return)
    public
    class RevelationDance < Basic
      def definitive_types(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # If the target is the ally that just got KO'd in a double battle, it gets directly brought back
      # @param ally [PFM::PokemonBattler] ally revived by the move
      def summon_revived_ally(ally)
      end
    end
    Move.register(:s_revival_blessing, RevivalBlessing)
    public
    # Move that is used during 5 turn and get more powerfull until it gets interrupted
    class Rollout < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Effects::EffectBase]
      def create_effect(user, actual_targets)
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
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
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
      end
      private
      # Function that deals the stats to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Test if any ally had used round in the current turn
      # @param user [PFM::PokemonBattler]
      # @return [Boolean]
      def any_allies_used_round?(user)
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
      end
      # Statistic modifier calculation: DFE/DFS
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param ph_move [Boolean] true: physical, false: special
      # @return [Integer]
      def calc_def_stat_modifier(user, target, ph_move)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Duration of the effect including the current turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def create_effect(user, target)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Check if the effect can affect the target
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def can_affect_target?(target)
      end
    end
    Move.register(:s_sappy_seed, SappySeed)
    public
    # Inflicts Scale Shot to an enemy (multi hit + drops the defense and rises the speed of the user by 1 stage each)
    class ScaleShot < MultiHit
      private
      # Function that defines the number of hits
      def hit_amount(user, actual_targets)
      end
      # Function that deals the stat to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_stats(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Change the target status
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param status [Symbol]
      def sp_status(user, target, status)
      end
      # Change a stat
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @param stat [Symbol]
      # @param power [Integer]
      def sp_stat(user, target, stat, power)
      end
      # Secret Power Card to pick
      class SPC
        attr_reader :mock, :type, :params
        # Create a new Secret Power possibility
        # @param mock [Symbol, Integer] ID or db_symbol of the animation move
        # @param type [Symbol] name of the function to call
        # @param params [Array<Object>] params to pass to the function
        def initialize(mock, type, *params)
        end
        def to_s
        end
      end
      # Element by location type.
      # @return [Hash<Symbol, Array<Symbol>]
      def element_table
      end
      # Chances of status/stat to proc out of 100
      # @return [Integer]
      def proc_chance
      end
      class << self
        def reset
        end
        # @param loc [Symbol] Name of the location type
        # @param mock [Symbol, Integer] ID or db_symbol of the move used for the animation
        # @param type [Symbol] name of the function to call
        # @param params [Array<Object>] params to pass to the function
        def register(loc, mock, type, *params)
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
      end
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity, :pp
      def on_move_failure(user, targets, reason)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Is the skill physical ?
      # @return [Boolean]
      def physical?
      end
      # Is the skill special ?
      # @return [Boolean]
      def special?
      end
      # Is the skill direct ?
      # @return [Boolean]
      def direct?
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # @param super_result [Boolean] the result of original method
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_userturn1(super_result, user, targets)
      end
      # Display the message and the animation of the turn
      # @param user [PFM::PokemonBattler]
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def proceed_message_turn1(user, targets)
      end
      # Add the effects to the pokemons (first turn)
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def deal_effects_turn1(user, targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Function that list all the moves the user can pick
      # @param user [PFM::PokemonBattler]
      # @return [Array<Battle::Move>]
      def usable_moves(user)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Test if a specific effect is ineffective against a target
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def ineffective_against_target?(target)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the effect
      # @return [Battle::Effects::EffectBase]
      def create_effect(user, target)
      end
      # Message displayed when the move succeed
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler]
      # @return [String]
      def deal_message(user, target)
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
      end
      private
      # Check if the two turn move is executed in one turn
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Boolean]
      def shortcut?(user, targets)
      end
    end
    Move.register(:s_solar_beam, SolarBeam)
    public
    # Class that defines the move Sparkling Aria
    class SparklingAria < Basic
      # Function that indicates the status to check
      def status_condition
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Find the last skill used position in the moveset of the Pokemon
      # @param pokemon [PFM::PokemonBattler]
      # @return [Integer]
      def find_last_skill_position(pokemon)
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
      end
    end
    Move.register(:s_guard_swap, GuardSwap)
    class SpeedSwap < StatAndStageEditBypassAccuracy
      private
      # Apply the stats or/and stage edition
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      def edit_stages(user, target)
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
      end
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
      end
      # Returns the multiplier applied to the move's base power
      # @return [Integer]
      def factor
      end
    end
    # Class managing Infernal Parade / Bitter Malice move
    class InfernalParade < StatusBoostedMove
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
      end
    end
    # Class managing Facade move
    class Facade < StatusBoostedMove
      # Check if the move must be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def boosted?(user, target)
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
      end
      # Calculate the multiplier needed to get the damage factor of the Stealth Rock
      # @param target [PFM::PokemonBattler]
      # @return [Integer, Float]
      def calc_factor(target)
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target that will be affected by the move
      def create_effect(user, target)
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
      end
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
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
      end
      private
      # Determines if the power of Stomping Tantrum should be boosted
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def boosted?(user, target)
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
      end
      private
      # Get the number of increased stats
      # @param pokemon [PFM::PokemonBattler] Pokémon whose stats stages are checked
      # @return [Integer]
      def stat_increase_count(pokemon)
      end
    end
    Move.register(:s_stored_power, StoredPower)
    public
    # Class describing a move that drains HP
    class StrengthSap < Move
      # Tell that the move is a drain move
      # @return [Boolean]
      def drain?
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
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
      end
      # Get the reason why the move is disabled
      # @param user [PFM::PokemonBattler] user of the move
      # @return [#call] Block that should be called when the move is disabled
      def disable_reason(user)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Play the move animation
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      def play_animation(user, targets)
      end
      private
      # The divisor used to calculate the HP cost for creating a substitute (1/4 of max HP)
      # @return [Integer]
      def factor
      end
    end
    # Move that put the mon into a substitute and switches it out, giving its sub to the incoming Pokémon
    class ShedTail < Substitute
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
      end
      # Function that tests if the user is able to use the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @note Thing that prevents the move from being used should be defined by :move_prevention_user Hook
      # @return [Boolean] if the procedure can continue
      def move_usable_by_user(user, targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # The divisor used to calculate the HP cost for creating a substitute (1/4 of max HP)
      # @return [Integer]
      def factor
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
      end
      # Function that tells if the target is using a Move & if it's a status move
      # @return [Boolean]
      def target_move_is_status_move?(target)
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
      end
      private
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Healing value depending on stockpile
      # @return [Array]
      RATIO = [nil, 0.25, 0.5, 1]
      # Healing value depending on stockpile
      # @return [Array]
      def ratio
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
      end
      private
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # First message displayed
      def first_message(pokemon)
      end
      # Second message displayed
      def second_message(pokemon)
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
      end
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Tell if the user share on type with the target
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def share_types?(user, target)
      end
    end
    Move.register(:s_synchronoise, Synchronoise)
    public
    class SyrupBomb < BasicWithSuccessfulEffect
      # Function that deals the heal to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param _actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, _actual_targets)
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
      end
    end
    Move.register(:s_take_heart, TakeHeart)
    public
    class TarShot < Basic
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Return the number of turns the effect works
      # @return [Integer]
      def turn_count
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    Move.register(:s_terrain_boosting, TerrainBoosting)
    public
    # Move that execute Misty Explosion
    class MistyExplosion < SelfDestruct
      def real_base_power(user, target)
      end
    end
    register(:s_misty_explosion, MistyExplosion)
    # Move that execute Expanding Force
    class ExpandingForce < BasicWithSuccessfulEffect
      def real_base_power(user, target)
      end
      def deal_effect(user, actual_targets)
      end
    end
    register(:s_expanding_force, ExpandingForce)
    # Move that execute Rising Voltage
    class RisingVoltage < Basic
      def real_base_power(user, target)
      end
    end
    register(:s_rising_voltage, RisingVoltage)
    # Move that execute Grassy Glide
    class GrassyGlide < BasicWithSuccessfulEffect
      # Return the priority of the skill
      # @param user [PFM::PokemonBattler] user for the priority check
      # @return [Integer]
      def priority(user = nil)
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
      end
    end
    Move.register(:s_terrain, TerrainMove)
    public
    class TerrainPulse < Basic
      # Return the current type of the move
      # @return [Integer]
      def type
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
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
      end
    end
    Move.register(:s_thief, Thief)
    public
    # Thrash Move
    class Thrash < BasicWithSuccessfulEffect
      # Tell if the move will take two or more turns
      # @return [Boolean]
      def multi_turn?
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
      end
      # Test if the effect is working
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      # @return [Boolean]
      def effect_working?(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      private
      # Return the number of turns the effect works
      # @return Integer
      def turn_count
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      private
      # Display failure message
      # @return [Boolean] true for blocking
      def failure_message
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
      end
      private
      # Test if the target is immune
      # @param user [PFM::PokemonBattler]
      # @param target [PFM::PokemonBattler]
      # @return [Boolean]
      def target_immune?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the text's CSV ids
      # @return [Array<Integer>]
      def message_id
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
      end
      private
      # Return the turn countdown before the effect proc (including the current one)
      # @return [Integer]
      def turn_count
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
      end
      private
      # Check if the move bypass chance of hit and cannot fail
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Boolean]
      def bypass_chance_of_hit?(user, target)
      end
      # Power table
      # Array<Integer>
      POWER_TABLE = [200, 80, 60, 50]
      # Power table
      # @return [Array<Integer>]
      def power_table
      end
      # Power of the move if the power table is nil at pp index
      # @return [Integer]
      def default_power
      end
    end
    register(:s_trump_card, TrumpCard)
    public
    # Class managing moves that allow a Pokemon to hit and switch
    class UTurn < Move
      # Tell if the move is a move that switch the user if that hit
      def self_user_switch?
      end
      private
      # Function that deals the damage to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_damage(user, actual_targets)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Return the target symbol the skill can aim
      # @return [Symbol]
      def target
      end
      private
      # Event called if the move failed
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @param reason [Symbol] why the move failed: :usable_by_user, :accuracy, :immunity
      def on_move_failure(user, targets, reason)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Method responsive testing accuracy and immunity.
      # It'll report the which pokemon evaded the move and which pokemon are immune to the move.
      # @param user [PFM::PokemonBattler] user of the move
      # @param targets [Array<PFM::PokemonBattler>] expected targets
      # @return [Array<PFM::PokemonBattler>]
      def accuracy_immunity_test(user, targets)
      end
      # Name of the effect
      # @return [Symbol]
      def effect_name
      end
      # Create the effect
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets
      # @return [Effects::EffectBase]
      def create_effect(user, actual_targets)
      end
      # Message displayed when the move fails and the pokemon calm down
      # @param user [PFM::PokemonBattler] user of the move
      # @return [String]
      def calm_down_message(user)
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
      end
      # Function that tells if the target is using an invalid move: either status, or not priority
      # @return [Boolean]
      def invalid_move?(target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
    end
    Move.register(:s_venoshock, Venoshock)
    public
    class WeatherBall < Basic
      # Return the current type of the move
      # @return [Integer]
      def type
      end
      # Get the real base power of the move (taking in account all parameter)
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] target of the move
      # @return [Integer]
      def real_base_power(user, target)
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
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
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
      end
      # Duration of the effect
      # @return [Integer]
      def duration
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
      end
      # Get the max power the moves can have
      # @return [Integer]
      def max_power
      end
    end
    # Class managing Hard Press move
    class HardPress < WringOut
      # Get the max power the moves can have
      # @return [Integer]
      def max_power
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
      end
      # Function that tests if the targets blocks the move
      # @param user [PFM::PokemonBattler] user of the move
      # @param target [PFM::PokemonBattler] expected target
      # @note Thing that prevents the move from being used should be defined by :move_prevention_target Hook.
      # @return [Boolean] if the target evade the move (and is not selected)
      def move_blocked_by_target?(user, target)
      end
      # Function that deals the effect to the pokemon
      # @param user [PFM::PokemonBattler] user of the move
      # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
      def deal_effect(user, actual_targets)
      end
      # Return the turn countdown before the effect proc (including the current one)
      # @return [Integer]
      def turn_count
      end
      # Display failure message
      # @param target [PFM::PokemonBattler] expected target
      # @return [Boolean] true if blocked
      def failure_message(target)
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
