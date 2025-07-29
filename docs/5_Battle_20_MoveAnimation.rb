module Battle
  # Module responsive of handling all move animation
  #
  # All animation will have the following values in their resolver:
  #   - :visual => Battle::Visual object
  #   - :user => BattleUI::PokemonSprite of the user of the move
  #   - :target => BattleUI::PokemonSprite of the target of the move (first if user animation, current if target animation)
  #   - :viewport => Viewport of the user sprite
  module MoveAnimation
    @specific_move_animations = {}
    @generic_move_animations = {}
    module_function
    # Function that store a specific move animation
    # @param move_db_symbol [Symbol]
    # @param animation_reason [Symbol]
    # @param animation_user [Yuki::Animation::TimedAnimation] unstarted animation of user that will be serialized
    # @param animation_target [Yuki::Animation::TimedAnimation] unstarted animation of target that will be serialized
    def register_specific_animation(move_db_symbol, animation_reason, animation_user, animation_target)
    end
    # Function that stores a generic move animation
    # @param move_kind [Integer] 1 = physical, 2 = special, 3 = status
    # @param move_type [Integer] type of the move
    # @param animation_user [Yuki::Animation::TimedAnimation] unstarted animation of user that will be serialized
    # @param animation_target [Yuki::Animation::TimedAnimation] unstarted animation of target that will be serialized
    def register_generic_animation(move_kind, move_type, animation_user, animation_target)
    end
    # Function that retreives the animation for the user & the target depending on the condition
    # @param move [Battle::Move] move used
    # @param animation_reason [Array<Symbol>] reason of the animation (in order you want it, you'll get the first that got resolved)
    # @return [Array<Yuki::Animation::TimedAnimation>, nil] animation on user, animation on target
    def get(move, *animation_reason)
    end
    # Function that plays an animation
    # @param animations [Array<Yuki::Animation::TimedAnimation>]
    # @param visual [Battle::Visual]
    # @param user [PFM::PokemonBattler] user of the move
    # @param targets [Array<PFM::PokemonBattler>] expected targets
    def play(animations, visual, user, targets)
    end
  end
