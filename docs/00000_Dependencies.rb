class Object
  # Array representing an empty optional key hash
  EMPTY_OPTIONAL = [].freeze
  # Default error message
  VALIDATE_PARAM_ERROR = 'Parameter %<param_name>s sent to %<method_name>s is incorrect : %<reason>s'
  # Exception message
  EXC_MSG = 'Invalid param value passed to %s#%s, see previous errors to know what are the invalid params'
  # Function that validate the input paramters
  # @note To use a custom message, define a validate_param_message
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_names [Array<Symbol>] list of the names of the params
  # @param param_values [Hash] hash associating a param value to the expected type (description)
  # @example Param with a static type
  #   validate_param(:meth, :param, param => Type)
  # @example Param with various allowed types
  #   validate_param(:meth, :param, param => [Type1, Type2])
  # @example Param using a validation method
  #   validate_param(:meth, :param, param => :validation_method)
  # @example Param using a complex structure (Array of String)
  #   validate_param(:meth, :param, param => { Array => String })
  # @example Param using a complex structure (Array of Symbol, Integer, String, repetetive)
  #   validate_param(:meth, :param, param => { Array => [Symbol, Integer, String], :cyclic => true, min: 3, max: 9})
  # @example Param using a complex structure (Hash)
  #   validate_param(:meth, :param, param => { Hash => { key1: Type, key2: Type2, key3: [String, Symbol] },
  #                                            :optional => [:key2] })
  def validate_param(method_name, *param_names, param_values)
  end
  # Function that does nothing and return nil
  # @example
  #   alias function_to_disable void
  def void(*args)
  end
  # Function that does nothing and return true
  # @example
  #   alias function_to_disable void_true
  def void_true(*args)
  end
  # Function that does nothing and return false
  # @example
  #   alias function_to_disable void_false
  def void_false(*args)
  end
  # Function that does nothing and return 0
  # @example
  #   alias function_to_disable void0
  def void0(*args)
  end
  # Function that does nothing and return []
  # @example
  #   alias function_to_disable void_array
  def void_array(*args)
  end
  # Function that does nothing and return ""
  # @example
  #   alias function_to_disable void_array
  def void_string(*args)
  end
  private
  # Function that validate a single parameter
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Class] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_value(method_name, param_name, value, types)
  end
  # Function that shows an error on a parameter that should be validated by its type
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Class] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_simple(method_name, param_name, value, types)
  end
  # Function that shows an error on a parameter that should be validated by a method
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Symbol] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_method(method_name, param_name, value, types)
  end
  # Function that shows an error on a parameter that should be validated by its type
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Array<Class>] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_multiple(method_name, param_name, value, types)
  end
  # Function that validate a single complex value parameter
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Hash] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_complex_value(method_name, param_name, value, types)
  end
  # Function that validate the size of a complex array value
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Hash] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_complex_value_size(method_name, param_name, value, types)
  end
  # Return the common error message
  # @return [String]
  def validate_param_message
  end
end
# Class that describe a collection of characters
class String
  # Convert numeric related chars of the string to corresponding chars in the Pokemon DS font family
  # @return [self]
  # @author Nuri Yuri
  def to_pokemon_number
  end
end
# Binding class of Ruby
class Binding
  alias [] local_variable_get
  alias []= local_variable_set
end
# Kernel module of Ruby
module Kernel
  # Infer the object as the specified class (lint)
  # @return [self]
  def from(other)
  end
end
# Class that describes RGBA colors in integer scale (0~255)
class Color < LiteRGSS::Color
end
# Class that describe tones (added/modified colors to the surface)
class Tone < LiteRGSS::Tone
end
# Class that defines a rectangular surface of a Graphical element
class Rect < LiteRGSS::Rect
end
# Class that stores an image loaded from file or memory into the VRAM
class Texture < LiteRGSS::Bitmap
  # List of supported extensions
  SUPPORTED_EXTS = ['.png', '.PNG', '.jpg']
  # Initialize the texture, add automatically the extension to the filename
  # @param filename [String] Filename or FileData
  # @param from_mem [Boolean] load the file from memory (then filename is FileData)
  def initialize(filename, from_mem = nil)
  end
end
# Class that stores an image loaded from file or memory into the VRAM
# @deprecated Please stop using bitmap to talk about texture!
class Bitmap < LiteRGSS::Bitmap
  # Create a new Bitmap
  def initialize(*args)
  end
end
# Class that is dedicated to perform Image operation in Memory before displaying those operations inside a texture
class Image < LiteRGSS::Image
end
# BlendMode applicable to a Sprite/Viewport
class BlendMode < LiteRGSS::BlendMode
end
# Module responsive of showing graphics into the main window
module Graphics
  include Hooks
  extend Hooks
  @on_start = []
  @viewports = []
  @frozen = 0
  @frame_rate = 60
  @current_time = Time.new
  @has_focus = true
  @frame_count = 0
  @fullscreen_toggle_enabled = true
  class << self
    # Get the game window
    # @return [LiteRGSS::DisplayWindow]
    attr_reader :window
    # Get the global frame count
    # @return [Integer]
    attr_accessor :frame_count
    # Get the framerate
    # @return [Integer]
    attr_accessor :frame_rate
    # Get the current time
    # @return [Time]
    attr_reader :current_time
    # Get the time when the last frame was executed
    # @return [Time]
    attr_reader :last_time
    # Tell if it is allowed to go fullscreen with ALT+ENTER
    attr_accessor :fullscreen_toggle_enabled
    # Tell if the graphics window has focus
    # @return [Boolean]
    def focus?
    end
    # Tell if the graphics are frozen
    # @return [Boolean]
    def frozen?
    end
    # Tell how much time there was since last frame
    # @return [Float]
    def delta
    end
    # Get the brightness of the main game window
    # @return [Integer]
    def brightness
    end
    # Set the brightness of the main game window
    # @param brightness [Integer]
    def brightness=(brightness)
    end
    # Get the height of the graphics
    # @return [Integer]
    def height
    end
    # Get the width of the graphics
    # @return [Integer]
    def width
    end
    # Get the shader of the graphics
    # @return [Shader]
    def shader
    end
    # Set the shader of the graphics
    # @param shader [Shader, nil]
    def shader=(shader)
    end
    # Freeze the graphics
    def freeze
    end
    # Resize the window screen
    # @param width [Integer]
    # @param height [Integer]
    def resize_screen(width, height)
    end
    # Snap the graphics to bitmap
    # @return [LiteRGSS::Bitmap]
    def snap_to_bitmap
    end
    # Take a screenshot of what's currently displayed on the player's screen and save it as a png file
    # @param filename [String] the filename of the png file (will automatically increment if filename contains '%d')
    # @param scale [Integer] the scale of the final screenshot (between 1 and 3, this helps to multiply 320*240 by a factor)
    def player_view_screenshot(filename, scale)
    end
    # Start the graphics
    def start
    end
    # Stop the graphics
    def stop
    end
    # Transition the graphics between a scene to another
    # @param frame_count_or_sec [Integer, Float] integer = frames, float = seconds; duration of the transition
    # @param texture [Texture] texture used to perform the transition (optional)
    def transition(frame_count_or_sec = 8, texture = nil)
    end
    # Update graphics window content & events. This method might wait for vsync before updating events
    def update
    end
    # Update the graphics window content. This method might wait for vsync before returning
    def update_no_input
    end
    # Update the graphics window event without drawing anything.
    def update_only_input
    end
    # Make the graphics wait for an amout of time
    # @param frame_count_or_sec [Integer, Float] Integer => frames, Float = actual time
    # @yield
    def wait(frame_count_or_sec)
    end
    # Register an event on start of graphics
    # @param block [Proc]
    def on_start(&block)
    end
    # Register a viewport to the graphics (for special handling)
    # @param viewport [Viewport]
    # @return [self]
    def register_viewport(viewport)
    end
    # Unregister a viewport
    # @param viewport [Viewport]
    # @return [self]
    def unregitser_viewport(viewport)
    end
    # Reset frame counter (for FPS reason)
    def frame_reset
    end
    # Init the Sprite used by the Graphics module
    def init_sprite
    end
    # Sort the graphics in z
    def sort_z
    end
    # Swap the fullscreen state
    def swap_fullscreen
    end
    # Set the screen scale factor
    # @param scale [Float] scale of the screen
    def screen_scale=(scale)
    end
    private
    # Update the frozen state of graphics
    def update_freeze
    end
    # Get the registered viewport in order
    # @return [Array<Viewport>]
    def viewports_in_order
    end
    # Actual execution of the transition internal
    # @param frame_count_or_sec [Integer, Float] integer = frames, float = seconds; duration of the transition
    # @param texture [Texture] texture used to perform the transition (optional)
    def transition_internal(frame_count_or_sec, texture)
    end
  end
  # Shader used to perform transition
  TRANSITION_FRAG_SHADER = "uniform float param;\nuniform sampler2D texture;\nuniform sampler2D transition;\nuniform sampler2D nextFrame;\nconst float sensibilite = 0.05;\nconst float scale = 1.0 + sensibilite;\nvoid main()\n{\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  vec4 tran = texture2D(transition, gl_TexCoord[0].xy);\n  float pixel = max(max(tran.r, tran.g), tran.b);\n  pixel -= (param * scale);\n  if(pixel < sensibilite)\n  {\n    vec4 nextFrag = texture2D(nextFrame, gl_TexCoord[0].xy);\n    frag = mix(frag, nextFrag, max(0.0, sensibilite + pixel / sensibilite));\n  }\n  gl_FragColor = frag;\n}\n"
  # Shader used to perform static transition
  STATIC_TRANSITION_FRAG_SHADER = "uniform float param;\nuniform sampler2D texture;\nuniform sampler2D nextFrame;\nvoid main()\n{\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  vec4 nextFrag = texture2D(nextFrame, gl_TexCoord[0].xy);\n  frag = mix(frag, nextFrag, max(0.0, param));\n  gl_FragColor = frag;\n}\n"
