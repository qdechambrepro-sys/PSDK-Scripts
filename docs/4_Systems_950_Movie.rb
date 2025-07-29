module GamePlay
  # Scene responsive of playing a movie (video file)
  class Movie < BaseCleanUpdate
    # Constant telling if the BGM should automatically be stopped
    AUTO_STOP_BGM = true
    # Constant telling if the map scene should automatically be hidden
    AUTO_HIDE_MAP = true
    # Create a new Movie scene
    # @param filename [String] name of the file to play
    # @param aliased [Boolean] if the scene should use a viewport to ensure the video gets played in native resolution
    # @param skip_delay [Float] number of seconds the player has to wait before being able to skip the video
    def initialize(filename, aliased = false, skip_delay = Float::INFINITY)
    end
    # Update the inputs for the Movie scene
    def update_inputs
    end
    # Update the graphics for the move scene
    def update_graphics
    end
    private
    # Redefine main_end to show map again & clean up the space a bit
    def main_end
    end
    # Function that create an aliased viewport
    def create_viewport
    end
    # Create all the graphics for the UI
    def create_graphics
    end
    def auto_require_movie_player
    end
    def start_video
    end
  end
end