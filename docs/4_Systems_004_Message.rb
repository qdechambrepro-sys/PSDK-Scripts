module Util
  # Module that help showing system message.
  #
  # How to use it :
  # ```ruby
  #   include Util::SystemMessage
  #   # ...
  #     show_message(:message_name) # Basic message
  #     if yes_no_choice(load_message(:message_name)) # Choice from interpreter
  #       show_message(:message_name, pokemon: pokemon) # Will set PKNICK[0] & PKNAME[0]
  #       show_message(:message_name, pokemon_1: pokemon) # Will set PKNICK[1] & PKNAME[1]
  #       show_message(:message_name, item: item_id, pokemon: pokemon) # Will set ITEM2[0], PKNICK[0] & PKNAME[0]
  #       show_message_and_wait(:message_name) # Will wait until the message box disappear
  # ```
  #
  # How to define ":message_name"s :
  #   - Simple message (from RH) : `Util::SystemMessage::MESSAGES[:message_name] = [:text_get, id, line]`
  #   - Complex message : `Util::SystemMessage::MESSAGES[:message_name] = proc { |opts| next(message_contents) }`
  # Note : opts are the optionnals arguments sent to show_message
  module SystemMessage
    # List of message by name
    MESSAGES = {received_pokemon: [:ext_text, 8999, 15], give_nickname_question: [:ext_text, 8999, 16], is_nickname_correct_qesion: [:ext_text, 8999, 17], pokemon_stored_to_box: [:ext_text, 8999, 18], bag_store_item_in_pocket: [:text_get, 41, 9], pokemon_shop_unavailable: [:ext_text, 9003, 1]}
    # Capture regexp
    HAS_NUMBER_REG = /_([0-9]+)$/
    # Tell if the key contain pokemon
    IS_POKEMON = /^pokemon/
    # Tell if the key contain item
    IS_ITEM = /^item/
    # Tell if the key contain num1
    IS_NUMBER1 = /^num1/
    # Tell if the key contain num2
    IS_NUMBER2 = /^num2/
    # Tell if the key contain num3
    IS_NUMBER3 = /^num3/
    module_function
    # Load a message
    # @param message_name [Symbol] ID of the message in MESSAGES
    # @param opts [Hash] options (additional text replacement)
    def load_message(message_name, opts = nil)
    end
    # Show a message
    # @param message_name [Symbol] ID of the message in MESSAGES
    # @param opts [Hash] options (additional text replacement)
    def show_message(message_name, opts = nil)
    end
    # Show a message
    # @param message_name [Symbol] ID of the message in MESSAGES
    # @param opts [Hash] options (additional text replacement)
    def show_message_and_wait(message_name, opts = nil)
    end
    # Parse the message opts
    # @param opts [Hash] options (additional text replacement)
    def parse_opts(opts)
    end
  end
