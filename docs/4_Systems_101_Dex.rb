module PFM
  # The Pokedex informations
  #
  # The main Pokedex object is stored in $pokedex or PFM.game_state.pokedex
  #
  # All Creature are usually marked as seen or captured in the correct scripts using $pokedex.mark_seen(id)
  # or $pokedex.mark_captured(id).
  #
  # When the Pokedex is disabled, no Creature can be marked as seen (unless they're added to the party).
  # All caught Creature are marked as captured so if for scenaristic reason you need the trainer to catch Creature
  # before having the Pokedex. Don't forget to call $pokedex.unmark_captured(id) (as well $pokedex.unmark_seen(id))
  # @author Nuri Yuri
  class Pokedex
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Get the current dex variant
    # @return [Symbol]
    attr_reader :variant
    # Get the list of seen variants
    # @return [Array<Symbol>]
    attr_reader :seen_variants
    # Create a new Pokedex object
    # @param game_state [PFM::GameState] game state storing this instance
    def initialize(game_state = PFM.game_state)
    end
    # Convert the dex to .26 format
    def convert_to_dot26
    end
    # Create a Hash for form caught
    def set_form_caught
    end
    # Enable the Pokedex
    def enable
    end
    # Test if the Pokedex is enabled
    # @return [Boolean]
    def enabled?
    end
    # Disable the Pokedex
    def disable
    end
    # Set the national flag of the Pokedex
    # @param mode [Boolean] the flag
    def national=(mode)
    end
    alias set_national national=
    # Set the variant the Dex is currently showing
    # @param variant [Symbol]
    def variant=(variant)
    end
    # Is the Pokedex showing national Creature
    # @return [Boolean]
    def national?
    end
    # Return the number of Creature seen
    # @return [Integer]
    def creature_seen
    end
    alias pokemon_seen creature_seen
    # Return the number of caught Creature
    # @return [Integer]
    def creature_caught
    end
    alias pokemon_captured creature_caught
    # Return the number of Creature captured by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @return [Integer]
    def creature_caught_count(db_symbol)
    end
    # Change the number of Creature captured by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param number [Integer] the new number
    def set_creature_caught_count(db_symbol, number)
    end
    # Increase the number of Creature captured by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    def increase_creature_caught_count(db_symbol)
    end
    alias pokemon_captured_inc increase_creature_caught_count
    # Return the number of Creature fought by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @return [Integer]
    def creature_fought(db_symbol)
    end
    # Change the number of Creature fought by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param number [Integer] the number of Creature fought in the specified specie
    def set_creature_fought(db_symbol, number)
    end
    # Increase the number of Creature fought by specie
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    def increase_creature_fought(db_symbol)
    end
    alias pokemon_fought_inc increase_creature_fought
    # Mark a creature as seen
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param form [Integer] the specific form of the Creature
    # @param forced [Boolean] if the Creature is marked seen even if the Pokedex is disabled
    #                         (Giving Creature before givin the Pokedex).
    def mark_seen(db_symbol, form = 0, forced: false)
    end
    # Unmark a creature as seen
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param form [Integer, false] if false, all form will be unseen, otherwise the specific form will be unseen
    def unmark_seen(db_symbol, form: false)
    end
    # Mark a Creature as captured
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param form [Integer] the specific form of the Creature
    def mark_captured(db_symbol, form = 0)
    end
    # Unmark a Creature as captured
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    def unmark_captured(db_symbol, form = false)
    end
    # Has the player seen a Creature
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @return [Boolean]
    def creature_seen?(db_symbol, form = false)
    end
    alias pokemon_seen? creature_seen?
    alias has_seen? creature_seen?
    # Has the player caught this Creature
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @param form [Integer] the specific form of the Creature
    # @return [Boolean]
    def creature_caught?(db_symbol, form = false)
    end
    alias pokemon_caught? creature_caught?
    alias has_captured? creature_caught?
    # Get the seen forms informations of a Creature
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @return [Integer] An integer where int[form] == 1 mean the form has been seen
    def form_seen(db_symbol)
    end
    alias get_forms form_seen
    # Get the caught forms informations of a Creature
    # @param db_symbol [Symbol] db_symbol of the Creature in the database
    # @return [Integer] An integer where int[form] == 1 mean the form has been caught
    def form_caught(db_symbol)
    end
    # Tell if the creature is unlocked in the current dex state
    # @param db_symbol [Symbol]
    # @return [Boolean]
    def creature_unlocked?(db_symbol)
    end
    # Calibrate the Pokedex information (seen/captured)
    def calibrate
    end
    # Detect the best worldmap to display for the creature
    # @param db_symbol [Symbol] db_symbol of the creature we want the worldmap to display
    # @return [Integer]
    def best_worldmap_for_creature(db_symbol)
    end
    alias best_worldmap_pokemon best_worldmap_for_creature
    # Return the list of the zone id where the creature spawns
    # @param db_symbol [Symbol] db_symbol of the creature we want to know where it spawns
    # @return [Array<Symbol>]
    def spawn_zones(db_symbol)
    end
  end
  class GameState
    # The Pokedex of the player
    # @return [PFM::Pokedex]
    attr_accessor :pokedex
    on_player_initialize(:pokedex) {@pokedex = PFM.dex_class.new(self) }
    on_expand_global_variables(:pokedex) do
      $pokedex = @pokedex
      @pokedex.game_state = self
      @pokedex.convert_to_dot26 if trainer.current_version < 6656
      @pokedex.set_form_caught
    end
  end
