module Util
  # Module that hold a warping function
  # @author Nuri Yuri
  module Warp
    module_function
    # Warp to an event of another map (below by default)
    # @param map_id [Integer] ID of the map where to warp
    # @param name_or_id [Integer, String] name or ID of the event that will be found
    # @param transition_type [Integer] 0 = no transition, 1 = circular transition, 2 = directed transition, -1 = bw transition
    # @param offset_x [Integer] offset x to add to the warp x coordinate
    # @param offset_y [Integer] offset y to add to the warp y coordinate
    # @param direction [Integer] new direction of the player
    def to(map_id, name_or_id, transition_type = 0, offset_x: 0, offset_y: 1, direction: 0)
    end
    # Define the transition for the warping process
    # @param type [Integer] type of transition
    def setup_transition(type)
    end
    # Warp to the specified coordinate
    # @param map_id [Integer] ID of the map where to warp
    # @param x_pos [Integer] x coordinate where to warp
    # @param y_pos [Integer] y coordinate where to warp
    # @param direction [Integer] new direction of the player
    def warp(map_id, x_pos, y_pos, direction)
    end
    # Find the event coordinate in another map
    # @param map_id [Integer] ID of the map where to warp
    # @param name_or_id [Integer, String] name or ID of the event that will be found
    # @return [Array<Integer>] x & y coordinate of the event in the other map
    def find_event_from(map_id, name_or_id)
    end
  end
end
module UI
  # Show a panel about the currently visited zone on the map
  class MapPanel < SpriteStack
    # Animation delta y
    DELTA_Y = 32
    # Create a new MapPanel
    # @param viewport [Viewport]
    # @param zone [Studio::Zone]
    def initialize(viewport, zone)
    end
    # Update the panel animation
    def update
    end
    # Tell if the animation is done and the pannel should be disposed
    def done?
    end
    private
    def create_sprites
    end
    def create_animation
    end
    def create_background
    end
    def create_text
    end
    def background_filename
    end
    def initial_coordinates
    end
  end
end
# Describe a picture display on the Screen
class Game_Picture
  attr_reader :number
  # ピクチャ番号
  attr_reader :name
  # ファイル名
  attr_reader :origin
  # 原点
  attr_reader :x
  # X 座標
  attr_reader :y
  # Y 座標
  attr_reader :zoom_x
  # X 方向拡大率
  attr_reader :zoom_y
  # Y 方向拡大率
  attr_reader :opacity
  # 不透明度
  attr_reader :blend_type
  # ブレンド方法
  attr_reader :tone
  # 色調
  attr_reader :angle
  # 回転角度
  attr_reader :mirror
  # Initialize the Game_Picture with default value
  # @param number [Integer] the "id" of the picture
  def initialize(number)
  end
  # Show a picture
  # @param name [String] The name of the image in Graphics/Pictures
  # @param origin [Integer] the origin type (top left / center)
  # @param x [Numeric] the x position on the screen
  # @param y [Numeric] the y position on the screen
  # @param zoom_x [Numeric] the zoom on the width
  # @param zoom_y [Numeric] the zoom on the height
  # @param opacity [Numeric] the opacity of the picture
  # @param blend_type [Integer] the blend_type of the picture
  def show(name, origin, x, y, zoom_x, zoom_y, opacity, blend_type)
  end
  # Move a picture
  # @param duration [Integer] the number of frame the picture takes to move
  # @param origin [Integer] the origin type (top left / center)
  # @param x [Numeric] the x position on the screen
  # @param y [Numeric] the y position on the screen
  # @param zoom_x [Numeric] the zoom on the width
  # @param zoom_y [Numeric] the zoom on the height
  # @param opacity [Numeric] the opacity of the picture
  # @param blend_type [Integer] the blend_type of the picture
  def move(duration, origin, x, y, zoom_x, zoom_y, opacity, blend_type)
  end
  # Rotate the picture
  # @param speed [Numeric] the rotation speed (2*angle / frame)
  def rotate(speed)
  end
  # Start a tone change of the picture
  # @param tone [Tone] the new tone of the picture
  # @param duration [Integer] the number of frame the tone change takes
  def start_tone_change(tone, duration)
  end
  # Remove the picture from the screen
  def erase
  end
  # Set the mirror state of a Game_Picture
  # @param bool [Boolean] the mirror state
  def mirror=(bool)
  end
  # Update the picture state change
  def update
  end
end
# Update every component that affect the screen
class Game_Screen
  # Tone that is considered neutral (to let interpreter know how to handle tone & TJN)
  NEUTRAL_TONE = Tone.new(0, 0, 0, 0)
  attr_reader :tone
  # 色調
  attr_reader :flash_color
  # フラッシュ色
  attr_reader :shake
  # シェイク位置
  attr_reader :pictures
  # ピクチャ
  attr_reader :weather_type
  # 天候 タイプ
  attr_reader :weather_max
  # 天候 画像の最大数
  # default initializer
  def initialize
  end
  # start a tone change process
  # @param tone [Tone] the new tone
  # @param duration [Integer] the time it takes in frame
  def start_tone_change(tone, duration)
  end
  # start a flash process
  # @param color [Color] a color
  # @param duration [Integer] the time it takes in frame
  def start_flash(color, duration)
  end
  # start a screen shake process
  # @param power [Integer] the power of the shake (distance between normal position and shake limit position)
  # @param speed [Integer] the speed of the shake (10 = 4 frame to get one shake period)
  # @param duration [Integer] the time the shake lasts
  def start_shake(power, speed, duration)
  end
  # starts a weather change process
  # @param type [Integer] the type of the weather
  # @param power [Numeric] The power of the weather
  # @param duration [Integer] the time it takes to change the weather
  # @param psdk_weather [Integer, nil] the PSDK weather type
  def weather(type, power, duration, psdk_weather: nil)
  end
  # Update every process and picture
  def update
  end
end
# Class that describe a Character Sprite on the Map
class Sprite_Character < RPG::Sprite
  # Zoom of a tile and factor used to fix coordinate
  TILE_ZOOM = Configs.display.tilemap_settings.character_tile_zoom
  # Zoom of a Sprite
  SPRITE_ZOOM = Configs.display.tilemap_settings.character_sprite_zoom
  # Tag that disable shadow
  SHADOW_TAG = '§'
  # Name of the shadow file
  SHADOW_FILE = '0 Ombre Translucide'
  # Enable or disable realistic shadow
  REALISTIC_SHADOW = true
  # Tag that add 1 to the superiority of the Sprite_Character
  SUP_TAG = '¤'
  # Blend mode for Reflection
  REFLECTION_BLEND_MODE = BlendMode.new
  REFLECTION_BLEND_MODE.alpha_dest_factor = BlendMode::One
  REFLECTION_BLEND_MODE.alpha_src_factor = BlendMode::Zero
  # Character displayed by the Sprite_Character
  # @return [Game_Character]
  attr_accessor :character
  # Return the Sprite bush_depth
  # @return [Integer]
  attr_reader :bush_depth
  # Initialize a new Sprite_Character
  # @param viewport [Viewport] the viewport where the sprite will be shown
  # @param character [Game_Character, Game_Event, Game_Player] the character shown
  def initialize(viewport, character = nil)
  end
  # Initialize the specific parameters of the Sprite_Character (shadow, add_z etc...)
  # @param character [Game_Character, Game_Event, Game_Player] the character shown
  def init(character)
  end
  # Initialize the add_z info & the shadow sprite of the Sprite_Character
  def init_add_z_shadow
  end
  # Update every informations about the Sprite_Character
  def update
  end
  # Update the graphics of the Sprite_Character
  def update_graphics
  end
  # Update the sprite graphics
  def update_sprite_graphic
  end
  # Update the tile graphic of the sprite
  def update_tile_graphic
  end
  # Update the position of the Sprite_Character on the screen
  # @return [Boolean] if the update can continue after the call of this function or not
  def update_position
  end
  # Update the pattern animation
  def update_pattern
  end
  # Load the animation when there's one on the character
  def update_load_animation
  end
  # Update the bush depth effect
  def update_bush_depth
  end
  # Change the bush_depth
  # @param value [Integer]
  def bush_depth=(value)
  end
  # Dispose the Sprite_Character and its shadow
  def dispose
  end
  # Initialize the shadow display
  def init_shadow
  end
  # Update the shadow
  def update_shadow
  end
  # Dispose the shadow sprite
  def dispose_shadow
  end
  # Init the reflection sprite
  def init_reflection
  end
  # Update the reflection graphics
  def update_reflection_graphics
  end
  # Dispose the reflection sprite
  def dispose_reflection
  end
  # Fix the animation file
  def self.fix_rmxp_animations
  end
end
# A sprite that show a Game_Picture on the screen
class Sprite_Picture < ShaderedSprite
  # Tell if the loop of the gif is disabled or not
  # @return [Boolean]
  attr_accessor :gif_loop_disabled
  # Initialize a new Sprite_Picture
  # @param viewport [Viewport] the viewport where the sprite will be shown
  # @param picture [Game_Picture] the picture
  def initialize(viewport, picture)
  end
  # Dispose the picture
  def dispose
  end
  # Update the picture sprite display with the information of the current Game_Picture
  def update
  end
  # Tell if the gif animation is done
  # @return [Boolean]
  def gif_done?
  end
  private
  # Update the picture properties on the sprite
  def update_properties
  end
  # Update the gif animation
  def update_gif
  end
  # Load the picture bitmap
  def load_bitmap
  end
  # Dispose the bitmap
  def dispose_bitmap
  end
end
# Display the main Timer on the screen
class Sprite_Timer < Text
  # Create the timer with its surface
  def initialize(viewport = nil)
  end
  # Update the timer according to the frame_rate and the number of frame elapsed.
  def update
  end
end
# Display everything that should be displayed during the Scene_Map
class Spriteset_Map
  include Hooks
  # Retrieve the Game Player sprite
  # @return [Sprite_Character]
  attr_reader :game_player_sprite
  # Initialize a new Spriteset_Map object
  # @param zone [Integer, nil] the id of the zone where the player is
  def initialize(zone = nil)
  end
  # Method responsive of initializing the viewports
  # @param viewport_type [Symbol]
  def init_viewports(viewport_type)
  end
  # Take a snapshot of the spriteset
  # @return [Array<Texture>]
  def snap_to_bitmaps
  end
  # Do the same as initialize but without viewport initialization (opti)
  # @param zone [Integer, nil] the id of the zone where the player is
  def reload(zone = nil)
  end
  # Last step of the Spriteset initialization
  # @param zone [Integer, nil] the id of the zone where the player is
  def finish_init(zone)
  end
  # Return the prefered tilemap class
  # @return [Class]
  def tilemap_class
  end
  # Tilemap initialization
  def init_tilemap
  end
  # Attempt to load an autotile
  # @param filename [String] name of the autotile
  # @return [Texture] the bitmap of the autotile
  def load_autotile(filename)
  end
  # Attempt to load an autotile
  # @param filename [String] name of the autotile
  # @return [Texture] the bitmap of the autotile
  def load_autotile_internal(filename)
  end
  # Panorama and fog initialization
  def init_panorama_fog
  end
  # PSDK related thing initialization
  def init_psdk_add
  end
  Hooks.register(self, :initialize, 'PSDK Additional Spriteset Initialization') {init_psdk_add }
  Hooks.register(self, :reload, 'PSDK Additional Spriteset Initialization') {init_psdk_add }
  # Sprite_Character initialization
  def init_characters
  end
  # Recycled Sprite_Character initialization
  # @param character_sprites [Array<Sprite_Character>] the actual stack of sprites
  def recycle_characters(character_sprites)
  end
  # Player initialization
  def init_player
  end
  # Weather, picture and timer initialization
  def init_weather_picture_timer
  end
  # Create the quest informer array
  def init_quest_informer
  end
  Hooks.register(self, :initialize, 'Quest Informer') {init_quest_informer }
  # Tell if the spriteset is disposed
  # @return [Boolean]
  def disposed?
  end
  # Spriteset_map dispose
  # @param from_warp [Boolean] if true, prepare a screenshot with some conditions and cancel the sprite dispose process
  # @return [Sprite, nil] a screenshot or nothing
  def dispose(from_warp = false)
  end
  # Update every sprite
  def update
  end
  # update event sprite
  def update_events
  end
  # update weather and picture sprites
  def update_weather_picture
  end
  # update panorama and fog sprites
  def update_panorama_fog
  end
  # Get the Sprite_Picture linked to the ID of the Game_Picture
  # @param [Integer] the ID of the Game_Picture
  # @return [Sprite_Picture]
  def sprite_picture(id_game_picture)
  end
  # create the zone panel of the current zone
  # @param zone [Integer, nil] the id of the zone where the player is
  def create_panel(zone)
  end
  Hooks.register(self, :finish_init, 'Zone Panel') { |method_binding| create_panel(method_binding[:zone]) }
  # Dispose the zone panel
  def dispose_sp_map
  end
  Hooks.register(self, :reload, 'Zone Panel') {dispose_sp_map }
  Hooks.register(self, :dispose, 'Zone Panel') {dispose_sp_map }
  # Update the zone panel
  def update_panel
  end
  Hooks.register(self, :update, 'Zone Panel') {update_panel }
  # Change the visible state of the Spriteset
  # @param value [Boolean] the new visibility state
  def visible=(value)
  end
  # Return the map viewport
  # @return [Viewport]
  def map_viewport
  end
  # Add a new quest informer
  # @param name [String] Name of the quest
  # @param quest_status [Symbol] status of quest (:new, :completed, :failed)
  def inform_quest(name, quest_status)
  end
  private
  # Take a snapshot of the map
  # @return [Sprite] the snapshot ready to be used
  def take_map_snapshot
  end
  # Update the quest informer
  def update_quest_informer
  end
  Hooks.register(self, :update, 'Quest Informer') {update_quest_informer }
  Hooks.register(Spriteset_Map, :reload, 'Spriteset_Map reloaded') do
    if $game_map.fog_name == nil.to_s && $game_switches[Yuki::Sw::Env_CanFly] && $fog_info
      $game_map.fog_name = $fog_info[0]
      $game_map.fog_hue = $fog_info[1]
      $game_map.fog_opacity = $fog_info[2]
      $game_map.fog_blend_type = $fog_info[3]
      $game_map.fog_zoom = $fog_info[4]
      $game_map.fog_sx = $fog_info[5]
      $game_map.fog_sy = $fog_info[6]
    end
  end
