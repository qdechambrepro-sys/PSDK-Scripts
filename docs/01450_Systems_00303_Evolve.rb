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
    end
    def update_graphics
    end
    private
    def release_animation
    end
    def stop_evolution_step
    end
    def evolution_first_step
    end
    def evolution_last_step
    end
    def memorize_audio
    end
    def restore_audio
    end
    def update_animation
    end
    def update_message
    end
    def create_background
    end
    def create_sprite_pkmn
    end
    def create_sprite_pkmn_evolved
    end
    def create_viewport
    end
    def create_graphics
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
    end
    # Update the hatching process
    def update
    end
    private
    # Play the evolve music
    def play_music
    end
    # Update the message to show according to the counter
    def update_message
    end
    # Show the rename choice
    def show_rename_choice
    end
    # Update the animation
    def update_animation
    end
    # Update the egg move
    def update_egg_move
    end
    # Update the egg glow animation
    def update_egg_glow
    end
    # Update the viewport glow animation
    def update_viewport_glow
    end
    # Switch the sprite before the flash process
    def switch_sprites
    end
    # Update the viewport flash animation
    def update_viewport_flash
    end
    # Update the Pokemon alpha down animation
    def update_pokemon_alpha_down
    end
    # Create the background
    def create_background
    end
    # Create the Pokemon sprite
    def create_pokemon_sprite
    end
    # Create the egg sprite
    def create_egg_sprite
    end
    # Create the scene graphics
    def create_graphics
    end
    # Create the scene viewport
    def create_viewport
    end
  end
end
GamePlay.evolve_mixin = GamePlay::EvolveMixin
GamePlay.evolve_class = GamePlay::Evolve
GamePlay.hatch_class = GamePlay::Hatch
