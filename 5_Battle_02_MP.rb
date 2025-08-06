###############TEST###############
class Battle::Visual
  # Associe les backgrounds à leurs grounds correspondants
  # Si le background n'est pas trouvé, on utilise 'ground_grass' par défaut
  # Ces noms doivent correspondre aux noms des fichiers dans le dossier "battleback"  
  GROUND_BY_BATTLEBACK = {
    'back_grass' => 'ground_grass',
    'back_tall_grass' => 'ground_grass',
    'back_taller_grass' => 'ground_grass',
    'back_tall_grass_night' => 'ground_grass_night',
    'back_building' => 'ground_building',
    'back_cave' => 'ground_cave',
    'back_mount' => 'ground_mount',
    'back_sand' => 'ground_sand',
    'back_pond' => 'ground_water',
    'back_sea' => 'ground_water',
    'back_under_water' => 'ground_underwater',
    'back_ice' => 'ground_ice',
    'back_snow' => 'ground_snow'
  }
  # Associe les backgrounds à leurs foregrounds correspondants
  # Si le background n'est pas trouvé, on utilise 'fg_default' par défaut
  # Ces noms doivent correspondre aux noms des fichiers dans le dossier "battleback"
  # Note: Les foregrounds sont des éléments qui apparaissent au-dessus du background
FOREGROUND_BY_BATTLEBACK = {
    'back_grass' => 'fg_grass',
    'back_tall_grass' => 'fg_tall_grass',
    'back_tall_grass_night' => 'fg_tall_grass_night',
    'back_taller_grass' => 'fg_grass',
    'back_building' => 'fg_building',
    'back_cave' => 'fg_cave',
    'back_mount' => 'fg_mount',
    'back_sand' => 'fg_sand',
    'back_pond' => 'fg_water',
    'back_sea' => 'fg_water',
    'back_under_water' => 'fg_underwater',
    'back_ice' => 'fg_ice',
    'back_snow' => 'fg_snow'
  }
 def create_grounds
    @ground_sprites = {}

    # Récupère le nom de base du background actuel
    # Utilise la fonction définie dans 05_Battle_02_MP.rb pour obtenir le nom du battleback, tout se joue à partir de lui !
    current_back = current_battleback_name

    # Cherche le ground associé dans le dictionnaire
    # Si le background n'est pas trouvé, on utilise 'ground_grass' par défaut
    ground_name = GROUND_BY_BATTLEBACK[current_back] || 'ground_grass' # fallback par défaut
    
    @battlers.each do |bank, sprites|
      sprites.each do |position, sprite|
        # On ne garde que les sprites de Pokémon
        next unless position >= 0
        next unless sprite.is_a?(BattleUI::PokemonSprite)

        ground = ShaderedSprite.new(@viewport)
        ground.bitmap = RPG::Cache.battleback(ground_name)
        ground.ox = ground.bitmap.width / 2
        ground.oy = ground.bitmap.height / 2
        ground.z = sprite.z - 100
        ground.x = sprite.x
        ground.y = sprite.y

        @ground_sprites[bank] ||= {}
        @ground_sprites[bank][position] = ground
      end
    end
  end

 def create_foreground
  
    current_back = current_battleback_name
    foreground_name = FOREGROUND_BY_BATTLEBACK[current_back] || 'fg_default'
    puts "Foreground name: #{foreground_name}"
    @foreground_sprite = ShaderedSprite.new(@viewport)
    @foreground_sprite.bitmap = RPG::Cache.battleback(foreground_name)
    @foreground_sprite.ox = @foreground_sprite.bitmap.width / 2
    @foreground_sprite.oy = @foreground_sprite.bitmap.height / 2
    @foreground_sprite.x = Graphics.width / 2
    @foreground_sprite.y = Graphics.height / 2
    @foreground_sprite.z = 1000 # très haut pour être au-dessus de tout
  end
  # Renvoie le nom exact du battleback actuellement utilisé (sans extension)
  # @return [String]

  def current_battleback_name
    @scene.battle_info.find_background_name_to_display do |filename|
      RPG::Cache.battleback_exist?(filename) || Yuki::GifReader.exist?("#{filename}.gif", :battleback)
    end
  end
end

class Battle::Scene
  # Renvoie la position de base du sprite allié ou ennemi à partir des positions issues de Figma
  # Changer seulement les valeurs de pos_x_ally et pos_x_enemy et pos_y pour modifier la position de base (prendre valeur de position de Figma)
  # @return [Integer, Integer] Position X et Y du sprite
  def base_position_v1
    pos_x_ally = 16  # Position X par défaut de l'allié
    pos_x_enemy = 208 # Position X par défaut de l'ennemi
    pos_y = 100 # Position Y par défaut des deux sprites

    return pos_x_enemy, pos_y if enemy?
    return pos_x_ally, pos_y
  end

  # Renvoie la position de base du sprite allié ou ennemi pour la version custom
  # @return [Integer, Integer] Position X et Y du sprite
  def base_position_v1_custom

    pos_x_ally= 16  # Position X par défaut de l'allié
    pos_x_enemy = 208 # Position X par défaut de l'ennemi
    pos_y = 100 # Position Y par défaut des deux sprites
    sprite_size = 96

    return pos_x_enemy+sprite_size/2, 170+sprite_size if enemy?
    return pos_x_ally+sprite_size/2, 170+sprite_size
  end
  end

module BattleUI
  # Class for the battle info bar
  # This class is used to display the battle information such as the type logos
  # and other relevant information during the battle.
  #
  class InfoBar < UI::SpriteStack
    # Crée les icônes des types du Pokémon
    # @param pokemon [PFM::Pokemon]
    def create_type_logos

      return unless enemy?
      return unless @pokemon
      if @pokemon != 0 && $pokedex.creature_caught?(pokemon.id, pokemon.form)
        

        sprite_type1 = add_sprite(99, 22, 'battle/type_logo', 1, each_data_type.size, type: SpriteSheet)
        sprite_type1.sy = @pokemon.type1
        sprite_type1.z = 10000
        sprite_type1.visible = true

        sprite_type2 = add_sprite(115, 22, 'battle/type_logo', 1, each_data_type.size, type: SpriteSheet)
        sprite_type2.sy = @pokemon.type2
        sprite_type2.z = 10000
        sprite_type2.visible = true

      end
    end
    private

    def isthepokemoncaught
      puts "Pokemon caught : #{$pokedex.creature_caught?(pokemon.id, pokemon.form)}"
      return $pokedex.creature_caught?(pokemon.id, pokemon.form)
    end
  end


  class TypeLogosSprite < ShaderedSprite
    # Set the Pokemon Data
    # @param pokemon [PFM::Pokemon]
    def data=(pokemon)
      self.visible = pokemon.bank != 0 && $pokedex.creature_caught?(pokemon.id, pokemon.form)
    end
  end
end