end
module Yuki
  # Module that manage the particle display
  # @author Nuri Yuri
  module Particles
    module_function
    # Init the particle display on a new viewport
    # @param viewport [Viewport]
    def init(viewport)
    end
    # Update of the particles & stack cleaning if requested
    def update
    end
    # Request to clean the stack
    def clean_stack
    end
    # Add a particle to the stack
    # @param character [Game_Character] the character on which the particle displays
    # @param particle_tag [Integer, Symbol] identifier of the particle in the hash
    # @param params [Hash] additional params for the particle
    # @return [Particle_Object]
    def add_particle(character, particle_tag, params = {})
    end
    # Add a named particle (particle that has a specific flow)
    # @param name [Symbol] name of the particle to prevent collision
    # @param character [Game_Character] the character on which the particle displays
    # @param particle_tag [Integer, Symbol] identifier of the particle in the hash
    # @param params [Hash] additional params for the particle
    def add_named_particle(name, character, particle_tag, params = {})
    end
    # Add a parallax
    # @param image [String] name of the image in Graphics/Pictures/
    # @param x [Integer] x coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
    # @param y [Integer] y coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
    # @param z [Integer] z superiority in the tile viewport
    # @param zoom_x [Numeric] zoom_x of the parallax
    # @param zoom_y [Numeric] zoom_y of the parallax
    # @param opacity [Integer] opacity of the parallax (0~255)
    # @param blend_type [Integer] blend_type of the parallax (0, 1, 2)
    # @return [Parallax_Object]
    def add_parallax(image, x, y, z, zoom_x = 1, zoom_y = 1, opacity = 255, blend_type = 0)
    end
    # Add a building
    # @param image [String] name of the image in Graphics/Autotiles/
    # @param x [Integer] x coordinate of the building
    # @param y [Integer] y coordinate of the building
    # @param oy [Integer] offset y coordinate of the building in native resolution pixel
    # @param visible_from1 [Symbol, false] data parameter (unused there)
    # @param visible_from2 [Symbol, false] data parameter (unused there)
    # @return [Building_Object]
    def add_building(image, x, y, oy = 0, visible_from1 = false, visible_from2 = false)
    end
    # Return the viewport of in which the Particles are shown
    def viewport
    end
    # Tell if the system is ready to work
    # @return [Boolean]
    def ready?
    end
    # Tell the particle manager the game is warping the player. Particle will skip the :enter phase.
    # @param v [Boolean]
    def set_on_teleportation(v)
    end
    # Dispose each particle
    def dispose
    end
    class << self
      # Return the list of named particles
      # @return [Hash{ Symbol => Particle_Object }]
      attr_reader :named
    end
    public
    # The particle data
    Data = []
    # The empty actions
    EMPTY = {max_counter: 1, loop: false, data: []}
    module_function
    # Function that find the data for a particle according to the terrain_tag & the particle tag
    # @note This function will try $game_variables[Var::PAR_DatID] & 0 as terrain_tag if the particle_tag wasn't found
    # @param terrain_tag [Integer] terrain_tag in which the event is
    # @param particle_tag [Integer, Symbol] identifier of the particle in the hash
    def find_particle(terrain_tag, particle_tag)
    end
    safe_code('Particle Data Loading') do
      remove_const :Data
      const_set :Data, load_data('Data/Animations/Particles.dat')
    end
  end
  class Particle_Object
    # List of action handler to know how to compute the current frame of the particle
    ACTION_HANDLERS = {}
    # Order of the particle handlers
    ACTION_HANDLERS_ORDER = []
    # Add a new action handler
    # @param name [Symbol] name of the action
    # @param before [Symbol, nil] tell to put this handler before another handler
    def self.add_handler(name, before = nil, &block)
    end
    add_handler(:state) { |data| @state = data }
    add_handler(:on_chara_move_end) { |data| execute_action(data) if @character.movable? }
    add_handler(:zoom) { |data| @sprite.zoom = data * 1 }
    add_handler(:file) do |data|
      @sprite.bitmap = RPG::Cache.particle(data)
      @ox = @sprite.bitmap.width / 2
      @oy = @sprite.bitmap.height
    end
    add_handler(:position) { |data| @position_type = data }
    add_handler(:angle) { |data| @sprite.angle = data }
    add_handler(:add_z) { |data| @add_z = data }
    add_handler(:oy_offset) { |data| @oy_off = data + @params.fetch(:oy_offset, 0) }
    add_handler(:ox_offset) { |data| @ox_off = data + @params.fetch(:ox_offset, 0) }
    add_handler(:set_z) { |data| @set_z = data }
    add_handler(:opacity) { |data| @sprite.opacity = data }
    add_handler(:se_play) { |data| Audio.se_play(*data) }
    add_handler(:se_player_play) { |data| Audio.se_play(*data) if @character == $game_player }
    add_handler(:wait) { |data| @wait_count = data.to_i }
    add_handler(:chara) do |data|
      cw = @sprite.bitmap.width / 4
      ch = @sprite.bitmap.height / 4
      sx = @character.pattern * cw
      sy = (@character.direction - 2) / 2 * ch
      @sprite.src_rect.set(sx, sy, cw, ch)
      @ox = cw / 2
      @oy = ch / 2
    end
    add_handler(:rect) do |data|
      @sprite.src_rect.set(*data)
      @ox = data[2] / 2
      @oy = data[3]
    end
    # Zoom of a tile to adjust coordinate
    TILE_ZOOM = Configs.display.tilemap_settings.character_tile_zoom
    # if the particle is disposed
    # @return [Boolean]
    attr_reader :disposed
    # Create a particle object
    # @param character [Game_Character] the character on which the particle displays
    # @param data [Hash{Symbol => Hash}] the data of the particle
    #    field of the data hash :
    #       enter: the particle animation when character enter on the tile
    #       stay: the particle animation when character stay on the tile
    #       leave: the particle animation when character leave the tile
    #    field of the particle animation
    #       max_counter: the number of frame on the animation
    #       loop: Boolean # if the animation loops or not
    #       data: an Array of animation instructions (Hash)
    #    field of an animation instruction
    #       state: Symbol # the new state of the particle
    #       zoom: Numeric # the zoom of the particle
    #       position: Symbol # the position type of the particle (:center_pos, :character_pos)
    #       file: String # the filename of the particle in Graphics/Particles/
    #       angle: Numeric # the angle of the particle
    #       add_z: Integer # The z offset relatively to the character
    #       oy_offset: Integer # The offset in oy
    #       opacity: Integer # The opacity of the particle
    #       chara: Boolean # If the particle Texture is treaten like the Character bitmap
    #       rect: Array(Integer, Integer, Integer, Integer) # the parameter of the #set function of Rect (src_rect)
    # @param on_tp [Boolean] tells the particle to skip the :enter animation or not
    # @param params [Hash] additional params for the animation
    # @option params [Symbol] :flow define the kind of flow to use for the animation
    # @option params [Integer] :radius define the radius to use for the :update_radius_flow flow
    def initialize(character, data, on_tp = false, params = {})
    end
    # Update the particle animation
    def update
    end
    # Get the real x of the particle on the map
    # @return [Integer]
    def x
    end
    # Get the real y of the particle on the map
    # @return [Integer]
    def y
    end
    # Update the particle info
    # @param data [Hash] the data related to the current state
    # @return [Boolean] if the update_sprite_position can be done
    def update_particle_info(data)
    end
    # Update the default particle state flow
    # @param data [Hash] the data related to the current state
    # @return [Boolean]
    def update_default_flow(data)
    end
    # Update the radius particle kind flow
    # @param data [Hash] the data related to the current state
    # @return [Boolean]
    def update_radius_flow(data)
    end
    # Execute an animation instruction
    # @param action [Hash] the animation instruction
    def exectute_action(action)
    end
    # Update the position of the particle sprite
    def update_sprite_position
    end
    # Function that process screen z depending on original screen_y (without zoom)
    def screen_z
    end
    # Dispose the particle
    def dispose
    end
    alias disposed? disposed
    private
    # Init the map_data info for the particle
    # @param character [Game_Event, Game_Character, Game_Player]
    def init_map_data(character)
    end
    # Initialize the zoom info
    def init_zoom
    end
  end
  # Object that describe a parallax as a particle
  # @author Nuri Yuri
  class Parallax_Object
    # If the parallax is disposed
    # @return [Boolean]
    attr_reader :disposed
    # The parallax sprite
    # @return [Sprite]
    attr_accessor :sprite
    # the factor that creates an automatic offset in x
    # @return [Numeric]
    attr_accessor :factor_x
    # the factor that creates an automatic offset in y
    # @return [Numeric]
    attr_accessor :factor_y
    # Creates a new Parallax_Object
    # @param image [String] name of the image in Graphics/Pictures/
    # @param x [Integer] x coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
    # @param y [Integer] y coordinate of the parallax from the first pixel of the Map (16x16 tiles /!\)
    # @param z [Integer] z superiority in the tile viewport
    # @param zoom_x [Numeric] zoom_x of the parallax
    # @param zoom_y [Numeric] zoom_y of the parallax
    # @param opacity [Integer] opacity of the parallax (0~255)
    # @param blend_type [Integer] blend_type of the parallax (0, 1, 2)
    def initialize(image, x, y, z, zoom_x = 1, zoom_y = 1, opacity = 255, blend_type = 0)
    end
    # Update the parallax position
    def update
    end
    # Dispose the parallax
    def dispose
    end
    alias disposed? disposed
  end
  # Object that describe a building on the Map as a Particle
  # @author Nuri Yuri
  class Building_Object
    # If the building is disposed
    # @return [Boolean]
    attr_reader :disposed
    # The building sprite
    # @return [Sprite]
    attr_accessor :sprite
    # Create a new Building_Object
    # @param image [String] name of the image in Graphics/Autotiles/
    # @param x [Integer] x coordinate of the building
    # @param y [Integer] y coordinate of the building
    # @param oy [Integer] offset y coordinate of the building in native resolution pixel
    def initialize(image, x, y, oy)
    end
    # Update the building position (x, y, z)
    def update
    end
    # Dispose the building
    def dispose
    end
    alias disposed? disposed
  end
  # MapLinker, script that emulate the links between maps. This script also display events.
  # @author Nuri Yuri
  module MapLinker
    # The offset in X until we see black borders
    OFFSET_X = Configs.display.tilemap_settings.map_linker_offset.x
    # The offset in Y until we seen black borders
    OFFSET_Y = Configs.display.tilemap_settings.map_linker_offset.y
    # The number of tiles the Maker has to let in common between each maps
    DELTA_MAKER = Configs.display.tilemap_settings.uses_old_map_linker ? 3 : 0
    # The default Map (black borders)
    DEFAULT_MAP = RPG::Map.new(20, 15)
    # The map filename format
    MAP_FORMAT = 'Data/Map%03d.rxdata'
    # List of link types for the link loading
    LINK_TYPES = %i[north east south west]
    class << self
      alias get_OffsetX void0
      alias get_OffsetY void0
      alias current_OffsetX void0
      alias current_OffsetY void0
      # Return the map datas
      # @return [Array<Yuki::Tilemap::MapData>]
      attr_reader :map_datas
      # Return the SpritesetMap object used to load the map
      # @return [Spriteset_Map]
      attr_accessor :spriteset
      # Get the added events
      # @return [Hash<Integer => Array<RPG::Event>>] Integer is map_id
      attr_reader :added_events
      # Test if the given event is from the center map or not
      # @param event [Game_Event] the event to test
      # @return [Boolean, nil]
      def from_center_map?(event)
      end
      # Reset the module when the RGSS resets itself
      def reset
      end
      # Load a map and its linked map
      # @param map_id [Integer] the map ID
      # @return [RPG::Map] the map adjusted
      def load_map(map_id)
      end
      # Function that loads the current map data
      # @param map_id [Integer]
      # @return [Array<Yuki::Tilemap::MapData>]
      def load_current_map_datas(map_id)
      end
      # Load the map_datas array from the link_data
      # @param link_data [Studio::MapLink]
      # @param map_datas [Array<Yuki::Tilemap::MapData>]
      # @param current_map [RPG::Map] map currently being loaded
      def load_map_data_from_link_data(link_data, map_datas, current_map)
      end
      # Load a map data from a link
      # @param link [Studio::MapLink::Link]
      # @param cardinal [:north, :south, :east, :west]
      # @param current_map [RPG::Map] map currently being loaded
      # @return [Tilemap::MapData]
      def load_map_data_from_link(link, cardinal, current_map)
      end
      # Load the data of a map (with some optimizations)
      # @param map_id [Integer] the id of the Map
      # @return [RPG::Map]
      def load_map_data(map_id)
      end
      # Return the current tileset name
      # @return [String]
      def tileset_name
      end
      if Configs.display.tilemap_settings.uses_old_map_linker
        # Test if the player can warp between maps and warp him
        def test_warp
        end
      else
        # Test if the player can warp between maps and warp him
        def test_warp
        end
      end
      # Test if a tile is passable
      # @param x [Integer] x coordinate of the tile on the map
      # @param y [Integer] y coordinate of the tile on the map
      # @param d [Integer] direction to check
      # @param event [Game_Character]
      def passable?(x, y, d = 0, event = $game_player)
      end
      # Retrieve the ID of the SystemTag on a specific tile
      # @param x [Integer] x position of the tile
      # @param y [Integer] y position of the tile
      # @return [Integer]
      # @author Nuri Yuri
      def system_tag(x, y)
      end
      # Check if a specific SystemTag is present on a specific tile
      # @param x [Integer] x position of the tile
      # @param y [Integer] y position of the tile
      # @param tag [Integer] ID of the SystemTag
      # @return [Boolean]
      # @author Nuri Yuri
      def system_tag_here?(x, y, tag)
      end
      private
      # Load the visible events for all maps
      def load_events
      end
      # Load the visible event of a map
      # @param map [Yuki::Tilemap::MapData]
      def load_events_loop(map)
      end
      # Adjust the event position and id. Move them on the current map
      # @param data [RPG::Map] the map where the event normally are
      # @param min [Integer] the min position where the event can be to be cloned
      # @param max [Integer] the max position where the event can be to be cloned
      # @param ox [Integer] the offset x of the event
      # @param oy [Integer] the offset y of the event
      # @param last_event_id [Integer] the last event id
      # @param events [Hash] the event hash of the current map
      # @param map_id [Integer] the map id of the event
      # @param type [Symbol] the property checked on the event to check if they're cloned or not
      # @return [Integer] the new last_event_id
      def ajust_events(data, min, max, ox, oy, last_event_id, events, map_id, type = :x)
      end
      # Warp a player to a new map and a new location
      # @param map_id [Integer] the ID of the new map
      # @param x [Integer] the new x position of the player
      # @param y [Integer] the new y position of the player
      def warp(map_id, x, y)
      end
    end
  end
  module FollowMe
    module_function
    # Tell if the system is enabled or not
    # @return [Boolean]
    def enabled
    end
    # Enable or disabled the system
    # @param state [Boolean] new enabled state
    def enabled=(state)
    end
    # Get the current selected follower (to move using player moveroutes)
    # @return [Integer] 0 = no follower selected
    def selected_follower
    end
    # Set the selected follower
    # @param index1 [Integer] index of the follower in the follower stack starting at index 1
    def selected_follower=(index1)
    end
    # Get the number of human following the player (Heroes from 2 to n+1)
    # @return [Integer]
    def human_count
    end
    # Set the number of human following the player
    # @param count [Integer] number of human
    def human_count=(count)
    end
    # Get the number of pokemon following the player
    # @return [Integer]
    def pokemon_count
    end
    # Set the number of pokemon following the player
    # @param count [Integer]
    def pokemon_count=(count)
    end
    # Get the number of Pokemon from "other_party" following the player
    # @return [Integer]
    def other_pokemon_count
    end
    # Set the number of Pokemon from "other_party" following the player
    # @param count [Integer]
    def other_pokemon_count=(count)
    end
    # Is the FollowMe in Let's Go Mode
    # @return [Boolean]
    def in_lets_go_mode?
    end
    # Set the FollowMe Let's Go Mode state
    # @param mode [Boolean] true if in lets go mode
    def lets_go_mode=(mode)
    end
    public
    @followers = []
    module_function
    # Init the FollowMe on a new viewport. Previous Follower are disposed.
    # @param viewport [Viewport] the new viewport
    def init(viewport)
    end
    # Remove event follower from player when the FollowMe gets re-initialized
    def fix_follower_event
    end
    # Update of the Follower Management. Their graphics are updated here.
    def update
    end
    # Function that attempts to set the event as last follower
    # @param last_follower [Game_Character]
    # @param follower_event [Game_Event]
    def update_follower_event(last_follower, follower_event)
    end
    # Get the follower entities (those giving information about character_name)
    # @return [Array<#character_name>]
    def follower_entities
    end
    # Get the human follower entities
    # @return [Array<#character_name>]
    def human_entities
    end
    # Get the player's pokemon follower entities
    # @return [Array<#character_name>]
    def player_pokemon_entities
    end
    # Get the player's pokemon follower entity if the FollowMe mode is Let's Go
    # @return [Array<#character_name>]
    def player_pokemon_lets_go_entity
    end
    # Get the friend's pokemon follower entities
    # @return [Array<#character_name>]
    def other_pokemon_entities
    end
    # Update of a single follower
    # @param last_follower [Game_Character] the last follower (in case of Follower creation)
    # @param i [Integer] index in the @followers Array
    # @param entity [PFM::Pokemon, Game_Actor] the entity that is shown as a follower
    # @param chara_update [Boolean] if the character graphics and informations needs to be updated
    # @return [Game_Character] the character that will become the last_follower
    def update_follower(last_follower, i, entity, chara_update)
    end
    # Sets the default position of a follower
    # @param c [Game_Character] the character
    # @param i [Integer] the index of the caracter in the @followers Array
    def position_character(c, i)
    end
    # Clears the follower (and dispose them)
    def clear
    end
    # Retrieve a follower
    # @param i [Integer] index of the follower in the @followers Array
    # @return [Game_Character] $game_player if i is invalid
    def get_follower(i)
    end
    # yield a block on each Followers
    # @param block [Proc] the block to call
    # @example Turn each follower down
    #   Yuki::FollowMe.each_follower { |c| c.turn_down }
    def each_follower(&block)
    end
    # Sets the position of each follower (Warp)
    # @param args [Array<Integer, Integer, Integer>] array of x, y, direction
    def set_positions(*args)
    end
    # Positions followers in the correct place after battle
    def reload_position_after_battle
    end
    # Saves follower positions to user_data
    def save_follower_positions
    end
    # Reset position of each follower to the player (entering in a building)
    def reset_position
    end
    # Test if a character is a Follower of the player
    # @param character [Game_Character]
    def is_player_follower?(character)
    end
    # Set the Follower Manager in Battle mode. When getting out of battle every character will get its particle pushed.
    def set_battle_entry(v = true)
    end
    # Push particle of each character if the Follower Manager was in Battle mode.
    def particle_push
    end
    # Dispose the follower and release resources.
    def dispose
    end
    # Smart disable the following system (keep it active when smart_enable is called)
    def smart_disable
    end
    # Smart disable the following system (keep it active when smart_enable is called)
    def smart_enable
    end
    # Enable / Disable the particles for the player followers
    def set_player_follower_particles(value)
    end
  end
  # Class responsive of displaying the map
  class Tilemap
    # Array telling how much layer each priority layer can show
    PRIORITY_LAYER_COUNT = [3, 2, 2, 1, 1, 1]
    # Get all the map data used by the tilemap
    # @return [Array<Yuki::Tilemap::MapData>]
    attr_reader :map_datas
    # Get the ox
    # @return [Integer]
    attr_accessor :ox
    # Get the oy
    # @return [Integer]
    attr_accessor :oy
    # Create a new Tilemap
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Reset the tilemap in order to force it to draw the frame
    def reset
    end
    # Update the tilemap
    def update
    end
    # Is the tilemap disposed
    # @return [Boolean]
    def disposed?
    end
    # Set the map datas
    # @param map_datas [Array<Yuki::Tilemap::MapData>]
    def map_datas=(map_datas)
    end
    # Dispose the tilemap
    def dispose
    end
    private
    # Generate the sprites of the tilemap with the right settings
    # @param tile_size [Integer] the dimension of a tile
    # @param zoom [Numeric] the global zoom of a tile
    def create_sprites(tile_size = 32, zoom = 1)
    end
    # Adjust the sprites variable when the priority allow only two sprites => c3 c2 c3
    # @param priority [Integer] the current priority
    # @param count [Integer] the number of layer allowed for the priority
    # @return [Sprite_Map]
    def adjust_sprite_layer(priority, count)
    end
    # Get the tilemap configuration for its size
    # @return [Array<Integer>]
    def nx_ny_configs
    end
    # Update the position of each tile according to the ox / oy, also adjusts z
    # @param ox [Integer] ox of every tiles
    # @param oy [Integer] oy of every tiles
    def update_position(ox, oy)
    end
    # Draw the tiles (suboptimal)
    # @param x [Integer] real world x of the top left tile
    # @param y [Integer] real world y of the top left tile
    def draw_suboptimal(x, y)
    end
    # Draw the tiles
    # @param x [Integer] real world x of the top left tile
    # @param y [Integer] real world y of the top left tile
    def draw(x, y)
    end
    public
    # Class containing the map Data and its resources
    class MapData
      # List of method that help to load the position
      POSITION_LOADERS = {north: :load_position_north, south: :load_position_south, east: :load_position_east, west: :load_position_west, self: :load_position_self}
      # Get access to the original map data
      # @return [RPG::Map]
      attr_reader :map
      # Get the map id
      # @return [Integer]
      attr_reader :map_id
      # Get the map X coordinate range
      # @return [Range]
      attr_reader :x_range
      # Get the map Y coordinate range
      # @return [Range]
      attr_reader :y_range
      # Get the map offset_x
      # @return [Integer]
      attr_reader :offset_x
      # Get the map offset_y
      # @return [Integer]
      attr_reader :offset_y
      # Get the tileset filename (to prevent unwanted dispose in the future)
      # @return [String]
      attr_reader :tileset_name
      # Get the side of the map
      # @return [Symbol]
      attr_reader :side
      @tileset_chunks = {}
      # Create a new MapData
      # @param map [RPG::Map]
      # @param map_id [Integer]
      def initialize(map, map_id)
      end
      # Sets the position of the map in the 2D Space
      # @param map [RPG::Map] current map
      # @param side [Symbol] which side the map is (:north, :south, :east, :west)
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      def load_position(map, side, offset)
      end
      # Get a tile from the map
      # @param x [Integer] real world x position
      # @param y [Integer] real world y position
      # @param z [Integer] z
      def [](x, y, z)
      end
      # Set tile sprite to sprite
      # @param sprite [Sprite]
      # @param tile_id [Integer] ID of the tile the sprite wants
      def assign_tile_to_sprite(sprite, tile_id)
      end
      # Draw the tile on the right layer
      # @param x [Integer] real world x of the top left tile
      # @param y [Integer] real world y of the top left tile
      # @param tx [Integer] x index of the tile to draw from top left tile (0)
      # @param ty [Integer] y index of the tile to draw from top left tile (0)
      # @param tz [Integer] z index of the tile to draw
      # @param layer [Array<Array<SpriteMap>>] layers of the tilemap .dig(priority, ty)
      def draw(x, y, tx, ty, tz, layer)
      end
      # Draw the visible part of the map
      # @param x [Integer] real world x of the top left tile
      # @param y [Integer] real world y of the top left tile
      # @param rx [Integer] real world x of the bottom right tile
      # @param ry [Integer] real world y of the bottom right tile
      # @param layers [Array<Array<Array<SpriteMap>>>] layers of the tilemap .dig(tz, priority, ty)
      def draw_map(x, y, rx, ry, layers)
      end
      # Load the tileset
      def load_tileset
      end
      # Update the autotiles counter (for tilemap)
      def update_counters
      end
      private
      # Load the tileset graphics
      def load_tileset_graphics
      end
      def load_counters
      end
      # Load tileset chunks
      # @param name [Filename]
      # @return [Array<Texture>]
      def load_tileset_chunks(name)
      end
      # Load the position when map is on north
      # @param map [RPG::Map] current map
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      # @param maker_offset [Integer]
      def load_position_north(map, offset, maker_offset)
      end
      # Load the position when map is on south
      # @param map [RPG::Map] current map
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      # @param maker_offset [Integer]
      def load_position_south(map, offset, maker_offset)
      end
      # Load the position when map is on east
      # @param map [RPG::Map] current map
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      # @param maker_offset [Integer]
      def load_position_east(map, offset, maker_offset)
      end
      # Load the position when map is on east
      # @param map [RPG::Map] current map
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      # @param maker_offset [Integer]
      def load_position_west(map, offset, maker_offset)
      end
      # Load the position when map is the current one
      # @param map [RPG::Map] current map
      # @param offset [Integer] offset relative to the side of the map in the positive perpendicular position
      # @param maker_offset [Integer]
      def load_position_self(map, offset, maker_offset)
      end
      class << self
        # Get tileset chunks
        # @return [Hash{filename => Array<Texture>}]
        attr_reader :tileset_chunks
      end
      class AnimatedTileCounter
        # Hash of default AnimatedTileCounters
        DEFAULT_COUNTERS = {}
        # @return [Integer]
        attr_reader :count
        # @return [Array<Integer>]
        attr_reader :waits
        # @return [Time]
        attr_reader :last_update_time
        # Create a new animated tile counter
        # @param waits [Array<Integer>] list of number of frame to wait for each count
        def initialize(waits)
        end
        # Update the count value
        def update
        end
        # Synchronize itself with another animated tile
        # @param animated_tile [AnimatedTileCounter]
        def synchronize(animated_tile)
        end
        class << self
          # Set or get the last update counter time
          attr_accessor :last_update_counter_time
          # Get the default counters for the specified texture
          # @param texture [Texture]
          # @param texture_name [String]
          # @return [Array<AnimatedTileCounter>]
          def defaults(texture, texture_name)
          end
          # Synchronize all the counter based on their wait type
          def synchronize_all
          end
        end
      end
    end
  end
  # Tilemap definition for tilemap rendered with 16x16 tiles (default)
  class Tilemap16px < Tilemap
    private
    # Generate the sprites of the tilemap with the right settings
    # @param tile_size [Integer] the dimension of a tile
    # @param zoom [Numeric] the global zoom of a tile
    def create_sprites(tile_size = 16, zoom = 0.5)
    end
  end
