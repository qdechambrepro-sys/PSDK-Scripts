module PFM
  # Class for the data of Map overlays that will be saved
  class MapOverlay
    # Current preset
    # @return [PresetBase, nil]
    attr_reader :current_preset
    # Change to a new preset
    # @param new_preset [Symbol] Symbol of the preset
    def change_overlay_preset(new_preset)
      raise ArgumentError, "Unregistered Map Overlay Preset :#{new_preset}" unless REGISTERED_PRESETS[new_preset]
      @current_preset = REGISTERED_PRESETS[new_preset].new
    end
    # Erase overlay and dispose resources
    # @return [Boolean] False if overlay was already stopped, true otherwise
    def stop_overlay_preset
      @current_preset = nil
    end
    # List of registered presets
    # @return [Hash<Symbol => Class>]
    REGISTERED_PRESETS = {}
    class << self
      # Register a preset
      # @param preset_name [Symbol]
      # @param klass [Class]
      def register_preset(preset_name, klass)
        REGISTERED_PRESETS[preset_name] = klass
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
        unless ALLOWED_BLEND_MODES.include?(blend_mode)
          raise ArgumentError, "Provided with invalid blend mode value: #{blend_mode}; expected #{ALLOWED_BLEND_MODES.to_a.join(', ')}"
        end
        @blend_mode = blend_mode
      end
      # Get the opacity
      # @return [Float]
      attr_reader :opacity
      # Set the opacity
      # @param opacity [Float, Integer]
      def opacity=(opacity)
        unless opacity.between?(0, 1)
          raise ArgumentError, "Provided with invalid opacity: #{opacity}, expected 0.0 upto 1.0"
        end
        @opacity = opacity
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
        @blend_mode = ALLOWED_BLEND_MODES.first
        @time = t_min
        @opacity = 1
        config = Viewport::CONFIGS[:main]
        @resolution = [config[:width], config[:height]]
        @paused = !has_animation?
      end
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
        :overlay_shader_static_image
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return false
      end
      # Return the t_min value for animation
      # @return [Numeric]
      def t_min
        return TMIN
      end
      # Return the t_max value for animation
      # @return [Numeric]
      def t_max
        return TMAX
      end
      # Update the preset in UI space
      # @param preset [PresetBase]
      def update(preset)
        update_opacity(preset)
        update_blend_mode(preset)
        update_time(preset)
      end
      # Update the opacity in UI Space
      # @param preset [PresetBase]
      def update_opacity(preset)
        return if preset.opacity == @opacity
        @shader.set_float_uniform('opacity', @opacity = preset.opacity)
      end
      # Update the blend_mode in UI Space
      # @param preset [PresetBase]
      def update_blend_mode(preset)
        return if preset.blend_mode == @blend_mode
        @blend_mode = preset.blend_mode
        @shader.set_int_uniform('blend_mode', ALLOWED_BLEND_MODES.index(@blend_mode))
      end
      # Update the time parameter
      # @param preset [PresetBase]
      def update_time(preset)
        current_elapsed = $scene.clock.elapsed_time
        return if preset.paused
        if @last_elapsed
          if current_elapsed >= @last_elapsed
            delta = (current_elapsed - @last_elapsed) / 2
          else
            delta = 0.008
          end
          @time += delta
          @time = t_min + (@time - t_max) if @time > t_max
        end
        @shader.set_float_uniform('time', @time)
      ensure
        @last_elapsed = current_elapsed
      end
      # Dispose itself in UI space
      def dispose
        @shader = nil
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
        super
        update_sample_color(preset)
      end
      # Update sample_color texture in UI space
      # @param preset [PresetWithSampleColor]
      def update_sample_color(preset)
        return if @sample_color == preset.sample_color
        @shader.set_float_uniform('sample_color', @sample_color = preset.sample_color.dup)
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
        super
        @extra_texture_name = 'fog_base'
        @distance_factor = 1.5
      end
      # Update the preset in UI space
      # @param preset [PresetStaticImage]
      def update(preset)
        super
        update_distance_factor(preset)
        update_extra_texture(preset)
      end
      # Update extra texture in UI space
      # @param preset [PresetStaticImage]
      def update_extra_texture(preset)
        return if @extra_texture_name == preset.extra_texture_name && @extra_texture
        @extra_texture&.dispose unless @extra_texture&.disposed?
        @extra_texture = RPG::Cache.fog(@extra_texture_name = preset.extra_texture_name)
        @shader.set_texture_uniform('extra_texture', @extra_texture)
      end
      # Update the distance factor
      # @param preset [PresetStaticImage]
      def update_distance_factor(preset)
        return if preset.distance_factor == @distance_factor
        @shader.set_float_uniform('dist_factor', @distance_factor = preset.distance_factor)
      end
      def dispose
        super
        @extra_texture&.dispose unless @extra_texture&.disposed?
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
        :overlay_shader_scroll
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
      end
      # Initialize the Scroll Image preset
      def initialize
        super
        @distance_factor = 1.5
        @extra_texture_name = 'noise_texture'
        @direction1 = [0.1, 0.1]
      end
      # Update the preset
      # @param preset [PresetScrollImage]
      def update(preset)
        super
        update_direction1(preset)
      end
      # Update the direction1
      # @param preset [PresetScrollImage]
      def update_direction1(preset)
        return if preset.direction1 == @direction1
        @shader.set_float_uniform('direction1', @distance_factor = preset.distance_factor)
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
        :overlay_shader_water
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
      end
      # Initialize the Water Overlay preset
      def initialize
        super
        @noise_texture_name = 'noise_texture'
        @color_gradient_texture_name = 'water_color_gradient'
        @blend_mode = :multiply
      end
      # Update the preset in UI space
      # @param preset [PresetWaterOverlay]
      def update(preset)
        super
        update_noise_texture(preset)
        update_color_gradient_texture(preset)
      end
      # Update noise texture in UI space
      # @param preset [PresetWaterOverlay]
      def update_noise_texture(preset)
        return if @noise_texture_name == preset.noise_texture_name
        @noise_texture&.dispose unless @noise_texture&.disposed?
        @noise_texture = RPG::Cache.fog(@noise_texture_name = preset.noise_texture_name)
        @shader.set_texture_uniform('noise', @noise_texture)
      end
      # Update color_gradient texture in UI space
      # @param preset [PresetWaterOverlay]
      def update_color_gradient_texture(preset)
        return if @color_gradient_texture_name == preset.color_gradient_texture_name
        @color_gradient_texture&.dispose unless @color_gradient_texture&.disposed?
        @color_gradient_texture = RPG::Cache.fog(@color_gradient_texture_name = preset.color_gradient_texture_name)
        @shader.set_texture_uniform('color_gradient', @color_gradient_texture)
      end
      def dispose
        super
        @noise_texture&.dispose unless @noise_texture&.disposed?
        @color_gradient_texture&.dispose unless @color_gradient_texture&.disposed?
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
        :overlay_shader_fog
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
      end
      # Initialize the Fog Overlay preset
      def initialize
        super
        @noise_texture_name = 'noise_texture'
        @sample_color = Color.new(204, 204, 204)
      end
      # Update the preset in UI space
      # @param preset [PresetFogOverlay]
      def update(preset)
        super
        update_noise_texture(preset)
      end
      # Update noise texture in UI space
      # @param preset [PresetFogOverlay]
      def update_noise_texture(preset)
        return if @noise_texture_name == preset.noise_texture_name
        @noise_texture&.dispose unless @noise_texture&.disposed?
        @noise_texture = RPG::Cache.fog(@noise_texture_name = preset.noise_texture_name)
        @shader.set_texture_uniform('noise', @noise_texture)
      end
      def dispose
        super
        @noise_texture&.dispose unless @noise_texture&.disposed?
      end
    end
    register_preset(:fog, PresetFogOverlay)
    # Nausea overlay
    class PresetNausea < PresetBase
      private
      # Name of the shader to load
      # @return [Symbol]
      def shader_name
        :overlay_shader_nausea
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
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
        :overlay_shader_ripple
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
      end
      # Initialize the Ripple preset
      def initialize
        super
        @sample_color = Color.new(0, 26, 26, 128)
        @position = UVResolver.new(:game_player)
      end
      # Update the preset in UI space
      # @param preset [PresetRippleOverlay]
      def update(preset)
        super
        update_position(preset)
      end
      # Update the position
      # @param preset [PresetRippleOverlay]
      def update_position(preset)
        @shader.set_float_uniform('position', preset.position.resolve(preset.resolution, $game_player))
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
        :overlay_shader_godrays
      end
      # Tell if the preset has an animation
      # @return [Boolean]
      def has_animation?
        return true
      end
      # Initialize the Godrays preset
      def initialize
        super
        @sample_color = Color.new(153, 102, 26, 128)
        @blend_mode = :screen
      end
    end
    register_preset(:godrays, PresetGodRaysOverlay)
    # Class responsive of resolving target uv coordinates for the shaders used in MapOverlay
    class UVResolver
      # Create a new UVResolver
      # @param source_coordinates [Array<Integer>, Symbol] (:game_player for player's coordinates)
      # @param coordinate_type [Symbol] Must be :tile (defined for later uses)
      def initialize(source_coordinates, coordinate_type = :tile)
        @source_coordinates = source_coordinates
        @coordinate_type = coordinate_type
        @tilesize = Configs.display.tilemap_settings.tilemap_class == 'Yuki::Tilemap16px' ? 16 : 32
        @zoom = Configs.display.window_scale.to_f
      end
      # Resolve the uv coordinates
      # @param screen_size [Array<Float>] size of the screen
      # @param origin [Object] object allowing the find the origin of the screen in its own coordinate space
      # @return [Array<Float>]
      def resolve(screen_size, origin)
        sx, sy = coordinates_relative_to_origin(origin)
        zoom = @zoom
        return [sx / (screen_size.first * zoom), sy / (screen_size.last * zoom)]
      end
      private
      # Get the coordinates relative to origin
      # @param origin [Object]
      # @return [Array<Float>]
      def coordinates_relative_to_origin(origin)
        return [0, 0] if @coordinate_type != :tile || !origin.is_a?(Game_Character)
        src_x, src_y = source_coordinates
        dx = src_x - origin.x
        dy = origin.y - src_y - 0.5
        screen_factor = @tilesize * @zoom
        return [dx * screen_factor + origin.screen_x, dy * screen_factor + origin.screen_y]
      end
      # Get the source coordinates
      # @return [Array<Float>]
      def source_coordinates
        return [$game_player.x, $game_player.y] if @source_coordinates == :game_player
        return @source_coordinates
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
      @viewport = viewport
      @current_preset = nil
    end
    # Update the Overlay animation
    def update
      map_overlay = PFM.game_state.map_overlay
      return dispose unless map_overlay.current_preset
      swap_presets(map_overlay.current_preset) if map_overlay.current_preset.class != @current_preset.class
      @current_preset.update(map_overlay.current_preset)
    end
    # Dispose of map overlay and restore normal shader
    def dispose
      return unless @current_preset
      return if @viewport.disposed?
      @viewport.shader = Shader.create(:map_shader)
      if @viewport.is_a?(Viewport::WithToneAndColors)
        @viewport.shader&.set_float_uniform('color', @viewport.color)
        @viewport.shader&.set_float_uniform('tone', @viewport.tone)
      end
    ensure
      @current_preset&.dispose
      @current_preset = nil
    end
    private
    # Swap to a new preset and dispose of the previous one
    # @param new_preset [PFM::MapOverlay::PresetBase, nil]
    def swap_presets(new_preset)
      return dispose unless new_preset
      @current_preset&.dispose
      @current_preset = new_preset.dup
      @current_preset.extend(UISpace)
      @current_preset.clear_ivar
      @current_preset.bind_to_viewport(@viewport)
    end
    public
    # Module that enable the UI Space related function of each presets
    module UISpace
      IVAR_TO_PRESERVE = %i[@time @paused]
      # Set all the IVar to nil (aside those mentioned in `IVAR_TO_PRESERVE`)
      def clear_ivar
        ivar_to_remove = instance_variables.reject { |i| IVAR_TO_PRESERVE.include?(i) }
        ivar_to_remove.each { |i| instance_variable_set(i, nil) }
      end
      # Set the preset related variables
      # @param viewport [Viewport]
      def bind_to_viewport(viewport)
        @shader = Shader.create(shader_name)
        viewport.shader = @shader
        if viewport.is_a?(Viewport::WithToneAndColors)
          @shader.set_float_uniform('color', viewport.color)
          @shader.set_float_uniform('tone', viewport.tone)
        end
      end
      # Update the preset
      # @param preset [PFM::MapOverlay::PresetBase]
      def update(preset)
        super
      end
      # Dispose the preset
      def dispose
        super
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
