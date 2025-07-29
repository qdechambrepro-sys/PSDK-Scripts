# Nuri Yuri's external script module
module NuriYuri
  # Module managing the dynamic light system for PSDK
  module DynamicLight
    # @return [Array<Array>] List of light
    #   The first array component tell if it's a normal light (:normal, centered on the character)
    #   or if it's a directed light (:direction, in the direction of the character)
    #   The second component is the sprite shown under the map (light mask)
    #   The third component is the sprite shown in the map viewport for special effect mostly on top of the character
    LIGHTS = [[:normal, 'dynamic_light/circle_320'], [:direction, 'dynamic_light/flash_light_mask', 'dynamic_light/flash_light_color'], [:normal, 'dynamic_light/circle_96']]
    # @return [Array<Hash>] List of light animation, Hash key are opacity: & zoom: (array of value)
    ANIMATIONS = [{zoom: [1], opacity: [255]}, {zoom: Array.new(120) { |i| 0.70 + 0.05 * Math.cos(6.28 * i / 120) }, opacity: Array.new(120) { |i| 240 + (15 * Math.cos(6.28 * i / 120)).to_i }}, {zoom: Array.new(120) { |i| 0.95 + 0.05 * Math.cos(6.28 * i / 120) }, opacity: [255]}]
    module_function
    # Start the dynamic light processing
    # @param block [Proc] given_block that tells to start the DynamicLight process on the next update
    def start(&block)
    end
    # Stop the dynamic light processing
    # @param from_start [Boolean] tell if stop was called from start to prevent useless viewport dispose
    def stop(from_start = false)
    end
    # Start delayed to the warp_end process
    # @yield [dl] given_block that tells to start the DynamicLight process on the next update
    # @yieldparam dl [DynamicLight] this module
    def start_delay
    end
    # Stop delayed to the warp_end process
    def stop_delay
    end
    # Tells if the DynamicLight is started and running or not
    # @return [Integer]
    def started?
    end
    # Update the lights
    def update
    end
    # Add a new light to the stack
    # @param chara_id [Integer] ID of the character (0 = player, -n = follower n, +n = event id)
    # @param light_type [Integer] Type of the light we'll display on the character
    # @param animation_type [Integer] Type of the animation performed on the light
    # @param zoom_count [Integer] initial value of the zoom_count
    # @param opacity_count [Integer] initial value of the opacity_count
    # @param args [Array] extra parameters
    # @param type [Class] Type of the sprite used to simulate the light
    # @return [Integer] ID of the light in the light stack, if -1 => one of the parameter is invalid
    def add(chara_id, light_type, animation_type = 0, zoom_count = 0, opacity_count = 0, *args, type: DynamicLightSprite)
    end
    # Recursively get to the asked follower and return the result
    # @param chara_id [Integer]
    # @return [Game_Character, Game_Event, nil] the Game_Character/Game_Event is it exists, else nil
    def determine_follower_character(chara_id)
    end
    # Switch a light on
    # @param light_id [Integer] ID of the light in the light stack
    def switch_on(light_id)
    end
    # Switch a light off
    # @param light_id [Integer] ID of the light in the light stack
    def switch_off(light_id)
    end
    # Retrieve the light sprite
    # @param light_id ID of the light in the light stack
    # @return [DynamicLightSprite, nil]
    def light_sprite(light_id)
    end
    # Register the update task
    def register
    end
    # Unregister the update task
    def unregister
    end
    # Clear the light task
    def clear_stack
    end
    # Create the viewport
    def create_viewport
    end
    # Dispose the light viewport
    def dispose_viewport
    end
    # Load the light blend_mode
    def load_blendmode
    end
    # Part called when Scene_Map init itself (in order to reload all the lights)
    def on_map_init
    end
    # Return the viewport of the DynamicLight system
    # @return [Viewport]
    def viewport
    end
    # Clean everything on soft reset
    def on_soft_reset
    end
    unless PARGV[:worldmap] || PARGV[:test] || PARGV[:tags]
      Scheduler.add_message(:on_init, Scene_Map, 'NuriYuri::DynamicLight', 0, self, :on_map_init)
      Graphics.on_start do
        soft_reset = Yuki.const_get(:SoftReset)
        Scheduler.add_message(:on_transition, soft_reset, 'NuriYuri::DynamicLight', 100, self, :on_soft_reset)
      end
    end
    public
    # Sprite that simulate the dynamic light
    class DynamicLightSprite < ::Sprite
      # Offset of the light in :direction mode
      DIRECTION_OFFSET = -12
      # Offset of the light in other modes
      NORMAL_OFFSET = -8
      # Zoom of a tile to process coodinate properly
      TILE_ZOOM = Configs.display.tilemap_settings.character_tile_zoom
      # @return [Integer] ID of the light in the stack
      attr_accessor :light_id
      # Create a new DynamicLightSprite
      # @param character [Game_Character]
      # @param light_type [Integer] Type of the light we'll display on the character
      # @param animation_type [Integer] Type of the animation performed on the light
      # @param zoom_count [Integer] initial value of the zoom_count
      # @param opacity_count [Integer] initial value of the opacity_count
      def initialize(character, light_type, animation_type = 0, zoom_count = 0, opacity_count = 0)
      end
      # Update the sprite
      def update
      end
      alias on visible
      # Change the sprite visibility
      # @param value [Boolean]
      def visible=(value)
      end
      # Dispose the sprite
      def dispose
      end
      alias on= visible=
      private
      # Update the direction of the sprite
      def update_direction
      end
      # Update the sub sprite
      def sub_sprite_update
      end
      # Update the sub sprite angle
      def update_sub_sprite_angle
      end
      # Load the light images
      # @param light_array [Array] informations about the light
      def load_light(light_array)
      end
    end
    public
    # Sprite that simulate the dynamic light and can be scaled
    class ScalableDLS < DynamicLightSprite
      # Create a new ScalableDynamicLightSprite
      # @param character [Game_Character]
      # @param light_type [Integer] Type of the light we'll display on the character
      # @param animation_type [Integer] Type of the animation performed on the light
      # @param zoom_count [Integer] initial value of the zoom_count
      # @param opacity_count [Integer] initial value of the opacity_count
      # @param init_scale [Numeric] initial scale of the object
      def initialize(character, light_type, animation_type = 0, zoom_count = 0, opacity_count = 0, init_scale = 1)
      end
      # Change the zoom of the sprite
      # @param value [Numeric] New zoom
      def zoom=(value)
      end
      # Retrieve the current scale of the sprite (without the animation effect)
      # @return [Numeric]
      def scale
      end
      # Update the sprite
      def update
      end
      # Tell the sprite to scale
      # @param target_scale [Numeric] target value the sprite should scale
      # @param duration [Integer] number of frame the sprite should take to scale
      def scale_to(target_scale, duration = 0)
      end
    end
  end
end
module PFM
  class GameState
    # Access to the information of the current dynamic light state (Battle / Save)
    attr_accessor :nuri_yuri_dynamic_light
  end
end