end
Hooks.register(Spriteset_Map, :init_psdk_add, 'Yuki::Particles') do
  Yuki::Particles.init(@viewport1)
  Yuki::Particles.set_on_teleportation(true)
end
Hooks.register(Spriteset_Map, :init_player_end, 'Yuki::Particles') do
  Yuki::Particles.update
  Yuki::Particles.set_on_teleportation(false)
end
Hooks.register(Spriteset_Map, :update, 'Yuki::Particles') {Yuki::Particles.update }
Hooks.register(Spriteset_Map, :init_psdk_add, 'Yuki::FollowMe') {Yuki::FollowMe.init(@viewport1) }
Hooks.register(Spriteset_Map, :init_player_begin, 'Yuki::FollowMe') do
  Yuki::FollowMe.update
  Yuki::FollowMe.reload_position_after_battle unless $user_data[:follower_pos].nil?
  Yuki::FollowMe.particle_push
  $user_data[:follower_pos] = nil
end
Hooks.register(Spriteset_Map, :update_fps_balanced, 'Yuki::FollowMe') {Yuki::FollowMe.update }
# Class that describe and manipulate a Character (Player/Events)
class Game_Character
  include GameData::SystemTags
  # Id of the event in the map
  # @return [Integer]
  attr_reader :id
  # @return [Integer] X position of the event in the current map
  attr_accessor :x
  # @return [Integer] Y position of the event in the current map
  attr_accessor :y
  # @return [Integer] Z priority of the event
  attr_accessor :z
  # @return [Integer] "real" X position of the event, usually x * 128
  attr_reader :real_x
  # @return [Integer] "real" Y position of the event, usually y * 128
  attr_reader :real_y
  # @return [Integer] direction where the event is looking (2 = down, 6 = right, 4 = left, 8 = up)
  attr_accessor :direction
  # @return [Boolean] if the character is forced to move using a specific route
  attr_reader :move_route_forcing
  # @return [Boolean] if the character is traversable and it can walk through any tiles
  attr_accessor :through
  # @return [Integer] ID of the animation to play on the character
  attr_accessor :animation_id
  # @return [Integer] exponant of two added to the real_x/y when the event is moving
  attr_accessor :move_speed
  # @return [Game_Character, nil] the follower
  attr_reader :follower
  # @return [Boolean] if the character is unaffected by sliding tags
  attr_accessor :no_slide
  # @return [Boolean] if the character is sliding
  attr_reader :sliding
  # If the direction is fixed
  # @return [Boolean]
  attr_reader :direction_fix
  # If the character has reflection
  # @return [Boolean]
  attr_reader :reflection_enabled
  # Default initializer
  def initialize
  end
  # Set the move_frequency (and define the max_stop_count value)
  # @param value [Numeric]
  def move_frequency=(value)
  end
  # Adjust the character position
  def straighten
  end
  # Force the character to adopt a move route and save the original one
  # @param move_route [RPG::MoveRoute]
  def force_move_route(move_route)
  end
  # Warps the character on the Map to specific coordinates.
  # Adjust the z position of the character.
  # @param x [Integer] new x position of the character
  # @param y [Integer] new y position of the character
  def moveto(x, y)
  end
  # Change the reflection of a Game_Character
  def reflection_enabled=(bool)
  end
  private
  # Array used to detect if a character is on a bridge tile
  BRIDGE_TILES = [BridgeRL, BridgeUD]
  SLOPES_TILES = [SlopesL, SlopesR]
  # Manage the system_tag part of the moveto method
  def moveto_system_tag_manage(skip_bridges = false)
  end
  public
  # Return the x position of the sprite on the screen
  # @return [Integer]
  def screen_x
  end
  # Return the y position of the sprite on the screen
  # @return [Integer]
  def screen_y
  end
  # Return the x position of the shadow of the character on the screen
  # @return [Integer]
  def shadow_screen_x
  end
  # Return the y position of the shadow of the character on the screen
  # @return [Integer]
  def shadow_screen_y
  end
  # Return the z superiority of the sprite of the character
  # @param _height [Integer] height of a frame of the character (ignored)
  # @return [Integer]
  def screen_z(_height = 0)
  end
  # Define the function check_event_trigger_touch to prevent bugs
  def check_event_trigger_touch(*args)
  end
  # Check if the character is activate. Useful to make difference between event without active page and others.
  # @return [Boolean]
  def activated?
  end
  public
  # SystemTags that trigger Surfing
  SurfTag = [TPond, TSea, RapidsL, RapidsR, RapidsU, RapidsD]
  # SystemTags that does not trigger leaving water
  SurfLTag = SurfTag + [BridgeUD, BridgeRL, RapidsL, RapidsR, RapidsU, RapidsD, AcroBikeRL, AcroBikeUD, WaterFall, JumpD, JumpL, JumpR, JumpU, TUnderWater, Whirlpool]
  # Is the tile in front of the character passable ?
  # @param x [Integer] x position on the Map
  # @param y [Integer] y position on the Map
  # @param d [Integer] direction : 2, 4, 6, 8, 0. 0 = current position
  # @param skip_event [Boolean] if the function does not check events
  # @return [Boolean] if the front/current tile is passable
  def passable?(x, y, d, skip_event = false)
  end
  # Check the bridge related passabilities
  # @param x [Integer] current x position
  # @param y [Integer] current y position
  # @param d [Integer] current direction
  # @param new_x [Integer] new x position
  # @param new_y [Integer] new y position
  # @param z [Integer] current z position
  # @param game_map [Game_Map] map object
  # @param sys_tag [Integer] current system_tag
  # @return [Boolean] if the tile is passable according to the bridge rules
  def passable_bridge_check?(x, y, d, new_x, new_y, z, game_map, sys_tag)
  end
  # Check the surf related passabilities
  # @param sys_tag [Integer] current system_tag
  # @return [Boolean] if the tile is passable according to the surf rules
  def passage_surf_check?(sys_tag)
  end
  # Check the passage related to events
  # @param new_x [Integer] new x position
  # @param new_y [Integer] new y position
  # @param z [Integer] current z position
  # @param game_map [Game_Map] map object
  # @return [Boolean] if the tile has no event that block the way
  def event_passable_check?(new_x, new_y, z, game_map)
  end
  # Check the passage related to events
  # @param new_x [Integer] new x position
  # @param new_y [Integer] new y position
  # @param z [Integer] current z position
  # @return [Boolean] if the tile has no event that block the way
  def follower_check?(new_x, new_y, z)
  end
  public
  # Update the Game_Character (manages movements and some animations)
  def update
  end
  # Reset some attributes when using Fly
  def fly_reset_attributes
  end
  private
  # Update the pattern animation
  def update_pattern
  end
  # Update the pattern state
  def update_pattern_state
  end
  # Update of the jump animation
  def update_jump
  end
  # Update of the move animation
  def update_move
  end
  # Update the real_x/y positions
  def update_real_position
  end
  # Update the slope offset y if there is one
  def update_slope_offset_y
  end
  # Update no movement animation (triggers movement when staying on specific SystemTag)
  def update_stop
  end
  # SystemTags that forces the Game_Character to move
  RapidsTag = [RapidsL, RapidsU, RapidsD, RapidsR]
  # System tag that force the player to move regardless if the system tag in front
  ROCKET_TAGS = [RocketL, RocketU, RocketD, RocketR, RocketRL, RocketRU, RocketRD, RocketRR]
  # List of translations for system tag movement
  SLIDE_TAG_TO_MOVEMENT = {TIce => :move_forward, RapidsL => :move_left, RapidsR => :move_right, RapidsU => :move_up, RapidsD => :move_down, RocketL => :move_left, RocketU => :move_up, RocketD => :move_down, RocketR => :move_right, RocketRL => :move_left, RocketRU => :move_up, RocketRD => :move_down, RocketRR => :move_right, MachBike => :move_down}
  # System tags that rotate the player
  ROTATING_SLIDING_TAGS = [RocketRL, RocketRU, RocketRD, RocketRR]
  # Update when the Game_Character slides
  def update_sliding
  end
  # Function that completely sto
  def stop_slide
  end
  # Function that tells if the character can slide
  # @return [Boolean]
  def can_slide?
  end
  # Random movement (when Event is on "Move random")
  def move_type_random
  end
  # Move toward player with some randomness
  def move_type_toward_player
  end
  # Move on a specified route
  def move_type_custom
  end
  # Execute a move route command
  # @param command [RPG::MoveCommand]
  # @return [Boolean] if the loop calling the method should break
  def move_type_custon_exec_command(command)
  end
  # When the command is 0 we reached the end and we loop back if the repeat mode is on
  def move_type_custom_end
  end
  # When the command is a real move command
  # @param command [RPG::MoveCommand]
  def move_type_custom_move(command)
  end
  # Update the move_route_index if the character moved or can skip undoable route
  def move_type_custom_move_update_index
  end
  # When the move command is a turn command
  # @param command [RPG::MoveCommand]
  def move_type_custom_turn(command)
  end
  # When the move command is a special command
  # @param command [RPG::MoveCommand]
  def move_type_custom_special(command)
  end
  # Function that execute a script
  # @param script [String]
  def eval_script(script)
  end
  public
  # Increase step prototype (sets @stop_count to 0)
  def increase_steps
  end
  # Process the slope y modifier
  def process_slope_y_modifier(y_modifier)
  end
  public
  # Move Game_Character down
  # @param turn_enabled [Boolean] if the Game_Character turns when impossible move
  def move_down(turn_enabled = true)
  end
  # Move Game_Character left
  # @param turn_enabled [Boolean] if the Game_Character turns when impossible move
  def move_left(turn_enabled = true)
  end
  # Try to move the Game_Character on a stair to the left
  # @return [Boolean] if the player cannot perform a regular movement (success or blocked)
  def stair_move_left
  end
  # Update the slope values when moving to left
  def slope_check_left(write = true)
  end
  # Move Game_Character right
  # @param turn_enabled [Boolean] if the Game_Character turns when impossible move
  def move_right(turn_enabled = true)
  end
  # Try to move the Game_Character on a stair to the right
  # @return [Boolean] if the player cannot perform a regular movement (success or blocked)
  def stair_move_right
  end
  # Update the slope values when moving to right, and return y slope modifier
  # @return [Integer]
  def slope_check_right(write = true)
  end
  # Move Game_Character up
  # @param turn_enabled [Boolean] if the Game_Character turns when impossible move
  def move_up(turn_enabled = true)
  end
  # Move the Game_Character lower left
  def move_lower_left
  end
  # Move the Game_Character lower right
  def move_lower_right
  end
  # Move the Game_Character upper left
  def move_upper_left
  end
  # Move the Game_Character upper right
  def move_upper_right
  end
  # Move the Game_Character to a random direction
  def move_random
  end
  # Move the Game_Character to a random direction within a rectangular zone
  # @param lx [Integer] the x coordinate of the left border of the zone
  # @param rx [Integer] the x coordinate of the right border of the zone
  # @param ty [Integer] the y coordinate of the top border of the zone
  # @param dy [Integer] the y coordinate of the down border of the zone
  def move_random_within_zone(lx, rx, ty, dy)
  end
  # Move the Game_Character to a random direction within a rectangular zone
  # @param sys_tag_id [Integer] the ID of the systemtag the character should only move into
  def move_random_within_systemtag(sys_tag_id)
  end
  # Move the Game_Character toward the player
  def move_toward_player
  end
  # Move the Game_Character away from the player
  def move_away_from_player
  end
  # Move the entity toward a specific coordinate
  def move_toward(tx, ty)
  end
  # Move the Game_Character forward
  def move_forward
  end
  # Move the Game_Character backward
  def move_backward
  end
  # Make the Game_Character jump
  # @param x_plus [Integer] the number of tile the Game_Character will jump on x
  # @param y_plus [Integer] the number of tile the Game_Character will jump on y
  # @param follow_move [Boolean] if the follower moves when the Game_Character starts jumping
  # @return [Boolean] if the character is jumping
  def jump(x_plus, y_plus, follow_move = true)
  end
  # Perform the bridge check for the jump operation
  # @param x_plus [Integer] the number of tile the Game_Character will jump on x
  # @param y_plus [Integer] the number of tile the Game_Character will jump on y
  def jump_bridge_check(x_plus, y_plus)
  end
  # SystemTags that triggers "sliding" state
  SlideTags = [TIce, RapidsL, RapidsR, RapidsU, RapidsD, RocketL, RocketU, RocketD, RocketR, RocketRL, RocketRU, RocketRD, RocketRR]
  # End of the movement process
  # @param no_follower_move [Boolean] if the follower should not move
  # @author Nuri Yuri
  def movement_process_end(no_follower_move = false)
  end
  public
  # Turn down unless direction fix
  def turn_down
  end
  # Turn left unless direction fix
  def turn_left
  end
  # Turn right unless direction fix
  def turn_right
  end
  # Turn up unless direction fix
  def turn_up
  end
  # Turn 90° to the right of the Game_Character
  def turn_right_90
  end
  # Turn 90° to the left of the Game_Character
  def turn_left_90
  end
  # Turn 180°
  def turn_180
  end
  # Turn random right or left 90°
  def turn_right_or_left_90
  end
  # Turn in a random direction
  def turn_random
  end
  # Turn toward the player
  def turn_toward_player
  end
  # Turn toward another character
  # @param character [Game_Character]
  def turn_toward_character(character)
  end
  # Turn away from the player
  def turn_away_from_player
  end
  public
  # @return [Integer] ID of the tile shown as the event (0 = no tile)
  attr_reader :tile_id
  # @return [String] name of the character graphic used to display the event
  attr_accessor :character_name
  # @return [Intger] must be 0
  attr_accessor :character_hue
  # @return [Integer] opacity of the event when it's shown
  attr_accessor :opacity
  # @return [Integer] blending of the event (0 is the only one that actually works)
  attr_reader :blend_type
  # @return [Integer] current pattern of the character graphic shown
  attr_reader :pattern
  # @return [Boolean] if the event is invisible
  attr_accessor :transparent
  # @return [Boolean] if the event has a patern animation while staying
  attr_accessor :step_anime
  # @return [Boolean] if the shadow should be shown or not
  attr_accessor :shadow_disabled
  # @return [Hash, nil] hash if a charset animation is setup, else nil
  attr_accessor :charset_animation
  # @return [Integer, nil] offset y of the character on the screen
  attr_accessor :offset_screen_y
  # @return [Integer, nil] offset y of the character on the screen
  attr_accessor :offset_shadow_screen_y
  # @return [Integer, nil] offset x of the character on the screen
  attr_accessor :offset_screen_x
  # @return [Integer, nil] offset x of the character on the screen
  attr_accessor :offset_shadow_screen_x
  # Values that allows the shadow_disabled update in set_appearance
  SHADOW_DISABLED_UPDATE_VALUES = [false, true, nil]
  # Define the new appearance of the character
  # @param character_name [String] name of the character graphic to display
  # @param character_hue [Integer] must be 0
  def set_appearance(character_name, character_hue = 0)
  end
  # bush_depth of the sprite of the character
  # @return [Integer]
  def bush_depth
  end
  # Set the charset animation. It can be needed to set the event in direction fixed.
  # @param lines [Array<Integer>] list of the lines to animates (0,1,2,3)
  # @param duration [Integer] duration of the animation in frame (30 frames per secondes)
  # @param reverse [Boolean] <default: false> set it to true if the animation is reversed
  # @param repeat [Boolean, Integer] true if looping continuously, Integer for the number of loops, false for no loops
  # @param last_frame_delay [Boolean] if the delay should also be applied to the last frame of the animation
  # @param reset_at_end [Boolean] if the character's appearance should be set back to the first frame at the end of the anim
  # @return [Boolean]
  def animate_from_charset(lines, duration, reverse: false, repeat: false, last_frame_delay: false, reset_at_end: false)
  end
  # Cancel the charset animation
  def cancel_charset_animation
  end
  # Tell the Game_Character to wait for its charset animation to finish
  def wait_charset_animation
  end
  private
  SHADOW_DISABLED_KEEP_VALUES = {NilClass => nil, nil => NilClass, FalseClass => false, false => FalseClass, TrueClass => true, true => TrueClass}
  # Change the shadow state in order to keep the old value
  # @param value [Boolean] new value
  def change_shadow_disabled_state(value)
  end
  # Update the charset animation and return true if there is a charset animation
  # @return [Boolean]
  def update_charset_animation
  end
  # Tell if the @charset_animation should loop
  # @return [Boolean]
  def should_charset_anim_loop?
  end
  # Tells if a delay should be applied on the last frame of the charset_animation
  # @return [Boolean]
  def last_frame_delay?
  end
  # Update the appearance with the given index in the charset_animation
  # @param index [Integer] the index of the frame we want to update to
  def update_charset_anim_appearance(index)
  end
  public
  # @return [Integer, false] if the character is in swamp tile and the power of the swamp tile
  attr_accessor :in_swamp
  # @return [Boolean] if the character is a Pokemon (affect the step anime)
  attr_accessor :is_pokemon
  # @return [Boolean] tell if the character can make footprint on the ground or not
  attr_accessor :can_make_footprint
  # is the character moving ?
  # @return [Boolean]
  def moving?
  end
  # is the character jumping ?
  # @return [Boolean]
  def jumping?
  end
  # Is the character able to execute a move action
  def movable?
  end
  # Set the Game_Character in the "surfing" mode (not able to walk on ground but able to walk on water)
  # @author Nuri Yuri
  def set_surfing
  end
  # Check if the Game_Character is in the "surfing" mode
  # @return [Boolean]
  # @author Nuri Yuri
  def surfing?
  end
  # Check if the Game_Character slides
  # @return [Boolean]
  # @author Nuri Yuri
  def sliding?
  end
  # Make the character look the player during a dialog
  def lock
  end
  # Is the character locked ? (looking to the player when it's activated)
  # @note in this state, the character is not able to perform automatic moveroute (rmxp conf)
  # @return [Boolean]
  def lock?
  end
  # Release the character, can perform its natural movements
  def unlock
  end
  # current terrain tag on which the character steps
  # @return [Integer, nil]
  def terrain_tag
  end
  # Return the SystemTag where the Game_Character stands
  # @return [Integer] ID of the SystemTag
  # @author Nuri Yuri
  def system_tag
  end
  # Return the db_symbol of the system tag
  # @return [Symbol]
  def system_tag_db_symbol
  end
  # Count the number of impassable tiles around the fishing spot
  # @return [Integer] The number of impassable tiles
  def fishing_creek_amount
  end
  public
  # Remove the memorized moves of the follower
  # @author Nuri Yuri
  def reset_follower_move
  end
  # Move a follower
  # @author Nuri Yuri
  def follower_move
  end
  # Warp the follower to the event it follows
  # @author Nuri Yuri
  def move_follower_to_character
  end
  # Check if the follower slides
  # @return [Boolean]
  # @author Nuri Yuri
  def follower_sliding?
  end
  # Define the follower of the event
  # @param follower [Game_Character, Game_Event] the follower
  # @author Nuri Yuri
  def set_follower(follower)
  end
  # Return the tail of the following queue
  # @return [Game_Character, self]
  def follower_tail
  end
  # Rerturn the first follower that is a Game_Event in the queue
  # @return [Game_Event, nil]
  def next_event_follower
  end
  # Reset the follower stack of the current entity
  def reset_follower
  end
  public
  # Return tile position in front of the player
  # @return [Array(Integer, Integer)] the position x and y
  def front_tile
  end
  # Return the event that stand in the front of the Player
  # @return [Game_Event, nil]
  def front_tile_event
  end
  # Iterate through each front tiles including current tile
  # @param nb_steps [Integer] number of step in front of the event to iterate
  # @yieldparam x [Integer] x coordinate
  # @yieldparam y [Integer] y coordinate
  # @yieldparam d [Integer] direction
  def each_front_tiles(nb_steps)
  end
  # Iterate through each front tiles including current tile
  # @param nb_steps [Integer] number of step in front of the event to iterate
  # @param dist [Integer] distance in both side of the detection
  # @yieldparam x [Integer] x coordinate
  # @yieldparam y [Integer] y coordinate
  # @yieldparam d [Integer] direction
  def each_front_tiles_rect(nb_steps, dist)
  end
  # Check a the #front_event has a specific name
  # @return [Boolean]
  # @author Nuri Yuri
  def front_name_check(name)
  end
  alias front_name_detect front_name_check
  # Return the id of the #front_tile_event
  # @return [Integer, 0] 0 if no front_tile_event
  # @author Nuri Yuri
  def front_tile_id
  end
  # Return the SystemTag in the front of the Game_Character
  # @return [Integer] ID of the SystemTag
  # @author Nuri Yuri
  def front_system_tag
  end
  # Terrain tag in front of the character
  # @return [Integer, nil]
  def front_terrain_tag
  end
  # Return the db_symbol of the front system tag
  # @return [Symbol]
  def front_system_tag_db_symbol
  end
  # Look directly to a specific event
  # @param event_id [Integer] id of the event on the Map
  # @author Nuri Yuri
  def look_to(event_id)
  end
  # Look directly to the current event
  def look_this_event
  end
  # Array of SystemTag that define stairs
  StairsTag = [StairsL, StairsD, StairsU, StairsR]
  # Dynamic move_speed value of the Game_Character, return a different value than @move_speed
  # @return [Integer] the dynamic move_speed
  # @author Nuri Yuri
  def move_speed
  end
  # Return the original move speed of the character
  # @return [Integer]
  def original_move_speed
  end
  # Check if it's possible to have contact interaction with this Game_Character at certain coordinates
  # @param x [Integer] x position
  # @param y [Integer] y position
  # @param z [Integer] z position
  # @return [Boolean]
  # @author Nuri Yuri
  def contact?(x, y, z)
  end
  # Detect if the event walks in a swamp or a deep swamp and change the Game_Character states.
  # @author Nuri Yuri
  def detect_swamp
  end
  public
  # Adjust the Character informations related to the brige when it moves down (or up)
  # @param z [Integer] the z position
  # @author Nuri Yuri
  def bridge_down_check(z)
  end
  alias bridge_up_check bridge_down_check
  # Adjust the Character informations related to the brige when it moves left (or right)
  # @param z [Integer] the z position
  # @author Nuri Yuri
  def bridge_left_check(z)
  end
  alias bridge_right_check bridge_left_check
  # Check bridge information and adjust the z position of the Game_Character
  # @param sys_tag [Integer] the SystemTag
  # @author Nuri Yuri
  def z_bridge_check(sys_tag)
  end
  public
  # @return [Boolean] if the particles are disabled for the Character
  attr_accessor :particles_disabled
  # Show an emotion to an event or the player
  # @param type [Symbol] the type of emotion (see wiki)
  # @param wait [Integer] the number of frame the event will wait after this command.
  # @param params [Hash] particle params
  def emotion(type, wait = 34, params = {})
  end
  # Constant defining all the particle method to call
  PARTICLES_METHODS = {TGrass => :particle_push_grass, TTallGrass => :particle_push_tall_grass, TSand => :particle_push_sand, TSnow => :particle_push_snow, TPond => :particle_push_pond, TWetSand => :particle_push_wetsand, Puddle => :particle_push_puddle}
  # Push a particle to the particle stack if possible
  # @author Nuri Yuri
  def particle_push
  end
  # Push a grass particle
  def particle_push_grass
  end
  # Push a tall grass particle
  def particle_push_tall_grass
  end
  # Constant telling the sand particle name to push (according to the direction)
  SAND_PARTICLE_NAME = {2 => :sand_d, 4 => :sand_l, 6 => :sand_r, 8 => :sand_u}
  # Push a sand particle
  def particle_push_sand
  end
  # Push a wet sand particle
  def particle_push_wetsand
  end
  # Constant telling the snow particle name to push (according to the direction)
  SNOW_PARTICLE_NAME = {2 => :snow_d, 4 => :snow_l, 6 => :snow_r, 8 => :snow_u}
  # Push a snow particle
  def particle_push_snow
  end
  # Push a pond particle
  def particle_push_pond
  end
  # Push a pond particle
  def particle_push_puddle
  end
  public
  # The current move route
  attr_reader :move_route
  # The current move route index
  attr_reader :move_route_index
  # The bridge state
  attr_accessor :__bridge
  # The current sliding state
  attr_accessor :sliding
  # The current surfing state
  attr_writer :surfing
  # The current path
  # @return [Array<RPG::MoveCommand>, :pending, nil]
  attr_accessor :path
  # Move route that is empty and serve as a template for all the generate move route (by Path Finding)
  EMPTY_MOVE_ROUTE = RPG::MoveRoute.new
  EMPTY_MOVE_ROUTE.repeat = false
  # Request a path to the target and follow it as soon as it found
  # @param to [Array<Integer, Integer>, Game_Character] the target, [x, y] or Game_Character object
  # @param radius [Integer] <default : 0> the distance from the target to consider it as reached
  # @param tries [Integer, Symbol] <default : 5> the number of tries allowed to this request, use :infinity to unlimited try count
  # @param type [Symbol]
  # @example find path to x=10 y=15 with an error radius of 5 tiles
  #   find_path(to:[10,15], radius:5)
  def find_path(to:, radius: 0, tries: Pathfinding::TRY_COUNT, type: nil)
  end
  # Stop following the path if there is one and clear the agent
  def stop_path
  end
  # Movement induced by the Path Finding
  def move_type_path
  end
  # Define the path from path_finding
  # @param path [Array<RPG::MoveCommand>]
  def define_path(path)
  end
  private
  # Clear the path
  def clear_path
  end
