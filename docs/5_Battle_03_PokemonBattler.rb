module PFM
  # Class defining a Pokemon during a battle, it aim to copy its properties but also to have the methods related to the battle.
  class PokemonBattler < Pokemon
    include Hooks
    # List of properties to copy
    COPIED_PROPERTIES = %i[@id @form @given_name @code @ability @nature @iv_hp @iv_atk @iv_dfe @iv_spd @iv_ats @iv_dfs @ev_hp @ev_atk @ev_dfe @ev_spd @ev_ats @ev_dfs @trainer_id @trainer_name @step_remaining @loyalty @exp @hp @status @status_count @item_holding @captured_with @captured_in @captured_at @captured_level @gender @skill_learnt @ribbons @character @exp_rate @hp_rate @egg_at @egg_in @evolve_var @pokerus]
    # List of properties to copy with transform
    TRANSFORM_COPIED_PROPERTIES = %i[@id @form @nature @ev_hp @ev_atk @ev_dfe @ev_spd @ev_ats @ev_dfs]
    # List of @battle_properties to copy with transform
    TRANSFORM_BP_METHODS = %i[ability weight height type1 type2 gender shiny atk_basis dfe_basis ats_basis dfs_basis spd_basis atk_stage dfe_stage ats_stage dfs_stage spd_stage]
    # Setter cache for the Transform properties to write
    TRANSFORM_SETTER_CACHE = TRANSFORM_BP_METHODS.to_h { |key| [key, :"#{key}="] }
    # List of properties to copy with Illusion
    ILLUSION_COPIED_PROPERTIES = %i[@id @form @gender @given_name @code @captured_with]
    # List of properties to copy back to original
    BACK_PROPERTIES = %i[@id @form @trainer_id @trainer_name @step_remaining @loyalty @hp @status @status_count @item_holding @captured_with @captured_in @captured_at @captured_level @gender @character @hp_rate @evolve_var @pokerus]
    # @return [Array<Battle::Move>] the moveset of the Pokemon
    attr_reader :moveset
    # @return [Integer] number of turn the Pokemon is in battle
    attr_accessor :turn_count
    alias battle_turns turn_count
    # Last turn the Pokemon fought
    # @return [Integer]
    attr_accessor :last_battle_turn
    # Last turn the pokemon was sent out
    # @return [Integer]
    attr_accessor :last_sent_turn
    # @return [Battle::Move] last move that hit the pokemon
    attr_accessor :last_hit_by_move
    # @return [Integer] 3rd type (Mega / Move effect)
    attr_accessor :type3
    # @return [Integer] the ID of the party that control the Pokemon in the bank
    attr_accessor :party_id
    # @return [Integer] Bank where the Pokemon is supposed to be
    attr_accessor :bank
    # @return [Integer] Position of the Pokemon in the bank
    attr_accessor :position
    # @return [Integer] Place in the team of the Pokemon
    attr_accessor :place_in_party
    # Get the original Pokemon
    # @return [PFM::Pokemon]
    attr_reader :original
    # Get the move history
    # @return [Array<MoveHistory>]
    attr_reader :move_history
    # Get the damage history
    # @return [Array<DamageHistory>]
    attr_reader :damage_history
    # Get the successful move history
    # @return [Array<SuccessfulMoveHistory>]
    attr_reader :successful_move_history
    # Get the stat history
    # @return [Array<StatHistory>]
    attr_reader :stat_history
    # Get the encounter list
    # @return [Array<PFM::PokemonBattler>]
    attr_reader :encounter_list
    # Get the information if the Pokemon is actually a follower or not (changing its go-in-out animation)
    # @return [Boolean]
    attr_accessor :is_follower
    # Get the bag of the battler
    # @return [PFM::Bag]
    attr_accessor :bag
    # Tell if the Pokemon already distributed its experience during the battle
    # @return [Boolean]
    attr_accessor :exp_distributed
    # Get the item held during battle
    # @return [Integer]
    attr_accessor :battle_item
    # Get the data associated to the item if needed
    # @return [Array]
    attr_reader :battle_item_data
    # @return [Boolean] set switching state
    attr_writer :switching
    # Mimic move that was replace by another move with its index
    # @return [Array<Battle::Move, Integer>]
    attr_accessor :mimic_move
    # Tell if the Pokemon has its item consumed
    # @return [Boolean]
    attr_accessor :item_consumed
    # @return [Symbol] the symbol of the consumed item
    attr_accessor :consumed_item
    # @return [Integer] number of times the pokémon has been knocked out
    attr_accessor :ko_count
    # @return [Integer] number of turns the Pokémon has been asleep
    attr_accessor :sleep_turns
    # Get the transform pokemon
    # @return [PFM::PokemonBattler, nil]
    attr_reader :transform
    # Get the Illusion pokemon
    # @return [PFM::PokemonBattler, nil]
    attr_reader :illusion
    # Create a new PokemonBattler from a Pokemon
    # @param original [PFM::Pokemon] original Pokemon (protected during the battle)
    # @param scene [Battle::Scene] current battle scene
    # @param max_level [Integer] new max level for Online battle
    def initialize(original, scene, max_level = Float::INFINITY)
    end
    # Is the Pokemon able to fight ?
    # @return [Boolean]
    def can_fight?
    end
    # Format the Battler for logging purpose
    # @return [String]
    def to_s
    end
    alias inspect to_s
    # Return if the Pokemon is in the player's original team
    # @ Return [Boolean]
    def from_party?
    end
    # Return if the Pokemon is in the player's current team
    # @ Return [Boolean]
    def from_player_party?
    end
    # Return the db_symbol of the current ability of the Pokemon
    # @return [Symbol]
    def ability_db_symbol
    end
    # Return the db_symbol of the current ability of the Pokemon for battle
    # @return [Symbol]
    def battle_ability_db_symbol
    end
    # Tell if the pokemon has an ability
    # @param db_symbol [Symbol] db_symbol of the ability
    # @return [Boolean]
    def has_ability?(db_symbol)
    end
    # Return the db_symbol of the current item the Pokemon is holding
    # @return [Symbol]
    def item_db_symbol
    end
    # Get the item for battle
    # @return [Symbol]
    def battle_item_db_symbol
    end
    # Tell if the pokemon hold an item
    # @param db_symbol [Symbol] db_symbol of the item
    # @return [Boolean]
    def hold_item?(db_symbol)
    end
    # Tell if the pokemon hold a berry
    # @param db_symbol [Symbol] db_symbol of the item
    # @return [Boolean]
    def hold_berry?(db_symbol)
    end
    # Add a move to the move history
    # @param move [Battle::Move]
    # @param targets [Array<PFM::PokemonBattler>]
    def add_move_to_history(move, targets)
    end
    # Add a damage to the damage history
    # @note This method should only be used for successful damages!!!
    # @param damage [Integer]
    # @param launcher [PFM::PokemonBattler]
    # @param move [Battle::Move]
    # @param ko [Boolean]
    def add_damage_to_history(damage, launcher, move, ko)
    end
    # Add a successful move to the successful move history
    # @note This method should only be used for successful moves!!!
    # @param move [Battle::Move]
    # @param targets [Array<PFM::PokemonBattler>]
    def add_successful_move_to_history(move, targets)
    end
    # Add a stat to the stat history
    # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
    # @param power [Integer] power of the stat change
    # @param target [PFM::PokemonBattler] target of the stat change
    # @param launcher [PFM::PokemonBattler, nil] launcher of the stat change
    # @param move [Battle::Move, nil] move that cause the stat change
    def add_stat_to_history(stat, power, target, launcher, move)
    end
    # Add a battler to the encounter list
    # @note The battler is not added if it is already present in the list
    # @param battler [PFM::PokemonBattler]
    def add_battler_to_encounter_list(battler)
    end
    # Delete a battler to the encounter list
    # @param battler [PFM::PokemonBattler]
    def delete_battler_to_encounter_list(battler)
    end
    # Test if the Pokemon has encountered the battler
    # @param battler [PFM::PokemonBattler]
    def encountered?(battler)
    end
    # Test if the last move was of a certain symbol
    # @param db_symbol [Symbol] symbol of the move
    def last_move_is?(db_symbol)
    end
    # Test if the last successful move was of a certain symbol
    # @param db_symbol [Symbol] symbol of the move
    def last_successful_move_is?(db_symbol)
    end
    # Test if the Pokemon can use a move
    # @return [Boolean]
    def can_move?
    end
    # List of abilities that ignore abilities
    ABILITIES_IGNORING_ABILITIES = %i[mold_breaker teravolt turboblaze]
    # List of moves that ignore abilities
    MOVES_IGNORING_ABILITIES = %i[sunsteel_strike moongeist_beam photon_geyser]
    # Test if the Pokemon can have a lowering stat or have its move canceled (return false if the Pokemon has mold breaker)
    #
    # List of ability that should be affected:
    # :battle_armor|:clear_body|:damp|:dry_skin|:filter|:flash_fire|:flower_gift|:heatproof|:hyper_cutter|:immunity|:inner_focus|:insomnia|
    # :keen_eye|:leaf_guard|:levitate|:lightning_rod|:limber|:magma_armor|:marvel_scale|:motor_drive|:oblivious|:own_tempo|:sand_veil|:shell_armor|
    # :shield_dust|:simple|:snow_cloak|:solid_rock|:soundproof|:sticky_hold|:storm_drain|:sturdy|:suction_cups|:tangled_feet|:thick_fat|:unaware|:vital_spirit|
    # :volt_absorb|:water_absorb|:water_veil|:white_smoke|:wonder_guard|:big_pecks|:contrary|:friend_guard|:heavy_metal|:light_metal|:magic_bounce|:multiscale|
    # :sap_sipper|:telepathy|:wonder_skin|:aroma_veil|:bulletproof|:flower_veil|:fur_coat|:overcoat|:sweet_veil|:dazzling|:disguise|:fluffy|:queenly_majesty|
    # :water_bubble|:mirror_armor|:punk_rock|:ice_scales|:ice_face|:pastel_veil||:armor_tail|:earth_eater|:good_as_gold|:purifying_salt|:well_backed_body|:wind_rider
    # @param test [Boolean] if the test should be done
    # @return [Boolean] potential changed result
    def can_be_lowered_or_canceled?(test = true)
    end
    # Tell if the Pokémon has a ability ignoring ability
    # @return [Boolean]
    def current_ability_ignoring_ability?
    end
    # Tell if the Pokemon uses a move ignoring abilities
    # @return [Boolean]
    def current_move_ignoring_ability?
    end
    # Return the Pokemon rareness
    # @return [Integer]
    def rareness
    end
    # Return the base HP
    # @return [Integer]
    def base_hp
    end
    # Copy all the properties back to the original pokemon
    def copy_properties_back_to_original
    end
    # Function that resets everything from the pokemon once it got switched out of battle
    def reset_states
    end
    # if the pokemon is switching during this turn
    # @return [Boolean]
    def switching?
    end
    # Confuse the Pokemon
    # @param _ [Boolean] (ignored)
    # @return [Boolean] if the pokemon has been confused
    def status_confuse(_ = false)
    end
    # Is the Pokemon confused?
    # @return [Boolean]
    def confused?
    end
    # Apply the flinch effect
    # @param forced [Boolean] this parameter is ignored since flinch effect is volatile
    def apply_flinch(forced = false)
    end
    # Transform this pokemon into another pokemon
    # @param pokemon [PFM::PokemonBattler, nil]
    def transform=(pokemon)
    end
    # Setup the Illusion of the Pokémon
    def illusion=(pokemon)
    end
    # Is the pokemon affected by the terrain ?
    # @return [Boolean]
    def affected_by_terrain?
    end
    # Neutralize a type on the Pokemon
    # @param types [Array<Integer>]
    # @param default [Integer] (default: id of :normal) type applied when no other types are defined
    def ignore_types(*types, default: data_type(:normal).id)
    end
    # Change the type of the pokemons
    # @param types [Array<Integer>]
    def change_types(*types)
    end
    # Is the Pokemon typeless?
    # @return [Boolean]
    def typeless?
    end
    # Copy the moveset upon level up
    # @param moveset_before [Array<PFM::Skill>]
    def level_up_copy_moveset(moveset_before)
    end
    # Copy some important data upon level up
    def level_up_copy
    end
    # Update the PFM::PokemonBattler loyalty when level up
    def update_loyalty
    end
    private
    # Copy the properties of the original pokemon
    def copy_properties
    end
    # Copy the properties of a transformed pokemon
    def copy_transform_properties
    end
    # Copy the properties of a pokemon under Illusion
    def copy_illusion_properties
    end
    # Copy the moveset of the original Pokemon
    def copy_moveset
    end
    # Copy the moveset of the pokemon it transforms
    def copy_transform_moveset
    end
    # Function that sets the is_follower variable (for animation purpose)
    def initialize_set_is_follower
    end
    # Function that sets the is_follower variable for LetsGo FollowMe (for animation purpose)
    def initialize_letsgo_set_is_follower
    end
    public
    # List of the UIs able to omit the Illusion form of the Pokemon
    # @return [Array<Class>]
    ILLUSION_PROOF_SCENES = [GamePlay::Party_Menu, GamePlay::Summary]
    # Return the current ID of the Pokemon
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the id saved before Illusion was triggered
    # @return [Integer]
    def id
    end
    # Return the current form of the Pokemon
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the form saved before Illusion was triggered
    # @return [Integer]
    def form
    end
    # Return the current given name of the Pokemon
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the given_name saved before Illusion was triggered
    # @return [String]
    def given_name
    end
    # Return the current name of the Pokemon
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the name of the original
    # @return [String]
    def name
    end
    # Return the current code of the Pokemon
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the code saved before Illusion was triggered
    # @return [Integer]
    def code
    end
    # Return the current ball ID the Pokemon was captured with
    # If the current UI is one defined in PFM::PokemonBattler::ILLUSION_PROOF_SCENES
    # then it'll send the ball id saved before Illusion was triggered
    # @return [Integer]
    def captured_with
    end
    # Return the cry file name of the Pokemon
    # If the Pokemon is under the effect of Illusion, returns the cry from the target of the ability
    # @return [String]
    def cry
    end
    # Return the battler's combat property
    # @return [Integer]
    def atk_basis
    end
    # Set the battler's combat property
    # @param value [Integer]
    def atk_basis=(value)
    end
    # Restore the battler's property original value
    def restore_atk_basis
    end
    # Return the battler's combat property
    # @return [Integer]
    def ats_basis
    end
    # Set the battler's combat property
    # @param value [Integer]
    def ats_basis=(value)
    end
    # Restore the battler's property original value
    def restore_ats_basis
    end
    # Return the battler's combat property
    # @return [Integer]
    def dfe_basis
    end
    # Set the battler's combat property
    # @param value [Integer]
    def dfe_basis=(value)
    end
    # Restore the battler's property original value
    def restore_dfe_basis
    end
    # Return the battler's combat property
    # @return [Integer]
    def dfs_basis
    end
    # Set the battler's combat property
    # @param value [Integer]
    def dfs_basis=(value)
    end
    # Restore the battler's property original value
    def restore_dfs_basis
    end
    # Return the battler's combat property
    # @return [Integer]
    def spd_basis
    end
    # Set the battler's combat property
    # @param value [Integer]
    def spd_basis=(value)
    end
    # Restore the battler's property original value
    def restore_spd_basis
    end
    # Return the battler's combat property
    # @return [Integer]
    def nature_id
    end
    # Set the battler's combat property
    # @param value [Integer]
    def nature_id=(value)
    end
    # Restore the battler's property original value
    def restore_nature_id
    end
    # Return the battler's combat property
    # @return [Integer]
    def ability
    end
    # Set the battler's combat property
    # @param value [Integer]
    def ability=(value)
    end
    # Restore the battler's property original value
    def restore_ability
    end
    # Return the battler's combat property
    # @return [Integer]
    def height
    end
    # Set the battler's combat property
    # @param value [Integer]
    def height=(value)
    end
    # Restore the battler's property original value
    def restore_height
    end
    # Return the battler's combat property
    # @return [Integer]
    def weight
    end
    # Set the battler's combat property
    # @param value [Integer]
    def weight=(value)
    end
    # Restore the battler's property original value
    def restore_weight
    end
    # Return the battler's combat property
    # @return [Integer]
    def gender
    end
    # Set the battler's combat property
    # @param value [Integer]
    def gender=(value)
    end
    # Restore the battler's property original value
    def restore_gender
    end
    # Return the battler's combat property
    # @return [Integer]
    def rareness
    end
    # Set the battler's combat property
    # @param value [Integer]
    def rareness=(value)
    end
    # Restore the battler's property original value
    def restore_rareness
    end
    # Return the battler's combat property
    # @return [Integer]
    def type1
    end
    # Set the battler's combat property
    # @param value [Integer]
    def type1=(value)
    end
    # Restore the battler's property original value
    def restore_type1
    end
    # Return the battler's combat property
    # @return [Integer]
    def type2
    end
    # Set the battler's combat property
    # @param value [Integer]
    def type2=(value)
    end
    # Restore the battler's property original value
    def restore_type2
    end
    # Return the battler's combat property
    # @return [Integer]
    def type3
    end
    # Set the battler's combat property
    # @param value [Integer]
    def type3=(value)
    end
    # Restore the battler's property original value
    def restore_type3
    end
    # Restore all Pokemon types
    def restore_types
    end
    public
    # Minimal value of the stat modifier level (stage)
    MIN_STAGE = -6
    # Maximal value of the stat modifier level (stage)
    MAX_STAGE = 6
    # Return the current atk
    # @return [Integer]
    def atk
    end
    # Return the current dfe
    # @return [Integer]
    def dfe
    end
    # Return the current spd
    # @return [Integer]
    def spd
    end
    # Return the current ats
    # @return [Integer]
    def ats
    end
    # Return the current dfs
    # @return [Integer]
    def dfs
    end
    # Return the atk modifier
    # @return [Float] the multiplier
    def atk_modifier
    end
    # Return the dfe modifier
    # @return [Float] the multiplier
    def dfe_modifier
    end
    # Return the spd modifier
    # @return [Float] the multiplier
    def spd_modifier
    end
    # Return the ats modifier
    # @return [Float] the multiplier
    def ats_modifier
    end
    # Return the dfs modifier
    # @return [Float] the multiplier
    def dfs_modifier
    end
    # Return the atk stage
    # @return [Integer]
    def atk_stage
    end
    # Return the dfe stage
    # @return [Integer]
    def dfe_stage
    end
    # Return the spd stage
    # @return [Integer]
    def spd_stage
    end
    # Return the ats stage
    # @return [Integer]
    def ats_stage
    end
    # Return the dfs stage
    # @return [Integer]
    def dfs_stage
    end
    # Return the evasion stage
    # @return [Integer]
    def eva_stage
    end
    # Return the accuracy stage
    # @return [Integer]
    def acc_stage
    end
    # Return the regular stat multiplier
    # @param stage [Integer] the value of the stage
    # @return [Float] the multiplier
    def stat_multiplier_regular(stage)
    end
    # Return the accuracy related stat multiplier
    # @param stage [Integer] the value of the stage
    # @return [Float] the multiplier
    def stat_multiplier_acceva(stage)
    end
    # Change a stat stage
    # @param stat_id [Integer] id of the stat : 0 = atk, 1 = dfe, 2 = spd, 3 = ats, 4 = dfs, 5 = eva, 6 = acc
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_stat(stat_id, amount)
    end
    # Change the atk stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_atk(amount)
    end
    # Change the dfe stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_dfe(amount)
    end
    # Change the spd stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_spd(amount)
    end
    # Change the ats stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_ats(amount)
    end
    # Change the dfs stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_dfs(amount)
    end
    # Change the eva stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_eva(amount)
    end
    # Change the acc stage
    # @param amount [Integer] the amount to change on the stat stage
    # @return [Integer] the difference between the current and the last stage value
    def change_acc(amount)
    end
    # Set a stat stage
    # @param stat_id [Integer] id of the stat : 0 = atk, 1 = dfe, 2 = spd, 3 = ats, 4 = dfs, 5 = eva, 6 = acc
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def set_stat_stage(stat_id, value)
    end
    # Set the acc stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def acc_stage=(value)
    end
    # Set the spd stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def spd_stage=(value)
    end
    # Set the atk stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def atk_stage=(value)
    end
    # Set the ats stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def ats_stage=(value)
    end
    # Set the dfe stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def dfe_stage=(value)
    end
    # Set the dfs stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def dfs_stage=(value)
    end
    # Set the eva stage
    # @param value [Integer] the new value of the stat stage
    # @return [Integer] the new stat stage value
    def eva_stage=(value)
    end
    public
    # Check if the pokemon is grounded
    # @return [Boolean]
    def grounded?
    end
    class << self
      # Register a hook forcing Pokemon to be grounded
      # @param reason [String] reason of the force_grounded hook
      # @yieldparam pokemon [PFM::PokemonBattler]
      # @yieldparam scene [Battle::Scene]
      # @yieldreturn [Boolean] if the Pokemon is forced to be grounded
      def register_force_grounded_hook(reason)
      end
      # Register a hook forcing Pokemon to be flying (ie not grounded)
      # @param reason [String] reason of the force_flying hook
      # @yieldparam pokemon [PFM::PokemonBattler]
      # @yieldparam scene [Battle::Scene]
      # @yieldreturn [Boolean] if the Pokemon is forced to be "flying"
      def register_force_flying_hook(reason)
      end
    end
    register_force_grounded_hook('PSDK grounded: Gravity') { |_, scene| scene.logic.terrain_effects.has?(:gravity) }
    register_force_grounded_hook('PSDK grounded: Iron Ball') { |pokemon| pokemon.hold_item?(:iron_ball) }
    register_force_grounded_hook('PSDK grounded: Smack Down') { |pokemon| pokemon.effects.has?(:smack_down) }
    register_force_grounded_hook('PSDK grounded: Ingrain') { |pokemon| pokemon.effects.has?(:ingrain) }
    register_force_flying_hook('PSDK flying: Air Balloon') { |pokemon| pokemon.hold_item?(:air_balloon) }
    register_force_flying_hook('PSDK flying: Fly type') { |pokemon, _| pokemon.type_fly? }
    register_force_flying_hook('PSDK flying: Levitate') { |pokemon| pokemon.has_ability?(:levitate) }
    public
    # Get the effect handler
    # @return [Battle::Effects::EffectsHandler]
    attr_reader :effects
    Hooks.register(PFM::PokemonBattler, :on_reset_states, 'PSDK reset effects') do
      @effects = Battle::Effects::EffectsHandler.new
    end
    # Evaluate all the effects related to this Pokemon
    # @param yielder [Proc] proc to call with the effect
    def evaluate_effects(yielder)
    end
    # Get the status effect
    # @return [Battle::Effects::Status]
    def status_effect
    end
    # Get the ability effect
    # @return [Battle::Effects::Ability]
    def ability_effect
    end
    # Get the item effect
    # @return [Battle::Effects::Item]
    def item_effect
    end
    public
    # Class defining an history of move use
    class MoveHistory
      # Get the turn when it was used
      # @return [Integer]
      attr_reader :turn
      # Get the move that was used
      # @return [Battle::Move]
      attr_reader :move
      # Get the target that were affected by the move
      # @return [Array<PFM::PokemonBattler>]
      attr_reader :targets
      # Get the actual move object that was used
      # @return [Battle::Move]
      attr_reader :original_move
      # Get the attack order of the Pokemon
      # @return [Integer]
      attr_reader :attack_order
      # Create a new Move History
      # @param move [Battle::Move]
      # @param targets [Array<PFM::PokemonBattler>]
      # @param attack_order [Integer]
      def initialize(move, targets, attack_order)
      end
      # Tell if the move was used during last turn
      # @return [Boolean]
      def last_turn?
      end
      # Tell if the move was used during the current turn
      # @return [Boolean]
      def current_turn?
      end
      # Get the db_symbol of the move
      # @return [Symbol]
      def db_symbol
      end
    end
    # History specialization for successful moves
    class SuccessfulMoveHistory < MoveHistory
    end
    public
    # Class defining an history of damages took
    class DamageHistory
      # Get the turn when it was used
      # @return [Integer]
      attr_reader :turn
      # Get the amount of damage took
      # @return [Integer]
      attr_reader :damage
      # Get the launcher that cause the damages
      # @return [PFM::PokemonBattler, nil]
      attr_reader :launcher
      # Get the move that cause the damages
      # @return [Battle::Move, nil]
      attr_reader :move
      # Get if the Pokemon was knocked out
      # @return [Boolean]
      attr_reader :ko
      # Create a new Damage History
      # @param damage [Integer]
      # @param launcher [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param ko [Boolean]
      def initialize(damage, launcher, move, ko)
      end
      # Tell if the move was used during last turn
      # @return [Boolean]
      def last_turn?
      end
      # Tell if the move was used during the current turn
      # @return [Boolean]
      def current_turn?
      end
    end
    public
    class StatHistory
      # Get the turn when it was used
      # @return [Integer]
      attr_reader :turn
      # :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @return [Symbol]
      attr_reader :stat
      # Get the power of the stat change
      # @return [Integer]
      attr_reader :power
      # Get the target of the stat change
      # @return [PFM::PokemonBattler]
      attr_reader :target
      # Get the launcher of the stat change
      # @return [PFM::PokemonBattler, nil]
      attr_reader :launcher
      # Get the move that cause the stat change
      # @return [Battle::Move, nil]
      attr_reader :move
      # Create a new Stat History
      # @param stat [Symbol] :atk, :dfe, :spd, :ats, :dfs, :acc, :eva
      # @param power [Integer] power of the stat change
      # @param target [PFM::PokemonBattler] target of the stat change
      # @param launcher [PFM::PokemonBattler, nil] launcher of the stat change
      # @param move [Battle::Move, nil] move that cause the stat change
      def initialize(stat, power, target, launcher, move)
      end
      # Tell if the move was used during last turn
      # @return [Boolean]
      def last_turn?
      end
      # Tell if the move was used during the current turn
      # @return [Boolean]
      def current_turn?
      end
      # Get the db_symbol of the move
      # @return [Symbol]
      def db_symbol
      end
    end
  end
end