end
Interpreter.include(Util::SystemMessage)
module PFM
  # Module responsive of holding the whole Message logic
  module Message
    # Module parsing a message to a set of instruction the message displayer can show
    module Parser
      @code_replacer = []
      # Function that parses the message text so it's easier to work with it
      # @param text [String] original message text
      # @return [Message::Properties] the initial message properties
      def convert_text_to_properties(text)
      end
      # Function that generate the instructions based on properties & text surface
      # @param properties [Properties] Message box properties
      # @param width [Integer] width of the surface used to draw the message
      # @param width_computer [WidthComputer] object helping to compute the width of the words
      def make_instructions(properties, width, width_computer)
      end
      class << self
        # Get the list of code replacer
        # @return [Array<Proc>]
        attr_reader :code_replacer
        # Register a text marker to make text easier to parse
        # @param regexp [Regexp] regexp to parse
        # @param code [Integer] code to use for easier parsing (must be positive integer)
        # @yieldparam captures [Array<String>] list of all captures from the regexp
        # @yieldreturn [Array] array of element not containing "[" or "]"
        # @note If no block is given, the function will assume the regexp has 1 match
        def register_marker(regexp, code)
        end
      end
      register_marker(/\\c\[([0-9]+)\]/i, 1)
      register_marker(/\[WAIT ([0-9]+)\]/i, 2)
      register_marker(/\\s\[([bir]+)\]/i, 3) do |(style)|
        next(0) if style.include?('r')
        next(1) if style == 'b'
        next(2) if style == 'i'
        next(3)
      end
      register_marker(/\\\^/, 4) {0 }
      register_marker(/\\spd\[([0-9]+)\]/, 5)
      register_marker(/\\img\[([^\]]+)\]/, 15)
    end
    # Class holding all the properties for the currently showing message
    class Properties
      # All the properties that can be set in :[]: with the function to call to compute the property parameters
      # @return [Hash{String=>Symbol}]
      PROPERTIES = {'name' => :parse_speaker_name, 'face' => :parse_speaker_face, 'city' => :parse_city_filename, 'can_skip' => :parse_can_skip, 'windowskin' => :parse_window_skin, 'lookto' => :look_to_event, 'align' => :parse_message_align}
      # Parsed text of the message
      # @return [String]
      attr_reader :parsed_text
      # Tell that the message should show the gold window
      # @return [Boolean]
      attr_accessor :show_gold_window
      # Get the name to show
      # @return [String, nil]
      attr_reader :name
      # Get the color of the name to show
      # @return [Integer, nil]
      attr_reader :name_color
      # Get all the faces to show
      # @return [Array<Face>]
      attr_reader :faces
      # Get the city image to show
      # @return [String, nil]
      attr_reader :city_filename
      # Tell if user can skip the message using directional keys
      # @return [Boolean]
      attr_reader :can_skip_message
      # Get the windowsking overwrite of the current message
      # @return [String]
      attr_reader :windowskin_overwrite
      # Get the ID of the event to look to
      # @return [Integer]
      attr_reader :look_to
      # Get the message alignment
      # @return [Symbol] :left, :right, :center
      attr_reader :align
      # Create a new Properties object
      # @param parsed_text [String]
      def initialize(parsed_text)
      end
      # Process the lookto operation
      def process_look_to
      end
      private
      # Parse the speaker name
      # @param info_str [String] name of the speaker
      def parse_speaker_name(info_str)
      end
      # Parse the face of a speaker
      # @param info_str [String] infos about the face (position,name,opacity,mirror)
      def parse_speaker_face(info_str)
      end
      # Parse the image setting of the city
      # @param name [String] name of the image in Pictures
      def parse_city_filename(name)
      end
      # Parse the can skip authorisation
      # @param _ignored [String] ignored param
      def parse_can_skip(_ignored)
      end
      # Parse the message box windowsking change
      # @param windowskin [String] name of the temporary windowskin
      def parse_window_skin(windowskin)
      end
      # Turn the player toward the event of it's choice
      # @param event [String] the info about the chosen event
      # @example example of event
      #   If you want your player to turn to the talking event, write :[lookto=] or :[lookto=0]
      #   If you want your player to turn to another event, write :[lookto=X] where X is the event's id
      #   Take care to always write the id without the first 0. Example : 036 should always be written 36.
      def look_to_event(event)
      end
      # Parse the message alignment
      # @param align [String] position of text
      def parse_message_align(align = 'left')
      end
      # Function that pre parse the properties so they're all set to the right value
      def preparse_properties
      end
      # Parse all the properties of a message set through :[prop_name1=a;prop_name2=a,b]:
      # @param unparsed_props [String] all the properties that were not currently parsed
      # @return nil
      def parse_properties(unparsed_props)
      end
      # Class describing a face to show
      class Face
        # Get the face position
        # @return [Integer]
        attr_accessor :position
        # Get the face name (filename)
        # @return [String]
        attr_accessor :name
        # Get the face opacity
        # @return [Integer]
        attr_accessor :opacity
        # Get the face mirror state
        # @return [Boolean]
        attr_accessor :mirror
      end
    end
    # Parse & List all the instructions to draw the message box content
    class Instructions
      # Regexp used to detect markers
      MARKER_REGEXP = /([\x01-\x0F]\[[^\]]+\])/
      # Regexp to grab the marker data
      MARKER_DATA = /\[([^\]]+)\]/
      # Regexp that split text with space but preserver space in split output
      SPACE_SPLIT_PRESERVE_REGEXP = /( )/
      # ID of image marker
      IMAGE_MARKER_ID = 15
      # ID of big text marker
      BIG_TEXT_MARKER_ID = 4
      # Create a new Instructions instance
      # @param properties [Properties] Message box properties
      # @param width [Integer] width of the surface used to draw the message
      # @param width_computer [WidthComputer] object helping to compute the width of the words
      def initialize(properties, width, width_computer)
      end
      # Parse the message
      def parse
      end
      # Start instruction procesing
      def start_processing
      end
      # Tell if processing is done
      # @return [Boolean]
      def done_processing?
      end
      # Get current instruction and prepare next instruction
      # @return [Text, Marker, NewLine, nil]
      def get
      end
      # Get the width of the current line
      # @return [Integer]
      def current_line_width
      end
      private
      # Split the text in a way markers can be converted to marker instruction easilly
      # @return [Array<String>]
      def split_text_and_markers
      end
      # Detect if the string is a marker
      # @param string [String]
      # @return [Boolean]
      def marker?(string)
      end
      # Get the width of the text
      # @param text [String]
      # @return [Integer]
      def width_of(text)
      end
      # Function that parse a marker
      # @param marker [String]
      def parse_marker(marker)
      end
      # Function that parse a image marker
      # @param marker [String]
      def parse_image_marker(marker)
      end
      # Function that parses text
      # @param text [String]
      def parse_text(text)
      end
      # Function that parses text containing new lines.
      # Will not push new line if a new line was created by the last word or will be created by next word.
      # @param text [String]
      def parse_text_with_new_line(text)
      end
      # Function that parses text not containing new lines
      # @param text [String]
      def parse_text_without_new_line(text)
      end
      # Function that parse a text that will break in several line because it's long
      # @param text [String]
      def parse_text_that_break_in_several_lines(text)
      end
      # Test if the current element width will overflow
      # @param width [Integer]
      # @return [Boolean]
      def will_overflow?(width)
      end
      # Function that pushes a new line
      # @param new_line_total_width [Integer] current width of the new line
      def push_line(new_line_total_width = 0)
      end
      # Class that describes a Marker
      class Marker
        # Get the marker ID
        # @return [Integer]
        attr_reader :id
        # Get the marker data
        # @return [String]
        attr_reader :data
        # Get the width of the marker
        # @return [Integer]
        attr_reader :width
        # Create a new Marker
        # @param id [Integer] ID of the marker
        # @param data [String] data of the marker
        # @param width [Integer] width of the marker
        def initialize(id, data, width = 0)
        end
      end
      # Class that describe a text object
      class Text
        # Get the text to show
        # @return [String]
        attr_reader :text
        # Get the width of the text
        # @return [Integer]
        attr_reader :width
        # Create a new text object
        # @param text [String] text to show
        # @param width [Integer] width of the text to show
        def initialize(text, width)
        end
      end
      # Module that describe a new line
      module NewLine
        module_function
        # Get the width of the new line
        # @return [Integer]
        def width
        end
      end
    end
    # Class that helps to compute the width of the words
    class WidthComputer
      # Create a new WidthComputer
      # @param text_normal [LiteRGSS::Text]
      # @param text_big [LiteRGSS::Text]
      def initialize(text_normal, text_big)
      end
      # Get the normal width of the text
      # @param text [String]
      # @return [Integer]
      def normal_width(text)
      end
      # Get the width of the text when it's big
      # @param text [String]
      # @return [Integer]
      def big_width(text)
      end
      # Tell if any of the text is disposed
      # @return [Boolean]
      def disposed?
      end
    end
    # Module responsive of helping the message window with states
    #
    # In order to have everything working properly, the class including this module needs to define:
    # - message_width : Returns an integer telling the width of the message window we want to process (can use @properties)
    # - width_computer : Returns [PFM::Message::WidthComputer] object helping to compute the width of the words/texts
    module State
      include Parser
      # If the message doesn't wait the player to hit A to terminate
      # @return [Boolean]
      attr_accessor :auto_skip
      # If the window message doesn't fade out
      # @return [Boolean]
      attr_accessor :stay_visible
      # The last unprocessed text the window has shown
      # @return [String, nil]
      attr_reader :last_text
      protected
      # Get the current instruction
      # @return [Instructions::Text, Instructions::Marker, Instructions::Marker, nil]
      attr_reader :current_instruction
      # Get the instructions
      # @return [Instructions]
      attr_reader :instructions
      # Get the properties
      # @return [Properties]
      attr_reader :properties
      public
      # Initialize the states
      def initialize(...)
      end
      # Tell if the message window need to show a message
      # @return [Boolean]
      def need_to_show_message?
      end
      # Tell if the message window need to wait for user input
      # @return [Boolean]
      def need_to_wait_user_input?
      end
      # Parse the new message and set the window into showing message state
      def parse_and_show_new_message
      end
      # Load the next instruction
      def load_next_instruction
      end
      # Test if we're at the end of the line
      # @return [Boolean]
      def at_end_of_line?
      end
      # Test if we're done drawing the message
      # @return [Boolean]
      def done_drawing_message?
      end
      # Tell if the message window is showing a message
      # @return [Boolean]
      def showing_message?
      end
      # Tell if the message window need to show a choice
      # @return [Boolean]
      def need_to_show_choice?
      end
      # Tell if the message window need to show a number input
      # @return [Boolean]
      def need_to_show_number_input?
      end
      private
      # Terminate the message display
      def terminate_message
      end
      # Reset all the states of the message_window
      def reset_states
      end
      # Reset the $game_temp stuff
      def reset_game_temp_message_info
      end
    end
  end