end
# Describe an Event during the Map display process
class Game_Event < Game_Character
  # Tag inside an event that put it in the surfing state
  SURFING_TAG = 'surf_'
  # If named like this, this event is an invisible object
  INVISIBLE_EVENT_NAME = 'OBJ_INVISIBLE'
  # Tag that sets the event in an invisible state (not triggerd unless in front of it)
  INVISIBLE_EVENT_TAG = 'invisible_'
  # Tag that tells the event to always take the character_name of the first page when page change
  AUTO_CHARSET_TAG = '$'
  # Tag that tells the event not to push particles when it moves
  PARTICLE_OFF_TAG = '[particle=off]'
  # Tag that detect offset_screen_y
  OFFSET_Y_TAG = /\[offset_y=([0-9\-]+)\]/
  # Tag that detect offset_screen_x
  OFFSET_X_TAG = /\[offset_x=([0-9\-]+)\]/
  # Tag that forbid the creation of a Sprite_Character for this event
  NO_SPRITE_TAG = '[sprite=off]'
  # Tag that give the event an symbol alias
  SYMBOL_ALIAS_TAG = /\[alias=([a-z\-0-9\-_]+)\]/
  # Tag that detect z=
  SET_Z_TAG = /\[z=([0-9\-]+)\]/
  # Tag enabling no slide
  NOSLIDE_TAG = '[noslide=on]'
  # Tag enabling reflection
  REFLECTION_TAG = '[reflection=on]'
  # @return [Integer, nil] Type of trigger for the event (0: Action key, 1: Player contact, 2: Event contact, 3: Autorun, 4: Parallel process)
  attr_reader :trigger
  # @return [Array<RPG::EventCommand>] list of commands that should be executed
  attr_reader :list
  # @return [Boolean] if the event wants to start
  attr_reader :starting
  # @return [RPG::Event] the event data from the MAP
  attr_reader :event
  # @return [Boolean] if the event is an invisible event (should be in front of the event to trigger it when it doesn't have a character_name)
  attr_reader :invisible_event
  # @return [Boolean] if the event was erased (needs to be removed from the view)
  attr_reader :erased
  # @return [Integer] Original id of the event
  attr_reader :original_id
  # @return [Integer] Original map id of the event
  attr_reader :original_map
  # @return [Symbol, nil] The symbol alias of the event
  attr_reader :sym_alias
  # Initialize the Game_Event with its map_id and its RPG::Event data
  # @param map_id [Integer] id of the map where the event is instanciated
  # @param event [RPG::Event] data of the event
  def initialize(map_id, event)
  end
  # Parse the event name in order to setup the event particularity
  def initialize_parse_name
  end
  # Tell if the event can execute in parallel process or automatic process
  # @return [Boolean]
  def can_parallel_execute?
  end
  # Tell if the event can have a sprite or not
  def can_be_shown?
  end
  # Sets @starting to false allowing the event to move with its default move route
  def clear_starting
  end
  # Tells if the Event cannot start
  # @return [Boolean]
  def over_trigger?
  end
  # Starts the event if possible
  def start
  end
  # Remove the event from the map
  def erase
  end
  # Refresh the event : check if an other page is valid and if so, refresh the graphics and command list
  def refresh
  end
  # Check if the event touch the player and start it if so
  # @param x [Integer] the x position to check
  # @param y [Integer] the y position to check
  def check_event_trigger_touch(x, y)
  end
  # Check if the event starts automaticaly and start if so
  def check_event_trigger_auto
  end
  # Update the Game_Character and its internal Interpreter
  def update
  end
  # Use path finding to locate the current event move else
  # @param to [Array<Integer, Integer>, Game_Character] the target, [x, y] or Game_Character object
  # @param radius [Integer] <default : 0> the distance from the target to consider it as reached
  # @param tries [Integer, Symbol] <default : 5> the number of tries allowed to this request, use :infinity to unlimited try count
  # @param type [Symbol]
  # @example find path to x=10 y=15 with an error radius of 5 tiles
  #   find_path(to:[10,15], radius:5)
  def find_path(to:, radius: 0, tries: Pathfinding::TRY_COUNT, type: nil)
  end
  # Check if the character is activate. Useful to make difference between event without active page and others.
  # @return [Boolean]
  def activated?
  end
  private
  # Refresh all the information of the event according to the new page
  # @param new_page [RPG::Event::Page]
  # @return [Boolean] if the refresh function can continue
  def refresh_page(new_page)
  end