end
# Module responsive of giving information about user Inputs
#
# The virtual keys of the Input module are : :A, :B, :X, :Y, :L, :R, :L2, :R2, :L3, :R3, :START, :SELECT, :HOME, :UP, :DOWN, :LEFT, :RIGHT
module Input
  # Alias for the Keyboard module
  Keyboard = Sf::Keyboard
  # Range giving dead zone of axis
  DEAD_ZONE = -20..20
  # Range outside of which a trigger is considered on an exis
  NON_TRIGGER_ZONE = -50..50
  # Sensitivity in order to take a trigger in account on joystick movement
  AXIS_SENSITIVITY = 10
  # Cooldown delta of Input.repeat?
  REPEAT_COOLDOWN = 0.25
  # Time between each signals of Input.repeat? after cooldown
  REPEAT_SPACE = 0.08
  @last_down_times = Hash.new { |hash, key| hash[key] = Graphics.current_time }
  @next_trigger_times = Hash.new { |hash, key| hash[key] = Graphics.current_time }
  @last_state = Hash.new {false }
  @current_state = Hash.new {false }
  @main_joy = 0
  @x_axis = Sf::Joystick::POV_X
  @y_axis = Sf::Joystick::POV_Y
  @x_joy_axis = Sf::Joystick::X
  @y_joy_axis = Sf::Joystick::Y
  @last_text = nil
  s = Keyboard::Scancode
  # List of keys the input knows
  Keys = {A: [s::C, s::Space, s::Enter, s::NumpadEnter, -1], B: [s::X, s::Backspace, s::Escape, s::LShift, -2], X: [s::V, s::Menu, s::Numpad3, s::V, -3], Y: [s::B, s::Numpad1, s::RShift, s::B, -4], L: [s::F, s::Num1, s::Numpad7, s::F, -5], R: [s::G, s::Num3, s::Numpad9, s::G, -6], L2: [s::R, s::R, s::R, s::R, -7], R2: [s::T, s::T, s::T, s::T, -8], L3: [s::Num4, s::Num4, s::Y, s::F2, -9], R3: [s::Num5, s::Num5, s::U, s::F3, -10], START: [s::J, s::J, s::Insert, s::Insert, -8], SELECT: [s::H, s::H, s::Pause, s::Pause, -7], HOME: [s::Semicolon, s::Semicolon, s::Home, s::Home, 255], UP: [s::Up, s::W, s::Numpad8, s::Up, -13], DOWN: [s::Down, s::S, s::Numpad2, s::Down, -14], LEFT: [s::Left, s::A, s::Numpad4, s::Left, -15], RIGHT: [s::Right, s::D, s::Numpad6, s::Right, -16]}
  # List of key ALIAS
  ALIAS_KEYS = {up: :UP, down: :DOWN, left: :LEFT, right: :RIGHT, a: :A, b: :B, x: :X, y: :Y, start: :START, select: :SELECT}
  # List of Axis mapping (axis => key_neg, key_pos)
  AXIS_MAPPING = {Sf::Joystick::Z => %i[R2 L2]}
  @previous_axis_positions = Hash.new { |hash, key| hash[key] = Hash.new {0 } }
  @joysticks_connected = []
  class << self
    # Get the main joystick
    # @return [Integer]
    attr_accessor :main_joy
    # Get the X axis
    attr_accessor :x_axis
    # Get the Y axis
    attr_accessor :y_axis
    # Get the Joystick X axis
    attr_accessor :x_joy_axis
    # Get the Joystick Y axis
    attr_accessor :y_joy_axis
    # Get the 4 direction status
    # @return [Integer] 2 = down, 4 = left, 6 = right, 8 = up, 0 = none
    def dir4
    end
    # Get the 8 direction status
    # @return [Integer] see NumPad to know direction
    def dir8
    end
    # Get the last entered text
    # @return [String, nil]
    def get_text
    end
    # Get the axis position of a joystick
    # @param id [Integer] ID of the joystick
    # @param axis [Integer] axis
    # @return [Integer]
    def joy_axis_position(id, axis)
    end
    # Tell if a key is pressed
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def press?(key)
    end
    # Tell if a key was triggered
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def trigger?(key)
    end
    # Tell if a key was released
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def released?(key)
    end
    # Tell if a key is repeated (0.25s then each 0.08s)
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def repeat?(key)
    end
    # Swap the states (each time input gets updated)
    def swap_states
    end
    # Register all events in the window
    # @param window [LiteRGSS::DisplayWindow]
    def register_events(window)
    end
    private
    # Set the last entered text
    # @param text [String]
    def on_text_entered(text)
    end
    # Set a key up
    # @param key [Integer]
    # @param alt [Boolean] if the alt key is pressed
    def on_key_down(key, alt = false)
    end
    # Set a key down
    # @param key [Integer]
    def on_key_up(key)
    end
    # Trigger a key depending on the joystick axis movement
    # @param id [Integer] id of the joystick
    # @param axis [Integer] axis
    # @param position [Integer] new position
    def on_axis_moved(id, axis, position)
    end
    # Trigger a RIGHT or LEFT thing depending on x axis position
    # @param position [Integer] new position
    def on_axis_x(position)
    end
    # Trigger a UP or DOWN thing depending on y axis position (D-Pad)
    # @param position [Integer] new position
    def on_axis_y(position)
    end
    # Trigger a UP or DOWN thing depending on y axis position (Joystick)
    # @param position [Integer] new position
    def on_axis_joy_y(position)
    end
    # Add the joystick to the list of connected joysticks and the new joystick connected becomes the main joystick
    # @param id [Integer] id of the joystick
    def on_joystick_connected(id)
    end
    # Remove the joystick to the list of connected joysticks and change the main joystick if other joystick are connected
    # @param id [Integer] id of the joystick
    def on_joystick_disconnected(id)
    end
    # Set a key down if the button pressed comes of main joystick
    # @param id [Integer] id of the joystick
    # @param button [Integer]
    def on_joystick_button_pressed(id, button)
    end
    # Set a key up if the button released comes of main joystick
    # @param id [Integer] id of the joystick
    # @param button [Integer]
    def on_joystick_button_released(id, button)
    end
  end
end
# Module responsive of giving global state of mouse Inputs
#
# The buttons of the mouse are : :LEFT, :MIDDLE, :RIGHT, :X1, :X2
module Mouse
  @last_state = Hash.new {false }
  @current_state = Hash.new {false }
  # Mapping between button & symbols
  BUTTON_MAPPING = {Sf::Mouse::LEFT => :LEFT, Sf::Mouse::RIGHT => :RIGHT, Sf::Mouse::Middle => :MIDDLE, Sf::Mouse::XButton1 => :X1, Sf::Mouse::XButton2 => :X2}
  # List of alias button
  BUTTON_ALIAS = {left: :LEFT, right: :RIGHT, middle: :MIDDLE}
  @wheel = 0
  @wheel_delta = 0
  @x = -999_999
  @y = -999_999
  @in_screen = true
  @moved = false
  class << self
    # Mouse wheel position
    # @return [Integer]
    attr_accessor :wheel
    # Mouse wheel delta
    # @return [Integer]
    attr_reader :wheel_delta
    # Get the mouse x position
    # @return [Integer]
    attr_reader :x
    # Get the mouse y position
    # @return [Integer]
    attr_reader :y
    # Get if the mouse moved since last frame
    # @return [Boolean]
    attr_reader :moved
    # Tell if a button is pressed on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def press?(button)
    end
    # Tell if a button was triggered on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def trigger?(button)
    end
    # Tell if a button was released on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def released?(button)
    end
    # Tell if the mouse is in the screen
    # @return [Boolean]
    def in?
    end
    # Swap the state of the mouse
    def swap_states
    end
    # Register event related to the mouse
    # @param window [LiteRGSS::DisplayWindow]
    def register_events(window)
    end
    private
    # Update the mouse wheel state
    # @param wheel [Integer]
    # @param delta [Float]
    def on_wheel_scrolled(wheel, delta)
    end
    # Update the button state
    # @param button [Integer]
    def on_button_pressed(button)
    end
    # Update the button state
    # @param button [Integer]
    def on_button_released(button)
    end
    # Update the mouse position
    # @param x [Integer]
    # @param y [Integer]
    def on_mouse_moved(x, y)
    end
    # Update the mouse status when it enters the screen
    def on_mouse_entered
    end
    # Update the mouse status when it leaves the screen
    def on_mouse_left
    end
  end
end
# Class that describes a surface of the screen where texts and sprites are shown (with some global effect)
class Viewport < LiteRGSS::Viewport
  # Hash containing all the Viewport configuration (:main, :sub etc...)
  CONFIGS = {}
  @global_offset_x = nil
  @global_offset_y = nil
  # Filename for viewport compiled config
  VIEWPORT_CONF_COMP = 'Data/Viewport.rxdata'
  # Filename for viewport uncompiled config
  VIEWPORT_CONF_TEXT = 'Data/Viewport.json'
  # Tell if the viewport needs to sort
  # @return [Boolean]
  attr_accessor :need_to_sort
  # Create a new viewport
  # @param x [Integer] x coordinate of the viewport on screen
  # @param y [Integer] y coordinate of the viewport on screen
  # @param width [Integer] width of the viewport
  # @param height [Integer] height of the viewport
  # @param z [Integer] z coordinate of the viewport
  def initialize(x, y, width, height, z = nil)
  end
  # Dispose a viewport
  # @return [self]
  def dispose
  end
  class << self
    # Generating a viewport with one line of code
    # @overload create(screen_name_symbol, z = nil)
    #   @param screen_name_symbol [:main, :sub] describe with screen surface the viewport is (loaded from maker options)
    #   @param z [Integer, nil] superiority of the viewport
    # @overload create(x, y = 0, width = 1, height = 1, z = nil)
    #   @param x [Integer] x coordinate of the viewport
    #   @param y [Integer] y coordinate of the viewport
    #   @param width [Integer] width of the viewport
    #   @param height [Integer] height of the viewport
    #   @param z [Integer, nil] superiority of the viewport
    # @overload create(opts)
    #   @param opts [Hash] opts of the viewport definition
    #   @option opts [Integer] :x (0) x coordinate of the viewport
    #   @option opts [Integer] :y (0) y coordinate of the viewport
    #   @option opts [Integer] :width (320) width of the viewport
    #   @option opts [Integer] :height (240) height of the viewport
    #   @option opts [Integer, nil] :z (nil) superiority of the viewport
    # @return [Viewport] the generated viewport
    def create(x, y = 0, width = 1, height = 1, z = 0)
    end
    # Load the viewport configs
    def load_configs
    end
  end
  # Format the viewport to string for logging purposes
  def to_s
  end
  alias inspect to_s
  # Flash the viewport
  # @param color [LiteRGSS::Color] the color used for the flash processing
  def flash(color, duration)
  end
  # Update the viewport
  def update
  end
  # Module defining a shader'd entity that has .color and .tone methods (for flash or other purpose)
  module WithToneAndColors
    # Extended class of Tone allowing setters to port back values to the shader and its tied entity
    class Tone < LiteRGSS::Tone
      # Create a new Tied Tone
      # @param viewport [Viewport, Sprite] element on which the tone is tied
      # @param r [Integer] red color
      # @param g [Integer] green color
      # @param b [Integer] blue color
      # @param g2 [Integer] gray factor
      def initialize(viewport, r, g, b, g2)
      end
      # Set the attribute (according to how it works in normal class)
      # @param args [Array<Integer>]
      def set(*args)
      end
      # Set the red value
      # @param v [Integer]
      def red=(v)
      end
      # Set the green value
      # @param v [Integer]
      def green=(v)
      end
      # Set the blue value
      # @param v [Integer]
      def blue=(v)
      end
      # Set the gray value
      # @param v [Integer]
      def gray=(v)
      end
      private
      # Update the viewport tone shader attribute
      def update_viewport
      end
    end
    # Extended class of Color allowing setters to port back values to the shader and its tied entity
    class Color < LiteRGSS::Color
      # Create a new Tied Color
      # @param viewport [Viewport, Sprite] element on which the color is tied
      # @param r [Integer] red color
      # @param g [Integer] green color
      # @param b [Integer] blue color
      # @param a [Integer] alpha factor
      def initialize(viewport, r, g, b, a)
      end
      # Set the attribute (according to how it works in normal class)
      # @param args [Array<Integer>]
      def set(*args)
      end
      # Set the red value
      # @param v [Integer]
      def red=(v)
      end
      # Set the green value
      # @param v [Integer]
      def green=(v)
      end
      # Set the blue value
      # @param v [Integer]
      def blue=(v)
      end
      # Set the alpha value
      # @param v [Integer]
      def alpha=(v)
      end
      private
      # Update the viewport color shader attribute
      def update_viewport
      end
    end
    # Set color of the viewport
    # @param value [Color]
    def color=(value)
    end
    # Color of the viewport
    # @return [Color]
    def color
    end
    # Set the tone
    # @param value [Tone]
    def tone=(value)
    end
    # Tone of the viewport
    # @return [Tone]
    def tone
    end
  end
