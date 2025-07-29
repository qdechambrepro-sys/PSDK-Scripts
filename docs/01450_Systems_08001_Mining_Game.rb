module GameData
  # Module that describes the Mining Game database and its derived methods
  module MiningGame
    module_function
    # Sign that indicate a part of the ITEM exist on a specific tile of a layout
    # @return true
    def x
    end
    # Sign that indicate a part of the ITEM does not exist on a specific tile of a layout
    # @return false
    def o
    end
    # Register an item
    # @param db_symbol [Symbol] db_symbol of the item
    # @param probability [Integer] chance of the item to appear
    # @param layout [Array<Array<boolean>>] layout of the item
    # @param accepted_max_rotation [Integer] ask Rey about it
    def register_item(db_symbol, probability, layout, accepted_max_rotation)
    end
    # Register an iron
    # @param symbol [Symbol] unique name of the iron
    # @param probability [Integer] chance of the iron to appear
    # @param layout [Array<Array<boolean>>] layout of the iron
    # @param accepted_max_rotation [Integer] ask Rey about it
    def register_iron(symbol, probability, layout, accepted_max_rotation)
    end
    # The data list of each item that exist for the MiningGame
    # probability is an Integer and states how many chances out of the total of chances the item will be picked by the system.
    # layout is a [Array<Array>] where each sub-Array is assigned to one line; x means a part of the ITEM is here, o means that's not the case.
    # accepted_max_rotation is an Integer (between 0 and 3) determining the max rotation the sprite can have (90x degrees, x being accepted_max_rotation).
    DATA_ITEM = {}
    register_item(:blue_shard, 20, [[x, x, x], [x, x, x], [x, x, o]], 3)
    register_item(:green_shard, 20, [[x, x, x, x], [x, x, x, x], [x, x, o, x]], 3)
    register_item(:red_shard, 20, [[x, x, x], [x, x, o], [x, x, x]], 3)
    register_item(:yellow_shard, 20, [[x, o, x, o], [x, x, x, o], [x, x, x, x]], 3)
    register_item(:everstone, 1, [[x, x, x, x], [x, x, x, x]], 3)
    register_item(:dawn_stone, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:dusk_stone, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:fire_stone, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:ice_stone, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:leaf_stone, 1, [[o, x, o], [x, x, x], [x, x, x], [x, x, x]], 1)
    register_item(:moon_stone, 1, [[o, x, x, x], [x, x, x, o]], 1)
    register_item(:shiny_stone, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:sun_stone, 1, [[o, x, o], [x, x, x], [x, x, x]], 3)
    register_item(:thunder_stone, 1, [[o, x, x], [x, x, x], [x, x, o]], 3)
    register_item(:water_stone, 1, [[x, x, x], [x, x, x], [x, x, o]], 3)
    register_item(:damp_rock, 5, [[x, x, x], [x, x, x], [x, o, x]], 3)
    register_item(:hard_stone, 5, [[x, x], [x, x]], 0)
    register_item(:heart_scale, 20, [[x, o], [x, x]], 3)
    register_item(:heat_rock, 5, [[x, o, x, o], [x, x, x, x], [x, x, x, x]], 3)
    register_item(:icy_rock, 5, [[o, x, x, o], [x, x, x, x], [x, x, x, x], [x, o, o, x]], 3)
    register_item(:iron_ball, 5, [[x, x, x], [x, x, x], [x, x, x]], 0)
    register_item(:light_clay, 5, [[x, o, x, o], [x, x, x, o], [x, x, x, x], [o, x, o, x]], 3)
    register_item(:max_revive, 1, [[x, x, x], [x, x, x], [x, x, x]], 3)
    register_item(:odd_keystone, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x], [x, x, x, x]], 3)
    register_item(:rare_bone, 1, [[x, o, o, o, o, x], [x, x, x, x, x, x], [x, o, o, o, o, x]], 1)
    register_item(:revive, 5, [[o, x, o], [x, x, x], [o, x, o]], 1)
    register_item(:smooth_rock, 5, [[o, o, x, o], [x, x, x, o], [o, x, x, x], [o, x, o, o]], 3)
    register_item(:star_piece, 5, [[o, x, o], [x, x, x], [o, x, o]], 0)
    register_item(:draco_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:dread_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:earth_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:fist_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:flame_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:icicle_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:insect_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:iron_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:meadow_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:mind_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:pixie_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:sky_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:splash_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:spooky_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:stone_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:toxic_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:zap_plate, 1, [[x, x, x, x], [x, x, x, x], [x, x, x, x]], 1)
    register_item(:armor_fossil, 5, [[o, x, x, x, o], [o, x, x, x, o], [x, x, x, x, x], [o, x, x, x, o]], 3)
    register_item(:claw_fossil, 5, [[o, o, x, x], [o, x, x, x], [o, x, x, x], [x, x, x, o], [x, x, o, o]], 3)
    register_item(:dome_fossil, 5, [[x, x, x, x, x], [x, x, x, x, x], [x, x, x, x, x], [o, x, x, x, o]], 3)
    register_item(:helix_fossil, 5, [[o, x, x, x], [x, x, x, x], [x, x, x, x], [x, x, x, o]], 3)
    register_item(:old_amber, 5, [[o, x, x, x], [x, x, x, x], [x, x, x, x], [x, x, x, o]], 1)
    register_item(:root_fossil, 5, [[x, x, x, x, o], [x, x, x, x, x], [x, x, o, x, x], [o, o, o, x, x], [o, o, x, x, o]], 3)
    register_item(:skull_fossil, 5, [[x, x, x, x], [x, x, x, x], [x, x, x, x], [o, x, x, o]], 3)
    # The data list of each iron that exist for the MiningGame
    # probability is an Integer and states how many chances out of the total of chances the item will be picked by the system.
    # layout is a [Array<Array>] where each sub-Array is assigned to one line; x means a part of the ITEM is here, o means that's not the case.
    # accepted_max_rotation is an Integer (between 0 and 3) determining the max rotation the sprite can have (90x degrees, x being accepted_max_rotation).
    DATA_IRON = {}
    register_iron(:anti_stair, 20, [[x, o], [x, x], [o, x]], 1)
    register_iron(:big_square, 20, [[x, x, x], [x, x, x], [x, x, x]], 0)
    register_iron(:line, 20, [[x, x, x, x]], 1)
    register_iron(:rectangle, 20, [[x, x, x, x], [x, x, x, x]], 1)
    register_iron(:square, 20, [[x, x], [x, x]], 0)
    register_iron(:stair, 20, [[o, x], [x, x], [x, o]], 1)
    register_iron(:t_tetrimino, 20, [[o, x, o], [x, x, x]], 3)
    # Return the total of the chances to get a certain item
    # @return [Integer]
    def total_chance
    end
    # Return the total of the chances to get a certain iron
    # @return [Integer]
    def iron_total_chance
    end
  end
