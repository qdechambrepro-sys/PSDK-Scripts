module PFM
  # Class for the data of Map overlays that will be saved
  class MapOverlay
    # Current preset
    # @return [PresetBase, nil]
    attr_reader :current_preset
    # Change to a new preset
    # @param new_preset [Symbol] Symbol of the preset
    def change_overlay_preset(new_preset)
    end
    # Erase overlay and dispose resources
    # @return [Boolean] False if overlay was already stopped, true otherwise
    def stop_overlay_preset
    end
    # List of registered presets
    # @return [Hash<Symbol => Class>]
    REGISTERED_PRESETS = {}
    class << self
      # Register a preset
      # @param preset_name [Symbol]
      # @param klass [Class]
      def register_preset(preset_name, klass)
      end
    end
    # Base preset of the map overlay
    class PresetBase
      # Minimum value of time in MapOverlay
      TMIN = 0
      # Maximum value of time in MapOverlay
      TMAX = 100
      # List of allowed blend modes
      ALLOWED_BLEND_MODES = %i[normal add subtract multiply overlay screen]
      # Get the blend mode
      # @return [Symbol]
      attr_reader :blend_mode
      # Set the blend mode
      # @param blend_mode [Symbol]
      def blend_mode=(blend_mode)
      end
      # Get the opacity
      # @return [Float]
      attr_reader :opacity
      # Set the opacity
      # @param opacity [Float, Integer]
      def opacity=(opacity)
      end
      # Get the resolution
      # @return [Array<Integer>]
      attr_reader :resolution
      # Access the paused attribute
      # @return [Boolean]
      attr_accessor :paused
      private
      # Initialize the preset
      def initialize
      end
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Return the t_min value for animation
      # @return [Numeric]
      def t_min
      end
      # Return the t_max value for animation
      # @return [Numeric]
      def t_max
      end
      # Update the preset in UI space
      # @param preset [PresetBase]
      def update(preset)
      end
      # Update the opacity in UI Space
      # @param preset [PresetBase]
      def update_opacity(preset)
      end
      # Update the blend_mode in UI Space
      # @param preset [PresetBase]
      def update_blend_mode(preset)
      end
      # Update the time parameter
      # @param preset [PresetBase]
      def update_time(preset)
      end
      # Dispose itself in UI space
      def dispose
      end
    end
    # Abstraction for shader using the 'sample_color' uniform
    module PresetWithSampleColor
      # Get or set the sample_color
      # @return [Color]
      attr_accessor :sample_color
      private
      # Update the preset in UI space
      # @param preset [PresetWithSampleColor]
      def update(preset)
      end
      # Update sample_color texture in UI space
      # @param preset [PresetWithSampleColor]
      def update_sample_color(preset)
      end
    end
    # Static image overlay
    class PresetStaticImage < PresetBase
      # Get or set the extra texture name
      # @return [String]
      attr_accessor :extra_texture_name
      # Get or set the distance factor
      # @return [Numeric]
      attr_accessor :distance_factor
      private
      # Initialize the Static Image preset
      def initialize
      end
      # Update the preset in UI space
      # @param preset [PresetStaticImage]
      def update(preset)
      end
      # Update extra texture in UI space
      # @param preset [PresetStaticImage]
      def update_extra_texture(preset)
      end
      # Update the distance factor
      # @param preset [PresetStaticImage]
      def update_distance_factor(preset)
      end
      def dispose
      end
    end
    register_preset(:static_image, PresetStaticImage)
    # Scroll image preset
    class PresetScrollImage < PresetStaticImage
      # Get or set the scroll direction
      # @return [Array]
      attr_accessor :direction1
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Initialize the Scroll Image preset
      def initialize
      end
      # Update the preset
      # @param preset [PresetScrollImage]
      def update(preset)
      end
      # Update the direction1
      # @param preset [PresetScrollImage]
      def update_direction1(preset)
      end
    end
    register_preset(:scroll, PresetScrollImage)
    # Water overlay
    class PresetWaterOverlay < PresetBase
      # Get or set the noise texture name
      # @return [String]
      attr_accessor :noise_texture_name
      # Get or set the color gradient texture name
      # @return [String]
      attr_accessor :color_gradient_texture_name
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Initialize the Water Overlay preset
      def initialize
      end
      # Update the preset in UI space
      # @param preset [PresetWaterOverlay]
      def update(preset)
      end
      # Update noise texture in UI space
      # @param preset [PresetWaterOverlay]
      def update_noise_texture(preset)
      end
      # Update color_gradient texture in UI space
      # @param preset [PresetWaterOverlay]
      def update_color_gradient_texture(preset)
      end
      def dispose
      end
    end
    register_preset(:water, PresetWaterOverlay)
    # Fog overlay
    class PresetFogOverlay < PresetBase
      prepend PresetWithSampleColor
      # Get or set the noise texture name
      # @return [String]
      attr_accessor :noise_texture_name
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Initialize the Fog Overlay preset
      def initialize
      end
      # Update the preset in UI space
      # @param preset [PresetFogOverlay]
      def update(preset)
      end
      # Update noise texture in UI space
      # @param preset [PresetFogOverlay]
      def update_noise_texture(preset)
      end
      def dispose
      end
    end
    register_preset(:fog, PresetFogOverlay)
    # Nausea overlay
    class PresetNausea < PresetBase
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
    end
    register_preset(:nausea, PresetNausea)
    # Ripple overlay
    class PresetRippleOverlay < PresetBase
      prepend PresetWithSampleColor
      # Get or set the position
      # @return [PFM::MapOverlay::UVResolver]
      attr_accessor :position
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Initialize the Ripple preset
      def initialize
      end
      # Update the preset in UI space
      # @param preset [PresetRippleOverlay]
      def update(preset)
      end
      # Update the position
      # @param preset [PresetRippleOverlay]
      def update_position(preset)
      end
    end
    register_preset(:ripple, PresetRippleOverlay)
    # GodRays overlay
    class PresetGodRaysOverlay < PresetBase
      prepend PresetWithSampleColor
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
      end
      # Initialize the Godrays preset
      def initialize
      end
    end
    register_preset(:godrays, PresetGodRaysOverlay)
    # Class responsive of resolving target uv coordinates for the shaders used in MapOverlay
    class UVResolver
      # Create a new UVResolver
      # @param source_coordinates [Array<Integer>, Symbol] (:game_player for player's coordinates)
      # @param coordinate_type [Symbol] Must be :tile (defined for later uses)
      def initialize(source_coordinates, coordinate_type = :tile)
      end
      # Resolve the uv coordinates
      # @param screen_size [Array<Float>] size of the screen
      # @param origin [Object] object allowing the find the origin of the screen in its own coordinate space
      # @return [Array<Float>]
      def resolve(screen_size, origin)
      end
      private
      # Get the coordinates relative to origin
      # @param origin [Object]
      # @return [Array<Float>]
      def coordinates_relative_to_origin(origin)
      end
      # Get the source coordinates
      # @return [Array<Float>]
      def source_coordinates
      end
    end
  end
  class << self
    # Accessor for the MapOverlay class
    # @return [Class]
    attr_accessor :map_overlay_class
  end
  class GameState
    # Accessor for the MapOverlay
    # @return [PFM::MapOverlay]
    attr_accessor :map_overlay
    on_initialize(:map_overlay) {@map_overlay = PFM.map_overlay_class.new }
    on_expand_global_variables(:map_overlay) do
      @map_overlay ||= PFM.map_overlay_class.new
      $map_overlay = @map_overlay
    end
  end