end
Graphics.on_start {Viewport.load_configs }
# Class that describe a sprite shown on the screen or inside a viewport
class Sprite < LiteRGSS::ShaderedSprite
  # RGSS Compatibility "update" the sprite
  def update
  end
  # define the superiority of the sprite
  # @param z [Integer] superiority
  # @return [self]
  def set_z(z)
  end
  # define the pixel of the bitmap that is shown at the coordinate of the sprite.
  # The width and the height is divided by ox and oy to determine the pixel
  # @param ox [Numeric] factor of division of width to get the origin x
  # @param oy [Numeric] factor of division of height to get the origin y
  # @return [self]
  def set_origin_div(ox, oy)
  end
  # Define the surface of the bitmap that is shown on the screen surface
  # @param x [Integer] x coordinate on the bitmap
  # @param y [Integer] y coordinate on the bitmap
  # @param width [Integer] width of the surface
  # @param height [Integer] height of the surface
  # @return [self]
  def set_rect(x, y, width, height)
  end
  # Define the surface of the bitmap that is shown with division of it
  # @param x [Integer] the division index to show on x
  # @param y [Integer] the division index to show on y
  # @param width [Integer] the division of width of the bitmap to show
  # @param height [Integer] the division of height of the bitmap to show
  # @return [self]
  def set_rect_div(x, y, width, height)
  end
  # Set the texture show on the screen surface
  # @overload load(filename, cache_symbol)
  #   @param filename [String] the name of the image
  #   @param cache_symbol [Symbol] the symbol method to call with filename argument in RPG::Cache
  #   @param auto_rect [Boolean] if the rect should be automatically set
  # @overload load(bmp)
  #   @param texture [Texture, nil] the bitmap to show
  # @return [self]
  def load(texture, cache = nil, auto_rect = false)
  end
  alias set_bitmap load
  # Define a sprite that mix with a color
  class WithColor < Sprite
    # Create a new Sprite::WithColor
    # @param viewport [LiteRGSS::Viewport, nil]
    def initialize(viewport = nil)
    end
    # Set the Sprite color
    # @param array [Array(Numeric, Numeric, Numeric, Numeric), LiteRGSS::Color] the color (values : 0~1.0)
    # @return [self]
    def color=(array)
    end
    alias set_color color=
  end
end
# @deprecated Please use Sprite directly
class ShaderedSprite < Sprite
end
# Class simulating repeating texture
class Plane < Sprite
  # Shader of the Plane sprite
  SHADER = "// Viewport tone (required)\nuniform vec4 tone;\n// Viewport color (required)\nuniform vec4 color;\n// Zoom configuration\nuniform vec2 zoom;\n// Origin configuration\nuniform vec2 origin;\n// Texture size configuration\nuniform vec2 textureSize;\n// Texture source\nuniform sampler2D texture;\n// Plane Texture (what's zoomed origined etc...)\nuniform sampler2D planeTexture;\n// Screen size\nuniform vec2 screenSize;\n// Gray scale transformation vector\nconst vec3 lumaF = vec3(.299, .587, .114);\n// Main process\nvoid main()\n{\n  // Coordinate on the screen in pixel\n  vec2 screenCoord = gl_TexCoord[0].xy * screenSize;\n  // Coordinaet in the texture in pixel (including zoom)\n  vec2 bmpCoord = mod(origin + screenCoord / zoom, textureSize) / textureSize;\n  vec4 frag = texture2D(planeTexture, bmpCoord);\n  // Tone&Color process\n  frag.rgb = mix(frag.rgb, color.rgb, color.a);\n  float luma = dot(frag.rgb, lumaF);\n  frag.rgb += tone.rgb;\n  frag.rgb = mix(frag.rgb, vec3(luma), tone.w);\n  frag.a *= gl_Color.a;\n  // Result\n  gl_FragColor = frag * texture2D(texture, gl_TexCoord[0].xy);\n}\n"
  # Get the real texture
  # @return [Texture]
  attr_reader :texture
  # Return the visibility of the plane
  # @return [Boolean]
  attr_reader :visible
  # Return the color of the plane /!\ this is unlinked set() won't change the color
  # @return [Color]
  attr_reader :color
  # Return the tone of the plane /!\ this is unlinked set() won't change the color
  # @return [Tone]
  attr_reader :tone
  # Return the blend type
  # @return [Integer]
  attr_reader :blend_type
  # Create a new plane
  # @param viewport [Viewport]
  def initialize(viewport)
  end
  alias working_texture= bitmap=
  alias working_texture bitmap
  # Set the texture of the plane
  # @param texture [Texture]
  def texture=(texture)
  end
  alias bitmap= texture=
  alias bitmap texture
  # Set the visibility of the plane
  # @param visible [Boolean]
  def visible=(visible)
  end
  # Set the zoom of the Plane
  # @param zoom [Float]
  def zoom=(zoom)
  end
  # Set the zoom_x of the Plane
  # @param zoom [Float]
  def zoom_x=(zoom)
  end
  # Get the zoom_x of the Plane
  # @return [Float]
  def zoom_x
  end
  # Set the zoom_y of the Plane
  # @param zoom [Float]
  def zoom_y=(zoom)
  end
  # Get the zoom_y of the Plane
  # @return [Float]
  def zoom_y
  end
  # Set the origin of the Plane
  # @param ox [Float]
  # @param oy [Float]
  def set_origin(ox, oy)
  end
  # Set the ox of the Plane
  # @param origin [Float]
  def ox=(origin)
  end
  # Get the ox of the Plane
  # @return [Float]
  def ox
  end
  # Set the oy of the Plane
  # @param origin [Float]
  def oy=(origin)
  end
  # Get the oy of the Plane
  # @return [Float]
  def oy
  end
  # Set the color of the Plane
  # @param color [Color]
  def color=(color)
  end
  # Set the tone of the Plane
  # @param tone [Tone]
  def tone=(tone)
  end
  # Set the blend type
  # @param blend_type [Integer]
  def blend_type=(blend_type)
  end
  class << self
    # Get the generic plane texture
    # @return [Texture]
    def texture
    end
  end
  undef x
  undef x=
  undef y
  undef y=
  undef set_position
end
# Class that describes a text shown on the screen or inside a viewport
class Text < LiteRGSS::Text
end
# Class used to show a Window object on screen.
#
# A Window is an object that has a frame (built from #window_builder and #windowskin) and some contents that can be Sprites or Texts.
class Window < LiteRGSS::Window
end
# Class allowing to draw Shapes in a viewport
class Shape < LiteRGSS::Shape
end
# Class that allow to draw tiles on a row
class SpriteMap < LiteRGSS::SpriteMap
end
module LiteRGSS
  module Fonts
    @line_heights = []
    class << self
      # Load a line height for a specific font
      # @param font_id [Integer] ID of the font
      # @param line_height [Integer] new line height for the font
      def load_line_height(font_id, line_height)
      end
      # Get the line height for a specific font
      # @param font_id [Integer] ID of the font
      # @return [Integer]
      def line_height(font_id)
      end
    end
  end
end
# Alias access to the Fonts module
Fonts = LiteRGSS::Fonts
Graphics.on_start do
  Configs.texts.fonts.ttf_files.each do |ttf_file|
    id = ttf_file[:id]
    LiteRGSS::Fonts.load_font(id, "Fonts/#{ttf_file[:name]}.ttf")
    LiteRGSS::Fonts.set_default_size(id, ttf_file[:size])
    LiteRGSS::Fonts.load_line_height(id, ttf_file[:lineHeight])
  end
  Configs.texts.fonts.alt_sizes.each do |size|
    id = size[:id]
    LiteRGSS::Fonts.set_default_size(id, size[:size])
    LiteRGSS::Fonts.load_line_height(id, size[:lineHeight])
  end