end
## Module allowing the animation to chose the bank of the user in case of differences
module Yuki
  module Animation
    class UserBankRelativeAnimation < Command
      def initialize
      end
      def play_before_on_bank(bank, other)
      end
      def play_parallel_on_bank(bank, other)
      end
      def start(begin_offset = 0)
      end
    end
    module_function
    # Animation camera movement
    # @param target [Symbol] target of the camera movement
    # @param duration [Float] duration of the camera movement
    def camera_move_animation(target = :target, duration = 0.4)
    end
    # Animation Recenter movement
    def camera_reset_position
    end
    public
    module_function
    # Combine multiple animations into one
    # @param animations [Array<TimedAnimation>] animations to combine
    # @param time_global [Float] global time of the animation
    def combine_animation(animations, time_global)
    end
    # Combine an animation with a sound
    # @param sound [String] sound to play
    # @param animations [Array<TimedAnimation>] animations to combine
    # @param time_global [Float] global time of the animation
    def combine_animation_with_sound(sound, animations, time_global)
    end
    # Combine multiple animations into one with play_before
    # @param animations [Array<TimedAnimation>] animations to combine in play_before
    def combine_before_animation(animations)
    end
    # Combine multiple animations into one with play_before with a sound
    # @param sound [String] sound to play
    # @param animations [Array<TimedAnimation>] animations to combine in play_before
    def combine_before_animation_with_sound(sound, animations)
    end
    public
    module_function
    class CompressAnimation < TimedAnimation
      # Create a new CompressAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param a [Integer] value in x retrieved to the sprite_zoom
      # @param b [Integer] value in y retrieved to the sprite_zoom
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, a, b, distortion: :SQUARE010_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    # Create a new CompressAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param a [Integer] value in x retrieved to the sprite_zoom
    # @param b [Integer] value in y retrieved to the sprite_zoom
    # @param iteration [#call, Integer] number of iteration of the animation
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [CompressAnimation]
    def compress(time_to_process, on, a, b, iteration: 1, distortion: :SQUARE010_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    class MoveParticleAnimation < TimedAnimation
      # Create a new MoveParticleAnimation
      # @note Create an animation between two sprites, an offset will be randomly choose for each coordinates depending of the proportion parameters,
      # if 0, it will stay on the origin, at 1 it can placed everywhere on the sprite
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param particle [Sprite, Sprite3D] sprite that will be moved
      # @param from [PokemonSprite, PokemonSprite3D] based on which Sprite it will start
      # @param to [PokemonSprite, PokemonSprite3D] on which Sprite it will go
      # @param proportion_x [Float] proportion of the sprite width that will cover (by default 1)
      # @param proportion_y [Float] proportion of the sprite height that will cover (by default 1)
      # @param use_zoom [Boolean] is the zoom difference used (by default false)
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, particle, from, to, proportion_x = 1, proportion_y = 1, use_zoom: false, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    class MoveParticleOffsetAnimation < TimedAnimation
      # Create a new MoveParticleOffsetAnimation
      # @note Create an animation between two sprites with the possibility to apply an offset in both coordinates between the sprites
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param particle [Sprite, Sprite3D] sprite that will be moved
      # @param from [PokemonSprite, PokemonSprite3D] based on which Sprite it will start
      # @param to [PokemonSprite, PokemonSprite3D] on which Sprite it will go
      # @param offset_x [Integer] offset on x
      # @param offset_y [Integer] offset on y
      # @param from_center [Boolean] is the origin from the center of the sprite (by default false)
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, particle, from, to, offset_x, offset_y, from_center: false, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    # Create a new MoveParticleAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be moved
    # @param from [PokemonSprite, PokemonSprite3D] based on which Sprite it will start
    # @param to [PokemonSprite, PokemonSprite3D] on which Sprite it will go
    # @param proportion_x [Float] proportion of the sprite width that will cover (by default 1)
    # @param proportion_y [Float] proportion of the sprite height that will cover (by default 1)
    # @param use_zoom [Boolean] is the zoom difference used (by default false)
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [MoveParticleAnimation]
    def particle_move_to_sprite(time_to_process, particle, from, to, proportion_x = 1, proportion_y = 1, use_zoom: false, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new MoveParticleOffsetAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be moved
    # @param from [PokemonSprite, PokemonSprite3D] based on which Sprite it will start
    # @param to [PokemonSprite, PokemonSprite3D] on which Sprite it will go
    # @param offset_x [Integer] offset on x
    # @param offset_y [Integer] offset on y
    # @param from_center [Boolean] is the origin from the center of the sprite (by default false)
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [MoveParticleOffsetAnimation]
    def particle_move_to_sprite_offset(time_to_process, particle, from, to, offset_x = 0, offset_y = 0, from_center: false, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    class ParticleOnSpriteAnimation < TimedAnimation
      # Create a new ParticleOnSpriteAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param particle [Sprite, Sprite3D] sprite that will be placed
      # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
      # @param proportion_x [Float] proportion of the sprite width that will cover (by default 1)
      # @param proportion_y [Float] proportion of the sprite height that will cover (by default 1)
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, particle, on, proportion_x = 1, proportion_y = 1, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    # Place a particle on a sprite with an offset
    class ParticleOnSpriteOffset < Command
      # Create a new ParticleOnSpriteOffset
      # @param particle [Sprite, Sprite3D] sprite that will be placed
      # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
      # @param offset_x [Integer] (by default 0)
      # @param offset_y [Integer] (by default 0)
      def initialize(particle, on, offset_x = 0, offset_y = 0)
      end
      private
      # Execute the placement of the particle on the sprite with the offset
      def update_internal
      end
    end
    # Place a particle on a sprite with an offset
    class ParticleOnSpriteRandom < Command
      # Create a new ParticleOnSpriteRandom
      # @param particle [Sprite, Sprite3D] sprite that will be placed
      # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
      # @param proportion_x [Float] proportion of the sprite width that will cover (by default 1)
      # @param proportion_y [Float] proportion of the sprite height that will cover (by default 1)
      def initialize(particle, on, proportion_x = 1, proportion_y = 1)
      end
      private
      # Execute the placement of the particle on the sprite with the offset
      def update_internal
      end
    end
    class MoveParticleOnSprite < TimedAnimation
      # Create a new MoveParticleOnSprite
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param particle [Sprite, Sprite3D] sprite that will moved
      # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will navigate
      # @param start_x [Integer]
      # @param start_y [Integer]
      # @param final_x [Integer]
      # @param final_y [Integer]
      # @param use_zoom [Boolean] use zoom of the sprite (by default true)
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, particle, on, start_x, start_y, final_x, final_y, use_zoom: true, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    # Create a new MoveParticleOnSprite
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will moved
    # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will navigate
    # @param start_x [Integer]
    # @param start_y [Integer]
    # @param final_x [Integer]
    # @param final_y [Integer]
    # @param use_zoom [Boolean] use zoom of the sprite (by default true)
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [MoveParticleOnSprite]
    def move_particle_on_sprite(time_to_process, particle, on, start_x, start_y, final_x, final_y, use_zoom: true, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new ParticleOnSpriteOffset
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
    # @param offset_x [Integer] (by default 0)
    # @param offset_y [Integer] (by default 0)
    # @return [ParticleOnSpriteOffset]
    def particle_on_sprite_command(particle, on, offset_x = 0, offset_y = 0)
    end
    # Create a new ParticleOnSpriteRandom
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
    # @param proportion_x [Integer] (by default 1)
    # @param proportion_y [Integer] (by default 1)
    # @return [ParticleOnSpriteRandom]
    def particle_random_sprite_command(particle, on, proportion_x = 1, proportion_y = 1)
    end
    # Create a new ParticleOnSpriteAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] based on which Sprite dimension it will be placed
    # @param proportion_x [Float] proportion of the sprite width that will cover (by default 1)
    # @param proportion_y [Float] proportion of the sprite height that will cover (by default 1)
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [ParticleOnSpriteAnimation]
    def particle_on_sprite(time_to_process, particle, on, proportion_x = 1, proportion_y = 1, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    class ParticleZoomAnimation < TimedAnimation
      # Create a new ParticleZoomAnimation
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param particle [Sprite, Sprite3D] sprite that will be placed
      # @param on [PokemonSprite, PokemonSprite3D] Sprite from which the zoom will be based
      # @param a [Float] zoom_start
      # @param b [Float] zoom_final
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      #   converting it to another number (between 0 & 1) to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, particle, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
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
    class ParticleZoomXAnimation < ParticleZoomAnimation
      # Method you should always overwrite in order to perform the right animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    class ParticleZoomYAnimation < ParticleZoomAnimation
      # Method you should always overwrite in order to perform the right animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a new ParticleZoomAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] Sprite from which the zoom will be based
    # @param a [Float] zoom_start
    # @param b [Float] zoom_final
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def particle_zoom(time_to_process, particle, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new ParticleZoomXAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] Sprite from which the zoom will be based
    # @param a [Float] zoom_start
    # @param b [Float] zoom_final
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def particle_zoom_x(time_to_process, particle, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a new ParticleZoomYAnimation
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param particle [Sprite, Sprite3D] sprite that will be placed
    # @param on [PokemonSprite, PokemonSprite3D] Sprite from which the zoom will be based
    # @param a [Float] zoom_start
    # @param b [Float] zoom_final
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    #   converting it to another number (between 0 & 1) to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    def particle_zoom_y(time_to_process, particle, on, a, b, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    public
    module_function
    class ScalarXFromSprite < TimedAnimation
      # Create a new ScalarXFromSprite
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param sprite [Object] on which the origin will be based on
      # @param start_x [Integer] start_x
      # @param offset_x [Integer] offset_x
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, sprite, start_x, offset_x, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    class ScalarYFromSprite < TimedAnimation
      # Create a new ScalarYFromSprite
      # @param time_to_process [Float] number of seconds (with generic time) to process the animation
      # @param on [Object] object that will receive the property
      # @param sprite [Object] on which the origin will be based on
      # @param start_y [Integer] start_y
      # @param offset_y [Integer] offset_y
      # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
      # convert it to another number (between 0 & 1) in order to distort time
      # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
      def initialize(time_to_process, on, sprite, start_y, offset_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
      end
      # Start the animation (initialize it)
      # @param begin_offset [Float] offset that prevents the animation from starting before now + begin_offset seconds
      def start(begin_offset = 0)
      end
      # Update the scalar animation
      # @param time_factor [Float] number between 0 & 1 indicating the progression of the animation
      def update_internal(time_factor)
      end
    end
    # Create a scalar animation on the x property of an element, linked to a sprite for the original position
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param sprite [Object] on which the origin will be based on
    # @param start_x [Integer] start_x
    # @param offset_x [Integer] offset_x
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [ScalarXFromSprite]
    def scalar_x_from_sprite(time_to_process, on, sprite, start_x, offset_x, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
    # Create a scalar animation on the y property of an element, linked to a sprite for the original position
    # @param time_to_process [Float] number of seconds (with generic time) to process the animation
    # @param on [Object] object that will receive the property
    # @param sprite [Object] on which the origin will be based on
    # @param start_y [Integer] start_y
    # @param offset_y [Integer] offset_y
    # @param distortion [#call, Symbol] callable taking one parameter (between 0 & 1) and
    # convert it to another number (between 0 & 1) in order to distort time
    # @param time_source [#call, Symbol] callable taking no parameter and giving the current time
    # @return [ScalarYFromSprite]
    def scalar_y_from_sprite(time_to_process, on, sprite, start_y, offset_y, distortion: :UNICITY_DISTORTION, time_source: :SCENE_TIME_SOURCE)
    end
  end
end
module Fake3DCreateSpriteFallback
  def update_internal
  end
end
Yuki::Animation::SpriteCreationCommand.prepend(Fake3DCreateSpriteFallback)
ya = Yuki::Animation
animation_target = ya.wait(0.1)
animation_user = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'acid_armor', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 1], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_user.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :user, :user))
main_t_anim.play_before(ya.se_play('moves/acid_armor'))
main_t_anim.play_before(ya.wait(0.1))
8.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, (i % 4) * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.12))
end
animation_user.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:acid_armor, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'acrobatics', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 0.5], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/acrobatics'))
main_t_anim.play_before(ya.wait(0.2))
3.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.1))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:acrobatics, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'aerial_ace', :animation], [:set_rect, 0, 0, 208, 192], [:zoom=, 0.75], [:set_origin, 104, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/aerial_ace'))
main_t_anim.play_before(ya.wait(0.1))
13.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 208, 0, 208, 192))
  main_t_anim.play_before(ya.wait(0.055))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:aerial_ace, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'air_slash', :animation], [:set_rect, 0, 0, 208, 192], [:zoom=, 0.75], [:set_origin, 104, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/air_slash'))
main_t_anim.play_before(ya.wait(0.1))
7.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 208, 0, 208, 192))
  main_t_anim.play_before(ya.wait(0.055))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:air_slash, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_target = ya.wait(0.1)
