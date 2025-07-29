module RPG
  class Sprite
    SHADER = "uniform sampler2D texture;\nuniform float hue;\n\n// Source: https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786\nvec3 hueShift( vec3 color, float hueAdjust ) {\n\n  const vec3  kRGBToYPrime = vec3 (0.299, 0.587, 0.114);\n  const vec3  kRGBToI      = vec3 (0.596, -0.275, -0.321);\n  const vec3  kRGBToQ      = vec3 (0.212, -0.523, 0.311);\n\n  const vec3  kYIQToR     = vec3 (1.0, 0.956, 0.621);\n  const vec3  kYIQToG     = vec3 (1.0, -0.272, -0.647);\n  const vec3  kYIQToB     = vec3 (1.0, -1.107, 1.704);\n\n  float   YPrime  = dot (color, kRGBToYPrime);\n  float   I       = dot (color, kRGBToI);\n  float   Q       = dot (color, kRGBToQ);\n  float   hue     = atan (Q, I);\n  float   chroma  = sqrt (I * I + Q * Q);\n\n  hue += hueAdjust;\n\n  Q = chroma * sin (hue);\n  I = chroma * cos (hue);\n\n  vec3    yIQ   = vec3 (YPrime, I, Q);\n\n  return vec3( dot (yIQ, kYIQToR), dot (yIQ, kYIQToG), dot (yIQ, kYIQToB) );\n}\n\nvoid main() {\n  vec4 color = texture2D(texture, gl_TexCoord[0].xy);\n  color.rgb = hueShift(color.rgb, hue);\n  gl_FragColor = color * gl_Color;\n}\n"
    @@_animations = []
    @@_reference_count = {}
    def initialize(viewport = nil)
      super(viewport)
      @_whiten_duration = 0
      @_appear_duration = 0
      @_escape_duration = 0
      @_collapse_duration = 0
      @_damage_duration = 0
      @_animation_duration = 0
      @_blink = false
      @_reverse = false
      @_option = 0
      @_registered_x = 0
      @_registered_y = 0
      @_registered_ox = 0
      @_registered_oy = 0
      @flash_duration = 0
    end
    def flash(color, duration)
      @flash_color = color
      @flash_duration = duration
      @flash_total_duration = duration
    end
    def color
      return @_color ||= Color.new(0, 0, 0, 0)
    end
    def register_position
      @_registered_x = x
      @_registered_ox = ox
      @_registered_y = y
      @_registered_oy = oy
    end
    def reset_position
      self.x = @_registered_x
      self.ox = @_registered_ox
      self.y = @_registered_y
      self.oy = @_registered_oy
    end
    def dispose_animation
      return unless @_animation_sprites
      @_animation_sprites.each(&:dispose)
      @_animation_sprites = nil
      @_animation = nil
    end
    def dispose_loop_animation
      return unless @_loop_animation_sprites
      @_loop_animation_sprites.each(&:dispose)
      @_loop_animation_sprites = nil
      @_loop_animation = nil
    end
    def animation(animation, hit, reverse = false)
      dispose_animation
      @_animation = animation
      return if @_animation == nil
      self.shader ||= Shader.create(:color_shader)
      self.shader.set_float_uniform('color', color)
      @_animation_hit = hit
      @_animation_duration = @_animation.frame_max
      animation_name = @_animation.animation_name
      animation_hue = @_animation.animation_hue
      bitmap = RPG::Cache.animation(animation_name, animation_hue)
      @_animation_sprites = []
      if @_animation.position != 3 || !@@_animations.include?(animation)
        0.upto(15) do
          sprite = ShaderedSprite.new(viewport)
          sprite.bitmap = bitmap
          sprite.shader = Shader.new(SHADER)
          sprite.shader.set_float_uniform('hue', Math::PI * (360 - animation_hue) / 180)
          sprite.visible = false
          @_animation_sprites.push(sprite)
        end
        @@_animations.push(animation) unless @@_animations.include?(animation)
      end
      @_option = 0
      @_reverse = reverse
      if animation.name.include?('/')
        split_list = animation.name.split('/')
        if split_list.length == 2
          @_option = 1 if split_list[0].include?('R')
          @_reverse = false if split_list[0].include?('N')
          @_option = 2 if split_list[0].include?('M')
        end
      end
      update_animation
    end
    def update
      super
      if @_whiten_duration > 0
        @_whiten_duration -= 1
        color.alpha = 128 - (16 - @_whiten_duration) * 10
      end
      if @_appear_duration > 0
        @_appear_duration -= 1
        self.opacity = (16 - @_appear_duration) * 16
      end
      if @_escape_duration > 0
        @_escape_duration -= 1
        self.opacity = 256 - (32 - @_escape_duration) * 10
      end
      if @_collapse_duration > 0
        @_collapse_duration -= 1
        self.opacity = 256 - (48 - @_collapse_duration) * 6
      end
      if @_animation && (Graphics.frame_count % 3 == 1)
        @_animation_duration -= 1
        update_animation
      end
      if @_loop_animation && (Graphics.frame_count % 3 == 1)
        update_loop_animation
        @_loop_animation_index += 1
        @_loop_animation_index %= @_loop_animation.frame_max
      end
      if @_blink
        @_blink_count = (@_blink_count + 1) % 32
        if @_blink_count < 16
          alpha = (16 - @_blink_count) * 6
        else
          alpha = (@_blink_count - 16) * 6
        end
        color.set(255, 255, 255, alpha)
      end
      @@_animations.clear
      viewport&.update
      handle_flash
      shader.set_float_uniform('color', color)
    end
    def handle_flash
      return if @flash_duration == 0
      @flash_duration -= 1
      if @flash_color
        color.set(@flash_color.red, @flash_color.green, @flash_color.blue, @flash_color.alpha * @flash_duration / @flash_total_duration)
      else
        self.visible = @flash_duration <= 0
      end
    end
    def animation_set_sprites(sprites, cell_data, position)
      sprite = sprites[15]
      pattern = cell_data[15, 0]
      jump = false
      unless sprite && pattern && pattern != -1
        sprite&.visible = false
        jump = true
      end
      x_compensate = 0
      y_compensate = 0
      unless jump
        if position == 3
          if viewport
            self.x = viewport.rect.width / 2
            self.y = viewport.rect.height - 80
          else
            self.x = Graphics.width / 2
            self.y = Graphics.height / 2
          end
        else
          self.x = @_registered_x
          self.y = @_registered_y
        end
        if @_reverse && position == 3
          self.x = 320 - x
          self.y = 220 - y
        end
        if @_reverse
          self.x -= cell_data[15, 1].to_i / 2
          self.y -= cell_data[15, 2].to_i / 2
          x_compensate += cell_data[15, 1].to_i / 2 if position != 3
          y_compensate += cell_data[15, 2].to_i / 2 if position != 3
        else
          self.x += cell_data[15, 1].to_i / 2
          self.y += cell_data[15, 2].to_i / 2
          x_compensate -= cell_data[15, 1].to_i / 2 if position != 3
          y_compensate -= cell_data[15, 2].to_i / 2 if position != 3
        end
        self.zoom = cell_data[15, 3].to_i / 100.0
      end
      15.times do |i|
        sprite = sprites[i]
        pattern = cell_data[i, 0]
        next(sprite&.visible = false) unless sprite && pattern && pattern != -1
        sprite.visible = true
        sprite.src_rect.set(pattern % 5 * 192, pattern / 5 * 192, 192, 192)
        if position == 3
          if viewport
            sprite.x = viewport.rect.width / 2
            sprite.y = viewport.rect.height - 80
          else
            sprite.x = Graphics.width / 2
            sprite.y = Graphics.height / 2
          end
        else
          sprite.x = x - ox + src_rect.width / 2
          sprite.y = y - oy + src_rect.height / 2
          sprite.y -= src_rect.height / 8 if position == 0
          sprite.y += src_rect.height / 8 if position == 2
        end
        if @_reverse && position == 3
          sprite.x = 320 - sprite.x
          sprite.y = 220 - sprite.y
        end
        if @_reverse
          sprite.x -= cell_data[i, 1].to_i / 2 - x_compensate
          sprite.y -= cell_data[i, 2].to_i / 2 - y_compensate
        else
          sprite.x += cell_data[i, 1].to_i / 2 + x_compensate
          sprite.y += cell_data[i, 2].to_i / 2 + y_compensate
        end
        sprite.y -= 24 if position == 3
        sprite.z = 2000
        sprite.ox = 96
        sprite.oy = 96
        sprite.zoom = cell_data[i, 3].to_i / 200.0
        sprite.angle = cell_data[i, 4].to_i
        sprite.angle += 180 if @_option == 1 && @_reverse
        sprite.mirror = (cell_data[i, 5] == 1)
        sprite.mirror = (sprite.mirror == false) if @_option == 2 && @_reverse
        sprite.opacity = cell_data[i, 6].to_i * opacity / 255.0
        sprite.shader.blend_type = cell_data[i, 7].to_i
      end
    end
  end
