# Module that holds all the Battle related classes
module Battle
  # Base classe of all the battle scene
  class Scene < GamePlay::Base
    # Tell if speed up is allowed in battle
    SPEED_UP_ALLOWED = true
    # Input key used for speed up
    SPEED_UP_KEY = :HOME
    # Speed up factor
    SPEED_UP_FACTOR = 4
    include Hooks
    # @return [Battle::Visual]
    attr_reader :visual
    # @return [Battle::Logic]
    attr_reader :logic
    # @return [Battle::Logic::BattleInfo]
    attr_reader :battle_info
    # @return [UI::Message::Window]
    attr_reader :message_window
    # @return [Array]
    attr_reader :player_actions
    # @return [Array<AI::Base>]
    attr_reader :artificial_intelligences
    # Set the next update from outside (flee)
    # @return [Symbol]
    attr_accessor :next_update
    # Create a new Battle Scene
    # @param battle_info [Battle::Logic::BattleInfo] informations about the battle
    # @note This method create the banks, the AI, the pokemon battlers and the battle logic
    #       It should call the logic_init event
    def initialize(battle_info)
    end
    # Safe to_s & inspect
    def to_s
    end
    alias inspect to_s
    # Disable the Graphics.transition
    def main_begin()
    end
    # Update the scene
    def update
    end
    # Process the next update method
    def next_update_process
    end
    # Dispose the battle scene
    def dispose
    end
    # Take a snapshot of the scene
    # @note You have to dispose the bitmap you got from this function
    # @return [Texture]
    def snap_to_bitmap
    end
    private
    # Update the speed up
    def update_speed_up
    end
    # Create a new logic object
    # @return [Battle::Logic]
    def create_logic
    end
    # Create a new visual
    # @return [Battle::Visual]
    def create_visual
    end
    # Create all the AIs
    # @return [Array<Battle::AI::Base>]
    def create_ais
    end
    # Method that call @visual.show_pre_transition and change @next_update to :transition_animation
    def pre_transition
    end
    # Method that call @visual.show_transition and change @next_update to :player_action_choice
    # @note It should call the battle_begin event
    def transition_animation
    end
    # Method that call all the switch event for the Pokemon that entered the battle in the begining
    def show_enter_event
    end
    # Create the message proc ensuring the scene is still updated
    def create_message_proc
    end
    # Return the message class used by this scene
    # @return [Class]
    def message_class
    end
    public
    # Tell if the ia should force a switch in case of no foe alive
    # @return [Boolean]
    def force_ia_switch?
    end
    private
    # Method that ask for the player choice (it calls @visual.show_player_choice)
    def player_action_choice
    end
    # Method that asks for the skill the current Pokemon should use
    def skill_choice
    end
    # Method that asks the target of the choosen move
    def target_choice
    end
    # Check if the player can make another action choice
    # @note push empty hash where Pokemon cannot be controlled
    # @return [Boolean]
    def can_player_make_another_action_choice?
    end
    # Tell if the player is not allowed to take any actions
    # @return [Boolean]
    def no_player_action?
    end
    # Method that asks the item to use
    def item_choice
    end
    # Method that test if the item_wrapper has different logic and execute is
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    # @return [Boolean] if the battle should not continue normally
    def special_item_choice_action(item_wrapper)
    end
    # Begin the Pokemon giving procedure
    # @param battler [PFM::PokemonBattler] pokemon that was just caught
    # @param ball [Studio::BallItem]
    def give_pokemon_procedure(battler, ball)
    end
    # Pokemon related quests update
    # @param pkmn [PFM::Pokemon] pokemon that was just caught
    def update_pokemon_related_quests(pkmn)
    end
    # Pokemon related Pokedex update
    # @param pkmn [PFM::Pokemon] pokemon that was just caught
    def update_pokedex_related_infos(pkmn)
    end
    # Rename question and scene
    # @param pkmn [PFM::Pokemon] pokemon that was just caught
    def rename_sequence(pkmn)
    end
    # Method that asks the pokemon to switch with
    def switch_choice
    end
    # Clean the action that was removed from the stack (Make sure we don't lock things)
    def clean_action(action)
    end
    # Method that checks if the flee is possible
    def flee_attempt
    end
    def debug_terminate_trainer_battle
    end
    # Method that checks if nuzlocke mode prevents capture
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    # @return [Boolean] if nuzlocke mode prevents capture
    def catch_prevented(item_wrapper)
    end
    # Method to caught a Pokémon
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    def caught(item_wrapper)
    end
    # Method to know if BallFetch should activate or not
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    def should_activate_ball_fetch?(item_wrapper)
    end
    public
    private
    # Method that trigger all the AI
    # @note It should first trigger the trainer_dialog event and for each AI trigger the AI_force_action event
    def trigger_all_AI
    end
    public
    private
    # Method that add the actions of the player, sort them and let the main phase process
    def start_battle_phase
    end
    # Method that makes the battle logic perform an action
    # @note Should call the after_action_dialog event
    def update_battle_phase
    end
    # Method that perform everything that needs to be performed at battle end (phrases etc...) and gives back the master to Scene_Map
    def battle_end
    end
    # Method that tells to return to the last scene (Scene_Map)
    def return_to_last_scene
    end
    public
    class << self
      # Set the current battle scene
      # @return [Battle::Scene]
      attr_writer :current
      # Register an event for the battle
      # @param name [Symbol] name of the event
      # @param block [Proc] code of the event
      def register_event(name, &block)
      end
    end
    # Call the after_attack Battle Event
    # This event is called at the end of each attack
    # @param launcher [PFM::PokemonBattler]
    # @param move [Battle::Move]
    def on_after_attack(launcher, move)
    end
    # Call the pre_battle_begin Battle Event
    # This event is called right after the "Trainer wants to battle" text
    def on_pre_battle_begin
    end
    # Call the battle_phase_end Battle Event
    # This event is called at the very end of a turn (after the switching in of new mons)
    def on_battle_turn_end
    end
    private
    # Register an event for the battle
    # @param name [Symbol] name of the event
    # @param block [Proc] code of the event
    def register_event(name, &block)
    end
    # Call a named event to let the Maker put some personnal configuration of the battle
    # @param name [Symbol] name of the event
    # @param args [Array] arguments of the event if any
    def call_event(name, *args)
    end
    # Load the battle event
    # @note events are stored inside Data/Events/Battle/{id} name.rb (if not compiled)
    #   or inside Data/Events/Battle/{id}.yarb (if compiled) is a 5 digit number (zero padding at the begining)
    # @param id [Integer] id of the battle
    def load_events(id)
    end
    if PSDK_CONFIG.release?
      # Load the events from a YARB file
      # @param id [String] the id of the event (00051 for 51)
      def load_yarb_events(id)
      end
    else
      # Load the events from a ruby file
      # @param id [String] the id of the event (00051 for 51)
      def load_ruby_events(id)
      end
    end
    public
    # Message Window of the Battle
    class Message < UI::Message::Window
      # Number of 60th of second to wait while message does not wait for user input
      MAX_WAIT = 120
      # Default windowskin of the message
      WINDOW_SKIN = 'message_box'
      # If the message will wait user to validate the message forever
      # @return [Boolean]
      attr_accessor :blocking
      # If the message wait for the user to press a key before skiping
      # @return [Boolean]
      attr_accessor :wait_input
      # Create a new window
      def initialize(...)
      end
      # Process the wait user input phase
      def wait_user_input
      end
      # Skip the update of wait input
      # @return [Boolean] if the update of wait input should be skipped
      def update_wait_input_skip
      end
      # Autoskip the wait input
      # @return [Boolean]
      def update_wait_input_auto_skip
      end
      # Terminate the message display
      def terminate_message
      end
      # Function that create the skipper wait animation
      def create_skipper_wait_animation
      end
      # Retrieve the current window position
      # @note Always return :bottom if the battler interpreter is not running
      # @return [Symbol, Array]
      def current_position
      end
      # Battle Windowskin
      # @return [String]
      def current_windowskin
      end
      # Retrieve the current window_builder
      # @return [Array]
      def current_window_builder
      end
      # Translate the color according to the layout configuration
      # @param color [Integer] color to translate
      # @return [Integer] translated color
      def translate_color(color)
      end
      # Return the default horizontal margin
      # @return [Integer]
      def default_horizontal_margin
      end
      # Return the default vertical margin
      # @return [Integer]
      def default_vertical_margin
      end
    end
  end
  # Safari battles scene
  class Safari < Scene
    # The current Safari Pokémon shown in the battle scene
    # @return [PokemonBattler]
    attr_accessor :safari_pokemon
    # Stage modifying a Pokemon's catch rate
    # @return [Integer]
    attr_accessor :catch_rate_modifier
    # Stage modifying a Pokemon's flee chance
    # @return [Integer]
    attr_accessor :flee_rate_modifier
    # Initialisation for Safari battle scene
    def initialize(battle_info)
    end
    # Method that ask for the player choice (it calls @visual.show_player_choice)
    def player_action_choice
    end
    # Throw a bait at the Pokémon, increasing its catch rate modifier by 1. Also has a 90% chance of increasing its flee rate modifier by 1
    # In case the flee rate modifier is not increased, a special message is shown
    def throw_bait
    end
    # Throw mud at the Pokémon, decreasing its flee rate modifier by 1. Also has a 90% chance of decreasing its catch rate modifier by 1
    # In case the catch rate modifier is not decreased, a special message is shown
    def throw_mud
    end
    # Try to send a Safari Ball to catch the Pokémon
    # If the player has no Safari Balls left, the battle ends
    def try_safari_catch
    end
    # Return the stage modifier (multiplier)
    # @param stage [Integer] the value of the stage
    # @return [Float] the multiplier
    def modifier_stage(stage)
    end
    # Method to catch a Pokémon
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    def caught(item_wrapper)
    end
    # Method that makes the player flee the battle, no verification needed in Safari battles
    def flee
    end
    # Engage the turn of the wild Pokemon, check if it flees or if the battle proceeds
    def pokemon_turn
    end
    # Get the message shown when throwing a bait
    def throw_bait_message
    end
    # Get the message shown when throwing mud
    def throw_mud_message
    end
    # Get the message shown when throwing a bait and the flee rate is not increased
    def ten_percent_bait_message
    end
    # Get the message shown when throwing mud and the catch rate is not decreased
    def ten_percent_mud_message
    end
    # Get the message shown when the Safari Pokemon flees
    def pokemon_flee_message
    end
    # Get the message shown when the Safari Pokemon does not flee and the battle continues
    def battle_continues_message
    end
  end