animation_user = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'aqua_ring', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 0.75], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_user.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :user, :user))
main_t_anim.play_before(ya.se_play('moves/aqua_ring'))
main_t_anim.play_before(ya.wait(0.1))
9.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, (i % 3) * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.15))
end
animation_user.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:aqua_ring, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'aqua_tail', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 1], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/aqua_tail'))
main_t_anim.play_before(ya.wait(0.1))
3.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.065))
end
4.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 312 + (i * 104), 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.075))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:aqua_tail, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'assurance', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 1], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/assurance'))
main_t_anim.play_before(ya.wait(0.1))
4.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.15))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:assurance, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'astonish', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 1], [:set_origin, 52, 132])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/astonish'))
main_t_anim.play_before(ya.wait(0.1))
main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 0, 0, 104, 192))
main_t_anim.play_before(ya.wait(0.085))
main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 104, 0, 104, 192))
main_t_anim.play_before(ya.wait(0.15))
3.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 208 + (i * 104), 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.085))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:astonish, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'avalanche', :animation], [:set_rect, 0, 0, 104, 192], [:zoom=, 1.25], [:set_origin, 52, 110])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/avalanche'))
main_t_anim.play_before(ya.wait(0.1))
19.times do |i|
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, i * 104, 0, 104, 192))
  main_t_anim.play_before(ya.wait(0.1))