end
# Management of the player displacement on the Map
class Game_Player < Game_Character
  # 4 time the x position of the Game_Player sprite
  CENTER_X = Configs.display.tilemap_settings.center.x
  # 4 time the y position of the Game_Player sprite
  CENTER_Y = Configs.display.tilemap_settings.center.y
  # Name of the bump sound when the player hit a wall
  BUMP_FILE = 'audio/se/bump'
  # true if the player is on the back wheel of its Acro bike
  # @return [Boolean]
  attr_accessor :acro_appearence
  # Default initializer
  def initialize
  end
  # Adjust the map display according to the given position
  # @param x [Integer] the x position on the MAP
  # @param y [Integer] the y position on the MAP
  def center(x, y)
  end
  # Warp the player to a specific position. The map display will be centered
  # @param x [Integer] the x position on the MAP
  # @param y [Integer] the y position on the MAP
  def moveto(x, y)
  end
  # Manage the system_tag part of the moveto method
  def moveto_system_tag_manage
  end
  # Offset Screen Y of the surf sprite when surfing
  SURF_OFFSET_Y = [2, 2, 0, 0, 0, -2, -2, 0, 0, 0]
  # Overwrite the screen_y to add the surfing animation
  # @return [Integer]
  def screen_y
  end
  # Increases a step and displays related things
  def increase_steps
  end
  # Refresh the player graphics
  def refresh
  end
  # Update the player movements according to inputs
  def update
  end
  # Process the slope y modifier with scrolling handling
  def process_slope_y_modifier(y_modifier)
  end
  private
  # Redefine of the update_move with the auto warp from the Yuki::MapLinker
  def update_move
  end
  # Redefine the update_stop to support some specific cycling state
  def update_stop
  end
  # Name of the JUMP SE
  JUMP_SE = 'audio/se/jump'
  # Redefine the update_jump to support the cracked floor
  def update_jump
  end
  # Scroll the map during the update phase
  # @param last_real_x [Integer] the last real_x value of the player
  # @param last_real_y [Integer] the last real_y value of the player
  def update_scroll_map(last_real_x, last_real_y)
  end
  # Check the triggers during the update
  # @param last_moving [Boolean] if the player was moving before
  def update_check_trigger(last_moving)
  end
  # Start common event diving if the player stand on diving system tag and is surfing
  def check_diving_trigger_here
  end
  public
  # is the tile in front of the player passable ? / Plays a BUMP SE in some conditions
  # @param x [Integer] x position on the Map
  # @param y [Integer] y position on the Map
  # @param d [Integer] direction : 2, 4, 6, 8, 0. 0 = current position
  # @return [Boolean] if the front/current tile is passable
  def passable?(x, y, d)
  end
  # Tags that are Bike bridge (jumpable on Acro Bike)
  AccroTag = [AcroBikeRL, AcroBikeUD]
  # Tags where the Bike cannot pass
  NO_BIKE_TILE = [SwampBorder, DeepSwamp, TTallGrass]
  # Test if the player can pass Bike bridge
  # @author Nuri Yuri
  def acro_passable_check(d, result)
  end
  # Check the surf related passabilities
  # @param sys_tag [Integer] current system_tag
  # @return [Boolean] if the tile is passable according to the surf rules
  def passage_surf_check?(sys_tag)
  end
  # Check the passage related to events
  # @param new_x [Integer] new x position
  # @param new_y [Integer] new y position
  # @param z [Integer] current z position
  # @param game_map [Game_Map] map object
  # @return [Boolean] if the tile has no event that block the way
  def event_passable_check?(new_x, new_y, z, game_map)
  end
  private
  # is the tile in front of the player passable for maplinker uses
  # @param new_x [Integer] new x position on the Map
  # @param new_y [Integer] new y position on the Map
  # @return [Boolean] if the front/current tile is passable
  def maplinker_passable?(new_x, new_y)
  end
  public
  # Check if there's an event trigger on the tile where the player stands
  # @param triggers [Array<Integer>] the list of triggers to check
  # @return [Boolean]
  def check_event_trigger_here(triggers)
  end
  # Check if there's an event trigger in front of the player (when he presses A)
  # @param triggers [Array<Integer>] the list of triggers to check
  # @return [Boolean]
  def check_event_trigger_there(triggers)
  end
  # Tile tha allow to use DIVE
  DIVE_TILE = [TSea, TUnderWater]
  # Check the common event call
  # @param new_x [Integer] the x position to check
  # @param new_y [Integer] the y position to check
  # @param z [Integer] the z of the event
  # @param d [Integer] the direction where to check
  def check_common_event_trigger_there(new_x, new_y, z, d)
  end
  # Check the follower common event call
  # @param new_x [Integer] the x position to check
  # @param new_y [Integer] the y position to check
  # @return [Boolean] if the trigger happened
  def check_follower_trigger_there(new_x, new_y)
  end
  # Check if the player touch an event and start it if so
  # @param x [Integer] the x position to check
  # @param y [Integer] the y position to check
  def check_event_trigger_touch(x, y)
  end
  public
  # List of system tags that makes the player Jump
  JumpTags = [JumpL, JumpR, JumpU, JumpD]
  # Move or turn the player according to its input. The common event 2 can be triggered there
  # @author Nuri Yuri
  def player_update_move
  end
  # Turn the player on himself. Does some calibration for the Acro Bike.
  # @author Nuri Yuri
  def player_turn(swamp_detect)
  end
  # Move the player. Does some calibration for the Acro Bike.
  # @author Nuri Yuri
  def player_move
  end
  # Reset the direction of the player when he's on bike bridge
  # @param last_dir [Integer] the last direction
  # @author Nuri Yuri
  def calibrate_acro_direction(last_dir)
  end
  # Update the Acro Bike jump info
  # @param count [Integer] number of @acro_count frame before the player is allowed to jump
  # @param sys_tag [Integer] the current system tag
  # @return [Boolean, nil] if the player can jump (nil = not allowed to jump but can move forward)
  # @author Nuri Yuri
  def update_acro_bike(count, sys_tag)
  end
  # Update the Acro Bike jump info when not moving
  # @param count [Integer] number of @acro_count frame before the player is allowed to jump
  # @param sys_tag [Integer] the current system tag
  # @return [Boolean, nil] if the player can jump (nil = not allowed to jump but can move forward)
  # @author Leikt
  def update_acro_bike_turn(sys_tag)
  end
  # Manage the bump part of the player_update_move
  # @param bool [Boolean] tell if the player did a fast direction change
  def player_update_move_bump(bool)
  end
  # Restore step anime if it was changed
  def player_update_move_bump_restore_step_anime
  end
  # Manage the common event calling of player_update_move
  # @param bool [Boolean]
  def player_update_move_common_events(bool)
  end
  # Manage the running update of player_update_move inside player_update_move_common_events
  # @param bool [Boolean]
  def player_update_move_running_state(bool)
  end
  # Update the cracked floor when the player move on it
  def player_move_on_cracked_floor_update
  end
  public
  # @return [String, nil] return the charset_base used to calculate the graphic
  attr_reader :charset_base
  # Launch the player update appearance
  # @param forced_pattern [Integer] pattern after update (default : 0)
  # @author Leikt
  def update_appearance(forced_pattern = 0)
  end
  # Get the character suffix from the hash
  # @return [String] the suffix
  # @author Leikt
  def chara_by_state
  end
  # Change the appearance set for the player. The argument is the base of the charset name.
  # For exemple : for the file "HeroRed001_M_walk", the charset base will be "HeroRed001"
  # @param charset_base [String, nil] the base of the charsets filenames (nil = don't use the charset_base)
  # @author Leikt
  def set_appearance_set(charset_base)
  end
  public
  # Push the sand particle only if the player is not cycling
  def particle_push_sand
  end
  public
  # Return the tail of the following queue (Game_Event exclusive)
  # @return [Game_Character, self]
  def follower_tail
  end
  # Define the follower of the player, if the player already has event following him, it'll put them at the tail of the following events
  # @param follower [Game_Character, Game_Event] the follower
  # @param force [Boolean] param comming from Yuki::FollowMe to actually force the follower
  # @author Nuri Yuri
  def set_follower(follower, force = false)
  end
  # Reset the follower stack to prevent any issue
  def reset_follower
  end
  # Set the player z and all its follower z at the same tile
  # @param value [Integer] new z value
  def change_z_with_follower(value)
  end
  public
  # Indicate if the player is on acro bike
  # @return [Boolean]
  attr_reader :on_acro_bike
  # Define Acro Bike state of the Game_Player
  # @author Nuri Yuri
  def on_acro_bike=(state)
  end
  # Search an invisible item
  def search_item
  end
  # Detect the swamp state
  def detect_swamp
  end
  # Detect if we are leaving the swamp, then update the state
  # @param last_in_swamp [Integer, false] the last swamp info
  def detect_swamp_leaving(last_in_swamp)
  end
  # Detect if we are entering in the swamp, then update the state
  # @param last_in_swamp [Integer, false] the last swamp info
  def detect_swamp_entering(last_in_swamp)
  end
  # Detect if we should trigger the deep_swamp sinking when we detect swamp info
  # @param last_in_swamp [Integer, false] the last swamp info
  def detect_deep_swamp_sinking(last_in_swamp)
  end
  public
  # Same as Game_Character but with Acro bike
  # @author Nuri Yuri
  def bridge_down_check(z)
  end
  alias bridge_up_check bridge_down_check
  # Same as Game_Character but with Acro bike
  # @author Nuri Yuri
  def bridge_left_check(z)
  end
  alias bridge_right_check bridge_left_check
  public
  # @return [Hash] List of appearence suffix according to the state
  STATE_APPEARANCE_SUFFIX = {cycling: '_cycle_roll', cycle_stop: '_cycle_stop', roll_to_wheel: '_cycle_roll_to_wheel', wheeling: '_cycle_wheel', fishing: '_fish', surf_fishing: '_surf_fish', saving: '_pokecenter', using_skill: '_pokecenter', giving_pokemon: '_pokecenter', taking_pokemon: '_pokecenter', running: '_run', walking: '_walk', surfing: '_surf', swamp: '_swamp', swamp_running: '_swamp_run', sinking: '_deep_swamp_sinking', watering_berries: '_misc2'}
  # @return [Hash] List of movement speed, movement frequency according to the state
  STATE_MOVEMENT_INFO = {walking: [3, 4], running: [4, 4], wheeling: [4, 4], cycling: [5, 4], surfing: [4, 4]}
  # @return [Symbol, nil] the update_callback
  attr_reader :update_callback
  # Update the move_speed & move_frequency parameters
  # @param state [Symbol] the name of the state to fetch the move parameter
  def update_move_parameter(state)
  end
  # Enter in walking state (supports the swamp state)
  # @return [:walking] (It's used inside set_appearance_set when no state is defined)
  def enter_in_walking_state
  end
  # Enter in running state (supports the swamp state)
  def enter_in_running_state
  end
  # Enter in surfing state
  def enter_in_surfing_state
  end
  # Leave the surfing state
  def leave_surfing_state
  end
  # Enter in the wheel state
  def enter_in_wheel_state
  end
  # Callback called when we are entering in wheel state
  def update_enter_wheel_state
  end
  # Leave the wheel state
  def leave_wheel_state
  end
  # Callback called when we are leaving in wheel state
  def update_leave_wheel_state
  end
  # Jump on the mach bike
  def enter_in_cycling_state
  end
  # Jump on the acro bike
  def enter_in_acro_bike_state
  end
  # Leave the cycling state
  def leave_cycling_state
  end
  alias leave_acro_bike_state leave_cycling_state
  # Update the cycling state
  def update_cycling_state
  end
  # Test if the player is cycling
  # @return [Boolean]
  def cycling?
  end
  # Enter in fishing state
  def enter_in_fishing_state
  end
  # Callback called when we are entering in wheel state
  def update_enter_fishing_state
  end
  # Leave fishing state
  def leave_fishing_state
  end
  # Callback called when we are leaving in wheel state
  def update_leave_fishing_state
  end
  # Enter in sinking state
  def enter_in_sinking_state
  end
  # Callback called when we are entering in wheel state
  def update_enter_sinking_state
  end
  # Leave sinking state
  def leave_sinking_state
  end
  # Callback called when we are leaving in wheel state
  def update_leave_sinking_state
  end
  # Enter in saving state
  def enter_in_saving_state
  end
  # Enter in using_skill state
  def enter_in_using_skill_state
  end
  # Enter in giving_pokemon state
  def enter_in_giving_pokemon_state
  end
  # Update the Pokemon giving animation
  def update_giving_pokemon_state
  end
  # Enter in taking_pokemon state
  def enter_in_taking_pokemon_state
  end
  # Update the Pokemon taking animation
  def update_taking_pokemon_state
  end
  # Enter in watering berries state
  # @note Do not call this function while surfing
  def enter_in_watering_berries_state
  end
  # Leave the watering berries state
  def leave_watering_berries_state
  end
  # Callback called when we only want the character to show it's 4 pattern (it'll lock the player, use return_to_previous_state to unlock)
  # @param factor [Integer] the number added to pattern
  def update_4_step_animation(factor = 1)
  end
  # Callback called when we only want the character to show it's 4 pattern and return to previous state
  # @param factor [Integer] the number added to pattern
  def update_4_step_animation_to_previous(factor = 1)
  end
  # Return to the correct state
  def return_to_previous_state
  end
  # Update the locked state
  def update_locked_state()
  end
  public
  # @return [Hash{map_id=>Array<map_id, offset_x, offset_y>}] list of falling hole info
  FALLING_HOLES = {7 => [7, 0, 35]}
  # Function that makes the player warp based on hole data for each map
  def falling_hole_warp
  end
