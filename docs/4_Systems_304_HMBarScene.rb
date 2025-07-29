module UI
  # Module holding all the HMBarScene UI elements
  module HMBarScene
    # HMBarAnimation UI element
    class HMBarAnimation < SpriteStack
      # Create a new HMBarAnimation UI
      # @param viewport [Viewport]
      # @param reason [Symbol] db_symbol of the HM move
      def initialize(viewport, reason)
      end
      # Tell if the animation is done
      def done?
      end
      # Update the HMBarAnimation UI
      def update
      end
      private
      # Function that creates all the sprites of the animation
      def create_sprites
      end
      # Function that creates the different backgrounds
      # The background is divided in 5 parts, to get the properly animation at the end
      # Resources are stored in graphics\transitions
      def create_hidden_move_background
      end
      # Function that creates the character sprite
      # Resources are stored in graphics\transitions
      def create_character_sprite
      end
      # Function that creates the bar strobes.
      def create_hidden_move_strobes
      end
      # Functions that creates the pokemon sprite
      # Sprite of the Pokemon
      def create_pkmn_sprite
      end
      # User index of the selected Pokemon
      # @return []
      def hm_user_index
      end
      # Function that create the pre-animation (battleback + character).
      def create_fading_in_anim
      end
      # Function that create the animation (strobes on screen + end of animation).
      def create_animation
      end
      # Method that creates the bar loop animation
      # @return Yuki::Animation::TimedLoopAnimation
      def create_bar_loop_animation
      end
      # Method that creates the opacity fading animation
      # @return Yuki::Animation::TimedAnimation
      def create_fading_out_anim
      end
      # Function that create the strobes loop animation, the cry animation and the end of the Pkmn sprite animation.
      def create_leave_animation
      end
    end
  end
end
module GamePlay
  class HMBarScene < BaseCleanUpdate
    # Initialize the HMBarScene UI
    # @param reason [Symbol, PFM::Pokemon] symbol for the HM used, PFM::Pokemon to specify the Pokemon to use in the anim
    # @param scene_to_update [Object, nil] either an instantiated object responding to #update, or nil if no scene to update
    def initialize(reason, scene_to_update = nil)
    end
    include UI::HMBarScene
    # Update the graphics of the scene
    def update_graphics
    end
    private
    # Update the given scene to update during this one
    # Will only update if the given Object respond to the update method
    def update_given_scene
    end
    # Create the graphics of the scene
    def create_graphics
    end
    # Create the HMBarAnimation component
    def create_hm_bar_animation
    end
  end
end
GamePlay.hm_bar_scene_class = GamePlay::HMBarScene
