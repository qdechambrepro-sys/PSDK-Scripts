# Module that allows a sprite to be quickly recenter (useful in a Battle::Visual3D scene)
module RecenterSprite
  # recenter a sprite according to the dimension of the window
  def recenter
  end
  def add_position(offset_x, offset_y)
  end
end
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
    # Not used in Visual (avoid crash when using MoveAnimation)
    attr_accessor :camera_positionner
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
    # Get the correct PlayerChoice class depending on the battle mode
    def player_choice_class
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
    # @return [Array, nil]
    def stc_result(result = :auto)
    end
    # Handle the cancel case logic
    # @param pokemon [PFM::PokemonBattler]
    # @return [Array, nil] Returns pokemon array if force_next_move, nil otherwise
    def handle_cancel_result(pokemon)
    end
    # Determine target information based on result type
    # @param result [Array, :auto]
    # @param pokemon [PFM::PokemonBattler]
    # @param skill [Battle::Move]
    # @return [Array, nil]
    def determine_target_info(result, pokemon, skill)
    end
    # Determine targets automatically based on skill configuration
    # @param skill [Battle::Move]
    # @param pokemon [PFM::PokemonBattler]
    # @return [Array] Array containing bank and position of target
    def determine_auto_targets(skill, pokemon)
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
    # @param cannot_switch_index [Integer, nil] Index of the trapped party member if a switch cannot happen
    # @return [PFM::PokemonBattler, nil]
    def show_pokemon_choice(forced = false, cannot_switch_index: nil)
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
    # Show an animation for stat change
    # @param target [PFM::PokemonBattler]
    # @param amount [Integer] value for the changement
    def show_stat_animation(target, amount)
    end
    # Show an animation for a status
    # @param target [PFM::PokemonBattler]
    # @param status [Symbol]
    def show_status_animation(target, status)
    end
    # remove the tone animation
    # @param target [PFM::PokemonBattler]
    def heal_status_remove_tone(target)
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
    # Show the pokemon mega evolution animation
    # @param target [PFM::PokemonBattler]
    def show_mega_animation(target)
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
    # Define the translation to the center of the Screen
    # @note This method is used only in Visual3D
    def start_center_animation
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
    # Show the bait or mud throw animation if Safari Battle
    # @param target_pokemon [PFM::PokemonBattler] pokemon being thrown something at
    # @param bait_mud [Symbol] :bait or :mud, depending on the player's choice
    def show_bait_mud_animation(target_pokemon, bait_mud)
    end
    private
    # Create the throw bait or mud animation
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_bait_mud_animation(sprite, target, origin)
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
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
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
        # Get the resource name according to the current state of the player and requested prefix
        # @param prefix [String] The prefix to use for the resource name
        # @return [String] The determined resource name
        def resource_name(prefix)
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
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
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
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
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
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
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
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
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
      class CrystalWild < RBYWild
        private
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Wild transition of Ruby/Saphir/Emerald/LeafGreen/FireRed games
      class RSWild < RBYWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @param line_offset [Integer] if line 0 or line 1 should be hidden
        # @return [Shader]
        def setup_shader(name, line_offset)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Wild Cave transition of Ruby/Saphir/Emerald/LeafGreen/FireRed games
      class RSCaveWild < RBYWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Trainer transition of Red/Blue/Yellow games
      class RSTrainer < RBYTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Wild transition of Diamant/Perle/Platine games
      class DPPWild < RSWild
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Wild Cave transition of Diamant/Perle/Platine games
      class DPPCaveWild < RSCaveWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
        end
      end
      # Wild Sea transition of Diamant/Perle/Platine games
      class DPPSeaWild < RSCaveWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Return the shader name
        # @return [Symbol]
        def second_shader_name
        end
      end
      # Trainer transition of Diamant/Perle/Platine games
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
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
      end
      class Gen4Trainer < DPPTrainer
      end
      # Gym Leader transition of Diamant/Perle/Platine
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
        # Function that creates all the sprites
        def create_all_sprites
        end
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Create VS sprite
        # @param bitmap [String] the bitmap filename
        # @param position [Array<Integer>] the x and y coordinates to set the sprite position
        # @return [LiteRGSS::Sprite] The created sprite
        def create_vs_sprite(bitmap, position, zoom)
        end
        # Create the full VS sprite
        def create_vs_full_sprite
        end
        # Create the VS zoom sprite
        def create_vs_zoom_sprite
        end
        # Function that creates the mugshot of the trainer
        def create_mugshot_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_pre_transition_animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_fade_in_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_vs_zoom_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_pre_transition_fade_out_animation
        end
        # Create the bar movement loop
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_bar_loop_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_screenshot_shadow_animation
        end
        def make_screenshot_shadow
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
      class HGSSCaveWild < RBYWild
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
      class HGSSSeaWild < RBYWild
        # A hash mapping symbolic names to sprite paths
        # @type [Hash{Symbol => String}]
        SPRITE_NAMES = {first: 'assets/heartgold_soulsilver_sea_wild_01', second: 'assets/heartgold_soulsilver_sea_wild_02', third: 'black_screen'}
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
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
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
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Trainer transition of Heartgold/Soulsilver games
      class HGSSTrainer < DPPTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Gym Leader transition of Heartgold/Soulsilver
      class HGSSGymLeader < DPPGymLeader
        # VS image y offset
        VS_OFFSET_Y = 35
        # Text offset Y
        TEXT_OFFSET_Y = 41
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the mugshot of the trainer
        def create_mugshot_sprite
        end
        # Create the full VS sprite
        def create_vs_full_sprite
        end
        # Create the VS zoom sprite
        def create_vs_zoom_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_fade_in_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_vs_zoom_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_zoom_oscillation_animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_bar_loop_animation
        end
      end
      # Wild Sea transition of Black/White games
      class BWWild < RBYWild
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Wild Sea transition of Black/White games
      class BWSeaWild < RBYWild
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
        end
      end
      # Trainer transition of Black/White games
      class BWTrainer < RBYTrainer
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
      end
      # Trainer transition of X/Y games
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
        # Function to calculate positions based on number of sprites
        # @param trainer_is_couple [Boolean]
        # @param vs_type [Array<Integer>]
        # @param width [Integer]
        # @return [Array<Integer>]
        def calculate_positions
        end
        # Function that get out all battler sprites
        # @return [Yuki::Animation::TimedAnimation]
        def go_out_battlers
        end
        def hide_all_sprites
        end
      end
      class Gen6Trainer < XYTrainer
      end
      # Trainer transition of Battle Frontier
      class BattleFrontierVertical < RSTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      class BattleFrontierHorizontal < RSTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
        end
      end
      # Red transition of Heartgold/Soulsilver games
      class Red < RBYTrainer
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
        # Function that creates the top sprite
        def create_top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
      end
      # Team Rocket transition of Heartgold/Soulsilver games
      class TeamRocket < RBYTrainer
        # Y coordinate of the bar
        BAR_Y = 115
        # Text offset Y
        TEXT_Y = BAR_Y + 83
        # Text offset X
        TEXT_X = 105
        # Get the enemy trainer name
        # @return [String]
        def trainer_name
        end
        # Return the pre_transtion sprite name
        # @return [Array<String>]
        def pre_transition_sprite_name
        end
        # Function that creates all the sprites
        def create_all_sprites
        end
        # Function that creates the top sprite (unused here)
        def create_top_sprite
        end
        # Creates and configures the strobe sprite
        def create_strobes_sprite
        end
        # Creates the screenshot sprites
        def create_screenshot_sprite
        end
        # Creates and configures the background sprites
        def create_background_sprite
        end
        # Creates and configures the mugshot sprite for the trainer
        def create_mugshot_sprite
        end
        # Creates and configures the text for the mugshot
        def create_mugshot_text
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Function that creates the strobes animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_strobes_animation
        end
        # Function that creates the screenshot animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_screenshot_animation
        end
        # Function that creates the top screenshot animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_top_screenshot_animation
        end
        # Function that creates the bottom screenshot animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_bottom_screenshot_animation
        end
        # Function that creates the background animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_second_background_animation
        end
        # Function that creates the mugshot animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_mugshot_animation
        end
        # Function that creates the pre transition fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_fade_out_animation
        end
      end
    end
    WILD_TRANSITIONS.default = Transition::Base
    TRAINER_TRANSITIONS.default = Transition::Base
    public
    TRAINER_TRANSITIONS[2] = Transition::RBYTrainer
    TRAINER_TRANSITIONS.default = Transition::RBYTrainer
    public
    WILD_TRANSITIONS[0] = Transition::RBYWild
    WILD_TRANSITIONS.default = Transition::RBYWild
    public
    WILD_TRANSITIONS[1] = Transition::GoldWild
    WILD_TRANSITIONS[2] = Transition::CrystalWild
    public
    WILD_TRANSITIONS[3] = Transition::RSWild
    public
    WILD_TRANSITIONS[10] = Transition::RSCaveWild
    public
    TRAINER_TRANSITIONS[5] = Transition::RSTrainer
    Visual.register_transition_resource(5, :sprite)
    public
    WILD_TRANSITIONS[4] = Transition::DPPWild
    public
    WILD_TRANSITIONS[9] = Transition::DPPCaveWild
    public
    WILD_TRANSITIONS[12] = Transition::DPPSeaWild
    public
    TRAINER_TRANSITIONS[1] = Transition::DPPTrainer
    Visual.register_transition_resource(1, :sprite)
    public
    TRAINER_TRANSITIONS[3] = Transition::DPPGymLeader
    Visual.register_transition_resource(3, :sprite)
    public
    WILD_TRANSITIONS[5] = Transition::HGSSWild
    public
    WILD_TRANSITIONS[6] = Transition::HGSSCaveWild
    public
    WILD_TRANSITIONS[7] = Transition::HGSSSeaWild
    public
    TRAINER_TRANSITIONS[4] = Transition::HGSSTrainer
    Visual.register_transition_resource(4, :sprite)
    public
    TRAINER_TRANSITIONS[10] = Transition::HGSSGymLeader
    Visual.register_transition_resource(11, :sprite)
    public
    WILD_TRANSITIONS[8] = Transition::BWWild
    public
    WILD_TRANSITIONS[11] = Transition::BWSeaWild
    public
    TRAINER_TRANSITIONS[9] = Transition::BWTrainer
    Visual.register_transition_resource(9, :sprite)
    public
    TRAINER_TRANSITIONS[0] = Transition::XYTrainer
    Visual.register_transition_resource(0, :artwork_full)
    public
    TRAINER_TRANSITIONS[6] = Transition::BattleFrontierVertical
    TRAINER_TRANSITIONS[7] = Transition::BattleFrontierHorizontal
    Visual.register_transition_resource(6, :sprite)
    Visual.register_transition_resource(7, :sprite)
    public
    TRAINER_TRANSITIONS[8] = Transition::Red
    Visual.register_transition_resource(8, :sprite)
    public
    TRAINER_TRANSITIONS[11] = Transition::TeamRocket
    register_transition_resource(11, :sprite)
  end
  # Tell if Visual3D should be used
  BATTLE_CAMERA_3D = Configs.settings.is_use_battle_camera_3d
  # Class that manage all the things that are visually seen on the screen used only when BATTLECAMERA is true
  class Visual3D < Visual
    # Return half of the width of the default resolution
    HALF_WIDTH = 160
    # Return half of the height of the default resolution
    HALF_HEIGHT = 120
    # Camera of the battle
    # @return [Fake3D::Camera]
    attr_accessor :camera
    # Camera Positionner of the camera
    # @return [Fake3D::Camera]
    attr_accessor :camera_positionner
    # @return Array of the sprite applied to the camera
    attr_accessor :sprites3D
    # Create a new visual instance
    # @param scene [Scene] scene that hold the logic object
    def initialize(scene)
    end
    # Create the Visual viewport
    def create_viewport
    end
    # Create the camera and the camera_positionner
    def create_cameras
    end
    # Update the visuals
    def update
    end
    private
    # Create the default background
    def create_background
    end
    # Create the battler sprites (Trainer + Pokemon)
    def create_battlers
    end
    # End of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_end(pokemon_index)
    end
    # Begining of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_begin(pokemon_index)
    end
    # End of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_end(pokemon_index)
    end
    public
    # Offsets for target coordinates based on type and conditions
    TARGET_COORDINATE_OFFSETS = {ball: {solo: [-50, -96], base_position_0: [-90, -77], base_position_1: [-28, -70]}, stars: {solo: [-51, -11], base_position_0: [-91, 8], base_position_1: [-29, 15]}, catch_burst: {solo: [-50, -93], base_position_0: [-90, -73], base_position_1: [-28, -66]}, burst_break: {solo: [-39, 14], base_position_0: [-79, 54], base_position_1: [-17, 41]}}
    # Coordinates for the camera dependinng of the target
    CAMERA_CAPTURE_POSITION = {solo: [65, -10, 2], base_position_0: [65, -10, 2], base_position_1: [65, -10, 2]}
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
    # @param burst_catch [UI::BallCatch]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_ball_animation(sprite, burst_catch, target, origin)
    end
    # Create the throwing animation annd the zoom of the camera
    # @param target [Sprite]
    # @param sprite [UI::ThrowingBallSprite3D | UI::ThrowingBaitMudSprite]
    # @param type [Symbol] type of projectile
    # @return [Yuki::Animation::TimedAnimation]
    def throwing_animation(target, sprite, type = :ball)
    end
    # Create the sound animation for the bouncing ball
    # @return [Yuki::Animation::TimedAnimation]
    def sound_bounce_animation
    end
    # Create the fall animation
    # @param target [Sprite]
    # @param sprite [UI::ThrowingBallSprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_fall_animation(target, sprite)
    end
    # Create the fall animation
    # @param target [Sprite]
    # @param burst [UI::BallCatch]
    # @param sprite [UI::ThrowingBallSprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_enter_animation(target, burst_catch, sprite)
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
    # @param target [Sprite]
    def create_caught_animation(animation, sprite, target)
    end
    # Create the break animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param burst [UI::BallBurst]
    # @param sprite [UI::ThrowingBallSprite3D]
    # @param target [Sprite]
    def create_break_animation(animation, burst, sprite, target)
    end
    # Create the exit animation for the Pokemon (when not catch)
    # @param burst [UI::BallBurst]
    # @param sprite [UI::ThrowingBallSprite3D]
    # @param target [Sprite]
    def target_out_animation(target, burst, sprite)
    end
    # Sprite zoom of the Pokemon battler
    # @return [Integer]
    def sprite_zoom
    end
    # Coordinates whee the ball start before being throwned
    # @return [Array<Integer, Integer>]
    def ball_origin_position
    end
    # Return the coordinates based on the target, type, and offsets
    # @param target [Sprite] the target sprite
    # @param type [Symbol] the type of coordinates
    # @return [Array<Integer>] the calculated coordinates [x, y]
    def animation_coordinates(target, type)
    end
    # Return the "zoom position" of the camera
    # @return [Array<Integer>]
    def determine_camera_position
    end
    # Return the correct key depending of the battle and target
    # @return [:Symbol]
    def type_of_position
    end
    public
    TARGET_COORDINATE_OFFSETS[:bait_mud] = {solo: [-40, 0], base_position_0: [-90, -77], base_position_1: [-28, -70]}
    # Show the bait or mud throw animation if Safari Battle
    # @param target_pokemon [PFM::PokemonBattler] pokemon being thrown something at
    # @param bait_mud [Symbol] :bait or :mud, depending on the player's choice
    def show_bait_mud_animation(target_pokemon, bait_mud)
    end
    private
    # Create the throw ball animation
    # @param sprite [UI::ThrowingBaitMudSprite]
    # @param target [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_bait_mud_animation(sprite, target)
    end
    public
    class CameraPositionner
      # Create a new CameraPositionner use for the camera movement
      # @param scene [Scene] scene that hold the logic object
      def initialize(camera)
      end
      # @param t [Float] value of x
      def x(t)
      end
      # @param t [Float] value of y
      def y(t)
      end
      # @param t [Float] value of z (0 is illegal)
      def z(t)
      end
      # @param t [Float] value of the translation, apply the same for x and y
      def translation(t)
      end
      # Apply a rotation to the camera using yaw
      # @param yaw [Float] angle around axis z (left-right)
      def rotate_z(yaw)
      end
      # Apply a rotation to the camera using pitch
      # @param pitch [Float] angle around axis y (up-down)
      def rotate_y(pitch)
      end
      # Apply a rotation to the camera using roll
      # @param roll [Float] angle around axis x (tilt)
      def rotate_x(roll)
      end
    end
    public
    # Default Margin_X : 64 (32px on each side), Margin_Y : 60 (30px on each side)
    # This constant handles the camera coordinates and all info related
    # It is composed by Array made like that :
    # [start_x, final_x, start_y, final_y, start_z, final_z, duration_of_the_movement, wait_after_the_movement]
    # -9 20 1 => is when the camera is centered on your creature (but it's not the real center of the screen, 0 0 1 is the real one) at default zoom (z = 1)
    CAMERA_TRANSLATION = [[0, -21, 0, 29, 1, 0.9, 2, 1], [-21, 15, 29, -19, 0.9, 1, 3, 1.25], [15, -44, -19, 6, 1, 1, 2.5, 1.5], [-44, 0, 6, 0, 1, 1, 1.4, 2]]
    # coordinates of the camera centered
    CAMERA_CENTER = [-9, 20, 1, 0.3]
    # Update the position of the camera
    def update_camera
    end
    # Define the camera animation across the Battle Scene
    def start_camera_animation
    end
    # Define the translation to the center of the Screen
    def start_center_animation
    end
    # Time without moving at the beginning of start_camera_animation
    def no_movement_duration
    end
    # delete all cameras
    def stop_camera
    end
    # Center the camera on one of the sprite
    # @param bank [Integer]
    # @param position [Integer]
    def center_target(bank, position)
    end
    # Coordinates to zoom for the camera in 1v1
    # @param bank [Integer]
    # @return Array[<Float,Float,Float>]
    def camera_zoom_1v1(bank)
    end
    # Coordinates to zoom for the camera in 2v2
    # @param bank [Integer]
    # @param position [Integer]
    # @return Array[<Float,Float,Float>]
    def camera_zoom_2v2(bank, position)
    end
    public
    # Module holding all the Battle 3D Transitions
    module Transition3D
      # Base class of all transitions
      class Base < Battle::Visual::Transition::Base
        ANIMATION_DURATION = 0.75
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
        end
      end
      class RBYTrainer < Battle::Visual::Transition::RBYTrainer
        ANIMATION_DURATION = 0.75
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
        end
        # Function that starts the Enemy send animation
        def start_enemy_send_animation
        end
      end
      class Trainer3D < RBYTrainer
        # Default duration for the animations
        ANIMATION_DURATION = 0.5
        # Dezoom for player send animation (last parameter is an angle for axe x)
        CAMERA_COORDINATES_PLAYER_SEND = [-35, 20, 0.90, 5]
        # Coordinates at the end of the transition for the camera
        CAMERA_END_COORDINATES = [0, 0, 1, 0]
        # Shader Color applying when the sprites appear
        SHADER_COLOR = [0, 0, 0, 1]
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
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
        # Play the Follower go Animation on the right sprites
        def send_followers
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
        end
        # Function that create the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
        end
        # Check if all the Pokémon on the field are sent
        def all_pokemon_on_field?
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation
        def create_player_send_animation
        end
        # Function that creates the animation of sending the ball(s) for each actor
        # @return [Yuki::Animation::TimedAnimation]
        def ball_throw_player
        end
        # Function that creates the animation of sending the ball(s) in 1v1
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_classic
        end
        # Function that creates the animation of sending the ball(s) in duo battle (no multi)
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_duo
        end
        # Function that creates the animation of sending the ball(s) in multi battle
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_multi
        end
        # Create the dezoom animation for the player sending animation
        # @return [Yuki::Animation::TimedAnimation]
        def dezoom_camera_animation
        end
        # Create the animation for resetting the camera to the center of the Battle Scene
        # @return [Yuki::Animation::TimedAnimation]
        def reset_camera_animation
        end
        # Animation for the first trainer sending a ball
        # @return [Yuki::Animation::TimedAnimation]
        def trainer_send_ball_animation(index)
        end
        # Animation for a Pokémon going into battle
        # @param index [Integer] index of the Pokémon in the bank (0 or 1)
        # @return [Yuki::Animation::TimedAnimation]
        def pokemon_send_ball_animation(index)
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
        def setup_camera_position
        end
        # Returns a cubic distortion for animations
        def cubic_distortion
        end
        # Waiting time before the pokemon out animation
        # @return [Float]
        def wait_time_pokemon_animation
        end
      end
      class WildTransition < Base
        # Default duration for the animations
        ANIMATION_DURATION = 0.5
        # Shader Color applying when the sprites appear
        SHADER_COLOR = [0, 0, 0, 1]
        # Coordinates at the end of the transition for the camera
        CAMERA_END_COORDINATES = [0, 0, 1, 0]
        # Dezoom for player send animation (last parameter is an angle for axe x)
        CAMERA_COORDINATES_PLAYER_SEND = [-35, 20, 0.90, 5]
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
        end
        private
        # Set the default position for the camera at the start
        def setup_camera_position
        end
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
        # Play the Follower go Animation on the right sprites
        def send_followers
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
        end
        # Check if all the Pokémon on the field are sent
        def all_pokemon_on_field?
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation
        def create_player_send_animation
        end
        # Function that creates the animation of sending the ball(s) for each actor
        # @return [Yuki::Animation::TimedAnimation]
        def ball_throw_player
        end
        # Function that creates the animation of sending the ball(s) in 1v1
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_classic
        end
        # Function that creates the animation of sending the ball(s) in duo battle (no multi)
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_duo
        end
        # Function that creates the animation of sending the ball(s) in multi battle
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_multi
        end
        # Create the dezoom animation for the player sending animation
        # @return [Yuki::Animation::TimedAnimation]
        def dezoom_camera_animation
        end
        # Create the animation for resetting the camera to the center of the Battle Scene
        # @return [Yuki::Animation::TimedAnimation]
        def reset_camera_animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
        end
        # Animation for the first trainer sending a ball
        # @return [Yuki::Animation::TimedAnimation]
        def trainer_send_ball_animation(index)
        end
        # Animation for a Pokémon going into battle
        # @param index [Integer] index of the Pokémon in the bank (0 or 1)
        # @return [Yuki::Animation::TimedAnimation]
        def pokemon_send_ball_animation(index)
        end
        # Apply shader color animation to sprites
        # @param animation [Yuki::Animation::TimedAnimation]
        # @param sprites [Array] list of sprites to animate
        def apply_shader_animation(animation, sprites)
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
        end
        # Waiting time before the pokemon out animation
        # @return [Float]
        def wait_time_pokemon_animation
        end
      end
    end
    # Method that show the pre_transition of the battle
    def show_pre_transition
    end
    # Return the current battle transition
    # @return [Class]
    def battle_transition
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
    # List of the resource type for each transition
    # @return [Hash{ Integer => Symbol }]
    TRANSITION_RESOURCE_TYPE3D = {}
    TRANSITION_RESOURCE_TYPE3D.default = :sprite
    # List of Wild Transitions
    # @return [Hash{ Integer => Class<Transition3D::Base> }]
    WILD_TRANSITIONS_3D = {}
    # List of Trainer Transitions
    # @return [Hash{ Integer => Class<Transition3D::Base> }]
    TRAINER_TRANSITIONS_3D = {}
    public
    TRAINER_TRANSITIONS_3D[0] = Transition3D::Trainer3D
    TRAINER_TRANSITIONS_3D.default = Transition3D::Trainer3D
    Visual3D.register_transition_resource(0, :sprite)
    public
    WILD_TRANSITIONS_3D[0] = Transition3D::WildTransition
    WILD_TRANSITIONS_3D.default = Transition3D::WildTransition
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
module UI
  class Sprite3D < ShaderedSprite
    prepend Fake3D::Sprite3D
  end
  class StatAnimation < SpriteSheet
    include RecenterSprite
    COLUMNS = 12
    ROWS = 10
    MAX_INDEX = COLUMNS * ROWS - 1
    # Create a new StatAnimation
    # @param viewport [Viewport]
    # @param amount [Integer]
    # @param z [Integer]
    # @param bank [Integer]
    def initialize(viewport, amount, z, bank)
    end
    # Function that change the sprite according to the progression of the animation
    # @param progression [Float]
    def animation_progression=(progression)
    end
    # return the zoom value for the bitmap
    # @return [Integer]
    def zoom_value
    end
    # Return the x offset for the Stat Animation
    # @param [Integer]
    def x_offset
    end
    # Return the y offset for the Stat Animation
    # @param [Integer]
    def y_offset
    end
    # Tell which type of battle it is
    # @return [Boolean]
    def battle_3d?
    end
    # Tell if the Animation is from the enemy side
    # @return [Boolean]
    def enemy?
    end
  end
  class StatusAnimation < SpriteSheet
    include RecenterSprite
    # Get the db_symbol of the status
    # @return [Symbol]
    attr_reader :status
    @registered_status = {}
    # Create a new StatusAnimation
    # @param viewport [Viewport]
    # @param status [Symbol] Symbol of the status
    def initialize(viewport, status, bank)
    end
    class << self
      # Register a new status
      # @param db_symbol [Symbol] db_symbol of the status
      # @param klass [Class<StatusAnimation>] class of the status animation
      def register(db_symbol, klass)
      end
      # Create a new Status animation
      # @param viewport [Viewport]
      # @param status [Symbol] db_symbol of the status
      # @param bank [Integer] bank of the Creature
      # @return [StatusAnimation]
      def new(viewport, status, bank)
      end
    end
    # Function that change the sprite according to the progression of the animation
    # @param progression [Float]
    def animation_progression=(progression)
    end
    # Return the x offset for the Status Animation
    # @param [Integer]
    def x_offset
    end
    # Return the y offset for the Status Animation
    # @param [Integer]
    def y_offset
    end
    # Return the duration of the Status Animation
    # @param [Integer]
    def status_duration
    end
    private
    # Tell which type of battle it is
    # @return [Boolean]
    def battle_3d?
    end
    # Tell if the sprite is from the enemy side
    # @return [Boolean]
    def enemy?
    end
    # return the zoom value for the bitmap
    # @return [Integer]
    def zoom_value
    end
    # Get the dimension of the Spritesheet
    # @return [Array<Integer, Integer>]
    def status_dimension
    end
    # Get the filename status
    # @return [String]
    def status_filename
    end
    public
    class PoisonAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
      # Return the duration of the Status Animation
      # @param [Integer]
      def status_duration
      end
    end
    register(:poison, PoisonAnimation)
    register(:toxic, PoisonAnimation)
    public
    class SleepAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
    end
    register(:sleep, SleepAnimation)
    public
    class FreezeAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
    end
    register(:freeze, FreezeAnimation)
    public
    class BurnAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
    end
    register(:burn, BurnAnimation)
    public
    class ParalyzeAnimation < StatusAnimation
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
    end
    register(:paralysis, ParalyzeAnimation)
    public
    class AttractAnimation < StatusAnimation
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
    end
    register(:attract, AttractAnimation)
    public
    class ConfusionAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
      end
      # Return the duration of the Status Animation
      # @param [Integer]
      def status_duration
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
      end
      # Get the filename status
      # @return [String]
      def status_filename
      end
      def zoom_value
      end
    end
    register(:confusion, ConfusionAnimation)
  end
  # Sprite responsive of showing the sprite of the Ball we throw to Pokemon or to release Pokemon
  class ThrowingBallSprite3D < SpriteSheet
    include RecenterSprite
    # Array mapping the move progression to the right cell
    MOVE_PROGRESSION_CELL = [11, 12, 13, 12, 11, 14, 15, 16, 15, 14, 0]
    # Create a new ThrowingBallSprite
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
    end
    # Reset the ball position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    def reset_position(bank, position, scene, start_battle = false)
    end
    # Set the ThrowingBall position for retrieve animation
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    def retrieve_position(bank, position, scene)
    end
    # Function that adjust the sy depending on the progression of the "throw" animation
    # @param progression [Float]
    def throw_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "throw" animation (enemy only)
    # @param progression [Float]
    def throw_progression_enemy=(progression)
    end
    # Function that adjust the sy depending on the progression of the "open" animation
    # @param progression [Float]
    def open_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "close" animation
    # @param progression [Float]
    def close_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "move" animation
    # @param progression [Float]
    def move_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "break" animation
    # @param progression [Float]
    def break_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "caught" animation
    # @param progression [Float]
    def caught_progression=(progression)
    end
    # Coordinate of the offset to match the apparition of the Pokemon
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    # @return [Array<Integer, Integer>]
    def actor_ball_offset(position, scene, start_battle = false)
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
    end
    # Get the base position of the ball in 1v1
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v1(bank)
    end
    # Get the base position of the ball in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v2(bank)
    end
    def offset_position_v2(bank, scene)
    end
    # Add of offset to the ball at the start of a battle
    # @return [Array<Integer, Integer>]
    def offset_start_battle
    end
    # set the position of the ball the Pokemon is withdrawed in 1v1
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_position_v1(bank)
    end
    # set the position of the ball the Pokemon is withdrawed in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_position_v2(bank)
    end
    # Offset between the two position in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_offset_v2(bank)
    end
    # Get the sprite position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def sprite_position(bank, position, scene)
    end
    # Get the sprite position fo the retrieve of a Pokemon
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def get_retrieve_position(bank, position, scene)
    end
  end
  class BallStars < SpriteSheet
    COLUMNS = 9
    ROWS = 7
    MAX_INDEX = COLUMNS * ROWS - 1
    # Filename of the Spritesheet used
    BALLSTARS_FILENAME = 'ball_stars'
    # Create a new BallStars
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def catch_progression=(progression)
    end
  end
  class BallBurst < SpriteSheet
    include RecenterSprite
    # Create a new BallBurst
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
    end
    # Reset the Ballburst position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    def reset_position(bank, position, scene, start_battle = false)
    end
    # Set the Ballburst position for retrieve animation
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    def retrieve_position(bank, position, scene)
    end
    # Function that adjust the sy depending on the progression of the "open" animation
    # @param progression [Float]
    def open_progression=(progression)
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
    end
    # Get the base position of the burst in 1v1
    # @param bank
    # @return [Array<Integer, Integer>]
    def base_position_v1(bank)
    end
    # Get the base position of the burst in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v2(bank)
    end
    # Return the offset used in 2v2 battle, based on the bank
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def offset_position_v2(bank)
    end
    # Add of offset to the burst at the start of a battle
    # @return [Array<Integer, Integer>]
    def offset_start_battle
    end
    # Get the sprite position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def sprite_position(bank, position, scene)
    end
  end
  class BallCatch < SpriteSheet
    include RecenterSprite
    COLUMNS = 10
    ROWS = 9
    MAX_INDEX = COLUMNS * ROWS - 1
    # Create a new BallCatch
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def catch_progression=(progression)
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
    end
  end
  class RetrieveBurst < SpriteSheet
    COLUMNS = 8
    ROWS = 7
    MAX_INDEX = COLUMNS * ROWS - 1
    # Filename of the Spritesheet used
    BURST_FILENAME = 'ball-retreat'
    # Create a new RetrieveBurst
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def retrieve_progression=(progression)
    end
  end
  # Handle the mega evolution animation in the battle scene
  class MegaEvolveAnimation < SpriteStack
    # Create a new MegaEvolve Spritestack
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param target [PFM::PokemonBattler]
    # @param target_sprite [BattleUI::PokemonSprite]
    def initialize(viewport, scene, target, target_sprite)
    end
    # Play the MegaEvolve animation
    def mega_evolution_animation
    end
    private
    # Create the ring animation
    def ring_animation
    end
    # Create the stars animation
    def stars_animation
    end
    # Create the icon mega animation
    def icon_mega_animation
    end
    # Create the main Spritesheet for the animation
    def create_sprite_mega
    end
    # Create the icon mega for the animation
    def create_icon_mega
    end
    # Create the coordinates of the all_cells in a sprite sheet.
    # @param sprite [Sprite]
    # @param exclude_column [Integer]
    # @return [Array<Array<Integer>>]
    def create_sprite_cells(sprite, exclude_column: 0)
    end
    # Create the sprite for the mega evolution animation
    # @param file [String] filename of the sprite
    def create_sprite(filename)
    end
    # Apply the 3D settings to the sprite if the 3D camera is enabled
    # @param sprite [Sprite, Spritesheet]
    def apply_3d_battle_settings(sprite)
    end
    def ring_filename
    end
    def star_filename
    end
    def me_filename
    end
    def me_icon_filename
    end
    def se_me
    end
    def ring_and_stars_origin
    end
    def me_sprite_origin
    end
    def me_icon_origin
    end
    def me_dimension
    end
  end
end
module BattleUI
  class Sprite3D < ShaderedSprite
    prepend Fake3D::Sprite3D
    def z=(z)
    end
  end
end