end
# Describe the Map processing
class Game_Map
  # Audiofile to play when the player is on mach bike
  # @return [RPG::AudioFile]
  MACH_BIKE_BGM = RPG::AudioFile.new('09 Bicycle', 100, 100)
  # Audiofile to play when the player is on acro bike
  # @return [RPG::AudioFile]
  ACRO_BIKE_BGM = MACH_BIKE_BGM.clone
  # If the Path Finding system is enabled
  PATH_FINDING_ENABLED = true
  # If the player is always on the center of the screen
  CenterPlayer = Configs.display.is_player_always_centered
  # Number of tiles the player can see in x
  NUM_TILE_VIEW_Y = 15
  # Number of tiles the player can see in y
  NUM_TILE_VIEW_X = 20
  attr_accessor :tileset_name
  # タイルセット ファイル名
  attr_accessor :autotile_names
  # オートタイル ファイル名
  attr_accessor :panorama_name
  # パノラマ ファイル名
  attr_accessor :panorama_hue
  # パノラマ 色相
  attr_accessor :fog_name
  # フォグ ファイル名
  attr_accessor :fog_hue
  # フォグ 色相
  attr_accessor :fog_opacity
  # フォグ 不透明度
  attr_accessor :fog_blend_type
  # フォグ ブレンド方法
  attr_accessor :fog_zoom
  # フォグ 拡大率
  attr_accessor :fog_sx
  # フォグ SX
  attr_accessor :fog_sy
  # フォグ SY
  attr_accessor :battleback_name
  # バトルバック ファイル名
  attr_accessor :display_x
  # 表示 X 座標 * 128
  attr_accessor :display_y
  # 表示 Y 座標 * 128
  attr_accessor :need_refresh
  # リフレッシュ要求フラグ
  attr_reader :passages
  # 通行 テーブル
  attr_reader :priorities
  # プライオリティ テーブル
  attr_reader :terrain_tags
  # 地形タグ テーブル
  # @return [Hash{Integer => Game_Event}] all the living events
  attr_reader :events
  # Return the hash of symbol associate to event id
  # @return [Hash<Symbol, Integer>]
  attr_accessor :events_sym_to_id
  attr_reader :fog_ox
  # フォグ 原点 X 座標
  attr_reader :fog_oy
  # フォグ 原点 Y 座標
  attr_reader :fog_tone
  # フォグ 色調
  # @return [Boolean] if the maplinker was disabled when the map was setup
  attr_reader :maplinker_disabled
  # Initialize the default Game_Map object
  def initialize
  end
  # setup the Game_Map object with the right Map data
  # @param map_id [Integer] the ID of the map
  def setup(map_id)
  end
  # Returns the ID of the Map
  # @return [Integer]
  def map_id
  end
  # Returns the width of the map
  # @return [Integer]
  def width
  end
  # Returns the height of the map
  # @return [Integer]
  def height
  end
  # Returns the encounter list
  # @deprecated Not used by the Core of PSDK because not precise enough to be used
  def encounter_list
  end
  # Returns the encounter steps from RMXP data
  # @return [Integer]
  def rmxp_encounter_steps
  end
  # Returns the tile matrix of the Map
  # @return [Table] a 3D table containing ids of tile
  def data
  end
  # Auto play bgm and bgs of the map if defined
  def autoplay
  end
  # Refresh events and common events of the map
  def refresh
  end
  # Scrolls the map down
  # @param distance [Integer] distance in y to scroll
  # @param is_priority [Boolean] used if there is a prioratary scroll running
  def scroll_down(distance, is_priority = false)
  end
  # Scrolls the map left
  # @param distance [Integer] distance in -x to scroll
  # @param is_priority [Boolean] used if there is a prioratary scroll running
  def scroll_left(distance, is_priority = false)
  end
  # Scrolls the map right
  # @param distance [Integer] distance in x to scroll
  # @param is_priority [Boolean] used if there is a prioratary scroll running
  def scroll_right(distance, is_priority = false)
  end
  # Scrolls the map up
  # @param distance [Integer] distance in -y to scroll
  # @param is_priority [Boolean] used if there is a prioratary scroll running
  def scroll_up(distance, is_priority = false)
  end
  # Tells if the x,y coordinate is valid or not (inside of bounds)
  # @param x [Integer] the x coordinate
  # @param y [Integer] the y coordinate
  # @return [Boolean] if it's valid or not
  def valid?(x, y)
  end
  # Tells if the tile front/current tile is passsable or not
  # @param x [Integer] x position on the Map
  # @param y [Integer] y position on the Map
  # @param d [Integer] direction : 2, 4, 6, 8, 0. 0 = current position
  # @param self_event [Game_Event, nil] the "tile" event to ignore
  # @return [Boolean] if the front/current tile is passable
  def passable?(x, y, d, self_event = nil)
  end
  # Tells if the tile is a bush tile
  # @param x [Integer] x coordinate of the tile
  # @param y [Integer] y coordinate of the tile
  # @return [Boolean]
  def bush?(x, y)
  end
  # カウンター判定 (no idea, need GTranslate)
  # @param x [Integer] x coordinate of the tile
  # @param y [Integer] y coordinate of the tile
  # @return [Boolean]
  def counter?(x, y)
  end
  # Returns the tag of the tile
  # @param x [Integer] x coordinate of the tile
  # @param y [Integer] y coordinate of the tile
  # @return [Integer, nil] Tag of the tile
  def terrain_tag(x, y)
  end
  # Starts a scroll processing
  # @param direction [Integer] the direction to scroll
  # @param distance [Integer] the distance to scroll
  # @param speed [Integer] the speed of the scroll processing
  # @param x_priority [Boolean] true if the scroll is prioritary in x axis, be careful using this
  # @param y_priority [Boolean] true if the scroll is prioritary in y axis, be careful using this
  def start_scroll(direction, distance, speed, x_priority = false, y_priority = false)
  end
  # is the map scrolling ?
  # @return [Boolean]
  def scrolling?
  end
  # Starts a fog tone change process
  # @param tone [Tone] the new tone of the fog
  # @param duration [Integer] the number of frame the tone change will take
  def start_fog_tone_change(tone, duration)
  end
  # Starts a fog opacity change process
  # @param opacity [Integer] the new opacity of the fog
  # @param duration [Integer] the number of frame the opacity change will take
  def start_fog_opacity_change(opacity, duration)
  end
  # Update the Map processing
  def update
  end
  private
  # Return the current Autoplay BGM state
  # @return [Boolean]
  def autoplay_bgm?
  end
  # Return the current Autoplay BGS state
  # @return [Boolean]
  def autoplay_bgs?
  end
  # Return the current BGM to play
  # @return [RPG::AudioFile]
  def current_bgm
  end
  # Return the current BGS to play
  # @return [RPG::AudioFile]
  def current_bgs
  end
  # Get the cycle audio file matching the current bike or nil
  # @return [RPG::AudioFile, nil]
  def cycling_bgm
  end
  public
  # Regular expression catching follower id
  FOLLOWER_ID_REGEXP = /\[follow=([0-9]+)\]/
  # If an event has been erased (helps removing it)
  # @return [Boolean]
  attr_accessor :event_erased
  # The system_tags linked to each tiles of the tileset
  # @return [Table]
  attr_reader :system_tags
  # Retrieve the ID of the SystemTag on a specific tile
  # @param x [Integer] x position of the tile
  # @param y [Integer] y position of the tile
  # @return [Integer]
  # @author Nuri Yuri
  def system_tag(x, y)
  end
  # Check if a specific SystemTag is present on a specific tile
  # @param x [Integer] x position of the tile
  # @param y [Integer] y position of the tile
  # @param tag [Integer] ID of the SystemTag
  # @return [Boolean]
  # @author Nuri Yuri
  def system_tag_here?(x, y, tag)
  end
  # Loads the SystemTags of the map
  # @author Nuri Yuri
  def load_systemtags
  end
  # Retrieve the id of a specific tile
  # @param x [Integer] x position of the tile
  # @param y [Integer] y position of the tile
  # @return [Integer] id of the tile
  # @author Nuri Yuri
  def get_tile(x, y)
  end
  # Check if the player can jump a case with the acro bike
  # @param x [Integer] x position of the tile
  # @param y [Integer] y position of the tile
  # @param d [Integer] the direction of the player
  # @return [Boolean]
  # @author Nuri Yuri
  def jump_passable?(x, y, d)
  end
  # Return the current location type
  # @return [Symbol]
  def location_type(x, y)
  end
  # Convert terrain tag to location symbol
  # @return [Hash<Integer, Symbol>]
  TERRAIN_TAGS_TABLE = {GameData::SystemTags::TGrass => :grass, GameData::SystemTags::TTallGrass => :grass, GameData::SystemTags::HeadButt => :grass, GameData::SystemTags::TSnow => :snow, GameData::SystemTags::TPond => :shallow_water, GameData::SystemTags::TWetSand => :shallow_water, GameData::SystemTags::SwampBorder => :shallow_water, GameData::SystemTags::DeepSwamp => :shallow_water, GameData::SystemTags::TSand => :desert, GameData::SystemTags::TCave => :cave, GameData::SystemTags::TMount => :cave, GameData::SystemTags::TIce => :icy_cave, GameData::SystemTags::TSea => :water, GameData::SystemTags::WaterFall => :water, GameData::SystemTags::RapidsL => :water, GameData::SystemTags::RapidsD => :water, GameData::SystemTags::RapidsU => :water, GameData::SystemTags::RapidsR => :water, GameData::SystemTags::Whirlpool => :water}
  # List of variable to remove in order to keep the map data safe
  IVAR_TO_REMOVE_FROM_SAVE_FILE = %i[@map @tileset_name @autotile_names @panorama_name @panorama_hue @fog_name @fog_hue @fog_opacity @fog_blend_type @fog_zoom @fog_sx @fog_sy @battleback_name @passages @priorities @terrain_tags @events @common_events @system_tags]
  # Method that prevent non wanted data save of the Game_Map object
  # @author Nuri Yuri
  def begin_save
  end
  # Method that end the save state of the Game_Map object
  # @author Nuri Yuri
  def end_save
  end
  private
  # Method that save the Follower Event of the player
  def save_follower
  end
  # Method that load the follower Event of the player when the map is loaded
  def load_follower
  end
  # Method that un-save the followers
  def unsave_followers
  end
  # Method that save the event position, direction & move_route info
  def save_events
  end
  # Method that save the events & fix the event offset added by the MapLinker
  def save_events_offset
  end
  # Method that load the event
  def load_events
  end
  # Function that loads the events that are following
  def load_following_events
  end