end
# Shader loaded applicable to a Sprite/Viewport or Graphics
#
# Special features:
#   Shader.register(name_sym, frag_file, vert_file = nil, tone_process: false, color_process: false, alpha_process: false)
#     This function registers a shader as name name_sym
#       if frag_file contains `void main()` it'll assume its the file contents of the shader
#       otherwise it'll assume it's the filename and load it from disc
#       if vert_file is nil, it won't load the vertex shader
#       if vert_file contains `void main()` it'll assume it's the file contents of the shader
#       otherwise it'll assume it's the filename and load it from disc
#       tone_process adds tone process to the shader (fragment color needs to be called frag), it'll add the required constant and uniforms (tone)
#       color_process adds the color process to the shader (fragment color needs to be called frag), it'll add the required uniforms (color)
#       alpha_process adds the alpha process to the shader (fragment color needs to be called frag), it'll use gl_Color.a
#   Shader.create(name_sym)
#     This function instanciate a shader by it's name_sym so you don't have to load the files several time and you have all the correct data
# @note `#version 120` will be automatically added to the begining of the file if not present
class Shader < LiteRGSS::Shader
  # Shader version based on the platform
  SHADER_VERSION = PSDK_PLATFORM == :macos ? "#version 120\n" : "#version 130\n"
  # Color uniform
  COLOR_UNIFORM = "\\0uniform vec4 color;\n"
  # Color process
  COLOR_PROCESS = "\n  frag.rgb = mix(frag.rgb, color.rgb, color.a);\\0"
  # Tone uniform
  TONE_UNIFORM = "\\0uniform vec4 tone;\nconst vec3 lumaF = vec3(.299, .587, .114);\n"
  # Tone process
  TONE_PROCESS = "\n  float luma = dot(frag.rgb, lumaF);\n  frag.rgb = mix(frag.rgb, vec3(luma), tone.w);\n  frag.rgb += tone.rgb;\\0"
  # Alpha process
  ALPHA_PROCESS = "\n  frag.a *= gl_Color.a;\\0"
  # Default shader when there's nothing to do
  DEFAULT_SHADER = "#{SHADER_VERSION}\nuniform sampler2D texture;\nvoid main() {\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  gl_FragColor = frag;\n}\n"
  # Part detecting the shader code begin
  SHADER_CONTENT_DETECTION = 'void main()'
  # Part detecting the shader version pre-processor
  SHADER_VERSION_DETECTION = '#version '
  # Part responsive of detecting where to add the processes
  SHADER_FRAG_FEATURE_ADD = /\n( |)+gl_FragColor( |)+=/
  # Part responsive of detecting where to add the uniforms
  SHADER_UNIFORM_ADD = /\#version[^\n]+\n/
  @registered_shaders = {}
  class << self
    # Register a new shader by it's name
    # @param name_sym [Symbol] name of the shader
    # @param frag_file [String] file content or filename of the frag shader, the function will look at void main() to know
    # @param vert_file [String] file content or filename of the vertex shader, the function will look at void main() to know
    # @param tone_process [Boolean] if the function should add tone_process to the shader
    # @param color_process [Boolean] if the function should add color_process to the shader
    # @param alpha_process [Boolean] if the function should add alpha_process to the shader
    def register(name_sym, frag_file, vert_file = nil, tone_process: false, color_process: false, alpha_process: false)
    end
    # Function that creates a shader by its name
    # @param name_sym [Symbol] name of the shader
    # @return [Shader]
    def create(name_sym)
    end
    # Load a shader data from a file
    # @param filename [String] name of the file in Graphics/Shaders
    # @return [String] the shader string
    def load_to_string(filename)
    end
    private
    # Function that loads the shader file
    # @param filecontent_or_name [String]
    # @return [String]
    def load_shader_file(filecontent_or_name)
    end
    # Function that adds the color processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_color(shader)
    end
    # Function that adds the tone processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_tone(shader)
    end
    # Function that adds the alpha processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_alpha(shader)
    end
  end
  safe_code('Default shader loading') do
    Graphics.on_start do
      background_color_shader = DEFAULT_SHADER.sub(SHADER_FRAG_FEATURE_ADD, "\n  frag.a = max(frag.a, color.a);\\0")
      register(:map_shader, background_color_shader, tone_process: true, color_process: true)
      register(:tone_shader, DEFAULT_SHADER, tone_process: true, alpha_process: true)
      register(:color_shader, DEFAULT_SHADER, color_process: true, alpha_process: true)
      register(:color_shader_with_background, background_color_shader, color_process: true, alpha_process: true)
      register(:full_shader, DEFAULT_SHADER, tone_process: true, color_process: true, alpha_process: true)
      register(:yuki_circular, 'graphics/shaders/yuki_transition_circular.txt')
      register(:yuki_directed, 'graphics/shaders/yuki_transition_directed.txt')
      register(:yuki_weird, 'graphics/shaders/yuki_transition_weird.txt')
      register(:blur, 'graphics/shaders/blur.txt')
      register(:battle_shadow, 'graphics/shaders/battle_shadow.frag', 'graphics/shaders/battle_shadow.vert')
      register(:battle_backout, 'graphics/shaders/battle_backout.frag')
      register(:graphics_transition, Graphics::TRANSITION_FRAG_SHADER)
      register(:graphics_transition_static, Graphics::STATIC_TRANSITION_FRAG_SHADER)
      register(:fake_3d, 'graphics/shaders/fake_3d.frag', 'graphics/shaders/fake_3d.vert') if Fake3D::ENABLED
    end
  end
end
# Module holding the core logic for Fake3D
module Fake3D
  # Constant to set to true if you intent on using Fake3D in your project
  ENABLED = false
  # Module to prepend to one of your Sprite class to make them Fake3D able
  module Sprite3D
    def initialize(viewport)
    end
    # Set the z position of the sprite
    # @param z [Numeric]
    def z=(z)
    end
    # Set the position of the sprite
    # @param x [Integer] x position of the sprite (Warning, 0 is most likely the center of the viewport)
    # @param y [Integer] y position of the sprite (Warning, y still goes to the bottom, 0 is most likely the center of the viewport)
    # @param z [Numeric] z position of the sprite (1 is most likely at scale, 2 is smaller, 0 is illegal)
    def set_position(x, y, z = nil)
    end
  end
  # Camera of a Fake3D scene
  #
  # This class is used to help Sprite3D to render at the right position by applying a camera matrix
  class Camera
    # Minimum Z the camera can go
    MIN_Z = 0.1
    # Get the camera pitch
    # @return [Numeric]
    attr_reader :pitch
    # Get the camera yaw
    # @return [Numeric]
    attr_reader :yaw
    # Get the camera roll
    # @return [Numeric]
    attr_reader :roll
    # Check if the camera was updated
    # @return [Boolean]
    attr_reader :was_updated
    # Get the z coordinate of the camera
    # @return [Numeric]
    attr_reader :z
    # Create a new Camera
    # @param viewport [Viewport] viewport used to compute the projection matrix
    def initialize(viewport)
    end
    # Set the camera rotation
    # @param yaw [Integer] angle around axis z
    # @param pitch [Integer] angle around axis y
    # @param roll [Integer] angle around axis x
    def set_rotation(yaw, pitch, roll)
    end
    # Set the camera position
    # @param x [Numeric] x position of the camera
    # @param y [Numeric] y position of the camera
    # @param z [Numeric] z position of the camera (z = 1 => sprite of z = 1 at scale, sprite of z = 2 demi scale, z = 2 => sprite of z = 1 might disappear, sprite of z = 2 at scale)
    def set_position(x, y, z)
    end
    # Get the x coordinate of the camera
    # @return [Numeric]
    def x
    end
    # Get the y coordinate of the camera
    # @return [Numeric]
    def y
    end
    # Apply the camera to a sprite
    # @param sprite [Sprite3D, Array<Sprite3D>]
    def apply_to(sprite)
    end
    private
    # Apply the Z of the camera. Overwrite this method to apply your own z computation
    # @param z [Float]
    def apply_z(z)
    end
    def pitch_yaw_roll(pitch, yaw, roll)
    end
    # @param viewport [Viewport] viewport used to compute the projection matrix
    def projection_matrix(viewport)
    end
    def compute_matrix
    end
  end
