# GTS Script
module GTS
  # Settings of the GTS
  module Settings
    # ID of the game, replace 0 by what you got on the panel
    GAMEID = 67
    # URL of the GTS server
    URL = 'http://gts.kawasemi.de/api.php?i='
    # Condition to see the Pokemon in the search result (All/Seen/Owned)
    SPECIES_SHOWN = 'All'
    # How the Pokemon are searched (Alphabetical/Regional)
    SORT_MODE = 'Alphabetical'
    # List of black listed Pokemon (filtered out of the search) put ID or db_symbol here
    BLACK_LIST = []
    # Internal Game Code to know if the Pokemon comes from this game or another (like DPP <-> HGSS)
    GAME_CODE = '255'
    # Scene BGM (Complete path in lower case without extname)
    BGM = 'audio/bgm/xy_gts'
  end
  module_function
  # Main Method
  def open
  end
  # Return the loading screen
  # @return [LoadingScreen]
  def loading_screen
  end
  # Finishes the GTS trade
  # @param my_pokemon [PFM::Pokemon] the player's Pokemon
  # @param new_poke [PFM::Pokemon] the traded Pokemon
  # @param choice [Integer, nil] the choice made in the Box in order to correctly remove the Pokemon
  # @param searching [Boolean] if the Pokemon was got from searching (implying choice to be Integer)
  # @param id [Integer] online ID
  def finish_trade(my_pokemon, new_poke, searching, choice = nil, id = nil)
  end
  # Finishes the GTS trade (delete pokemon from data & insert traded Pokemon in party)
  # @param my_pokemon [PFM::Pokemon] the player's Pokemon
  # @param new_poke [PFM::Pokemon] the traded Pokemon
  # @param choice [Integer, nil] the choice made in the Box in order to correctly remove the Pokemon
  # @param id [Integer] online ID
  def finish_trade_from_searching(my_pokemon, new_poke, choice, id)
  end
  ##### Brings up all species of pokemon of the given index of the given sort mode
  def order_species(index)
  end
  # Return the specie list filtered with the criteria (seen, got, black_list)
  # @return [Array<Integer>]
  def species_list_from_criteria
  end
  # List of the genders
  def genders
  end
  # GTS Button, A Basic options button for our GTS System
  class Button < UI::SpriteStack
    def initialize(viewport, x, y, name = '')
    end
    # Width of the button
    # @return [Integer]
    def width
    end
  end
  # GTS Search Method Selection
  class SearchMethod < GamePlay::BaseCleanUpdate
    # Create the new SearchMethod object
    def initialize
    end
    # Update the inputs
    def update_inputs
    end
    private
    # Update the sprites
    def update_graphics
    end
    # Update the selector position
    def update_selector
    end
    # Create all the sprites
    def create_graphics
    end
    # Create the Spriteset and the Background with the right scene_name
    # @param scene_name [String] name of the scene shown on screen
    def create_spriteset_and_background(scene_name = ext_text(8997, 3))
    end
    # Create the actions sprites
    # @param width2 [Integer] half of the view width
    def create_action_sprites(width2)
    end
    # Create the selectors
    def create_selection
    end
    # Execute the actions according to the index
    def do_command
    end
    # Ask the player to select a Pokemon in the given list
    # @param pokemon_list [Array<PFM::Pokemon>]
    # @return [Integer, false]
    def select_pokemon(pokemon_list)
    end
    # Ask the player to confirm if he wants to take the given wanted_data
    # @param wanted_data [Array<Integer>]
    # @return [Boolean]
    def confirm_wanted_data(wanted_data)
    end
    # Ask the player to choose a Pokemon in the storage
    # @return [Integer, nil]
    def choose_pokemon
    end
    # Search by player's requirements
    def do_command0
    end
    # Search using a Pokemon that could meet the requirement
    def do_command1
    end
    # Search using the online ID of the trainer
    def do_command2
    end
    # Test if the Pokemon match the requirement
    # @param pkmn [PFM::Pokemon] pokemon
    # @param wanted_data [Array<Integer>] requirements
    def pokemon_matching_requirements?(pkmn, wanted_data)
    end
  end
  # GTS Wanted Data, shows a screen on which you can create wanted data
  class WantedDataScene < SearchMethod
    # @return [Array, -1] the choosen wanted data
    attr_reader :wanted_data
    # Create a new WantedDataScene
    def initialize
    end
    # Update the inputs
    def update_inputs
    end
    private
    # Create all the sprites
    def create_graphics
    end
    def draw_wanted_data
    end
    # Create the Spriteset and the Background with the right scene_name
    def create_spriteset_and_background
    end
    # Create the actions sprites
    # @param width2 [Integer] half of the view width
    def create_action_sprites(width2)
    end
    # Execute the actions according to the index
    def do_command
    end
    def do_command0
    end
    undef do_command1
    # Ask the level requirements
    def do_command2
    end
  end
  # Scene GTS Main GTS Functionality here.
  class Scene < SearchMethod
    def initialize
    end
    private
    # Create the Spriteset and the Background with the right scene_name
    def create_spriteset_and_background
    end
    # Create the actions sprites
    # @param width2 [Integer] half of the view width
    def create_action_sprites(width2)
    end
    def refresh_sprites
    end
    # Execute the actions according to the index
    def do_command
    end
    undef do_command0
    # Perform the action related to the Pokemon on the GTS
    def do_command1
    end
    undef do_command2
    # Brings up a summary of your uploaded pokemon (also allows you to delete it)
    def summary
    end
  end
  # Selection of a Pokemon in a List
  class SummarySelect < GamePlay::Summary
    # @return [Integer, false] Index of the Pokemon the player wants in the list
    attr_accessor :return_data
    # Create a new SummarySelect
    def initialize(list)
    end
    # Overload the update inputs to ask if the player wants the current Pokemon
    def update_inputs
    end
    # Overload the mouse_quit to ask if the player really wants to quit (without choosing)
    def mouse_quit
    end
  end
  # Show a Pokemon with its requirement in order to trade
  class SummaryWanted < GamePlay::Summary
    attr_accessor :return_data
    def initialize(wanted_data)
    end
    # Force the button to disabled unless it's the cancel one
    def ctrl_id_state
    end
    # Ask if the player wants to accept this trade
    def update_inputs
    end
    # Ask if the player wants to decline
    def mouse_quit
    end
    # Create the graphics of the wanted summary UI
    def create_graphics
    end
    # Create the various UI
    def create_uis
    end
    # Draw the wanted info
    def draw_page_one_gts_wanted(wanted_data)
    end
  end
  # Child of the Memo that doesn't write the text_info itself
  class Summary_Memo_GTS < UI::Summary_Memo
    attr_reader :text_info
    alias load_text_info void
  end
  module Core
    @uri = URI(Settings::URL + Settings::GAMEID.to_s)
    # Locking mutex
    LOCK = Mutex.new
    module_function
    # Update the URI
    def update_uri
    end
    # Tests connection to the server (not used anymore but kept for possible use)
    def test_connection
    end
    # Our main execution method, since I'm too lazy to write Settings::URL a lot
    def execute(action, data = {})
    end
    # gets a new online ID from the server
    def obtain_online_id
    end
    # registers our new online ID to the server
    def register_online_id(id)
    end
    # checks whether you have a pokemon uploaded in the server
    def pokemon_uploaded?(id = PFM.game_state.online_id)
    end
    # sets the pokemon with the given online ID to taken
    def take_pokemon(id)
    end
    # checks wether the pokemon with the give online ID is taken
    def pokemon_taken?(id = PFM.game_state.online_id)
    end
    # uploads a pokemon to the server
    def upload_pokemon(pokemon, *wanted_data)
    end
    # uploads the newly traded pokemon to the given online ID to the server
    def upload_new_pokemon(id, pokemon)
    end
    # downloads a pokemon string with the given online ID
    def download_pokemon(id)
    end
    # downloads the wanted data with the given online ID
    def download_wanted_data(id)
    end
    # deletes your current pokemon from the server
    def delete_pokemon(withdraw = true, party = PFM.game_state)
    end
    # gets a list of online IDs where the wanted data match up
    def get_pokemon_list(*wanted_data)
    end
    # Reverse Lookup pokemon
    def get_pokemon_list_from_wanted(pokemon)
    end
    # installs the MYSQL tables in the server
    def install
    end
    # Translate the wanted gender field for the server
    def translate_gender(wanted)
    end
  end
  # Class showing the loading during server requests
  class LoadingScreen < UI::SpriteStack
    # Create a new LoadingScreen
    # @param viewport [Viewport] viewport used by the loading screen
    def initialize(viewport)
    end
    # Blocking method that makes the "LoadingScreen" process it's loading display
    def process
    end
  end
end
__LINE__.to_i
module PFM
  class GameState
    attr_accessor :online_pokemon
    # Retrieve the online ID of the trainer
    # @return [Integer]
    def online_id
    end
    # The raw_online_id doesn't have the checksum to get a new ID, this is used for
    # when you do new game.
    # @return [Integer, nil]
    def raw_online_id
    end
  end
  # Add a game_code field and to_s method to the pokemon class
  class Pokemon
    # Code of the game where the Pokemon comes from (nil if the Pokemon hasn't been tainted by GTS system)
    # @return [Integer, nil]
    attr_accessor :game_code
    # Encode the Pokemon to a String in order to send it to the GTS system
    # @return [String]
    def encode
    end
  end
end
# Add a to_pokemon method to the string class
class String
  # Convert string to Pokemon if possible
  # @return [PFM::Pokemon, nil]
  def to_pokemon
  end
end
__LINE__.to_i
module GamePlay
  class Save
    alias gts_save_game save_game
    def save_game
    end
  end
end
