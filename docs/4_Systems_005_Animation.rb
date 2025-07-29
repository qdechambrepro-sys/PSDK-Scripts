# Simple implementation of a clock
class Clock
  # Atomic delta value to avoid high imprecision due to big framerates
  ATOMIC_DELTA = 0.001
  # Get the clock speed factor
  # @return [Float, Integer]
  attr_reader :speed_factor
  # Create a new clock
  def initialize
  end
  alias reset initialize
  public :reset
  # Tell if the clock is frozen
  # @return [Boolean]
  def frozen?
  end
  # Freeze the clock
  def freeze
  end
  # Unfreeze the clock
  def unfreeze
  end
  # Get the elapsed time (in seconds)
  # @return [Float]
  def elapsed_time
  end
  # Set the clock speed factor
  # @param speed_factor [Float, Integer]
  def speed_factor=(speed_factor)
  end
  private
  # Tick the clock (add time to elapsed time)
  def tick
  end
  @main = new
  class << self
    # Get the main clock
    # @return [Clock]
    attr_reader :main
  end
end
module Yuki
  # Module containing all the animation utility
  module Animation
    module_function
    pi_div2 = Math::PI / 2
    # Causal method
    # @param x [Float, Integer]
    # @return [Float]
    def r(x)
    end
    # Hash describing all the distortion proc
    DISTORTIONS = {SMOOTH_DISTORTION: proc { |x| 1 - Math.cos(pi_div2 * x ** 1.5) ** 5 }, UNICITY_DISTORTION: proc { |x| x }, SQUARE010_DISTORTION: proc { |x| 1 - (x * 2 - 1) ** 2 }, SIN: proc { |x| Math.sin(2 * Math::PI * x) }, FALLING_SMOOTH: proc { |x| 5 * r(x) - 6 * r(x - 0.2) + 1.25 * r(x - 0.4) - 0.25 * r(x - 0.6) }, POSITIVE_OSCILLATING_4: proc { |x| (Math.sin(8 * Math::PI * x) + 1) / 2 }, POSITIVE_OSCILLATING_16: proc { |x| (Math.sin(32 * Math::PI * x) + 1) / 2 }, POWDER_1: proc { |x| 1.5 + 5 * r(x) - 10 * r(x - 0.2) }, POWDER_2: proc { |x| 1.5 - 5 * r(x) + 10 * r(x - 0.8) }, POWDER_3: proc { |x| -0.5 + 5 * r(x) - 10 * r(x - 0.6) }, POWDER_4: proc { |x| -0.5 - 5 * r(x) + 10 * r(x - 0.4) }, POWDER_5: proc { |x| -2.5 + 5 * x }}
    public
    # Hash describing all the time sources
    TIME_SOURCES = {GENERIC_TIME_SOURCE: Graphics.method(:current_time), SCENE_TIME_SOURCE: proc {$scene.respond_to?(:clock) ? $scene.clock.elapsed_time : Clock.main.elapsed_time }}
    # Default object resolver (make the game crash)
    DEFAULT_RESOLVER = proc { |x| raise "Couldn't resolve object :#{x}" }
    module_function
    # Create a "wait" animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def wait(during, time_source: :SCENE_TIME_SOURCE)
    end
    # Class calculating time offset for animation.
    #
    # This class also manage parallel & sub animation. Example :
    #   (TimedAnimation.new(1) | TimedAnimation.new(2) > TimedAnimation.new(3)).root
    #   # Is equivalent to
    #   TimedAnimation.new(1).parallel_play(TimedAnimation.new(2)).play_before(TimedAnimation.new(3)).root
    #   # Which is equivalent to : play 1 & 2 in parallel and then play 3
    #   # Note that if 2 has sub animation, its sub animation has to finish in order to see animation 3
    class TimedAnimation
      # @return [Array<TimedAnimation>] animation playing in parallel
      attr_reader :parallel_animations
      # @return [TimedAnimation, nil] animation that plays after
      attr_reader :sub_animation
      # @return [TimedAnimation] the root animation
      #   (to retreive the right animation to play when building animation using operators)
      attr_accessor :root
      # Get the begin time of the animation (if started)
      # @return [Time, nil]
      attr_reader :begin_time
      # Get the end time of the animation (if started)
      # @return [Time, nil]
      attr_reader :end_time
      # Get the time source of the animation (if started)
      # @return [#call, nil]
      attr_reader :time_source
      # Create a new TimedAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      #   convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, distortion = :UNICITY_DISTORTION, time_source = :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Indicate if the animation is done
      # @note should always be called after start
      # @return [Boolean]
      def done?
      end
      # Update the animation internal time and call update_internal with a parameter between
      # 0 & 1 indicating the progression of the animation
      # @note should always be called after start
      def update
      end
      # Add a parallel animation
      # @param other [TimedAnimation] the parallel animation to add
      # @return [self]
      def parallel_add(other)
      end
      alias_method :<<, :parallel_add
      alias_method :|, :parallel_add
      alias_method :parallel_play, :parallel_add
      # Add this animation in parallel of another animation
      # @param other [TimedAnimation] the parallel animation to add
      # @return [TimedAnimation] the animation parameter
      def in_parallel_of(other)
      end
      alias_method :>>, :in_parallel_of
      # Add a sub animation
      # @param other [TimedAnimation]
      # @return [TimedAnimation] the animation parameter
      def play_before(other)
      end
      alias_method :>, :play_before
      # Define the resolver (and transmit it to all the childs / parallel)
      # @param resolver [#call] callable that takes 1 parameter and return an object
      def resolver=(resolver)
      end
      private
      # Indicate if this animation in particular is done (not the parallel, not the sub, this one)
      # @return [Boolean]
      def private_done?
      end
      # Indicate if this animation in particular has started
      def private_began?
      end
      # Method you should always overwrite in order to perform the right animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
      # Resolve an object from a symbol using the resolver
      # @param param [Symbol, Object]
      # @return [Object]
      def resolve(param)
      end
    end
    # Class responsive of making "looped" animation
    #
    # This class works exactly the same as TimedAnimation putting asside it's always done and will update its sub/parallel animations.
    # When the loop duration is reached, it restart all the animations with the apprioriate offset.
    #
    # @note This kind of animation is not designed for object creation, please refrain from creating objects inside those kind of animations.
    class TimedLoopAnimation < TimedAnimation
      # Update the looped animation
      def update
      end
      # Start the animation but without sub_animation bug
      # (it makes no sense that the sub animation start after a looped animation)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Looped animations are always done
      def done?
      end
    end
    # Create a rotation animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param angle_start [Float, Symbol] start angle
    # @param angle_end [Float, Symbol] end angle
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def rotation(during, on, angle_start, angle_end, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a opacity animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param opacity_start [Float, Symbol] start opacity
    # @param opacity_end [Float, Symbol] end opacity
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def opacity_change(during, on, opacity_start, opacity_end, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a scalar animation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
    # @param a [Float, Symbol] origin position
    # @param b [Float, Symbol] destination position
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def scalar(time_to_process, on, property, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Class that perform a scalar animation (set object.property to a upto b depending on the animation)
    class ScalarAnimation < TimedAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a [Float, Symbol] origin position
      # @param b [Float, Symbol] destination position
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Scalar animation with offset
    class ScalarOffsetAnimation < ScalarAnimation
      # Create a new ScalarOffsetAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property_get [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param property_set [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a [Float, Symbol] origin position
      # @param b [Float, Symbol] destination position
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property_get, property_set, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new ScalarOffsetAnimation
    # @return [ScalarOffsetAnimation]
    def scalar_offset(time_to_process, on, property_get, property_set, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a move animation (from a to b)
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param start_x [Float, Symbol] start x
    # @param start_y [Float, Symbol] start y
    # @param end_x [Float, Symbol] end x
    # @param end_y [Float, Symbol] end y
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def move(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a move animation (from a to b) with discreet values (Integer)
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param start_x [Float, Symbol] start x
    # @param start_y [Float, Symbol] start y
    # @param end_x [Float, Symbol] end x
    # @param end_y [Float, Symbol] end y
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def move_discreet(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a origin pixel shift animation (from a to b inside the bitmap)
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param start_x [Float, Symbol] start ox
    # @param start_y [Float, Symbol] start oy
    # @param end_x [Float, Symbol] end ox
    # @param end_y [Float, Symbol] end oy
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def shift(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Class that perform a 2D animation (from point a to point b)
    class Dim2Animation < TimedAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a_x [Float, Symbol] origin x position
      # @param a_y [Float, Symbol] origin y position
      # @param b_x [Float, Symbol] destination x position
      # @param b_y [Float, Symbol] destination y position
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property, a_x, a_y, b_x, b_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a src_rect.x animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property (please give sprite.src_rect)
    # @param cell_start [Integer, Symbol] start opacity
    # @param cell_end [Integer, Symbol] end opacity
    # @param width [Integer, Symbol] width of the cell
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def cell_x_change(during, on, cell_start, cell_end, width, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a src_rect.y animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property (please give sprite.src_rect)
    # @param cell_start [Integer, Symbol] start opacity
    # @param cell_end [Integer, Symbol] end opacity
    # @param width [Integer, Symbol] width of the cell
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def cell_y_change(during, on, cell_start, cell_end, width, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Class that perform a discreet number animation (set object.property to a upto b using integer values only)
    class DiscreetAnimation < TimedAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a [Integer, Symbol] origin position
      # @param b [Integer, Symbol] destination position
      # @param factor [Integer, Symbol] factor applied to a & b to produce stuff like src_rect animation (sx * width)
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property, a, b, factor = 1, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Class that perform a 2D animation (from point a to point b)
    class Dim2AnimationDiscreet < TimedAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a_x [Float, Symbol] origin x position
      # @param a_y [Float, Symbol] origin y position
      # @param b_x [Float, Symbol] destination x position
      # @param b_y [Float, Symbol] destination y position
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property, a_x, a_y, b_x, b_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Class that describe a SpriteSheet animation
    class SpriteSheetAnimation < TimedAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [SpriteSheet, Symbol] object that will receive the property
      # @param cells [Array<Array<Integer>>, Symbol] all the select arguments that should be sent during the animation
      # @param rounding [Symbol] kind of rounding, can be: :ceil, :round, :floor
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, cells, rounding = :round, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    public
    module_function
    # Class executing commands for animations (takes 0 seconds to proceed and then needs no time information)
    # @note This class inherit from TimedAnimation to allow composition with it but it overwrite some components
    # @note Animation inheriting from this class has a `update_internal` with no parameters!
    class Command < TimedAnimation
      # Create a new Command
      def initialize
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Update the animation internal time and call update_internal with no parameter
      # @note should always be called after start
      def update
      end
      private
      # Indicate if this animation in particular is done (not the parallel, not the sub, this one)
      # @return [Boolean]
      def private_done?
      end
      # Indicate if this animation in particular has started
      def private_began?
      end
      # Perform the animation action
      def update_internal
      end
    end
    # Play a BGM
    # @param filename [String] name of the file inside Audio/BGM
    # @param volume [Integer] volume to play the bgm
    # @param pitch [Integer] pitch used to play the bgm
    def bgm_play(filename, volume = 100, pitch = 100)
    end
    # Stop the bgm
    def bgm_stop
    end
    # Play a BGS
    # @param filename [String] name of the file inside Audio/BGS
    # @param volume [Integer] volume to play the bgs
    # @param pitch [Integer] pitch used to play the bgs
    def bgs_play(filename, volume = 100, pitch = 100)
    end
    # Stop the bgs
    def bgs_stop
    end
    # Play a ME
    # @param filename [String] name of the file inside Audio/ME
    # @param volume [Integer] volume to play the me
    # @param pitch [Integer] pitch used to play the me
    def me_play(filename, volume = 100, pitch = 100)
    end
    # Play a SE
    # @param filename [String] name of the file inside Audio/SE
    # @param volume [Integer] volume to play the se
    # @param pitch [Integer] pitch used to play the se
    def se_play(filename, volume = 100, pitch = 100)
    end
    # Animation command responsive of playing / stopping audio.
    # It sends the type command to Audio with *args as parameter.
    #
    # Example: Playing a SE
    #   AudioCommand.new(:se_play, 'audio/se/filename', 80, 80)
    class AudioCommand < Command
      # Create a new AudioCommand
      # @param type [Symbol] name of the method of Audio to call
      # @param args [Array] parameter to send to the command
      def initialize(type, *args)
      end
      private
      # Execute the audio command
      def update_internal
      end
    end
    # Create a new sprite
    # @param viewport [Symbol] viewport to use inside the resolver
    # @param name [Symbol] name of the sprite inside the resolver
    # @param type [Class] class to use in order to create the sprite
    # @param args [Array] argument to send to the sprite in order to create it (sent after viewport)
    # @param properties [Array<Array>] list of properties to call with their values
    def create_sprite(viewport, name, type, args = nil, *properties)
    end
    # Animation command responsive of creating sprites and storing them inside the resolver
    #
    # Example :
    #   SpriteCreationCommand.new(:main, :star1, SpriteSheet, [1, 3], [:select, 0, 1], [:set_position, 160, 120])
    #   # This will create a spritesheet at the coordinate 160, 120 and display the cell 0,1
    class SpriteCreationCommand < Command
      # Create a new SpriteCreationCommand
      # @param viewport [Symbol] viewport to use inside the resolver
      # @param name [Symbol] name of the sprite inside the resolver
      # @param type [Class] class to use in order to create the sprite
      # @param args [Array] argument to send to the sprite in order to create it (sent after viewport)
      # @param properties [Array<Array>] list of properties to call with their values
      def initialize(viewport, name, type, args, *properties)
      end
      private
      # Execute the sprite creation command
      def update_internal
      end
    end
    # Send a command to an object in the resolver
    # @param name [Symbol] name of the object in the resolver
    # @param command [Symbol] name of the method to call
    # @param args [Array] arguments to send to the method
    def send_command_to(name, command, *args)
    end
    # Dispose a sprite
    # @param name [Symbol] name of the sprite in the resolver
    def dispose_sprite(name)
    end
    # Animation command that sends a message to an object in the resolver
    #
    # Example :
    #   ResolverObjectCommand.new(:star1, :set_position, 0, 0)
    #   # This will call set_position(0, 0) on the star1 object in the resolver
    class ResolverObjectCommand < Command
      # Create a new ResolverObjectCommand
      # @param name [Symbol] name of the object in the resolver
      # @param command [Symbol] name of the method to call
      # @param args [Array] arguments to send to the method
      def initialize(name, command, *args)
      end
      private
      # Execute the command
      def update_internal
      end
    end
    # Try to run commands during a specific duration and giving a fair repartition of the duraction for each commands
    # @note Never put dispose command inside this command, there's risk that it does not execute
    # @param duration [Float] number of seconds (with generic time) to process the animation
    # @param animation_commands [Array<Command>]
    def run_commands_during(duration, *animation_commands)
    end
    # Animation that try to execute all the given command at total_time / n_command * command_index
    # Example :
    #   TimedCommands.new(1,
    #     create_sprite(:main, :star1, SpriteSheet, [1, 3], [:select, 0, 0]),
    #     send_command_to(:star1, :select, 0, 1),
    #     send_command_to(:star1, :select, 0, 2),
    #   )
    #   # Will create the start at 0
    #   # Will set the second cell at 0.33
    #   # Will set the third cell at 0.66
    # @note It'll skip all the commands that are not SpriteCreationCommand if it's "too late"
    class TimedCommands < DiscreetAnimation
      # Create a new TimedCommands object
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param animation_commands [Array<Command>]
      def initialize(time_to_process, *animation_commands)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Define the resolver (and transmit it to all the childs / parallel)
      # @param resolver [#call] callable that takes 1 parameter and return an object
      def resolver=(resolver)
      end
      private
      # Execute a command
      # @param index [Integer] index of the command
      def run_command(index)
      end
    end
    public
    module_function
    # Function that creates a message locked animation
    def message_locked_animation
    end
    # Animation that doesn't update when message box is still visible
    class MessageLocked < TimedAnimation
      # Update the animation (if message window is not visible)
      def update
      end
    end
    public
    # Class handling several animation at once
    class Handler < Hash
      # Update all the animations
      def update
      end
      # Tell if all animation are done
      def done?
      end
    end
    public
    module_function
    # Animation resposive of positinning a sprite between two other sprites
    class MoveSpritePosition < ScalarAnimation
      # Create a new ScalarAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Symbol] origin sprite position
      # @param b [Symbol] destination sprite position
      # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distord time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Method you should always overwrite in order to perform the right animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new ScalarAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Symbol] origin sprite position
    # @param b [Symbol] destination sprite position
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [MoveSpritePosition]
    def move_sprite_position(time_to_process, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new TimedLoopAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def timed_loop_animation(time_to_process, distortion = :UNICITY_DISTORTION, time_source = :SCENE_TIME_SOURCE)
    end
    # Class that help to handle animations that depends on sprite creation commands
    #
    # @example Create a fully resolved animation
    #   root_anim = Yuki::Animation.create_sprite(:viewport, :sprite, Sprite)
    #   resolved_animation = Yuki::Animation.resolved
    #   root_anim.play_before(resolved_animation)
    #   resolved_animation.play_before(...)
    #   resolved_animation.play_before(...)
    #   resolved_animation.parallel_play(...)
    #   root_anim.play_before(Yuki::Animation.dispose_sprite(:sprite))
    #
    # @note The play command of all animation played before resolved animation will be called after all previous animation were called.
    #       It's a good practice not to put something else than dispose command after a fully resolved animation.
    class FullyResolvedAnimation < TimedAnimation
      # Create a new fully resolved animation
      def initialize
      end
      alias timed_animation_start start
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Tell if the animation is done
      # @return [Boolean]
      def done?
      end
      # Update the animation internal time and call update_internal with a parameter between
      # 0 & 1 indicating the progression of the animation
      # @note should always be called after start
      def update
      end
    end
    # Create a fully resolved animation
    # @return [FullyResolvedAnimation]
    def resolved
    end
    public
    # Animation that wait for a signal in order to start the sub animation
    class SignalWaiter < Command
      # Create a new SignalWaiter
      # @param name [Symbol] name of the block in resolver to call to know if the signal is there
      # @param args [Array] optional arguments to the block
      # @param block [Proc] if provided, name will be ignored and this block will be used (it prevents this animation from being savable!)
      def initialize(name = nil, *args, &block)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Indicate if this animation in particular is done (not the parallel, not the sub, this one)
      # @return [Boolean]
      def private_done?
      end
      # Perform the animation action
      def update_internal
      end
    end
    module_function
    # Create a new SignalWaiter animation
    # @param name [Symbol] name of the block in resolver to call to know if the signal is there
    # @param args [Array] optional arguments to the block
    # @param block [Proc] if provided, name will be ignored and this block will be used (it prevents this animation from being savable!)
    # @return [SignalWaiter]
    def wait_signal(name = nil, *args, &block)
    end
    public
    module_function
    # Class that performs a 2D elliptical animation (follows an ellipse)
    class EllipseAnimation < TimedAnimation
      # Create a new EllipseAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param property [Symbol] name of the property to affect (add the = sign in the symbol name)
      # @param a [Float, Symbol] semi-major axis (horizontal radius)
      # @param b [Float, Symbol] semi-minor axis (vertical radius)
      # @param turn [Integer, float] number of turns
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, property, a, b, turn: 1, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the ellipse animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create an ellipse animation (follows an elliptical trajectory)
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Float, Symbol] semi-major axis (horizontal radius)
    # @param b [Float, Symbol] semi-minor axis (vertical radius)
    # @param turn [Integer] number of turns
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def ellipse(during, on, a, b, turn: 1, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    # Class that performs a 2D falling animation
    class FallingAnimation < TimedAnimation
      # Create a new FallingAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Symbol] Sprite that should hit
      # @param b [Float, Integer] distance of the fall
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, distortion: :FALLING_SMOOTH, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      private
      # Update the falling animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new FallingAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Symbol] Sprite that should hit
    # @param b [Float, Integer] distance of the fall
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [MoveSpritePosition]
    def falling_animation(time_to_process, on, a, b, distortion: :FALLING_SMOOTH, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    # Animation responsive of moving a sprite between a 2 point, one from a sprite defined by a distance
    class RadiusMoveAnimation < TimedAnimation
      # Create a new RadiusMoveAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Symbol] origin sprite position
      # @param b [Integer] length of the movement
      # @param reversed [Boolean] if the animation should be reversed
      # @param max_radius [Integer] max_radius for the angle direction
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, reversed: false, max_radius: 360, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Method you should always overwrite in order to perform the right animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    class RadiusMoveMarginAnimation < RadiusMoveAnimation
      # Create a new RadiusMoveMarginAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Symbol] origin sprite position
      # @param b [Integer] length of the movement
      # @param x_margin [Integer] x length of the margin origin
      # @param y_margin [Integer] y length of the margin origin
      # @param reversed [Boolean] if the animation should be reversed
      # @param max_radius [Integer] max_radius for the angle direction
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, x_margin = 5, y_margin = 5, reversed: false, max_radius: 360, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
    end
    # Create a new RadiusMoveAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Symbol] origin sprite position
    # @param b [Integer] length of the movement
    # @param reversed [Boolean] if the animation should be reversed
    # @param max_radius [Integer] max_radius for the angle direction
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [RadiusMoveAnimation]
    def radius_move(time_to_process, on, a, b, reversed: false, max_radius: 360, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new RadiusMoveMarginAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Symbol] origin sprite position
    # @param b [Integer] length of the movement
    # @param x_margin [Integer] x length of the margin origin
    # @param y_margin [Integer] y length of the margin origin
    # @param reversed [Boolean] if the animation should be reversed
    # @param max_radius [Integer] max_radius for the angle direction
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [RadiusMoveMarginAnimation]
    def radius_move_margin(time_to_process, on, a, b, x_margin = 5, y_margin = 5, reversed: false, max_radius: 360, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    class ToneAnimation < TimedAnimation
      # Create a new ToneAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Array(Integer, Integer, Integer, Integer)] origin_tone
      # @param b [Array(Integer, Integer, Integer, Integer)] tone wanted
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converts it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Update the animation, interpolating the tone values
      # @param time_factor [Float] number between 0 and 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new ToneAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Array(Integer, Integer, Integer, Integer)] Initial tone values for the animation.
    # @param b [Array(Integer, Integer, Integer, Integer)] Target tone values for the animation.
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [ToneAnimation]
    def tone_animation(time_to_process, on, a, b = a, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
  end
end