end
# @private
module RPG
  class Animation
    attr_accessor :id
    attr_accessor :name
    attr_accessor :animation_name
    attr_accessor :animation_hue
    attr_accessor :position
    attr_accessor :frame_max
    attr_accessor :frames
    attr_accessor :timings
    class Frame
      attr_accessor :cell_max
      attr_accessor :cell_data
    end
    class Timing
      attr_accessor :frame
      attr_accessor :se
      attr_accessor :flash_scope
      attr_accessor :flash_color
      attr_accessor :flash_duration
      attr_accessor :condition
    end
  end
  class AudioFile
    def initialize(name = '', volume = 100, pitch = 100)
    end
    attr_accessor :name
    attr_accessor :volume
    attr_accessor :pitch
  end
  class Class
    class Learning
    end
  end
  class CommonEvent
    attr_accessor :id
    attr_accessor :name
    attr_accessor :trigger
    attr_accessor :switch_id
    attr_accessor :list
  end
  class Enemy
    attr_accessor :id
    attr_accessor :name
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :maxhp
    attr_accessor :str
    attr_accessor :dex
    attr_accessor :agi
    attr_accessor :int
    attr_accessor :atk
    attr_accessor :pdef
    attr_accessor :mdef
    attr_accessor :eva
    attr_accessor :element_ranks
    attr_accessor :state_ranks
    attr_accessor :actions
    attr_accessor :exp
    attr_accessor :gold
    attr_accessor :item_id
    attr_accessor :weapon_id
    attr_accessor :armor_id
    attr_accessor :treasure_prob
    class Action
    end
  end
  class Event
    attr_accessor :id
    attr_accessor :name
    attr_accessor :x
    attr_accessor :y
    attr_accessor :pages
    # Properties dedicated to the MapLinker
    attr_accessor :original_id, :original_map, :offset_x, :offset_y
    class Page
      attr_accessor :condition
      attr_accessor :graphic
      attr_accessor :move_type
      attr_accessor :move_speed
      attr_accessor :move_frequency
      attr_accessor :move_route
      attr_accessor :walk_anime
      attr_accessor :step_anime
      attr_accessor :direction_fix
      attr_accessor :through
      attr_accessor :always_on_top
      attr_accessor :trigger
      attr_accessor :list
      class Condition
        # Return if the page condition is currently valid
        # @param map_id [Integer] ID of the map where the event is
        # @param event_id [Integer] ID of the event
        # @return [Boolean] if the page is valid
        def valid?(map_id, event_id)
        end
        attr_accessor :switch1_valid
        attr_accessor :switch2_valid
        attr_accessor :variable_valid
        attr_accessor :self_switch_valid
        attr_accessor :switch1_id
        attr_accessor :switch2_id
        attr_accessor :variable_id
        attr_accessor :variable_value
        attr_accessor :self_switch_ch
      end
      class Graphic
        attr_accessor :tile_id
        attr_accessor :character_name
        attr_accessor :character_hue
        attr_accessor :direction
        attr_accessor :pattern
        attr_accessor :opacity
        attr_accessor :blend_type
      end
    end
  end
  class EventCommand
    attr_accessor :code
    attr_accessor :indent
    attr_accessor :parameters
  end
  class Map
    def initialize(width, height)
    end
    attr_accessor :tileset_id
    attr_accessor :width
    attr_accessor :height
    attr_accessor :autoplay_bgm
    attr_accessor :bgm
    attr_accessor :autoplay_bgs
    attr_accessor :bgs
    attr_accessor :encounter_list
    attr_accessor :encounter_step
    attr_accessor :data
    attr_accessor :events
  end
  class MapInfo
    attr_accessor :name
    attr_accessor :parent_id
    attr_accessor :order
    attr_accessor :expanded
    attr_accessor :scroll_x
    attr_accessor :scroll_y
  end
  class MoveCommand
    def initialize(code = 0, parameters = [])
    end
    attr_accessor :code
    attr_accessor :parameters
  end
  class MoveRoute
    def initialize
    end
    attr_accessor :repeat
    attr_accessor :skippable
    attr_accessor :list
  end
  class Sprite < ::Sprite
    attr_accessor :blend_type
    attr_accessor :bush_depth
    attr_accessor :tone
    attr_accessor :color
    def flash(*args)
    end
    def color
    end
    def tone
    end
    @@_animations = []
    @@_reference_count = {}
    def initialize(viewport = nil)
    end
    def dispose
    end
    def whiten
    end
    def appear
    end
    def escape
    end
    def collapse
    end
    def damage(value, critical)
    end
    def animation(animation, hit)
    end
    def loop_animation(animation)
    end
    def dispose_damage
    end
    def dispose_animation
    end
    def dispose_loop_animation
    end
    def blink_on
    end
    def blink_off
    end
    def blink?
    end
    def effect?
    end
    def update
    end
    def update_animation
    end
    def update_loop_animation
    end
    def animation_set_sprites(sprites, cell_data, position)
    end
    def animation_process_timing(timing, hit)
    end
    def x=(x)
    end
    def y=(y)
    end
  end
  class System
    attr_accessor :magic_number
    attr_accessor :party_members
    attr_accessor :elements
    attr_accessor :switches
    attr_accessor :variables
    attr_accessor :windowskin_name
    attr_accessor :title_name
    attr_accessor :gameover_name
    attr_accessor :battle_transition
    attr_accessor :title_bgm
    attr_accessor :battle_bgm
    attr_accessor :battle_end_me
    attr_accessor :gameover_me
    attr_accessor :cursor_se
    attr_accessor :decision_se
    attr_accessor :cancel_se
    attr_accessor :buzzer_se
    attr_accessor :equip_se
    attr_accessor :shop_se
    attr_accessor :save_se
    attr_accessor :load_se
    attr_accessor :battle_start_se
    attr_accessor :escape_se
    attr_accessor :actor_collapse_se
    attr_accessor :enemy_collapse_se
    attr_accessor :words
    attr_accessor :test_battlers
    attr_accessor :test_troop_id
    attr_accessor :start_map_id
    attr_accessor :start_x
    attr_accessor :start_y
    attr_accessor :battleback_name
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :edit_map_id
    class TestBattler
      attr_accessor :actor_id
      attr_accessor :level
      attr_accessor :weapon_id
      attr_accessor :armor1_id
      attr_accessor :armor2_id
      attr_accessor :armor3_id
      attr_accessor :armor4_id
    end
    class Words
    end
  end
  class Tileset
    attr_accessor :id
    attr_accessor :name
    attr_accessor :tileset_name
    attr_accessor :autotile_names
    attr_accessor :panorama_name
    attr_accessor :panorama_hue
    attr_accessor :fog_name
    attr_accessor :fog_hue
    attr_accessor :fog_opacity
    attr_accessor :fog_blend_type
    attr_accessor :fog_zoom
    attr_accessor :fog_sx
    attr_accessor :fog_sy
    attr_accessor :battleback_name
    attr_accessor :passages
    attr_accessor :priorities
    attr_accessor :terrain_tags
  end
  class Troop
    attr_accessor :id
    attr_accessor :name
    attr_accessor :members
    attr_accessor :pages
    class Member
      attr_accessor :enemy_id
      attr_accessor :x
      attr_accessor :y
      attr_accessor :hidden
    end
    class Page
      attr_accessor :condition
      attr_accessor :span
      attr_accessor :list
      class Condition
        attr_accessor :turn_valid
        attr_accessor :enemy_valid
        attr_accessor :actor_valid
        attr_accessor :switch_valid
        attr_accessor :turn_a
        attr_accessor :turn_b
        attr_accessor :enemy_index
        attr_accessor :enemy_hp
        attr_accessor :actor_id
        attr_accessor :actor_hp
        attr_accessor :switch_id
      end
    end
  end
  class Actor
    attr_accessor :id
    attr_accessor :name
    attr_accessor :initial_level
    attr_accessor :final_level
    attr_accessor :exp_basis
    attr_accessor :exp_inflation
    attr_accessor :character_name
    attr_accessor :character_hue
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :parameters
    attr_accessor :weapon_id
    attr_accessor :armor1_id
    attr_accessor :armor2_id
    attr_accessor :armor3_id
    attr_accessor :armor4_id
    attr_accessor :weapon_fix
    attr_accessor :armor1_fix
    attr_accessor :armor2_fix
    attr_accessor :armor3_fix
    attr_accessor :armor4_fix
  end
  # Script that cache bitmaps when they are reusable.
  # @author Nuri Yuri
  module Cache
    # Array of load methods to call when the game starts
    LOADS = %i[load_animation load_autotile load_ball load_battleback load_battler load_character load_fog load_icon load_panorama load_particle load_pc load_picture load_pokedex load_title load_tileset load_transition load_interface load_foot_print load_b_icon load_poke_front load_poke_back]
    # Extension of gif files
    GIF_EXTENSION = '.gif'
    # Common filename of the image to load
    Common_filename = 'Graphics/%s/%s'
    # Common filename with .png
    Common_filename_format = format('%s.png', Common_filename)
    # Notification message when an image couldn't be loaded properly
    Notification_title = 'Failed to load graphic'
    # Path where autotiles are stored from Graphics
    Autotiles_Path = 'autotiles'
    # Path where animations are stored from Graphics
    Animations_Path = 'animations'
    # Path where ball are stored from Graphics
    Ball_Path = 'ball'
    # Path where battlebacks are stored from Graphics
    BattleBacks_Path = 'battlebacks'
    # Path where battlers are stored from Graphics
    Battlers_Path = 'battlers'
    # Path where characters are stored from Graphics
    Characters_Path = 'characters'
    # Path where fogs are stored from Graphics
    Fogs_Path = 'fogs'
    # Path where icons are stored from Graphics
    Icons_Path = 'icons'
    # Path where interface are stored from Graphics
    Interface_Path = 'interface'
    # Path where panoramas are stored from Graphics
    Panoramas_Path = 'panoramas'
    # Path where particles are stored from Graphics
    Particles_Path = 'particles'
    # Path where pc are stored from Graphics
    PC_Path = 'pc'
    # Path where pictures are stored from Graphics
    Pictures_Path = 'pictures'
    # Path where pokedex images are stored from Graphics
    Pokedex_Path = 'pokedex'
    # Path where titles are stored from Graphics
    Titles_Path = 'titles'
    # Path where tilesets are stored from Graphics
    Tilesets_Path = 'tilesets'
    # Path where transitions are stored from Graphics
    Transitions_Path = 'transitions'
    # Path where windowskins are stored from Graphics
    Windowskins_Path = 'windowskins'
    # Path where footprints are stored from Graphics
    Pokedex_FootPrints_Path = 'pokedex/footprints'
    # Path where pokeicon are stored from Graphics
    Pokedex_PokeIcon_Path = 'pokedex/pokeicon'
    # Path where pokefront are stored from Graphics
    Pokedex_PokeFront_Path = ['pokedex/pokefront', 'pokedex/pokefrontshiny']
    # Path where pokeback are stored from Graphics
    Pokedex_PokeBack_Path = ['pokedex/pokeback', 'pokedex/pokebackshiny']
    module_function
    # Gets the default bitmap
    # @note Should be used in scripts that require a bitmap be doesn't perform anything on the bitmap
    def default_bitmap
    end
    # Dispose every bitmap of a cache table
    # @param cache_tab [Hash{String => Texture}] cache table where bitmaps should be disposed
    def dispose_bitmaps_from_cache_tab(cache_tab)
    end
    # Test if a file exist
    # @param filename [String] filename of the image
    # @param path [String] path of the image inside Graphics/
    # @param file_data [Yuki::VD] "virtual directory"
    # @return [Boolean] if the image exist or not
    def test_file_existence(filename, path, file_data = nil)
    end
    # Loads an image (from cache, disk or virtual directory)
    # @param cache_tab [Hash{String => Texture}] cache table where bitmaps are being stored
    # @param filename [String] filename of the image
    # @param path [String] path of the image inside Graphics/
    # @param file_data [Yuki::VD] "virtual directory"
    # @param image_class [Class] Texture or Image depending on the desired process
    # @return [Texture]
    # @note This function displays a desktop notification if the image is not found.
    #       The resultat bitmap is an empty 16x16 bitmap in this case.
    def load_image(cache_tab, filename, path, file_data = nil, image_class = Texture)
    end
    # Loads an image from virtual directory with the right encoding
    # @param filename [String] filename of the image
    # @param file_data [Yuki::VD] "virtual directory"
    # @param image_class [Class] Texture or Image depending on the desired process
    # @return [Texture] the image loaded from the virtual directory
    def load_image_from_file_data(filename, file_data, image_class)
    end
    # Load/unload the animation cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_animation(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def animation_exist?(filename)
    end
    # Load an animation image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def animation(filename, _hue = 0)
    end
    # Load/unload the autotile cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_autotile(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def autotile_exist?(filename)
    end
    # Load an autotile image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def autotile(filename, _hue = 0)
    end
    # Load/unload the ball cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_ball(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def ball_exist?(filename)
    end
    # Load ball animation image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def ball(filename, _hue = 0)
    end
    # Load/unload the battleback cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_battleback(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def battleback_exist?(filename)
    end
    # Load a battle back image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def battleback(filename, _hue = 0)
    end
    # Load/unload the battler cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_battler(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def battler_exist?(filename)
    end
    # Load a battler image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def battler(filename, _hue = 0)
    end
    # Load/unload the character cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_character(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def character_exist?(filename)
    end
    # Load a character image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def character(filename, _hue = 0)
    end
    # Load/unload the fog cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_fog(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def fog_exist?(filename)
    end
    # Load a fog image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def fog(filename, _hue = 0)
    end
    # Load/unload the icon cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_icon(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def icon_exist?(filename)
    end
    # Load an icon
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def icon(filename, _hue = 0)
    end
    # Load/unload the interface cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_interface(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def interface_exist?(filename)
    end
    # Load an interface image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def interface(filename, _hue = 0)
    end
    # Load an interface "Image" (to perform some background process)
    # @param filename [String] name of the image in the folder
    # @return [Image]
    def interface_image(filename)
    end
    # Load/unload the panorama cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_panorama(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def panorama_exist?(filename)
    end
    # Load a panorama image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def panorama(filename, _hue = 0)
    end
    # Load/unload the particle cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_particle(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def particle_exist?(filename)
    end
    # Load a particle image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def particle(filename, _hue = 0)
    end
    # Load/unload the pc cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_pc(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def pc_exist?(filename)
    end
    # Load a pc image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def pc(filename, _hue = 0)
    end
    # Load/unload the picture cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_picture(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def picture_exist?(filename)
    end
    # Load a picture image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def picture(filename, _hue = 0)
    end
    # Load/unload the pokedex cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_pokedex(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def pokedex_exist?(filename)
    end
    # Load a pokedex image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def pokedex(filename, _hue = 0)
    end
    # Load/unload the title cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_title(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def title_exist?(filename)
    end
    # Load a title image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def title(filename, _hue = 0)
    end
    # Load/unload the tileset cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_tileset(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def tileset_exist?(filename)
    end
    # Load a tileset image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def tileset(filename, _hue = 0)
    end
    # Load a tileset "Image" (to perform some background process)
    # @param filename [String] name of the image in the folder
    # @return [Image]
    def tileset_image(filename)
    end
    # Load/unload the transition cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_transition(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def transition_exist?(filename)
    end
    # Load a transition image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def transition(filename, _hue = 0)
    end
    # Load/unload the windoskin cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_windowskin(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def windowskin_exist?(filename)
    end
    # Load a windowskin image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def windowskin(filename, _hue = 0)
    end
    # Load/unload the foot print cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_foot_print(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def foot_print_exist?(filename)
    end
    # Load a foot print image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def foot_print(filename, _hue = 0)
    end
    # Load/unload the pokemon icon cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_b_icon(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def b_icon_exist?(filename)
    end
    # Load a Pokemon icon image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def b_icon(filename, _hue = 0)
    end
    # Load/unload the pokemon front cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_poke_front(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @param hue [Integer] if the front is shiny or not
    # @return [Boolean]
    def poke_front_exist?(filename, hue = 0)
    end
    # Load a pokemon face image
    # @param filename [String] name of the image in the folder
    # @param hue [Integer] 0 = normal, 1 = shiny
    # @return [Texture]
    def poke_front(filename, hue = 0)
    end
    # Load/unload the pokemon back cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_poke_back(flush_it = false)
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @param hue [Integer] if the back is shiny or not
    # @return [Boolean]
    def poke_back_exist?(filename, hue = 0)
    end
    # Load a pokemon back image
    # @param filename [String] name of the image in the folder
    # @param hue [Integer] 0 = normal, 1 = shiny
    # @return [Texture]
    def poke_back(filename, hue = 0)
    end
    # Meta defintion of the cache loading without hue (shiny processing)
    Cache_meta_without_hue = "      LOADS << :load_%<cache_name>s\n      %<cache_constant>s_Path = '%<cache_path>s'\n      module_function\n\n      def load_%<cache_name>s(flush_it = false)\n        unless flush_it\n          @%<cache_name>s_cache = {}\n          @%<cache_name>s_data = Yuki::VD.new(PSDK_PATH + '/master/%<cache_name>s', :read)\n        else\n          dispose_bitmaps_from_cache_tab(@%<cache_name>s_cache)\n        end\n      end\n\n      def %<cache_name>s_exist?(filename)\n        test_file_existence(filename, %<cache_constant>s_Path, @%<cache_name>s_data)\n      end\n\n      def %<cache_name>s(filename, _hue = 0)\n        load_image(@%<cache_name>s_cache, filename, %<cache_constant>s_Path, @%<cache_name>s_data)\n      end\n\n      def extract_%<cache_name>s(path = '')\n        path += %<cache_constant>s_Path\n        ori = Dir.pwd\n        Dir.mkdir!(path.downcase)\n        Dir.chdir(path.downcase)\n        @%<cache_name>s_data.get_filenames.each do |filename|\n          if filename.include?('/')\n            dirname = File.dirname(filename)\n            Dir.mkdir!(dirname) unless Dir.exist?(dirname)\n          end\n          was_cached = @%<cache_name>s_cache[filename] != nil\n          bmp = %<cache_name>s(filename)\n          bmp.to_png_file(filename + '.png')\n          bmp.dispose unless was_cached\n        end\n      ensure\n        Dir.chdir(ori)\n      end\n"
    # Meta definition of the cache loading with hue (shiny processing)
    Cache_meta_with_hue = "      LOADS << :load_%<cache_name>s\n      %<cache_constant>s_Path = [%<cache_path>s]\n      module_function\n\n      def load_%<cache_name>s(flush_it = false)\n        unless flush_it\n          @%<cache_name>s_cache = Array.new(%<cache_constant>s_Path.size) { {} }\n          @%<cache_name>s_data = [\n            Yuki::VD.new(PSDK_PATH + '/master/%<cache_name>s', :read),\n            Yuki::VD.new(PSDK_PATH + '/master/%<cache_name>s_s', :read)]\n        else\n          @%<cache_name>s_cache.each { |cache_tab| dispose_bitmaps_from_cache_tab(cache_tab) }\n        end\n      end\n\n      def %<cache_name>s_exist?(filename, hue = 0)\n        test_file_existence(filename, %<cache_constant>s_Path.fetch(hue), @%<cache_name>s_data[hue])\n      end\n\n      def %<cache_name>s(filename, hue = 0)\n        load_image(@%<cache_name>s_cache.fetch(hue), filename, %<cache_constant>s_Path.fetch(hue), @%<cache_name>s_data[hue])\n      end\n\n      def extract_%<cache_name>s(path = '', hue = 0)\n        path += %<cache_constant>s_Path[hue]\n        ori = Dir.pwd\n        Dir.mkdir!(path.downcase)\n        Dir.chdir(path.downcase)\n        @%<cache_name>s_data[hue].get_filenames.each do |filename|\n          if filename.include?('/')\n            dirname = File.dirname(filename)\n            Dir.mkdir!(dirname) unless Dir.exist?(dirname)\n          end\n          was_cached = @%<cache_name>s_cache[hue][filename] != nil\n          bmp = %<cache_name>s(filename, hue)\n          bmp.to_png_file(filename + '.png')\n          bmp.dispose unless was_cached\n        end\n      ensure\n        Dir.chdir(ori)\n      end\n"
    # Execute a meta code generation (undef when done)
    def meta_exec(line, name, constant, path, meta_code = Cache_meta_without_hue)
    end
  end
  # Class that display weather
  class Weather
    # Tone used to simulate the sun weather
    SunnyTone = Tone.new(90, 50, 0, 40)
    # Array containing all the texture initializer in the order of the type
    INIT_TEXTURE = %i[init_rain init_rain init_zenith init_sand_storm init_snow init_fog]
    # Array containing all the weather update methods in the order of the type
    UPDATE_METHODS = %i[update_rain update_rain update_zenith update_sandstorm update_snow update_fog]
    # Methods symbols telling how to set the new type of weather according to the index
    SET_TYPE_METHODS = []
    # Boolean telling if the set_type is managed by PSDK or not
    SET_TYPE_PSDK_MANAGED = []
    # Number of sprite to generate
    MAX_SPRITE = 61
    # Top factor of the max= adjustment (max * top / bottom)
    MAX_TOP = 3
    # Bottom factor of the max= adjustment (max * top / bottom)
    MAX_BOTTOM = 2
    # Return the weather type
    # @return [Integer]
    attr_reader :type
    # Return the max amount of sprites
    # @return [Integer]
    attr_reader :max
    # Return the origin x
    # @return [Numeric]
    attr_reader :ox
    # Return the origin y
    # @return [Numeric]
    attr_reader :oy
    # Create the Weather object
    # @param viewport [Viewport]
    # @note : type 0 = None, 1 = Rain, 2 = Sun/Zenith, 3 = Darud Sandstorm, 4 = Hail, 5 = Foggy
    def initialize(viewport = nil)
    end
    # Update the sprite display
    def update
    end
    # Dispose the interface
    def dispose
    end
    # Update the ox
    # @param ox [Numeric]
    def ox=(ox)
    end
    # Update the oy
    # @param oy [Numeric]
    def oy=(oy)
    end
    # Update the max number of sprites to show
    # @param max [Integer]
    def max=(max)
    end
    # Change the Weather type
    # @param type [Integer]
    def type=(type)
    end
    private
    # Initialize the sprites
    # @param viewport [Viewport]
    def init_sprites(viewport)
    end
    # Create the sand_storm bitmap
    def init_sand_storm
    end
    # Create the rain bitmap
    def init_rain
    end
    # Create the snow bitmap
    def init_snow
    end
    # Initialize the zenith stuff
    def init_zenith
    end
    # Initialize the fog bitmap
    def init_fog
    end
    # Set the weather type as rain (special animation)
    def set_type_rain
    end
    # Set the weather type as sandstorm (different bitmaps)
    def set_type_sandstorm
    end
    # Called when type= is called with snow id
    def set_type_snow
    end
    # Called when type= is called with 0
    def set_type_none
    end
    # Called when type= is called with sunny id
    def set_type_sunny
    end
    # Set the weather type as fog
    def set_type_fog
    end
    # Reset the sprite when type= is called (and it's managed)
    # @param bitmap [Texture]
    def set_type_reset_sprite(bitmap)
    end
    # Update the rain weather
    def update_rain
    end
    # Update the sunny weather
    def update_zenith
    end
    # Update the sandstorm weather
    def update_sandstorm
    end
    # Update the snow weather
    def update_snow
    end
    # Update the fog weather
    def update_fog
    end
    class << self
      # Register a new type= method call
      # @param type [Integer] the type of weather
      # @param symbol [Symbol] if the name of the method to call
      # @param psdk_managed [Boolean] if it's managed by PSDK (some specific code in the type= method)
      def register_set_type(type, symbol, psdk_managed)
      end
    end
    register_set_type(0, :set_type_none, true)
    register_set_type(1, :set_type_rain, true)
    register_set_type(2, :set_type_sunny, true)
    register_set_type(3, :set_type_sandstorm, true)
    register_set_type(4, :set_type_snow, true)
    register_set_type(5, :set_type_fog, true)
  end
