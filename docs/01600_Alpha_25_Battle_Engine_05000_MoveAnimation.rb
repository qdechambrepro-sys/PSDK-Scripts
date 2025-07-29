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
ya = Yuki::Animation
animation_user = ya.wait(0.1)
animation_target = ya.create_sprite(:viewport, :sprite, Sprite, nil, [:load, '017-Thunder02', :animation], [:set_rect, 0, 0, 192, 192], [:zoom=, 0.5], [:set_origin, 96, 192])
main_t_anim = ya.resolved
animation_target.play_before(main_t_anim)
main_t_anim.play_before(ya.move_sprite_position(0, :sprite, :target, :target))
main_t_anim.play_before(ya.se_play('moves/thunder_wave'))
5.times do
  main_t_anim.play_before(ya.wait(0.05))
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 192, 0, 192, 192))
  main_t_anim.play_before(ya.wait(0.05))
  main_t_anim.play_before(ya.send_command_to(:sprite, :set_rect, 0, 0, 192, 192))
end
main_t_anim.play_before(ya.wait(0.05))
animation_target.play_before(ya.dispose_sprite(:sprite))
Battle::MoveAnimation.register_specific_animation(:thunder_wave, :first_use, animation_user, animation_target)