end
module Pathfinding
  # Amount of node to calculate in one frame (OPTIMISATION)
  OPERATION_PER_FRAME = 150
  # Amount of node by requests in one frame (OPTIMISATION)
  OPERATION_PER_REQUEST = 50
  # Cost of the reload
  COST_RELOAD = 15
  # Cost of the watch
  COST_WATCH = 9
  # Cost of the wait
  COST_WAIT = 1
  # Obstacle detection range
  OBSTACLE_DETECTION_RANGE = 9
  # Amount of try count
  TRY_COUNT = 5
  # Number of frame before two path search when the first one fail
  TRY_DELAY = 60
  # Directions to check
  PATH_DIRS = [1, 2, 3, 4]
  # Move route when waiting for a new path
  WAITING_ROUTE = RPG::MoveRoute.new
  WAITING_ROUTE.list.unshift(RPG::MoveCommand.new(15, 1))
  # Weight of the tags, the higher is the cost, the more the path will avoid it
  TAGS_WEIGHT = {GameData::SystemTags::Road => 2, GameData::SystemTags::TSand => 4, GameData::SystemTags::SwampBorder => 20, GameData::SystemTags::DeepSwamp => 30, GameData::SystemTags::MachBike => 1000, GameData::SystemTags::TGrass => 20}
  TAGS_WEIGHT.default = 10
  # Grass, ...
  # module that contains the tags weight for path calculation
  module TagsWeight
    include GameData::SystemTags
    # Default tags weight
    DEFAULT = Pathfinding::TAGS_WEIGHT
    # Test tage weight
    WILD_POKEMON = Hash.new(10)
    WILD_POKEMON[TGrass] = 2
    WILD_POKEMON[Road] = 100
    WILD_POKEMON[TSand] = 100
  end
  # Default save state
  DEFAULT_SAVE = []
  @requests = []
  @operation_per_frame = OPERATION_PER_FRAME
  @last_request_id = 0
  # Method giving a preset command (the 5 first move commands)
  PRESET_COMMANDS = Array.new(5) { |i| RPG::MoveCommand.new(i) }.method(:[])
  # Add the request to the system list and start looking for path
  # @param character [Game_Character] the character looking for a path
  # @param target [Game_Character, Array<Integer>] character or coords to reach
  # @param tries [Integer] the number of tries before giving up the path research. :infinity for infinite try count.
  # @param tags [Symbol] the name of the Pathfinding::TagsWeight constant to use to calcultate the node weight
  # @return [Boolean] if the request is successfully submitted
  def self.add_request(character, target, tries, tags)
  end
  # Remove the request from the system list and return true if the request has been popped out.
  # @param character [Game_Character] the character to pop out
  # @return [Boolean] if the request has been popped out
  def self.remove_request(character)
  end
  # CLear all the requests
  def self.clear
  end
  # Set the number of operation per frame. By default it's 150, be careful with the performance issues.
  # @param value [Integer] the new amount of operation allowed per frame
  def self.operation_per_frame=(value)
  end
  # Update the pathfinding system
  def self.update
  end
  # Create an savable array of the current requests
  # @return [Array<Pathfinding::Request>]
  def self.save
  end
  # Load the data from the Game State
  def self.load
  end
  @debug = false
  # Enable or disable the debug mode
  # @param value [Boolean] if debug must be enabled
  def self.debug=(value)
  end
  # Clear the pathfinding debug data
  # @param from [Integer, nil] the id of the caracter to clear, if nil, clear all
  def self.debug_clear(from = nil)
  end
  # Update the pathfinding display debug
  def self.debug_update
  end
  # Add a path to display
  # @param from [Game_Character] the character who follow the path
  # @param cursor [Cursor] the cursor used to calculate the path
  # @param path [Array<Integer>] the list of moveroute command
  def self.debug_add(from, cursor, path)
  end
  #-------------------------------------------
  # Class that describe a pathfinding request
  #   A request has three caracteristics :
  #   - Character : the character summonning the request
  #   - Target : the target to reach
  #   - Priority : The priority of the request between others
  #
  # Algorithm steps
  # 1st step : Initialization
  #   Creation of the variables (#initialize)
  # 2nde step: Search
  #   Calculate NODES_PER_FRAME nodes per frame to optimize the process (#update_search)
  #   Nodes are calculated in #calculate_node with A* algorithm
  #   Once a path is found, or all possibilies are studied, the request start watching
  # 3rd step : Watch
  #   The Request look for obstacles on the path and restart the search (reload) if there is one
  class Request
    # The character which needs a path
    # @return [Game_Character]
    attr_reader :character
    # Indicate if the request needs update or not
    # @return [Boolean]
    attr_reader :need_update
    # Create the request
    # @param character [Game_Character] the character to give a path
    # @param target [Target] the target data
    # @param tries [Integer, Symbol] the amount of tries allowed before fail, use :infinity to have unlimited tries
    # @param tags [Symbol] the name of the Pathfinding::TagsWeight constant to use to calcultate the node weight
    def initialize(character, target, tries, tags)
    end
    # Indicate if the request is search for path
    # @return [Boolean]
    def searching?
    end
    # Indicate if the request is watching for obstacle
    # @return [Boolean]
    def waiting?
    end
    # Inidicate if the request is waiting for new try
    # @return [Boolean]
    def watching?
    end
    # Indicate if the request is to reload
    # @return [Boolean]
    def reload?
    end
    # Indicate if the request is ended
    # @return [Boolean]
    def finished?
    end
    # Update the requests and return the number of performed actions
    # @param operation_counter [Integer] the amount of operation left
    # @param is_first_update [Boolean] indicate if it's the first update of the frame
    # @return [Integer]
    def update(operation_counter, is_first_update)
    end
    # Update the request search and return the new remaining node count
    # @param operation_counter [Integer] the amount of node per frame remaining
    # @return [Integer]
    def update_search(operation_counter)
    end
    # Process the result of the node calculation
    # @param result [Array<Integer>, nil, Symbol] the result value
    def process_result(result)
    end
    # Update the request when looking for obstacles
    def update_watch(is_first_update)
    end
    # Update the request when waiting before retrying to find path
    def update_wait(is_first_update)
    end
    # Reload the request
    def update_reload(is_first_update)
    end
    # Make the character following the found path
    # @param path [Array<Integer>] The path, list of move direction
    def send_path(path)
    end
    # Detect if the character is stucked
    # @return [Boolean]
    def stucked?
    end
    # Calculate a node and return it if a path is found
    # @return [Object]
    def calculate_node
    end
    # Calculate the path from the given node
    # @param tx [Integer] target x?
    # @param ty [Integer] target y?
    # @param tz [Integer] target z?
    # @return [Array<Integer>] the path
    def backtrace(tx, ty, tz)
    end
    # Gather the data ready to be saved
    # @return [Array<Object>]
    def save
    end
    # (Class method) Load the requests from the given argument
    # @param data [Array<Object>] the data generated by the save method
    def self.load(data)
    end
  end
  #-------------------------------------------
  # Class that describe and manipulate the simili character used in pathfinding
  class Cursor
    include GameData::SystemTags
    # SystemTags that trigger Surfing
    SurfTag = Game_Character::SurfTag
    # SystemTags that does not trigger leaving water
    SurfLTag = Game_Character::SurfLTag
    # SystemTags that triggers "sliding" state
    SlideTags = [TIce, RapidsL, RapidsR, RapidsU, RapidsD, RocketL, RocketU, RocketD, RocketR, RocketRL, RocketRU, RocketRD, RocketRR]
    # Array used to detect if a character is on a bridge tile
    BRIDGE_TILES = [BridgeRL, BridgeUD]
    attr_reader :x
    attr_reader :y
    attr_reader :z
    attr_reader :__bridge
    def initialize(character)
    end
    # Get the current state of the cursor
    def state
    end
    # Simulate the mouvement of the character and store the data into cursor's attributes
    # @param sx [Integer] start coords X
    # @param sy [Integer] start coords Y
    # @param sz [Integer] start coords z
    # @param code [Integer] mouvement's code
    # @param b [Array, nil] bridge metadata
    # @param slide [Boolean] slide meta data
    # @param surf [Boolean] surf meta data
    # @return [Boolean]
    def sim_move?(sx, sy, sz, code, b = @__bridge, slide = @sliding, surf = @surfing)
    end
    private
    # Warps the character on the Map to specific coordinates.
    # Adjust the z position of the character.
    # @param x [Integer] new x position of the character
    # @param y [Integer] new y position of the character
    def moveto(x, y)
    end
    # Move Game_Character down
    def move_down
    end
    # Move Game_Character left
    def move_left
    end
    # Try to move the Game_Character on a stair to the left
    # @return [Boolean] if the player cannot perform a regular movement (success or blocked)
    def stair_move_left
    end
    # Update the slope values when moving to left
    def slope_check_left
    end
    # Move Game_Character right
    def move_right
    end
    # Try to move the Game_Character on a stair to the right
    # @return [Boolean] if the player cannot perform a regular movement (success or blocked)
    def stair_move_right
    end
    # Update the slope values when moving to right, and return y slope modifier
    # @return [Integer]
    def slope_check_right
    end
    # Move Game_Character up
    def move_up
    end
    # Move the Game_Character lower left
    def move_lower_left
    end
    # Move the Game_Character lower right
    def move_lower_right
    end
    # Move the Game_Character upper left
    def move_upper_left
    end
    # Move the Game_Character upper right
    def move_upper_right
    end
    # Is the tile in front of the character passable ?
    # @param x [Integer] x position on the Map
    # @param y [Integer] y position on the Map
    # @param d [Integer] direction : 2, 4, 6, 8, 0. 0 = current position
    # @return [Boolean] if the front/current tile is passable
    def passable?(x, y, d)
    end
    # Check the bridge related passabilities
    # @param x [Integer] current x position
    # @param y [Integer] current y position
    # @param d [Integer] current direction
    # @param new_x [Integer] new x position
    # @param new_y [Integer] new y position
    # @param z [Integer] current z position
    # @param game_map [Game_Map] map object
    # @param sys_tag [Integer] current system_tag
    # @return [Boolean] if the tile is passable according to the bridge rules
    def passable_bridge_check?(x, y, d, new_x, new_y, z, game_map, sys_tag)
    end
    # Check the surf related passabilities
    # @param sys_tag [Integer] current system_tag
    # @return [Boolean] if the tile is passable according to the surf rules
    def passage_surf_check?(sys_tag)
    end
    # Check the passage related to events
    # @param new_x [Integer] new x position
    # @param new_y [Integer] new y position
    # @param z [Integer] current z position
    # @return [Boolean] if the tile has no event that block the way
    def follower_check?(new_x, new_y, z)
    end
    # Check the passage related to events
    # @param new_x [Integer] new x position
    # @param new_y [Integer] new y position
    # @param z [Integer] current z position
    # @param game_map [Game_Map] map object
    # @return [Boolean] if the tile has no event that block the way
    def event_passable_check?(new_x, new_y, z, game_map)
    end
    # Make the Game_Character jump
    # @param x_plus [Integer] the number of tile the Game_Character will jump on x
    # @param y_plus [Integer] the number of tile the Game_Character will jump on y
    # @return [Boolean] if the character is jumping
    def jump(x_plus, y_plus)
    end
    # Perform the bridge check for the jump operation
    # @param x_plus [Integer] the number of tile the Game_Character will jump on x
    # @param y_plus [Integer] the number of tile the Game_Character will jump on y
    def jump_bridge_check(x_plus, y_plus)
    end
    # Adjust the Character informations related to the brige when it moves left (or right)
    # @param z [Integer] the z position
    # @author Nuri Yuri
    def bridge_down_check(z)
    end
    alias bridge_up_check bridge_down_check
    # Check bridge information and adjust the z position of the Game_Character
    # @param z [Integer] the z level
    # @author Nuri Yuri
    def bridge_left_check(z)
    end
    alias bridge_right_check bridge_left_check
    # End of the movement process
    # @author Nuri Yuri
    def movement_process_end
    end
    # Return the SystemTag in the front of the Game_Character
    # @return [Integer] ID of the SystemTag
    # @author Nuri Yuri
    def front_system_tag
    end
    # Return the SystemTag where the Game_Character stands
    # @return [Integer] ID of the SystemTag
    # @author Nuri Yuri
    def system_tag
    end
  end
  # Module that describe the pathfinding targets.
  # There is different type of targets :
  # - Coords : reach a specific point in the map
  #         find_path to:[x, y, [,z]] [, radius: Integer]
  # - Character : reach a game character object in the map
  #         find_path to:get_character(Integer)[, radius: Integer]
  # - Charcater_Reject : flee the given charcater :
  #         find_path to:get_character(Integer), type: :Character_Reject[, radius: Integer]
  # - Border : reach the border of the map (:north, :south, :east, :west)
  #         find_path to: Symbol, type: :Border[, radius: Integer]
  # Each target can be tested by the reached? method
  module Target
    # Convert the raw data to a target object
    # @param data [Array] data to convert
    # @return [Object]
    def self.get(type, *data)
    end
    # Convert the saved data to a target object with
    # @param data [Array] data to convert, must be create by the target object
    # @return [Object]
    def self.load(data)
    end
    # Coords target type
    class Coords
      def initialize(*args)
      end
      # Test if the target is reached at the fiveng coords
      # @param x [Integer] the x coordinate to test
      # @param y [Integer] the y coordinate to test
      # @param z [Integer] the x coordinate to test
      # @return [Boolean]
      def reached?(x, y, z)
      end
      # Check if the character targetted has moved, considering the distance for optimisation and return true if the target is considered as moved
      # @param x [Integer] the x coordinate of the heading event
      # @param y [Integer] the y coordinate of the heading event
      # @return [Boolean]
      def check_move(x, y)
      end
      # Gather the savable data
      # @return [Array<Object>]
      def save
      end
      # Create new target from the given data
      # @param data [Array] saved data
      def self.load(data)
      end
    end
    # Character target type
    class Character
      def initialize(*args)
      end
      # Test if the target is reached at the fiveng coords
      # @param x [Integer] the x coordinate to test
      # @param y [Integer] the y coordinate to test
      # @param z [Integer] the x coordinate to test
      # @return [Boolean]
      def reached?(x, y, z)
      end
      # Check if the character targetted has moved, considering the distance for optimisation and return true if the target is considered as moved
      # @param x [Integer] the x coordinate of the heading event
      # @param y [Integer] the y coordinate of the heading event
      # @return [Boolean]
      def check_move(x, y)
      end
      # Gather the savable data
      # @return [Array<Object>]
      def save
      end
      # Create new target from the given data
      # @param data [Array] saved data
      def self.load(data)
      end
    end
    # Character reject target type
    class Character_Reject
      def initialize(*args)
      end
      # Test if the target is reached at the given coords
      # @param x [Integer] the x coordinate to test
      # @param y [Integer] the y coordinate to test
      # @param z [Integer] the x coordinate to test
      # @return [Boolean]
      def reached?(x, y, z)
      end
      # Check if the character targetted has moved, considering the distance for optimisation and return true if the target is considered as moved
      # @param x [Integer] the x coordinate of the heading event
      # @param y [Integer] the y coordinate of the heading event
      # @return [Boolean]
      def check_move(x, y)
      end
      # Gather the savable data
      # @return [Array<Object>]
      def save
      end
      # Create new target from the given data
      # @param data [Array] saved data
      def self.load(data)
      end
    end
    # Border target type
    class Border
      def initialize(*args)
      end
      # Test if the target is reached at the given coords
      # @param x [Integer] the x coordinate to test
      # @param y [Integer] the y coordinate to test
      # @param z [Integer] the x coordinate to test
      # @return [Boolean]
      def reached?(x, y, z)
      end
      # Check if the character targetted has moved, considering the distance for optimisation and return true if the target is considered as moved
      # @param x [Integer] the x coordinate of the heading event
      # @param y [Integer] the y coordinate of the heading event
      # @return [Boolean]
      def check_move(x, y)
      end
      # Gather the savable data
      # @return [Array<Object>]
      def save
      end
      # Create new target from the given data
      # @param data [Array] saved data
      def self.load(data)
      end
    end
  end