end
# noyard
module PSP
  module_function
  def make_sprite(viewport = nil)
    @main_sprite = ::RPG::Sprite.new(viewport)
  end
  def dispose_sprite
    return unless @main_sprite
    @main_sprite.dispose
    @main_sprite = nil
  end
  def animation(src_sprite, id, reverse = false)
    (sp = @main_sprite).x = src_sprite.x
    sp.x += Graphics.width / 2 if $scene.is_a?(Battle::Scene) && $scene.visual.is_a?(Battle::Visual3D)
    sp.y = src_sprite.y
    sp.y += Graphics.height / 2 if $scene.is_a?(Battle::Scene) && $scene.visual.is_a?(Battle::Visual3D)
    sp.z = src_sprite.z
    sp.ox = src_sprite.ox
    sp.oy = src_sprite.oy
    sp.bitmap = src_sprite.bitmap
    sp.zoom_x = sp.zoom_y = src_sprite.zoom_x
    sp.shader = src_sprite.shader unless $scene.is_a?(Battle::Scene) && $scene.visual.is_a?(Battle::Visual3D)
    visible = src_sprite.visible
    sp.opacity = src_sprite.opacity
    src_sprite.visible = false
    animation = $data_animations[id]
    if animation
      sp.register_position
      sp.animation(animation, true, reverse)
      while sp.effect?
        sp.update
        sp.viewport.need_to_sort = true
        sp.viewport.sort_z
        Graphics.update
        Graphics.update while Graphics::FPSBalancer.global.skipping?
      end
      sp.reset_position
      sp.update
      Graphics.update
    end
    sp&.viewport&.color&.set(0, 0, 0, 0)
    src_sprite.visible = visible
    sp.bitmap = nil
    sp.shader = nil
  end
  def move_animation(usr_sprite, trg_sprite, move_id, reverse = false)
    id = MOVE_TO_ID_ANIMATION_USER[move_id]
    animation(usr_sprite, id, reverse) if id
    id = MOVE_TO_ID_ANIMATION_TARGET[move_id]
    animation(trg_sprite, id, reverse) if id
  end
  MOVE_TO_ID_ANIMATION_TARGET = load_data('Data/PSP_MTAT.dat')
  MOVE_TO_ID_ANIMATION_USER = load_data('Data/PSP_MTAU.dat')
end
