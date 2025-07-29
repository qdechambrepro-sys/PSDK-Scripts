module PFM
  # Environment management (Weather, Zone, etc...)
  #
  # The global Environment object is stored in $env and PFM.game_state.env
  # @author Nuri Yuri
  class Environment
    # Unkonw location text
    UNKNOWN_ZONE = 'Zone ???'
    include GameData::SystemTags
    # The master zone (zone that show the panel like city, unlike house of city)
    # @note Master zone are used inside Pokemon data
    # @return [Integer]
    attr_reader :master_zone
    # Last visited map ID
    # @return [Integer]
    attr_reader :last_map_id
    # Custom markers on worldmap
    # @return [Array]
    attr_reader :worldmap_custom_markers
    # Return the modified worldmap position or nil
    # @return [Array, nil]
    attr_reader :modified_worldmap_position
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create a new Environnement object
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Is the player inside a building (and not on a systemtag)
    # @return [Boolean]
    def building?
    end
    # Update the zone informations, return the ID of the zone when the player enter in an other zone
    #
    # Add the zone to the visited zone Array if the zone has not been visited yet
    # @return [Integer, false] false = player was in the zone
    def update_zone
    end
    # Load the zone information
    # @param data [Studio::Zone] the current zone data
    # @param index [Integer] the index of the zone in the stack
    def load_zone_information(data, index)
    end
    # Reset the zone informations to get the zone id with update_zone (Panel display)
    def reset_zone
    end
    # Return the current zone in which the player is
    # @return [Integer] the zone ID in the database
    def current_zone
    end
    alias get_current_zone current_zone
    # Return the zone data in which the player is
    # @return [Studio::Zone]
    def current_zone_data
    end
    alias get_current_zone_data current_zone_data
    # Return the zone name in which the player is (master zone)
    # @return [String]
    def current_zone_name
    end
    # Return the warp zone ID (where the player will teleport with skills)
    # @return [Integer] the ID of the zone in the database
    def warp_zone
    end
    alias get_warp_zone warp_zone
    # Get the zone data in the worldmap
    # @param x [Integer] the x position of the zone in the World Map
    # @param y [Integer] the y position of the zone in the World Map
    # @param worldmap_id [Integer] <default : @worldmap> the worldmap to refer at
    # @return [Studio::Zone, nil] nil = no zone there
    def get_zone(x, y, worldmap_id = @worldmap)
    end
    # Return the zone coordinate in the worldmap
    # @param zone_id [Integer] id of the zone in the database
    # @param worldmap_id [Integer] <default : @worldmap> the worldmap to refer at
    # @return [Array(Integer, Integer)] the x,y coordinates
    def get_zone_pos(zone_id, worldmap_id = @worldmap)
    end
    # Check if a zone has been visited
    # @param zone [Integer, Studio::Zone] the zone id in the database or the zone
    # @return [Boolean]
    def visited_zone?(zone)
    end
    # Get the worldmap from the zone
    # @param zone [Integer] <default : current zone>
    # @return [Integer]
    def get_worldmap(zone = @zone)
    end
    # Test if the given world map has been visited
    # @param worldmap [Integer]
    # @return [Boolean]
    def visited_worldmap?(worldmap)
    end
    # Is the player standing in grass ?
    # @return [Boolean]
    def grass?
    end
    # Is the player standing in tall grass ?
    # @return [Boolean]
    def tall_grass?
    end
    # Is the player standing in taller grass ?
    # @return [Boolean]
    def very_tall_grass?
    end
    # Is the player in a cave ?
    # @return [Boolean]
    def cave?
    end
    # Is the player on a mount ?
    # @return [Boolean]
    def mount?
    end
    # Is the player on sand ?
    # @return [Boolean]
    def sand?
    end
    # Is the player on a pond/river ?
    # @return [Boolean]
    def pond?
    end
    # Is the player on a sea/ocean ?
    # @return [Boolean]
    def sea?
    end
    # Is the player underwater ?
    # @return [Boolean]
    def under_water?
    end
    # Is the player on ice ?
    # @return [Boolean]
    def ice?
    end
    # Is the player on snow or ice ?
    # @return [Boolean]
    def snow?
    end
    # Return the zone type
    # @param ice_prio [Boolean] when on snow for background, return ice ID if player is on ice
    # @return [Integer] 1 = tall grass, 2 = taller grass, 3 = cave, 4 = mount, 5 = sand, 6 = pond, 7 = sea, 8 = underwater, 9 = snow, 10 = ice, 0 = building
    def get_zone_type(ice_prio = false)
    end
    # Convert a system_tag to a zone_type
    # @param system_tag [Integer] the system tag
    # @return [Integer] same as get_zone_type
    def convert_zone_type(system_tag)
    end
    # Is it night time ?
    # @return [Boolean]
    def night?
    end
    # Is it day time ?
    # @return [Boolean]
    def day?
    end
    # Is it morning time ?
    # @return [Boolean]
    def morning?
    end
    # Is it sunset time ?
    # @return [Boolean]
    def sunset?
    end
    # Can the player fish ?
    # @return [Boolean]
    def can_fish?
    end
    # Set the delete state of an event
    # @param event_id [Integer] id of the event
    # @param map_id [Integer] id of the map where the event is
    # @param state [Boolean] new delete state of the event
    def set_event_delete_state(event_id, map_id = @game_state.game_map.map_id, state = true)
    end
    # Get the delete state of an event
    # @param event_id [Integer] id of the event
    # @param map_id [Integer] id of the map where the event is
    # @return [Boolean] if the event is deleted
    def get_event_delete_state(event_id, map_id = @game_state.game_map.map_id)
    end
    # Add the custom marker to the worldmap
    # @param filename [String] the name of the icon in the interface/worldmap/icons directory
    # @param worldmap_id [Integer] the id of the worldmap
    # @param x [Integer] coord x on the worldmap
    # @param y [Integer] coord y on the wolrdmap
    # @param ox_mode [Symbol, :center] :center (the icon will be centered on the tile center), :base
    # @param oy_mode [Symbol, :center] :center (the icon will be centered on the tile center), :base
    def add_worldmap_custom_icon(filename, worldmap_id, x, y, ox_mode = :center, oy_mode = :center)
    end
    # Remove all custom worldmap icons on the coords
    # @param filename [String] the name of the icon in the interface/worldmap/icons directory
    # @param worldmap_id [Integer] the id of the worldmap
    # @param x [Integer] coord x on the worldmap
    # @param y [Integer] coord y on the wolrdmap
    def remove_worldmap_custom_icon(filename, worldmap_id, x, y)
    end
    # Overwrite the zone worldmap position
    # @param new_x [Integer] the new x coords on the worldmap
    # @param new_y [Integer] the new y coords on the worldmap
    # @param new_worldmap_id [Integer, nil] the new worldmap id
    def set_worldmap_position(new_x, new_y, new_worldmap_id = nil)
    end
    # Reset the modified worldmap position
    def reset_worldmap_position
    end
    # List of weather symbols
    WEATHER_NAMES = %i[none rain sunny sandstorm hail fog hardsun hardrain strong_winds snow]
    # Apply a new weather to the current environment
    # @param id [Integer, Symbol] ID of the weather : 0 = None, 1 = Rain, 2 = Sun/Zenith, 3 = Darud Sandstorm, 4 = Hail, 5 = Foggy
    # @param duration [Integer, nil] the total duration of the weather (battle), nil = never stops
    def apply_weather(id, duration = nil)
    end
    # Return the current weather duration
    # @return [Numeric] can be Float::INFINITY
    def weather_duration
    end
    alias get_weather_duration weather_duration
    # Decrease the weather duration, set it to normal (none = 0) if the duration is less than 0
    # @return [Boolean] true = the weather stopped
    def decrease_weather_duration
    end
    # Return the current weather id according to the game state (in battle or not)
    # @return [Integer]
    def current_weather
    end
    # Return the db_symbol of the current weather
    # @return [Symbol]
    def current_weather_db_symbol
    end
    # Is it rainning?
    # @return [Boolean]
    def rain?
    end
    # Is it hardrainning?
    # @return [Boolean]
    def hardrain?
    end
    # Is it sunny?
    # @return [Boolean]
    def sunny?
    end
    # Is it hardsunny?
    # @return [Boolean]
    def hardsun?
    end
    # Is it Strong Winds ? (Mega Rayquaza)
    # @return [Boolean]
    def strong_winds?
    end
    # Duuuuuuuuuuuuuuuuuuuuuuun
    # Dun dun dun dun dun dun dun dun dun dun dun dundun dun dundundun dun dun dun dun dun dun dundun dundun
    # @return [Boolean]
    def sandstorm?
    end
    # Does it hail ?
    # @return [Boolean]
    def hail?
    end
    # Is it snowing?
    # @return [Boolean]
    def snowing?
    end
    # Is it foggy ?
    # @return [Boolean]
    def fog?
    end
    # Is the weather normal
    # @return [Boolean]
    def normal?
    end
    private
    # Update the state of each switches so the system knows what happens
    def ajust_weather_switches
    end
    # Get the list of switch related to weather
    # @return [Array<Integer>]
    def weather_switches
    end
  end
  # Constant for previous PSDK usage when the typo was there
  Environnement = Environment
  class GameState
    # The environment informations
    # @return [PFM::Environment]
    attr_accessor :env
    on_player_initialize(:env) {@env = PFM.environment_class.new(self) }
    on_expand_global_variables(:env) do
      $env = @env
      @env.game_state = self
    end
  end
end
PFM.environment_class = PFM::Environment