end
# The map gameplay scene
class Scene_Map < GamePlay::Base
  include Hooks
  include Graphics::FPSBalancer::Marker
  # Access to the spriteset of the map
  # @return [Spriteset_Map]
  attr_reader :spriteset
  # Poison flash color
  PSN_COLOR = Color.new(123, 55, 123, 128)
  # Create a new Scene_Map
  def initialize
  end
  # Update the scene process
  def update
  end
  # Section where we update the graphics of the scene (for now only spriteset)
  def update_graphics
  end
  # Change the viewport visibility of the scene (we overwrite it because we don't want viewport to be hidden when calling a scene)
  # @param value [Boolean]
  def visible=(value)
  end
  # Update everything related to the graphics of the map (used in Interfaces that require that)
  def sprite_set_update
  end
  # Change the spriteset visibility
  # @param v [Boolean] the new visibility of the spriteset
  def sprite_set_visible=(v)
  end
  # Display the repel check sequence
  def display_repel_check
  end
  # Display the end of poisoning sequence
  # @param pokemon [PFM::Pokemon] previously poisoned pokemon
  def display_poison_end(pokemon)
  end
  # Display text showing pokemon fainted from poison
  def display_poison_faint(pokemon)
  end
  # Display the poisoning animation sequence
  def display_poison_animation
  end
  # Display the Egg hatch sequence
  # @param pokemon [PFM::Pokemon] haching pokemon
  def display_egg_hatch(pokemon)
  end
  # Prepare the call of a display_ method
  # @param args [Array] the send method parameter
  def delay_display_call(*args)
  end
  # Force the message window to close
  # @param smooth [Boolean] if the message window is closed smoothly or not
  def window_message_close(smooth)
  end
  # Take a snapshot of the scene
  # @note You have to dispose the bitmap you got from this function
  # @return [Texture]
  def snap_to_bitmap
  end
  private
  # The main process at the begin of scene
  def main_begin
  end
  # Create the spriteset
  def create_spriteset
  end
  # Section of the update where we ensure that the game player is transfering correctly
  def auto_transfert_update
  end
  # Section of the update where we test if the game switched to a main RMXP scene
  # @note we also process transition here
  # @return [Boolean] if a switch was done
  def switched_to_main_rmxp_scene
  end
  public
  # List of RMXP Group that should be treated as "wild battle"
  RMXP_WILD_BATTLE_GROUPS = [1, 30]
  @triggers = {}
  @battle_modes = []
  class << self
    # List of call_xxx trigger
    # @return [Hash{ Symbol => Proc }]
    attr_reader :triggers
    # Add a call scene in Scene_Map
    # @param method_name [Symbol] name of the method to call (no argument)
    # @param block [Proc] block to execute in order to be sure the scene callable
    def add_call_scene(method_name, &block)
    end
    # List all the battle modes
    # @return [Array<Proc>]
    attr_reader :battle_modes
    # Add a battle mode
    # @param id [Integer] ID of the battle mode
    # @param block [Proc]
    # @yieldparam scene [Scene_Map]
    def register_battle_mode(id, &block)
    end
  end
  # Ensure the battle will start without any weird behaviour
  # @param klass [Class<Battle::Scene>] class of the scene to setup
  # @param battle_info [Battle::Logic::BattleInfo]
  def setup_start_battle(klass, battle_info)
  end
  private
  # Function responsive of testing all the scene calling and doing the job
  def update_scene_calling
  end
  add_call_scene(:call_battle) {$game_temp.battle_calling }
  add_call_scene(:call_shop) {$game_temp.shop_calling }
  add_call_scene(:call_name) {$game_temp.name_calling }
  add_call_scene(:call_menu) {$game_temp.menu_calling }
  add_call_scene(:call_save) {$game_temp.save_calling }
  add_call_scene(:call_debug) {$game_temp.debug_calling }
  add_call_scene(:call_shortcut) {Input.trigger?(:Y) unless $game_map.map_id == Configs.scene_title_config.intro_movie_map_id }
  # Detect if the player clicked on the Player sprite to open the menu
  # @return [Boolean]
  def player_menu_trigger
  end
  # Call the Battle scene if the play encounter Pokemon or trainer and its party has Pokemon that can fight
  def call_battle
  end
  register_battle_mode(0) do |scene|
    if RMXP_WILD_BATTLE_GROUPS.include?($game_temp.battle_troop_id)
      battle_info = $wild_battle.setup
    else
      battle_info = Battle::Logic::BattleInfo.from_old_psdk_settings($game_variables[Yuki::Var::Trainer_Battle_ID], $game_variables[Yuki::Var::Second_Trainer_ID], $game_variables[Yuki::Var::Allied_Trainer_ID])
    end
    scene.setup_start_battle(Battle::Scene, battle_info)
  end
  # Call the shop ui
  def call_shop
  end
  # Call the name input scene
  def call_name
  end
  # Call the Menu interface
  def call_menu
  end
  # Call the save interface
  def call_save
  end
  # Call the debug interface (not present in PSDK)
  def call_debug
  end
  # Call the shortcut interface
  def call_shortcut
  end
  public
  private
  # Execute the begin calculation of the transfer_player processing
  def transfer_player_begin
  end
  # Teleport the play between map or inside the map
  def transfer_player
  end
  # End of the transfer player processing (transitions)
  def transfer_player_end(transition_sprite)
  end
  # Start a specific transition
  def transfer_player_specific_transition
  end
end
