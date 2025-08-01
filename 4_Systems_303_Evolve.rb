module GamePlay
  # Module defining the IO of the evolve scene so user know what to expect
  module EvolveMixin
    # Tell if the Pokemon evolved
    # @return [Boolean]
    attr_accessor :evolved
  end
  # Evolve scene
  class Evolve < BaseCleanUpdate::FrameBalanced
    include EvolveMixin
    # Constant telling if you have gifs or not during the scene
    ENABLE_GIF = true
    # Path of the music of the pokemon in evolution
    EVOLVE_MUSIC = 'audio/bgm/pkmrs-evolving'
    # Path of the music of the pokemon in evolved
    EVOLVED_MUSIC = 'audio/bgm/xy_trainer_battle_victory'
    # Counter value for the first step end
    FIRST_STEP = 60
    # Frequency count for the second step to repeat
    SECOND_STEP_FREQUENCY = 60
    # Counter value for the second step end
    SECOND_STEP = FIRST_STEP + (2.5 * SECOND_STEP_FREQUENCY).to_i
    # Counter value for the last step end
    LAST_STEP = SECOND_STEP + 60
    # 2pi value
    PI2 = Math::PI * 2
    # Launch the Pokemon Evolution scene
    # @param pokemon [PFM::Pokemon] the evolving Pokemon
    # @param id [Integer] the ID of the evolution
    # @param form [Integer] the form of the evolution
    # @param forced [Boolean] if the evolution can be stopped or not
    def initialize(pokemon, id, form = nil, forced = false)
      super()
      @pokemon = pokemon
      @clone = pokemon.clone
      @clone.evolve(id, form)
      @forced = forced
      @id_bg = 0
      @evolved = false
      @counter = 0
      memorize_audio
    end
    def update_graphics
      @pokemon_gif&.update(@sprite_pokemon.bitmap)
      @clone_gif&.update(@sprite_clone.bitmap)
      return unless can_display_message_be_called?
      if @counter == 0
        evolution_first_step
      else
        if @counter >= LAST_STEP
          evolution_last_step
          update_message
          @pokemon.evolve(@clone.id, @clone.form)
          restore_audio
          @running = false
          @evolved = true
        else
          if @counter < SECOND_STEP && !@forced && Input.trigger?(:B)
            stop_evolution_step
            return
          else
            update_animation
          end
        end
      end
      @counter += 1
    end
    private
    def release_animation
      @sprite_clone.opacity = 0
      @sprite_pokemon.opacity = 255
      @sprite_pokemon.set_color([0, 0, 0, 0])
      @viewport.tone.set(0, 0, 0, 0)
    end
    def stop_evolution_step
      release_animation
      @message_window.stay_visible = false
      display_message(parse_text(31, 1, ::PFM::Text::PKNICK[0] => @pokemon.given_name))
      @running = false
      $game_system.bgm_restore2
    end
    def evolution_first_step
      Audio.bgm_play(EVOLVE_MUSIC)
      $game_system.cry_play(@pokemon.id, form: @pokemon.form)
      @message_window.auto_skip = true
      @message_window.stay_visible = true
      display_message(parse_text(31, 0, ::PFM::Text::PKNICK[0] => @pokemon.given_name))
    end
    def evolution_last_step
      @message_window.stay_visible = false
      Audio.bgm_play(EVOLVED_MUSIC)
      $game_system.cry_play(@clone.id, form: @clone.form)
      display_message(parse_text(31, 2, ::PFM::Text::PKNICK[0] => @pokemon.given_name, ::PFM::Text::PKNAME[1] => @clone.name))
    end
    def memorize_audio
      $game_system.bgm_memorize2
      Audio.bgm_stop
    end
    def restore_audio
      Audio.bgm_stop
      $game_system.bgm_restore2
    end
    def update_animation
      if @counter < FIRST_STEP
        value = 255 * @counter / FIRST_STEP
        @sprite_pokemon.set_color(Color.new(value, value, value, value))
        value /= 5
        @viewport.tone.set(value, value, value, 0)
      else
        if @counter < SECOND_STEP
          value = (Math.cos((@counter - FIRST_STEP) * PI2 / SECOND_STEP_FREQUENCY) + 1) * 128
          @sprite_pokemon.opacity = value
          @sprite_clone.opacity = 255 - value
        else
          if @counter < LAST_STEP
            value = (60 - (@counter - SECOND_STEP)) * 255 / 60
            @viewport.tone.set(value, value, value, 0)
            @sprite_clone.set_color(Color.new(value, value, value, value))
          end
        end
      end
    end
    def update_message
      while $game_temp.message_window_showing
        @message_window.update
        Graphics.update
      end
    end
    def create_background
      bi = @__last_scene.is_a?(Battle::Scene) ? @__last_scene.battle_info : Battle::Logic::BattleInfo.new
      background_filename = bi.find_background_name_to_display do |filename|
        next(RPG::Cache.battleback_exist?(filename))
      end
      @background = Sprite.new(@viewport).set_bitmap(background_filename, :battleback)
    end
    def create_sprite_pkmn
      if ENABLE_GIF && (@pokemon_gif = @pokemon.gif_face)
        add_disposable bitmap = Texture.new(@pokemon_gif.width, @pokemon_gif.height)
        @pokemon_gif&.update(bitmap)
      end
      @sprite_pokemon = Sprite::WithColor.new(@viewport).set_bitmap(bitmap || @pokemon.battler_face)
      @sprite_pokemon.set_position(160, 120)
      @sprite_pokemon.set_origin_div(2, 2)
    end
    def create_sprite_pkmn_evolved
      if ENABLE_GIF && (@clone_gif = @clone.gif_face)
        add_disposable bitmap = Texture.new(@clone_gif.width, @clone_gif.height)
        @clone_gif&.update(bitmap)
      end
      @sprite_clone = Sprite::WithColor.new(@viewport).set_bitmap(bitmap || @clone.battler_face)
      @sprite_clone.set_position(160, 120)
      @sprite_clone.set_origin_div(2, 2)
      @sprite_clone.set_color([1, 1, 1, 1])
      @sprite_clone.opacity = 0
    end
    def create_viewport
      super
      @viewport.extend(Viewport::WithToneAndColors)
      @viewport.shader = Shader.create(:map_shader)
    end
    def create_graphics
      create_viewport
      create_background
      create_sprite_pkmn
      create_sprite_pkmn_evolved
    end
  end
  # Scene showing the Egg of a Pokemon hatching
  class Hatch < Base
    # Constant telling if you have gifs or not during the scene
    ENABLE_GIF = true
    # Move duration
    EGG_MOVE_DURATION = 180
    # Move period
    EGG_MOVE_PERIOD = 60
    # Move angle
    EGG_MOVE_ANGLE = 10
    # Max red component of the Viewport's tone when the egg is glowing
    TONE_RED_MAX = 255 / 5
    # Max green component of the Viewport's tone when the egg is glowing
    TONE_GREEN_MAX = 180 / 5
    # Time when the egg starts to glow
    EGG_GLOW_START = EGG_MOVE_DURATION + 1
    # Time when the egg stops to glow
    EGG_GLOW_END = EGG_GLOW_START + 180
    # The factor used in the glow alpha
    EGG_GLOW_FACTOR = 255
    # Time when the viewport start to show the tone when the egg is glowing
    VIEWPORT_GLOW_START = EGG_GLOW_START + 30
    # Time when the viewport finish to show the tone when the egg is glowing
    VIEWPORT_GLOW_END = EGG_GLOW_END - 30
    # Time when the flash starts (pokemon shown, egg hidden)
    FLASH_START = EGG_GLOW_END + 1
    # Time when the flash ends
    FLASH_END = FLASH_START + 20
    # Time when the Pokemon starts to decrease it's color alpha
    POKEMON_ALPHA_DOWN_START = FLASH_START + 30
    # Time when the Pokemon ends to decrease it's color alpha
    POKEMON_ALPHA_DOWN_END = POKEMON_ALPHA_DOWN_START + 40
    # Max alpha of the Pokemon color
    MAX_POKEMON_ALPHA = 230
    # Name of the move file
    EGG_MOVE_SE = 'audio/se/pokemove'
    include Math
    # Create a new Hatch scene
    # @param pkmn [PFM::Pokemon] the Pokemon in the egg
    def initialize(pkmn)
      super()
      @pokemon = pkmn
      @egg = pkmn.clone
      @egg.step_remaining = 1
      @counter = 0
      play_music
    end
    # Update the hatching process
    def update
      @pokemon_gif&.update(@pokemon_sprite.bitmap)
      return unless super
      update_message
      update_animation
      @counter += 1
    end
    private
    # Play the evolve music
    def play_music
      $game_system.bgm_memorize2
      Audio.bgm_stop
      Audio.bgm_play(Evolve::EVOLVE_MUSIC)
    end
    # Update the message to show according to the counter
    def update_message
      return unless can_display_message_be_called?
      if @counter == 0
        @message_window.auto_skip = true
        @message_window.stay_visible = true
        display_message(text_get(36, 37))
      else
        if @counter == POKEMON_ALPHA_DOWN_END
          @message_window.auto_skip = false
          Audio.bgm_play(Evolve::EVOLVED_MUSIC)
          PFM::Text.set_pkname(@pokemon, 0)
          display_message(text_get(36, 38))
        else
          if @counter > POKEMON_ALPHA_DOWN_END
            show_rename_choice
            Audio.bgm_stop
            $game_system.bgm_restore2
            $pokedex.mark_seen(@pokemon.id, @pokemon.form, forced: true)
            $pokedex.mark_captured(@pokemon.id, @pokemon.form)
            $pokedex.increase_creature_fought(@pokemon.id)
            $pokedex.increase_creature_caught_count(@pokemon.id)
            @pokemon.loyalty = 120
            @running = false
          end
        end
      end
    end
    # Show the rename choice
    def show_rename_choice
      PFM::Text.set_pkname(@pokemon, 0)
      choice = display_message(text_get(36, 39), 1, text_get(11, 27), text_get(11, 28))
      return unless choice == 0
      GamePlay.open_pokemon_name_input(@pokemon) { |name_input| @pokemon.given_name = name_input.return_name }
    end
    # Update the animation
    def update_animation
      update_egg_move if @counter <= EGG_MOVE_DURATION
      update_egg_glow if @counter.between?(EGG_GLOW_START, EGG_GLOW_END)
      update_viewport_glow if @counter.between?(VIEWPORT_GLOW_START, VIEWPORT_GLOW_END)
      update_viewport_flash if @counter.between?(FLASH_START, FLASH_END)
      switch_sprites if @counter == FLASH_START
      update_pokemon_alpha_down if @counter.between?(POKEMON_ALPHA_DOWN_START, POKEMON_ALPHA_DOWN_END)
    end
    # Update the egg move
    def update_egg_move
      @egg_sprite.angle = EGG_MOVE_ANGLE * sin(@counter * PI / EGG_MOVE_PERIOD) ** 17
      return unless ((@counter + EGG_MOVE_PERIOD / 2) % EGG_MOVE_PERIOD) == 0
      Audio.se_play(EGG_MOVE_SE)
    end
    # Update the egg glow animation
    def update_egg_glow
      glow_max = EGG_GLOW_END - EGG_GLOW_START
      @egg_color.alpha = (@counter - EGG_GLOW_START) * EGG_GLOW_FACTOR / glow_max if glow_max != 0
      @egg_sprite.set_color(@egg_color)
    end
    # Update the viewport glow animation
    def update_viewport_glow
      current_viewport_time = @counter - VIEWPORT_GLOW_START
      max_viewport_time = VIEWPORT_GLOW_END - VIEWPORT_GLOW_START
      @viewport.tone.set(TONE_RED_MAX * current_viewport_time / max_viewport_time, TONE_GREEN_MAX * current_viewport_time / max_viewport_time, 0, 0)
    end
    # Switch the sprite before the flash process
    def switch_sprites
      @viewport.tone.set(0, 0, 0, 0)
      @egg_sprite.visible = false
      @pokemon_sprite.visible = true
    end
    # Update the viewport flash animation
    def update_viewport_flash
      max_viewport_flash_time = FLASH_END - FLASH_START
      current_viewport_flash_time = max_viewport_flash_time - (@counter - FLASH_START)
      @viewport.color.set(255, 255, 255, 255 * current_viewport_flash_time / max_viewport_flash_time)
    end
    # Update the Pokemon alpha down animation
    def update_pokemon_alpha_down
      max_alpha_time = POKEMON_ALPHA_DOWN_END - POKEMON_ALPHA_DOWN_START
      current_time = max_alpha_time - (@counter - POKEMON_ALPHA_DOWN_START)
      @pokemon_color.alpha = MAX_POKEMON_ALPHA * current_time / max_alpha_time
      @pokemon_sprite.set_color(@pokemon_color)
    end
    # Create the background
    def create_background
      bi = @__last_scene.is_a?(Battle::Scene) ? @__last_scene.battle_info : Battle::Logic::BattleInfo.new
      background_filename = bi.find_background_name_to_display do |filename|
        next(RPG::Cache.battleback_exist?(filename))
      end
      @background = Sprite.new(@viewport).set_bitmap(background_filename, :battleback)
    end
    # Create the Pokemon sprite
    def create_pokemon_sprite
      if ENABLE_GIF && (@pokemon_gif = @pokemon.gif_face)
        add_disposable bitmap = Texture.new(@pokemon_gif.width, @pokemon_gif.height)
        @pokemon_gif&.update(bitmap)
      end
      @pokemon_sprite = Sprite::WithColor.new(@viewport).set_bitmap(bitmap || @pokemon.battler_face)
      @pokemon_sprite.set_position(@viewport.rect.width / 2, @viewport.rect.height / 2)
      @pokemon_sprite.set_origin_div(2, 1)
      @pokemon_sprite.set_color(@pokemon_color = Color.new(255, 255, 255, MAX_POKEMON_ALPHA))
      @pokemon_sprite.visible = false
    end
    # Create the egg sprite
    def create_egg_sprite
      @egg_sprite = Sprite::WithColor.new(@viewport).set_bitmap(@egg.battler_face)
      @egg_sprite.set_position(@viewport.rect.width / 2, @viewport.rect.height / 2)
      @egg_sprite.set_origin_div(2, 1)
      @egg_sprite.set_color(@egg_color = Color.new(255, 180, 0, 0))
    end
    # Create the scene graphics
    def create_graphics
      create_viewport
      create_background
      create_pokemon_sprite
      create_egg_sprite
    end
    # Create the scene viewport
    def create_viewport
      @viewport = Viewport.create(:main, @message_window.z - 1)
      @viewport.extend(Viewport::WithToneAndColors)
      @viewport.shader = Shader.create(:map_shader)
    end
  end
end
GamePlay.evolve_mixin = GamePlay::EvolveMixin
GamePlay.evolve_class = GamePlay::Evolve
GamePlay.hatch_class = GamePlay::Hatch