end
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:avalanche, :first_use, animation_user, animation_target)
ya = Yuki::Animation
all_animations = []
setup_animation = Yuki::Animation::UserBankRelativeAnimation.new
setup_animation.play_before_on_bank(0, ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'hand-front-left', :animation], [:set_rect, 0, 0, 32, 32], [:zoom=, 1], [:opacity=, 0], [:set_origin, 16, 32]))
setup_animation.play_before_on_bank(1, ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'hand-front-right', :animation], [:set_rect, 0, 0, 32, 32], [:zoom=, 2], [:opacity=, 0], [:set_origin, 16, 32]))
all_animations << setup_animation
fall_animation = ya.resolved
fall_animation.play_before(ya.falling_animation(1, :sprite, :target, 200))
all_animations << fall_animation
sprite_animation = ya.resolved
sprite_animation.play_before(ya.send_command_to(:sprite, :opacity=, 200))
sprite_animation.play_before(ya.wait(0.2))
sprite_animation.play_before(ya.send_command_to(:sprite, :set_rect, 0, 32, 32, 32))
sprite_animation.play_before(ya.wait(0.2))
sprite_animation.play_before(ya.send_command_to(:sprite, :opacity=, 230))
sprite_animation.play_before(ya.send_command_to(:sprite, :set_rect, 0, 0, 32, 32))
sprite_animation.play_before(ya.wait(0.3))
sprite_animation.play_before(ya.opacity_change(0.3, :sprite, 230, 0))
all_animations << sprite_animation
deformation_animation = ya.resolved
deformation_animation.play_before(ya.wait(0.1))
deformation_animation.play_before(ya.compress(0.3, :target, 0.2, -0.6))
all_animations << deformation_animation
all_particles_animation = ya.wait(0.6)
20.times do |i|
  sprite_symbol = :"sprite_#{i}"
  particle_animation = ya.create_sprite(:viewport, sprite_symbol, Sprite, nil, [:load, 'circle_particle', :animation], [:opacity=, 0], [:set_origin, 8, 8])
  particle_anim_resolved = ya.resolved
  particle_animation.play_before(particle_anim_resolved)
  particle_animation.play_before(ya.wait(0.2))
  particle_animation.play_before(ya.send_command_to(sprite_symbol, :opacity=, 255))
  radial_animation = ya.radius_move(0.5, sprite_symbol, :target, 60)
  radial_animation.parallel_add(ya.tone_animation(0.5, sprite_symbol, [1, 0.65, 0, 1]))
  radial_animation.parallel_add(ya.scalar(0.5, sprite_symbol, :zoom=, 1, 0))
  particle_animation.play_before(radial_animation)
  particle_animation.play_before(ya.dispose_sprite(sprite_symbol))
  all_particles_animation.parallel_add(particle_animation)