end
module PFM
  # Class describing the Hall_of_Fame logic
  class MiningGame
    # If the player is playing the mini-game for the first time
    # @return [Boolean]
    attr_accessor :first_time
    # If the player has access to the new dynamite tool
    # @return [Boolean]
    attr_accessor :dynamite_unlocked
    # Tells how many items the player has dug
    # @return [Integer]
    attr_accessor :nb_items_dug
    # Tells how many times the player has launched the mini-game
    # @return [Integer]
    attr_accessor :nb_game_launched
    # Tells how many times the player succeeded in the mini-game (every items dug)
    # @return [Integer]
    attr_accessor :nb_game_success
    # Tells how many times the player failed in the mini-game (wall collapsing)
    # @return [Integer]
    attr_accessor :nb_game_failed
    # Tells how many times the player used the pickaxe
    # @return [Integer]
    attr_accessor :nb_pickaxe_hit
    # Tells how many times the player used the mace
    # @return [Integer]
    attr_accessor :nb_mace_hit
    # Tells how many times the player used the dynamite
    # @return [Integer]
    attr_accessor :nb_dynamite_hit
    # Set the difficulty of the game (true = no yellow tiles at beginning)
    # @return [Boolean]
    attr_accessor :hard_mode
    def initialize
    end
    # Class handling the grid for the mining game
    class GridHandler
      # Constant telling the minimum amount of item possible on a grid
      MIN_ITEM_COUNT = 2
      # Constant telling the maximum amount of item possible on a grid
      MAX_ITEM_COUNT = 5
      # Constant telling at how many unsuccessful tries the system switched from full randomness to semi-randomness
      # A lower number means the system will switch to a more mechanical way earlier
      # Might yield unexpected result, !!! Change with caution !!!
      # @return [Integer]
      SWITCH_METHOD_TRIES = 25
      # Constant telling the max number of tries the system has to randomly place an item or an iron
      # A higher number means a better probability of success but also means a higher loading time
      # !!! Change with caution !!!
      # @return [Integer]
      MAX_TRIES_ALLOWED = 50
      # Get the grid width
      # @return [Integer]
      attr_reader :width
      # Get the grid height
      # @return [Integer]
      attr_reader :height
      # Get the tile states
      # @return [Array<Array<Integer>>]
      attr_reader :arr_tiles_state
      # Get the list of diggable items
      # @return [Array<Diggable>]
      attr_reader :arr_items
      # Get the list of irons
      # @return [Array<Diggable>]
      attr_reader :arr_irons
      # Create a new grid handler
      # @param wanted_items [Array<Symbol>, nil] list of wanted items
      # @param item_count [Integer, nil] maximum number of items
      # @param grid_width [Integer] width of the grid
      # @param grid_height [Integer] height of the grid
      def initialize(wanted_items, item_count, grid_width, grid_height)
      end
      # Tell if the mining game grid is ready
      # @return [Boolean]
      def ready?
      end
      # Check if a diggable is present at the said coordinate and return it if it's an item
      # @param x [Integer] x coordinate where we went to find the diggable
      # @param y [Integer] y coordinate where we went to find the diggable
      # @return [Diggable, Boolean] Diggable instance if item, true if iron, false if nothing
      def check_presence_of_diggable(x, y)
      end
      private
      # Generate a random array of items to dig
      # @param nb_items [Integer] number of items to generate
      # @return [Array<Hash>]
      def randomize_items(nb_items)
      end
      # Initialize the grid content using a thread to profit of Graphics.update on slow computer
      def initialize_grid_content
      end
      # Function that places the hiding tiles on the grid
      def launch_tile_state_procedure
      end
      # Tell if all tiles are placed
      # @return [Boolean]
      def all_tile_placed?
      end
      # Get the first unplaced tile
      # @return [Array<Array(Integer, Integer)>]
      def first_tile
      end
      # Function that update the state of all the adjacent tiles from arr tiles
      def update_tiles_state(arr)
      end
      # Function that gives all the possible adjacent tiles and update probabilities
      def get_any_adjacent_tile(arr)
      end
      # Function that add the north tile to new_arr if possible
      # @param new_arr [Array]
      # @param y [Integer]
      # @param x [Integer]
      def add_north_tile(new_arr, y, x)
      end
      # Function that add the south tile to new_arr if possible
      # @param new_arr [Array]
      # @param y [Integer]
      # @param x [Integer]
      def add_south_tile(new_arr, y, x)
      end
      # Function that west the south tile to new_arr if possible
      # @param new_arr [Array]
      # @param y [Integer]
      # @param x [Integer]
      def add_west_tile(new_arr, y, x)
      end
      # Function that west the south tile to new_arr if possible
      # @param new_arr [Array]
      # @param y [Integer]
      # @param x [Integer]
      def add_east_tile(new_arr, y, x)
      end
      # Function that sets the state to all tiles contained in arr
      # @param arr [Array<Array(Integer, Integer)>] array of tile coordinate
      # @param state [Integer]
      def set_state_in_array(arr, state)
      end
      # Function that place all the items on the grid
      def launch_item_placement_procedure
      end
      # Function that create all the digable objects
      # @param items [Array<Hash>]
      # @return [Array<Diggable>]
      def create_diggables(items)
      end
      # Function that maps an Array of Symbol to Hashes in order to make sure they're mappable to diggable
      # @param arr [Array<Symbol>]
      # @return [Array<Hash>]
      def map_symbol2hash(arr)
      end
      # Function that place the diggable on the map
      # @param array [Array<Diggable>]
      def place_diggable(array)
      end
      # Function that generates a random position for a diggable
      # @param diggable [Diggable] the diggable used to clamp the width and height
      # @return [Array(Integer, Integer)]
      def random_diggable_position(diggable)
      end
      # Function that generates a random position using a quarter of the screen for the diggable
      # @param diggable [Diggable] the diggable used to clamp the width and height
      # @return [Array(Integer, Integer)]
      def alternate_random_diggable_position(diggable)
      end
      # Function that tries to map available spaces depending on the diggable and return one randomly
      # Will return 0, 0 if impossible
      # @param diggable [Diggable]
      # @return [Array(Integer, Integer)]
      def final_random_diggable_position(diggable)
      end
      # Function that check if a diggable is well placed
      # @param diggable [Diggable]
      # @return [Boolean]
      def check_diggable_well_placed(diggable)
      end
      # Function that place all the irons on the grid
      def launch_iron_placement_procedure
      end
      # Function that randomize the irons and their
      def randomize_irons
      end
    end
    # Class handling the property of a diggable element
    class Diggable
      # The x position of the diggable
      # @return [Integer]
      attr_accessor :x
      # The y position of the diggable
      # @return [Integer]
      attr_accessor :y
      # The width of the diggable
      # @return [Integer]
      attr_accessor :width
      # The height of the diggable
      # @return [Integer]
      attr_accessor :height
      # The symbol of the item the Diggable represent
      # @return [Symbol]
      attr_accessor :symbol
      # The original pattern of the diggable
      # @return [Array<Array<Boolean>>]
      attr_accessor :origin_pattern
      # The current pattern of the diggable
      # @return [Array<Array<Boolean>>]
      attr_accessor :pattern
      # The accepted rotation of the diggable
      # @return [Integer]
      attr_accessor :accepted_rotation
      # The current rotation of the diggable
      # @return [Integer]
      attr_accessor :rotation
      # If the diggable is an item or not (then it's an iron)
      # @return [Boolean]
      attr_accessor :is_an_item
      # If the diggable is placed or not
      # @return [Boolean]
      attr_accessor :placed
      # If the diggable is revealed
      # @return [Boolean]
      attr_accessor :revealed
      def initialize(hash)
      end
      # Set a new rotation to the diggable and change values accordingly
      def set_new_rotation
      end
      # Set a specific rotation to the diggable and change values accordingly
      # @param rotation [Integer]
      def set_specific_rotation(rotation)
      end
      # Test if another diggable is overlapping this diggable
      # @param diggable [Diggable]
      # @return [Boolean]
      def overlap?(diggable)
      end
      # Give the area size (for sorting purpose)
      def area_size
      end
      private
      # Rotate the pattern according to the new rotation
      def rotate_object
      end
      # Set the width and height of the diggable depending on current pattern
      def set_width_and_length
      end
      # Check if two ranges are overlapping
      def range_overlapping?(range1, range2)
      end
    end
  end
  class GameState
    # Stats and booleans relative to the Mining Game
    # @return [PFM::MiningGame]
    attr_accessor :mining_game
    on_player_initialize(:mining_game) {@mining_game = PFM::MiningGame.new }
    on_expand_global_variables(:mining_game) do
      @mining_game ||= PFM::MiningGame.new
    end
  end