end
PFM.map_overlay_class = PFM::MapOverlay
module UI
  # UI Materialization of the Map Overlay
  class MapOverlay
    # Create a new Map Overlay UI
    # @param viewport [Viewport]
    def initialize(viewport)
    end
    # Update the Overlay animation
    def update
    end
    # Dispose of map overlay and restore normal shader
    def dispose
    end
    private
    # Swap to a new preset and dispose of the previous one
    # @param new_preset [PFM::MapOverlay::PresetBase, nil]
    def swap_presets(new_preset)
    end
    public
    # Module that enable the UI Space related function of each presets
    module UISpace
      IVAR_TO_PRESERVE = %i[@time @paused]
      # Set all the IVar to nil (aside those mentioned in `IVAR_TO_PRESERVE`)
      def clear_ivar
      end
      # Set the preset related variables
      # @param viewport [Viewport]
      def bind_to_viewport(viewport)
      end
      # Update the preset
      # @param preset [PFM::MapOverlay::PresetBase]
      def update(preset)
      end
      # Dispose the preset
      def dispose
      end
    end
  end
end
Hooks.register(Spriteset_Map, :initialize, 'Load Map Overlay') do
  @ui_map_overlay = UI::MapOverlay.new(map_viewport)
end
Hooks.register(Spriteset_Map, :update, 'Update Map Overlay') do
  @ui_map_overlay&.update
end
Hooks.register(Spriteset_Map, :dispose, 'Dispose Map Overlay') do
  @ui_map_overlay&.dispose
  @ui_map_overlay = nil
end
vertex_shader = 'graphics/shaders/map_viewport.vert'
Shader.register(:overlay_shader_static_image, 'graphics/shaders/overlay_static_image.frag', vertex_shader)
Shader.register(:overlay_shader_scroll, 'graphics/shaders/overlay_scroll.frag', vertex_shader)
Shader.register(:overlay_shader_water, 'graphics/shaders/overlay_water.frag', vertex_shader)
Shader.register(:overlay_shader_fog, 'graphics/shaders/overlay_fog.frag', vertex_shader)
Shader.register(:overlay_shader_nausea, 'graphics/shaders/overlay_nausea.frag', vertex_shader)
Shader.register(:overlay_shader_ripple, 'graphics/shaders/overlay_ripple.frag', vertex_shader)
Shader.register(:overlay_shader_godrays, 'graphics/shaders/overlay_godrays.frag', vertex_shader)
