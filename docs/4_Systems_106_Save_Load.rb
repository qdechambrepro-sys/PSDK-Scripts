module Configs
  # Configuration of the saves
  class SaveConfig
    # Number of save the player can have
    # @return [Integer] 0 = infinite
    attr_accessor :maximum_save_count
    # Get the header of the save file (preventing other fangames to read the save if changed)
    # @return [String]
    attr_accessor :save_header
    # Get the save key (preventing other fangames to read the save if changed)
    # @return [Integer]
    attr_accessor :save_key
    # Get the base filename of the save
    # @return [String]
    attr_accessor :base_filename
    # Tell if the player is allowed to save over another save
    # @return [Boolean]
    attr_accessor :can_save_on_any_save
    # Tell if the player can have unlimited saves
    # @return [Boolean]
    def unlimited_saves?
    end
    # Tell if the player is restricted to 1 save
    # @return [Boolean]
    def single_save?
    end
  end
  module Project
    # Allow configuration of the saves from being accessed through the Project module
    Save = SaveConfig
  end
  register(:save_config, 'save_config', :json, true, SaveConfig)
end
module UI
  # UI element showing the save information
  class SaveSign < SpriteStack
    # Get the index of the save
    # @return [Integer]
    attr_accessor :save_index
    # Get the visual index of the save sign
    # @return [Integer]
    attr_accessor :visual_index
    # String shown when a save is corrupted
    CORRUPTED_MESSAGE = 'Corrupted Save File'
    # String shown when a save is not corrupted and can be choosen
    SAVE_INDEX_MESSAGE = 'Save %d'
    # Create a new save sign
    # @param viewport [Viewport]
    # @param visual_index [Integer]
    def initialize(viewport, visual_index)
    end
    # Set the data of the SaveSign
    # @param value [PFM::GameState, Symbol] :new if new game, :corrupted if corrupted
    def data=(value)
    end
    # Update the animation
    def update
    end
    # Tell if the animation is done
    # @return [Boolean]
    def done?
    end
    # Start the animation of moving between index
    # @param target_visual_index [Integer]
    def move_to_visual_index(target_visual_index)
    end
    # Animate the cursor when moving
    def animate_cursor
    end
    # Get the coordinate of the element based on its coordinate
    # @param visual_index [Integer] visual index of the UI element
    # @return [Array<Integer>]
    def coordinates(visual_index)
    end
    private
    def show_new_game
    end
    def show_corrupted
    end
    # Show the save data
    # @param value [PFM::GameState]
    def show_data(value)
    end
    # Show the save data
    # @param value [PFM::GameState]
    def show_save_data(value)
    end
    def create_sprites
    end
    def create_background
    end
    def create_cursor
    end
    def create_player_sprite
    end
    def create_player_name
    end
    def create_save_text
    end
    def create_save_info_text
    end
    def create_pokemon_sprites
    end
    def player_name_color
    end
    def location_color
    end
    def info_color
    end
    def corrupted_message
    end
    def save_index_message
    end
    def base_x
    end
    def base_y
    end
    def spacing_x
    end
    def spacing_y
    end
  end
end
module GamePlay
  # Load game scene
  class Load < BaseCleanUpdate
    # Create a new GamePlay::Load scene
    def initialize
    end
    # Update the load scene graphics
    def update_graphics
    end
    # Tell if the Title should automatically create a new game instead
    # @return [Boolean]
    def should_make_new_game?
    end
    private
    def create_graphics
    end
    def create_base_ui
    end
    def button_texts
    end
    def create_shadow
    end
    def create_frame
    end
    def create_signs
    end
    def load_sign_data
    end
    public
    private
    # Function responsive of loading all the existing saves
    # @return [Array<PFM::GameState>]
    def load_all_saves
    end
    public
    # CTRL button actions
    ACTIONS = %i[action_a action_a action_a action_b]
    # Update the load scene inputs
    def update_inputs
    end
    # Update the load scene mouse interactions
    def update_mouse(*)
    end
    private
    def rotate_signs
    end
    def action_left
    end
    def action_right
    end
    def action_b
    end
    def action_a
    end
    public
    # Create a new game and start it
    def create_new_game
    end
    private
    # Load the current game
    def load_game
    end
    # Creaye a new Pokemon Party object and ask the language if possible
    def create_new_party
    end
  end
  # Scene responsive of displaying the language choice when creating a new game
  class Language_Choice < BaseCleanUpdate::FrameBalanced
    # If the change of index is animated
    ANIME_CHANGE = true
    # Number of frame for index change
    ANIME_FRAMES = 6
    # Initialize the scene
    def initialize
    end
    # Create the graphics
    def create_graphics
    end
    # Update the graphics
    def update_graphics
    end
    # Update the inputs
    def update_inputs
    end
    private
    # Update the index
    def update_index
    end
    # Move animation
    # TODO: Use real animation istead of code!
    # @param left [Boolean] if we're moving left
    def move(left)
    end
    # Animation when moving left
    def move_left_animation
    end
    # Animation when moving right
    def move_right_animation
    end
  end
  # Save game scene
  class Save < Load
    # MultiSave file format
    MULTI_SAVE_FORMAT = '%s-%d'
    # List of the usable root path for the save state
    SAVE_ROOT_PATHS = ['.', ENV['APPDATA'] || Dir.home, Dir.home]
    @save_index = 0
    # @return [Boolean] if the game was saved
    attr_reader :saved
    # Create a new GamePlay::Save
    def initialize
    end
    # Return the current GameState object
    # @return [GameState, nil]
    def current_game_state
    end
    # Save the game (method allowing hooks on the save)
    def save_game
    end
    private
    def create_frame
    end
    def button_texts
    end
    # Function creating the save directory
    def make_save_directory
    end
    undef create_new_game
    public
    private
    def action_left
    end
    def action_right
    end
    def action_b
    end
    def action_a
    end
    def play_save_se
    end
    public
    # @return [Hash] all the before save hooks
    BEFORE_SAVE_HOOKS = {game_map: proc {$game_map.begin_save }, encounters_history: proc {$wild_battle.begin_save }}
    # @return [Hash] all the after save hooks
    AFTER_SAVE_HOOKS = {game_map: proc {$game_map.end_save }, encounters_history: proc {$wild_battle.end_save }}
    class << self
      # @return [Integer] index of the save file (to allow multi-save)
      attr_accessor :save_index
      # Save a game
      # @param filename [String, nil] name of the save file (nil = auto name the save file)
      # @param no_file [Boolean] tell if the save should not be saved to file and just be returned
      def save(filename = nil, no_file = false)
      end
      # Load a game
      # @param filename [String, nil] name of the save file (nil = auto name the save file)
      # @param no_load_parameter [Boolean] if the system should not call load_parameters
      # @return [PFM::GameState, nil] The save data (nil = no save data / data corruption)
      # @note Change PFM.game_state
      def load(filename = nil, no_load_parameter: false)
      end
      # Get the root path of the save for the game
      def save_root_path
      end
      # Get the filename of the current save
      def save_filename
      end
      private
      # Function that encrypt / decrypt the save
      # @param data [String]
      # @return [String]
      def encrypt(data)
      end
      # Function that clears the sate
      def clear_states
      end
      # Function that update the save info (current game version, current PSDK version etc...)
      def update_save_info
      end
      # Function that actually save the file
      # @param filename [String]
      # @param save_data [String] save_data
      def save_file(filename, save_data)
      end
    end
  end
end