end
module UI
  module MiningGame
    # Class that describes the Background of the Mining Game
    class Background < Sprite
      # Create the background
      # @param viewport [Viewport] the viewport of the scene
      def initialize(viewport)
      end
      private
      # The filename of the background depending on the use of the dynamite or not
      # @return [String]
      def background_filename
      end
    end
    # Class that describes the Diggable_Sprite object
    class Diggable_Sprite < ShaderedSprite
      # Create the Diggable_Sprite
      # @param viewport [Viewport] the viewport of the scene
      # @param item [PFM::MiningGame::Diggable] the item/iron object
      def initialize(viewport, item)
      end
      private
      # Return the correct pathname for the image
      # @return [String]
      def image_path
      end
      # Return the correct origin point for after rotating the image
      # @return [Array<Integer>]
      def correct_origin
      end
    end
    # Class that describes the Diggable_Stack
    class Diggable_Stack < SpriteStack
      # @return [Array<UI::MiningGame::Diggable_Sprite] the array containing every items' sprite
      attr_accessor :item_arr
      # @return [Array<UI::MiningGame::Diggable_Sprite] the array containing every irons' sprite
      attr_accessor :iron_arr
      # Create the Diggable_Stack
      # @param viewport [Viewport] the viewport of the scene
      # @param item_arr [Array<PFM::MiningGame::Diggable] the array containing the items to dig
      # @param iron_arr [Array<PFM::MiningGame::Diggable] the array containing the irons to not dig
      def initialize(viewport, item_arr, iron_arr)
      end
      private
      # Return the x coordinate of the SpriteStack
      # @return [Integer]
      def initial_x
      end
      # Return the y coordinate of the SpriteStack
      # @return [Integer]
      def initial_y
      end
    end
    # Class that describes the Hit_Counter_Sprite
    class Hit_Counter_Sprite < SpriteSheet
      # @return [Integer] the current state
      attr_accessor :state
      # @return [Symbol] the symbol corresponding to the Hit_Counter_Sprite number (:first or :not_first)
      attr_accessor :reason
      # Create the Hit_Counter_Sprite
      # @param viewport [Viewport] the viewport of the scene
      # @param reason [Symbol] the symbol corresponding to the Hit_Counter_Sprite number
      def initialize(viewport, reason)
      end
      # Change the state of the Hit_Counter_Sprite
      def change_state
      end
      # Return the number of images on a same column
      # @return [Integer]
      def number_of_image_y
      end
      private
      # Return the number of images on a same line
      # @return [Integer]
      def number_of_image_x
      end
      # Return the right image filename
      # @return [String]
      def bitmap_filename
      end
      # Update the sheet appearance
      def update_sheet
      end
      # Set the visibility of the sprite
      def set_visible
      end
    end
    # Class that describes the SpriteStack containing all the Hit_Counter_Sprite
    class Hit_Counter_Stack < SpriteStack
      # X Coordinates of first and second Hit_Counter_Sprite
      COORD_X = [206, 182]
      # The X space between all Hit_Counter_Sprite (except first and second)
      SPACE_BETWEEN_CRACKS = 24
      # Y Coordinates of first and every other Hit_Counter_Sprite
      COORD_Y = [0, 2]
      # Max number of Cracks
      NUMBER_OF_CRACKS = 10
      # Max number of hits the wall can take
      MAX_NB_HIT = 61
      # @return [Integer] the current number of hit
      attr_accessor :nb_hit
      # Create the Hit_Counter_Stack
      # @param viewport [Viewport] the viewport of the scene
      def initialize(viewport)
      end
      # Method that send the correct number of hits
      # @param reason [Symbol] the symbol of the tool used to hit
      def send_hit(reason)
      end
      # Check if the current number of hits is equal the max amount of hit
      # @return [Boolean]
      def max_cracks?
      end
      private
      # Get the good X coordinates for setting the Hit_Counter_Sprite
      # @param i [Integer] the index of the Hit_Counter_Sprite
      # @return [Integer]
      def get_x(i)
      end
      # Get the good Y coordinates for setting the Hit_Counter_Sprite
      # @param i [Integer] the index of the Hit_Counter_Sprite
      # @return [Integer]
      def get_y(i)
      end
      # Return the number of hit for the pickaxe
      # @return [Integer]
      def pickaxe
      end
      # Return the number of hit for the mace
      # @return [Integer]
      def mace
      end
      # Return the number of hit for the dynamite
      # @return [Integer]
      def dynamite
      end
    end
    # Class that describes the Tiles sprite
    class Tiles < SpriteSheet
      # @return [Integer] state of the tile
      attr_accessor :state
      # Create the Tiles
      # @param viewport [Viewport]
      # @param state [Integer] the state the image is initialized on (between 0 and 6)
      def initialize(viewport, state)
      end
      # Update the state of the sheet
      def update_sx
      end
      # Lower the state and update the image in consequence
      # @param reason [Symbol] the reason of lowering
      def lower_state(reason)
      end
      private
      # The number of column of the sheet
      # @return [Integer]
      def number_of_y_images
      end
      # The number of possible state of a tile
      # @return [Integer]
      def possible_state_number
      end
    end
    # Class that describes the Tiles_Stack object
    class Tiles_Stack < SpriteStack
      # The length of the texture for each tile
      # @return [Integer]
      TEXTURE_LENGTH = 16
      # The length of the texture for each tile
      # @return [Integer]
      TEXTURE_WIDTH = 16
      # @return [Array<UI::MiningGame::Tiles] the array containing all the Tiles sprite
      attr_accessor :tile_array
      # Create the Tiles_Stack
      # @param viewport [Viewport] the viewport of the scene
      # @param arr [Array<Array<Integer>>] the array containing the arrays containing the tiles (columns<lines<tiles state>>)
      def initialize(viewport, arr)
      end
      # Get the Tiles sprite at given coordinates
      # @param x [Integer]
      # @param y [Integer]
      # @return [UI::MiningGame::Tiles] the tile required
      def get_tile(x, y)
      end
      # Get the Tiles sprite adjacent to the one at given coordinates
      # @param x [Integer]
      # @param y [Integer]
      # @return [Array<UI::MiningGame::Tiles>] the tiles required
      def get_adjacent_of(x, y)
      end
      # Return the texture length
      # @return [Integer]
      def texture_length
      end
      # Return the texture width
      # @return [Integer]
      def texture_width
      end
      private
      # Return the initial x coordinate of Tiles_Stack
      # @return [Integer]
      def initial_x
      end
      # Return the initial x coordinate of Tiles_Stack
      # @return [Integer]
      def initial_y
      end
      # Return the filename of the image
      # @return [String]
      def bitmap_filename
      end
    end
    # Class describing the Tool_Sprite object
    class Tool_Sprite < SpriteSheet
      # @return [Symbol] the symbol of the currently used tool
      attr_accessor :tool
      # Create the Tool_Sprite
      def initialize(viewport)
      end
      # Increase x attribute by nb
      # @param nb [Integer]
      def add_to_x(nb)
      end
      # Decrease x attribute by nb
      # @param nb [Integer]
      def sub_to_x(nb)
      end
      # Increase y attribute by nb
      # @param nb [Integer]
      def add_to_y(nb)
      end
      # Decrease y attribute by nb
      # @param nb [Integer]
      def sub_to_y(nb)
      end
      # Set the next frame of the sheet
      def new_frame
      end
      # Change the tool image
      # @param sym_tool [Symbol] the symbol of the currently used tool
      def change_tool(sym_tool)
      end
      private
      # Return the number of images on a same line
      # @return [Integer]
      def number_image_x
      end
      # Return the number of images on a same column
      # @return [Integer]
      def number_image_y
      end
      # Set the new image of the sheet
      def change_image
      end
    end
    # Class that describes the buttons that let the player choose his tool
    class Tool_Buttons < SpriteStack
      # Coordinates in no dynamite mode
      COORD_Y_2_TOOLS = [0, 80]
      # Coordinates in dynamite mode
      COORD_Y_3_TOOLS = [0, 64, 128]
      # Symbols of the tools
      TOOL_FILENAME = ['pickaxe', 'mace', 'dynamite']
      # @return [Integer] the currently selected button
      attr_accessor :index
      # @return [Array<SpriteSheet>] the array containing each button
      attr_accessor :buttons
      # @return [Yuki::Animation::TimedAnimation] the animation played when selecting a button
      attr_accessor :animation
      # Create the tool buttons
      # @param viewport [Viewport] the viewport of the scene
      def initialize(viewport)
      end
      # Change the state of each button depending on the one that is hit
      # @param index [Integer] the index of the hitted button
      # @return [Symbol] the symbol of the new tool to use
      def change_buttons_state(index)
      end
      # Cycle through the buttons with a keyboard input
      # @return [Symbol] the symbol of the new tool to use
      def cycle_through_buttons
      end
      private
      # Initial coordinates of the SpriteStack
      # @return [Array<Integer>]
      def initial_coordinates
      end
      # Change the tool buttons state and set the new tool
      # @return [Symbol] the symbol of the new tool to use
      def button_state_change
      end
      # Method that setup the button hit animation
      # @return [Yuki::Animation::TimedAnimation]
      def button_animation
      end
    end
    # Class that describes the Tool_Hit_Sprite object
    class Tool_Hit_Sprite < Tool_Sprite
      # Create the Tool_Hit_Sprite
      # @param viewport [Viewport] the viewport of the scene
      def initialize(viewport)
      end
      # Number of images on the same line
      # @return [Integer]
      def number_image_x
      end
      # Set the new image of the sheet
      def change_image
      end
    end
    class KeyboardCursor < Sprite
      # Initialize the KeyboardCursor component
      # @param viewport [Viewport]
      # @param initial_coordinates [Array<Integer>] the initial coordinates defined by the INITIAL_CURSOR_COORDINATES constant
      def initialize(viewport, initial_coordinates)
      end
      # Change the coordinates of the cursor to change its position
      # @param [Array<Integer>] array containing the x coordinate and the y coordinate
      def change_coordinates(coordinates)
      end
      private
      # Setup some attributes during the initialization of the Sprite
      def setup_attributes
      end
      # Calibrate the position of the cursor depending on its coordinates
      def calibrate_position
      end
      # Give the base x coordinate used to calibrate the cursor
      # @return [Integer]
      def base_x
      end
      # Give the base y coordinate used to calibrate the cursor
      # @return [Integer]
      def base_y
      end
      # Give the offset x induced by the sprite used to calibrate the cursor
      # @return [Integer]
      def sprite_induced_offset_x
      end
      # Give the offset y induced by the sprite used to calibrate the cursor
      # @return [Integer]
      def sprite_induced_offset_y
      end
      # Give the length of the texture of the mining tiles as defined in Tiled_Stack
      # @return [Integer]
      def tile_texture_length
      end
      # Give the width of the texture of the mining tiles as defined in Tiled_Stack
      # @return [Integer]
      def tile_texture_width
      end
      # Give the filename of the image used for this sprite
      # @return [String]
      def image_filename
      end
    end
  end
