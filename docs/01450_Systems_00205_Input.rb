module UI
  # Base UI for name input scenes
  class NameInputBaseUI < GenericBase
    alias create_button_background void
    alias update_background_animation void
    # @param viewport [LiteRGSS::Viewport]
    # @param last_scene [GamePlay::BaseCleanUpdate]
    def initialize(viewport, last_scene)
    end
    private
    def create_background
    end
    def create_control_button
    end
  end
  # Name Input UI window
  class NameInputUI < Window
    # Return the chars the user has inserted
    # @return [Array<String>]
    attr_reader :chars
    # Character used to indicate there's no char there
    NO_CHAR = '_'
    # Create a new NameInputUI
    # @param viewport [Viewport]
    # @param max_size [Integer] maximum size of the name
    # @param chars [Array<String>] chars initialize there
    # @param character [PFM::Pokemon, String, nil] the character to display
    # @param phrase [String] the phrase to display in order to justify the name input
    def initialize(viewport, max_size, chars, character, phrase)
    end
    # Add a character to the input
    # @param char [String]
    def add_char(char)
    end
    # Remove a character from the input
    def remove_char
    end
    # Update the window (caret)
    def update
    end
    private
    # Return the default window parameters (x, y, width, height)
    # @return [Array<Integer>]
    def window_parameters
    end
    # Return the default windowskin
    # @return [String]
    def default_windowskin
    end
    # Create the graphics inside the window
    def create_graphics
    end
    # Create the character sprite
    def create_character_sprite
    end
    def character_sprite_position
    end
    # Create the phrase texte
    def create_phrase
    end
    # Create the text inputs elements
    def create_inputs
    end
    def base_x
    end
    def delta_x
    end
    def base_y
    end
    def delta_y
    end
    def refresh_chars
    end
  end
  # UI element showing input number (for number choice & selling)
  class InputNumber < SpriteStack
    # Image used as source for the UI build
    IMAGE_SOURCE = 'numin_bg'
    # List of coordinates used to know how to build the UI from the image
    IMAGE_COMPOSITION = {left: [0, 0, 33, 44], number: [33, 0, 24, 44], separator: [57, 0, 6, 44], right: [83, 0, 10, 44], money_add: [94, 0, 68, 44]}
    # Padding for money text
    MONEY_PADDING = 2
    # Minimum value
    # @return [Integer]
    attr_accessor :min
    # Maximum value
    # @return [Integer]
    attr_accessor :max
    # Currently inputed number
    # @return [Integer]
    attr_reader :number
    # Create a new Input number
    # @param viewport [Viewport]
    # @param max_digits [Integer] maximum number of digit
    # @param default_number [Integer] default number
    # @param accept_negatives [Boolean] if we can provide negative values
    def initialize(viewport, max_digits, default_number = 0, accept_negatives = false)
    end
    # Update the UI element
    def update
    end
    # Set the number shown by the UI
    # @param number [Integer]
    def number=(number)
    end
    # Get the width of the UI
    # @return [Integer]
    def width
    end
    # Get the height of the UI
    # @return [Integer]
    def height
    end
    private
    def create_sprites
    end
    def create_left
    end
    def create_center
    end
    def create_right
    end
    def create_money
    end
    def draw_digits
    end
    def define_position
    end
  end
end
module GamePlay
  # Module defining the IO of the NameInput scene so user know what to expect
  module NameInputMixin
    # Return the choosen name
    # @return [String]
    attr_reader :return_name
  end
  # Name input scene
  class NameInput < GamePlay::BaseCleanUpdate::FrameBalanced
    include NameInputMixin
    # Hint shown about how to enter name
    DEFAULT_HINT = [:ext_text, 9000, 162]
    # "Use your keyboard and press ENTER"
    # GUESSED PHRASE when not given
    GUESSED_PHRASE = [:ext_text, 9000, 163]
    # "How would you name %<name>s?"
    # Create a new NameInput scene
    # @param default_name [String] the choosen name if no choice
    # @param max_length [Integer] the maximum number of characters in the choosen name
    # @param character [PFM::Pokemon, String, nil] the character to display
    # @param phrase [String, nil] phrase to show in order to display the name
    def initialize(default_name, max_length, character = nil, phrase: nil)
    end
    # Update the inputs of the scene
    # @return [Boolean] if the other "input" related updates can be called
    def update_inputs
    end
    # Update the graphics of the scene
    def update_graphics
    end
    # Make main return self for compatibility
    # @return [self]
    def main
    end
    private
    def guess_phrase
    end
    def create_graphics
    end
    # Update the displayed name (according to a list of chars)
    # @param chars [Array<String>] all the chars that controls the name (add / remove / validate)
    # @param from_clipboard [Boolean] if the chars comes from the clipboard
    def update_name(chars, from_clipboard = false)
    end
    def confirm_name
    end
    def joypad_update_inputs
    end
    def create_base_ui
    end
    def create_name_input_ui
    end
    def create_hint_ui
    end
    def create_joypad_ui
    end
    # Function that checks if a character is valid depending on its ordinal
    # @param ord [Integer] value of the char in numbers
    # @return [Boolean]
    def char_valid?(ord)
    end
  end
  # Number input scene
  class NumberInput < NameInput
    private
    def create_joypad_ui
    end
    # Function that checks if a character is valid depending on its ordinal
    # @param ord [Integer] value of the char in numbers
    # @return [Boolean]
    def char_valid?(ord)
    end
  end
end
GamePlay.string_input_mixin = GamePlay::NameInputMixin
GamePlay.string_input_class = GamePlay::NameInput
