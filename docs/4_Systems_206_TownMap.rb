module GamePlay
  # Class showing the basic World Map (TownMap) with navigation
  #
  # The world map is stored inside a 2D Array ($game_data_map) that holds each columns of the world map.
  # Each of these columns contain the ID of the zones at the y position of the cursor
  class WorldMap < BaseCleanUpdate::FrameBalanced
    # Base Z of the viewports
    # @return [Integer]
    ViewportsBaseZ = 51_000
    # Coord X of the map viewport
    # @return [Integer]
    VMapX = 49
    # Coord Y of the map viewport
    # @return [Integer]
    VMapY = 37
    # Width of the map viewport
    # @return [Integer]
    VMapWidth = 257
    # Height of the map viewport
    # @return [Integer]
    VMapHeight = 168
    # Coord X of the window tell the zone is unkonwn
    # @return [Integer]
    UnknownZoneX = 76
    # Coord Y of the window tell the zone is unkonwn
    # @return [Integer]
    UnknownZoneY = 77
    # Width of the window tell the zone is unkonwn
    # @return [Integer]
    UnknownZoneWidth = 200
    # Height of the window tell the zone is unkonwn
    # @return [Integer]
    UnknownZoneHeight = 30
    # Duration of the whole cursor animation
    # @return [Integer]
    CursorAnimationDuration = 60
    # frames
    # Duration of the one case move
    # @return [Integer]
    CursorMoveDuration = 4
    # Offset of the World Map bitmap
    # @return [Integer]
    BitmapOffset = 0
    # 8
    # Size of a tile in the WorldMap (Used outside of the script !)
    # @return [Integer]
    TileSize = 8
    # The height of the display zone on the map window
    # @return [Integer]
    UI_MAP_HEIGHT = 168
    # The width of the display zone on the map window
    # @return [Integer]
    UI_MAP_WIDTH = 256
    # Indicate if the zoom is usable in world map
    ZoomEnabled = true
    # Proc to define the zones color
    # @param counter [Integer] goes from 0 to 100 frame then goes back to 0
    PROC_ZONE_COLOR = proc do |counter|
      [1, 0, 0, (300 + counter).to_f / 500]
    end
    # Proc to define the fly zones color
    # @param counter [Integer] goes from 0 to 100 frame then goes back to 0
    PROC_FLY_ZONE_COLOR = proc do |counter|
      [1, 0, 1, (300 + counter * 2).to_f / 600]
    end
    # Create a new World Map view
    # @param mode [Symbol] mode of the World Map (:view / :fly / :pokdex / :view_wall)
    # @param wm_id [Integer] the id of the world map to display
    # @param pokemon [PFM::Pokemon, Symbol] <default :map> the calling situation
    def initialize(mode = :view, wm_id = $env.get_worldmap, pokemon = nil)
    end
    # Update the inputs
    def update_inputs
    end
    # Update the graphics
    def update_graphics
    end
    # Scene the scene visibility
    # @param value [Boolean]
    def visible=(value)
    end
    # Dispose the scene
    def dispose
    end
    # Delete zones and markers sprite
    def dispose_zone_and_marker
    end
    # Create the viewports of the scene
    def create_viewport
    end
    # Create all the graphics required by this Scene
    def create_graphics
    end
    # Create the Worldmap background
    def create_background
    end
    # Create the map sprite
    def create_map
    end
    # Create the cursor
    def create_cursor
    end
    # Create the player marker
    def create_player_sprite
    end
    # Create the markers (their holder)
    def create_markers
    end
    # Create the frame
    def create_frame
    end
    # Initialize the cursor and the player positions
    def init_cursor_and_player
    end
    # Update the background sprite animation
    def update_background_animation
    end
    # Update the cursor sprite animation
    def update_cursor_animation
    end
    # Update the animation of the zones
    def update_zones_animation
    end
    # Get the direction 8 input and process it on the cursor
    def update_dir_input
    end
    # Update the buttons triggered
    def update_button_input
    end
    # Update the cursor movement
    def update_move
    end
    # Updates the display origin based on cursor position and map size
    def update_display_origin
    end
    # Checks if the worldmap is larger than the UI
    # @return [Boolean] True if the worldmap is larger than the UI, false otherwise
    def worldmap_larger_than_ui?
    end
    # Adjusts the display origin when the worldmap is larger than the UI
    # @param max_x [Integer] The maximum x offset
    # @param max_y [Integer] The maximum y offset
    def adjust_for_large_worldmap(max_x, max_y)
    end
    # Adjusts the display origin when the worldmap is smaller than the UI
    # @param max_x [Integer] The maximum x offset
    # @param max_y [Integer] The maximum y offset
    # @return [void]
    def adjust_for_small_worldmap(max_x, max_y)
    end
    # Checks if the cursor is before the display origin
    # @return [Boolean] True if the cursor is before the display origin.
    def cursor_before_origin?
    end
    # Update the map position
    def update_display_position
    end
    # Update the cursor position using Input.dir8
    def update_cursor_position_dir8
    end
    # Method updating the infobox sprites
    def update_infobox
    end
    # Change the zoom to 0.5 or 1
    def on_toggle_zoom
    end
    # We try to fly to the selected zone
    def on_fly_attempt
    end
    # Load the next worldmap
    def on_next_worldmap
    end
    # Method retreiving the boundaries of the worldmap
    def set_bounds
    end
    # Change the display worldmap
    # @param id [Integer] the worldmap id to display
    def set_worldmap(id)
    end
    # Reset the map display coords
    def recenter_map
    end
    # Set the pokemon to display
    # @param pkm [PFM::Pokemon] the pokemon object
    # @param forced_worldmap_id [Integer, nil] the worldmap to display, if nil, the best one will be picked
    def set_pokemon(pkm, forced_worldmap_id = nil)
    end
    # Display the customs icons
    def display_custom_icons
    end
    # Define the sprite origin with the given parameters
    # @param sprite [Sprite] the sprite to modify
    # @param ox_mode [Symbol]
    # @param oy_mode [Symbol]
    def process_icon_origin_mode(sprite, ox_mode, oy_mode)
    end
    # Display the available fly zones
    def display_fly_zones
    end
    # Display the roaming pokemon zones and icons
    def display_roaming_pokemons
    end
    # Display the pokedex pokemon zones
    def display_pokemon_zones
    end
    # Create the zones sprites
    # @param tab [Table] the table containing the data : 0=no zone, 1=zone
    def display_zones(tab)
    end
    # Change the zone appearence to match the neighbour
    # @param zones_tab [Table] the zones data
    # @param x [Integer] the x coord
    # @param y [Integer] the y coord
    # @param sprite [Sprite] the sprite to setup
    def set_zone_rect(zones_tab, x, y, sprite)
    end
    # Search the pokemon encounter zone, return i
    # @return [Table] the table where the pokemon spawn
    def search_pokemon_zone
    end
  end
end
GamePlay.town_map_class = GamePlay::WorldMap