end
all_animations << all_particles_animation
animation_user = ya.camera_move_animation
animation_user.play_before(ya.combine_animation_with_sound('moves/karate-chop', all_animations, 1.1))
animation_user.play_before(ya.dispose_sprite(:sprite))
animation_user.play_before(ya.camera_reset_position)
Battle::MoveAnimation.register_specific_animation(:karate_chop, :first_use, animation_user, ya.wait(0))
ya = Yuki::Animation
animation_target = ya.wait(0)
animation_user = ya.se_play('moves/leech-seed-1')
animation_user.play_before(ya.wait(0.8))
animation_user.play_before(ya.send_command_to(:target, :center_camera))
animation_user.play_before(ya.wait(1.5))
animation_user.play_before(ya.send_command_to(:visual, :start_center_animation))
seed_throw_animation = ya.wait(0.7)
4.times do |i|
  seed_symbol = :"seed_#{i}"
  seed_animation = ya.create_sprite(:viewport, seed_symbol, Sprite, nil, [:load, 'seed', :animation], [:opacity=, 255], [:zoom=, 0], [:set_origin, 16, 16])
  seed_animation_resolved = ya.resolved
  seed_animation.play_before(seed_animation_resolved)
  seed_animation_resolved.play_before(ya.wait(0.2 * i))
  seed_animation_resolved.play_before(ya.particle_random_sprite_command(seed_symbol, :user, 0, 0))
  zoom_animation = ya.particle_zoom_x(0.5, seed_symbol, :target, 0, 0.7)
  zoom_animation.parallel_add(ya.particle_zoom_y(0.5, seed_symbol, :target, 0, 1))
  zoom_animation.play_before(ya.particle_zoom_x(0.2, seed_symbol, :target, 0.7, 0).parallel_add(ya.particle_zoom_y(0.2, seed_symbol, :target, 1, 0)))
  rotation_animation = ya.rotation(0.8, seed_symbol, 0, 1440)
  combined_animation = ya.wait(0.5)
  combined_animation.parallel_add(zoom_animation)
  combined_animation.parallel_add(rotation_animation)
  combined_animation.parallel_add(ya.particle_move_to_sprite(0.7, seed_symbol, :user, :target, 0, 0))
  combined_animation.parallel_add(ya.scalar_offset(0.7, seed_symbol, :y, :y=, 20, -64, distortion: :SQUARE010_DISTORTION))
  seed_animation_resolved.play_before(combined_animation)
  seed_animation.play_before(ya.dispose_sprite(seed_symbol))
  seed_throw_animation.parallel_add(seed_animation)