end
# Module responsive of handling audio in game
module Audio
  # Base class for all audio drivers (mainly definition)
  class DriverBase
    @@logged_audio_filenames = []
    # List of the Audio extension that are supported
    AUDIO_FILENAME_EXTENSIONS = ['.ogg', '.mp3', '.wav', '.flac']
    # Update the driver (must be called every meaningful frames)
    def update
    end
    # Reset the driver
    def reset
    end
    # Release the driver
    def release
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    def play_music(channel, filename, volume, pitch, fade_with_previous)
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
    end
    private
    # Load an Audio file content
    # @param filename [String]
    # @return [String, nil]
    def try_load(filename)
    end
    # Find the audio filename
    # @param filename [String]
    # @return [String]
    def search_audio_filename(filename)
    end
    # Get all the supported extensions
    # @return [Array<String>]
    def audio_filename_extensions
    end
  end
  @known_drivers = {default: DriverBase}
  @selected_driver = :default
  module_function
  # Globally initialize the audio module (after all driver has been chosen and the game was loaded)
  def __init__
  end
  # Globally release the audio module (after the game is done or if you need to swap drivers)
  def __release__
  end
  # Globally reset the audio (when soft resetting the game or for other reasons)
  def __reset__
  end
  # Update the audio (must be called every meaningful frames)
  def update
  end
  # Get the current driver
  # @return [DriverBase]
  def driver
  end
  # Register an audio driver
  # @param driver_name [Symbol] name of the driver
  # @param driver_class [Class<DriverBase>] driver class (to instanciate when chosen)
  def register_driver(driver_name, driver_class)
  end
  public
  @music_volume = 100
  @sfx_volume = 100
  module_function
  # Get volume of bgm and me
  # @return [Integer] a value between 0 and 100
  def music_volume
  end
  # Set the volume of bgm and me
  # @param value [Integer] a value between 0 and 100
  def music_volume=(value)
  end
  # Get all the music channels (to patch if you want to include more)
  # @return [Array<Symbol>]
  def music_channels
  end
  # Get volume of sfx
  # @return [Integer] a value between 0 and 100
  def sfx_volume
  end
  # Set the volume of sfx
  # @param value [Integer] a value between 0 and 100
  def sfx_volume=(value)
  end
  # Get all the sfx channels (to patch if you want to include more)
  # @return [Array<Symbol>]
  def sfx_channels
  end
  public
  # Constant allowing maker to define if music must fade in by default
  FADE_IN_BY_DEFAULT = true
  module_function
  # plays a BGM and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the BGM between 0 and 100
  # @param pitch [Integer] speed of the BGM in percent
  # @param fade_in [Boolean, Integer] if the BGM fades in when different (or time in ms)
  def bgm_play(filename, volume = 100, pitch = 100, fade_in = FADE_IN_BY_DEFAULT)
  end
  # Returns the BGM position
  # @return [Integer]
  def bgm_position
  end
  # Set the BGM position
  # @param position [Integer]
  def bgm_position=(position)
  end
  # Fades the BGM
  # @param time [Integer] fade time in ms
  def bgm_fade(time)
  end
  # Stop the BGM
  def bgm_stop
  end
  # plays a BGS and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the BGS between 0 and 100
  # @param pitch [Integer] speed of the BGS in percent
  # @param fade_in [Boolean, Integer] if the BGS fades in when different (or time in ms)
  def bgs_play(filename, volume = 100, pitch = 100, fade_in = FADE_IN_BY_DEFAULT)
  end
  # Returns the BGS position
  # @return [Integer]
  def bgs_position
  end
  # Set the BGS position
  # @param position [Integer]
  def bgs_position=(position)
  end
  # Fades the BGS
  # @param time [Integer] fade time in ms
  def bgs_fade(time)
  end
  # Stop the BGS
  def bgs_stop
  end
  # plays a ME and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the ME between 0 and 100
  # @param pitch [Integer] speed of the ME in percent
  # @param preserve_bgm [Boolean] if the bgm should not be paused
  def me_play(filename, volume = 100, pitch = 100, preserve_bgm = false)
  end
  # Returns the ME position
  # @return [Integer]
  def me_position
  end
  # Set the ME position
  # @param position [Integer]
  def me_position=(position)
  end
  # Fades the ME
  # @param time [Integer] fade time in ms
  def me_fade(time)
  end
  # Stop the ME
  def me_stop
  end
  # plays a SE if possible
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the SE between 0 and 100
  # @param pitch [Integer] speed of the SE in percent
  def se_play(filename, volume = 100, pitch = 100)
  end
  # Stop SE
  def se_stop
  end
  # plays a cry
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the SE between 0 and 100
  # @param pitch [Integer] speed of the SE in percent
  def cry_play(filename, volume = 100, pitch = 100)
  end
  public
  class SFMLAudioDriver < DriverBase
    # Create a new SFML Audio Driver
    def initialize
    end
    # Reset the driver
    def reset
    end
    # Release the driver
    def release
    end
    # Update the driver
    def update
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    def play_music(channel, filename, volume, pitch, fade_with_previous)
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
    end
    private
    # Automatically loop an audio
    # @param music [SFMLAudio::Music]
    # @param memory [String] audio file content
    def auto_loop(music, memory)
    end
    # Update a fading operation
    # @param channel [Symbol]
    # @param start_time [Time]
    # @param volume [Float]
    # @param duration [Float]
    # @return [Boolean] if the sound should be stopped
    def update_fade(channel, start_time, volume, duration)
    end
    # Update a mute operation
    # @param channel [Symbol]
    # @param end_mute [Time]
    def update_mute(channel, end_mute)
    end
    # Get the SE sound
    # @param filename [String]
    # @return [SFMLAudio::Sound]
    def get_se_sound(filename)
    end
  end
  register_driver(:sfml, SFMLAudioDriver) if Object.const_defined?(:SFMLAudio)
  public
  class FMODDriver < DriverBase
    # List of the Audio extension that are supported
    AUDIO_FILENAME_EXTENSIONS = ['.ogg', '.mp3', '.wav', '.mid', '.aac', '.wma', '.it', '.xm', '.mod', '.s3m', '.midi', '.flac']
    # List of Audio Priorities (if not found => 128)
    AUDIO_PRIORITIES = {bgm: 0, me: 1, bgs: 2, se: 250, cries: 249}
    # Time of the audio fade in
    FADE_IN_TIME = 250
    @@BUG_FMOD_INITIALIZED = false
    # Create a new FMOD driver
    def initialize
    end
    # Update the driver (must be called every meaningful frames)
    def update
    end
    # Reset the driver
    def reset
    end
    # Release the driver
    def release
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    def play_music(channel, filename, volume, pitch, fade_with_previous)
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
    end
    private
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    def play_music_internal(channel, filename, volume, pitch, fade_with_previous)
    end
    # Play a ME
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_me_sound(filename, volume, pitch)
    end
    # Play a SE
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_se_sound(filename, volume, pitch)
    end
    # Get all the supported extensions
    # @return [Array<String>]
    def audio_filename_extensions
    end
    # Auto loop a music
    # @param sound [FMOD::Sound] the sound that contain the data
    # @note Only works with createSound and should be called before the channel creation
    def auto_loop(sound)
    end
    # Fade a channel
    # @param time [Integer] number of miliseconds to perform the fade
    # @param channel [FMOD::Channel] the channel to fade
    # @param start_value [Numeric]
    # @param end_value [Numeric]
    def fade(time, channel, start_value = 1.0, end_value = 0)
    end
    # Try to release all fading sounds that are done fading
    # @param additionnal_sound [FMOD::Sound, nil] a sound that should be released with the others
    # @note : Warning ! Doing sound.release before channel.anything make the channel invalid and raise an FMOD::Error
    def release_fading_sounds(additionnal_sound)
    end
    # Return if the channel time is higher than the stop time
    # @note will return true if the channel handle is invalid
    # @param channel [FMOD::Channel]
    # @return [Boolean]
    def channel_stop_time_exceeded(channel)
    end
    # Synchronize a mutex
    # @param mutex [Mutex] the mutex to safely synchronize
    # @param block [Proc] the block to call
    def synchronize(mutex, &block)
    end
    # Create a bgm sound used to play the BGM
    # @param filename [String] the correct filename of the sound
    # @param flags [Integer, nil] the FMOD flags for the creation
    # @return [FMOD::Sound] the sound
    def create_sound_sound(filename, flags = nil)
    end
    # Return the expected flag for create_sound_sound
    # @param flags [Integer, nil] the FMOD flags for the creation
    # @return [Integer]
    def create_sound_get_flags(flags)
    end
    # Function that detects if the previous playing sound is the same as the next one
    # @param filename [String] the filename of the sound
    # @param old_filename [String] the filename of the old sound
    # @param sound [FMOD::Sound] the previous playing sound
    # @param channel [FMOD::Channel, nil] the previous playing channel
    # @param fade_out [Boolean, Integer] if the channel should fades out (Integer = time to fade)
    # @note If the sound wasn't the same, the channel will be stopped if not nil
    # @return [Boolean]
    def was_sound_previously_playing?(filename, old_filename, sound, channel, fade_out = false)
    end
    # Adjust channel volume and pitch
    # @param channel [Fmod::Channel]
    # @param channel_type [Symbol]
    # @param volume [Numeric] target volume
    # @param pitch [Numeric] target pitch
    def adjust_channel(channel, channel_type, volume, pitch)
    end
    # Automatically call the "was playing callback"
    def call_was_playing_callback
    end
  end
  register_driver(:fmod, FMODDriver) if Object.const_defined?(:FMOD)