end
PFM.dex_class = PFM::Pokedex
module UI
  # Dex sprite that show the Pokemon sprite with its name
  class DexWinSprite < SpriteStack
    # Create a new dex win sprite
    def initialize(viewport)
    end
    # Update the graphics
    def update_graphics
    end
    def data=(pokemon)
    end
    private
    def create_sprites
    end
    # Define if the Pokemon is displayed by the UI
    # @param creature [PFM::Pokemon]
    def update_info_visibility(creature)
    end
  end
  # Dex sprite that show the Pokemon location
  class DexSeenGot < SpriteStack
    # Create a new dex win sprite
    def initialize(viewport)
    end
    private
    def create_sprites
    end
  end
  # Dex sprite that show the Pokemon infos
  class DexWinInfo < SpriteStack
    # Change the data
    # Array of visible sprites if the Pokemon was captured
    VISIBLE_SPRITES = 1..7
    # Create a new dex win sprite
    def initialize(viewport)
    end
    # Define the Pokemon shown by the UI
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
    end
    private
    # Show / hide the sprites according to the captured state of the Pokemon
    def update_capture_visibility(creature)
    end
    def create_sprites
    end
  end
  # Dex sprite that show the Pokemon infos
  class DexButton < SpriteStack
    # Create a new dex button
    # @param viewport [Viewport]
    # @param index [Integer] index of the sprite in the viewport
    def initialize(viewport, index)
    end
    # Change the data
    # @param pokemon [PFM::Pokemon] the Pokemon shown by the button
    def data=(pokemon)
    end
    # Tell the button if it's selected or not : change the obfuscator visibility & x position
    # @param value [Boolean] the selected state
    def selected=(value)
    end
    private
    def create_sprites
    end
    # Adjust the position according to the index
    # @param index [Integer] index of the sprite in the viewport
    def fix_position(index)
    end
    # Change the catch visibility to the captured state of the Pokemon
    def update_catch_icon_visibility(pokemon)
    end
  end
  # Dex sprite that show the Pokemon location
  class DexWinMap < SpriteStack
    # Create a new dex win sprite
    def initialize(viewport, display_controls = true)
    end
    # Change the data and the state
    # @param pokemon [PFM::Pokemon, :map] if set to map, we'll be showing the map icon
    def data=(pokemon)
    end
    # Set the location name
    # @param place [String] the name to display
    # @param color [Integer] the color code
    def set_location(place, color = 10)
    end
    # Set the region name
    # @param place [String] the name to display
    # @param color [Integer] the color code
    def set_region(place, color = 10)
    end
    private
    # Get the icon of the map
    # @return [String]
    def map_icon
    end
    def create_sprites(display_controls)
    end
    def create_controls
    end
  end
end
module GamePlay
  # Class that shows the Pokedex
  class Dex < BaseCleanUpdate::FrameBalanced
    # Text format for the name
    NAME_FORMAT = '%03d - %s'
    # Array of actions to do according to the pressed button
    ACTIONS = %i[action_A action_X action_Y action_B]
    include UI
    # Create a new Pokedex interface
    # @param page_id [PFM::Pokemon, Integer, false] id of the page to show
    def initialize(page_id = false)
    end
    # Update the UI inputs
    def update_inputs
    end
    # Update the mouse interaction with the ctrl buttons
    # @param _moved [Boolean] if the mouse moved during the frame
    def update_mouse(_moved = false)
    end
    private
    # Update the index when changed
    def update_index
    end
    def update_index_descr
    end
    # Update the current creature
    def update_current_creature
    end
    # Action triggered when A is pressed
    def action_A
    end
    # Action triggered when B is pressed
    def action_B
    end
    # Action triggered when X is pressed
    def action_X
    end
    # Action triggered when Y is pressed
    def action_Y
    end
    # Switch the mode of the Pokédex
    def mode_switch
    end
    # Change the state of the Interface
    # @param state [Integer] the id of the state
    def change_state(state)
    end
    # Change the form displayed
    def change_creature_form
    end
    # Find the next seen form after the current one
    def find_next_seen_form(current_form)
    end
    # Retrieve the first form seen for a Pokemon, if a form is specified return in priority the form specified
    # @param data [Array] Array corresponding to the form seen or captured
    # @param form [Integer] if a specific form want to be prioritized
    # @return [Integer] first form seen
    def first_or_prefered_form(data, form = nil)
    end
    # Update the button list
    # @param visible [Boolean]
    def update_list(visible)
    end
    # Calculate the base index of the list
    # @return [Integer]
    def calc_base_index
    end
    # Return the list according to the variant and the mode of the Pokédex
    # @param dex [Array<Studio::Dex::CreatureInfo>]
    # @param unseen [boolean] display of the not seen creatures or not
    def dex_list(dex, unseen = true)
    end
    # Generate the selected_pokemon array
    # @param page_id [Integer, false] see initialize
    def generate_selected_pokemon_array(page_id)
    end
    # Generate the Pokemon Object
    def generate_pokemon_object
    end
    public
    # Create all the graphics
    def create_graphics
    end
    # Update all the graphics
    def update_graphics
    end
    private
    # Update the arrow animation
    def update_arrow
    end
    # Create the viewport and a Stack making the graphic creation easier
    def create_viewport
    end
    # Create the base ui
    def create_base_ui
    end
    # Create the Pokemon list
    def create_list
    end
    # Create arrow (telling which Pokemon we're choosing)
    def create_arrow
    end
    # Create the scrollbar
    def create_scroll_bar
    end
    # Create the frame sprite
    def create_frame
    end
    # Create the face sprite ui
    def create_face
    end
    # Create the progression ui
    def create_progression
    end
    # Create the info ui
    def create_info
    end
    # Create the worldmap ui
    def create_worldmap
    end
    # Get the button text for the generic UI
    # @return [Array<Array<String>>]
    def button_texts
    end
  end
end
GamePlay.dex_class = GamePlay::Dex
