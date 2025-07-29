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
    Move.register_single_type_multiplier_overwrite_hook('PSDK Force Flying') do |target, _, type|
      next if target.grounded? || type != data_type(:ground).id
      next(0)
    end
    Move.register_single_type_multiplier_overwrite_hook('PSDK Force Grounded') do |target, target_type, type|
      next unless target.grounded? || type == data_type(:ground).id
      next(1) if target_type == data_type(:flying).id
      next(data_type(type).hit(data_type(target_type).db_symbol))
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
    # Levitate and mold breaker functionality
    # @param user [PFM::PokemonBattler]
    # @param target [PFM::PokemonBattler]
    # @return [Boolean]
    def levitate_vs_moldbreaker?(user, target)
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
    # Array mapping the status effect to an action
    STATUS_EFFECT_MAPPING = %i[nothing poison paralysis burn sleep freeze confusion flinch toxic]
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
    # Internal procedure of the move for Sheer Force Ability
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def proceed_internal_sheer_force(user, targets)
    end
    # Function that deals the effect to the pokemon
    # @param user [PFM::PokemonBattler] user of the move
    # @param actual_targets [Array<PFM::PokemonBattler>] targets that will be affected by the move
    def deal_effect_sheer_force(user, actual_targets)
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