end
# Module that defines every data class, data reader module or constants
module GameData
  # Module that contain the ids of every SystemTag
  # @author Nuri Yuri
  module SystemTags
    module_function
    # Generation of the SystemTag id
    # @param x [Integer] X coordinate of the SystemTag on the w_prio tileset
    # @param y [Integer] Y coordinate of the SystemTag on the w_prio tileset
    def gen(x, y)
    end
    # SystemTag that is used to remove the effet of SystemTags like TSea or TPond.
    Empty = gen 0, 0
    # Ice SystemTag, every instance of Game_Character slide on it.
    TIce = gen 1, 0
    # Grass SystemTag, used to display grass particles and start Wild Pokemon Battle.
    TGrass = gen 5, 0
    # Taller grass SystemTag, same purpose as TGrass.
    TTallGrass = gen 6, 0
    # Cave SystemTag, used to start Cave Wild Pokemon Battle.
    TCave = gen 7, 0
    # Mount SystemTag, used to start Mount Wild Pokemon Battle.
    TMount = gen 5, 1
    # Sand SystemTag, used to start Sand Pokemon Battle.
    TSand = gen 6, 1
    # Wet sand SystemTag, used to display a particle when walking on it, same purpose as TSand.
    TWetSand = gen 2, 0
    # Define a tile that acts like a puddle
    Puddle = gen 3, 2
    # Pond SystemTag, used to start Pond/River Wild Pokemon Battle.
    TPond = gen 7, 1
    # Sea SystemTag, used to start Sea/Ocean Wild Pokemon Battle.
    TSea = gen 5, 2
    # Under water SystemTag, used to start Under water Wild Pokemon Battle.
    TUnderWater = gen 6, 2
    # Define a tag that acts like a whirlpool
    Whirlpool = gen 5, 7
    # Snow SystemTag, used to start Snow Wild Pokemon Battle.
    TSnow = gen 7, 2
    # SystemTag that is used by the pathfinding system as a road.
    Road = gen 7, 5
    # Defines a Ledge SystemTag where you can jump to the right.
    JumpR = gen 0, 1
    # Defines a Ledge SystemTag where you can jump to the left.
    JumpL = gen 0, 2
    # Defines a Ledge SystemTag where you can jump down.
    JumpD = gen 0, 3
    # Defines a Ledge SystemTag where you can jump up.
    JumpU = gen 0, 4
    # Defines a WaterFall (aid for events).
    WaterFall = gen 3, 0
    # Define a HeadButt tile
    HeadButt = gen 4, 0
    # Defines a tile that force the player to move left.
    RapidsL = gen 1, 1
    # Defines a tile that force the player to move down.
    RapidsD = gen 2, 1
    # Defines a tile that force the player to move up.
    RapidsU = gen 3, 1
    # Defines a tile that force the player to move Right.
    RapidsR = gen 4, 1
    # Defines a Swamp tile.
    SwampBorder = gen 5, 4
    # Defines a Swamp tile that is deep (player can be stuck).
    DeepSwamp = gen 6, 4
    # Defines a upper left stair.
    StairsL = gen 1, 4
    # Defines a up stair when player moves up.
    StairsD = gen 2, 4
    # Defines a up stair when player moves down.
    StairsU = gen 3, 4
    # Defines a upper right stair.
    StairsR = gen 4, 4
    # Defines the left slope
    SlopesL = gen 7, 3
    # Defines the right slope
    SlopesR = gen 7, 4
    # Defines a Ledge "passed through" by bunny hop (Acro bike).
    AcroBike = gen 6, 3
    # Defines a bike bridge that only allow right and left movement (and up down jump with acro bike).
    AcroBikeRL = gen 4, 3
    # Same as AcroBikeRL but up and down with right and left jump.
    AcroBikeUD = gen 3, 3
    # Defines a tile that require high speed to pass through (otherwise you fall down).
    MachBike = gen 5, 3
    # Defines a tile that require high speed to not fall in a Hole.
    CrackedSoil = gen 1, 3
    # Defines a Hole tile.
    Hole = gen 2, 3
    # Defines a bridge (crossed up down).
    BridgeUD = gen 2, 2
    # Defines a bridge (crossed right/left).
    BridgeRL = gen 4, 2
    # Define tiles that change the z property of a Game_Character.
    ZTag = [gen(0, 5), gen(1, 5), gen(2, 5), gen(3, 5), gen(4, 5), gen(5, 5), gen(6, 5)]
    # Defines a tile that force the character to move left until he hits a wall.
    RocketL = gen 0, 6
    # Defines a tile that force the character to move down until he hits a wall.
    RocketD = gen 1, 6
    # Defines a tile that force the character to move up until he hits a wall.
    RocketU = gen 2, 6
    # Defines a tile that force the character to move Right until he hits a wall.
    RocketR = gen 3, 6
    # Defines a tile that force the character to move left until he hits a wall. (With Rotation)
    RocketRL = gen 4, 6
    # Defines a tile that force the character to move down until he hits a wall. (With Rotation)
    RocketRD = gen 5, 6
    # Defines a tile that force the character to move up until he hits a wall. (With Rotation)
    RocketRU = gen 6, 6
    # Defines a tile that force the character to move Right until he hits a wall. (With Rotation)
    RocketRR = gen 7, 6
    # Defines a tile that force the character to be stopped when sliding on it
    StopSlide = gen 1, 2
    # Gives the db_symbol of the system tag
    # @param system_tag [Integer]
    # @return [Symbol]
    def system_tag_db_symbol(system_tag)
    end
  end
