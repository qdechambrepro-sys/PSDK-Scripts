module RPG
  class Sprite
    SHADER = "uniform sampler2D texture;\nuniform float hue;\n\n// Source: https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786\nvec3 hueShift( vec3 color, float hueAdjust ) {\n\n  const vec3  kRGBToYPrime = vec3 (0.299, 0.587, 0.114);\n  const vec3  kRGBToI      = vec3 (0.596, -0.275, -0.321);\n  const vec3  kRGBToQ      = vec3 (0.212, -0.523, 0.311);\n\n  const vec3  kYIQToR     = vec3 (1.0, 0.956, 0.621);\n  const vec3  kYIQToG     = vec3 (1.0, -0.272, -0.647);\n  const vec3  kYIQToB     = vec3 (1.0, -1.107, 1.704);\n\n  float   YPrime  = dot (color, kRGBToYPrime);\n  float   I       = dot (color, kRGBToI);\n  float   Q       = dot (color, kRGBToQ);\n  float   hue     = atan (Q, I);\n  float   chroma  = sqrt (I * I + Q * Q);\n\n  hue += hueAdjust;\n\n  Q = chroma * sin (hue);\n  I = chroma * cos (hue);\n\n  vec3    yIQ   = vec3 (YPrime, I, Q);\n\n  return vec3( dot (yIQ, kYIQToR), dot (yIQ, kYIQToG), dot (yIQ, kYIQToB) );\n}\n\nvoid main() {\n  vec4 color = texture2D(texture, gl_TexCoord[0].xy);\n  color.rgb = hueShift(color.rgb, hue);\n  gl_FragColor = color * gl_Color;\n}\n"
    @@_animations = []
    @@_reference_count = {}
    def initialize(viewport = nil)
    end
    def flash(color, duration)
    end
    def color
    end
    def register_position
    end
    def reset_position
    end
    def dispose_animation
    end
    def dispose_loop_animation
    end
    def animation(animation, hit, reverse = false)
    end
    def update
    end
    def handle_flash
    end
    def animation_set_sprites(sprites, cell_data, position)
    end
  end
end
# noyard
module PSP
  module_function
  def make_sprite(viewport = nil)
  end
  def dispose_sprite
  end
  def animation(src_sprite, id, reverse = false)
  end
  def move_animation(usr_sprite, trg_sprite, move_id, reverse = false)
  end
  MOVE_TO_ID_ANIMATION_TARGET = load_data('Data/PSP_MTAT.dat')
  MOVE_TO_ID_ANIMATION_USER = load_data('Data/PSP_MTAU.dat')
end
