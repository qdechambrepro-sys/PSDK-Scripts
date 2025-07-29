module Configs
  # Definition of the scene title config
  class SceneTitleConfig
    # Get the intro movie map id
    # @return [Integer] 0 = No intro movie
    attr_accessor :intro_movie_map_id
    # Get the duration of the title music before it restarts
    # @return [Integer] duration in pcm samples
    attr_accessor :bgm_duration
    # Get the name of the bgm to play
    # @return [String]
    attr_accessor :bgm_name
    # Get the information if the language selection is enabled or not
    # @return [Boolean]
    attr_accessor :language_selection_enabled
    # Get the additional splash played after the PSDK splash
    # @return [Array<String>]
    attr_accessor :additional_splashes
    # Get the duration the controls has to wait before showing
    # @return [Float]
    attr_accessor :control_wait
  end
  module Project
    # Allow SceneTitleConfig from being accessed from Project::SceneTitle
    SceneTitle = SceneTitleConfig
  end
  register(:scene_title_config, 'scene_title_config', :json, true, SceneTitleConfig)
end
# Scene responsive of showing the title of the game
#
# It's being the first scene called when starting game without specific arguments.
# It's also the scene that gets called when the game soft resets.
#
# @note Due to how Scene_Title is designed, create_graphics will not be overloaded so the default viewport will be created
#       and other required graphics will be initialized / disposed when needed
class Scene_Title < GamePlay::BaseCleanUpdate
  # Create a new Scene_Title
  def initialize
  end
  # Update the input of the scene
  def update_inputs
  end
  # Update the graphics
  def update_graphics
  end
  # Update the mouse
  # @param moved [Boolean]
  def update_mouse(moved)
  end
  private
  # Load the RMXP Data
  def data_load
  end
  # Function that loads a data through a thread
  # @param filename [String] name of the file to load
  # @param clean [Boolean] if the utf-8 objects names should be cleaned
  # @yieldparam data [Object] the loaded data
  def thread_load(filename, clean: true)
  end
  # Function that autofixes the missing animated tiles files on RMXP projects
  def auto_fix_animated_tiles
  end
  # Function that tells if all data was loaded
  # @return [Boolean]
  def all_data_loaded?
  end
  public
  private
  def action_a
  end
  def action_up
  end
  def action_down
  end
  def action_play_game
  end
  def action_show_credits
  end
  public
  private
  # Show the intro movie map
  # @param map_id [Integer] ID of the map
  def start_intro_movie(map_id)
  end
  public
  private
  # Function that creates the PSDK splash
  def psdk_splash_initialize
  end
  # Function that initialize the next splash
  def next_splash_initialize
  end
  # Function that create a splash animation
  # @param se_filename [String] filename of the SE to play
  def create_splash_animation(se_filename = nil)
  end
  public
  private
  # Create the title animation
  def create_title_animation
  end
  # Function that create the title graphics
  def create_title_graphics
  end
  def create_title_background
  end
  def create_title_title
  end
  def create_title_controls
  end
  def checkup_language
  end
end
module UI
  # UI component showing the controls of the title screen (Play / Credits)
  class TitleControls < SpriteStack
    # Get the index of the selection
    # @return [Integer]
    attr_reader :index
    # Get the play bg button
    # @return [Sprite]
    attr_reader :play_bg
    # Get the credit bg button
    # @return [Sprite]
    attr_reader :credit_bg
    def initialize(viewport)
    end
    # Set the index of the selection
    # @param index [Integer]
    def index=(index)
    end
    # Update the animation
    def update
    end
    # Tell if the controls are done transitionning
    # @return [Boolean]
    def done?
    end
    private
    # Create all the necessary sprites for the title controls
    def create_sprites
    end
    # Function that creates the button shader
    def create_button_shader
    end
    def create_play_bg
    end
    def create_credits_bg
    end
    def create_play_text
    end
    def create_credit_text
    end
    # Create the animation
    def create_animation
    end
    # Create the loop animation
    def create_loop_animation
    end
  end
end
Graphics.on_start do
  Shader.register(:title_button, 'graphics/shaders/title_button.frag')
end