end
position_array = [[0, 0], [-21, -3], [21, 3]]
seeds_growth_animations = ya.wait(1.5)
3.times do |i|
  growth_symbol = "growth_#{i}".to_sym
  growth_animation = ya.create_sprite(:viewport, growth_symbol, Sprite, nil, [:load, 'seed-growth', :animation], [:opacity=, 255], [:zoom=, 0], [:set_origin, 16, 32], [:set_rect, 0, 0, 32, 32])
  growth_animation_resolved = ya.resolved
  growth_animation.play_before(ya.wait(0.6))
  growth_animation.play_before(growth_animation_resolved)
  growth_animation_resolved.play_before(ya.particle_on_sprite_command(growth_symbol, :target, *position_array[i]))
  growth_animation_resolved.play_before(ya.tone_animation(0, growth_symbol, [0.08, 0.94, 0.05, 0.83]))
  growth_animation_resolved.play_before(ya.wait(0.1 * i))
  growth_animation_resolved.play_before(ya.particle_zoom(0, growth_symbol, :target, 0, 1))
  5.times do |j|
    growth_animation_resolved.play_before(ya.wait(0.05))
    growth_animation_resolved.play_before(ya.send_command_to(growth_symbol, :set_rect, 32 * j, 0, 32, 32))
  end
  growth_animation_resolved.play_before(ya.wait(0.2))
  growth_animation_resolved.play_before(ya.opacity_change(0.3, growth_symbol, 255, 0))
  growth_animation.play_before(ya.dispose_sprite(growth_symbol))
  seeds_growth_animations.parallel_add(growth_animation)
end
animation_target.play_before(seeds_growth_animations.parallel_add(seed_throw_animation))
Battle::MoveAnimation.register_specific_animation(:leech_seed, :first_use, animation_user, animation_target)
ya = Yuki::Animation
all_animations = []
camera_move_animation = ya.camera_move_animation(:target)
camera_move_animation.play_before(ya.se_play('moves/poison-powder'))
all_animations << camera_move_animation
animation = ya.wait(1.5)
20.times do |i|
  particle_symbol = :"particle_#{i}"
  parallel_animation = ya.create_sprite(:viewport, particle_symbol, Sprite, nil, [:load, 'Circle-blurry-M-2', :animation], [:opacity=, 255], [:zoom=, 0], [:set_origin, 16, 16])
  animation_resolved = ya.resolved
  parallel_animation.play_before(animation_resolved)
  animation_resolved.play_before(ya.tone_animation(0, particle_symbol, [0.78, 0.26, 0.93, 0.83]))
  animation_resolved.play_before(ya.wait(0.2 * i / 5))
  animation_resolved.play_before(ya.particle_zoom(0, particle_symbol, :target, 0, 0.5))
  opacity_animation = ya.wait(0.8)
  opacity_animation.play_before(ya.opacity_change(0.3, particle_symbol, 255, 0))
  move_animation = ya.scalar_x_from_sprite(1.2, particle_symbol, :target, 0, 15, distortion: :"POWDER_#{i % 5 + 1}")
  move_animation.parallel_add(ya.falling_animation(1.2, particle_symbol, :target, 80, distortion: :UNICITY_DISTORTION))
  move_animation.parallel_add(ya.particle_zoom(1.2, particle_symbol, :target, 0.7, 0.3, distortion: :POSITIVE_OSCILLATING_16))
  move_animation.parallel_add(opacity_animation)
  animation_resolved.play_before(move_animation)
  parallel_animation.play_before(ya.dispose_sprite(particle_symbol))
  animation.parallel_add(parallel_animation)