end
# Module that hold all the Battle UI elements
module BattleUI
  # Module that implements the Going In & Out animation for each sprites/stacks of the UI
  #
  # To work this module requires `animation_handler` to return a `Yuki::Animation::Handler` !
  module GoingInOut
    # @!method animation_handler
    #   Get the animation handler
    #   @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    # Tell the element to go into the scene
    def go_in
    end
    # Tell the element to go out of the scene
    # @param forced_delta [Float] set the forced delta to force the animation to be performed with a specific delta
    def go_out(forced_delta = nil)
    end
    # Tell if the UI element is in
    # @note By default a UI element is considered as in because it's initialized in its in position
    # @return [Boolean]
    def in?
    end
    # Tell if the UI element is out
    # @return [Boolean]
    def out?
    end
    private
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    # Get the delta to use to accord with the previous going-in-out animation
    # @return [Float]
    def go_in_out_delta
    end
  end
  # Module that implements the Hide & Show animation for each sprites/stacks of the UI
  #
  # To work this module requires `animation_handler` to return a `Yuki::Animation::Handler` !
  #
  # You can specify a `hide_show_duration` function to overwrite the duration of this animation
  module HideShow
    # @!method animation_handler
    #   Get the animation handler
    #   @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    # Tell the element to show in the scene
    def show
    end
    # Tell the element to hide from scene
    def hide
    end
    private
    # Creates the hide animation
    # @return [Yuki::Animation::TimedAnimation]
    def hide_animation
    end
    # Creates the show animation
    # @param target_opacity [Integer] the desired opacity (if you need non full opacity)
    # @return [Yuki::Animation::TimedAnimation]
    def show_animation(target_opacity = 255)
    end
    # Get the delta to use to accord with the previous hiding/showing animation
    # @return [Float]
    def hide_show_delta
    end
    # get the duration of the hide show animation
    # @return [Float]
    def hide_show_duration
    end
  end
  # Module helping to position any sprite that can get several positions depending on the battle mode
  #
  # All class including this module should define the following methods
  #   - `scene` that returns the current Battle Scene
  #   - `position` that returns the position of the current object in its bank (0, 1, 2, ...)
  #   - `bank` that returns the bank of the current object (0 = ally, 1 = enemies)
  #   - `base_position_v1` that returns the base position of the object in 1v1 battles
  #   - `base_position_v2` that returns the base position of the object in 2v2+ battles
  #   - `offset_position_v2` that returns the offset of the object depending on its bank (this offset is multiplied to position)
  #
  # This module will define a `sprite_position` function that will compute the x & y position this element should get
  module MultiplePosition
    # Tell if the sprite is from the enemy side
    # @return [Boolean]
    def enemy?
    end
    private
    # Get the sprite position
    # @return [Array(Integer, Integer)]
    def sprite_position
    end
  end
  # Abstraction for the exp distribution so you can do right things
  module ExpDistributionAbstraction
    # Get the scene
    # @return [Battle::Scene]
    attr_reader :scene
    private
    # Get the list of Pokemon that can get exp (are from player party)
    # @return [Array<PFM::PokemonBattler>]
    def find_expable_pokemon
    end
    # Map Pokemon to originals with form
    # @param pokemon [Array<PFM::PokemonBattler>]
    # @return [Array<PFM::Pokemon>]
    # @note Do not call this function twice, it's caching for safety reasons
    def map_to_original_with_forms(pokemon)
    end
    # Restore the form to originals
    def restore_form_to_originals
    end
    # Align exp of all original mon to the battlers
    # @param battlers [Array<PFM::PokemonBattler>]
    def align_exp(battlers)
    end
    # Function that shows level up of a Pokemon
    # @param pokemon [PFM::PokemonBattler]
    # @yieldparam original [PFM::PokemonBattler] the original battler in case you need it
    # @yieldparam list [Array<Array>] stat list due to level up
    def show_level_up(pokemon)
    end
    # Show the level up message
    # @param receiver [PFM::PokemonBattler]
    # @param show_message [Boolean] tell if the level up message should be shown
    def level_up_message(receiver, show_message: false)
    end
  end
  # Abstraction helping to design player choice a way that complies to what Visual expect to handle
  module PlayerChoiceAbstraction
    # @!parse
    #   include GenericChoice
    # The result :attack, :bag, :pokemon, :flee, :cancel, :try_next, :action
    # @return [Symbol, nil]
    attr_reader :result
    # The possible action made by the player (other than choosing a sub action)
    # @return [Battle::Actions::Base]
    attr_reader :action
    # Get the index
    # @return [Integer]
    attr_reader :index
    # Reset the choice
    # @param can_switch [Boolean]
    def reset(can_switch)
    end
    # If the player made a choice
    # @return [Boolean]
    def validated?
    end
    # Force the action to use an item
    # @param item [Studio::Item]
    def use_item(item)
    end
    private
    # Check if a ball can be used
    # @param item [Studio::BallItem]
    # @return [Boolean]
    def ball_can_be_used?(item)
    end
    # Use an item that needs to pick a Pokemon
    # @param item_wrapper [PFM::ItemDescriptor::Wrapper]
    def use_item_on_creature_choice(item_wrapper)
    end
    # Set the choice as wanting to switch pokemon
    # @return [Boolean] if the operation was a success
    def choice_pokemon
    end
    # Set the choice as wanting to flee
    # @return [Boolean] if the operation was a success
    def choice_flee
    end
    # Set the choice as wanting to use a move
    # @return [Boolean] if the operation was a success
    def choice_attack
    end
    # Set the choice as wanting to use an item from bag
    # @return [Boolean] if the operation was a success
    def choice_bag
    end
    # Set the choice as wanting to cancel the choice
    # @return [Boolean] if the operation was a success
    def choice_cancel
    end
    # Show failure for specific choice like Pokemon & Flee
    # @param play_buzzer [Boolean] tell if the buzzer sound should be played
    # @param show_hide [Boolean] tell if the choice should be hidden during the failure show
    def show_switch_choice_failure(play_buzzer: true, show_hide: true)
    end
    public
    # Set the choice as wanting to throw a Safari Ball
    # @return [Boolean] if the operation was a success
    def choice_safari_ball
    end
    # Set the choice as wanting to throw a bait
    # @return [Boolean] if the operation was a success
    def choice_bait
    end
    # set the choice as wanting to throw mud
    # @return [Boolean] if the operation was a success
    def choice_mud
    end
  end
  # Abstraction helping to design skill choice a way that complies to what Visual expect to handle
  module SkillChoiceAbstraction
    # @!parse
    #   include GenericChoice
    # The selected move
    # @return [Battle::Move, :cancel]
    attr_reader :result
    # The pokemon the player choosed a move
    # @return [PFM::PokemonBattler]
    attr_reader :pokemon
    # Tell if the mega evolution is enabled
    # @return [Boolean]
    attr_accessor :mega_enabled
    # Get the index
    # @return [Integer]
    attr_reader :index
    # Reset the Skill choice
    # @param pokemon [PFM::PokemonBattler]
    def reset(pokemon)
    end
    # Ensure the info are reset properly with current Encore'd Pokemon
    # @param pokemon [PFM::PokemonBattler]
    # @param move [Battle::Move]
    def encore_reset(pokemon, move)
    end
    # If the player made a choice
    # @return [Boolean]
    def validated?
    end
    private
    # Give the max index of the choice
    # @return [Integer]
    def max_index
    end
    # Set the choice as wanting to cancel the choice
    # @return [Boolean] if the operation was a success
    def choice_cancel
    end
    # Set the choice of the move to use
    # @param index [Integer]
    # @return [Boolean]
    def choice_move(index = @index)
    end
    # Show the move choice failure
    # @param index [Integer]
    def show_move_choice_failure(index = @index)
    end
  end
  # Abstraction of the Target Selection to comply with what the Visual expect
  module TargetSelectionAbstraction
    # The position (bank, position) of the choosen target
    # @return [Array, :cancel]
    attr_accessor :result
    # If the player made a choice
    # @return [Boolean]
    def validated?
    end
    private
    # Function that initialize the required data to ensure every necessary instance variables are set
    # @param launcher [PFM::PokemonBattler]
    # @param move [Battle::Move]
    # @param logic [Battle::Logic]
    def initialize_data(launcher, move, logic)
    end
    # Choose the target
    # @return [Boolean] if the operation was a success
    def choose_target
    end
    # Tell that the player cancelled
    # @return [Boolean]
    def choice_cancel
    end
    # Generate the list of mons shown by the UI
    # @return [Array<PFM::PokemonBattler>]
    def generate_mon_list
    end
    # Find the best possible index as default index
    # @return [Integer]
    def find_best_index
    end
  end
  # Sprite of a Pokemon in the battle
  class PokemonSprite < ShaderedSprite
    include GoingInOut
    include MultiplePosition
    include Shader::CreatureShaderLoader
    # Constant giving the deat Delta Y (you need to adjust that so your screen animation are OK when Pokemon are KO)
    DELTA_DEATH_Y = 32
    # Sound effect corresponding to the status
    STATUS_SE = {poison: 'moves/poison', toxic: 'moves/poison', confusion: 'moves/confusion', sleep: 'moves/asleep', freeze: 'moves/freeze', paralysis: 'moves/paralysis', burn: 'moves/burn', attract: 'moves/attract'}
    # Tone according to the status
    STATUS_TONE = {neutral: [0, 0, 0, 0, 0], poison: [0.4, 0, 0.49, 0.6, 0], toxic: [0.4, 0, 0.49, 0.6, 0], freeze: [0.23, 0.56, 1, 0.6, 0.6], paralysis: [0.39, 0.47, 0, 0.6, 0], burn: [0.45, 0, 0, 0.8, 0], confusion: [0, 0, 0, 0, 0], sleep: [0, 0, 0, 0, 0], ko: [0, 0, 0, 0, 0], flinch: [0, 0, 0, 0, 0], attract: [0, 0, 0, 0, 0]}
    # Sound played by the shiny animation
    SHINY_SE = 'se_shiny'
    # Sound played when the stat rise up
    STAT_RISE_UP = 'moves/stat_rise_up'
    # Sound played when the stat fall down
    STAT_FALL_DOWN = 'moves/stat_fall_down'
    # Tell if the sprite is currently selected
    # @return [Boolean]
    attr_accessor :selected
    # Tell if the sprite is temporary showed while in the Substitute state
    # @return [Boolean]
    attr_accessor :temporary_substitute_overwrite
    # Get the Pokemon shown by the sprite
    # @return [PFM::PokemonBattler]
    attr_reader :pokemon
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the position of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :position
    # Get the bank of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :bank
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Get the animation linked to a status tone
    # @return [Yuki::TimedLoopAnimation]
    attr_accessor :animation_tone
    # Stop the animation linked to the status tone
    # @return [Boolean]
    attr_accessor :stop_status_tone
    # Stop the gif animation
    # @return [Boolean]
    attr_accessor :stop_gif_animation
    # Create a new PokemonSprite
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    # Update the sprite
    def update
    end
    # Tell if the sprite animations are done
    # @return [Boolean]
    def done?
    end
    # Set the Pokemon
    # @param pokemon [PFM::PokemonBattler]
    def pokemon=(pokemon)
    end
    # Play the cry of the Pokemon
    # @param dying [Boolean] if the Pokemon is dying
    def cry(dying = false)
    end
    # Set the origin of the sprite & the shadow
    # @param ox [Numeric]
    # @param oy [Numeric]
    # @return [self]
    def set_origin(ox, oy)
    end
    # Set the zoom of the sprite
    # @param zoom [Float]
    def zoom=(zoom)
    end
    # Set the zoom_x of the sprite
    # @param zoom [Float]
    def zoom_x=(zoom)
    end
    # Set the zoom_y of the sprite
    # @param zoom [Float]
    def zoom_y=(zoom)
    end
    # Set the position of the sprite
    # @param x [Numeric]
    # @param y [Numeric]
    # @return [self]
    def set_position(x, y)
    end
    # Set the y position of the sprite
    # @param y [Numeric]
    def y=(y)
    end
    # Set the x position of the sprite
    # @param x [Numeric]
    def x=(x)
    end
    # Set the opacity of the sprite
    # @param opacity [Integer]
    def opacity=(opacity)
    end
    # Set the bitmap of the sprite
    # @param bitmap [Texture]
    def bitmap=(bitmap)
    end
    # Set the visibility of the sprite
    # @param visible [Boolean]
    def visible=(visible)
    end
    # Creates the flee animation
    # @return [Yuki::Animation::TimedAnimation]
    def flee_animation
    end
    # Creates the switch to substitute animation
    def switch_to_substitute_animation
    end
    # Creates the switch from substitute animation
    def switch_from_substitute_animation
    end
    # Create a shiny animation
    def shiny_animation
    end
    # Create a status animation
    # @param status [Symbol]
    def status_animation(status)
    end
    # Create a tone status animation
    # @param status [Symbol, Integer] corresponding to the status of the sprite
    # @param switch [Boolean] tell if the method is called from a switch
    def set_tone_status(status, switch = false)
    end
    # Create a stat change animation
    def change_stat_animation(amount)
    end
    # remove tone animation
    def remove_tone_animation
    end
    # Set a tone on the PokemonSprite
    # @param red [Float]
    # @param green [Float]
    # @param blue [Float]
    # @param alpha [Float]
    def set_tone_to(red, green, blue, alpha)
    end
    # Reset the tone inflicted by the animation
    def reset_tone_status
    end
    # Tell if the Pokemon represented by this sprite is under the effect of Substitute
    # @return [Boolean]
    def under_substitute_effect?
    end
    # Directly switch the PokemonSprite appearance to the substitute appearance
    def switch_to_substitute_sprite
    end
    # Return the Substitute animations speed
    # @return [Float]
    def substitute_animations_speed
    end
    # Pokemon sprite zoom
    # @return [Integer]
    def sprite_zoom
    end
    # Move the camera to the battler sprite
    # @param use_position [Boolean] if the position should be used
    # @note can't send resolved parameter through Visual so PokemonSprite is used as an intermediary
    def center_camera(use_position = true)
    end
    private
    def create_shadow
    end
    # Reset the battler position
    def reset_position
    end
    # Return the basic z position of the battler
    def basic_z_position
    end
    # Get the base position of the Pokemon in 1v1
    # @return [Array(Integer, Integer)]
    def base_position_v1
    end
    # Get the base position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def base_position_v2
    end
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def offset_position_v2
    end
    # Load the battler of the Pokemon
    # @param forced [Boolean] if we force the loading of the battler (useful with Substitute cases)
    def load_battler(forced = false)
    end
    # Tell if the gif animation should be stopped
    # @return [Boolean]
    def should_stop_gif?
    end
    # Creates the go_in animation (Exiting the ball)
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_in animation of a Safari Battle
    # @return [Yuki::Animation::TimedAnimation]
    def safari_go_in_animation
    end
    # Creates the go_out animation (Entering the ball if not KO, shading out if KO)
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    # Creates the go_in animation of a "follower" pokemon
    # @return [Yuki::Animation::TimedAnimation]
    def follower_go_in_animation
    end
    # Creates the regular go in animation (not follower)
    # @return [Yuki::Animation::TimedAnimation]
    def regular_go_in_animation
    end
    # Creates the go_out animation of a "follower" pokemon
    # @return [Yuki::Animation::TimedAnimation]
    def follower_go_out_animation
    end
    # Creates the regular go out animation (not follower)
    # @return [Yuki::Animation::TimedAnimation]
    def regular_go_out_animation
    end
    # Create the go_out animation of a KO pokemon
    # @return [Yuki::Animation::TimedAnimation]
    def ko_go_out_animation
    end
    # Create the ball animation of the actor Pokemon
    # @param pokemon_going_out_of_ball_animation [Yuki::Animation::TimedAnimation]
    # @return [Yuki::Animation::TimedAnimation]
    def actor_ball_animation(pokemon_going_out_of_ball_animation)
    end
    # Create the ball animation of the enemy Pokemon
    # @param pokemon_going_out_of_ball_animation [Yuki::Animation::TimedAnimation]
    # @return [Yuki::Animation::TimedAnimation]
    def enemy_ball_animation(pokemon_going_out_of_ball_animation)
    end
    # Create the ball animation of the Pokemon going back in ball
    # @param pokemon_going_in_the_ball_animation [Yuki::Animation::TimedAnimation]
    # @return [Yuki::Animation::TimedAnimation]
    def go_back_ball_animation(pokemon_going_in_the_ball_animation)
    end
    # SE played when the ball is sent
    # @return [String]
    def sending_ball_se
    end
    # SE played when the ball is opening
    # @return [String]
    def opening_ball_se
    end
    # SE played when the Pokemon back to the ball
    # @return [String]
    def back_ball_se
    end
    # Filename for the shiny animation
    # @return [String]
    def shiny_filename
    end
    # Sound played when the stat change
    # @return [String]
    def stat_se(amount)
    end
    # Dimension of the shiny animation files
    # @return [Array(Integer, Integer)]
    def shiny_dimension
    end
  end
  # Object that show the Battle Bar of a Pokemon in Battle
  # @note Since .25 InfoBar completely ignore bank & position info about Pokemon to make thing easier regarding positionning
  class InfoBar < UI::SpriteStack
    include UI
    include GoingInOut
    include MultiplePosition
    # The information of the HP Bar
    HP_BAR_INFO = [92, 4, 0, 0, 6]
    # bw, bh, bx, by, nb_states
    # The information of the Exp Bar
    EXP_BAR_INFO = [88, 2, 0, 0, 1]
    # Get the Pokemon shown by the InfoBar
    # @return [PFM::PokemonBattler]
    attr_reader :pokemon
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the position of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :position
    # Get the bank of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :bank
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Create a new InfoBar
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param pokemon [PFM::Pokemon]
    # @param bank [Integer]
    # @param position [Integer]
    def initialize(viewport, scene, pokemon, bank, position)
    end
    # Update the InfoBar
    def update
    end
    # Tell if the InfoBar animations are done
    # @return [Boolean]
    def done?
    end
    # Sets the Pokemon shown by this bar
    # @param pokemon [PFM::Pokemon]
    def pokemon=(pokemon)
    end
    # Refresh the bar contents
    def refresh
    end
    # Set the Creature to show in the Info Bar
    def data=(pokemon)
    end
    private
    # Get the base position of the Pokemon in 1v1
    # @return [Array(Integer, Integer)]
    def base_position_v1
    end
    # Get the base position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def base_position_v2
    end
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def offset_position_v2
    end
    def create_sprites
    end
    def create_background
    end
    def create_hp
    end
    def create_exp
    end
    def hp_background_coordinates
    end
    def hp_bar_coordinates
    end
    def create_name
    end
    def create_catch_sprite
    end
    def create_gender_sprite
    end
    def create_level
    end
    def create_status
    end
    def create_star
    end
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    # Class showing the ball sprite if the Pokemon is enemy and caught
    class PokemonCaughtSprite < ShaderedSprite
      # Set the Pokemon Data
      # @param pokemon [PFM::Pokemon]
      def data=(pokemon)
      end
    end
    # Class showing the right background depending on the pokemon
    class Background < ShaderedSprite
      # Set the Pokemon Data
      # @param pokemon [PFM::Pokemon]
      def data=(pokemon)
      end
      # Name of the background based on the creature shown
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def background_filename(pokemon)
      end
    end
  end
  # Object that display the Battle Party Balls of a trainer in Battle
  #
  # Remaining Pokemon, Pokemon with status
  class TrainerPartyBalls < UI::SpriteStack
    include UI
    include GoingInOut
    include MultiplePosition
    # X coordinate of the first ball in the stack depending on the bank
    BALL_X = [3, 7]
    # Y coordinate of the first ball in the stack depending on the bank
    BALL_Y = [-3, -3]
    # Delta X between each balls
    BALL_DELTA = 14
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the position
    # @return [Integer]
    attr_reader :position
    # Get the bank of the party shown
    # @return [Integer]
    attr_reader :bank
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Create a new Trainer Party Balls
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param bank [Integer]
    def initialize(viewport, scene, bank)
    end
    # Update all the animation of this UI element
    def update
    end
    # Refresh the content of the bar
    def refresh
    end
    # Tell if the UI has done displaying its animation
    # @return [Boolean]
    def done?
    end
    private
    # Get the base position of the Pokemon in 1v1
    # @return [Array(Integer, Integer)]
    def base_position_v1
    end
    alias base_position_v2 base_position_v1
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def offset_position_v2
    end
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    def create_graphics
    end
    def create_background
    end
    def create_balls
    end
    # Class showing a ball in the TrainerPartyBalls UI
    class BallSprite < Sprite
      # Create a new ball
      # @param viewport [Viewport]
      # @param index [Integer]
      def initialize(viewport, index)
      end
      # Update the data
      # @param party [Array<PFM::PokemonBattler>]
      def data=(party)
      end
      # Get the filename of the image to show as ball sprite
      # @param pokemon [PFM::PokemonBattler]
      def image_filename(pokemon)
      end
    end
  end
  # Sprite of a Trainer in the battle
  class TrainerSprite < ShaderedSprite
    include GoingInOut
    include MultiplePosition
    # Number of pixels the sprite has to move in other to fade away from the scene
    FADE_AWAY_PIXEL_COUNT = 160
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the position of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :position
    # Get the bank of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :bank
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Define the number of frames inside a back trainer
    BACK_FRAME_COUNT = 2
    # Determines the number of frames for a backsprite automatically
    DYNAMIC_BACKSPRITES = true
    # Create a new TrainerSprite
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param battler [String] name of the battler in graphics/battlers
    # @param bank [Integer] Bank where the Trainer is
    # @param position [Integer] position of the battler in the Array
    # @param battle_info [Battle::Logic::BattleInfo]
    def initialize(viewport, scene, battler, bank, position, battle_info)
    end
    # Update the sprite
    def update
    end
    # Tell if the sprite animations are done
    # @return [Boolean]
    def done?
    end
    # Set the battler on its next frame
    # @note Frames are ordered on the vertical axis
    def show_next_frame
    end
    # Set the battler on its previous frame
    # @note Frames are ordered on the vertical axis
    def show_previous_frame
    end
    # Set the battler back on the first frame
    def reset_frame
    end
    # Animation of player scrolling in and out at start of battle
    def send_ball_animation
    end
    # Animation of player throwing a bait or mud at the Pokémon during Safari battles
    def throw_bait_mud_animation
    end
    # Create a shader for the TrainerSprite
    def create_shader
    end
    private
    # Reset the battler position
    def reset_position
    end
    # Return the basic z position of the battler
    def basic_z_position
    end
    # Get the base position of the Trainer in 1v1
    # @return [Array(Integer, Integer)]
    def base_position_v1
    end
    # Get the base position of the Trainer in 2v2+
    # @return [Array(Integer, Integer)]
    def base_position_v2
    end
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def offset_position_v2
    end
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
  end
  # Sprite of an Ability Bar in the battle
  class AbilityBar < UI::SpriteStack
    include UI
    include GoingInOut
    include MultiplePosition
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the position of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :position
    # Get the bank of the pokemon shown by the sprite
    # @return [Integer]
    attr_reader :bank
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Get if the animation out should be not played automatically
    # @return [Boolean]
    attr_reader :no_go_out
    # Create a new Ability Bar
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param bank [Integer]
    # @param position [Integer]
    def initialize(viewport, scene, bank, position)
    end
    # Update the animations
    def update
    end
    # Tell if the animations are done
    # @return [Boolean]
    def done?
    end
    # @!method animation_handler
    #   Get the animation handler
    #   @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    # Tell the ability to go into the scene
    # @param [Boolean] no_go_out Set if the animation out should be not played automatically
    def go_in_ability(no_go_out = false)
    end
    private
    # Get the base position of the Pokemon in 1v1
    # @return [Array(Integer, Integer)]
    def base_position_v1
    end
    alias base_position_v2 base_position_v1
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array(Integer, Integer)]
    def offset_position_v2
    end
    # Creates the go_in animation
    # @param [Boolean] no_go_out Set if the out animation should be not played automatically
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation(no_go_out)
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    def create_sprites
    end
    def create_background
    end
    def create_text
    end
    def text_coordinates
    end
    def create_icon
    end
    def icon_coordinates
    end
    # Class showing the right background depending on the pokemon
    class Background < ShaderedSprite
      # Set the Pokemon Data
      # @param pokemon [PFM::Pokemon]
      def data=(pokemon)
      end
      # Name of the background based on the creature shown
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def background_filename(pokemon)
      end
    end
  end
  # Sprite of a Trainer in the battle
  class ItemBar < AbilityBar
    private
    def create_text
    end
  end
  # Sprite showing a cursor (being animated)
  class Cursor < ShaderedSprite
    # Get the origin x
    attr_reader :origin_x
    # Get the origin y
    attr_reader :origin_y
    # Get the target x
    attr_reader :target_x
    # Get the target y
    attr_reader :target_y
    # Create a new cursor
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Register the positions so the cursor can animate itself
    def register_positions
    end
    # Update the sprite
    def update
    end
    # Set the visibility
    # @param visible [Boolean]
    def visible=(visible)
    end
    alias call send
    # Stops the animation
    def stop_animation
    end
    # Create and start the cursor animation
    # @return [Yuki::Animation::TimedLoopAnimation]
    def start_animation
    end
  end
  # Class that allow a choice do be made
  #
  # The object tells the player validated on #validated? and the result is stored inside #result
  #
  # The object should be updated through #update otherwise no validation is possible
  #
  # When result was taken, the scene should call #reset to undo the validated state
  #
  # The goal of this class is to provide the cursor handling. You have to define the buttons!
  # Here's the list of methods you should define
  #   - create_buttons
  #   - create_sub_choice (add the subchoice as a stack item! & store it in @sub_choice)
  #   - validate (set the result to the proper value)
  #   - update_key_index
  #
  # To allow flexibility (sub actions) this generic choice allow you to define a "sub generic" choice
  # that only needs to responds to #update, #reset and #done? in @sub_choice
  class GenericChoice < UI::SpriteStack
    include UI
    include HideShow
    include GoingInOut
    # Offset X of the cursor compared to the element it shows
    CURSOR_OFFSET_X = -10
    # Offset Y of the cursor compared to the element it shows
    CURSOR_OFFSET_Y = 6
    # Get the animation handler
    # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
    attr_reader :animation_handler
    # Get the scene
    # @return [Battle::Scene]
    attr_reader :scene
    # Create a new GenericChoice
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    # Update the Window cursor
    def update
    end
    # Tell if all animations are done
    # @return [Boolean]
    def done?
    end
    # Reset the choice
    def reset
    end
    private
    def create_sprites
    end
    def create_sub_choice
    end
    def create_cursor
    end
    # Get the buttons
    # @return [Array<Sprite>]
    def buttons
    end
    # Update the cursor position
    # @param silent [Boolean] if the update shouldn't make noise
    def update_cursor(silent = false)
    end
    # Set the button opacity
    def update_button_opacity
    end
    # Get the cursor offset x
    # @return [Integer]
    def cursor_offset_x
    end
    # Get the cursor offset y
    # @return [Integer]
    def cursor_offset_y
    end
    # Tell if the player is validating his choice
    def validating?
    end
    # Tell if the player is canceling his choice
    def canceling?
    end
    # Update the mouse index if the mouse moved
    def update_mouse_index
    end
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    # Make the button bounce
    def bounce_button
    end
  end
  # Class that allow the player to make the choice of the action he want to do
  #
  # The object tells the player validated on #validated? and the result is stored inside #result
  #
  # The object should be updated through #update otherwise no validation is possible
  #
  # When result was taken, the scene should call #reset to undo the validated state
  class PlayerChoice < GenericChoice
    include UI
    include PlayerChoiceAbstraction
    # Coordinate of each buttons
    BUTTON_COORDINATE = [[172, 172], [246, 182], [162, 201], [236, 211]]
    # Create a new PlayerChoice Window
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    private
    def create_buttons
    end
    def create_sub_choice
    end
    # Validate the player choice
    def validate
    end
    # Cancel the player choice
    def cancel
    end
    # Update the index if a key was pressed
    def update_key_index
    end
    # Creates the show animation
    # @param target_opacity [Integer] the desired opacity (if you need non full opacity)
    # @return [Yuki::Animation::TimedAnimation]
    def show_animation(target_opacity = 255)
    end
    # Button of the player choice
    class Button < SpriteSheet
      # Create a new Player Choice button
      # @param viewport [Viewport]
      # @param index [Integer]
      def initialize(viewport, index)
      end
      alias index sx
      alias index= sx=
      # Get the filename of the sprite
      # @return [String]
      def image_filename
      end
    end
    # Element showing a special button
    class SpecialButton < UI::SpriteStack
      # Create a new special button
      # @param viewport [Viewport]
      # @param type [Symbol] :last_item or :info
      def initialize(viewport, type)
      end
      # Update the special button content
      def refresh
      end
      private
      def create_sprites
      end
    end
    # UI showing the info about the last used item
    class ItemInfo < UI::SpriteStack
      include HideShow
      # Get the animation handler
      # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
      attr_reader :animation_handler
      # Create a new Item Info box
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the data shown by the UI
      # @param item [Studio::Item]
      def data=(item)
      end
      # Update the sprite
      def update
      end
      # Tell if the animation is done
      # @return [Boolean]
      def done?
      end
      private
      def create_sprites
      end
    end
    # UI element showing the sub_choice and interacting with the parent choice
    class SubChoice < UI::SpriteStack
      # Create the sub choice
      # @param viewport [Viewport]
      # @param scene [Battle::Scene]
      # @param choice [PlayerChoice]
      def initialize(viewport, scene, choice)
      end
      # Update the button
      def update
      end
      # Tell if the choice is done
      def done?
      end
      # Reset the sub choice
      def reset
      end
      private
      # Update the button when it's done letting the player choose
      def update_done
      end
      # Update the button when it's waiting for player actions
      def update_not_done
      end
      # Action triggered when pressing Y
      def action_y
      end
      # Action triggered when pressing X
      def action_x
      end
      # Action triggered when pressing A
      def action_a
      end
      # Action triggered when pressing B
      def action_b
      end
      def create_sprites
      end
      def create_special_buttons
      end
      def create_item_info
      end
    end
  end
  # Class that allows the player to make the choice of the action he wants to do during a Safari battle
  class PlayerChoiceSafari < PlayerChoice
    include UI
    include PlayerChoiceAbstraction
    # Create the 4 main action buttons
    def create_buttons
    end
    # Create the sub-choice buttons
    def create_sub_choice
    end
    # Validate the player choice
    def validate
    end
    # Buttons of the player choices, modified for Safari battles
    class ButtonSafari < PlayerChoice::Button
      # Get the filename of the sprite
      # @return [String]
      def image_filename
      end
    end
    # UI element showing the sub_choice and interacting with the parent choice, modified for Safari battles
    class SubChoiceSafari < PlayerChoice::SubChoice
      # Action triggered when pressing Y
      def action_y
      end
      # Action triggered when pressing X
      def action_x
      end
    end
  end
  # Class that allow to choose the skill of the Pokemon
  #
  #
  # The object tells the player validated on #validated? and the result is stored inside #result
  #
  # The object should be updated through #update otherwise no validation is possible
  #
  # When result was taken, the scene should call #reset to undo the validated state
  class SkillChoice < GenericChoice
    include SkillChoiceAbstraction
    # Coordinate of each buttons
    BUTTON_COORDINATE = [[198, 124], [198, 153], [198, 182], [198, 211]]
    # Create a new SkillChoice UI
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    private
    # Give the max index of the choice
    # @return [Integer]
    def max_index
    end
    def create_buttons
    end
    # Set the button opacity
    def update_button_opacity
    end
    # Get the cursor offset_x
    # @return [Integer]
    def cursor_offset_x
    end
    def create_sub_choice
    end
    # Validate the user choice
    def validate
    end
    # Cancel the player choice
    def cancel
    end
    # Update the index if a key was pressed
    def update_key_index
    end
    # Button of a move
    class MoveButton < UI::SpriteStack
      # Get the index
      # @return [Integer]
      attr_reader :index
      # Create a new Move button
      # @param viewport [Viewport]
      # @param index [Integer]
      def initialize(viewport, index)
      end
      # Set the data
      # @param pokemon [PFM::PokemonBattler]
      def data=(pokemon)
      end
      # Make sure sprite is visible only if the data is right
      # @param visible [Boolean]
      def visible=(visible)
      end
      private
      def create_sprites
      end
    end
    # Element showing the information of the current move
    class MoveInfo < UI::SpriteStack
      # Create a new MoveInfo
      # @param viewport [Viewport]
      # @param move_choice [SkillChoice]
      def initialize(viewport, move_choice)
      end
      # Set the move shown by the UI
      # @param pokemon [PFM::PokemonBattler]
      def data=(pokemon)
      end
      private
      def create_sprites
      end
    end
    # Element showing the full description about the currently selected move
    class MoveDescription < UI::SpriteStack
      include HideShow
      # Get the animation handler
      # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
      attr_reader :animation_handler
      # Create a new MoveDescription
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the sprite
      def update
      end
      # Tell if the animation is done
      # @return [Boolean]
      def done?
      end
      private
      def create_sprites
      end
    end
    # Element showing a special button
    class SpecialButton < UI::SpriteStack
      # Create a new special button
      # @param viewport [Viewport]
      # @param scene [Battle::Scene]
      # @param type [Symbol] :mega or :descr
      def initialize(viewport, scene, type)
      end
      # Set the data of the button
      # @param pokemon [PFM::PokemonBattler]
      def data=(pokemon)
      end
      # Update the special button content
      # @param mega [Boolean]
      def refresh(mega = false)
      end
      # Set the visibility of the button
      # @param visible [Boolean]
      def visible=(visible)
      end
      private
      def create_sprites
      end
    end
    # UI element showing the sub_choice and interacting with the parent choice
    class SubChoice < UI::SpriteStack
      # Create the sub choice
      # @param viewport [Viewport]
      # @param scene [Battle::Scene]
      # @param choice [SkillChoice]
      def initialize(viewport, scene, choice)
      end
      # Update the button
      def update
      end
      # Tell if the choice is done
      def done?
      end
      # Reset the sub choice
      def reset
      end
      private
      # Update the button when it's done letting the player choose
      def update_done
      end
      # Update the button when it's waiting for player actions
      def update_not_done
      end
      # Action triggered when pressing Y
      def action_y
      end
      # Action triggered when pressing X
      def action_x
      end
      # Action triggered when pressing B
      def action_b
      end
      def create_sprites
      end
      def create_special_buttons
      end
      def create_move_description
      end
    end
  end
  # UI element responsive of letting the Player choose which creature to aim
  class TargetSelection < UI::SpriteStack
    include TargetSelectionAbstraction
    # Tell if moves with no choice should not show that UI
    SKIP_NO_CHOICE_SKILL = true
    # Create a new TargetSelection
    # @param viewport [Viewport]
    # @param launcher [PFM::PokemonBattler]
    # @param move [Battle::Move]
    # @param logic [Battle::Logic]
    def initialize(viewport, launcher, move, logic)
    end
    # Update the Window cursor
    def update
    end
    private
    def update_key_index
    end
    def update_mouse_index
    end
    def create_sprites
    end
    # Validate the player choice
    def validate
    end
    # Cancel the player choice
    def cancel
    end
    # Update the cursor position
    # @param silent [Boolean] if the cursor se should not be played
    def update_cursor(silent = false)
    end
    # Create the cursor move animation
    def create_cursor_move_animation
    end
    # Finalize the cursor update
    def finalize_cursor_update(play_sound)
    end
    class << self
      # Tell if the UI can be shown or not
      # @param move [Battle::Move]
      # @param pokemon [PFM::PokemonBattler]
      # @param logic [Battle::Logic]
      # @return [Boolean]
      def cannot_show?(move, pokemon, logic)
      end
    end
    # Button shown by the UI to get what's selected
    class Button < UI::SpriteStack
      # Get the selected state of the button
      # @return [Boolean]
      attr_reader :selected
      # Get the cursor
      # @return [Cursor]
      attr_reader :cursor
      # Create a new button
      # @param viewport [Viewport]
      # @param index [Integer]
      # @param row_size [Integer]
      # @param pokemon [PFM::PokemonBattler]
      # @param launcher [PFM::PokemonBattler]
      # @param move [Battle::Move]
      # @param is_target [Boolean]
      def initialize(viewport, index, row_size, pokemon, launcher, move, is_target)
      end
      # Set the selected state about the button
      # @param selected [Boolean]
      def selected=(selected)
      end
      # Set the Pokemon shown
      # @param pokemon [PFM::PokemonBattler]
      def data=(pokemon)
      end
      private
      def create_sprites
      end
      # @param pokemon [PFM::PokemonBattler]
      # @return [String]
      def load_efficiency_text(pokemon)
      end
      def process_coordinates(index, row_size)
      end
      # Background of the target
      class Background < Sprite
        # Set the Pokemon shown
        # @param pokemon [PFM::PokemonBattler]
        def data=(pokemon)
        end
        private
        # Get the image that should be shown by the UI
        # @param pokemon [PFM::PokemonBattler]
        def image_name(pokemon)
        end
      end
    end
  end
  # UI element showing the exp distribution
  class ExpDistribution < UI::SpriteStack
    include UI
    include ExpDistributionAbstraction
    # Create a new exp distribution
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param exp_data [Hash{ PFM::PokemonBattler => Integer }] info about experience each pokemon should receive
    def initialize(viewport, scene, exp_data)
    end
    # Update the scene
    def update
    end
    # Test if the scene is done distributing experience
    # @return [Boolean]
    def done?
    end
    # Start the exp distribution animation
    def start_animation
    end
    private
    def update_statistics
    end
    def create_sprites
    end
    # Function that shows level up of a Pokemon
    # @param pokemon [PFM::PokemonBattler]
    def show_level_up(pokemon)
    end
    # Function that create an exp animation for a specific pokemon
    # @param pokemon [PFM::PokemonBattler]
    # @param exp [Integer] total exp he should receive
    # @return [Array(Yuki::Animation::TimedAnimation, PFM::PokemonBattler), nil]
    def create_exp_animation_for(pokemon, exp)
    end
    # UI element showing the basic information
    class PokemonInfo < UI::SpriteStack
      # The information of the Exp Bar
      EXP_BAR_INFO = [79, 2, 0, 0, 1]
      # Tell if the pokemon is leveling up or not
      # @return [Boolean]
      attr_reader :leveling_up
      # Coordinate where the UI element is supposed to show
      COORDINATES = [[17, 10], [162, 20], [17, 50], [162, 60], [17, 90], [162, 100]]
      # Create a new Pokemon Info
      # @param viewport [Viewport]
      # @param index [Integer]
      # @param pokemon [PFM::Pokemon]
      # @param exp_received [Integer]
      def initialize(viewport, index, pokemon, exp_received)
      end
      # Update the animation
      def update
      end
      # Set the data shown by the UI element
      # @param pokemon [PFM::Pokemon]
      def data=(pokemon)
      end
      # Set if the Pokemon is leveling up or not
      # @param leveling_up [Boolean]
      def leveling_up=(leveling_up)
      end
      private
      def create_sprites
      end
      def create_exp_bar
      end
      def create_animation
      end
    end
    # UI element showing the new statistics
    class Statistics < UI::SpriteStack
      include GoingInOut
      # Get the animation handler
      # @return [Yuki::Animation::Handler{ Symbol => Yuki::Animation::TimedAnimation}]
      attr_reader :animation_handler
      # Position of the sprite when it's in
      IN_POSITION = [0, 144]
      # Create a new Statistics UI
      # @param viewport [Viewport]
      # @param pokemon [PFM::Pokemon] Pokemon that is currently leveling up
      # @param list0 [Array<Integer>] old basis stats
      # @param list1 [Array<Integer>] new basis stats
      def initialize(viewport, pokemon, list0, list1)
      end
      # Tell if the animation is done
      # @return [Boolean]
      def done?
      end
      # Update the animation
      def update
      end
      private
      def create_sprites
      end
      # Create all the stats texts
      def create_stats_texts
      end
      # Creates the go_in animation
      # @return [Yuki::Animation::TimedAnimation]
      def go_in_animation
      end
      # Creates the go_out animation
      # @return [Yuki::Animation::TimedAnimation]
      def go_out_animation
      end
    end
  end
  class Battleback3D < ShaderedSprite
    MARGIN_X = 64
    MARGIN_Y = 68
    # Get the scene linked to this object
    # @return [Battle::Scene]
    attr_reader :scene
    # Create a new BattleBack3D
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    # Set the position of the sprite
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric] z position of the sprite (1 is most likely at scale, 2 is smaller and 0 is illegal)
    # @return [self]
    def set_position(x, y, z = 1)
    end
    # Set the z position of the sprite
    # @param z [Numeric]
    def z=(z)
    end
    # Return an Array containing the elements of the background
    def battleback_sprite3D
    end
    # Update the background Elements (especially the animated elements)
    def update_battleback
    end
    # Create all the graphic elements for the BattleBack
    def create_graphics
    end
    # Create all the animations for the graphics element in an array of Yuki::Animation::TimedAnimation
    def create_animations
    end
    private
    # Add an element to the background
    # @param path [String] folder where the element is located
    # @param name [String] name of the ressource
    # @param x [Numeric]
    # @param y [Numeric]
    # @param z [Numeric] z position of the sprite (1 is most likely at scale, 2 is smaller, 0 is illegal)
    # @param zoom [Numeric] zoom applied to Sprite to compensate for z
    # @return [BattleUI::Sprite3D]
    def add_battleback_element(path, name, x = -(Graphics.width / 2 + MARGIN_X), y = -(Graphics.height / 2 + MARGIN_Y), z = 1, zoom = 1)
    end
    # Function that returns the possible background names depending on the time
    # @param name [String]
    # @return [Array<String>, nil]
    def timed_background_names(sprite_name)
    end
    # Return the path for the resources, define it inside your Battleback Class
    def resource_path
    end
  end
  # Sprite of a Pokemon in the battle when BATTLE_CAMERA_3D is true
  # Sprite3D calculates Coordinates from the center of the Viewport
  class PokemonSprite3D < PokemonSprite
    # Standard duration of the animations
    ANIMATION_DURATION = 0.75
    # Create a new PokemonSprite
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param camera [Fake3D::Camera]
    # @param camera_positionner [Visual3D::CameraPositionner]
    def initialize(viewport, scene, camera, camera_positionner)
    end
    # Set the z position of the sprite
    # @param z [Numeric]
    def z=(z)
    end
    # Return the basic z position of the battler
    def shader_z_position
    end
    # Return the shadow characteristic of the PokemonSprite3D
    def shadow
    end
    # Reset the zoom of the sprite
    def reset_zoom
    end
    # Set the zoom of the sprite
    # @param zoom [Float]
    def zoom=(zoom)
    end
    # Set the zoom_x of the sprite
    # @param zoom [Float]
    def zoom_x=(zoom)
    end
    # Set the zoom_y of the sprite
    # @param zoom [Float]
    def zoom_y=(zoom)
    end
    # Creates the go_in animation (Exiting the ball)
    # @param start_battle [Boolean] animation for the start of the battle
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation(start_battle = false)
    end
    # Creates the go_in animation of a Safari Battle
    # @return [Yuki::Animation::TimedAnimation]
    def safari_go_in_animation
    end
    # Creates the go_out animation (Entering the ball if not KO, shading out if KO)
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
    # Display immediatly the Follower in the battle (only used in transition in 3D)
    def follower_go_in_animation
    end
    # Pokemon sprite zoom
    # @return [Integer]
    def sprite_zoom
    end
    private
    # create the shadow of the Pokemon with a shader
    def create_shadow
    end
    # Reset the battler position
    def reset_position
    end
    # Load the battler of the Pokemon
    # @param forced [Boolean] if we force the loading of the battler (useful with Substitute cases)
    def load_battler(forced = false)
    end
    # Set the position of the battler before being sent with a ball
    # @return [Yuki::Animation::TimedAnimation]
    def set_position_go_in(start_battle = false)
    end
    # Creates the regular go in animation (not follower)
    # @param start_battle [Boolean] animation for the start of the battle
    # @return [Yuki::Animation::TimedAnimation]
    def regular_go_in_animation(start_battle = false)
    end
    # Creates the regular go out animation (not follower)
    # @return [Yuki::Animation::TimedAnimation]
    def regular_go_out_animation
    end
    # Create the fall and the white animation after using a Pokeball
    # @return [Yuki::Animation::TimedAnimation]
    def poke_out_animation(start_battle = false)
    end
    # White animation when a Pokemon go back into its ball
    # @return [Yuki::Animation::TimedAnimation]
    def return_to_ball_animation
    end
    # Update the shader's alpha uniform
    # @param alpha [Float] the alpha value (0 to 1)
    def update_shader_alpha(alpha)
    end
    # Create the ball animation of the enemy Pokemon
    # @return [Yuki::Animation::TimedAnimation]
    def enemy_ball_animation
    end
    # Create the ball animation of the actor Pokemon
    # @param start_battle [Boolean] animation for the start of the battle
    # @param pokemon_going_out_of_ball_animation [Yuki::Animation::TimedAnimation]
    def actor_ball_animation(start_battle = false)
    end
    def burst_settings(start_battle = false)
    end
    def create_burst_animation(burst)
    end
    def create_retrieve_animation(burst)
    end
    # Get the base position of the Pokemon in 1v1
    # @return [Array<Integer, Integer>]
    def base_position_v1
    end
    # Get the base position of the Pokemon in 2v2+
    # @return [Array<Integer, Integer>]
    def base_position_v2
    end
    # Coordinates for the burst effect when the ball is opened
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    def burst_offset(start_battle = false)
    end
    def camera_y_before_check(start_battle = false)
    end
    # Intensity of the skake effect when the Pokemon hits the ground
    # @return [Integer]
    def camera_shake_effect
    end
    # Height fo the fall of a Pokémon Sprite
    # @return [Integer]
    def fall_height(start_battle = false)
    end
  end
  # Sprite of a Trainer in the battle when BATTLE_CAMERA_3D is set to true
  class TrainerSprite3D < TrainerSprite
    # Define the number of frames inside a back trainer
    BACK_FRAME_COUNT = 5
    def create_shader
    end
    # Set the z position of the sprite
    # @param z [Numeric]
    def z=(z)
    end
    # Return the basic z position of the trainer
    def shader_z_position
    end
    # Animation of player scrolling in and out at start of battle
    def send_ball_animation
    end
    # Set the position of the battle_sprite for the ending phase of the battle and make it visible
    # @param position [Integer] position in the bank
    def set_end_battle_position(position)
    end
    # Get the position at the end of the battle for enemy
    # @param position [Integer] position in the bank
    # @return [Array<Integer, Integer>]
    def base_position_end_battle(position)
    end
    private
    # Get the base position of the Trainer in 1v1
    # @return [Array<Integer, Integer>]
    def base_position_v1
    end
    # Get the base position of the Trainer in 2v2
    # @return [Array<Integer, Integer>]
    def base_position_v2
    end
    # Get the offset position of the Pokemon in 2v2+
    # @return [Array<Integer, Integer>]
    def offset_position_v2
    end
    # Creates the go_in animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_in_animation
    end
    # Creates the go_out animation
    # @return [Yuki::Animation::TimedAnimation]
    def go_out_animation
    end
  end
  # Here we only deal with the method for creating graphic elements associated with a Battleback when BATTLE_CAMERA_3D is activated. This is an example, so feel free to create your own.
  # Reminder : All the coordinates are calculated from the center of your Viewport which is :
  # x = Graphics.width and y = Graphics.height
  class BattleBackGrass < Battleback3D
    # Function that define the Battleback
    # To create your own Battleback you need to follow the same pattern
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    def initialize(viewport, scene)
    end
    # Create all the graphic elements for the BattleBack
    def create_graphics
    end
    # Create all the animations for the graphics element in an array of Yuki::Animation::TimedAnimation
    def create_animations
    end
    # create the animation for a cloud, this animation loops automatically, so it returns to start_x
    # @param element [BattleUI::Sprite3D] element from the backgound to be animated
    # @param start_x [Integer] x coordinates for the start of the animation
    # @param final_x [Integer] x coordinates for the target of the animation
    # @param duration [Float] duration of the animation in seconds (must be superior to 2.0)
    # @return [Yuki::Animation::TimedAnimation] animation for the cloud
    def create_animation_cloud(element, start_x, final_x, duration)
    end
    # Return the path for the resources
    def resource_path
    end
  end
end