end
module GamePlay
  # Class that describes the functionment of the scene
  class MiningGame < BaseCleanUpdate::FrameBalanced
    # Constant that stock the Database of the Mining Game
    DATA = GameData::MiningGame::DATA_ITEM
    # The base music of the scene
    DEFAULT_MUSIC = 'audio/bgm/mining_game'
    # The number of tiles per lines in the table
    NB_X_TILES = 16
    # The number of tiles per columns in the table
    NB_Y_TILES = 13
    # The initial coordinates of the cursor used when in keyboard mode
    INITIAL_CURSOR_COORDINATES = [NB_X_TILES / 2, NB_Y_TILES / 2]
    # IDs of the text displayed when playing for the first time
    FIRST_TIME_TEXT = [[9005, 6], [9005, 7], [9005, 8], [9005, 10], [9005, 11], [9005, 12]]
    # IDs of the text displayed when playing for the first time (dynamite mode)
    FIRST_TIME_TEXT_ALTERNATIVE = [9005, 9]
    # List of the usable tools
    TOOLS = %i[pickaxe mace dynamite]
    # Pathname of the SE folder
    SE_PATH = 'audio/se/mining_game'
    # @return [UI::MiningGame::Tiles_Stack]
    attr_accessor :tiles_stack
    # @return [Array<PFM::MiningGame::Diggable>]
    attr_accessor :arr_items_won
    # Initialize the UI
    # @overload initialize(item_count, music_filename = DEFAULT_MUSIC)
    #   @param item_count [Integer, nil] the number of items to search (nil for random between 2 and 5)
    #   @param music_filename [String] the filename of the music to play
    #   @param grid_handler [PFM::MiningGame::GridHandler, nil] hand-chosen grid handler
    # @overload initialize(wanted_item_db_symbols, music_filename = DEFAULT_MUSIC)
    #   @param wanted_item_db_symbols [Array<Symbol>] the array containing the specific items (comprised between 1 and 5 items)
    #   @param music_filename [String] the filename of the music to play
    #   @param grid_handler [PFM::MiningGame::GridHandler, nil] hand-chosen grid handler
    def initialize(param = nil, music_filename = DEFAULT_MUSIC, grid_handler: nil)
    end
    private
    # Save the current instance of the Mining Game in a file
    def save_instance_for_debug
    end
    public
    include UI::MiningGame
    private
    # Create the graphics
    def create_graphics
    end
    # Update the graphics that needs to be updated (and @animation)
    def update_graphics
    end
    # Create the viewports
    def create_viewport
    end
    # Create the map snapshot
    def create_snapshot
    end
    # Create the transition sprite
    def create_transition_sprite
    end
    # Create the background
    def create_background
    end
    # Create the tool buttons
    def create_tool_buttons
    end
    # Create the stack of diggables
    def create_diggable_stacks
    end
    # Create the stack of tiles
    def create_tiles_stack
    end
    # Create the hit counter
    def create_hit_counter
    end
    # Create the tool's sprite
    def create_tool_sprite
    end
    # Create the tool's hit sprite
    def create_tool_hit_sprite
    end
    # Create the iron's hit sprite
    def create_iron_hit_sprite
    end
    # Create the keyboard cursor sprite
    def create_keyboard_cursor
    end
    public
    private
    # Launch the procedure of clicking the tile and everything that ensue
    # @param x [Integer] the x coordinate of the clicked on tile
    # @param y [Integer] the y coordinate of the clicked on tile
    def tile_click(x, y)
    end
    # Change the tool currently used
    # @param value [Integer] the value of the button pressed to change the tool
    def change_tool(value)
    end
    # Add one to the stat of the currently used item
    def add_hit_to_stats
    end
    public
    private
    # Play all the animations resulting from a hit
    # @param x [Integer] the x coordinate of the tile
    # @param y [Integer] the y coordinate of the tile
    # @param diggable [PFM::MiningGame::Diggable, Boolean] either the actual object or a boolean (true for iron, false otherwise)
    # @param reveal [Boolean] true if the Diggable is revealed or already revealed otherwise false
    # @param newly_revealed [Boolean] if the item is fully revealed for the first time
    def play_hit_animation(x, y, diggable, reveal, newly_revealed)
    end
    # Setup the animation for @tool_sprite
    # @param diggable [PFM::MiningGame::Diggable, Boolean] either the actual object or a boolean (true for iron, false otherwise)
    # @param reveal [Boolean] if an item is revealed by the hit
    # @param newly_revealed [Boolean] if an item is fully revealed for the first time
    # @return [Yuki::Animation::ResolverObjectCommand]
    def tool_sprite_anim(diggable, reveal, newly_revealed)
    end
    # Setup the animation for @tool_hit_sprite or @iron_hit_sprite
    # @param diggable [PFM::MiningGame::Diggable, Boolean] either the actual object or a boolean (true for iron, false otherwise)
    # @param reveal [Boolean] if an item is revealed by the hit
    # @return [Yuki::Animation::ResolverObjectCommand]
    def tool_hit_sprite_anim(diggable, reveal)
    end
    # Setup the Audio part of the animation
    # @param diggable [PFM::MiningGame::Diggable, Boolean] either the actual object or a boolean (true for iron, false otherwise)
    # @param reveal [Boolean] if an item is revealed by the hit
    # @param newly_revealed [Boolean] if an item is fully revealed for the first time
    # @return [Yuki::Animation::TimedAnimation]
    def sound_anim(diggable, reveal, newly_revealed)
    end
    # Play the wall collapsing animation
    def start_wall_collapse_anim
    end
    # Start the transition_in animation
    def start_transition_in_animation
    end
    # Get the black sprite in animation
    def black_in_animation
    end
    # Get the black sprite out animation
    def black_out_animation
    end
    public
    # List of method called by automatic_input_update when pressing on a key
    AIU_KEY2METHOD = {A: :action_a, X: :action_x, LEFT: :action_left, RIGHT: :action_right, UP: :action_up, DOWN: :action_down}
    # Check if a keyboard key is pressed, else check for the win/lose condition
    # @return [Boolean] false if @running == false
    def update_inputs
    end
    private
    # Monkey-patch of the original BaseCleanUpdate to catch the result of the automatic input check
    # @param key2method [Hash] Hash associating Input Keys to action method name
    # @return [Boolean] if the update_inputs should continue
    def automatic_input_update(key2method = AIU_KEY2METHOD)
    end
    # Define the action realized when pressing the A button
    def action_a
    end
    # Define the action realized when pressing the X button
    def action_x
    end
    # Define the action realized when pressing the LEFT button
    def action_left
    end
    # Define the action realized when pressing the RIGHT button
    def action_right
    end
    # Define the action realized when pressing the UP button
    def action_up
    end
    # Define the action realized when pressing the DOWN button
    def action_down
    end
    # Change which controller is currently used (only useful to change the visibility of the cursor)
    # Currently, the @controller variable isn't used, but it's there just in case
    # @param reason [Symbol] :mouse or :keyboard depending on which sent a button trigger
    def change_controller_state(reason)
    end
    public
    private
    # Check if the mouse was used to click on a tile or on a button
    # @param _moved [Boolean] if the mouse moved
    # @return [Boolean]
    def update_mouse(_moved)
    end
    public
    # Check if a diggable item has been revealed
    # @param item [PFM::MiningGame::Diggable]
    # @return [Boolean]
    def check_reveal_of_items(item)
    end
    # Method that execute the ping sound and might trigger the texts displayed the first time the player plays
    def launch_ping_text
    end
    # Method that play the text displayed for the first time the player plays
    def first_time_text
    end
    # ID of the ping text
    PING_TEXT = [9005, 4]
    # Method that play the ping text
    def ping_text
    end
    # Check if the game is won or lost, and if none of the two then return
    def check_win_lose_condition
    end
    # ID of the text for the lose scenario
    LOSE_TEXT = [9005, 13]
    # Method that play the lose condition
    def lose
    end
    # Show the message starting lost
    def launch_loose_message
    end
    # ID of the text for the win scenario
    WIN_TEXT = [9005, 14]
    # Method that play the win condition
    def win
    end
    # ID of the text used to tell what items were excavated
    ITEM_WON_TEXT = [9005, 15]
    # Method that end the game and exit the scene
    def end_of_game
    end
  end
end
