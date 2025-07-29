module PFM
  # Class describing the Hall_of_Fame logic
  class Hall_of_Fame
    # Array containing every victory of the player
    # @return [Array]
    attr_accessor :player_victory
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create a new hall of fame
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Register a win in the Pokemon League for the player
    # @param mode [Symbol] the symbol designing the type of victory : possible victory are :league and :title_defense
    def register_victory(mode = :league)
    end
  end
  class GameState
    # The list of the victory in the Pokemon League
    # @return [PFM::Hall_of_Fame]
    attr_accessor :hall_of_fame
    on_player_initialize(:hall_of_fame) {@hall_of_fame = PFM.hall_of_fame_class.new(self) }
    on_expand_global_variables(:hall_of_fame) do
      @hall_of_fame ||= PFM.hall_of_fame_class.new(self)
      @hall_of_fame.game_state = self
    end
  end
end
PFM.hall_of_fame_class = PFM::Hall_of_Fame
module UI
  # Module holding the Hall of fame UI elements
  module Hall_of_Fame
    # The class that define the type background displayed during phase 1
    class Type_Background < SpriteStack
      # The non-translucent backgrounds
      # @return [Array<Sprite>]
      attr_accessor :type_foregrounds
      # The translucent backgrounds
      # @return [Array<Sprite>]
      attr_accessor :type_backgrounds
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      private
      # The initial position of the foregrounds
      # @return [Array<Integer>] the coordinates
      def foreground_pos
      end
      # The initial position of the backgrounds
      # @return [Array<Integer>] the coordinates
      def background_move
      end
    end
    # Class that define the stack containing the Pokemon's battlers
    class Pokemon_Battler_Stack < SpriteStack
      # All the colors based on 1st type of the creature
      COLORS = [[0, 0, 0, 255], [188, 187, 187, 255], [224, 56, 24, 255], [8, 124, 248, 255], [248, 208, 64, 255], [32, 192, 80, 255], [125, 186, 228, 255], [190, 74, 39, 255], [178, 74, 155, 255], [183, 122, 36, 255], [78, 176, 228, 255], [212, 108, 170, 255], [176, 213, 115, 255], [173, 126, 94, 255], [136, 111, 186, 255], [75, 155, 217, 255], [172, 178, 188, 255], [184, 85, 140, 255], [221, 139, 180, 255]]
      # X Left
      X_LEFT = -48
      # X Right
      X_RIGHT = 78
      # X Right color
      X_COLOR_RIGHT = 88
      # The Array containing every back sprites of the player team
      # @return [Array<UI::PokemonBackSprite>]
      attr_accessor :battlebacks
      # The Array containing every front sprites of the player team
      # @return [Array<UI::PokemonFaceSprite>]
      attr_accessor :battlefronts
      # The Array containing every colored back sprites of the player team
      # @return [Array<Sprite::WithColor>]
      attr_accessor :withcolorbacks
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      private
      # The initial position of the back battlers
      # @return [Array<Integer>] the coordinates
      def back_initial_pos
      end
      # The initial position of the front battlers
      # @return [Array<Integer>] the coordinates
      def front_initial_pos
      end
      # The initial position of the colored shadows
      # @return [Array<Integer>] the coordinates
      def withcolor_initial_pos
      end
      # Set the correct origin for each Sprite::WithColor
      def set_origin_withcolorbacks
      end
    end
    # Class that define the Star Animation
    class Star_Animation < SpriteSheet
      # The counter for the animation
      # @return [Integer]
      attr_accessor :counter
      # Tell if the animation is finished or not
      # @return [Boolean]
      attr_accessor :finished
      # Initialize the SpriteSheet
      # @param viewport [Viewport]
      # @param frame_count [Integer] how many frames between each anim update
      # @param repeat [Boolean] if the animation has to repeat itself
      def initialize(viewport, frame_count = 2, repeat: false)
      end
      # Update the animation depending on the @frame_count
      def update
      end
    end
    # Class that define the Pokemon text box stack
    class Pokemon_Text_Box < SpriteStack
      # White color
      WHITE_COLOR = Color.new(255, 255, 255)
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      # @param pkm [PFM::Pokemon] the Pokemon's data
      def initialize(viewport, pkm)
      end
      # The base filename of the window
      # @return [String]
      def bmp_filename
      end
      # The base coordinates of the name text
      # @return [Array<Integer>] the coordinates
      def name_text_coordinates
      end
      # The base coordinates of the level text
      # @return [Array<Integer>] the coordinates
      def lvl_text_coordinates
      end
      # Get the width of the box
      # @return [Integer] the width of the box sprite
      def width
      end
      # Check how many types the game has
      # @return [Integer] the number of types
      def number_of_types
      end
      # The SpriteStack initial coordinates
      # @return [Array<Integer>] the coordinates
      def spritesheet_coordinates
      end
    end
    # Class that define the Congratulation text box stack
    class Congratulation_Text_Box < SpriteStack
      # White color
      WHITE_COLOR = Color.new(255, 255, 255)
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      # @param pkm [PFM::Pokemon] the Pokemon's data
      def initialize(viewport, pkm)
      end
      # The base filename of the window
      # @return [String]
      def bmp_filename
      end
      # The base coordinates of the text
      # @return [Array<Integer>] the coordinates
      def text_coordinates
      end
      # Check how many types the game has
      # @return [Integer] the number of types
      def number_of_types
      end
      # Get the width of the box
      # @return [Integer] the width of the box sprite
      def width
      end
      # The SpriteStack initial coordinates
      # @return [Array<Integer>] the coordinates
      def spritesheet_coordinates
      end
    end
    # Class that define the Pokemon Stars animation
    class Pokemon_Stars_Animation < SpriteStack
      # All the X coordinate for the stars around Creature
      X_ARRAY = [67, 16, 90, 40, 65, 30]
      # All the Y coordinate for the stars around Creature
      Y_ARRAY = [20, 32, 90, 54, 48, 90]
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # The SpriteStack initial coordinates
      # @return [Array<Integer>] the coordinates
      def spritestack_coordinates
      end
      # Update each star animation
      def update
      end
      # Reset the star animation to replay it when needed
      def reset
      end
    end
    # Class that define the Graveyard Animation stack
    class Graveyard_Animation_Stack < SpriteStack
      # The array containing every ShaderedSprite
      # @return [Array<ShaderedSprite>]
      attr_accessor :sprites
      # The array containing every Dead_Pokemon_Text SpriteStack
      # @return [Array<UI::Hall_of_Fame::Dead_Pokemon_Text>]
      attr_accessor :text_boxes
      # Sprite X Right
      SPRITE_X_RIGHT = 422
      # Sprite X Middle
      SPRITE_X_MIDDLE = 112
      # Sprite X Left
      SPRITE_X_LEFT = -198
      # Sprite Y
      SPRITE_Y = 100
      # Box X Right
      BOX_X_RIGHT = 320
      # Box X Middle
      BOX_X_MIDDLE = 10
      # Box X Left
      BOX_X_LEFT = -300
      # Box Y
      BOX_Y = 80
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      private
      # The sprites initial coordinates
      # @return [Array<Integer>] the coordinates
      def initial_pos_sprites
      end
      # The boxes initial coordinates
      # @return [Array<Integer>] the coordinates
      def initial_pos_boxes
      end
    end
    # Class that define the Dead Pokemon text
    class Dead_Pokemon_Text < SpriteStack
      # White Color
      WHITE_COLOR = Color.new(255, 255, 255)
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      # @param x [Integer]
      # @param y [Integer]
      def initialize(viewport, x, y)
      end
      # The base filename of the window
      # @return [String]
      def bmp_filename
      end
      # The base coordinates of the text
      # @return [Array<Integer>] the coordinates
      def text_coordinate
      end
      # Change the text according to the data sent
      # @param pkm [PFM::Pokemon] the dead Pokemon we want the name of
      def text=(pkm)
      end
    end
    # Class that define the turning Pokeball
    class Turning_Pokeball < Sprite
      # Initialize the Sprite
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # The base filename of the image
      # @return [String]
      def bitmap_filename
      end
      # The new origin of the Sprite
      # @return [Array<Integer>]
      def new_origin
      end
      # Update the angle of the ball
      def update_anim
      end
    end
    # Class that define the Party Battler stack
    class Party_Battler_Stack < SpriteStack
      # The Array containing the front battlers of the Pokemon
      # @return [Array<UI::PokemonFaceSprite>]
      attr_accessor :pokemon_arr
      # The trainer battler
      # @return [Sprite]
      attr_accessor :trainer_battler
      # X coordinates for the party elements
      X_PARTY = [99, 221, 69, 251, 38, 282]
      # Y coordinates for the party elements
      Y_PARTY = [180, 150, 120]
      # Y coordinate for the trainer
      Y_TRAINER = 102
      # Trainer sprite filename based on its gender
      PLAYER_SPRITE_NAME = {true => 'hall_of_fame/female', false => 'hall_of_fame/male'}
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # The Pokemon initial coordinates
      # @return [Array<Integer>] the coordinates
      def pkm_initial_coordinates(index)
      end
      # The trainer sprite initial coordinates
      # @return [Array<Integer>] the coordinates
      def trainer_initial_coordinates
      end
    end
    # Class that define the League Champion text box stack
    class League_Champion_Text_Box < SpriteStack
      attr_accessor :text
      # Final Y coordinate
      Y_FINAL = 10
      # White color
      WHITE_COLOR = Color.new(255, 255, 255, 255)
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # The SpriteStack initial coordinates
      # @return [Array<Integer>] the coordinates
      def initial_coordinates
      end
      # The base filename of the window
      # @return [String]
      def box_filename
      end
      # Get the constant's value
      # @return [Integer]
      def y_final
      end
      # The base coordinates of the text
      # @return [Array<Integer>] the coordinates
      def text_coordinates
      end
    end
    # Class that define the Trainer Infos text box stack
    class Trainer_Infos_Text_Box < SpriteStack
      # The name text
      # @return [Text]
      attr_accessor :name
      # The id_no text
      # @return [Text]
      attr_accessor :id_no
      # The play_time text
      # @return [Text]
      attr_accessor :play_time
      # Final Y coordinate
      Y_FINAL = 202
      # White color
      WHITE_COLOR = Color.new(255, 255, 255, 255)
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # The SpriteStack initial coordinates
      # @return [Array<Integer>] the coordinates
      def initial_coordinates
      end
      # The base filename of the window
      # @return [String]
      def box_filename
      end
      # Get the constant's value
      # @return [Integer]
      def y_final
      end
      # The base coordinates of the name text
      # @return [Array<Integer>] the coordinates
      def name_coordinates
      end
      # The base coordinates of the id_no text
      # @return [Array<Integer>] the coordinates
      def id_no_coordinates
      end
      # The base coordinates of the play_time text
      # @return [Array<Integer>] the coordinates
      def play_time_coordinates
      end
    end
    # Class that define the End Stars animation stack
    class End_Stars_Animation < SpriteStack
      # Initialize the SpriteStack
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update each star's animation
      def update
      end
    end
  end