end
module UI
  # Module responsive of holding the whole message ui aspect
  module Message
    # Module implementing the overwrite functionality
    module TemporaryOverwrites
      # @return [Symbol, Array, nil] Overwrite the message position for the current message
      # @note Values can be : :top, :middle, :bottom, :left, :right, [x, y]
      attr_accessor :position_overwrite
      # @return [String, nil] Change the windowskin of the window
      attr_accessor :windowskin_overwrite
      # @return [String, nil] Change the windowskin of the name
      attr_accessor :nameskin_overwrite
      # @return [Integer, nil] Overwrite the number of line for the current message
      attr_accessor :line_number_overwrite
      # @return [Integer, nil] Overwrite the width of the window
      attr_accessor :width_overwrite
      # Initialize the overwrites
      def initialize(...)
      end
      # Reset all the overwrite when the message has been shown
      def reset_overwrites
      end
    end
    # Module defining the Message layout
    module Layout
      # Name of the pause skin in Graphics/Windowskins/
      PAUSE_SKIN = 'Pause2'
      # Windowskin for the name window
      NAME_SKIN = 'message'
      include TemporaryOverwrites
      # Attribute that holds the UI::InputNumber object
      # @return [UI::InputNumber]
      attr_accessor :input_number_window
      protected
      # Get the text stack
      # @return [UI::SpriteStack]
      attr_reader :text_stack
      # Get the sub_stack
      # @return [UI::SpriteStack]
      attr_reader :sub_stack
      public
      # Initialize the states
      # @param args [Array<Viewport>] arguments to forward to parents
      # @param scene [GamePlay::Base] scene holding this message instance
      def initialize(*args, scene)
      end
      # Retrieve the current layout configuration based on the scene
      # @return [Configs::Project::Texts::MessageConfig]
      def current_layout
      end
      # Dispose the layout
      # @param with_viewport [Boolean] tell to also dispose the viewport of the layout
      def dispose(with_viewport: false)
      end
      private
      # Initialize the window Parameter
      def init_window
      end
      def init_pause_coordinates
      end
      # Calculate the current window position
      def calculate_position
      end
      # Update the windowskin
      def update_windowskin
      end
      # Retrieve the current window position
      # @return [Symbol, Array]
      def current_position
      end
      # Retrieve the current window_builder
      # @return [Array]
      def current_window_builder
      end
      # Retrieve the current windowskin
      # @return [String]
      def current_windowskin
      end
      # Retrieve the current windowskin of the name window
      # @return [String]
      def current_name_windowskin
      end
      # Return the window width
      # @return [Integer]
      def window_width
      end
      # Return the message width
      def message_width
      end
      # Return the window height
      def window_height
      end
      # Return the number of lines
      def line_number
      end
      # Return the default window width
      # @return [Integer]
      def default_width
      end
      # Return the default horizontal margin
      # @return [Integer]
      def default_horizontal_margin
      end
      # Return the default vertical margin
      # @return [Integer]
      def default_vertical_margin
      end
      # Return the default line number
      # @return [Integer]
      def default_line_number
      end
      # Return the default line height
      def default_line_height
      end
      # Return the default text color
      # @return [Integer]
      def default_color
      end
      alias get_default_color default_color
      # Return the default text style
      # @return [Integer]
      def default_style
      end
      alias get_default_style default_style
      # Is text displaying bigger (marker 4 compatibility)
      def bigger_text?
      end
      public
      # Generate the choice window
      def generate_choice_window
      end
      # Generate the number input window
      def generate_input_number_window
      end
      # Show a window that tells the player how much money he got
      def show_gold_window
      end
      # Function that test if sub window can be updated (choice / number)
      # @return [Boolean]
      def can_sub_window_be_updated?
      end
      # Show the name window
      def show_name_window
      end
      # Show the city image
      def show_city_image
      end
      # Show a face
      # @param face [PFM::Message::Properties::Face]
      def show_face(face)
      end
      # Function that translate the position to a coordinate
      # @param position [Integer] position given by the maker
      # @return [Integer] the x position
      def parse_speaker_position(position)
      end
      # Return the face_speaker y position
      # @return [Integer]
      def face_speaker_y
      end
      # Load the sub layout based on properties
      def load_sub_layout
      end
    end
    # Module defining how the message transition to the screen
    module Transition
      private
      # Initialize the fade-in operation
      def init_fade_in
      end
      # Update the fade-in animation
      def update_fade_in
      end
      # Get the number of opacity unit per second for the fade in
      # @return [Integer]
      def fade_in_opacity_speed
      end
      # Initialize the fade-out operation
      def init_fade_out
      end
      # Finalize the fade-out operation
      def finalize_fade_out
      end
      # Update the fade-out animation
      def update_fade_out
      end
      # Get the number of opacity unit per second for the fade in
      # @return [Integer]
      def fade_out_opacity_speed
      end
      def init_new_line_transition
      end
      def create_pre_line_transition_animation
      end
      # Test if the new line transition is done
      # @return [Boolean]
      def new_line_transition_done?
      end
      # Test if the new line transition is necessary
      # @return [Boolean]
      def need_new_line_transition?
      end
      # Update the new line transition
      def update_new_line_transition
      end
      # Execute the post process of the new line transition
      def finalize_new_line_transition
      end
      # Get the speed of the new line transition
      # @return [Integer]
      def new_line_transition_speed
      end
    end
    # Module defining the drawing methods of messages
    module Draw
      private
      # Start to draw the message
      def start_drawing
      end
      # Update the text drawing
      def update_draw
      end
      # Function that tells if the system needs an internal text drawing
      def need_internal_drawing_update?
      end
      # Update the real drawing (animations) of the message
      def update_draw_internal
      end
      # Process the instructions
      def process_instruction
      end
      # Start the text animation
      def start_text_animation
      end
      # Test if the player is reading a panel and skips by moving
      def panel_skip?
      end
      # Process the end of line
      def process_end_of_line
      end
      # Load the text style
      # @param text [Text]
      def load_text_style(text)
      end
      # Get the character speed (number of character / seconds at lowest speed)
      # @return [Integer]
      def character_speed
      end
      # Initialize the text drawing
      def init_text_drawing
      end
      # Get the initial x position of the text for the current line
      # @return [Integer]
      def initial_text_line_x
      end
      # Translate the color according to the layout configuration
      # @param color [Integer] color to translate
      # @return [Integer] translated color
      def translate_color(color)
      end
      public
      # Function that process the markers of the message (property modifier)
      def process_marker
      end
      # Process the color marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_color_marker(marker)
      end
      alias process_marker1 process_color_marker
      # Process the wait marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_wait_marker(marker)
      end
      alias process_marker2 process_wait_marker
      # Process the style marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_style_marker(marker)
      end
      alias process_marker3 process_style_marker
      # Process the big text marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_big_text_marker(marker)
      end
      alias process_marker4 process_big_text_marker
      # Process the speed marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_speed_marker(marker)
      end
      alias process_marker5 process_speed_marker
      # Process the picture marker
      # @param marker [PFM::Message::Instructions::Marker]
      def process_picture_marker(marker)
      end
      alias process_marker15 process_picture_marker
    end
    # Module describing the whole user input process
    module WaitUserInput
      private
      # Process the wait user input phase
      def wait_user_input
      end
      # Show the Input Number Window
      # @return [Boolean] if the update function skips
      def update_input_number
      end
      # Show the choice during update
      # @return [Boolean] if the update function skips
      def update_choice
      end
      # Skip the update of wait input
      # @return [Boolean] if the update of wait input should be skipped
      def update_wait_input_skip
      end
      # Autoskip the wait input
      # @return [Boolean]
      def update_wait_input_auto_skip
      end
      # Wait for the user to press enter before moving forward
      def update_wait_input
      end
      # Tell if the user is interacting
      # @return [Boolean] true if the user is interacting
      def interacting?
      end
      # Tell if the user is cancelling
      # @return [Boolean] true if the user is cancelling
      def cancelling?
      end
    end
    # Definition of the Message Window UI element
    class Window < ::Window
      include Layout
      include Transition
      include Draw
      include WaitUserInput
      include PFM::Message::Parser
      include PFM::Message::State
      # Update the window
      def update
      end
      private
      # Get the width computer of this window
      # @return [PFM::Message::WidthComputer]
      def width_computer
      end
    end
  end
