# Module that holds every UI object
module UI
  # Class that helps to define a single object constitued of various sprites.
  # With this class you can move the sprites as a single sprite, change the data that generate the sprites and some other cool stuff
  class SpriteStack
    # Constant specifiying the sprite will have no image during initialization
    NO_INITIAL_IMAGE = nil
    # X coordinate of the sprite stack
    # @return [Numeric]
    attr_reader :x
    # Y coordinate of the sprite stack
    # @return [Numeric]
    attr_reader :y
    # Data used by the sprites of the sprite stack to generate themself
    attr_reader :data
    # Get the stack
    attr_reader :stack
    # Get the viewport
    # @return [Viewport]
    attr_reader :viewport
    # Create a new Sprite stack
    # @param viewport [Viewport] the viewport where the sprites will be shown
    # @param x [Numeric] the x position of the sprite stack
    # @param y [Numeric] the y position of the sprite stack
    # @param default_cache [Symbol] the RPG::Cache function to call when setting the bitmap
    def initialize(viewport, x = 0, y = 0, default_cache: :interface)
    end
    # Push a sprite to the stack
    # @param x [Numeric] the relative x position of the sprite in the stack (sprite.x = stack.x + x)
    # @param y [Numeric] the relative y position of the sprite in the stack (sprite.y = stack.y + y)
    # @param args [Array] the arguments after the viewport argument of the sprite to create the sprite
    # @param rect [Array, nil] the src_rect.set arguments if required
    # @param type [Class] the class to use to generate the sprite
    # @param ox [Numeric] the ox of the sprite
    # @param oy [Numeric] the oy of the sprite
    # @return [Sprite] the pushed sprite
    def push(x, y, bmp, *args, rect: nil, type: Sprite, ox: 0, oy: 0)
    end
    alias add_sprite push
    # Add a text inside the stack, the offset x/y will be adjusted
    # @param x [Integer] the x coordinate of the text surface
    # @param y [Integer] the y coordinate of the text surface
    # @param width [Integer] the width of the text surface
    # @param height [Integer, nil] the height of the text surface (if nil, uses the line_height from sizeid)
    # @param str [String] the text shown by this object
    # @param align [0, 1, 2] the align of the text in its surface (best effort => no resize), 0 = left, 1 = center, 2 = right
    # @param outlinesize [Integer, nil] the size of the text outline
    # @param type [Class] the type of text
    # @param color [Integer] the id of the color
    # @return [Text] the text object
    def add_text(x, y, width, height, str, align = 0, outlinesize = Text::Util::DEFAULT_OUTLINE_SIZE, type: Text, color: nil, sizeid: nil)
    end
    # Push a background image
    # @param filename [String] name of the image in the cache
    # @param rect [Array, nil] the src_rect.set arguments if required
    # @param type [Class] the class to use to generate the sprite
    # @return [Sprite]
    def add_background(filename, type: Sprite, rect: nil)
    end
    alias add_foreground add_background
    # Push a sprite object to the stack
    # @param sprite [Sprite, Text]
    # @return [sprite]
    def push_sprite(sprite)
    end
    alias add_custom_sprite push_sprite
    # Execute push operations with an alternative cache
    #
    # @example
    #   with_cache(:pokedex) { add_background('win_sprite') }
    # @param cache [Symbol] function of RPG::Cache used to load images
    def with_cache(cache)
    end
    # Execute add_text operation with an alternative font
    #
    # @example
    #   with_font(2) { add_text(0, 0, 320, 32, 'Big Text', 1) }
    # @param font_id [Integer] id of the font
    def with_font(font_id)
    end
    # Execute add_line with specific metrics info
    # @example
    #   with_surface(x, y, unit_width, size_id) do
    #     add_line(0, "Centered", 1)
    #     add_line(1, "Left Red", color: 2)
    #     add_line(2, "Right Blue", 2, color: 1)
    #     add_line(0, "Centered on next surface", 1, dx: 1)
    #   end
    # @param x [Integer] X position of the surface
    # @param y [Integer] Y position of the surface
    # @param unit_width [Integer] Width of the line (for alignment and offset x)
    # @param size_id [Integer] Size to use to get the right metrics
    # @param offset_width [Integer] offset between each columns when dx: is used
    def with_surface(x, y, unit_width, size_id = 0, offset_width = 2)
    end
    # Add a text inside the stack using metrics given by with_surface
    # @param line_index [Integer] index of the line in the surface
    # @param str [String] the text shown by this object
    # @param align [0, 1, 2] the align of the text in its surface (best effort => no resize), 0 = left, 1 = center, 2 = right
    # @param outlinesize [Integer, nil] the size of the text outline
    # @param type [Class] the type of text
    # @param color [Integer] the id of the color
    # @param dx [Integer] offset x to use "table like" display (this value is multiplied by width)
    # @return [Text] the text object
    def add_line(line_index, str, align = 0, outlinesize = Text::Util::DEFAULT_OUTLINE_SIZE, type: Text, color: nil, dx: 0)
    end
    # Return an element of the stack
    # @param index [Integer] index of the element in the stack
    # @return [Sprite, Text]
    def [](index)
    end
    # Return the size of the stack
    # @return [Integer]
    def size
    end
    alias length size
    # Change the x coordinate of the sprite stack
    # @param value [Numeric] the new value
    def x=(value)
    end
    # Change the y coordinate of the sprite stack
    # @param value [Numeric] the new value
    def y=(value)
    end
    # Change the x and y coordinate of the sprite stack
    # @param x [Numeric] the new x value
    # @param y [Numeric] the new y value
    # @return [self]
    def set_position(x, y)
    end
    # Move the sprite stack
    # @param delta_x [Numeric] number of pixel the sprite stack should be moved in x
    # @param delta_y [Numeric] number of pixel the sprite stack should be moved in y
    # @return [self]
    def move(delta_x, delta_y)
    end
    # Set the origin (does nothing)
    # @param _ox [Integer] new origin x
    # @param _oy [Integer] new origin y
    # @note this function is only for compatibility, it does nothing
    def set_origin(_ox, _oy)
    end
    # If the sprite stack is visible
    # @note Return the visible property of the first sprite
    # @return [Boolean]
    def visible
    end
    # Change the visible property of each sprites
    # @param value [Boolean]
    def visible=(value)
    end
    # Detect if the mouse is in the first sprite of the stack
    # @param mx [Numeric] mouse x coordinate
    # @param my [Numeric] mouse y coordinate
    # @return [Boolean]
    def simple_mouse_in?(mx = Mouse.x, my = Mouse.y)
    end
    # Translate the mouse coordinate to mouse position inside the first sprite of the stack
    # @param mx [Numeric] mouse x coordinate
    # @param my [Numeric] mouse y coordinate
    # @return [Array(Numeric, Numeric)]
    def translate_mouse_coords(mx = Mouse.x, my = Mouse.y)
    end
    # Set the data source of the sprites
    # @param v [Object]
    def data=(v)
    end
    # yield a block on each sprite
    # @param block [Proc]
    def each(&block)
    end
    # Dispose each sprite of the sprite stack and clear the stack
    def dispose
    end
    # >>> Section from Yuki::Sprite <<<
    # If the sprite has a self animation
    # @return [Boolean]
    attr_accessor :animated
    # If the sprite is moving
    # @return [Boolean]
    attr_accessor :moving
    # Update sprite (+move & animation)
    def update
    end
    # Move the sprite to a specific coordinate in a certain amount of frame
    # @param x [Integer] new x Coordinate
    # @param y [Integer] new y Coordinate
    # @param nb_frame [Integer] number of frame to go to the new coordinate
    def move_to(x, y, nb_frame)
    end
    # Update the movement
    def update_position
    end
    # Start an animation
    # @param arr [Array<Array(Symbol, *args)>] Array of message
    # @param delta [Integer] Number of frame to wait between each animation message
    def anime(arr, delta = 1)
    end
    # Update the animation
    # @param no_delta [Boolean] if the number of frame to wait between each animation message is skiped
    def update_animation(no_delta)
    end
    # Force the execution of the n next animation message
    # @note this method is used in animation message Array
    # @param n [Integer] Number of animation message to execute
    def execute_anime(n)
    end
    # Stop the animation
    # @note this method is used in the animation message Array (because animation loops)
    def stop_animation
    end
    # Change the time to wait between each animation message
    # @param v [Integer]
    def anime_delta_set(v)
    end
    # Gets the opacity of the SpriteStack
    # @return [Integer]
    def opacity
    end
    # Sets the opacity of the SpriteStack
    # @param value [Integer] the new opacity value
    def opacity=(value)
    end
    # Gets the z of the SpriteStack
    # @return [Numeric]
    def z
    end
    # Sets the z of the SpriteStack
    def z=(value)
    end
  end
  # Window utility allowing to make Window easilly
  class Window < ::Window
    # Default window skin
    DEFAULT_SKIN = 'message'
    # Create a new Window
    # @param viewport [Viewport] viewport where the window is shown
    # @param x [Integer] X position of the window
    # @param y [Integer] Y position of the window
    # @param width [Integer] Width of the window
    # @param height [Integer] Height of the window
    # @param skin [String] Windowskin used to display the window
    def initialize(viewport, x = 2, y = 2, width = 316, height = 48, skin: DEFAULT_SKIN)
    end
    private
    def initialize_window_internal(x, y, width, height, skin)
    end
    public
    class << self
      # Create a new window from given metrics
      # @param viewport [Viewport] viewport where the window is shown
      # @param x [Integer] x position of the window frame
      # @param y [Integer] y position of the window frame
      # @param width [Integer] width of the window contents
      # @param height [Integer] height of the window contents
      # @param skin [String] windowskin used to draw the window frame:
      # @param position [String] precision of the x/y positioning of the frame
      #   - 'top_left' : y is top side of the frame, x is left side of the frame
      #   - 'top_right' : y is top side of the frame, x is right side of the frame
      #   - 'bottom_left' : y is bottom side of the frame, x is left side of the frame
      #   - 'bottom_right' : y is bottom side of the frame, x is right side of the frame
      #   - 'middle_center' : y is middle height of the frame, x is center of the frame
      def from_metrics(viewport, x, y, width, height, skin: DEFAULT_SKIN, position: 'top_left')
      end
      # Get the Window Builder according to the skin
      # @param skin [String] windowskin used to show the window
      # @return [Array<Integer>] the window builder
      def window_builder(skin)
      end
    end
    # Add a text to the window
    # @see https://psdk.pokemonworkshop.fr/yard/UI/SpriteStack.html#add_text-instance_method UI::SpriteStack#add_text
    def add_text(x, y, width, height, str, align = 0, outlinesize = Text::Util::DEFAULT_OUTLINE_SIZE, type: Text, color: 0)
    end
    # Add a text line to the window
    # @see https://psdk.pokemonworkshop.fr/yard/UI/SpriteStack.html#add_line-instance_method UI::SpriteStack#add_line
    def add_line(line_index, str, align = 0, outlinesize = Text::Util::DEFAULT_OUTLINE_SIZE, type: Text, color: nil, dx: 0)
    end
    # Push a sprite to the window
    # @see https://psdk.pokemonworkshop.fr/yard/UI/SpriteStack.html#push-instance_method UI::SpriteStack#push
    def push(x, y, bmp, *args, rect: nil, type: Sprite, ox: 0, oy: 0)
    end
    # Return the stack of the window if any
    # @return [Array]
    def stack
    end
    # Return the sprite stack used by the window
    # @return [SpriteStack]
    def sprite_stack
    end
    # Load the cursor
    def load_cursor
    end
    private
    # Retrieve the current window_builder
    # @param skin [String]
    # @return [Array]
    def current_window_builder(skin)
    end
  end
  # Class that display a bar on screen using the whole texture to display the bar component
  class Bar
    # Returns the rate of the bar
    # @return [Numeric] 0 ~ 1
    attr_reader :rate
    # Return the data source to get the rate info through data=
    attr_accessor :data_source
    # Create a new bar
    # @param viewport [Viewport] the viewport in which the bar is shown
    # @param x [Integer] the x position of the bar
    # @param y [Integer] the y position of the bar
    # @param bmp [Texture] the texture of the bar (including the bar states)
    # @param bw [Integer] the bar width (progress part)
    # @param bh [Integer] the bar height (progress part)
    # @param bx [Integer] the x position of the bar inside the sprite
    # @param by [Integer] the y position of the bar inside the sprite
    # @param nb_states [Integer] the number of state the bar has
    # @param background_width [Integer] the bar width (background part). Useful if the bar has a different width than its real image
    def initialize(viewport, x, y, bmp, bw, bh, bx, by, nb_states, background_width = nil)
    end
    # Change the rate of the bar
    # @param value [Numeric] 0 ~ 1
    def rate=(value)
    end
    # Change the visible state of the bar
    # @param value [Boolean]
    def visible=(value)
    end
    # Returns the visible state of the bar
    # @return [Boolean]
    def visible
    end
    # Returns the x position of the bar
    # @return [Integer]
    def x
    end
    # Returns the y position of the bar
    # @return [Integer]
    def y
    end
    # Change the x position of the bar
    # @param value [Integer]
    def x=(value)
    end
    # Change the y position of the bar
    # @param value [Integer]
    def y=(value)
    end
    # Change the position of the bar
    # @param x [Integer]
    # @param y [Integer]
    def set_position(x, y)
    end
    # Returns the z position of the bar
    # @return [Integer]
    def z
    end
    # Change the z position of the bar
    # @param value [Numeric]
    def z=(value)
    end
    # Dispose the bar
    def dispose
    end
    # Change the data value (for SpriteStack usage)
    # @param data [Object] the data where we'll call the @data_source to get the actual rate
    def data=(data)
    end
  end
  # Generica base UI for most of the scenes
  class GenericBase < SpriteStack
    # @return [Array<Symbol>] keys shown in the button
    attr_reader :keys
    # @return [Array<String>] the texts shown in the button
    attr_reader :button_texts
    # @return [Array<ControlButton>] the control buttons
    attr_reader :ctrl
    # @return [Sprite]
    attr_reader :background
    # List of key by default
    DEFAULT_KEYS = %i[A X Y B]
    # List of button to hide when a text is shown
    BUTTON_TO_HIDE = 0..2
    # Create a new GenericBase UI
    # @param viewport [Viewport]
    # @param texts [Array<String>] list of texts shown in the ControlButton
    # @param keys [Array<Symbol>] list of keys used in the ControlButton
    # @param hide_background_and_button [Boolean] tell if we don't want to show the button and its bar
    def initialize(viewport, texts = [], keys = DEFAULT_KEYS, hide_background_and_button: false)
    end
    # Set the keys of the buttons
    # @param value [Array<Symbol>] the 4 key to show
    def keys=(value)
    end
    # Set the texts of the buttons
    # @param value [Array<String>]
    def button_texts=(value)
    end
    # Show the "win text" (bottom text giving information to the player)
    # @param text [String] text to show
    def show_win_text(text)
    end
    # Hide the "win text"
    def hide_win_text
    end
    # Tell if the win text is visible
    # @return [Boolean]
    def win_text_visible?
    end
    # Update the background animation
    def update_background_animation
    end
    private
    def create_graphics
    end
    def create_background
    end
    def create_background_animation
    end
    def create_button_background
    end
    # Return the name of the background
    # @return [String]
    def background_filename
    end
    # Return the name of the button background
    # @return [String]
    def button_background_filename
    end
    # Create the control buttons
    def create_control_button
    end
    # Return the win_text and create it if needed
    # @return [Text]
    def win_text
    end
    # Return the list of hidden button when win_text is shown
    # @return [#each]
    def hidden_button_indexes
    end
    # Generic Button used to help the player to know what key he can press
    class ControlButton < SpriteStack
      # Array of button coordinates
      COORDINATES = [[3, 219], [83, 219], [163, 219], [243, 219]]
      # Create a new Button
      # @param viewport [Viewport]
      # @param coords_index [Integer] index of the coordinates to use in order to position the button
      # @param key [Symbol] key to show by default
      def initialize(viewport, coords_index, key)
      end
      # Set the button pressed
      # @param pressed [Boolean] if the button is pressed or not
      def pressed=(pressed)
      end
      alias set_press pressed=
      # Set the text shown by the button
      # @param value [String] text to show
      def text=(value)
      end
      # Set the key shown by the button
      # @param value [Symbol]
      def key=(value)
      end
      private
      # Retrieve the color of the text
      # @param coords_index [Integer] index of the coordinates to use in order to position the button
      # @return [Integer]
      def text_color(coords_index)
      end
      # Retrieve the id of the font used to show the text
      # @return [Integer]
      def text_font
      end
    end
  end
  # Generic base allowing multiple button mode by initilizing it with all the value for keys & texts
  class GenericBaseMultiMode < GenericBase
    # @return [Integer] current mode of the UI
    attr_reader :mode
    # Create a new GenericBase UI
    # @param viewport [Viewport]
    # @param texts [Array<Array<String>>] list of texts shown in the ControlButton
    # @param keys [Array<Array<Symbol>>] list of keys used in the ControlButton
    def initialize(viewport, texts, keys, mode = 0)
    end
    # Set the mode to change the button display
    def mode=(value)
    end
  end
  # Sprite that show the 1st type of the Pokemon
  class Type1Sprite < SpriteSheet
    # Create a new Type Sprite
    # @param viewport [Viewport, nil] the viewport in which the sprite is stored
    # @param from_pokedex [Boolean] if the type is the Pokedex type (other source image)
    def initialize(viewport, from_pokedex = false)
    end
    # Set the Pokemon used to show the type
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
    private
    # Load the graphic resource
    # @param from_pokedex [Boolean] if the type is the Pokedex type (other source image)
    def load_texture(from_pokedex)
    end
    # Retrieve the data source of the type sprite
    # @return [Symbol]
    def data_source
    end
  end
  # Sprite that show the 2nd type of the Pokemon
  class Type2Sprite < Type1Sprite
    private
    # Retrieve the data source of the type sprite
    # @return [Symbol]
    def data_source
    end
  end
  # Class that show a type image using an object that responds to #type
  class TypeSprite < Type1Sprite
    private
    # Retrieve the data source of the type sprite
    # @return [Symbol]
    def data_source
    end
  end
  # Sprite that show the gender of a Pokemon
  class GenderSprite < SpriteSheet
    # Name of the gender image in Graphics/Interface
    IMAGE_NAME = 'battlebar_gender'
    # Create a new Gender Sprite
    # @param viewport [Viewport, nil] the viewport in which the sprite is stored
    def initialize(viewport)
    end
    # Set the Pokemon used to show the gender
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
    private
    # Define the number of gender supported by the resource
    def gender_count
    end
  end
  # Sprite that show the status of a Pokemon
  class StatusSprite < SpriteSheet
    # Name of the image in Graphics/Interface
    IMAGE_NAME = 'statuts'
    # Name of the image in Graphics/Interface
    IMAGE_NAME_DEFAULT = 'statutsen'
    # Number of official states
    STATE_COUNT = 10
    # Create a new Status Sprite
    # @param viewport [Viewport, nil] the viewport in which the sprite is stored
    def initialize(viewport)
    end
    # Set the Pokemon used to show the status
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
  end
  # Sprite that show the hold item if the pokemon is holding an item
  class HoldSprite < Sprite
    # Name of the image in Graphics/Interface
    IMAGE_NAME = 'hold'
    # Create a new Hold Sprite
    # @param viewport [Viewport, nil] the viewport in which the sprite is stored
    def initialize(viewport)
    end
    # Set the Pokemon used to show the hold image
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
  end
  # Sprite that show the actual item held if the Pokemon is holding one
  class RealHoldSprite < Sprite
    # Set the Pokemon used to show the hold image
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
  end
  # Class that show the category of a skill
  class CategorySprite < SpriteSheet
    # Name of the image in Graphics/Interface
    IMAGE_NAME = 'skill_categories'
    # Create a new category sprite
    # @param viewport [Viewport] viewport in which the sprite is shown
    def initialize(viewport)
    end
    # Set the object that responds to #atk_class
    # @param object [#atk_class, nil]
    def data=(object)
    end
    private
    def category_count
    end
  end
  # Class that show the face sprite of a Pokemon
  class PokemonFaceSprite < Sprite
    # Create a new Pokemon FaceSprite
    # @param viewport [Viewport] Viewport in which the sprite is shown
    # @param auto_align [Boolean] if the sprite auto align itself (sets its own ox/oy when data= is called)
    def initialize(viewport, auto_align = true)
    end
    # Set the pokemon
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
    # Update the face sprite
    def update
    end
    private
    # Load the Sprite bitmap
    # @param pokemon [PFM::Pokemon]
    # @return [Texture]
    def load_bitmap(pokemon)
    end
    # Retrieve the bitmap source
    # @return [Symbol]
    def bitmap_source
    end
    # Retreive the gif source
    # @return [Symbol]
    def gif_source
    end
    # Align the sprite according to the bitmap properties
    # @param bmp [Texture] the bitmap source
    # @param pokemon [PFM::Pokemon]
    def auto_align(bmp, pokemon)
    end
  end
  # Class that show the back sprite of a Pokemon
  class PokemonBackSprite < PokemonFaceSprite
    private
    # Retrieve the bitmap source
    # @return [Symbol]
    def bitmap_source
    end
    # Retreive the gif source
    # @return [Symbol]
    def gif_source
    end
  end
  # Class that show the icon sprite of a Pokemon
  class PokemonIconSprite < SpriteSheet
    # Create a new Pokemon FaceSprite
    # @param viewport [Viewport] Viewport in which the sprite is shown
    # @param auto_align [Boolean] if the sprite auto align itself (sets its own ox/oy when data= is called)
    def initialize(viewport, auto_align = true)
    end
    # Set the pokemon
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
    # Update the pokemon animation
    def update
    end
    private
    # Define the animation of the icon
    # @param creature [PFM::Pokemon]
    def animate(creature)
    end
    # Get the duration of 1 step change
    # @param creature [PFM::Pokemon]
    # @return [Float] duration of the step in seconds
    def animation_step_duration(creature)
    end
    # Align the sprite according to the bitmap properties
    # @param bmp [Texture] the bitmap source
    def auto_align(bmp)
    end
  end
  # Class that show the icon sprite of a Pokemon
  class PokemonFootSprite < Sprite
    # Format of the icon name
    D3 = '%03d'
    # Set the pokemon
    # @param pokemon [PFM::Pokemon, nil]
    def data=(pokemon)
    end
  end
  # Class that show the item icon
  class ItemSprite < Sprite
    # Set the item that should be shown
    # @param item_id [Integer, Symbol, Studio::Item]
    def data=(item_id)
    end
  end
  # Class that show the category of a skill
  class AttackDummySprite < SpriteSheet
    # Name of the image shown
    IMAGE_NAME = 'battle_attack_dummy'
    # Create a new category sprite
    # @param viewport [Viewport] viewport in which the sprite is shown
    def initialize(viewport)
    end
    # Set the object that responds to #atk_class
    # @param object [#atk_class, nil]
    def data=(object)
    end
  end
  # Object that show a text using a method of the data object sent
  class SymText < Text
    # Add a text inside the window, the offset x/y will be adjusted
    # @param font_id [Integer] the id of the font to use to draw the text
    # @param viewport [Viewport, nil] the viewport used to show the text
    # @param x [Integer] the x coordinate of the text surface
    # @param y [Integer] the y coordinate of the text surface
    # @param width [Integer] the width of the text surface
    # @param height [Integer] the height of the text surface
    # @param method [Symbol] the symbol of the method to call in the data object
    # @param align [0, 1, 2] the align of the text in its surface (best effort => no resize), 0 = left, 1 = center, 2 = right
    # @param outlinesize [Integer, nil] the size of the text outline
    # @param color [Integer] the id of the color
    # @param sizeid [Intger] the id of the size to use
    def initialize(font_id, viewport, x, y, width, height, method, align = 0, outlinesize = nil, color = nil, sizeid = nil)
    end
    # Set the Object used to show the text
    # @param object [Object, nil]
    def data=(object)
    end
  end
  # Object that show a multiline text using a method of the data object sent
  class SymMultilineText < SymText
    # Set the Object used to show the text
    # @param object [Object, nil]
    def data=(object)
    end
  end
  # Class that show the sprite of a key
  class KeyShortcut < Sprite
    # Create a new KeyShortcut sprite
    # @param viewport [Viewport]
    # @param key [Symbol, Integer] Input.trigger? argument (or Keyboard exact key if integer)
    # @param red [Boolean] pick the red texture instead of the blue texture
    def initialize(viewport, key, red = false)
    end
    # KeyIndex that holds the value of the Keyboard constants in the right order according to the texture
    KeyIndex = %i[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z Num0 Num1 Num2 Num3 Num4 Num5 Num6 Num7 Num8 Num9 Space Backspace Enter LShift LControl LAlt Escape Left Right Up Down].collect(&Input::Keyboard.method(:const_get))
    kbd = Input::Keyboard
    # KeyIndex for the NumPad Keys
    NUMPAD_KEY_INDEX = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, kbd::Numpad0, kbd::Numpad1, kbd::Numpad2, kbd::Numpad3, kbd::Numpad4, kbd::Numpad5, kbd::Numpad6, kbd::Numpad7, kbd::Numpad8, kbd::Numpad9, -1, -1, -1, kbd::RShift, kbd::RControl, kbd::RAlt, -1, -1, -1, -1, -1]
    # Find the key rect in the Sprite according to the input key requested
    # @param key [Symbol] the Virtual Input Key.
    def find_key(key)
    end
    # Show the exact key (when key from initialize was an interger)
    def show_key(key)
    end
  end
  # Class that allow to show a binding of a specific key
  class KeyBinding < KeyShortcut
    # @return [Symbol] the key the button describe
    attr_reader :key
    # @return [Integer] the index of the key in the Keys[key] array
    attr_reader :index
    # Create a new KeyBinding sprite
    # @param viewport [Viewport]
    # @param key [Symbol] Input.trigger? argument
    # @param index [Integer] Index of the key in the Keys constant
    def initialize(viewport, key, index)
    end
    # Find the key rect in the Sprite according to the input key requested
    # @param key [Symbol] the Virtual Input Key.
    def find_key(key)
    end
    # Update the key
    def update
    end
  end
  # Class that allow to show a binding of a specific key on the Joypad
  class JKeyBinding < Sprite
    # @return [Symbol] the key the button describe
    attr_reader :key
    # Create a new KeyBinding sprite
    # @param viewport [Viewport]
    # @param key [Symbol] Input.trigger? argument
    def initialize(viewport, key)
    end
    # KeyIndex that holds the value of the key value in the order of the texture
    KeyIndex = [1, 2, 0, 3, 13, 15, 12, 14, 8, 9, 4, 5, 6, 7, 10, 11]
    # Find the key rect in the Sprite according to the input key requested
    # @param key [Symbol] the Virtual Input Key.
    def find_key(key)
    end
    # Update the key
    def update
    end
    # Return the index of the key in the Keys[key] array
    # @return [Integer]
    def index
    end
  end
  # Sprite responsive of showing the sprite of the Ball we throw to Pokemon or to release Pokemon
  class ThrowingBallSprite < SpriteSheet
    # Array mapping the move progression to the right cell
    MOVE_PROGRESSION_CELL = [17, 16, 15, 16, 17, 18, 19, 18, 17]
    # Create a new ThrowingBallSprite
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
    end
    # Function that adjust the sy depending on the progression of the "throw" animation
    # @param progression [Float]
    def throw_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "open" animation
    # @param progression [Float]
    def open_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "close" animation
    # @param progression [Float]
    def close_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "move" animation
    # @param progression [Float]
    def move_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "break" animation
    # @param progression [Float]
    def break_progression=(progression)
    end
    # Function that adjust the sy depending on the progression of the "caught" animation
    # @param progression [Float]
    def caught_progression=(progression)
    end
    # Get the ball offset y in order to make it the same position as the Pokemon sprite
    # @return [Integer]
    def ball_offset_y
    end
    # Get the ball offset y in order to make it look like being in trainer's hand
    # @return [Integer]
    def trainer_offset_y
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
    end
  end
  # Class responsive of dealing with Keyboard user input (for search or other stuff like that).
  #
  # This is a Text that takes the same parameters as regular texts but has a `init` method allowing
  # to tell how much characters are allowed, what kind of character to use for empty chars and give the handler
  #
  # Example
  #   ```ruby
  #     @search = add_text(x, y, width, height, 'default_text', type: UI::UserInput)
  #     @search.init(25, '', on_new_char: method(:add_char), on_remove_char: method(:del_char))
  #     # ...
  #     def add_char(complete_string, new_char)
  #     # ...
  #     def del_char(complete_string, removed_char)
  #   ```
  class UserInput < ::Text
    # Code used to detect CTRL+V
    CTRL_V = ''
    # Code used to detect backspace
    BACK = ''
    # Init the user input
    # @param max_size [Integer] maximum size of the user input
    # @param empty_char [String] char used to replace all the remaining empty char
    # @param on_new_char [#call, nil] called when a char is added
    # @param on_remove_char [#call, nil] called when a char is removed
    def init(max_size, empty_char = '_', on_new_char: nil, on_remove_char: nil)
    end
    # Update the user input
    def update
    end
    private
    # Load the text from external source
    # @param text [String] external source
    def load_text(text)
    end
  end
  # Class describing a text scroller (used in Credits)
  class TextScroller < SpriteStack
    # Separator for double column
    DOUBLE_COLUMN_SEP = ' || '
    # Create a new text scroller
    # @param viewport [Viewport]
    # @param texts [Array<String>]
    # @param line_height [Integer] height of a line of text
    # @param speed [Float] number of pixels / seconds
    def initialize(viewport, texts, line_height, speed)
    end
    # Start the text scroll
    # @param until_all_text_hidden [Boolean] if the animation should last until the last text is offscreen
    def start(until_all_text_hidden: true)
    end
    # Update the scrolling
    def update
    end
    # Tell if the scrolling is done
    # @return [Boolean]
    def done?
    end
    private
    # Function responsive of spawning the next text to the screen
    def spawn_next_text
    end
    # Function responsive of loading the text to the screen
    # @param text [String] markdown styled text (h1, h2, h3 or p)
    def load_text(text)
    end
    # Function that load a text depending on its kind
    # @param pool [Array<Text>]
    # @param kind [Symbol]
    # @param text [String]
    # @return [Text]
    def load_text_by_kind(pool, kind, text)
    end
    # Function that load text on double column
    # @param pool [Array<Text>]
    # @param texts [Array<String>]
    def load_double_text(pool, texts)
    end
    # Function that give the text coordinate for the next text to show
    # @return [Array<Integer>]
    def next_text_coordinate
    end
    # Function that give the text surface & align
    # @return [Array<Integer>]
    def text_surface
    end
    # Function that give the text align
    # @return [Integer]
    def text_align
    end
    # Function that gives the font for a text
    # @param kind [Symbol]
    # @return [Integer]
    def font_id(kind)
    end
    # Function that gives the color for a text
    # @param kind [Symbol]
    # @return [Integer]
    def color_id(kind)
    end
    # Function that gives the outline_size for a text
    # @param kind [Symbol]
    # @return [Integer]
    def outline_size(kind)
    end
    # Function that preload some text in order to make the starting a bit smoother
    def preload_texts
    end
  end
  # Class responsive of showing a blur screenshot in the current scene
  class BlurScreenshot < ShaderedSprite
    # Create a new blur Screenshot
    # @param viewport [Viewport, nil]
    # @param last_scene [GamePlay::Base] base scene that should respond to #viewport
    def initialize(viewport = nil, last_scene)
    end
    # Dispose the sprite
    def dispose
    end
    # Update the snapshot
    def update_snapshot
    end
    private
    # Function that detects the viewport to use
    # @return [Viewport]
    def guess_viewport
    end
    # Function that creates the snapshot
    # @return [Texture]
    def create_snapshot
    end
  end
end
class Shader
  module CreatureShaderLoader
    # Load the shader when the Creature gets assigned
    # @param creature [PFM::Pokemon]
    def load_shader(creature)
    end
    # Load the shader properties (based on @__csl_shader_id and creature)
    # @param creature [PFM::Pokemon]
    def load_shader_properties(creature)
    end
    # Get the ID of the shader to load
    # @param creature [PFM::Pokemon]
    # @return [Symbol]
    def find_shader_id(creature)
    end
  end
  module CreatureShaderForCreatureFaceSpriteHelper
    include CreatureShaderLoader
    private
    # Load the Sprite bitmap
    # @param creature [PFM::Pokemon]
    # @return [Texture]
    def load_bitmap(creature)
    end
  end
  UI::PokemonFaceSprite.prepend(CreatureShaderForCreatureFaceSpriteHelper)
end