end
pokemon_animation = ya.resolved
pokemon_animation.play_before(ya.wait(0.5))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, true))
pokemon_animation.play_before(ya.send_command_to(:target, :set_tone_to, 0.78, 0.26, 0.93, 0.6))
pokemon_animation.play_before(ya.compress(0.15, :target, -0.2, 0.2, iteration: 5))
pokemon_animation.play_before(ya.send_command_to(:target, :reset_tone_status))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, false))
animation.parallel_add(pokemon_animation)
all_animations << animation
camera_reset_position = ya.camera_reset_position
all_animations << camera_reset_position
animation_target = ya.combine_before_animation(all_animations)
Battle::MoveAnimation.register_specific_animation(:poison_powder, :first_use, ya.wait(0), animation_target)
ya = Yuki::Animation
all_animations = []
camera_move_animation = ya.camera_move_animation(:target)
camera_move_animation.play_before(ya.se_play('moves/sleep-powder'))
all_animations << camera_move_animation
animation = ya.wait(1.5)
20.times do |i|
  particle_symbol = :"particle_#{i}"
  parallel_animation = ya.create_sprite(:viewport, particle_symbol, Sprite, nil, [:load, 'Circle-blurry-M-2', :animation], [:opacity=, 255], [:zoom=, 0], [:set_origin, 16, 16])
  animation_resolved = ya.resolved
  parallel_animation.play_before(animation_resolved)
  animation_resolved.play_before(ya.tone_animation(0, particle_symbol, [0, 0.94, 0.58, 0.83]))
  animation_resolved.play_before(ya.wait(0.2 * i / 5))
  animation_resolved.play_before(ya.particle_zoom(0, particle_symbol, :target, 0, 0.5))
  opacity_animation = ya.wait(0.8)
  opacity_animation.play_before(ya.opacity_change(0.3, particle_symbol, 255, 0))
  move_animation = ya.scalar_x_from_sprite(1.2, particle_symbol, :target, 0, 15, distortion: :"POWDER_#{i % 5 + 1}")
  move_animation.parallel_add(ya.falling_animation(1.2, particle_symbol, :target, 80, distortion: :UNICITY_DISTORTION))
  move_animation.parallel_add(ya.particle_zoom(1.2, particle_symbol, :target, 0.7, 0.3, distortion: :POSITIVE_OSCILLATING_16))
  move_animation.parallel_add(opacity_animation)
  animation_resolved.play_before(move_animation)
  parallel_animation.play_before(ya.dispose_sprite(particle_symbol))
  animation.parallel_add(parallel_animation)