end
module GamePlay
  # Module responsive of adding the display message functionality to a class
  module DisplayMessage
    # Message the displays when a GamePlay scene has been initialized without message processing and try to display a message
    MESSAGE_ERROR = 'This interface has no MessageWindow, you cannot call display_message'
    # Error message when display_message is called from "itself"
    MESSAGE_PROCESS_ERROR = 'display_message was called inside display_message. Please fix your scene update.'
    # The message window
    # @return [UI::Message::Window, nil]
    attr_reader :message_window
    # Prevent the update to process if the message are still processing
    # @return [Boolean]
    def message_processing?
    end
    # Tell if the display_message function can be called
    # @return [Boolean]
    def can_display_message_be_called?
    end
    # Force the message window to "close" (but does not update scene)
    # @yield yield to allow some process before updating the message window
    def close_message_window
    end
    # Return the message class used
    # @return [Class<UI::Message::Window>]
    def message_class
    end
    # Set the visibility of message
    # @param visible [Boolean]
    def message_visible=(visible)
    end
    # Get the visibility of message
    # @return [Boolean]
    def message_visible
    end
    # Display a message with choice or not
    # @param message [String] the message to display
    # @param start [Integer] the start choice index (1..nb_choice)
    # @param choices [Array<String>] the list of choice options
    # @param block [Proc] block to call while message updates
    # @return [Integer, nil] the choice result
    def display_message(message, start = 1, *choices, &block)
    end
    # Display a message with choice or not. This method will wait the message window to disappear
    # @param message [String] the message to display
    # @param start [Integer] the start choice index (1..nb_choice)
    # @param choices [Array<String>] the list of choice options
    # @param block [Proc] block to call while message updates
    # @return [Integer, nil] the choice result
    def display_message_and_wait(message, start = 1, *choices, &block)
    end
    private
    # Initialize the window related interface of the UI
    # @param no_message [Boolean] if the scene is created wihout the message management
    # @param message_z [Integer] the z superiority of the message
    # @param message_viewport_args [Array] if empty : [:main, message_z] will be used.
    def message_initialize(no_message, message_z, message_viewport_args)
    end
    # Setup the message display
    # @param message [String]
    # @param start [Integer] the start choice index (1..nb_choice)
    # @param choices [Array<String>] the list of choice options
    def setup_message_display(message, start, choices)
    end
    # Update the message
    def message_update
    end
    # Update the scene inside the message waiting loop
    # @note this internally calls message_update
    def message_update_scene
    end
    # Dispose the message
    def message_dispose
    end
    # Function performing some tests to prevent softlock from messages at certain points
    def message_soft_lock_prevent
    end
  end
  class Base
    include DisplayMessage
  end
end
