module GamePlay
  # Scene displaying the trainer card
  class TCard < BaseCleanUpdate::FrameBalanced
    # Coordinates of the player sprite
    PLAYER_COORDINATES = [222, 49]
    # Surface given to the player sprite
    PLAYER_SURFACE = [80, 73]
    # Coordinate of the first badge
    BADGE_ORIGIN_COORDINATE = [14, 30]
    # Offset between badges (x/y)
    BADGE_OFFSET = [48, 49]
    # Size of a badge in the badge image
    BADGE_SIZE = [32, 32]
    # Nmber of badge we can show in this UI
    BADGE_COUNT = 8
    # Create a new TCard interface
    def initialize
    end
    # Function that returns the actual play time of the trainer
    # @return [String] playtime formated like this %02d:%02d
    def current_play_time
    end
    # Make the UI act according to the inputs each frame
    def update_inputs
    end
    # Called when mouse can be updated (put your mouse related code inside)
    # @param _moved [Boolean] boolean telling if the mouse moved
    def update_mouse(_moved)
    end
    # Update the background animation
    def update_graphics
    end
    private
    # Create the UI Graphics
    def create_graphics
    end
    # Create the main background sprite
    def create_base_ui
    end
    # Create the sub background sprite (the dark surfaces in the TCard)
    def create_sub_background
    end
    # Create the trainer sprite
    def create_trainer_sprite
    end
    # Create the badge sprites
    def create_badge_sprites
    end
    # Create the texts
    def create_texts
    end
    def create_start_time
    end
    def create_money
    end
    def create_name
    end
    def create_do
    end
    def create_badge
    end
    def create_play_time
    end
    # Get the button text for the generic UI
    # @return [Array<String>]
    def button_texts
    end
  end
end
GamePlay.player_info_class = GamePlay::TCard
module PFM
  # The actor trainer data informations
  #
  # Main object stored in $trainer and PFM.game_state.trainer
  # @author Nuri Yuri
  class Trainer
    # Time format
    TIME_FORMAT = '%02d:%02d'
    # Name of the trainer as a boy (Default to Palbolsky)
    # @return [String]
    attr_accessor :name_boy
    # Name of the trainer as a girl (Default to Yuri)
    # @return [String]
    attr_accessor :name_girl
    # If the player is playing the girl trainer
    # @return [Boolean]
    attr_accessor :playing_girl
    # The internal ID of the trainer as a boy
    # @return [Integer]
    attr_accessor :id_boy
    # The internal ID of the trainer as a girl. It's equal to id_boy ^ 0x28F4AB4C
    # @return [Integer]
    attr_accessor :id_girl
    # The time in second when the Trainer object has been created (computer time)
    # @return [Integer]
    attr_accessor :start_time
    # The time the player has played as this Trainer object
    # @return [Integer]
    attr_accessor :play_time
    # The badges this trainer object has collected
    # @return [Array<Boolean>]
    attr_accessor :badges
    # The ID of the current region in which the trainer is
    # @return [Integer]
    attr_accessor :region
    # The game version in which this object has been saved or created
    # @return [Integer]
    attr_accessor :game_version
    # The current version de PSDK (update management). It's saved like game_version
    # @return [Integer]
    attr_accessor :current_version
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create a new Trainer
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Return the name of the trainer
    # @return [String]
    def name
    end
    # Change the name of the trainer
    # @param value [String] the new value of the trainer name
    def name=(value)
    end
    # Return the id of the trainer
    # @return [Integer]
    def id
    end
    # Redefine some variable RMXP uses with the right values
    def redefine_var
    end
    # Load the time counter with the current time
    def load_time
    end
    # Return the time counter (current time - time counter)
    # @return [Integer]
    def time_counter
    end
    # Update the play time and reload the time counter
    # @return [Integer] the play time
    def update_play_time
    end
    # Return the number of badges the trainer got
    # @return [Integer]
    def badge_counter
    end
    # Set the got state of a badge
    # @param badge_num [1, 2, 3, 4, 5, 6, 7, 8] the badge
    # @param region [Integer] the region id (starting by 1)
    # @param value [Boolean] the got state of the badge
    def set_badge(badge_num, region = 1, value = true)
    end
    # Has the player got the badge ?
    # @param badge_num [1, 2, 3, 4, 5, 6, 7, 8] the badge
    # @param region [Integer] the region id (starting by 1)
    # @return [Boolean]
    def badge_obtained?(badge_num, region = 1)
    end
    alias has_badge? badge_obtained?
    # Set the gender of the trainer
    # @param playing_girl [Boolean] if the trainer will be a girl
    def define_gender(playing_girl)
    end
    alias set_gender define_gender
    # Return the play time text (without updating it)
    # @return [String]
    def play_time_text
    end
    private
    # Return the default male name
    # @return [String]
    def default_male_name
    end
    # Return the default female name
    # @return [String]
    def default_female_name
    end
  end
  class GameState
    # The informations about the player and the game
    # @return [PFM::Trainer]
    attr_accessor :trainer
    on_player_initialize(:trainer) {@trainer = PFM.player_info_class.new(self) }
    on_expand_global_variables(:trainer) do
      $trainer = @trainer
      @trainer.game_state = self
    end
  end
end
PFM.player_info_class = PFM::Trainer
