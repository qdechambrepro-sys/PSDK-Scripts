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

  def play_contact_move_dash(launcher, target, move)
    puts "Is this a contact move? #{move.made_contact?}"

    return unless move.made_contact?
    return unless launcher && target
    
    # Récupération des sprites
    launcher = launcher.first if launcher.is_a?(Array)
    target = target.first if target.is_a?(Array)
    launcher_sprite = battler_sprite(launcher.bank, launcher.position)
    target_sprite = battler_sprite(target.bank, target.position)
    puts "Playing contact move dash for #{launcher} using #{move} on #{target}"
    return unless launcher_sprite && target_sprite

    # Sauvegarde des positions de départ
    original_x = launcher_sprite.x
    original_y = launcher_sprite.y

    # Position légèrement devant la cible
    offset = launcher.bank == 0 ? 32 : -32
    dest_x = target_sprite.x + offset
    dest_y = target_sprite.y

    # Aller
    puts "[DEBUG] Launcher sprite = #{launcher_sprite.class} / Pos: #{launcher_sprite.x}, #{launcher_sprite.y}"

    ya = Yuki::Animation
    anim_wait=ya.wait(2) 
    dash_in=ya.move(2, launcher_sprite, original_x, original_y, dest_x, dest_y)
    dash_in.parallel_add(anim_wait) 
    dash_in.start
    
    # Recul (après un petit délai)
    dash_out=ya.move(2, launcher_sprite, dest_x, dest_y, original_x, original_y)
    dash_out.start
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
