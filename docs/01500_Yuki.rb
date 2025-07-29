module Yuki
  # Sprite with move_to command a self "animation"
  # @author Nuri Yuri
  class Sprite < Sprite
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
    # Security patch
    def eval
    end
    alias class_eval eval
    alias instance_eval eval
    alias module_eval eval
  end
  # PSDK DayNightSystem v2
  #
  # This script manage the day night tint & hour calculation
  #
  # It's inputs are :
  #   - $game_switches[Sw::TJN_NoTime] (8) : Telling not to update time
  #   - $game_switches[Sw::TJN_RealTime] (7) : Telling to use the real time (computer clock)
  #   - $game_variables[Var::TJN_Month] (15) : Month of the year (1~13 in virtual time)
  #   - $game_variables[Var::TJN_MDay] (16) : Day of the month (1~28 in virtual time)
  #   - $game_variables[Var::TJN_Week] (14) : Week since the begining (0~65535)
  #   - $game_variables[Var::TJN_WDay] (13) : Day of the week (1~7 in virtual time)
  #   - $game_variables[Var::TJN_Hour] (10) : Hour of the day (0~23)
  #   - $game_variables[Var::TJN_Min] (11) : Minute of the hour (0~59)
  #   - $game_switches[Sw::TJN_Enabled] (10) : If tone change is enabled
  #   - $game_switches[Sw::Env_CanFly] (20) : If the tone can be applied (player outside)
  #   - Yuki::TJN.force_update_tone : Calling this method will force the system to update the tint
  #   - PFM.game_state.tint_time_set : Name of the time set (symbol) to use in order to get the tone
  #
  # It's outputs are :
  #   - All the time variables (15, 16, 14, 13, 10, 11)
  #   - $game_variables[Var::TJN_Tone] : The current applied tone
  #       - 0 = Night
  #       - 1 = Sunset
  #       - 2 = Morning
  #       - 3 = Day time
  # @author Nuri Yuri
  module TJN
    # Neutral tone
    NEUTRAL_TONE = Tone.new(0, 0, 0, 0)
    # The different tones according to the time set
    TONE_SETS = {default: [Tone.new(-85, -85, -20, 0), Tone.new(-17, -51, -34, 0), Tone.new(-75, -75, -10, 0), NEUTRAL_TONE, Tone.new(17, -17, -34, 0)], winter: [Tone.new(-75, -75, -10, 0), Tone.new(-80, -80, -10, 0), Tone.new(-85, -85, -10, 0), Tone.new(-80, -80, -12, 0), Tone.new(-75, -75, -15, 0), Tone.new(-65, -65, -18, 0), Tone.new(-55, -55, -20, 0), Tone.new(-25, -35, -22, 0), Tone.new(-20, -25, -25, 0), Tone.new(-15, -20, -30, 0), Tone.new(-10, -17, -34, 0), Tone.new(5, -8, -15, 0), Tone.new(0, 0, -5, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(-10, -25, -10, 0), Tone.new(-17, -51, -34, 0), Tone.new(-20, -43, -30, 0), Tone.new(-35, -35, -25, 0), Tone.new(-45, -45, -20, 0), Tone.new(-55, -55, -15, 0), Tone.new(-60, -60, -14, 0), Tone.new(-65, -65, -13, 0), Tone.new(-70, -70, -10, 0)], platinum_daynight: [Tone.new(-52, -50, -5, 90), Tone.new(-52, -50, -5, 90), Tone.new(-52, -50, -5, 90), Tone.new(-52, -50, -5, 90), Tone.new(-40, -37, -5, 80), Tone.new(-15, -25, 0, 50), Tone.new(-15, -25, 0, 50), Tone.new(28, 16, -25, 25), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, 0, 0, 0), Tone.new(0, -10, -35, 20), Tone.new(0, -38, -58, 45), Tone.new(-35, -40, -32, 75), Tone.new(-48, -46, -12, 90), Tone.new(-48, -46, -12, 90), Tone.new(-48, -46, -12, 90), Tone.new(-48, -46, -12, 90)]}
    # The different tones
    TONE = TONE_SETS[:default]
    # The different time sets according to the time set
    TIME_SETS = {default: summer = [22, 19, 11, 7], summer: summer, winter: [17, 16, 12, 10], fall: fall = [19, 17, 11, 9], spring: fall}
    # The time when the tone changes
    TIME = TIME_SETS[:default]
    # The number of frame that makes 1 minute in Game time
    MIN_FRAMES = 600
    # Regular number of frame the tint change has to be performed
    REGULAR_TRANSITION_TIME = 20
    @timer = 0
    @forced = false
    @real_time_scheduler_update = false
    @current_tone_value = Tone.new(0, 0, 0, 0)
    module_function
    # Function that init the TJN variables
    def init_variables
    end
    # Update the tone of the screen and the game time
    def update
    end
    # Force the next update to update the tone
    # @param value [Boolean] true to force the next update to update the tone
    def force_update_tone(value = true)
    end
    # Return the current tone
    # @return [Tone]
    def current_tone
    end
    # Function that scan all the timed event for the current map in order to update them
    # @param map_id [Integer] ID of the map where to update the timed events
    def update_timed_events(map_id = $game_map.map_id)
    end
    class << self
      private
      # Return the number of frame between each virtual minutes
      # @return [Integer]
      def one_minute
      end
      # Update the game time
      # @note If the game switch Yuki::Sw::TJN_NoTime is on, there's no time update.
      # @note If the game switch Yuki::Sw::TJN_RealTime is on, the time is the computer time
      def update_time
      end
      # Update the virtual time by adding 1 minute to the variable
      # @return [Boolean] if update_time should call update_tone
      def update_virtual_time
      end
      # Update the real time values
      # @return [Boolean] if update_time should call update_tone
      def update_real_time
      end
      # Update the tone of the screen
      # @note if the game switch Yuki::Sw::TJN_Enabled is off, the tone is not updated
      def update_tone
      end
      # Internal part of the update tone where flags are set & tone is processed
      # @param day_tone [Boolean] if we can process a tone (not inside / locked by something else)
      def update_tone_internal(day_tone)
      end
      # Change the game tone to the neutral one
      def change_tone_to_neutral
      end
      # Change tone of the map
      # @param tone_index [Integer] index of the tone if there's no 24 tones inside the tone array
      def change_tone(tone_index)
      end
      # Time to change tone
      # @return [Integer]
      def tone_change_time
      end
      # Get the time set
      # @return [Array<Integer>] 4 values : [night_start, evening_start, day_start, morning_start]
      def current_time_set
      end
      # Get the tone set
      # @return [Array<Tone>] 5 values : night, evening, morning / night, day, dawn
      def current_tone_set
      end
      # List of the switch name used by the TJN system (it's not defined here so we use another access)
      TJN_SWITCH_LIST = %i[TJN_NightTime TJN_DayTime TJN_MorningTime TJN_SunsetTime]
      # Update the state of the switches and the tone variable
      # @param switch_id [Integer] ID of the switch that should be true (all the other will be false)
      # @param variable_value [Integer] new value of $game_variables[Var::TJN_Tone]
      def update_switches_and_variables(switch_id, variable_value)
      end
      # If the tone should update each minute
      def should_update_tone_each_minute
      end
    end
  end
  # Module that manage the growth of berries.
  # @author Nuri Yuri
  #
  # The berry informations are stored in PFM.game_state.berries, a 2D Array of berry information
  #   PFM.game_state.berries[map_id][event_id] = [berry_id, stage, timer, stage_time, water_timer, water_time, water_counter, info_fertilizer]
  module Berries
    # The base name of berry character
    PLANTED_CHAR = 'Z_BP'
    # Berry data / db_symbol
    # @return [Hash{ symbol => Data }]
    BERRY_DATA = {}
    module_function
    # Init a berry tree
    # @param map_id [Integer] id of the map where the berry tree is
    # @param event_id [Integer] id of the event where the berry tree is shown
    # @param berry_id [Symbol, Integer] db_symbol or ID of the berry Item in the database
    # @param state [Integer] the growth state of the berry
    def init_berry(map_id, event_id, berry_id, state = 4)
    end
    # Test if a berry is on an event
    # @param event_id [Integer] ID of the event
    # @return [Boolean]
    def here?(event_id)
    end
    # Retrieve the ID of the berry that is planted on an event
    # @param event_id [Integer] ID of the event
    # @return [Integer]
    def get_berry_id(event_id)
    end
    # Retrieve the Internal ID of the berry (text_id)
    # @param event_id [Integer] ID of the event
    # @return [Integer]
    def get_berry_internal_id(event_id)
    end
    # Retrieve the stage of a berry
    # @param event_id [Integer] ID of the event
    # @return [Integer]
    def get_stage(event_id)
    end
    # Tell if the berry is watered
    # @param event_id [Integer] ID of the event
    # @return [Boolean]
    def watered?(event_id)
    end
    # Water a berry
    # @param event_id [Integer] ID of the event
    def water(event_id)
    end
    # Plant a berry
    # @param event_id [Integer] ID of the event
    # @param berry_id [Integer] ID of the berry Item in the database
    def plant(event_id, berry_id)
    end
    # Take the berries from the berry tree
    # @param event_id [Integer] ID of the event
    # @return [Integer] the number of berry taken from the tree
    def take(event_id)
    end
    # Initialization of the Berry management
    def init
    end
    # Update of the berry management
    def update
    end
    # Update of the berry event graphics
    # @param event_id [Integer] id of the event where the berry tree is shown
    # @param data [Array] berry data
    def update_event(event_id, data)
    end
    # Search the Berry data of the map
    # @param map_id [Integer] id of the Map
    def find_berry_data(map_id)
    end
    # Return the berry data
    def data
    end
    # Data describing a berry in the Berry system
    class Data
      # Bitter factor of the berry
      # @return [Integer]
      attr_accessor :bitter
      # Minimum amount of berry yield
      # @return [Integer]
      attr_accessor :min_yield
      # Sour factor of the berry
      # @return [Integer]
      attr_accessor :sour
      # Maximum amount of berry yield
      # @return [Integer]
      attr_accessor :max_yield
      # Spicy factor of the berry
      # @return [Integer]
      attr_accessor :spicy
      # Dry factor of the berry
      # @return [Integer]
      attr_accessor :dry
      # Sweet factor of the berry
      # @return [Integer]
      attr_accessor :sweet
      # Time the berry take to grow
      # @return [Integer]
      attr_accessor :time_to_grow
      # Moisture rating drained per hour
      # @return [Integer]
      attr_accessor :drain_rate
      # Create a new berry
      # @param time_to_grow [Integer] number of hours the berry need to fully grow
      # @param min_yield [Integer] minimum quantity the berry can yield
      # @param max_yield [Integer] maximum quantity the berry can yield
      # @param drain_rate [Integer] moisture rating drain per hour
      # @param taste_info [Hash{ Symbol => Integer}]
      def initialize(time_to_grow, min_yield, max_yield, drain_rate, taste_info)
      end
    end
    BERRY_DATA[:cheri_berry] = Data.new(12, 2, 5, 15, spicy: 10)
    BERRY_DATA[:chesto_berry] = Data.new(12, 2, 5, 15, dry: 10)
    BERRY_DATA[:pecha_berry] = Data.new(12, 2, 5, 15, sweet: 10)
    BERRY_DATA[:rawst_berry] = Data.new(12, 2, 5, 15, bitter: 10)
    BERRY_DATA[:aspear_berry] = Data.new(12, 2, 5, 15, sour: 10)
    BERRY_DATA[:leppa_berry] = Data.new(16, 2, 5, 15, spicy: 10, bitter: 10, sour: 10, sweet: 10)
    BERRY_DATA[:oran_berry] = Data.new(16, 2, 5, 15, spicy: 10, bitter: 10, sour: 10, sweet: 10, dry: 10)
    BERRY_DATA[:persim_berry] = Data.new(16, 2, 5, 15, spicy: 10, sour: 10, sweet: 10, dry: 10)
    BERRY_DATA[:lum_berry] = Data.new(48, 2, 5, 8, spicy: 10, bitter: 10, sweet: 10, dry: 10)
    BERRY_DATA[:sitrus_berry] = Data.new(32, 2, 5, 7, bitter: 10, sour: 10, sweet: 10, dry: 10)
    BERRY_DATA[:figy_berry] = Data.new(20, 1, 5, 10, spicy: 15)
    BERRY_DATA[:wiki_berry] = Data.new(20, 1, 5, 10, dry: 15)
    BERRY_DATA[:mago_berry] = Data.new(20, 1, 5, 10, sweet: 15)
    BERRY_DATA[:aguav_berry] = Data.new(20, 1, 5, 10, bitter: 15)
    BERRY_DATA[:iapapa_berry] = Data.new(20, 1, 5, 10, sour: 15)
    BERRY_DATA[:razz_berry] = Data.new(8, 2, 10, 35, dry: 10, spicy: 10)
    BERRY_DATA[:bluk_berry] = Data.new(8, 2, 10, 35, dry: 10, sweet: 10)
    BERRY_DATA[:nanab_berry] = Data.new(8, 2, 10, 35, bitter: 10, sweet: 10)
    BERRY_DATA[:wepear_berry] = Data.new(8, 2, 10, 35, bitter: 10, sour: 10)
    BERRY_DATA[:pinap_berry] = Data.new(8, 2, 10, 35, spicy: 10, sour: 10)
    BERRY_DATA[:pomeg_berry] = Data.new(32, 1, 5, 8, spicy: 10, bitter: 10, sweet: 10)
    BERRY_DATA[:kelpsy_berry] = Data.new(32, 1, 5, 8, sour: 10, bitter: 10, dry: 10)
    BERRY_DATA[:qualot_berry] = Data.new(32, 1, 5, 8, sour: 10, spicy: 10, sweet: 10)
    BERRY_DATA[:hondew_berry] = Data.new(32, 1, 5, 8, sour: 10, spicy: 10, bitter: 10, dry: 10)
    BERRY_DATA[:grepa_berry] = Data.new(32, 1, 5, 8, sour: 10, spicy: 10, sweet: 10)
    BERRY_DATA[:tamato_berry] = Data.new(32, 1, 5, 8, spicy: 20, dry: 10)
    BERRY_DATA[:cornn_berry] = Data.new(24, 2, 10, 10, dry: 20, sweet: 10)
    BERRY_DATA[:magost_berry] = Data.new(24, 2, 10, 10, bitter: 10, sweet: 20)
    BERRY_DATA[:rabuta_berry] = Data.new(24, 2, 10, 10, bitter: 20, sour: 10)
    BERRY_DATA[:nomel_berry] = Data.new(24, 2, 10, 10, spicy: 10, sour: 20)
    BERRY_DATA[:spelon_berry] = Data.new(60, 2, 15, 8, spicy: 30, dry: 10)
    BERRY_DATA[:pamtre_berry] = Data.new(60, 2, 15, 8, dry: 30, sweet: 10)
    BERRY_DATA[:watmel_berry] = Data.new(60, 2, 15, 8, sweet: 30, bitter: 10)
    BERRY_DATA[:durin_berry] = Data.new(60, 2, 15, 8, bitter: 30, sour: 10)
    BERRY_DATA[:belue_berry] = Data.new(60, 2, 15, 8, sour: 30, spicy: 10)
    BERRY_DATA[:occa_berry] = Data.new(72, 1, 5, 6, spicy: 15, sweet: 10)
    BERRY_DATA[:passho_berry] = Data.new(72, 1, 5, 6, dry: 15, bitter: 10)
    BERRY_DATA[:wacan_berry] = Data.new(72, 1, 5, 6, sweet: 15, sour: 10)
    BERRY_DATA[:rindo_berry] = Data.new(72, 1, 5, 6, bitter: 15, spicy: 10)
    BERRY_DATA[:yache_berry] = Data.new(72, 1, 5, 6, sour: 15, dry: 10)
    BERRY_DATA[:chople_berry] = Data.new(72, 1, 5, 6, spicy: 15, bitter: 1)
    BERRY_DATA[:kebia_berry] = Data.new(72, 1, 5, 6, dry: 15, sour: 10)
    BERRY_DATA[:shuca_berry] = Data.new(72, 1, 5, 6, sweet: 15, spicy: 10)
    BERRY_DATA[:coba_berry] = Data.new(72, 1, 5, 6, bitter: 15, dry: 10)
    BERRY_DATA[:payapa_berry] = Data.new(72, 1, 5, 6, sour: 15, sweet: 10)
    BERRY_DATA[:tanga_berry] = Data.new(72, 1, 5, 6, spicy: 20, sour: 10)
    BERRY_DATA[:charti_berry] = Data.new(72, 1, 5, 6, dry: 20, spicy: 10)
    BERRY_DATA[:kasib_berry] = Data.new(72, 1, 5, 6, sweet: 20, dry: 10)
    BERRY_DATA[:haban_berry] = Data.new(72, 1, 5, 6, bitter: 20, sweet: 10)
    BERRY_DATA[:colbur_berry] = Data.new(72, 1, 5, 6, sour: 20, bitter: 10)
    BERRY_DATA[:babiri_berry] = Data.new(72, 1, 5, 6, spicy: 25, dry: 10)
    BERRY_DATA[:chilan_berry] = Data.new(72, 1, 5, 6, dry: 25, sweet: 10)
    BERRY_DATA[:liechi_berry] = Data.new(96, 1, 5, 4, spicy: 30, sweet: 30, dry: 10)
    BERRY_DATA[:ganlon_berry] = Data.new(96, 1, 5, 4, bitter: 30, dry: 30, sweet: 10)
    BERRY_DATA[:salac_berry] = Data.new(96, 1, 5, 4, sweet: 30, sour: 30, bitter: 10)
    BERRY_DATA[:petaya_berry] = Data.new(96, 1, 5, 4, bitter: 30, spicy: 30, sour: 10)
    BERRY_DATA[:apicot_berry] = Data.new(96, 1, 5, 4, sour: 30, dry: 30, spicy: 10)
    BERRY_DATA[:lansat_berry] = Data.new(96, 1, 5, 4, bitter: 10, sour: 30, dry: 10, sweet: 30, spicy: 30)
    BERRY_DATA[:starf_berry] = Data.new(96, 1, 5, 4, bitter: 10, sour: 30, dry: 10, sweet: 30, spicy: 30)
    BERRY_DATA[:enigma_berry] = Data.new(96, 1, 5, 7, spicy: 40, dry: 10)
    BERRY_DATA[:micle_berry] = Data.new(96, 1, 5, 7, dry: 40, sweet: 10)
    BERRY_DATA[:custap_berry] = Data.new(96, 1, 5, 7, sweet: 40, bitter: 10)
    BERRY_DATA[:jaboca_berry] = Data.new(96, 1, 5, 7, bitter: 40, sour: 10)
    BERRY_DATA[:rowap_berry] = Data.new(96, 1, 5, 7, sour: 40, spicy: 10)
    BERRY_DATA[:roseli_berry] = Data.new(72, 1, 5, 6, sour: 10, sweet: 20)
    BERRY_DATA[:kee_berry] = Data.new(96, 1, 5, 6, sweet: 40, sour: 10)
    BERRY_DATA[:maranga_berry] = Data.new(96, 1, 5, 6, bitter: 40, dry: 10)
    ::Scheduler.add_message(:on_update, TJN, 'Update berries using time system', 1000, self, :update)
    ::Scheduler.add_message(:on_warp_process, 'Scene_Map', 'Init baies', 99, self, :init)
    ::Scheduler.add_message(:on_init, 'Scene_Map', 'Init baies', 99, self, :init)
  end
  # Module that helps the user to edit his worldmap
  module WorldMapEditor
    module_function
    # Main function
    def main
    end
    # Affiche l'aide
    def show_help
    end
    # Update the scene
    def update
    end
    # Update the current zone
    def update_zone
    end
    # Clear the map
    def clear_map
    end
    # Remove the zone
    def remove_zone
    end
    # Update the origin x/y
    # @param worldmap [Class<GamePlay::WorldMap>] should contain TileSize and BitmapOffset constants
    def update_origin(worldmap)
    end
    # Save the world map
    def save
    end
    # List the zone
    def list_zone(name = '')
    end
    # Select a zone
    def select_zone(id)
    end
    # Select a world map
    def select_worldmap(id)
    end
    # Add a new world map and select it
    # @param image [String] the image of the map in graphics/interface folder
    # @param name_id [Integer] the text id in the file
    # @param file_id [String, Integer, nil] the file to pick the region name, by default the Ruby Host
    def add_worldmap(image, name_id, file_id = nil)
    end
    # Delete world map
    # @param id [Integer] the id of the map to delete
    def delete_worldmap(id)
    end
    # Display all worldmaps
    # @param name [String, ''] the name to filter
    def list_worldmap(name = '')
    end
    # Change the worldmap name to the given name text id in the given file id (by default in the ruby host)
    # @param id [Integer] the id of the world map to edit
    # @param name_id [Integer] the id of the text in the file
    # @param file_id [Integer, String, nil] the file id / name by default ruby host
    def set_worldmap_name(id, name_id, file_id = nil)
    end
    # Change the worldmap image to the given one
    # @param id [Integer] the id of the world map to edit
    # @param new_image [Integer] the new filename of the image
    def set_worldmap_image(id, new_image)
    end
    # Init the editor
    def init
    end
    # Create the sprites
    def init_sprites
    end
    # Update the infobox
    def update_infobox
    end
  end
  # Module that display various transitions on the screen
  module Transitions
    # The number of frame the transition takes to display
    NB_Frame = 60
    module_function
    # Show a circular transition (circle reduce it size or increase it)
    # @param direction [-1, 1] -1 = out -> in, 1 = in -> out
    # @note A block can be yield if given, its parameter is i (frame) and sp1 (the screenshot)
    def circular(direction = -1)
    end
    # Hash that give the angle according to the direction of the player
    Directed_Angles = {-8 => 0, 8 => 180, -4 => 90, 4 => 270, -2 => 180, 2 => 0, -6 => 270, 6 => 90}
    Directed_Angles.default = 0
    # Hash that give x factor (* w/2)
    Directed_X = {-8 => 1, 8 => 1, -4 => -2, 4 => 0, -2 => 1, 2 => 1, -6 => 4, 6 => 2}
    Directed_X.default = 0
    # Hash that give the y factor (* w/2)
    Directed_Y = {-8 => -2, 8 => 0, -4 => 1, 4 => 1, -2 => 4, 2 => 2, -6 => 1, 6 => 1}
    Directed_Y.default = 0
    # Transition that goes from up -> down or right -> left
    # @param direction [-1, 1] -1 = out -> in, 1 = in -> out
    # @note A block can be yield if given, its parameter is i (frame) and sp1 (the screenshot)
    def directed(direction = -1)
    end
    # Display a weird transition (for battle)
    # @param nb_frame [Integer] the number of frame used for the transition
    # @param radius [Float] the radius (in texture uv) of the transition effect
    # @param max_alpha [Float] the maxium alpha value for the transition effect
    # @param min_tau [Float] the minimum tau value of the transition effect
    # @param delta_tau [Float] the derivative of tau between the begining and the end of the transition
    def weird_transition(nb_frame = 60, radius = 0.25, max_alpha = 0.5, min_tau = 0.07, delta_tau = 0.07, bitmap: nil)
    end
    # Display a BW in->out Transition
    # @param transition_sprite [Sprite] a screenshot sprite
    def bw_zoom(transition_sprite)
    end
    # TODO: rework all animations to rely on Yuki::Animation instead of using that dirty trick
    def update_graphics_60_fps
    end
    # Dispose the sprites
    # @param args [Array<Sprite>]
    def dispose_sprites(*args)
    end
  end
  # Module that contain every constants associated to a Swicth ID of $game_switches.
  # The description of the constants are the meaning of the switch
  module Sw
    # If the player is a female
    Gender = 1
    # If the shadow are shown under the Sprite_Character
    CharaShadow = 2
    # If the Game_Event doesn't collide with other Game_Event when they slide
    ThroughEvent = 3
    # If the surf message doesn't display when the player collide with the water tiles
    NoSurfContact = 4
    # If the common event did its work as expected or not
    EV_Acted = 5
    # If the Maplinker is disabled
    MapLinkerDisabled = 6
    # If InGame time use the SystemTime
    TJN_RealTime = 7
    # If the InGame time doesn't update
    TJN_NoTime = 8
    # If the added Pokemon has been stored
    SYS_Stored = 9
    # If the time tone is shown
    TJN_Enabled = 10
    # It's the day time
    TJN_DayTime = 11
    # It's the night time
    TJN_NightTime = 12
    # It's the moring time
    TJN_MorningTime = 13
    # It's sunset time
    TJN_SunsetTime = 14
    # BW transition when going from outside to inside (No fade on the warp)
    WRP_Transition = 15
    # If the nuzlocke is enabled
    Nuzlocke_ENA = 16
    # If the player is on AccroBike (and not on the normal bike)
    EV_AccroBike = 17
    # Disable the reset_position of Yuki::FollowMe
    FM_NoReset = 18
    # If the Yuki::FollowMe system is enabled
    FM_Enabled = 19
    # If the player can use Fly thus is outside
    Env_CanFly = 20
    # If the player can use Dig thus is in a cave
    Env_CanDig = 21
    # If the Follower are repositionned like the player warp between two exterior map
    Env_FM_REP = 22
    # If the player is on the Bicycle
    EV_Bicycle = 23
    # If the player has a Pokemon with Strength and Strength is active
    EV_Strength = 24
    # If the message system calculate the line break automatically
    MSG_Recalibrate = 25
    # If the choice are shown on top left
    MSG_ChoiceOnTop = 26
    # If the message system break lines on some punctuations
    MSG_Ponctuation = 27
    # If the actor doesn't turn to the event that show the message
    MSG_Noturn = 28
    # If the Pokemon FollowMe should use Let's Go Mode
    FollowMe_LetsGoMode = 29
    # If the battle is updating the phase (inside battle event condition)
    BT_PhaseUpdate = 30
    # If the phase 1 of the battle is running (Intro)
    BT_Phase1 = 31
    # If the phase 2 of the battle is running (Action choice)
    BT_Phase2 = 32
    # If the phase 3 of the battle is running (Target choice)
    BT_Phase3 = 33
    # If the wild Pokemon fled the battle
    BT_Wild_Flee = 34
    # If the player fled the battle
    BT_Player_Flee = 35
    # If the player was defeated
    BT_Defeat = 36
    # If the player was victorious
    BT_Victory = 37
    # If the player caught the Wild Pokemon
    BT_Catch = 38
    # If the weather in Battle change the Weather outside
    MixWeather = 39
    # If the experience calculation is harder
    BT_HardExp = 40
    # If the player cant escape the battle
    BT_NoEscape = 41
    # If the battle doesn't give exp
    BT_NoExp = 42
    # If the catch is forbidden
    BT_NoCatch = 43
    # If the Moves are replaced by no moves when Pokemon are generated for battle
    BT_NO_MOVE_WHEN_DEFAULT = 44
    # If the trainer first Pokemon is sent without ball animation
    BT_NO_BALL_ANIMATION = 45
    # Authorize defeat in the battle in nuzlocke mode
    BT_AUTHORIZE_DEFEAT_NUZLOCKE = 46
    # Add the Reminder in the Party Menu
    BT_Party_Menu_Reminder = 47
    # Make the AI able to win a battle
    BT_AI_CAN_WIN = 48
    # Disable the Battleback Name reset when you go on a new map
    DISABLE_BATTLEBACK_RESET = 49
    # If exp gain is scaled by player Pokémon level
    BT_ScaledExp = 50
    # If the Water Reflection is disabled
    WATER_REFLECTION_DISABLED = 51
    # If the player is running
    EV_Run = 52
    # If the player can run
    EV_CanRun = 53
    # If the player automatically turn on himself when walking on Rapid SystemTag
    EV_TurnRapids = 54
    #Indique si le joueur tourne dans les rapides
    # If the player triggered flash
    EV_Flash = 55
    # Weather is rain
    WT_Rain = 56
    # Weather is sunset
    WT_Sunset = 57
    # Weather is sandstorm
    WT_Sandstorm = 58
    # Weather is snow
    WT_Snow = 59
    # Weather is fog
    WT_Fog = 60
    # Disable player detection by all the detection methods
    Env_Detection = 75
    # Tells if the player can't currently leave the bike (useful for Cycling Road)
    CantLeaveBike = 76
    # Enable/disable if pokemon die from poison in overworld
    OW_Poison = 77
    # Failure switch (do not use)
    Alola = 96
    # Victory on the Alpha Ruins game
    RuinsVictory = 97
    # If the Yuki::FollowMe system was enabled
    FM_WasEnabled = 98
    # If the Pokedex is in National Mode
    Pokedex_Nat = 99
    # If the player got the Pokedex
    Pokedex = 100
  end
  # Module that contain every constants associated to a Variable ID of $game_variables.
  # The description of the constants are the meaning of the variable
  module Var
    # Player ID (31bits)
    Player_ID = 1
    # Number of Pokemon Seen
    Pokedex_Seen = 2
    # Number of Pokemon caught
    Pokedex_Catch = 3
    # Current Box (0 is Box 1)
    Boxes_Current = 4
    # Number the in the GamePlay::InputNumber interface (default variable)
    EnteredNumber = 5
    # Number of Pokemon to select for creating temporary team
    Max_Pokemon_Select = 6
    # ID (in the database) of the trainer battle to start
    Trainer_Battle_ID = 8
    # ID of the particle data to use in order to show particle
    PAR_DatID = 9
    # InGame hour
    TJN_Hour = 10
    # InGame minute
    TJN_Min = 11
    # InGame seconds (unused)
    TJN_Sec = 12
    # InGame day of the week (1 = Monday)
    TJN_WDay = 13
    # InGame week
    TJN_Week = 14
    # InGame Month
    TJN_Month = 15
    # InGame day of the month
    TJN_MDay = 16
    # Current Tone (0 : Night, 1 : Sunset, 3 : Day, 2 : Morning)
    TJN_Tone = 17
    # Number of Following Human
    FM_N_Human = 18
    # Number of Following Pokemon (actors one)
    FM_N_Pokem = 19
    # Number of Friend's Following Pokemon
    FM_N_Friend = 20
    # The selected Follower (1 = first, 0 = none)
    FM_Sel_Foll = 21
    # ID of the map where Dig send the player out
    E_Dig_ID = 23
    # X position where Dig send the player out
    E_Dig_X = 24
    # Y position where Dig send the player out
    E_Dig_Y = 25
    # Temporary variable 1
    TMP1 = 26
    # Temporary variable 2
    TMP2 = 27
    # Temporary variable 3
    TMP3 = 28
    # Temporary variable 4
    TMP4 = 29
    # Temporary variable 5
    TMP5 = 30
    # Trainer transition type (0 = 6G, 1 = 5G)
    TrainerTransitionType = 31
    # Map Transition type (1 = Circular, 2 = Directed)
    MapTransitionID = 32
    # Level of the AI
    AI_LEVEL = 34
    # ID (in the database) of the second trainer of the duo battle
    Second_Trainer_ID = 35
    # ID (in the database) of the allied trainer of the duo battle
    Allied_Trainer_ID = 36
    # Coin case amount of coin
    CoinCase = 41
    # Soot sack: amount of volcanic ash in the bag
    SootSack = 42
    # Index of the Pokemon that use its skill in the Party_Menu
    Party_Menu_Sel = 43
    # ID of the map where the player return (Teleport, defeat)
    E_Return_ID = 47
    # X position of the map where the player return
    E_Return_X = 48
    # Y position of the map where the player return
    E_Return_Y = 49
    # Battle mode, 0 : Normal, 1 : P2P server, 2 : P2P Client
    BT_Mode = 50
    # Id of the current player ID
    Current_Player_ID = 51
  end
  # Module that allow to mesure elapsed time between two calls of #show
  #
  # This module is muted when PSDK_CONFIG.release? = true
  #
  # Example :
  #   Yuki::ElapsedTime.start(:test)
  #   do_something
  #   Yuki::ElapsedTime.show(:test, "Something took")
  #   do_something_else
  #   Yuki::ElapsedTime.show(:test, "Something else took")
  module ElapsedTime
    @timers = {}
    @disabled_timers = [:audio_load_sound, :map_loading, :spriteset_map, :transfer_player, :maplinker]
    module_function
    # Start the time counter
    # @param name [Symbol] name of the timer
    def start(name)
    end
    # Disable a timer
    # @param name [Symbol] name of the timer
    def disable_timer(name)
    end
    # Enable a timer
    # @param name [Symbol] name of the timer
    def enable_timer(name)
    end
    # Show the elapsed time between the current and the last call of show
    # @param name [Symbol] name of the timer
    # @param message [String] message to show in the console
    def show(name, message)
    end
    # Show the real message in the console
    # @param delta [Float] number of unit elapsed
    # @param message [String] message to show on the terminal with the elapsed time
    # @param unit [String] unit of the elapsed time
    def sub_show(delta, message, unit)
    end
  end
  # Display a choice Window
  # @author Nuri Yuri
  class ChoiceWindow < Window
    # Array of choice colors
    # @return [Array<Integer>]
    attr_accessor :colors
    # Current choix (0~choice_max-1)
    # @return [Integer]
    attr_accessor :index
    # Name of the cursor in Graphics/Windowskins/
    CursorSkin = 'Cursor'
    # Name of the windowskin in Graphics/Windowskins/
    WINDOW_SKIN = 'Message'
    # Number of choice shown until a relative display is generated
    MaxChoice = 9
    # Index that tells the system to scroll up or down everychoice (relative display)
    DeltaChoice = (MaxChoice / 2.0).round
    # Create a new ChoiceWindow with the right parameters
    # @param width [Integer, nil] width of the window; if nil => automatically calculated
    # @param choices [Array<String>] list of choices
    # @param viewport [Viewport, nil] viewport in which the window is displayed
    def initialize(width, choices, viewport = nil)
    end
    # Retrieve the current layout configuration
    # @return [Configs::Project::Texts::ChoiceConfig]
    def current_layout
    end
    # Update the choice, if player hit up or down the choice index changes
    def update
    end
    # Translate the color according to the layout configuration
    # @param color [Integer] color to translate
    # @return [Integer] translated color
    def translate_color(color)
    end
    # Return the default height of a text line
    # @return [Integer]
    def default_line_height
    end
    # Return the default text color
    # @return [Integer]
    def default_color
    end
    alias get_default_color default_color
    # Return the disable text color
    # @return [Integer]
    def disable_color
    end
    alias get_disable_color disable_color
    # Update the mouse action
    def update_mouse
    end
    # Update the choice display when player hit UP
    def update_cursor_up
    end
    # Update the choice display when player hit DOWN
    def update_cursor_down
    end
    # Change the window builder and rebuild the window
    # @param builder [Array] The new window builder
    def window_builder=(builder)
    end
    # Build the window : update the height of the window and draw the options
    def build_window
    end
    # Draw the options
    def refresh
    end
    # Function that adds a choice text and manage various thing like getting the actual width of the text
    # @param text [String]
    # @param i [Integer] index in the loop
    # @return [Integer] the real width of the text
    def add_choice_text(text, i)
    end
    # Define the cursor rect
    def define_cursor_rect
    end
    # Tells the choice is done
    # @return [Boolean]
    def validated?
    end
    # Return the default horizontal margin
    # @return [Integer]
    def default_horizontal_margin
    end
    # Return the default vertical margin
    # @return [Integer]
    def default_vertical_margin
    end
    # Retrieve the current windowskin
    # @return [String]
    def current_windowskin
    end
    # Retrieve the current window_builder
    # @return [Array]
    def current_window_builder
    end
    # Function that creates a new ChoiceWindow for the message system
    # @param window [Window] a window that has the right window_builder (to calculate the width)
    # @return [ChoiceWindow] the choice window.
    def self.generate_for_message(window)
    end
    private
    def cool_down
    end
    public
    # Display a Choice "Window" but showing buttons instead of the common window
    class But < ChoiceWindow
      # Window Builder of this kind of choice window
      WindowBuilder = [11, 3, 100, 16, 12, 3]
      # Overwrite the current window_builder
      # @return [Array]
      def current_window_builder
      end
      # Overwrite the windowskin setter
      # @param v [Texture] ignored
      def windowskin=(v)
      end
    end
  end
  class GifReader
    class << self
      # Create a new GifReader from archives
      # @param filename [String] name of the gif file, including the .gif extension
      # @param cache_name [Symbol] name of the cache where to load the gif file
      # @param hue [Integer] 0 = normal, 1 = shiny for Pokemon battlers
      # @return [GifReader, nil]
      def create(filename, cache_name, hue = 0)
      end
      # Check if a Gif Exists
      # @param filename [String] name of the gif file, including the .gif extension
      # @param cache_name [Symbol] name of the cache where to load the gif file
      # @param hue [Integer] 0 = normal, 1 = shiny for Pokemon battlers
      # @return [Boolean]
      def exist?(filename, cache_name, hue = 0)
      end
    end
    alias old_update update
    # Update function that takes in account framerate of the game
    # @param bitmap [LiteRGSS::Bitmap] texture that receive the update
    # @return [self]
    def update(bitmap)
    end
  end
  # Debugguer for PSDK (UI)
  class Debug
    # Create a new Debug instance
    def initialize
    end
    # Update the debug each frame
    def update
    end
    private
    # Create the debugguer viewport
    def create_viewport
    end
    # Create the main debugger UI
    def create_main_ui
    end
    # Reset the game screen in order to make the debugger (set the window size to 1280x720 and the scale to 1)
    def reset_screen
    end
    class << self
      # Create a new debugger instance and delete the related message
      def create_debugger
      end
    end
    public
    # Main UI of the debugger
    class MainUI
      # @return [Integer] x position of the GUI on the screen
      SCREEN_X = 322
      # Create a new MainUI for the debug system
      # @param viewport [Viewport] viewport used to display the UI
      def initialize(viewport)
      end
      # Update the gui
      def update
      end
      private
      # Create the class text
      def create_class_text
      end
      # Update the class text
      def update_class_text
      end
      # Create the systag UI
      def create_systag_ui
      end
      # Update the systag ui
      def update_systag_ui
      end
      # Create the groups UI
      def create_groups_ui
      end
      # Update the group UI
      def update_groups_ui
      end
    end
    public
    # Show the system tag in debug mod
    class SystemTags
      # Create a new system tags viewer
      # @param viewport [Viewport]
      # @param stack [UI::SpriteStack] main stack giving the coordinates to use
      def initialize(viewport, stack)
      end
      # Update the view
      def update
      end
    end
    public
    # Show the Groups in debug mod
    class Groups
      # Create a new Group viewer
      # @param viewport [Viewport]
      # @param stack [UI::SpriteStack] main stack giving the coordinates to use
      def initialize(viewport, stack)
      end
      # Update the view
      def update
      end
      # Load the groups
      def load_groups
      end
      # Load the remaining groups
      # @param y [Integer] initial y position
      # @return [Integer] final y position
      def load_remaining_groups(y)
      end
    end
  end
  unless PSDK_CONFIG.release?
    Scheduler.add_proc(:on_update, :any, 'Yuki::Debug', 0) do
      Debug.create_debugger if Input::Keyboard.press?(Input::Keyboard::F9)
    end
  end
  # Module containing all the animation utility
  module Animation
    pi_div2 = Math::PI / 2
    # Hash describing all the distrotion procs
    DISTORTIONS = {SMOOTH_DISTORTION: proc { |x| 1 - Math.cos(pi_div2 * x ** 1.5) ** 5 }, UNICITY_DISTORTION: proc { |x| x }, SQUARE010_DISTORTION: proc { |x| 1 - (x * 2 - 1) ** 2 }, SIN: proc { |x| Math.sin(2 * Math::PI * x) }}
    # Hash describing all the time sources
    TIME_SOURCES = {GENERIC_TIME_SOURCE: Graphics.method(:current_time)}
    # Default object resolver (make the game crash)
    DEFAULT_RESOLVER = proc { |x| raise "Couldn't resolve object :#{x}" }
    module_function
    # Create a "wait" animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def wait(during, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, distortion = :UNICITY_DISTORTION, time_source = :GENERIC_TIME_SOURCE)
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
    def rotation(during, on, angle_start, angle_end, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
    end
    # Create a opacity animation
    # @param during [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param opacity_start [Float, Symbol] start opacity
    # @param opacity_end [Float, Symbol] end opacity
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def opacity_change(during, on, opacity_start, opacity_end, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def scalar(time_to_process, on, property, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, property, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, property_get, property_set, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
      end
      private
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new ScalarOffsetAnimation
    # @return [ScalarOffsetAnimation]
    def scalar_offset(time_to_process, on, property_get, property_set, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def move(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def move_discreet(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def shift(during, on, start_x, start_y, end_x, end_y, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, property, a_x, a_y, b_x, b_y, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def cell_x_change(during, on, cell_start, cell_end, width, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def cell_y_change(during, on, cell_start, cell_end, width, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, property, a, b, factor = 1, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, property, a_x, a_y, b_x, b_y, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, cells, rounding = :round, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
      def initialize(time_to_process, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
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
    def move_sprite_position(time_to_process, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :GENERIC_TIME_SOURCE)
    end
    # Create a new TimedLoopAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param distortion [#call, Symbol] callable taking one paramater (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distord time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def timed_loop_animation(time_to_process, distortion = :UNICITY_DISTORTION, time_source = :GENERIC_TIME_SOURCE)
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
  end
end
Hooks.register(Spriteset_Map, :finish_init, 'Yuki::TJN') do
  Yuki::TJN.force_update_tone
  Yuki::TJN.update
end
Hooks.register(Spriteset_Map, :update_fps_balanced, 'Yuki::TJN') {Yuki::TJN.update }