end
pokemon_animation = ya.resolved
pokemon_animation.play_before(ya.wait(0.5))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, true))
pokemon_animation.play_before(ya.send_command_to(:target, :set_tone_to, 0, 0.94, 0.58, 0.6))
pokemon_animation.play_before(ya.compress(0.15, :target, -0.2, 0.2, iteration: 5))
pokemon_animation.play_before(ya.send_command_to(:target, :reset_tone_status))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, false))
animation.parallel_add(pokemon_animation)
all_animations << animation
camera_reset_position = ya.camera_reset_position
all_animations << camera_reset_position
animation_target = ya.combine_before_animation(all_animations)
Battle::MoveAnimation.register_specific_animation(:sleep_powder, :first_use, ya.wait(0), animation_target)
ya = Yuki::Animation
all_animations = []
camera_move_animation = ya.camera_move_animation(:target)
camera_move_animation.play_before(ya.se_play('moves/stun-spore'))
all_animations << camera_move_animation
animation = ya.wait(1.5)
20.times do |i|
  particle_symbol = :"particle_#{i}"
  parallel_animation = ya.create_sprite(:viewport, particle_symbol, Sprite, nil, [:load, 'Circle-blurry-M-2', :animation], [:opacity=, 255], [:zoom=, 0], [:set_origin, 16, 16])
  animation_resolved = ya.resolved
  parallel_animation.play_before(animation_resolved)
  animation_resolved.play_before(ya.tone_animation(0, particle_symbol, [0.97, 0.91, 0.08, 0.83]))
  animation_resolved.play_before(ya.wait(0.2 * i / 5))
  animation_resolved.play_before(ya.particle_zoom(0, particle_symbol, :target, 0, 0.5))
  opacity_animation = ya.wait(0.8)
  opacity_animation.play_before(ya.opacity_change(0.3, particle_symbol, 255, 0))
  move_animation = ya.scalar_x_from_sprite(1.2, particle_symbol, :target, 0, 15, distortion: :"POWDER_#{i % 5 + 1}")
  move_animation.parallel_add(ya.falling_animation(1.2, particle_symbol, :target, 80, distortion: :UNICITY_DISTORTION))
  move_animation.parallel_add(ya.particle_zoom(1.2, particle_symbol, :target, 0.7, 0.3, distortion: :POSITIVE_OSCILLATING_16))
  move_animation.parallel_add(opacity_animation)
  animation_resolved.play_before(move_animation)
  parallel_animation.play_before(ya.dispose_sprite(particle_symbol))
  animation.parallel_add(parallel_animation)
end
pokemon_animation = ya.resolved
pokemon_animation.play_before(ya.wait(0.5))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, true))
pokemon_animation.play_before(ya.send_command_to(:target, :set_tone_to, 0.97, 0.91, 0.08, 0.6))
pokemon_animation.play_before(ya.compress(0.15, :target, -0.2, 0.2, iteration: 5))
pokemon_animation.play_before(ya.send_command_to(:target, :reset_tone_status))
pokemon_animation.play_before(ya.send_command_to(:target, :stop_gif_animation=, false))
animation.parallel_add(pokemon_animation)
all_animations << animation
camera_reset_position = ya.camera_reset_position
all_animations << camera_reset_position
animation_target = ya.combine_before_animation(all_animations)
Battle::MoveAnimation.register_specific_animation(:stun_spore, :first_use, ya.wait(0), animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0)
following_anim = Yuki::Animation::UserBankRelativeAnimation.new
following_anim.play_before_on_bank(0, ya.ellipse(1.5, :user, 18, 9, turn: 2))
following_anim.play_before_on_bank(1, ya.ellipse(1.5, :user, 11, -5, turn: 2))
animation_user.play_before(following_anim)
animation_target = ya.se_play('moves/tail_whip')
Battle::MoveAnimation.register_specific_animation(:tail_whip, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, '017-Thunder02', :animation], [:set_rect, 0, 0, 192, 192], [:zoom=, 0.5], [:set_origin, 96, 192])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/thunder_wave'))
main_t_anim.play_before(ya.send_command_to(:sprite, :z=, 1))
5.times do
  main_t_anim.play_before(ya.wait(0.05))
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 192, 0, 192, 192))
  main_t_anim.play_before(ya.wait(0.05))
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 0, 0, 192, 192))
end
main_t_anim.play_before(ya.wait(0.05))
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:thunder_wave, :first_use, animation_user, animation_target)
ya = Yuki::Animation
animation_user = ya.wait(0.05)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, 'vine-whip', :animation], [:set_rect, 0, 0, 200, 200], [:zoom=, 1], [:set_origin, 100, 100])
main_t_anim = ya.resolved
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/vine_whip'))
main_t_anim.play_before(ya.send_command_to(:sprite, :z=, 1))
8.times do |i|
  7.times do |j|
    main_t_anim.play_before(ya.wait(0.015))
    main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 200 * j, 200 * i, 200, 200))
  end
end
main_t_anim.play_before(ya.wait(0.05))
animation_target.play_before(main_t_anim)
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:vine_whip, :first_use, animation_user, animation_target)
