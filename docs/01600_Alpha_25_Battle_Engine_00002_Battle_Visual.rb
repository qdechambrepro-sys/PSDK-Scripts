module Battle
  # Class that manage all the thing that are visually seen on the screen
  class Visual
    # @return [Hash] List of the parallel animation
    attr_reader :parallel_animations
    # @return [Array] List of the animation
    attr_reader :animations
    # @return [Viewport] the viewport used to show the sprites
    attr_reader :viewport
    # @return [Viewport] the viewport used to show some UI part
    attr_reader :viewport_sub
    # @return [Array] the element to dispose on #dispose
    attr_reader :to_dispose
    # Create a new visual instance
    # @param scene [Scene] scene that hold the logic object
    def initialize(scene)
    end
    # Safe to_s & inspect
    def to_s
    end
    alias inspect to_s
    # Update the visuals
    def update
    end
    # Dispose the visuals
    def dispose
    end
    # Tell if the visual are locking the battle update (for transition purpose)
    def locking?
    end
    # Unlock the battle scene
    def unlock
    end
    # Lock the battle scene
    def lock
    end
    # Display animation & stuff like that by updating the scene
    # @yield [] yield the given block without argument
    # @note this function raise if the visual are not locked
    def scene_update_proc
    end
    # Wait for all animation to end (non parallel one)
    def wait_for_animation
    end
    # Snap all viewports to bitmap
    # @return [Array<Texture>]
    def snap_to_bitmaps
    end
    private
    # Create all the graphics for the visuals
    def create_graphics
    end
    # Create the Visual viewport
    def create_viewport
    end
    # Create the default background
    def create_background
    end
    # Return the background name according to the current state of the player
    # @return [String]
    def background_name
    end
    # Create the battler sprites (Trainer + Pokemon)
    def create_battlers
    end
    # Update the battler sprites
    def update_battlers
    end
    # Update the info bars
    def update_info_bars
    end
    # Create an ability bar
    # @param bank [Integer]
    # @param position [Integer]
    def create_ability_bar(bank, position)
    end
    # Update the Ability bars
    def update_ability_bars
    end
    # Update the item bars
    def update_item_bars
    end
    # Create an item bar
    # @param bank [Integer]
    # @param position [Integer]
    def create_item_bar(bank, position)
    end
    # Create the info bar for a bank
    # @param bank [Integer]
    # @param position [Integer]
    def create_info_bar(bank, position)
    end
    # Create the Trainer Party Ball
    # @param bank [Integer]
    def create_team_info(bank)
    end
    # Update the team info
    def update_team_info
    end
    # Create the player choice
    def create_player_choice
    end
    # Create the skill choice
    def create_skill_choice
    end
    # Create the battle animation handler
    def create_battle_animation_handler
    end
    # Take a snapshot
    # @return [Texture]
    def take_snapshot
    end
    public
    # Method that show the pre_transition of the battle
    def show_pre_transition
    end
    # Method that show the trainer transition of the battle
    def show_transition
    end
    # Method that show the ennemy sprite transition during the battle end scene
    def show_transition_battle_end
    end
    # Function storing a battler sprite in the battler Hash
    # @param bank [Integer] bank where the battler should be
    # @param position [Integer, Symbol] Position of the battler
    # @param sprite [Sprite] battler sprite to set
    def store_battler_sprite(bank, position, sprite)
    end
    # Retrieve the sprite of a battler
    # @param bank [Integer] bank where the battler should be
    # @param position [Integer, Symbol] Position of the battler
    # @return [BattleUI::PokemonSprite, nil] the Sprite of the battler if it has been stored
    def battler_sprite(bank, position)
    end
    class << self
      # Register the transition resource type for a specific transition
      # @note If no resource type was registered, will send the default sprite one
      # @param id [Integer] id of the transition
      # @param resource_type [Symbol] the symbol of the resource_type (:sprite, :artwork_full, :artwork_small)
      def register_transition_resource(id, resource_type)
      end
      # Return the transition resource type for a given transition ID
      # @param id [Integer] ID of the transition
      # @return [Symbol]
      def transition_resource_type_for(id)
      end
    end
    private
    # Return the current battle transition
    # @return [Class]
    def battle_transition
    end
    # Show the debug transition
    def show_debug_transition
    end
    # List of Wild Transitions
    # @return [Hash{ Integer => Class<Transition::Base> }]
    WILD_TRANSITIONS = {}
    # List of Trainer Transitions
    # @return [Hash{ Integer => Class<Transition::Base> }]
    TRAINER_TRANSITIONS = {}
    # List of the resource type for each transition
    # @return [Hash{ Integer => Symbol }]
    TRANSITION_RESOURCE_TYPE = {}
    TRANSITION_RESOURCE_TYPE.default = :sprite
    public
    # Method that shows the trainer choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    # @return [Symbol, Array(Symbol, Hash), nil] :attack, :bag, :pokemon, :flee, :cancel, :try_next
    def show_player_choice(pokemon_index)
    end
    # Show the message "What will X do"
    # @param pokemon_index [Integer]
    def spc_show_message(pokemon_index)
    end
    private
    # Begining of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_begin(pokemon_index)
    end
    # Loop process of the player choice
    def show_player_choice_loop
    end
    # End of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_end(pokemon_index)
    end
    # Start the IdlePokemonAnimation (bouncing)
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def spc_start_bouncing_animation(pokemon_index)
    end
    # Stop the IdlePokemonAnimation (bouncing)
    # @param _pokemon_index [Integer] Index of the Pokemon in the party
    def spc_stop_bouncing_animation(_pokemon_index)
    end
    public
    # Method that show the skill choice and store it inside an instance variable
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    # @return [Boolean] if the player has choose a skill
    def show_skill_choice(pokemon_index)
    end
    # Method that show the target choice once the skill was choosen
    # @return [Array<PFM::PokemonBattler, Battle::Move, Integer(bank), Integer(position), Boolean(mega)>, nil]
    def show_target_choice
    end
    private
    # Begin of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_begin(pokemon_index)
    end
    # Loop of the skill_choice
    def show_skill_choice_loop
    end
    # End of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_end(pokemon_index)
    end
    # Show the Target Selection Window
    def show_target_choice_begin
    end
    # Loop of the target choice
    def show_target_choice_loop
    end
    # End of the target choice
    def show_target_choice_end
    end
    # Make the result of show_target_choice method
    # @param result [Array, :auto, :cancel]
    def stc_result(result = :auto)
    end
    # Tell if the Pokemon can be used or not
    # @return [Boolean] if the Pokemon cannot be used
    def spc_cannot_use_this_pokemon?(pokemon_index)
    end
    # Tell if we can choose a target
    # @return [Boolean]
    def stc_cannot_choose_target?
    end
    public
    # Variable giving the position of the battlers to show from bank 0 in bag UI
    BAG_PARTY_POSITIONS = 0..5
    # Method that show the item choice
    # @return [PFM::ItemDescriptor::Wrapper, nil]
    def show_item_choice
    end
    # Method that show the pokemon choice
    # @param forced [Boolean]
    # @return [PFM::PokemonBattler, nil]
    def show_pokemon_choice(forced = false)
    end
    private
    # Method that returns the party for the Bag & Party scene
    # @return [Array<PFM::PokemonBattler>]
    def retrieve_party
    end
    public
    # Hide all the bars
    # @param no_animation [Boolean] skip the going out animation
    # @param bank [Integer, nil] bank where the info bar should be hidden
    def hide_info_bars(no_animation = false, bank: nil)
    end
    # Show all the bars
    # @param bank [Integer, nil] bank where the info bar should be hidden
    def show_info_bars(bank: nil)
    end
    # Show a specific bar
    # @param pokemon [PFM::PokemonBattler] the pokemon that should be shown by the bar
    def show_info_bar(pokemon)
    end
    # Show a specific bar
    # @param pokemon [PFM::PokemonBattler] the pokemon that was shown by the bar
    def hide_info_bar(pokemon)
    end
    # Refresh a specific bar (when Pokemon loses HP or change state)
    # @param pokemon [PFM::PokemonBattler] the pokemon that was shown by the bar
    def refresh_info_bar(pokemon)
    end
    # Set the state info
    # @param state [Symbol] kind of state (:choice, :move, :move_animation)
    # @param pokemon [Array<PFM::PokemonBattler>] optional list of Pokemon to show (move)
    def set_info_state(state, pokemon = nil)
    end
    # Show team info
    def show_team_info
    end
    # Hide team info
    def hide_team_info
    end
    public
    ABILITY_SOUND_EFFECT = ['Audio/SE/In-Battle_Ability_Activate', 100, 100]
    ITEM_SOUND_EFFECT = ABILITY_SOUND_EFFECT
    # Show HP animations
    # @param targets [Array<PFM::PokemonBattler>]
    # @param hps [Array<Integer>]
    # @param effectiveness [Array<Integer, nil>]
    # @param messages [Proc] messages shown right before the post processing
    def show_hp_animations(targets, hps, effectiveness = [], &messages)
    end
    # Show KO animations
    # @param targets [Array<PFM::PokemonBattler>]
    def show_kos(targets)
    end
    # Show the ability animation
    # @param target [PFM::PokemonBattler]
    # @param [Boolean] no_go_out Set if the out animation should be not played automatically
    def show_ability(target, no_go_out = false)
    end
    # Hide the ability animation (no effect if no_go_out = false)
    # @param target [PFM::PokemonBattler]
    def hide_ability(target)
    end
    # Show the item user animation
    # @param target [PFM::PokemonBattler]
    def show_item(target)
    end
    # Show the pokemon switch form animation
    # @param target [PFM::PokemonBattler]
    def show_switch_form_animation(target)
    end
    # Make a move animation
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>]
    # @param move [Battle::Move]
    def show_move_animation(user, targets, move)
    end
    # Show a dedicated animation
    # @param target [PFM::PokemonBattler]
    # @param id [Integer]
    def show_rmxp_animation(target, id)
    end
    # Show the exp distribution
    # @param exp_data [Hash{ PFM::PokemonBattler => Integer }] info about experience each pokemon should receive
    def show_exp_distribution(exp_data)
    end
    # Show the catching animation
    # @param target_pokemon [PFM::PokemonBattler] pokemon being caught
    # @param ball [Studio::BallItem] ball used
    # @param nb_bounce [Integer] number of time the ball move
    # @param caught [Integer] if the pokemon got caught
    def show_catch_animation(target_pokemon, ball, nb_bounce, caught)
    end
    private
    # Create the throw ball animation
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_ball_animation(sprite, target, origin)
    end
    def fall_distortion
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param nb_bounce [Integer]
    def create_move_ball_animation(animation, sprite, nb_bounce)
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    def create_caught_animation(animation, sprite)
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    def create_break_animation(animation, sprite, target)
    end
    # Sprite zoom of the Pokemon battler
    def sprite_zoom
    end
    # SE played when a Pokemon is K.O.
    def play_ko_se
    end
    # SE played when the ball is sent
    def sending_ball_se
    end
    # SE played when the ball is opening
    def opening_ball_se
    end
    # SE played when the ball is bouncing
    def bouncing_ball_se
    end
    # SE played when the ball is moving
    def moving_ball_se
    end
    # SE played when the Pokemon is caught
    def catching_ball_se
    end
    # SE played when the Pokemon escapes from the ball
    def break_ball_se
    end
    public
    # Animation shown when a Creature is currently selected and wait for the player to choose its actions
    class IdlePokemonAnimation
      # Pixel offset for each index of the sprite
      OFFSET_SPRITE = [0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0]
      # Pixel offset for each index of the bar
      OFFSET_BAR = [0, -1, -2, -3, -4, -5, -5, -4, -3, -2, -1, 0]
      # Create a new IdlePokemonAnimation
      # @param visual [Battle::Visual]
      # @param pokemon [BattleUI::PokemonSprite]
      # @param bar [BattleUI::InfoBar]
      def initialize(visual, pokemon, bar)
      end
      # Function that updates the idle animation
      def update
      end
      # Function that rmoves the idle animation from the visual
      def remove
      end
      private
      # Function that create the animation
      # @return [Yuki::Animation::TimedLoopAnimation]
      def create_animation
      end
      # Function that moves the bar using the relative offset specified by 
      def move_bar(index)
      end
      # Function that moves the pokemon using the relative offset specified by 
      def move_pokemon(index)
      end
    end
    public
    # Animation of HP getting down/up
    class HPAnimation < Yuki::Animation::DiscreetAnimation
      # Create the HP Animation
      # @param scene [Battle::Scene] scene responsive of holding all the battle information
      # @param target [PFM::PokemonBattler] Pokemon getting its HP down/up
      # @param quantity [Integer] quantity of HP the Pokemon is getting
      # @param effectiveness [Integer, nil] optional param to play the effectiveness sound if that comes from using a move
      def initialize(scene, target, quantity, effectiveness = nil)
      end
      # Update the animation
      def update
      end
      # Detect if the animation if done
      # @return [Boolean]
      def done?
      end
      # Play the effectiveness sound
      def effectiveness_sound(effectiveness)
      end
      private
      # Function that refreshes the bar to the final value
      def final_hp_refresh
      end
      # Function that creates the sub animation
      def create_sub_animation
      end
    end
    public
    # Waiting animation if 0 HP are dealt
    class FakeHPAnimation < Yuki::Animation::TimedAnimation
      # Create the HP Animation
      # @param scene [Battle::Scene] scene responsive of holding all the battle information
      # @param target [PFM::PokemonBattler] Pokemon getting its HP down/up
      # @param effectiveness [Integer, nil] optional param to play the effectiveness sound if that comes from using a move
      def initialize(scene, target, effectiveness = nil)
      end
      # Update the animation
      def update
      end
      # Detect if the animation if done
      # @return [Boolean]
      def done?
      end
      # Play the effectiveness sound
      def effectiveness_sound(effectiveness)
      end
    end
    public
    # Module holding all the Battle transition
    module Transition
      # Base class of all transitions
      class Base
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        def initialize(scene, screenshot)
        end
        # Update the transition
        def update
        end
        # Tell if the transition is done
        # @return [Boolean]
        def done?
        end
        # Dispose the transition (safely clean all things that needs to be disposed)
        def dispose
        end
        # Start the pre transition (fade in)
        #
        # - Initialize **all** the sprites
        # - Create all the pre-transition animations
        # - Force Graphics transition if needed.
        def pre_transition
        end
        # Start the transition (fade out)
        #
        # - Create all the transition animation
        # - Add all the message to the animation
        # - Add the send enemy Pokemon animation
        # - Add the send actor Pokemon animation
        def transition
        end
        # Start the transition
        def transition_battle_end
        end
        # Function that starts the Enemy send animation
        def start_enemy_send_animation
        end
        # Function that starts the Actor send animation
        def start_actor_send_animation
        end
        private
        # Function that creates all the sprites
        #
        # Please, call super of this function if you want to get the screenshot sprite!
        def create_all_sprites
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Function that creates the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
        end
        # Function that creates the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
        end
        # Function that creates the background movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_background_animation
        end
        # Function that creates the paralax animation
        # @return [Yuki::Animation::TimedLoopAnimation]
        def create_paralax_animation
        end
        # Function that creates the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
        end
        # Function that get out all battler sprites
        # @return [Yuki::Animation::TimedAnimation]
        def go_out_battlers
        end
        # Function that creates the flash animation before transition animation on battle
        # @param time_to_process [Float] number of seconds (with generic time) to process the animation
        # @param factor [Float]
        # @return [Yuki::Animation::ScalarAnimation]
        def create_flash_animation(time_to_process, factor)
        end
        # Function that shows the message about Wild appearing / Trainer wanting to fight
        def show_appearing_message
        end
        # Return the "appearing/issuing" message
        # @return [String]
        def appearing_message
        end
        # Function that shows the message about enemy sending its Pokemon
        def show_enemy_send_message
        end
        # Return the "Enemy sends out" message
        # @return [String]
        def enemy_send_message
        end
        # Function that shows the message about player sending its Pokemon
        def show_player_send_message
        end
        # Return the third message shown
        # @return [String]
        def player_send_message
        end
        # Get the enemy Pokemon sprites
        # @return [Array<ShaderedSprite>]
        def enemy_pokemon_sprites
        end
        # Get the actor sprites (and hide the mons)
        # @return [Array<ShaderedSprite>]
        def actor_sprites
        end
        # Get the actor Pokemon sprites
        # @return [Array<ShaderedSprite>]
        def actor_pokemon_sprites
        end
        # Function that gets the enemy sprites (and hide the mons)
        # @return [Array<ShaderedSprite>]
        def enemy_sprites
        end
      end
      # Trainer transition of Red/Blue/Yellow games
      class RBYTrainer < Base
        # Constant giving the X displacement done by the sprites
        # @return [Integer]
        DISPLACEMENT_X = 360
        private
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates all the sprites
        def create_all_sprites
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
        end
        # Function that creates the actor sprites
        def create_actors_sprites
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
        end
        # Function that create the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
        end
      end
      # Wild transition of Red/Blue/Yellow games
      class RBYWild < Base
        # Constant giving the X displacement done by the sprites
        DISPLACEMENT_X = 360
        private
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
        end
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates all the sprites
        def create_all_sprites
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
        end
        # Function that creates the actor sprites
        def create_actors_sprites
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Function that creates the fade in animation
        def create_fadein_animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
        end
      end
      # Wild transition of Gold/Silver games
      class GoldWild < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild transition of Crystal game
      class CrystalWild < GoldWild
        private
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild transition of Ruby/Saphir/Emerald/LeafGreen/FireRed games
      class RSWildExt < RBYWild
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Start the animation of both screenshot_sprite
        def start_parallel_animation
        end
        # Function that move the left screenshot_sprite
        # @return [Yuki::Animation::Dim2Animation]
        def sprite_left
        end
        # Function that move the right screenshot_sprite
        # @return [Yuki::Animation::Dim2Animation]
        def sprite_right
        end
        # Set up the shader
        # @param line_offset [Integer] if line 0 or line 1 should be hidden
        # @return [Shader]
        def setup_shader(line_offset)
        end
        # The name of the shader
        # @return [Symbol]
        def shader_name
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def black_sprite_name
        end
      end
      # Wild transition of Diamant/Perle/Platine games
      class DPPWildExt < RSWildExt
        # The name of the shader
        # @return [Symbol]
        def shader_name
        end
      end
      class DPPTrainer < RBYTrainer
        private
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Function that creates the fade in animation
        def create_fadein_animation
        end
      end
      class Gen4Trainer < DPPTrainer
      end
      # Trainer transition of DPP Gym Leader
      class DPPGymLeader < RBYTrainer
        # Start x coordinate of the bar
        BAR_START_X = 320
        # Y coordinate of the bar
        BAR_Y = 64
        # VS image x coordinate
        VS_X = 64
        # VS image y offset
        VS_OFFSET_Y = 30
        # Mugshot final x coordinate
        MUGSHOT_FINAL_X = BAR_START_X - 100
        # Mugshot pre final x coordinate (animation purposes)
        MUGSHOT_PRE_FINAL_X = MUGSHOT_FINAL_X - 20
        # Text offset Y
        TEXT_OFFSET_Y = 36
        # Update the transition
        def update
        end
        private
        # Get the enemy trainer name
        # @return [String]
        def trainer_name
        end
        # Get the resource name according to the current state of the player and requested prefix
        # @return [String]
        def resource_name(prefix)
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the vs sprites
        def create_vs_sprites
        end
        # Function that creates the mugshot of the trainer
        def create_mugshot_sprite
        end
        def dispose_all_pre_transition_sprites
        end
        # Function that creates all the sprites
        def create_all_sprites
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # @param [Module<Yuki::Animation>] ya
        def create_parallel_loop(ya)
        end
        # @param [Module<Yuki::Animation>] ya
        def create_vs_woop_woop_animation(ya)
        end
        # @param [Module<Yuki::Animation>] ya
        def create_pre_transition_fade_out_animation(ya)
        end
        # @param [Module<Yuki::Animation>] ya
        def create_screenshot_shadow_animation(ya)
        end
        # @param [Module<Yuki::Animation>] ya
        def create_bar_loop_animation(ya)
        end
        def make_screenshot_shadow
        end
        def show_vs
        end
      end
      # Wild transition of HeartGold/SoulSilver games
      class HGSSWild < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild Cave transition of HeartGold/SoulSilver games
      class HGSSWildCave < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild Sea transition of HeartGold/SoulSilver games
      class HGSSWildSea < RBYWild
        # A hash mapping symbolic names to sprite paths
        # @type [Hash{Symbol => String}]
        SPRITE_NAMES = {first: '4g/hgss_wild_sea_1', second: '4g/hgss_wild_sea_2', third: 'black_screen'}
        # Function that returns an image name
        # @return [String]
        def pre_transition_sprite_name(sprite_name)
        end
        # Function that create a sprite
        # @param sprite_name [Symbol]
        # @param z_factor [Integer]
        # @param y_offset [Integer]
        # @return [Sprite]
        def create_sprite(sprite_name, z_factor, y_offset = 0)
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Start the animation of the shader
        # @return [Yuki::Animation::ScalarAnimation]
        def start_shader_animation
        end
        # Start the animation of the bubble sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_bubble_animation
        end
        # Start the animation of the wave sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_wave_animation
        end
        # Start the animation of the black sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_black_animation
        end
        # Set up the shader
        # @return [Shader]
        def setup_shader
        end
      end
      class HGSSTrainer < DPPTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild Sea transition of Black/White games
      class BWWildExt < RBYWild
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
        end
        # Set up the shader
        # @return [Shader]
        def setup_shader
        end
      end
      class XYTrainer < Base
        # Unitary deltaX of the background
        DX = -Math.cos(-3 * Math::PI / 180)
        # Unitary deltaY of the background
        DY = Math.sin(-3 * Math::PI / 180)
        private
        # Function that creates all the sprites
        def create_all_sprites
        end
        def create_background
        end
        def create_degrade
        end
        def create_halos
        end
        def create_battlers
        end
        def create_battler_battle_end
        end
        # Determine the right filenames for the transition sprites
        # @param filename [String]
        # @return [Array<String>]
        def determine_battler_filename(filename)
        end
        def create_shader
        end
        def create_pre_transition_animation
        end
        def create_background_animation
        end
        def create_paralax_animation
        end
        def create_sprite_move_animation
        end
        def create_enemy_send_animation
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
        end
        def hide_all_sprites
        end
        # Function that get out all battler sprites
        # @return [Yuki::Animation::TimedAnimation]
        def go_out_battlers
        end
      end
      class Gen6Trainer < XYTrainer
      end
    end
    WILD_TRANSITIONS.default = Transition::Base
    TRAINER_TRANSITIONS.default = Transition::Base
    public
    TRAINER_TRANSITIONS[2] = Transition::RBYTrainer
    TRAINER_TRANSITIONS[5] = Transition::RBYTrainer
    TRAINER_TRANSITIONS[6] = Transition::RBYTrainer
    TRAINER_TRANSITIONS[7] = Transition::RBYTrainer
    TRAINER_TRANSITIONS[8] = Transition::RBYTrainer
    Visual.register_transition_resource(2, :sprite)
    Visual.register_transition_resource(5, :sprite)
    Visual.register_transition_resource(6, :sprite)
    Visual.register_transition_resource(7, :sprite)
    Visual.register_transition_resource(8, :sprite)
    public
    WILD_TRANSITIONS[0] = Transition::RBYWild
    public
    WILD_TRANSITIONS[1] = Transition::GoldWild
    WILD_TRANSITIONS[2] = Transition::CrystalWild
    public
    WILD_TRANSITIONS[3] = Transition::RSWildExt
    public
    WILD_TRANSITIONS[4] = Transition::DPPWildExt
    public
    TRAINER_TRANSITIONS[1] = Transition::DPPTrainer
    Visual.register_transition_resource(1, :sprite)
    public
    TRAINER_TRANSITIONS[3] = Transition::DPPGymLeader
    Visual.register_transition_resource(3, :sprite)
    public
    WILD_TRANSITIONS[5] = Transition::HGSSWild
    public
    WILD_TRANSITIONS[6] = Transition::HGSSWildCave
    public
    WILD_TRANSITIONS[7] = Transition::HGSSWildSea
    public
    TRAINER_TRANSITIONS[4] = Transition::HGSSTrainer
    Visual.register_transition_resource(4, :sprite)
    public
    WILD_TRANSITIONS[8] = Transition::BWWildExt
    public
    TRAINER_TRANSITIONS[0] = Transition::XYTrainer
    Visual.register_transition_resource(0, :artwork_full)
  end
  # Module holding all the message function used by the battle engine
  module Message
    include PFM::Text
    @battle_info = nil
    @logic = nil
    module_function
    # Setup the message system
    # @param logic [Battle::Logic] the current battle logic
    def setup(logic)
    end
    # A Wild Pokemon appeared
    # @return [String]
    def wild_battle_appearance
    end
    # Trainer issuing a challenge
    # @return [String]
    def trainer_issuing_a_challenge
    end
    # Player sending out its Pokemon
    # @return [String]
    def player_sending_pokemon_start
    end
    # Trainer sending out their Pokemon
    # @return [String]
    def trainer_sending_pokemon_start
    end
    # Trainer issuing a challenge with 2 trainers
    # @return [String]
    def trainer_issuing_a_challenge_multi
    end
    # Trainer issuing a challenge with one trainer
    # @return [String]
    def trainer_issuing_a_challenge_single
    end
    # When there's a friend trainer and we launch the Pokemon
    # @return [String]
    def player_sending_pokemon_start_multi
    end
    # When were' alone and we launch the Pokemon
    # @return [String]
    def player_sending_pokemon_start_single
    end
    # When the trainer has a class and it sends out its Pokemon
    # @param name [String] name of the trainer
    # @param class_name [String] class of the trainer
    # @param index [String] index of the trainer in the name array
    # @return [String]
    def trainer_sending_pokemon_start_class(name, class_name, index)
    end
    # When the trainer has no class and it sends out its Pokemon
    # @param name [String] name of the trainer
    # @param index [String] index of the trainer in the name array
    # @return [String]
    def trainer_sending_pokemon_start_no_class(name, index)
    end
  end
end
Graphics.on_start do
  Shader.register(:rby_trainer, 'graphics/shaders/rbytrainer.frag')
end
Graphics.on_start do
  Shader.register(:rs_sprite_side, 'graphics/shaders/rs_wild_ext_side.frag')
end
Graphics.on_start do
  Shader.register(:dpp_sprite_side, 'graphics/shaders/dpp_wild_ext_side.frag')
end
Graphics.on_start do
  Shader.register(:sinusoidal, 'graphics/shaders/hgss_wild_sea.frag')
end
Graphics.on_start do
  Shader.register(:weird, 'graphics/shaders/yuki_transition_weird.txt')
end
