module Configs
  # Configuration for the Credit Scene
  class CreditsConfig
    # Get the project title splash (in grahics/titles)
    # @return [String]
    attr_accessor :project_splash
    # Get the chief project title
    # @return [String]
    attr_accessor :chief_project_title
    # Get the chief project name
    # @return [String]
    attr_accessor :chief_project_name
    # Get the other leaders
    # @return [Array<Hash>]
    attr_accessor :leaders
    # Get the game credits
    # @return [String]
    attr_accessor :game_credits
    # Get the credits bgm
    # @return [String]
    attr_accessor :bgm
    # Get the line height of credits
    # @return [Integer]
    attr_accessor :line_height
    # Get the speed of the text scrolling
    # @return [Float]
    attr_accessor :speed
    # Get the spacing between a leader text and the center of the screen
    # @return [Integer]
    attr_accessor :leader_spacing
  end
  module Project
    # Allow the credit config from being accessed through project settings
    Credits = CreditsConfig
  end
  register(:credits_config, 'credits_config', :json, false, CreditsConfig)
end
module GamePlay
  # Scene responsive of showing credits
  class CreditScene < BaseCleanUpdate
    def initialize
    end
    # Update inputs
    def update_inputs
    end
    # Update mouse
    def update_mouse(*)
    end
    # Update graphics
    def update_graphics
    end
    # Process called when the scene ends
    def main_end
    end
    private
    def create_graphics
    end
    def create_splash
    end
    def create_director
    end
    def create_leaders
    end
    def create_scroller
    end
    def create_animation
    end
    # Create the splash animation
    # @return [Yuki::Animation::TimedAnimation]
    def create_splash_animation
    end
    # Create the director animation
    # @param stack [UI::SpriteStack]
    # @return [Yuki::Animation::TimedAnimation]
    def create_director_animation(stack = @director)
    end
    # Create the leaders animation
    # @return [Yuki::Animation::TimedAnimation]
    def create_leaders_animation
    end
    def title_color
    end
    def title_font_id
    end
    def name_color
    end
  end
end