end
module Yuki
  # Class that helps to read Virtual Directories
  #
  # In reading mode, the Virtual Directories can be loaded to RAM if MAX_SIZE >= VD.size
  #
  # All the filenames inside the Yuki::VD has to be downcased filename in utf-8
  #
  # Note : Encryption is up to the developper and no longer supported on the basic script
  class VD
    # @return [String] the filename of the current Yuki::VD
    attr_reader :filename
    # Is the debug info on ?
    DEBUG_ON = ARGV.include?('debug-yuki-vd')
    # The max size of the file that can be loaded in memory
    MAX_SIZE = 10 * 1024 * 1024
    # 10Mo
    # List of allowed modes
    ALLOWED_MODES = %i[read write update]
    # Size of the pointer at the begin of the file
    POINTER_SIZE = 4
    # Unpack method of the pointer at the begin of the file
    UNPACK_METHOD = 'L'
    # Create a new Yuki::VD file or load it
    # @param filename [String] name of the Yuki::VD file
    # @param mode [:read, :write, :update] if we read or write the virtual directory
    def initialize(filename, mode)
    end
    # Read a file data from the VD
    # @param filename [String] the file we want to read its data
    # @return [String, nil] the data of the file
    def read_data(filename)
    end
    # Test if a file exists in the VD
    # @param filename [String]
    # @return [Boolean]
    def exists?(filename)
    end
    # Write a file with its data in the VD
    # @param filename [String] the file name
    # @param data [String] the data of the file
    def write_data(filename, data)
    end
    # Add a file to the Yuki::VD
    # @param filename [String] the file name
    # @param ext_name [String, nil] the file extension
    def add_file(filename, ext_name = nil)
    end
    # Get all the filename
    # @return [Array<String>]
    def get_filenames
    end
    # Close the VD
    def close
    end
    private
    # Initialize the Yuki::VD in read mode
    def initialize_read
    end
    # Load the VD in the memory
    # @param size [Integer] size of the VD memory
    def load_whole_file(size)
    end
    # Initialize the Yuki::VD in write mode
    def initialize_write
    end
    # Initialize the Yuki::VD in update mode
    def initialize_update
    end
    # Fix the input mode in case it's a String
    # @param mode [Symbol, String]
    # @return [Symbol] one of the value of ALLOWED_MODES
    def fix_mode(mode)
    end
  end
end
# Module that helps to convert stuff
module Converter
  module_function
  # Convert an autotile file to a specific autotile file
  # @param filename [String]
  # @example Converter.convert_autotile("Graphics/autotiles/eauca.png")
  def convert_autotile(filename)
  end
  # The autotile builder data
  Autotiles = [[[27, 28, 33, 34], [5, 28, 33, 34], [27, 6, 33, 34], [5, 6, 33, 34], [27, 28, 33, 12], [5, 28, 33, 12], [27, 6, 33, 12], [5, 6, 33, 12]], [[27, 28, 11, 34], [5, 28, 11, 34], [27, 6, 11, 34], [5, 6, 11, 34], [27, 28, 11, 12], [5, 28, 11, 12], [27, 6, 11, 12], [5, 6, 11, 12]], [[25, 26, 31, 32], [25, 6, 31, 32], [25, 26, 31, 12], [25, 6, 31, 12], [15, 16, 21, 22], [15, 16, 21, 12], [15, 16, 11, 22], [15, 16, 11, 12]], [[29, 30, 35, 36], [29, 30, 11, 36], [5, 30, 35, 36], [5, 30, 11, 36], [39, 40, 45, 46], [5, 40, 45, 46], [39, 6, 45, 46], [5, 6, 45, 46]], [[25, 30, 31, 36], [15, 16, 45, 46], [13, 14, 19, 20], [13, 14, 19, 12], [17, 18, 23, 24], [17, 18, 11, 24], [41, 42, 47, 48], [5, 42, 47, 48]], [[37, 38, 43, 44], [37, 6, 43, 44], [13, 18, 19, 24], [13, 14, 43, 44], [37, 42, 43, 48], [17, 18, 47, 48], [13, 18, 43, 48], [1, 2, 7, 8]]]
  # The source rect (to draw autotiles)
  SRC = Rect.new(0, 0, 16, 16)
  # Generate one tile of an autotile
  # @param id [Integer] id of the tile
  # @param autotiles [Array<Texture>] autotiles bitmaps
  # @return [Texture] the calculated bitmap
  def generate_autotile_bmp(id, autotiles)
  end
end
Graphics.on_start do
  RPG::Cache::LOADS.each do |k|
    RPG::Cache.send(k)
  end
  RPG::Cache.instance_eval do
    undef meta_exec
    remove_const :Cache_meta_without_hue
    remove_const :Cache_meta_with_hue
  end
end
