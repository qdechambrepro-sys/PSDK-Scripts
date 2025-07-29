module Graphics
  class << self
    private
    def io_initialize
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics io_initialize') {io_initialize }
    # Create the Command thread
    def create_command_thread
    end
    # Eval a command from the console
    def update_cmd_eval
    end
    Hooks.register(Graphics, :post_update_internal, 'PSDK Graphics update_cmd_eval') {update_cmd_eval }
  end
  class << self
    # Function that resets the mouse viewport
    def reset_mouse_viewport
    end
    private
    def mouse_fps_create_graphics
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics mouse_fps_create_graphics') {mouse_fps_create_graphics }
    def reset_fps_info
    end
    Hooks.register(Graphics, :frame_reset, 'PSDK Graphics reset_fps_info') {reset_fps_info }
    def update_gc_time(delta_time)
    end
    def reset_gc_time
    end
    def update_ruby_time(delta_time)
    end
    def reset_ruby_time
    end
    def init_fps_text
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics init_fps_text') {init_fps_text }
    def fps_visibility(visible)
    end
    def fps_update
    end
    Hooks.register(Graphics, :pre_update_internal, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :update_freeze, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :update_transition_internal, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :post_transition, 'PSDK Graphics reset_fps_info') {reset_fps_info }
    def fps_gpu_update
    end
    Hooks.register(Graphics, :post_update_internal, 'PSDK Graphics fps_gpu_update') {fps_gpu_update }
    def mouse_create_graphics
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics mouse_create_graphics') {mouse_create_graphics }
    def mouse_update_graphics
    end
    Hooks.register(Graphics, :pre_update_internal, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
    Hooks.register(Graphics, :update_freeze, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
    Hooks.register(Graphics, :update_transition_internal, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
  end
  reset_fps_info
  on_start do
    Graphics.load_icon
  end
  class << self
    # Load the window icon
    def load_icon
    end
    alias original_swap_fullscreen swap_fullscreen
    # Define swap_fullscreen so the icon is taken in account
    def swap_fullscreen
    end
  end
  # Class helping to balance FPS on FPS based things
  class FPSBalancer
    @globally_enabled = true
    @last_f3_up = Time.new - 10
    # Create a new FPSBalancer
    def initialize
    end
    # Update the metrics of the FPSBalancer
    def update
    end
    # Run code according to FPS Balancing (block will be executed only if it's ok)
    # @param block [Proc] code to execute as much as needed
    def run(&block)
    end
    # Tell if the balancer is skipping frames
    def skipping?
    end
    # Force all the scripts to render if we're about to do something important
    def disable_skip_for_next_rendering
    end
    private
    def update_intervals
    end
    Hooks.register(Graphics, :post_transition, 'Reset interval after transition') do
      FPSBalancer.global.send(:update_intervals)
    end
    class << self
      # Get if the FPS balancing is globally enabled
      # @return [Boolean]
      attr_accessor :globally_enabled
      # Get last time F3 was pressed
      # @return [Time]
      attr_accessor :last_f3_up
      # Get the global balancer
      # @return [FPSBalancer]
      attr_reader :global
    end
    # Marker allowing the game to know the scene should be frame balanced
    module Marker
      # Function telling the object is supposed to be frame balanced
      def frame_balanced?
      end
    end
    @global = new
  end
  class << self
    alias original_update update
    # Update with fps balancing
    def update
    end
  end
end
class Object
  # Method that shows the help
  def help
  end
  # Parse a text from the text database with specific informations and a pokemon
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param pokemon [PFM::Pokemon] pokemon that will introduce an offset on text_id (its name is also used)
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text_with_pokemon(file_id, text_id, pokemon, additionnal_var = nil)
  end
  # Parse a text from the text database with 2 pokemon & specific information
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param pokemon1 [PFM::Pokemon] pokemon we're talking about
  # @param pokemon2 [PFM::Pokemon] pokemon who originated the "problem" (eg. bind)
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text_with_2pokemon(file_id, text_id, pokemon1, pokemon2, additionnal_var = nil)
  end
  # Parse a text from the text database with specific informations
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @param additionnal_var [nil, Hash{String => String}] additional remplacements in the text
  # @return [String] the text parsed and ready to be displayed
  def parse_text(file_id, text_id, additionnal_var = nil)
  end
  # Get a text front the text database
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @return [String] the text
  def text_get(file_id, text_id)
  end
  # Get a list of text from the text database
  # @param file_id [Integer] ID of the text file
  # @return [Array<String>] the list of text contained in the file.
  def text_file_get(file_id)
  end
  # Clean an array containing object responding to #name (force utf-8)
  # @param arr [Array<#name>]
  # @return [arr]
  def _clean_name_utf8(arr)
  end
  # Get a text front the external text database
  # @param file_id [Integer] ID of the text file
  # @param text_id [Integer] ID of the text in the file
  # @return [String] the text
  def ext_text(file_id, text_id)
  end
  # Play decision SE
  def play_decision_se
  end
  # Play cursor SE
  def play_cursor_se
  end
  # Play buzzer SE
  def play_buzzer_se
  end
  # Play cancel SE
  def play_cancel_se
  end
  # Play the Equip SE
  def play_equip_se
  end
  # Play the Shop SE
  def play_shop_se
  end
  # Play the Save SE
  def play_save_se
  end
  # Play the Load SE
  def play_load_se
  end
  # Play the Escape SE
  def play_escape_se
  end
  # Play the Actor collapse SE
  def play_actor_collapse_se
  end
  # Play the Enemy collapse SE
  def play_enemy_collapse_se
  end
end
# Module that allows you to schedule some tasks and run them at the right time
#
# The Scheduler has a @tasks Hash that is organized the following way:
#   @tasks[reason][class] = [tasks]
#   reason is one of the following reasons :
#     on_update: during Graphics.update
#     on_scene_switch: before going outside of the #main function of the scene (if called)
#     on_dispose: during the dispose process
#     on_init: at the begining of #main before Graphics.transition
#     on_warp_start: at the begining of player warp process (first action)
#     on_warp_process: after the player has been teleported but before the states has changed
#     on_warp_end: before the transition starts
#     on_hour_update: When the current hour change (ex: refresh groups)
#     on_getting_tileset_name: When the Map Engine search for the correct tileset name
#     on_transition: When Graphics.transition is called
#   class is a Class Object related to the scene where the Scheduler starts
#
# The Sheduler also has a @storage Hash that is used by the tasks to store informations
module Scheduler
  module_function
  # Initialize the Scheduler with no task and nothing in the storage
  def init
  end
  init
  # Start tasks that are related to a specific reason
  # @param reason [Symbol] reason explained at the top of the page
  # @param klass [Class, :any] the class of the scene
  def start(reason, klass = $scene.class)
  end
  # Remove a task
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param name [String] the name that describe the task
  # @param priority [Integer] its priority
  def __remove_task(reason, klass, name, priority)
  end
  # add a task (and sort them by priority)
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param task [ProcTask, MessageTask] the task to run
  def __add_task(reason, klass, task)
  end
  # Description of a Task that execute a Proc
  class ProcTask
    # Priority of the task
    # @return [Integer]
    attr_reader :priority
    # Name that describe the task
    # @return [String]
    attr_reader :name
    # Initialize a ProcTask with its name, priority and the Proc it executes
    # @param name [String] name that describe the task
    # @param priority [Integer] the priority of the task
    # @param proc_object [Proc] the proc (with no param) of the task
    def initialize(name, priority, proc_object)
    end
    # Invoke the #call method of the proc
    def start
    end
  end
  # Add a proc task to the Scheduler
  # @param reason [Symbol] the reason
  # @param klass [Class] the class of the scene
  # @param name [String] the name that describe the task
  # @param priority [Integer] the priority of the task
  # @param proc_object [Proc] the Proc object of the task (kept for compatibility should not be defined)
  # @param block [Proc] the Proc object of the task
  def add_proc(reason, klass, name, priority, proc_object = nil, &block)
  end
  # Describe a Task that send a message to a specific object
  class MessageTask
    # Priority of the task
    # @return [Integer]
    attr_reader :priority
    # Name that describe the task
    # @return [String]
    attr_reader :name
    # Initialize a MessageTask with its name, priority, the object and the message to send
    # @param name [String] name that describe the task
    # @param priority [Integer] the priority of the task
    # @param object [Object] the object that receive the message
    # @param message [Array<Symbol, *args>] the message to send
    def initialize(name, priority, object, message)
    end
    # Send the message to the object
    def start
    end
  end
  # Add a message task to the Scheduler
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param name [String] name that describe the task
  # @param priority [Integer] the priority of the task
  # @param object [Object] the object that receive the message
  # @param message [Array<Symbol, *args>] the message to send
  def add_message(reason, klass, name, priority, object, *message)
  end
  # Return the object of the Boot Scene (usually Scene_Title)
  # @return [Object]
  def get_boot_scene
  end
  public
  # Module that aim to add task triggered by events actions
  #
  # List of the event actions :
  #   - begin_step
  #   - begin_jump
  #   - begin_slide
  #   - end_step
  #   - end_jump
  #   - end_slide
  #
  # Events can be specified with the following criteria
  #   - map_id / :any : ID of the map where the task can trigger
  #   - event_id / :any : ID of the event that trigger the task (-1 = player, -2 its first follower, -3 its second, ...)
  #
  # Parameter sent to the task :
  #   - event : Game_Character object that triggered the task
  #   - event_id : ID of the event that triggered the task (for :any tasks)
  #   - map_id : ID of the map where the task was triggered (for :any tasks)
  #
  # Important note : The system will detect the original id & map of the events (that's why the event object is sent & its id)
  module EventTasks
    @tasks = {}
    module_function
    # Add a new task
    # @param task_type [Symbol] one of the specific tasks
    # @param description [String] description allowing to retrieve the task
    # @param event_id [Integer, :any] id of the event that triggers the task
    # @param map_id [Integer, :any] id of the map where the task triggers
    # @param task [Proc] task executed
    def on(task_type, description, event_id = :any, map_id = :any, &task)
    end
    # Trigger a specific task
    # @param task_type [Symbol] one of the specific tasks
    # @param event [Game_Character] event triggering the task
    def trigger(task_type, event)
    end
    # Resolve the id of the event
    # @param event [Game_Character]
    # @return [Integer]
    def resolve_id(event)
    end
    # Resolve the id of the event
    # @param event [Game_Character]
    # @return [Integer]
    def resolve_map_id(event)
    end
    # Remove a task
    # @param task_type [Symbol] one of the specific tasks
    # @param description [String] description allowing to retrieve the task
    # @param event_id [Integer, :any] id of the event that triggers the task
    # @param map_id [Integer, :any] id of the map where the task triggers
    def delete(task_type, description, event_id, map_id)
    end
  end
end
Hooks.register(Graphics, :transition, 'PSDK Graphics.transition') {Scheduler.start(:on_transition) }
Hooks.register(Graphics, :update, 'PSDK Graphics.update') {Scheduler.start(:on_update) }
Scheduler::EventTasks.on(:end_jump, 'Dust after jumping') do |event|
  next if event.particles_disabled
  particle = Game_Character::SurfTag.include?(event.system_tag) ? :water_dust : :dust
  Yuki::Particles.add_particle(event, particle)
end
Scheduler::EventTasks.on(:end_step, 'Repel count', -1) {PFM.game_state.repel_update }
Scheduler::EventTasks.on(:end_step, 'Daycare', -1) {$daycare.update }
Scheduler::EventTasks.on(:end_step, 'Loyalty check', -1) {PFM.game_state.loyalty_update }
Scheduler::EventTasks.on(:end_step, 'PoisonUpdate', -1) {PFM.game_state.poison_update }
Scheduler::EventTasks.on(:end_step, 'Hatch check', -1) {PFM.game_state.hatch_check_update }
Scheduler::EventTasks.on(:begin_step, 'BattleStarting', -1) {PFM.game_state.battle_starting_update }
# Class designed to test an interface or a script
class Tester
  @@args = nil
  @@class = nil
  # Create a new test
  # @param script [String] filename of the script to test
  def initialize(script)
  end
  # Main process of the tester
  def main
  end
  # Retart the scene
  # @return [true]
  def restart_scene
  end
  # Show the test message
  def show_test_message
  end
  # Quit the test
  def quit_test
  end
  # Load the script
  # @return [true]
  def load_script
  end
  # Manage the exception
  def manage_exception
  end
  # Define the class and the arguments of it to test
  # @param klass [Class] the class to test
  # @param args [Array] the arguments
  def self.start(klass, *args)
  end
  # Load the RMXP Data
  def data_load
  end
end
module LiteRGSS
  class Text
    # Utility module to manage text easly in user interfaces.
    # @deprecated DO NOT FUCKING USE THIS. Use SpriteStack instead.
    module Util
      # Default outlinesize, nil gives a 0 and keep shadow processing, 0 or more disable shadow processing
      DEFAULT_OUTLINE_SIZE = nil
      # Offset induced by the Font
      FOY = 2
      #4
      # Returns the text viewport
      # @return [Viewport]
      def text_viewport
      end
      # Change the text viewport
      def text_viewport=(v)
      end
      # Initialize the texts
      # @param font_id [Integer] the default font id of the texts
      # @param viewport [Viewport, nil] the viewport
      def init_text(font_id = 0, viewport = nil, z = 1000)
      end
      # Add a text inside the window, the offset x/y will be adjusted
      # @param x [Integer] the x coordinate of the text surface
      # @param y [Integer] the y coordinate of the text surface
      # @param width [Integer] the width of the text surface
      # @param height [Integer] the height of the text surface
      # @param str [String] the text shown by this object
      # @param align [0, 1, 2] the align of the text in its surface (best effort => no resize), 0 = left, 1 = center, 2 = right
      # @param outlinesize [Integer, nil] the size of the text outline
      # @param type [Class] the type of text
      # @return [Text] the text object
      def add_text(x, y, width, height, str, align = 0, outlinesize = DEFAULT_OUTLINE_SIZE, type: Text)
      end
      # Dispose the texts
      def text_dispose
      end
      # Yield a block on each undisposed text
      def text_each
      end
    end
    # Set a multiline text
    # @param value [String] Multiline text that should be ajusted to be display on multiple lines
    def multiline_text=(value)
    end
  end
end
# SpriteSheet is a class that helps the maker to display a sprite from a Sprite Sheet on the screen
class SpriteSheet < ShaderedSprite
  # Return the number of sprite on the x axis of the sheet
  # @return [Integer]
  attr_reader :nb_x
  # Return the number of sprite on the y axis of the sheet
  # @return [Integer]
  attr_reader :nb_y
  # Return the x sprite index of the sheet
  # @return [Integer]
  attr_reader :sx
  # Return the y sprite index of the sheet
  # @return [Integer]
  attr_reader :sy
  # Create a new SpriteSheet
  # @param viewport [Viewport, nil] where to display the sprite
  # @param nb_x [Integer] the number of sprites on the x axis in the sheet
  # @param nb_y [Integer] the number of sprites on the y axis in the sheet
  def initialize(viewport, nb_x, nb_y)
  end
  # Change the bitmap of the sprite
  # @param value [Texture, nil]
  def bitmap=(value)
  end
  # Change the number of cells the sheet supports on the x axis
  # @param nb_x [Integer] number of cell on the x axis
  def nb_x=(nb_x)
  end
  # Change the number of cells the sheet supports on the y axis
  # @param nb_y [Integer] number of cell on the y axis
  def nb_y=(nb_y)
  end
  # Redefine the number of cells the sheet supports on both axis
  # @param nb_x [Integer] number of cell on the x axis
  # @param nb_y [Integer] number of cell on the y axis
  def resize(nb_x, nb_y)
  end
  # Change the x sprite index of the sheet
  # @param value [Integer] the x sprite index of the sheet
  def sx=(value)
  end
  # Change the y sprite index of the sheet
  # @param value [Integer] the y sprite index of the sheet
  def sy=(value)
  end
  # Select a sprite on the sheet according to its x and y index
  # @param sx [Integer] the x sprite index of the sheet
  # @param sy [Integer] the y sprite index of the sheet
  # @return [self]
  def select(sx, sy)
  end
end
# A module that helps the PSDK_DEBUG to perform some commands
module Debugger
  # Warp Error message
  WarpError = 'Aucune map de cet ID'
  # Name of the map to load to prevent warp error
  WarpMapName = 'Data/Map%03d.rxdata'
  module_function
  # Warp command
  # @param id [Integer] ID of the map to warp
  # @param x [Integer] X position
  # @param y [Integer] Y position
  # @author Nuri Yuri
  def warp(id, x = -1, y = -1)
  end
  # Fight a specific trainer by its ID
  # @param id [Integer] ID of the trainer in Studio
  # @param bgm [Array(String, Integer, Integer)] bgm description of the trainer battle
  # @param troop_id [Integer] ID of the RMXP Troop to use
  def battle_trainer(id, bgm = Interpreter::DEFAULT_TRAINER_BGM, troop_id = 3)
  end
  # Find the normal position where the player should warp in a specific map
  # @param id [Integer] id of the map
  # @return [Boolean] if a normal position has been found
  # @author Nuri Yuri
  def __find_maker_warp(id)
  end
  # Find an alternative position where to warp
  # @param map [RPG::Map] the map data
  # @author Nuri Yuri
  def __find_map_warp(map)
  end
  # Detect a teleport command in the pages of an event
  # @param pages [Array<RPG::Event::Page>] the list of event page
  # @return [Boolean] if a command has been found
  # @author Nuri Yuri
  def __warp_command_found(pages)
  end
end
class Sprite
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
  # Detect if the mouse is in the sprite (without rotation)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
end
class Text
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
end
class Viewport
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
end
class Window
  # Detect if the mouse is in the window
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the window
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the window
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
  end
end