end
module GamePlay
  class Hall_of_Fame < BaseCleanUpdate
    # The default BGM to play
    DEFAULT_BGM = 'audio/bgm/Hall-of-Fame'
    # Initialize the scene
    # @param filename_bgm [String] the bgm to play during the Hall of Fame
    # @param context_of_victory [Symbol] the symbol to put as the context of victory
    def initialize(filename_bgm = DEFAULT_BGM, context_of_victory = :league)
    end
    # Play the music, nothing else
    def play_music
    end
    # Get the cry's filename of the Pokemon at index equal to @anim_count
    # @return [String] the filename of the cry
    def pkm_cry_filename
    end
    include UI::Hall_of_Fame
    # Create the graphics for the UI
    def create_graphics
    end
    # Launch each phase of the animation then update the looping animations
    def update_graphics
    end
    # Create the background
    def create_background
    end
    # Create the type background that is displayed during phase 1
    def create_type_background
    end
    # Create the stack containing the Pokemon's battler that is displayed during phase 1
    def create_pokemon_battler_stack
    end
    # Create the stars animation that is displayed during phase 1
    def create_pokemon_stars_animation
    end
    # Update the stars animation (only during phase 1, updated by launch_animation)
    def update_pokemon_stars_animation
    end
    # Create the boxes containing the text about the Pokemon that are displayed during phase 1
    def create_pokemon_text_boxes
    end
    # Create the congratulations boxes that are displayed during phase 1
    def create_congratulation_text_boxes
    end
    # Create the stack that contains everything needed for phase 2 animation
    def create_graveyard_anim
    end
    # Create the turning ball that is displayed during phase 3
    def create_turning_ball
    end
    # Update the turning ball animation during phase 3 and after
    def update_turning_ball
    end
    # Create the stack containing every battlers displayed during phase 3
    def create_party_battler_stack
    end
    # Create the box containing the league champion text displayed during phase 3
    def create_league_champion_text_box
    end
    # Create the box containing the trainer texts displayed during phase 3
    def create_trainer_infos_text_box
    end
    # Create the final stars animation that is displayed after phase 3
    def create_end_stars
    end
    # Update the final stars animation after phase 3
    def update_end_stars_anim
    end
    # Launch the given animation
    # @param animation [Yuki::Animation] the animation to run
    def launch_animation(animation)
    end
    # Update some parallel animation if the context demand it
    def parallel_animating
    end
    private
    def animation_phase_1
    end
    def p1_resolver_anim_2
    end
    def p1_resolver_anim_3
    end
    def p1_resolver_anim_4
    end
    def p1_resolver_anim_5
    end
    def p1_resolver_anim_6
    end
    def p1_resolver_anim_7
    end
    def p1_anim_1
    end
    def p1_anim_2(resolver)
    end
    def p1_anim_3(resolver)
    end
    def p1_anim_4(resolver)
    end
    def p1_anim_5(resolver)
    end
    def p1_anim_6(resolver)
    end
    def p1_anim_7(resolver)
    end
    public
    private
    def animation_phase_2
    end
    def p2_resolver_anim_1
    end
    def p2_resolver_anim_2_repeat
    end
    def p2_resolver_anim_3
    end
    def p2_anim_1(resolver)
    end
    def p2_anim_2_repeat(resolver)
    end
    def p2_anim_3(resolver)
    end
    public
    private
    def animation_phase_3
    end
    def p3_resolver_anim_1
    end
    def p3_resolver_anim_2
    end
    def p3_resolver_anim_3
    end
    def p3_resolver_anim_4
    end
    def p3_anim_1(resolver)
    end
    def p3_anim_2(resolver)
    end
    def p3_anim_3(resolver)
    end
    def p3_anim_4(resolver)
    end
    public
    # Update the inputs only at the end of the animation
    def update_inputs
    end
  end
end
GamePlay.hall_of_fame_class = GamePlay::Hall_of_Fame
