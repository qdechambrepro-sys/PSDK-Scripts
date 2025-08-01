# Module that allows a sprite to be quickly recenter (useful in a Battle::Visual3D scene)
module RecenterSprite
  # recenter a sprite according to the dimension of the window
  def recenter
    self.x += HALF_WIDTH
    self.y += HALF_HEIGHT
  end
  def add_position(offset_x, offset_y)
    self.x += offset_x
    self.y += offset_y
  end
end
module Battle
  # Class that manage all the thing that are visually seen on the screen
  class Visual
    # @return [Hash] List of the parallel animation
    attr_reader :parallel_animations
    # @return [Array] List of the animation
    attr_reader :animations
    # @return [Viewport] the viewport used to show the sprites
    attr_reader :viewport
    # @return [Viewport] the viewport used to show some UI part
    attr_reader :viewport_sub
    # @return [Array] the element to dispose on #dispose
    attr_reader :to_dispose
    # Not used in Visual (avoid crash when using MoveAnimation)
    attr_accessor :camera_positionner
    # Create a new visual instance
    # @param scene [Scene] scene that hold the logic object
    def initialize(scene)
      @scene = scene
      @screenshot = take_snapshot
      @battlers = {}
      @info_bars = {}
      @team_info = {}
      @ability_bars = {}
      @item_bars = {}
      @animations = []
      @animatable = []
      @parallel_animations = {}
      @to_dispose = []
      @locking = false
      create_graphics
      create_battle_animation_handler
      create_grounds
      create_foreground
      @viewport&.sort_z
    end
    # Safe to_s & inspect
    def to_s
      format('#<%<class>s:%<id>08X>', class: self.class, id: __id__)
    end
    alias inspect to_s
    # Update the visuals
    def update
      @animations.each(&:update)
      @animations.delete_if(&:done?)
      @parallel_animations.each_value(&:update)
      @gif_container&.update(@background.bitmap)
      update_battlers
      update_info_bars
      update_team_info
      update_ability_bars
      update_item_bars
    end
    # Dispose the visuals
    def dispose
      @to_dispose.each(&:dispose)
      @animations.clear
      @parallel_animations.clear
      @viewport.dispose
      @viewport_sub.dispose
    end
    # Tell if the visual are locking the battle update (for transition purpose)
    def locking?
      @locking
    end
    # Unlock the battle scene
    def unlock
      @locking = false
    end
    # Lock the battle scene
    def lock
      if block_given?
        raise 'Race condition' if locking?
        @locking = true
        yield
        return @locking = false
      end
      @locking = true
    end
    # Display animation & stuff like that by updating the scene
    # @yield [] yield the given block without argument
    # @note this function raise if the visual are not locked
    def scene_update_proc
      raise 'Unlocked visual while trying to update scene!' unless @locking
      yield
      @scene.update
      Graphics.update
    end
    # Wait for all animation to end (non parallel one)
    def wait_for_animation
      was_locked = @locking
      lock unless was_locked
      scene_update_proc { } until @animations.all?(&:done?) && @animatable.all?(&:done?)
      unlock unless was_locked
    end
    # Snap all viewports to bitmap
    # @return [Array<Texture>]
    def snap_to_bitmaps
      return [@viewport, @viewport_sub].map(&:snap_to_bitmap)
    end
    private
    # Create all the graphics for the visuals
    def create_graphics
      create_viewport
      create_background
      create_battlers
      create_player_choice
      create_skill_choice
    end
    # Create the Visual viewport
    def create_viewport
      @viewport = Viewport.create(:main, 500)
      @viewport.extend(Viewport::WithToneAndColors)
      @viewport.shader = Shader.create(:map_shader)
      @viewport_sub = Viewport.create(:main, 501)
    end
    # Create the default background
    def create_background
      bg_name = background_name
      if Yuki::GifReader.exist?("#{bg_name}.gif", :battleback)
        @background = Sprite.new(viewport)
        @gif_container = Yuki::GifReader.create("#{bg_name}.gif", :battleback)
        @background.bitmap = Bitmap.new(@gif_container.width, @gif_container.height)
        @background.x = @background.y = 0
        @to_dispose << @background.bitmap
      else
        @background = ShaderedSprite.new(@viewport).set_bitmap(bg_name, :battleback)
      end
    end
    # Return the background name according to the current state of the player
    # @return [String]
    def background_name
      @scene.battle_info.find_background_name_to_display do |filename|
        next(RPG::Cache.battleback_exist?(filename) || Yuki::GifReader.exist?("#{filename}.gif", :battleback))
      end
    end
    # Create the battler sprites (Trainer + Pokemon)
    def create_battlers
      infos = @scene.battle_info
      (logic = @scene.logic).bank_count.times do |bank|
        infos.battlers[bank].each_with_index do |battler, position|
          sprite = BattleUI::TrainerSprite.new(@viewport, @scene, battler, bank, position, infos)
          store_battler_sprite(bank, -position - 1, sprite)
        end
        infos.vs_type.times do |position|
          sprite = BattleUI::PokemonSprite.new(@viewport, @scene)
          sprite.pokemon = logic.battler(bank, position)
          @animatable << sprite
          store_battler_sprite(bank, position, sprite)
          create_info_bar(bank, position)
          create_ability_bar(bank, position)
          create_item_bar(bank, position)
        end
        create_team_info(bank)
      end
      hide_info_bars(true)
    end
    # Update the battler sprites
    def update_battlers
      @battlers.each_value do |battlers|
        battlers.each_value(&:update)
      end
    end
    # Update the info bars
    def update_info_bars
      @info_bars.each_value do |info_bars|
        info_bars.each(&:update)
      end
    end
    # Create an ability bar
    # @param bank [Integer]
    # @param position [Integer]
    def create_ability_bar(bank, position)
      @ability_bars[bank] ||= []
      @ability_bars[bank][position] = sprite = BattleUI::AbilityBar.new(@viewport_sub, @scene, bank, position)
      @animatable << sprite
      sprite.go_out(-3600)
    end
    # Update the Ability bars
    def update_ability_bars
      @ability_bars.each_value do |ability_bars|
        ability_bars.each(&:update)
      end
    end
    # Update the item bars
    def update_item_bars
      @item_bars.each_value do |item_bars|
        item_bars.each(&:update)
      end
    end
    # Create an item bar
    # @param bank [Integer]
    # @param position [Integer]
    def create_item_bar(bank, position)
      @item_bars[bank] ||= []
      @item_bars[bank][position] = sprite = BattleUI::ItemBar.new(@viewport_sub, @scene, bank, position)
      @animatable << sprite
      sprite.go_out(-3600)
    end
    # Create the info bar for a bank
    # @param bank [Integer]
    # @param position [Integer]
    def create_info_bar(bank, position)
      info_bars = (@info_bars[bank] ||= [])
      pokemon = @scene.logic.battler(bank, position)
      info_bars[position] = sprite = BattleUI::InfoBar.new(@viewport_sub, @scene, pokemon, bank, position)
      @animatable << sprite
    end
    # Create the Trainer Party Ball
    # @param bank [Integer]
    def create_team_info(bank)
      @team_info[bank] = sprite = BattleUI::TrainerPartyBalls.new(@viewport_sub, @scene, bank)
      @animatable << sprite
    end
    # Update the team info
    def update_team_info
      @team_info.each_value(&:update)
    end
    # Create the player choice
    def create_player_choice
      @player_choice_ui = player_choice_class
    end
    # Get the correct PlayerChoice class depending on the battle mode
    def player_choice_class
      return BattleUI::PlayerChoiceSafari.new(@viewport_sub, @scene) if $game_variables[Yuki::Var::BT_Mode] == 5
      return BattleUI::PlayerChoice.new(@viewport_sub, @scene)
    end
    # Create the skill choice
    def create_skill_choice
      @skill_choice_ui = BattleUI::SkillChoice.new(@viewport_sub, @scene)
    end
    # Create the battle animation handler
    def create_battle_animation_handler
      PSP.make_sprite(@viewport)
      @move_animator = PSP
    end
    # Take a snapshot
    # @return [Texture]
    def take_snapshot
      $scene.snap_to_bitmap
    end
    public
    # Method that show the pre_transition of the battle
    def show_pre_transition
      @transition = battle_transition.new(@scene, @screenshot)
      @animations << @transition
      @transition.pre_transition
      @locking = true
    end
    # Method that show the trainer transition of the battle
    def show_transition
      @animations << @transition
      @transition.transition
      @locking = true
    end
    # Method that show the ennemy sprite transition during the battle end scene
    def show_transition_battle_end
      @animations << @transition
      @transition.transition_battle_end
      @locking = true
    end
    # Function storing a battler sprite in the battler Hash
    # @param bank [Integer] bank where the battler should be
    # @param position [Integer, Symbol] Position of the battler
    # @param sprite [Sprite] battler sprite to set
    def store_battler_sprite(bank, position, sprite)
      @battlers[bank] ||= {}
      @battlers[bank][position] = sprite
    end
    # Retrieve the sprite of a battler
    # @param bank [Integer] bank where the battler should be
    # @param position [Integer, Symbol] Position of the battler
    # @return [BattleUI::PokemonSprite, nil] the Sprite of the battler if it has been stored
    def battler_sprite(bank, position)
      @battlers.dig(bank, position)
    end
    class << self
      # Register the transition resource type for a specific transition
      # @note If no resource type was registered, will send the default sprite one
      # @param id [Integer] id of the transition
      # @param resource_type [Symbol] the symbol of the resource_type (:sprite, :artwork_full, :artwork_small)
      def register_transition_resource(id, resource_type)
        return unless id.is_a?(Integer)
        return unless resource_type.is_a?(Symbol)
        TRANSITION_RESOURCE_TYPE[id] = resource_type
      end
      # Return the transition resource type for a given transition ID
      # @param id [Integer] ID of the transition
      # @return [Symbol]
      def transition_resource_type_for(id)
        resource_type = TRANSITION_RESOURCE_TYPE[id]
        return :sprite unless resource_type
        return resource_type
      end
    end
    private
    # Return the current battle transition
    # @return [Class]
    def battle_transition
      collection = $game_temp.trainer_battle ? TRAINER_TRANSITIONS : WILD_TRANSITIONS
      transition_class = collection[$game_variables[Yuki::Var::TrainerTransitionType]]
      log_debug("Choosen transition class : #{transition_class}")
      return transition_class
    end
    # Show the debug transition
    def show_debug_transition
      2.times do |bank|
        @scene.battle_info.battlers[bank].each_with_index do |_, position|
          battler_sprite(bank, -position - 1)&.visible = false
        end
      end
      Graphics.transition(1)
    end
    # List of Wild Transitions
    # @return [Hash{ Integer => Class<Transition::Base> }]
    WILD_TRANSITIONS = {}
    # List of Trainer Transitions
    # @return [Hash{ Integer => Class<Transition::Base> }]
    TRAINER_TRANSITIONS = {}
    # List of the resource type for each transition
    # @return [Hash{ Integer => Symbol }]
    TRANSITION_RESOURCE_TYPE = {}
    TRANSITION_RESOURCE_TYPE.default = :sprite
    public
    # Method that shows the trainer choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    # @return [Symbol, Array(Symbol, Hash), nil] :attack, :bag, :pokemon, :flee, :cancel, :try_next
    def show_player_choice(pokemon_index)
      if (pokemon = @scene.logic.battler(0, pokemon_index)).effects.has?(&:force_next_turn_action?)
        effect = pokemon.effects.get(&:force_next_turn_action?)
        return :action, effect.make_action
      end
      show_player_choice_begin(pokemon_index)
      show_player_choice_loop
      show_player_choice_end(pokemon_index)
      return @player_choice_ui.result, @player_choice_ui.action
    end
    # Show the message "What will X do"
    # @param pokemon_index [Integer]
    def spc_show_message(pokemon_index)
      @scene.message_window.wait_input = false
    end
    private
    # Begining of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_begin(pokemon_index)
      pokemon = @scene.logic.battler(0, pokemon_index)
      @locking = true
      @player_choice_ui.reset(@scene.logic.switch_handler.can_switch?(pokemon))
      if @player_choice_ui.out?
        @player_choice_ui.go_in
        @animations << @player_choice_ui
        wait_for_animation
      end
      spc_show_message(pokemon_index)
      spc_start_bouncing_animation(pokemon_index)
    end
    # Loop process of the player choice
    def show_player_choice_loop
      loop do
        @scene.update
        @player_choice_ui.update
        Graphics.update
        break if @player_choice_ui.validated?
      end
    end
    # End of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_end(pokemon_index)
      @player_choice_ui.go_out
      @animations << @player_choice_ui
      if @player_choice_ui.result != :attack
        spc_stop_bouncing_animation(pokemon_index)
        wait_for_animation
      end
      @locking = false
    end
    # Start the IdlePokemonAnimation (bouncing)
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def spc_start_bouncing_animation(pokemon_index)
      return if @parallel_animations[IdlePokemonAnimation]
      sprite = battler_sprite(0, pokemon_index)
      bar = @info_bars.dig(0, pokemon_index)
      @parallel_animations[IdlePokemonAnimation] = IdlePokemonAnimation.new(self, sprite, bar)
    end
    # Stop the IdlePokemonAnimation (bouncing)
    # @param _pokemon_index [Integer] Index of the Pokemon in the party
    def spc_stop_bouncing_animation(_pokemon_index)
      @parallel_animations[IdlePokemonAnimation]&.remove
    end
    public
    # Method that show the skill choice and store it inside an instance variable
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    # @return [Boolean] if the player has choose a skill
    def show_skill_choice(pokemon_index)
      return :try_next if spc_cannot_use_this_pokemon?(pokemon_index)
      effect = @scene.logic.battler(0, pokemon_index).effects.get(&:force_next_move?)
      if effect
        @skill_choice_ui.encore_reset(@scene.logic.battler(0, pokemon_index), effect.move)
        return true
      end
      show_skill_choice_begin(pokemon_index)
      show_skill_choice_loop
      show_skill_choice_end(pokemon_index)
      return @skill_choice_ui.result != :cancel
    end
    # Method that show the target choice once the skill was choosen
    # @return [Array<PFM::PokemonBattler, Battle::Move, Integer(bank), Integer(position), Boolean(mega)>, nil]
    def show_target_choice
      return stc_result if stc_cannot_choose_target?
      show_target_choice_begin
      show_target_choice_loop
      show_target_choice_end
      return stc_result(@target_selection_window.result)
    ensure
      @target_selection_window&.dispose
      @target_selection_window = nil
    end
    private
    # Begin of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_begin(pokemon_index)
      spc_start_bouncing_animation(pokemon_index)
      @locking = true
      wait_for_animation
      @skill_choice_ui.reset(@scene.logic.battler(0, pokemon_index))
      @skill_choice_ui.go_in
      @animations << @skill_choice_ui
      wait_for_animation
    end
    # Loop of the skill_choice
    def show_skill_choice_loop
      loop do
        @scene.update
        @skill_choice_ui.update
        Graphics.update
        break if @skill_choice_ui.validated?
      end
    end
    # End of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_end(pokemon_index)
      spc_stop_bouncing_animation(pokemon_index)
      @skill_choice_ui.go_out
      @animations << @skill_choice_ui
      wait_for_animation
      @locking = false
    end
    # Show the Target Selection Window
    def show_target_choice_begin
      @locking = true
      @target_selection_window = BattleUI::TargetSelection.new(@viewport_sub, @skill_choice_ui.pokemon, @skill_choice_ui.result, @scene.logic)
      spc_start_bouncing_animation(@skill_choice_ui.pokemon.position)
    end
    # Loop of the target choice
    def show_target_choice_loop
      loop do
        @scene.update
        @target_selection_window.update
        Graphics.update
        break if @target_selection_window.validated?
      end
    end
    # End of the target choice
    def show_target_choice_end
      spc_stop_bouncing_animation(@skill_choice_ui.pokemon.position)
      @locking = false
    end
    # Make the result of show_target_choice method
    # @param result [Array, :auto, :cancel]
    # @return [Array, nil]
    def stc_result(result = :auto)
      pokemon = @skill_choice_ui.pokemon
      skill = @skill_choice_ui.result
      return handle_cancel_result(pokemon) if result == :cancel
      base_result = [pokemon, skill]
      target_info = determine_target_info(result, pokemon, skill)
      return nil if target_info.nil?
      base_result.concat(target_info) << @skill_choice_ui.mega_enabled
    end
    # Handle the cancel case logic
    # @param pokemon [PFM::PokemonBattler]
    # @return [Array, nil] Returns pokemon array if force_next_move, nil otherwise
    def handle_cancel_result(pokemon)
      return pokemon.effects.get(&:force_next_move?) ? pokemon : nil
    end
    # Determine target information based on result type
    # @param result [Array, :auto]
    # @param pokemon [PFM::PokemonBattler]
    # @param skill [Battle::Move]
    # @return [Array, nil]
    def determine_target_info(result, pokemon, skill)
      case result
      when Array
        return result
      when :auto
        return determine_auto_targets(skill, pokemon)
      else
        return nil
      end
    end
    # Determine targets automatically based on skill configuration
    # @param skill [Battle::Move]
    # @param pokemon [PFM::PokemonBattler]
    # @return [Array] Array containing bank and position of target
    def determine_auto_targets(skill, pokemon)
      targets = skill.battler_targets(pokemon, @scene.logic)
      return [1, 0] if targets.empty?
      selected_target = skill.target == :random_foe ? targets.sample : targets.first
      return [selected_target.bank, selected_target.position]
    end
    # Tell if the Pokemon can be used or not
    # @return [Boolean] if the Pokemon cannot be used
    def spc_cannot_use_this_pokemon?(pokemon_index)
      return @scene.logic.battler(0, pokemon_index)&.party_id != 0
    end
    # Tell if we can choose a target
    # @return [Boolean]
    def stc_cannot_choose_target?
      return @scene.logic.battle_info.vs_type == 1 || BattleUI::TargetSelection.cannot_show?(@skill_choice_ui.result, @skill_choice_ui.pokemon, @scene.logic)
    end
    public
    # Variable giving the position of the battlers to show from bank 0 in bag UI
    BAG_PARTY_POSITIONS = 0..5
    # Method that show the item choice
    # @return [PFM::ItemDescriptor::Wrapper, nil]
    def show_item_choice
      data_to_return = nil
      GamePlay.open_battle_bag(retrieve_party) do |battle_bag_scene|
        data_to_return = battle_bag_scene.battle_item_wrapper
      end
      log_debug("show_item_choice returned #{data_to_return}")
      return data_to_return
    end
    # Method that show the pokemon choice
    # @param forced [Boolean]
    # @param cannot_switch_index [Integer, nil] Index of the trapped party member if a switch cannot happen
    # @return [PFM::PokemonBattler, nil]
    def show_pokemon_choice(forced = false, cannot_switch_index: nil)
      data_to_return = nil
      GamePlay.open_party_menu_to_switch(party = retrieve_party, forced, cannot_switch_index) do |scene|
        data_to_return = party[scene.return_data] if scene.pokemon_selected?
      end
      log_debug("show_pokemon_choice returned #{data_to_return}")
      return data_to_return
    end
    private
    # Method that returns the party for the Bag & Party scene
    # @return [Array<PFM::PokemonBattler>]
    def retrieve_party
      return @scene.logic.all_battlers.select(&:from_player_party?)
    end
    public
    # Hide all the bars
    # @param no_animation [Boolean] skip the going out animation
    # @param bank [Integer, nil] bank where the info bar should be hidden
    def hide_info_bars(no_animation = false, bank: nil)
      enum = bank ? [@info_bars[bank]].each : @info_bars.each_value
      enum.each do |info_bars|
        if no_animation
          info_bars.each { |bar| bar.visible = false }
        else
          info_bars.each { |bar| bar.go_out unless bar.out? }
        end
      end
    end
    # Show all the bars
    # @param bank [Integer, nil] bank where the info bar should be hidden
    def show_info_bars(bank: nil)
      enum = bank ? [@info_bars[bank]].each : @info_bars.each_value
      enum.each do |info_bars|
        info_bars.each do |bar|
          bar.pokemon = bar.pokemon
          next(bar.visible = false) unless bar.pokemon&.alive?
          bar.go_in unless bar.in?
        end
      end
    end
    # Show a specific bar
    # @param pokemon [PFM::PokemonBattler] the pokemon that should be shown by the bar
    def show_info_bar(pokemon)
      bar = @info_bars.dig(pokemon.bank, pokemon.position)
      return log_error("No battle bar at position #{pokemon.bank}, #{pokemon.position}") unless bar
      bar.pokemon = pokemon
      return if pokemon.dead?
      bar.go_in unless bar.in?
    end
    # Show a specific bar
    # @param pokemon [PFM::PokemonBattler] the pokemon that was shown by the bar
    def hide_info_bar(pokemon)
      bar = @info_bars.dig(pokemon.bank, pokemon.position)
      return log_error("No battle bar at position #{pokemon.bank}, #{pokemon.position}") unless bar
      bar.go_out unless bar.out?
    end
    # Refresh a specific bar (when Pokemon loses HP or change state)
    # @param pokemon [PFM::PokemonBattler] the pokemon that was shown by the bar
    def refresh_info_bar(pokemon)
      bar = @info_bars.dig(pokemon.bank, pokemon.position)
      @team_info[pokemon.bank]&.refresh
      return log_error("No battle bar at position #{pokemon.bank}, #{pokemon.position}") unless bar
      bar.refresh
    end
    # Set the state info
    # @param state [Symbol] kind of state (:choice, :move, :move_animation)
    # @param pokemon [Array<PFM::PokemonBattler>] optional list of Pokemon to show (move)
    def set_info_state(state, pokemon = nil)
      case state
      when :choice
        show_info_bars(bank: 1)
        hide_info_bars(bank: 0)
        show_team_info
      when :move
        hide_info_bars
        pokemon&.each { |target| show_info_bar(target) }
      when :move_animation
        hide_info_bars
        hide_team_info
      end
    end
    # Show team info
    def show_team_info
      @team_info.each_value do |info|
        info.refresh
        info.go_in unless info.in?
      end
    end
    # Hide team info
    def hide_team_info
      @team_info.each_value { |info| info.go_out unless info.out? }
    end
    public
    ABILITY_SOUND_EFFECT = ['Audio/SE/In-Battle_Ability_Activate', 100, 100]
    ITEM_SOUND_EFFECT = ABILITY_SOUND_EFFECT
    # Show HP animations
    # @param targets [Array<PFM::PokemonBattler>]
    # @param hps [Array<Integer>]
    # @param effectiveness [Array<Integer, nil>]
    # @param messages [Proc] messages shown right before the post processing
    def show_hp_animations(targets, hps, effectiveness = [], &messages)
      lock do
        wait_for_animation
        animations = targets.map.with_index do |target, index|
          show_info_bar(target)
          if hps[index] && hps[index] == 0
            next(Battle::Visual::FakeHPAnimation.new(@scene, target, effectiveness[index]))
          else
            if hps[index]
              next(Battle::Visual::HPAnimation.new(@scene, target, hps[index], effectiveness[index]))
            end
          end
        end
        scene_update_proc {animations.each(&:update) } until animations.all?(&:done?)
        messages&.call
        show_kos(targets)
      end
    end
    # Show an animation for stat change
    # @param target [PFM::PokemonBattler]
    # @param amount [Integer] value for the changement
    def show_stat_animation(target, amount)
      wait_for_animation
      return if target.effects.has?(&:out_of_reach?)
      target_sprite = battler_sprite(target.bank, target.position)
      target_sprite.change_stat_animation(amount)
      wait_for_animation
    end
    # Show an animation for a status
    # @param target [PFM::PokemonBattler]
    # @param status [Symbol]
    def show_status_animation(target, status)
      wait_for_animation
      return if status == :flinch
      target_sprite = battler_sprite(target.bank, target.position)
      target_sprite.status_animation(status)
      wait_for_animation
    end
    # remove the tone animation
    # @param target [PFM::PokemonBattler]
    def heal_status_remove_tone(target)
      wait_for_animation
      return if target.position < 0
      target_sprite = battler_sprite(target.bank, target.position)
      target_sprite.remove_tone_animation
      wait_for_animation
    end
    # Show KO animations
    # @param targets [Array<PFM::PokemonBattler>]
    def show_kos(targets)
      targets = targets.select(&:dead?)
      return if targets.empty?
      play_ko_se
      targets.each do |target|
        battler_sprite(target.bank, target.position).go_out
        hide_info_bar(target)
      end
      targets.each do |target|
        @scene.display_message_and_wait(parse_text_with_pokemon(19, 0, target, PFM::Text::PKNICK[0] => target.given_name))
        target.status = 0
      end
    end
    # Show the ability animation
    # @param target [PFM::PokemonBattler]
    # @param [Boolean] no_go_out Set if the out animation should be not played automatically
    def show_ability(target, no_go_out = false)
      Audio.se_play(*ABILITY_SOUND_EFFECT)
      ability_bar = @ability_bars[target.bank][target.position]
      item_bar = @item_bars[target.bank][target.position]
      return unless ability_bar
      ability_bar.data = target
      ability_bar.go_in_ability(no_go_out)
      if !item_bar || item_bar.done?
        ability_bar.z = 0
      else
        ability_bar.z = item_bar.z + 1
      end
    end
    # Hide the ability animation (no effect if no_go_out = false)
    # @param target [PFM::PokemonBattler]
    def hide_ability(target)
      ability_bar = @ability_bars[target.bank][target.position]
      return unless ability_bar || ability_bar.no_go_out
      ability_bar.go_out
    end
    # Show the item user animation
    # @param target [PFM::PokemonBattler]
    def show_item(target)
      Audio.se_play(*ITEM_SOUND_EFFECT)
      ability_bar = @ability_bars[target.bank][target.position]
      item_bar = @item_bars[target.bank][target.position]
      return unless item_bar
      item_bar.data = target
      item_bar.go_in_ability
      item_bar.z = ability_bar.z + 1 unless !ability_bar || ability_bar.done?
      if !ability_bar || ability_bar.done?
        item_bar.z = 0
      else
        item_bar.z = ability_bar.z + 1
      end
    end
    # Show the pokemon switch form animation
    # @param target [PFM::PokemonBattler]
    def show_switch_form_animation(target)
      battler_sprite(target.bank, target.position)&.pokemon = target
    end
    # Show the pokemon mega evolution animation
    # @param target [PFM::PokemonBattler]
    def show_mega_animation(target)
      wait_for_animation
      mega_evolution_sprite = UI::MegaEvolveAnimation.new(@viewport, @scene, target, battler_sprite(target.bank, target.position))
      animation = mega_evolution_sprite.mega_evolution_animation
      @animations << animation
      animation.start
      wait_for_animation
      RPG::Cache.load_animation(true)
      mega_evolution_sprite.dispose
    end
    # Make a move animation
    # BALISE Make a move animation
    # @param user [PFM::PokemonBattler]
    # @param targets [Array<PFM::PokemonBattler>]
    # @param move [Battle::Move]
def show_move_animation(user, targets, move)
  return unless $options.show_animation
  $data_animations ||= load_data('Data/Animations.rxdata')
  id = move.id
  user_sprite = battler_sprite(user.bank, user.position)
  target_sprite = battler_sprite(targets.first.bank, targets.first.position)
  original_rect = @viewport.rect.clone
  @viewport.rect.height = Viewport::CONFIGS[:main][:height]

  # === Début : Dash si attaque de contact ===
  if move.made_contact? && user_sprite && target_sprite
    puts "Dash de contact pour #{user_sprite.pokemon.given_name} (#{user_sprite.x}, #{user_sprite.y}) vers #{target_sprite.pokemon.given_name} (#{target_sprite.x}, #{target_sprite.y})"
    original_x = user_sprite.x
    original_y = user_sprite.y
    #offset = user.bank == 0 ? 32 : -32
    offset = 0
    dest_x = target_sprite.x + offset
    dest_y = target_sprite.y

    timed_ya = Yuki::Animation.wait(3)
    ya = Yuki::Animation
    dash_in=ya.move(2, user_sprite, original_x, original_y, 360, dest_y)
    timed_ya.parallel_play(dash_in)
    timed_ya.play_before(dash_in)
    # Recul (après un petit délai)
    dash_out=ya.move(2, user_sprite, dest_x, dest_y, original_x, original_y)
    wait_for_animation
  end
  # === Fin : Dash de contact ===

  # Animation principale de l’attaque
  lock { @move_animator.move_animation(user_sprite, target_sprite, id, user.bank != 0) }
  @viewport.rect = original_rect
end

    # Show a dedicated animation
    # @param target [PFM::PokemonBattler]
    # @param id [Integer]
    def show_rmxp_animation(target, id)
      return unless $options.show_animation
      wait_for_animation
      $data_animations ||= load_data('Data/Animations.rxdata')
      lock {@move_animator.animation(battler_sprite(target.bank, target.position), id, target.bank != 0) }
    end
    # Show the exp distribution
    # @param exp_data [Hash{ PFM::PokemonBattler => Integer }] info about experience each pokemon should receive
    def show_exp_distribution(exp_data)
      lock do
        exp_ui = BattleUI::ExpDistribution.new(@viewport_sub, @scene, exp_data)
        @scene.display_message_and_wait(ext_text(8999, 21))
        exp_ui.start_animation
        scene_update_proc {exp_ui.update } until exp_ui.done?
        exp_ui.dispose
      end
      exp_data.each_key { |pokemon| refresh_info_bar(pokemon) if pokemon.can_fight? }
    end
    # Show the catching animation
    # @param target_pokemon [PFM::PokemonBattler] pokemon being caught
    # @param ball [Studio::BallItem] ball used
    # @param nb_bounce [Integer] number of time the ball move
    # @param caught [Integer] if the pokemon got caught
    def show_catch_animation(target_pokemon, ball, nb_bounce, caught)
      origin = battler_sprite(0, 0)
      target = battler_sprite(target_pokemon.bank, target_pokemon.position)
      @sprite = UI::ThrowingBallSprite.new(origin.viewport, ball)
      animation = create_throw_ball_animation(@sprite, target, origin)
      create_move_ball_animation(animation, @sprite, nb_bounce)
      caught ? create_caught_animation(animation, @sprite) : create_break_animation(animation, @sprite, target)
      animation.start
      @animations << animation
      wait_for_animation
    end
    # Define the translation to the center of the Screen
    # @note This method is used only in Visual3D
    def start_center_animation
      return false
    end
    private
    # Create the throw ball animation
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_ball_animation(sprite, target, origin)
      ya = Yuki::Animation
      sprite.set_position(-sprite.ball_offset_y, origin.y - sprite.trainer_offset_y)
      animation = ya.scalar_offset(0.4, sprite, :y, :y=, 0, -64, distortion: :SQUARE010_DISTORTION)
      animation.parallel_play(ya.move(0.4, sprite, sprite.x, sprite.y, target.x, target.y - sprite.trainer_offset_y))
      animation.parallel_play(ya.scalar(0.4, sprite, :throw_progression=, 0, 1))
      animation.parallel_play(ya.se_play(*sending_ball_se))
      animation.play_before(ya.scalar(0.2, sprite, :open_progression=, 0, 1))
      animation.play_before(ya.scalar(0.2, target, :zoom=, sprite_zoom, 0))
      animation.play_before(ya.se_play(*opening_ball_se))
      animation.play_before(ya.scalar(0.5, sprite, :close_progression=, 0, 1))
      fall_animation = ya.scalar(1, sprite, :y=, target.y - sprite.ball_offset_y, target.y - sprite.trainer_offset_y, distortion: fall_distortion)
      sound_animation = ya.wait(0.2)
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      sound_animation.play_before(ya.wait(0.4))
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      sound_animation.play_before(ya.wait(0.4))
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      animation.play_before(fall_animation)
      fall_animation.parallel_play(sound_animation)
      return animation
    end
    def fall_distortion
      return proc { |x| (Math.cos(2.5 * Math::PI * x) * Math.exp(-2 * x)).abs }
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param nb_bounce [Integer]
    def create_move_ball_animation(animation, sprite, nb_bounce)
      ya = Yuki::Animation
      animation.play_before(ya.wait(0.5))
      nb_bounce.clamp(0, 3).times do
        animation.play_before(ya.se_play(*moving_ball_se))
        animation.play_before(ya.scalar(0.5, sprite, :move_progression=, 0, 1))
        animation.play_before(ya.wait(0.5))
      end
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    def create_caught_animation(animation, sprite)
      ya = Yuki::Animation
      animation.play_before(ya.se_play(*catching_ball_se))
      animation.play_before(ya.scalar(0.5, sprite, :caught_progression=, 0, 1))
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    def create_break_animation(animation, sprite, target)
      ya = Yuki::Animation
      animation.play_before(ya.se_play(*break_ball_se))
      animation.play_before(ya.scalar(0.5, sprite, :break_progression=, 0, 1))
      animation.play_before(ya.scalar(0.2, target, :zoom=, 0, sprite_zoom))
      animation.play_before(ya.send_command_to(sprite, :dispose))
    end
    # Sprite zoom of the Pokemon battler
    def sprite_zoom
      return 1
    end
    # SE played when a Pokemon is K.O.
    def play_ko_se
      Audio.se_play('Audio/SE/Down', 100, 80)
    end
    # SE played when the ball is sent
    def sending_ball_se
      return 'fall', 100, 120
    end
    # SE played when the ball is opening
    def opening_ball_se
      return 'pokeopen'
    end
    # SE played when the ball is bouncing
    def bouncing_ball_se
      return 'pokerebond'
    end
    # SE played when the ball is moving
    def moving_ball_se
      return 'pokemove'
    end
    # SE played when the Pokemon is caught
    def catching_ball_se
      return 'pokeopenbreak', 100, 180
    end
    # SE played when the Pokemon escapes from the ball
    def break_ball_se
      return 'pokeopenbreak'
    end
    public
    # Show the bait or mud throw animation if Safari Battle
    # @param target_pokemon [PFM::PokemonBattler] pokemon being thrown something at
    # @param bait_mud [Symbol] :bait or :mud, depending on the player's choice
    def show_bait_mud_animation(target_pokemon, bait_mud)
      origin = battler_sprite(0, -1)
      target = battler_sprite(target_pokemon.bank, target_pokemon.position)
      @sprite = UI::ThrowingBaitMudSprite.new(origin.viewport, bait_mud)
      animation = create_throw_bait_mud_animation(@sprite, target, origin)
      animation.start
      @animations << animation
      wait_for_animation
    end
    private
    # Create the throw bait or mud animation
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_bait_mud_animation(sprite, target, origin)
      ya = Yuki::Animation
      sprite.set_position(origin.x - sprite.trainer_offset, origin.y - sprite.trainer_offset)
      animation = ya.scalar_offset(0.5, sprite, :y, :y=, 0, -64, distortion: :SQUARE010_DISTORTION)
      animation.parallel_play(ya.move(0.5, sprite, sprite.x, sprite.y, target.x, target.y - sprite.offset_y))
      animation.parallel_play(ya.scalar(0.5, sprite, :throw_progression=, 0, 1))
      animation.parallel_play(ya.se_play(*sending_ball_se))
      animation.parallel_play(origin.throw_bait_mud_animation)
      animation.play_before(ya.wait(0.4))
      animation.play_before(ya.send_command_to(sprite, :dispose))
      return animation
    end
    public
    # Animation shown when a Creature is currently selected and wait for the player to choose its actions
    class IdlePokemonAnimation
      # Pixel offset for each index of the sprite
      OFFSET_SPRITE = [0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0]
      # Pixel offset for each index of the bar
      OFFSET_BAR = [0, -1, -2, -3, -4, -5, -5, -4, -3, -2, -1, 0]
      # Create a new IdlePokemonAnimation
      # @param visual [Battle::Visual]
      # @param pokemon [BattleUI::PokemonSprite]
      # @param bar [BattleUI::InfoBar]
      def initialize(visual, pokemon, bar)
        @visual = visual
        @pokemon = pokemon
        @pokemon_origin = pokemon.send(:sprite_position)
        @bar = bar
        @bar_origin = bar.send(:sprite_position)
        @animation = create_animation
      end
      # Function that updates the idle animation
      def update
        @animation.update
      end
      # Function that rmoves the idle animation from the visual
      def remove
        @pokemon.y = @pokemon_origin.last if @pokemon.in?
        @bar.y = @bar_origin.last if @bar.in?
        @visual.parallel_animations.delete(self.class)
      end
      private
      # Function that create the animation
      # @return [Yuki::Animation::TimedLoopAnimation]
      #BALISE Idle
      def create_animation
        root = Yuki::Animation::TimedLoopAnimation.new(1.2)
        pokemon_anim = Yuki::Animation::DiscreetAnimation.new(1.2, self, :move_pokemon, 0, OFFSET_SPRITE.size - 1)
        bar_anim = Yuki::Animation::DiscreetAnimation.new(1.2, self, :move_bar, 0, OFFSET_BAR.size - 1)
        pokemon_anim.parallel_add(bar_anim)
        root.play_before(pokemon_anim)
        root.start
        return root
      end
      # Function that moves the bar using the relative offset specified by 
      def move_bar(index)
        return if @bar.out?
        @bar.y = @bar_origin.last + OFFSET_BAR[index]
      end
      # Function that moves the pokemon using the relative offset specified by 
      def move_pokemon(index)
        return if @pokemon.out?
        return if BATTLE_CAMERA_3D
        @pokemon.y = @pokemon_origin.last + OFFSET_SPRITE[index]
      end
    end
    public
    # Animation of HP getting down/up
    class HPAnimation < Yuki::Animation::DiscreetAnimation
      # Create the HP Animation
      # @param scene [Battle::Scene] scene responsive of holding all the battle information
      # @param target [PFM::PokemonBattler] Pokemon getting its HP down/up
      # @param quantity [Integer] quantity of HP the Pokemon is getting
      # @param effectiveness [Integer, nil] optional param to play the effectiveness sound if that comes from using a move
      def initialize(scene, target, quantity, effectiveness = nil)
        @scene = scene
        @target = target
        @target_hp = (target.hp + (quantity == 0 ? -1 : quantity)).clamp(0, target.max_hp)
        time = (quantity.clamp(-target.hp, target.max_hp).abs.to_f / 60).clamp(0.2, 1)
        super(time, target, :hp=, target.hp, @target_hp)
        create_sub_animation
        start
        effectiveness_sound(effectiveness) if quantity != 0 && effectiveness
      end
      # Update the animation
      def update
        super
        @scene.visual.refresh_info_bar(@target)
      end
      # Detect if the animation if done
      # @return [Boolean]
      def done?
        return false unless super
        final_hp_refresh
        return true
      end
      # Play the effectiveness sound
      def effectiveness_sound(effectiveness)
        if effectiveness == 1
          Audio.se_play('Audio/SE/hit')
        else
          if effectiveness > 1
            Audio.se_play('Audio/SE/hitplus')
          else
            Audio.se_play('Audio/SE/hitlow')
          end
        end
      end
      private
      # Function that refreshes the bar to the final value
      def final_hp_refresh
        @target.hp = @target_hp while @target_hp != @target.hp
        @scene.visual.refresh_info_bar(@target)
      end
      # Function that creates the sub animation
      def create_sub_animation
        play_before(Yuki::Animation.send_command_to(self, :final_hp_refresh))
        if @target_hp > 0
          play_before(Yuki::Animation.wait((1 - @time_to_process).clamp(0.25, 1)))
        else
          play_before(Yuki::Animation.wait(0.1))
        end
      end
    end
    public
    # Waiting animation if 0 HP are dealt
    class FakeHPAnimation < Yuki::Animation::TimedAnimation
      # Create the HP Animation
      # @param scene [Battle::Scene] scene responsive of holding all the battle information
      # @param target [PFM::PokemonBattler] Pokemon getting its HP down/up
      # @param effectiveness [Integer, nil] optional param to play the effectiveness sound if that comes from using a move
      def initialize(scene, target, effectiveness = nil)
        @scene = scene
        @target = target
        time = 1
        super(time)
        start
        effectiveness_sound(effectiveness) if effectiveness
      end
      # Update the animation
      def update
        super
        @scene.visual.refresh_info_bar(@target)
      end
      # Detect if the animation if done
      # @return [Boolean]
      def done?
        return false unless super
        @scene.visual.refresh_info_bar(@target)
        return true
      end
      # Play the effectiveness sound
      def effectiveness_sound(effectiveness)
        if effectiveness == 1
          Audio.se_play('Audio/SE/hit')
        else
          if effectiveness > 1
            Audio.se_play('Audio/SE/hitplus')
          else
            Audio.se_play('Audio/SE/hitlow')
          end
        end
      end
    end
    public
    # Module holding all the Battle transition
    module Transition
      # Base class of all transitions
      class Base
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        def initialize(scene, screenshot)
          @scene = scene
          @visual = scene.visual
          @viewport = @visual.viewport
          @screenshot = screenshot
          @animations = []
          @to_dispose = [screenshot]
        end
        # Update the transition
        def update
          @animations.each(&:update)
        end
        # Tell if the transition is done
        # @return [Boolean]
        def done?
          return @animations.all?(&:done?)
        end
        # Dispose the transition (safely clean all things that needs to be disposed)
        def dispose
          @to_dispose.each do |disposable|
            disposable.dispose unless disposable.disposed?
          end
        end
        # Start the pre transition (fade in)
        #
        # - Initialize **all** the sprites
        # - Create all the pre-transition animations
        # - Force Graphics transition if needed.
        def pre_transition
          create_all_sprites
          @animations.clear
          transition = create_pre_transition_animation
          transition.play_before(Yuki::Animation.send_command_to(@visual, :unlock))
          @animations << transition
          Graphics.transition(1)
          @animations.each(&:start)
        end
        # Start the transition (fade out)
        #
        # - Create all the transition animation
        # - Add all the message to the animation
        # - Add the send enemy Pokemon animation
        # - Add the send actor Pokemon animation
        def transition
          @animations.clear
          @scene.message_window.visible = true
          @scene.message_window.blocking = true
          @scene.message_window.stay_visible = true
          @scene.message_window.wait_input = true
          ya = Yuki::Animation
          main = create_fade_out_animation
          main.play_before(create_sprite_move_animation)
          @animations << main
          @animations << create_background_animation
          @animations << create_paralax_animation
          main.play_before(ya.message_locked_animation).play_before(ya.send_command_to(self, :show_appearing_message)).play_before(ya.send_command_to(@scene, :on_pre_battle_begin)).play_before(ya.send_command_to(@scene.visual, :show_team_info)).play_before(ya.send_command_to(self, :start_enemy_send_animation))
          @animations.each(&:start)
        end
        # Start the transition
        def transition_battle_end
          @animations.clear
          main = Yuki::Animation.wait(0)
          main.play_before(go_out_battlers).play_before(Yuki::Animation.send_command_to(@visual, :hide_info_bars, bank: 0)).play_before(Yuki::Animation.send_command_to(@visual, :hide_info_bars, bank: 1)).play_before(Yuki::Animation.send_command_to(@visual, :hide_team_info)).play_before(show_enemy_sprite_battle_end)
          @animations << main
          main.play_before(Yuki::Animation.message_locked_animation)
          @animations.each(&:start)
        end
        # Function that starts the Enemy send animation
        def start_enemy_send_animation
          log_debug('start_enemy_send_animation')
          ya = Yuki::Animation
          animation = create_enemy_send_animation
          animation.parallel_add(ya.send_command_to(self, :show_enemy_send_message))
          animation.play_before(ya.message_locked_animation)
          animation.play_before(ya.send_command_to(self, :start_actor_send_animation))
          animation.start
          @animations << animation
        end
        # Function that starts the Actor send animation
        def start_actor_send_animation
          log_debug('start_actor_send_animation')
          ya = Yuki::Animation
          animation = create_player_send_animation
          animation.parallel_add(ya.message_locked_animation.play_before(ya.send_command_to(self, :show_player_send_message)))
          animation.play_before(ya.send_command_to(@visual, :unlock)).play_before(ya.send_command_to(self, :dispose))
          animation.start
          @animations << animation
        end
        private
        # Function that creates all the sprites
        #
        # Please, call super of this function if you want to get the screenshot sprite!
        def create_all_sprites
          @screenshot_sprite = ShaderedSprite.new(@viewport)
          @screenshot_sprite.bitmap = @screenshot
          @screenshot_sprite.z = 100_000
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
          animation = Yuki::Animation.send_command_to(Graphics, :freeze)
          animation.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :dispose))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          return Yuki::Animation.wait(0)
        end
        # Function that creates the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
          return Yuki::Animation.send_command_to(Graphics, :transition)
        end
        # Function that creates the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
          return Yuki::Animation.wait(0)
        end
        # Function that creates the background movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_background_animation
          return Yuki::Animation.wait(0)
        end
        # Function that creates the paralax animation
        # @return [Yuki::Animation::TimedLoopAnimation]
        def create_paralax_animation
          return Yuki::Animation::TimedLoopAnimation.new(100)
        end
        # Function that creates the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
          return Yuki::Animation.wait(0)
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
          return Yuki::Animation.wait(0)
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
          return Yuki::Animation.wait(0)
        end
        # Function that get out all battler sprites
        # @return [Yuki::Animation::TimedAnimation]
        def go_out_battlers
          return Yuki::Animation.wait(0)
        end
        # Function that creates the flash animation before transition animation on battle
        # @param time_to_process [Float] number of seconds (with generic time) to process the animation
        # @param factor [Float]
        # @return [Yuki::Animation::ScalarAnimation]
        def create_flash_animation(time_to_process, factor)
          flasher = proc do |x|
            sin = Math.sin(x)
            col = sin.ceil.clamp(0, 1) * 255
            alpha = (sin.abs2.round(2) * 180).to_i
            @viewport.color.set(col, col, col, alpha)
          end
          return Yuki::Animation.scalar(time_to_process, flasher, :call, 0, factor * Math::PI)
        end
        # Function that shows the message about Wild appearing / Trainer wanting to fight
        def show_appearing_message
          @scene.display_message(appearing_message)
          @scene.message_window.blocking = false
        end
        # Return the "appearing/issuing" message
        # @return [String]
        def appearing_message
          return @scene.battle_info.trainer_battle? ? Message.trainer_issuing_a_challenge : Message.wild_battle_appearance
        end
        # Function that shows the message about enemy sending its Pokemon
        def show_enemy_send_message
          return unless @scene.battle_info.trainer_battle?
          @scene.display_message(enemy_send_message)
        end
        # Return the "Enemy sends out" message
        # @return [String]
        def enemy_send_message
          return Message.trainer_sending_pokemon_start
        end
        # Function that shows the message about player sending its Pokemon
        def show_player_send_message
          @scene.message_window.stay_visible = false
          if $game_variables[Yuki::Var::BT_Mode] == 5
            @scene.message_window.visible = false
          else
            @scene.display_message(player_send_message)
          end
        end
        # Return the third message shown
        # @return [String]
        def player_send_message
          return Message.player_sending_pokemon_start
        end
        # Get the enemy Pokemon sprites
        # @return [Array<ShaderedSprite>]
        def enemy_pokemon_sprites
          sprites = $game_temp.vs_type.times.map do |i|
            @scene.visual.battler_sprite(1, i)
          end.compact.select(&:pokemon).select { |sprite| sprite.pokemon.alive? }
          return sprites
        end
        # Get the actor sprites (and hide the mons)
        # @return [Array<ShaderedSprite>]
        def actor_sprites
          sprites = $game_temp.vs_type.times.map do |i|
            @scene.visual.battler_sprite(0, i)&.zoom = 0
            next(@scene.visual.battler_sprite(0, -i - 1))
          end.compact
          return sprites
        end
        # Get the actor Pokemon sprites
        # @return [Array<ShaderedSprite>]
        def actor_pokemon_sprites
          sprites = $game_temp.vs_type.times.map do |i|
            @scene.visual.battler_sprite(0, i)
          end.compact.select(&:pokemon).select { |sprite| sprite.pokemon.alive? }
          return sprites
        end
        # Function that gets the enemy sprites (and hide the mons)
        # @return [Array<ShaderedSprite>]
        def enemy_sprites
          sprites = $game_temp.vs_type.times.map do |i|
            @scene.visual.battler_sprite(1, i)&.zoom = 0
            next(@scene.visual.battler_sprite(1, -i - 1))
          end.compact
          return sprites
        end
        # Get the resource name according to the current state of the player and requested prefix
        # @param prefix [String] The prefix to use for the resource name
        # @return [String] The determined resource name
        def resource_name(prefix)
          resource_filename = @scene.battle_info.find_background_name_to_display(prefix) do |filename|
            next(RPG::Cache.battleback_exist?(filename))
          end
          unless RPG::Cache.battleback_exist?(resource_filename)
            log_debug("Defaulting to file #{prefix}_#{@default_battler_name}")
            resource_filename = "#{prefix}_#{@default_battler_name}"
          end
          return resource_filename
        end
      end
      # Trainer transition of Red/Blue/Yellow games
      class RBYTrainer < Base
        # Constant giving the X displacement done by the sprites
        # @return [Integer]
        DISPLACEMENT_X = 360
        private
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/rby_trainer'
        end
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_top_sprite
          create_enemy_sprites
          create_actors_sprites
          Graphics.sort_z
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = ShaderedSprite.new(@viewport)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name, :transition)
          @top_sprite.zoom = @viewport.rect.width / @top_sprite.width.to_f
          @top_sprite.y = (@viewport.rect.height - @top_sprite.height * @top_sprite.zoom_y) / 2
          @top_sprite.shader = setup_shader(shader_name)
          @to_dispose << @screenshot_sprite << @top_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
          @enemy_sprites = enemy_sprites
          @enemy_sprites.each do |sprite|
            sprite.x -= DISPLACEMENT_X
          end
        end
        # Function that creates the actor sprites
        def create_actors_sprites
          @actor_sprites = actor_sprites
          @actor_sprites.each do |sprite|
            sprite.x += DISPLACEMENT_X
          end
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
          animation = Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0)
          animation.play_before(create_fade_in_animation)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 255))
          animation.play_before(Yuki::Animation.wait(0.25))
          animation.play_before(Yuki::Animation.send_command_to(self, :dispose))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          transitioner = proc { |t| @top_sprite.shader.set_float_uniform('t', t) }
          return Yuki::Animation.scalar(2.75, transitioner, :call, 0, 1)
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
          animation = Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0)
          animation.play_before(Yuki::Animation.send_command_to(Graphics, :transition, 15))
          return animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
          ya = Yuki::Animation
          animations = @enemy_sprites.map do |sp|
            puts "Enemy sprite: #{sp.x}, #{sp.y}"
            ya.move(0.8, sp, sp.x, sp.y, sp.x + DISPLACEMENT_X, sp.y)
          end
          animation = animations.pop
          animations.each { |a| animation.parallel_add(a) }
          @actor_sprites.each do |sp|
            animation.parallel_add(ya.move(0.8, sp, sp.x, sp.y, sp.x - DISPLACEMENT_X, sp.y))
          end
          color = [0, 0, 0, 0]
          @enemy_sprites.select(&:shader).each { |sp| animation.play_before(ya.send_command_to(sp.shader, :set_float_uniform, 'color', color)) }
          cries = @enemy_sprites.select { |sp| sp.respond_to?(:cry) }
          cries.each { |sp| animation.play_before(ya.send_command_to(sp, :cry)) }
          return animation
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
          ya = Yuki::Animation
          animations = @actor_sprites.map do |sp|
            next(ya.move(1, sp, sp.x, sp.y, -sp.width, sp.y).parallel_play(sp.send_ball_animation))
          end
          animation = animations.pop
          animations.each { |anim| animation.parallel_add(anim) }
          actor_pokemon_sprites.each do |sp|
            throwed_anim = ya.wait(0.3)
            throwed_anim.play_before(ya.send_command_to(sp, :go_in))
            animation.parallel_add(throwed_anim)
          end
          animation.play_before(ya.wait(0.2))
          return animation
        end
        # Function that create the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
          ya = Yuki::Animation
          animations = @enemy_sprites.map do |sp|
            next(ya.move(0.8, sp, sp.x, sp.y, @viewport.rect.width + sp.width, sp.y).parallel_play(ya.wait(0.2).play_before(ya.send_command_to(sp, :show_next_frame)).root))
          end
          animation = animations.pop
          animations.each { |anim| animation.parallel_add(anim) }
          enemy_pokemon_sprites.each do |sp|
            animation.play_before(ya.send_command_to(sp, :go_in))
          end
          return animation
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :rby_trainer
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
          return Shader.create(name)
        end
      end
      # Wild transition of Red/Blue/Yellow games
      class RBYWild < Base
        # Constant giving the X displacement done by the sprites
        DISPLACEMENT_X = 360
        private
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
          return 10, 3
        end
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 0.5
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/rby_wild'
        end
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_top_sprite
          create_enemy_sprites
          create_actors_sprites
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = SpriteSheet.new(@viewport, *pre_transition_cells)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name, :transition)
          @top_sprite.zoom = @viewport.rect.width / @top_sprite.width.to_f
          @top_sprite.y = (@viewport.rect.height - @top_sprite.height * @top_sprite.zoom_y) / 2
          @top_sprite.visible = false
          @to_dispose << @screenshot_sprite << @top_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
          color = [0, 0, 0, 1]
          @enemy_sprites = enemy_pokemon_sprites
          @enemy_sprites.each do |sprite|
            sprite.shader.set_float_uniform('color', color)
            sprite.x -= DISPLACEMENT_X
          end
        end
        # Function that creates the actor sprites
        def create_actors_sprites
          @actor_sprites = actor_sprites
          @actor_sprites.each do |sprite|
            sprite.x += DISPLACEMENT_X
          end
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
          animation = create_flash_animation(1.5, 6)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0))
          animation.play_before(create_fade_in_animation)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 255))
          animation.play_before(Yuki::Animation.send_command_to(self, :dispose))
          animation.play_before(Yuki::Animation.wait(0.25))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          cells = (@top_sprite.nb_x * @top_sprite.nb_y).times.map { |i| [i % @top_sprite.nb_x, i / @top_sprite.nb_x] }
          animation = Yuki::Animation.send_command_to(@top_sprite, :visible=, true)
          animation.play_before(Yuki::Animation::SpriteSheetAnimation.new(pre_transition_cells_duration, @top_sprite, cells))
          return animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
          animation = Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0)
          animation.play_before(Yuki::Animation.send_command_to(Graphics, :transition, 15))
          return animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
          ya = Yuki::Animation
          #BALISE Movement du pokémon sauvage
          animations = @enemy_sprites.map do |sp|
            ya.move(0.3, sp, DISPLACEMENT_X, sp.y, sp.x + DISPLACEMENT_X, sp.y)
          end
          animation = animations.pop
          animations.each { |a| animation.parallel_add(a) }
          @actor_sprites.each do |sp|
            animation.parallel_add(ya.move(0.8, sp, sp.x, sp.y, sp.x - DISPLACEMENT_X, sp.y))
          end
          color = [0, 0, 0, 0]
          @enemy_sprites.select(&:shader).each { |sp| animation.play_before(ya.send_command_to(sp.shader, :set_float_uniform, 'color', color)) }
          cries = @enemy_sprites.select { |sp| sp.respond_to?(:cry) }
          cries.each do |sp|
            animation.play_before(ya.send_command_to(sp, :cry))
            animation.play_before(ya.send_command_to(sp, :shiny_animation))
          end
          return animation
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
          return Yuki::Animation.wait(0) if $game_variables[Yuki::Var::BT_Mode] == 5
          ya = Yuki::Animation
          animations = @actor_sprites.map do |sp|
            next(ya.move(1, sp, sp.x, sp.y, -sp.width, sp.y).parallel_play(sp.send_ball_animation))
          end
          animation = animations.pop
          animations.each { |anim| animation.parallel_add(anim) }
          actor_pokemon_sprites.each do |sp|
            throwed_anim = ya.wait(0.3)
            throwed_anim.play_before(ya.send_command_to(sp, :go_in))
            animation.parallel_add(throwed_anim)
          end
          animation.play_before(ya.wait(0.2))
          return animation
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
          return Shader.create(name)
        end
      end
      # Wild transition of Gold/Silver games
      class GoldWild < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 1
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/gold_wild'
        end
      end
      # Wild transition of Crystal game
      class CrystalWild < RBYWild
        private
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/crystal_wild'
        end
      end
      # Wild transition of Ruby/Saphir/Emerald/LeafGreen/FireRed games
      class RSWild < RBYWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'black_screen'
        end
        # Function that creates the top sprite
        def create_top_sprite
          @screenshot_sprite_right = Sprite.new(@viewport)
          @screenshot_sprite_right.bitmap = @screenshot
          @screenshot_sprite_right.z = @screenshot_sprite.z * 2
          @black_screen = Sprite.new(@viewport)
          @black_screen.load(pre_transition_sprite_name, :transition)
          @black_screen.z = @screenshot_sprite.z * 0.5
          @to_dispose << @screenshot_sprite << @screenshot_sprite_right << @black_screen
          @viewport.sort_z
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :shader=, setup_shader(shader_name, 1))
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite_right, :shader=, setup_shader(shader_name, 0)))
          root.play_before(Yuki::Animation.move(0.7, @screenshot_sprite, 0, 0, -@screenshot.width, 0)).parallel_play(Yuki::Animation.move(0.7, @screenshot_sprite_right, 0, 0, @screenshot.width, 0))
          return root
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @param line_offset [Integer] if line 0 or line 1 should be hidden
        # @return [Shader]
        def setup_shader(name, line_offset)
          shader = Shader.create(name)
          shader.set_float_uniform('textureHeight', @screenshot.height)
          shader.set_int_uniform('lineOffset', line_offset)
          return shader
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :rs_sprite_side
        end
      end
      # Wild Cave transition of Ruby/Saphir/Emerald/LeafGreen/FireRed games
      class RSCaveWild < RBYWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/ruby_saphir_wild'
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = ShaderedSprite.new(@viewport)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name, :transition)
          @top_sprite.zoom = @viewport.rect.width / @top_sprite.width.to_f
          @top_sprite.y = (@viewport.rect.height - @top_sprite.height * @top_sprite.zoom_y) / 2
          @top_sprite.shader = setup_shader(shader_name)
          @to_dispose << @screenshot_sprite << @top_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          transitioner = proc { |t| @top_sprite.shader.set_float_uniform('t', t) }
          return Yuki::Animation.scalar(1, transitioner, :call, 0, 1)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :black_to_white
        end
      end
      # Trainer transition of Red/Blue/Yellow games
      class RSTrainer < RBYTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/ruby_saphir_trainer'
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          transitioner = proc { |t| @top_sprite.shader.set_float_uniform('t', t) }
          root = create_flash_animation(1.5, 6)
          root.play_before(Yuki::Animation.scalar(1, transitioner, :call, 0, 1))
          return root
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :black_to_white
        end
      end
      # Wild transition of Diamant/Perle/Platine games
      class DPPWild < RSWild
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :dpp_sprite_side
        end
      end
      # Wild Cave transition of Diamant/Perle/Platine games
      class DPPCaveWild < RSCaveWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/diamant_perle_wild'
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          transitioner = proc { |t| @top_sprite.shader.set_float_uniform('t', t) }
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :set_origin, @screenshot_sprite.width / 2, @screenshot_sprite.height / 2)
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :set_position, @viewport.rect.width / 2, @viewport.rect.height / 2))
          root.play_before(Yuki::Animation.scalar(1, transitioner, :call, 0, 1)).parallel_play(create_zoom_animation)
          return root
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
          return Yuki::Animation.scalar(1, @screenshot_sprite, :zoom=, 1, 3)
        end
      end
      # Wild Sea transition of Diamant/Perle/Platine games
      class DPPSeaWild < RSCaveWild
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/diamant_perle_sea_wild'
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          screenshot_sprite_updater = proc { |r| @screenshot_sprite.shader.set_float_uniform('time', r) }
          top_sprite_updater = proc { |t| @top_sprite.shader.set_float_uniform('t', t) }
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :shader=, setup_shader(second_shader_name))
          root.play_before(Yuki::Animation.scalar(1.5, screenshot_sprite_updater, :call, 0, 5)).parallel_play(wait = Yuki::Animation.wait(0.5))
          wait.play_before(Yuki::Animation.scalar(1, top_sprite_updater, :call, 0, 2))
          return root
        end
        # Return the shader name
        # @return [Symbol]
        def second_shader_name
          return :sinusoidal
        end
      end
      # Trainer transition of Diamant/Perle/Platine games
      class DPPTrainer < RBYTrainer
        private
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
          return 3, 4
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/diamant_perle_trainer_01', 'spritesheets/diamant_perle_trainer_02'
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = SpriteSheet.new(@viewport, *pre_transition_cells)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name[0], :transition)
          @top_sprite.zoom = @viewport.rect.width / @top_sprite.width.to_f
          @top_sprite.ox = @top_sprite.width / 2
          @top_sprite.oy = @top_sprite.height / 2
          @top_sprite.x = @viewport.rect.width / 2
          @top_sprite.y = @viewport.rect.height / 2
          @top_sprite.visible = false
          @to_dispose << @screenshot_sprite << @top_sprite
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
          animation = create_flash_animation(0.7, 2)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0))
          animation.play_before(Yuki::Animation.send_command_to(@top_sprite, :visible=, true))
          animation.play_before(create_fade_in_animation)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 255))
          animation.play_before(Yuki::Animation.send_command_to(self, :dispose))
          animation.play_before(Yuki::Animation.wait(0.25))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          cells = (@top_sprite.nb_x * @top_sprite.nb_y).times.map { |i| [i % @top_sprite.nb_x, i / @top_sprite.nb_x] }
          animation = Yuki::Animation.scalar(0.4, @top_sprite, :zoom=, 0.2, @viewport.rect.width / @top_sprite.width.to_f)
          animation.parallel_play(Yuki::Animation.scalar(0.4, @top_sprite, :angle=, 90, -360))
          animation.play_before(Yuki::Animation::SpriteSheetAnimation.new(0.2, @top_sprite, cells))
          animation.play_before(Yuki::Animation.send_command_to(@top_sprite, :load, pre_transition_sprite_name[1], :transition))
          animation.play_before(Yuki::Animation::SpriteSheetAnimation.new(0.2, @top_sprite, cells))
          animation.play_before(Yuki::Animation.send_command_to(@top_sprite, :dispose))
          RPG::Cache.transition(pre_transition_sprite_name[1])
          return animation
        end
      end
      class Gen4Trainer < DPPTrainer
      end
      # Gym Leader transition of Diamant/Perle/Platine
      class DPPGymLeader < RBYTrainer
        # Start x coordinate of the bar
        BAR_START_X = 320
        # Y coordinate of the bar
        BAR_Y = 64
        # VS image x coordinate
        VS_X = 64
        # VS image y offset
        VS_OFFSET_Y = 30
        # Mugshot final x coordinate
        MUGSHOT_FINAL_X = BAR_START_X - 100
        # Mugshot pre final x coordinate (animation purposes)
        MUGSHOT_PRE_FINAL_X = MUGSHOT_FINAL_X - 20
        # Text offset Y
        TEXT_OFFSET_Y = 36
        # Update the transition
        def update
          super
          @default_battler_name = @scene.battle_info.battlers[1][0]
          @viewport.update
        end
        private
        # Get the enemy trainer name
        # @return [String]
        def trainer_name
          @scene.battle_info.names[1][0]
        end
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_vs_full_sprite
          create_vs_zoom_sprite
          create_mugshot_sprite
          Graphics.sort_z
        end
        # Function that creates the top sprite
        def create_top_sprite
          @bar = Sprite.new(@viewport)
          @bar.load(resource_name('vs_bar/bar_dpp'), :battleback)
          @bar.set_position(BAR_START_X, BAR_Y)
          @to_dispose << @screenshot_sprite << @bar
        end
        # Create VS sprite
        # @param bitmap [String] the bitmap filename
        # @param position [Array<Integer>] the x and y coordinates to set the sprite position
        # @return [LiteRGSS::Sprite] The created sprite
        def create_vs_sprite(bitmap, position, zoom)
          sprite = Sprite.new(@viewport)
          sprite.load(bitmap, :battleback)
          sprite.set_origin_div(2, 2)
          sprite.set_position(*position)
          sprite.zoom = zoom
          sprite.visible = false
          return sprite
        end
        # Create the full VS sprite
        def create_vs_full_sprite
          @vs_full = create_vs_sprite('vs_bar/vs_white', [VS_X, BAR_Y + VS_OFFSET_Y], 1)
          @to_dispose << @vs_full
        end
        # Create the VS zoom sprite
        def create_vs_zoom_sprite
          @vs_zoom = create_vs_sprite('vs_bar/vs_white', [VS_X, BAR_Y + VS_OFFSET_Y], 1)
          @to_dispose << @vs_zoom
        end
        # Function that creates the mugshot of the trainer
        def create_mugshot_sprite
          @mugshot = Sprite.new(@viewport)
          @mugshot.load(resource_name('vs_bar/mugshot'), :battleback)
          @mugshot.set_position(BAR_START_X, BAR_Y)
          @mugshot.shader = Shader.create(:color_shader)
          @mugshot.shader.set_float_uniform('color', [0, 0, 0, 0.8])
          @mugshot_text = Text.new(0, @viewport, -1, BAR_Y + TEXT_OFFSET_Y, 0, 16, trainer_name, 2, nil, 10)
          @to_dispose << @mugshot << @mugshot_text
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_pre_transition_animation
          animation = Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0)
          animation.play_before(Yuki::Animation.move(0.25, @bar, BAR_START_X, BAR_Y, 0, BAR_Y))
          animation.play_before(create_fade_in_animation)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 255))
          animation.play_before(Yuki::Animation.send_command_to(self, :dispose))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_fade_in_animation
          animation = Yuki::Animation.wait(4)
          animation.parallel_play(create_bar_loop_animation)
          animation.parallel_play(create_screenshot_shadow_animation)
          animation.parallel_play(create_vs_zoom_animation)
          animation.parallel_play(create_pre_transition_fade_out_animation)
          return animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_vs_zoom_animation
          animation = Yuki::Animation.wait(0.5)
          animation.play_before(Yuki::Animation.send_command_to(@vs_zoom, :visible=, true))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 2, 1))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 2, 1))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 2, 1))
          animation.play_before(Yuki::Animation.send_command_to(@vs_zoom, :visible=, false))
          animation.play_before(Yuki::Animation.send_command_to(@vs_full, :visible=, true))
          animation.play_before(Yuki::Animation.move(0.4, @mugshot, BAR_START_X, BAR_Y, MUGSHOT_PRE_FINAL_X, BAR_Y))
          animation.play_before(Yuki::Animation.move(0.15, @mugshot, MUGSHOT_PRE_FINAL_X, BAR_Y, MUGSHOT_FINAL_X, BAR_Y))
          animation.play_before(Yuki::Animation.move_discreet(0.35, @mugshot_text, 0, @mugshot_text.y, MUGSHOT_PRE_FINAL_X, @mugshot_text.y))
          return animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_pre_transition_fade_out_animation
          transitioner = proc { |t| @viewport.shader.set_float_uniform('color', [1, 1, 1, t]) }
          animation = Yuki::Animation.wait(3.25)
          animation.play_before(Yuki::Animation.scalar(0.5, transitioner, :call, 0, 1))
          return animation
        end
        # Create the bar movement loop
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_bar_loop_animation
          animation = Yuki::Animation.timed_loop_animation(0.25)
          movement = Yuki::Animation.move(0.25, @bar, 0, BAR_Y, -256, BAR_Y)
          return animation.parallel_play(movement)
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_screenshot_shadow_animation
          animation = Yuki::Animation.wait(1.5)
          animation.play_before(Yuki::Animation.send_command_to(self, :make_screenshot_shadow))
          return animation
        end
        def make_screenshot_shadow
          @screenshot_sprite.shader = Shader.create(:color_shader)
          @screenshot_sprite.shader.set_float_uniform('color', [0, 0, 0, 0.5])
          @mugshot.shader.set_float_uniform('color', [0, 0, 0, 0.0])
          @viewport.flash(Color.new(255, 255, 255), 20)
        end
      end
      # Wild transition of HeartGold/SoulSilver games
      class HGSSWild < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 1.5
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/heartgold_soulsilver_wild'
        end
      end
      # Wild Cave transition of HeartGold/SoulSilver games
      class HGSSCaveWild < RBYWild
        private
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 1.5
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/heartgold_soulsilver_cave_wild'
        end
      end
      # Wild Sea transition of HeartGold/SoulSilver games
      class HGSSSeaWild < RBYWild
        # A hash mapping symbolic names to sprite paths
        # @type [Hash{Symbol => String}]
        SPRITE_NAMES = {first: 'assets/heartgold_soulsilver_sea_wild_01', second: 'assets/heartgold_soulsilver_sea_wild_02', third: 'black_screen'}
        # Function that returns an image name
        # @return [String]
        def pre_transition_sprite_name(sprite_name)
          return SPRITE_NAMES[sprite_name]
        end
        # Function that create a sprite
        # @param sprite_name [Symbol]
        # @param z_factor [Integer]
        # @param y_offset [Integer]
        # @return [Sprite]
        def create_sprite(sprite_name, z_factor, y_offset = 0)
          sprite = Sprite.new(@viewport)
          sprite.z = @screenshot_sprite.z * z_factor
          sprite.load(pre_transition_sprite_name(sprite_name), :transition)
          sprite.zoom = @viewport.rect.width / sprite.width.to_f
          sprite.y = @viewport.rect.height + y_offset
          sprite.visible = false
          return sprite
        end
        # Function that creates the top sprite
        def create_top_sprite
          @bubble_sprite = create_sprite(:first, 2)
          @wave_sprite = create_sprite(:second, 3)
          @black_sprite = create_sprite(:third, 4, @wave_sprite.height)
          @to_dispose << @bubble_sprite << @wave_sprite << @black_sprite << @screenshot_sprite
          @viewport.sort_z
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :shader=, setup_shader(shader_name))
          root.play_before(start_shader_animation).parallel_play(start_bubble_animation).parallel_play(start_wave_animation).parallel_play(start_black_animation)
          return root
        end
        # Start the animation of the shader
        # @return [Yuki::Animation::ScalarAnimation]
        def start_shader_animation
          time_updater = proc { |r| @screenshot_sprite.shader.set_float_uniform('time', r) }
          time_animation = Yuki::Animation.scalar(1.5, time_updater, :call, 0, 5)
          return time_animation
        end
        # Start the animation of the bubble sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_bubble_animation
          root = Yuki::Animation.wait(0)
          root.play_before(Yuki::Animation.send_command_to(@bubble_sprite, :visible=, true))
          root.play_before(Yuki::Animation.scalar(1.5, @bubble_sprite, :y=, @bubble_sprite.y, -@viewport.rect.height)).parallel_play(oscillation_animation = Yuki::Animation.scalar(0.3, @bubble_sprite, :x=, @bubble_sprite.x, @bubble_sprite.x - 10, distortion: :SMOOTH_DISTORTION))
          oscillation_animation.play_before(Yuki::Animation.scalar(0.6, @bubble_sprite, :x=, @bubble_sprite.x - 10, @bubble_sprite.x + 10, distortion: :SIN))
          oscillation_animation.play_before(Yuki::Animation.scalar(0.6, @bubble_sprite, :x=, @bubble_sprite.x - 10, @bubble_sprite.x + 10, distortion: :SIN))
          return root
        end
        # Start the animation of the wave sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_wave_animation
          root = Yuki::Animation.wait(0.5)
          root.play_before(Yuki::Animation.send_command_to(@wave_sprite, :visible=, true))
          root.play_before(Yuki::Animation.move(1, @wave_sprite, @wave_sprite.x, @wave_sprite.y, @wave_sprite.x, -@viewport.rect.height))
          return root
        end
        # Start the animation of the black sprite
        # @return [Yuki::Animation::TimedAnimation]
        def start_black_animation
          root = Yuki::Animation.wait(0.5)
          root.play_before(Yuki::Animation.send_command_to(@black_sprite, :visible=, true))
          root.play_before(Yuki::Animation.move(1, @black_sprite, @black_sprite.x, @black_sprite.y, @black_sprite.x, -@viewport.rect.height + @wave_sprite.height))
          return root
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :sinusoidal
        end
      end
      # Trainer transition of Heartgold/Soulsilver games
      class HGSSTrainer < DPPTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/heartgold_soulsilver_trainer_01', 'spritesheets/heartgold_soulsilver_trainer_02'
        end
      end
      # Gym Leader transition of Heartgold/Soulsilver
      class HGSSGymLeader < DPPGymLeader
        # VS image y offset
        VS_OFFSET_Y = 35
        # Text offset Y
        TEXT_OFFSET_Y = 41
        # Function that creates the top sprite
        def create_top_sprite
          @bar = Sprite.new(@viewport)
          @bar.load(resource_name('vs_bar/bar_hgss'), :battleback)
          @bar.set_position(BAR_START_X, BAR_Y)
          @to_dispose << @screenshot_sprite << @bar
        end
        # Function that creates the mugshot of the trainer
        def create_mugshot_sprite
          super
          @mugshot.set_position(BAR_START_X, BAR_Y)
          @mugshot_text.set_position(-1, BAR_Y + TEXT_OFFSET_Y)
        end
        # Create the full VS sprite
        def create_vs_full_sprite
          @vs_full = create_vs_sprite('vs_bar/vs_red_crossed', [VS_X, BAR_Y + VS_OFFSET_Y], 0.5)
          @to_dispose << @vs_full
        end
        # Create the VS zoom sprite
        def create_vs_zoom_sprite
          @vs_zoom = create_vs_sprite('vs_bar/vs_red_crossed', [VS_X, BAR_Y + VS_OFFSET_Y], 0.5)
          @to_dispose << @vs_zoom
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_fade_in_animation
          animation = Yuki::Animation.wait(4)
          animation.parallel_play(create_bar_loop_animation)
          animation.parallel_play(create_screenshot_shadow_animation)
          animation.parallel_play(create_vs_zoom_animation)
          animation.parallel_play(create_pre_transition_fade_out_animation)
          animation.parallel_play(create_zoom_oscillation_animation)
          return animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_vs_zoom_animation
          animation = Yuki::Animation.wait(0.5)
          animation.play_before(Yuki::Animation.send_command_to(@vs_zoom, :visible=, true))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 1, 0.5))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 1, 0.5))
          animation.play_before(Yuki::Animation.scalar(0.15, @vs_zoom, :zoom=, 1, 0.5))
          animation.play_before(Yuki::Animation.send_command_to(@vs_zoom, :visible=, false))
          animation.play_before(Yuki::Animation.send_command_to(@vs_full, :visible=, true))
          animation.play_before(Yuki::Animation.move(0.4, @mugshot, BAR_START_X, BAR_Y, MUGSHOT_PRE_FINAL_X, BAR_Y))
          animation.play_before(Yuki::Animation.move(0.15, @mugshot, MUGSHOT_PRE_FINAL_X, BAR_Y, MUGSHOT_FINAL_X, BAR_Y))
          animation.play_before(Yuki::Animation.move_discreet(0.35, @mugshot_text, 0, @mugshot_text.y, MUGSHOT_PRE_FINAL_X, @mugshot_text.y))
          return animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_zoom_oscillation_animation
          animation = Yuki::Animation.timed_loop_animation(0.05)
          animation.parallel_play(Yuki::Animation.scalar(0.05, @vs_full, :x=, @vs_full.x - 1, @vs_full.x + 1, distortion: :SIN))
          animation.parallel_play(Yuki::Animation.scalar(0.05, @vs_full, :y=, @vs_full.y - 1, @vs_full.y + 1, distortion: :SIN))
          return animation
        end
        # @return [Yuki::Animation::TimedAnimation] The created animation
        def create_bar_loop_animation
          animation = Yuki::Animation.timed_loop_animation(0.15)
          movement = Yuki::Animation.move(0.15, @bar, 0, BAR_Y, -256, BAR_Y)
          return animation.parallel_play(movement)
        end
      end
      # Wild Sea transition of Black/White games
      class BWWild < RBYWild
        # Function that creates the top sprite
        def create_top_sprite
          @screenshot_sprite.shader = setup_shader(shader_name)
          @to_dispose << @screenshot_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :set_origin, @screenshot_sprite.width / 2, @screenshot_sprite.height / 2)
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :set_position, @viewport.rect.width / 2, @viewport.rect.height / 2))
          root.play_before(create_shader_animation)
          root.play_before(create_zoom_animation)
          return root
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
          radius_updater = proc { |radius| @screenshot_sprite.shader.set_float_uniform('radius', radius) }
          alpha_updater = proc { |alpha| @screenshot_sprite.shader.set_float_uniform('alpha', alpha) }
          tau_updater = proc { |tau| @screenshot_sprite.shader.set_float_uniform('tau', tau) }
          time_to_process = 0.6
          root = Yuki::Animation.wait(0)
          root.play_before(Yuki::Animation.scalar(time_to_process, radius_updater, :call, 0, 0.5)).parallel_play(Yuki::Animation.scalar(time_to_process, alpha_updater, :call, 1, 0.5)).parallel_play(Yuki::Animation.scalar(time_to_process, tau_updater, :call, 0.5, 1))
          return root
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
          return Yuki::Animation.scalar(0.4, @screenshot_sprite, :zoom=, 1, 3)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :yuki_weird
        end
      end
      # Wild Sea transition of Black/White games
      class BWSeaWild < RBYWild
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          time_updater = proc { |r| @screenshot_sprite.shader.set_float_uniform('time', r) }
          root = Yuki::Animation.send_command_to(self, :setup_shader, shader_name)
          root.play_before(Yuki::Animation.scalar(1.5, time_updater, :call, 0, 5))
          return root
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :bw_wild_sea
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
          @screenshot_sprite.shader = Shader.create(name)
          @screenshot_sprite.shader.set_float_uniform('textureWidth', @viewport.rect.width)
          @screenshot_sprite.shader.set_float_uniform('textureHeight', @viewport.rect.height)
        end
      end
      # Trainer transition of Black/White games
      class BWTrainer < RBYTrainer
        # Function that creates the top sprite
        def create_top_sprite
          @screenshot_sprite.shader = setup_shader(shader_name)
          @to_dispose << @screenshot_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :set_origin, @screenshot_sprite.width / 2, @screenshot_sprite.height / 2)
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :set_position, @viewport.rect.width / 2, @viewport.rect.height / 2))
          root.play_before(create_zoom_animation)
          root.play_before(create_shader_animation)
          return root
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
          radius_updater = proc { |radius| @screenshot_sprite.shader.set_float_uniform('radius', radius) }
          alpha_updater = proc { |alpha| @screenshot_sprite.shader.set_float_uniform('alpha', alpha) }
          tau_updater = proc { |tau| @screenshot_sprite.shader.set_float_uniform('tau', tau) }
          time_to_process = 1.4
          root = Yuki::Animation.scalar(time_to_process, radius_updater, :call, 0, 0.5)
          root.parallel_play(Yuki::Animation.scalar(time_to_process, alpha_updater, :call, 1, 1))
          root.parallel_play(Yuki::Animation.scalar(time_to_process, tau_updater, :call, 0.5, 0.5))
          return root
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
          return Yuki::Animation.scalar(0.1, @screenshot_sprite, :zoom=, 1, 1.1)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :yuki_weird
        end
      end
      # Trainer transition of X/Y games
      class XYTrainer < Base
        # Unitary deltaX of the background
        DX = -Math.cos(-3 * Math::PI / 180)
        # Unitary deltaY of the background
        DY = Math.sin(-3 * Math::PI / 180)
        private
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_background
          create_degrade
          create_halos
          create_battlers
          create_shader
          @viewport.sort_z
        end
        def create_background
          @background = Sprite.new(@viewport).set_origin(@viewport.rect.width, @viewport.rect.height)
          @background.set_position(@viewport.rect.width / 2, @viewport.rect.height / 2)
          @background.load('battle_bg', :transition)
          @background.angle = -3
          @background.z = @screenshot_sprite.z - 1
          @to_dispose << @background
        end
        def create_degrade
          @degrade = Sprite.new(@viewport).set_origin(0, 90).set_position(0, 90).load('battle_deg', :transition)
          @degrade.zoom_y = 0.10
          @degrade.opacity = 255 * @degrade.zoom_y
          @degrade.z = @background.z
          @to_dispose << @degrade
        end
        def create_halos
          @halo1 = Sprite.new(@viewport).load('battle_halo1', :transition)
          @halo1.z = @background.z
          @to_dispose << @halo1
          @halo2 = Sprite.new(@viewport).set_origin(-640, 0).load('battle_halo2', :transition)
          @halo2.z = @background.z
          @to_dispose << @halo2
          @halo3 = Sprite.new(@viewport).set_origin(-640, 0).set_position(640, 0).load('battle_halo2', :transition)
          @halo3.z = @background.z
          @to_dispose << @halo3
        end
        def create_battlers
          @sprites = []
          positions = calculate_positions
          positions.each_with_index do |pos_x, index|
            sprite_small_filename, sprite_big_filename = *determine_battler_filename(@scene.battle_info.battlers[1][index])
            small_sprite = Sprite.new(@viewport)
            small_sprite.load(sprite_small_filename, :battler)
            small_sprite.set_position(-small_sprite.width / 4, @viewport.rect.height)
            small_sprite.set_origin(small_sprite.width / 2, small_sprite.height)
            small_sprite.z = @background.z
            big_sprite = Sprite.new(@viewport)
            big_sprite.load(sprite_big_filename, :battler)
            big_sprite.set_position(pos_x, @viewport.rect.height)
            big_sprite.set_origin(big_sprite.width / 2, big_sprite.height)
            big_sprite.z = @background.z
            big_sprite.opacity = 0
            @sprites << [small_sprite, big_sprite]
          end
          @actor_sprites = actor_sprites
        end
        # Determine the right filenames for the transition sprites
        # @param filename [String]
        # @return [Array<String>]
        def determine_battler_filename(filename)
          sprite_small_filename = "#{filename.gsub('_big', '')}_sma"
          sprite_big_filename = filename.include?('_big') ? filename : "#{filename}_big"
          return sprite_small_filename, sprite_big_filename
        end
        def create_shader
          @shader = Shader.create(:battle_backout)
          6.times do |i|
            @shader.set_texture_uniform("bk#{i}", RPG::Cache.transition("black_out0#{i}"))
          end
          @screenshot_sprite.shader = @shader
          @shader_time_update = proc { |t| @shader.set_float_uniform('time', t) }
        end
        def create_pre_transition_animation
          root = Yuki::Animation::ScalarAnimation.new(1.2, @shader_time_update, :call, 0, 1)
          root.play_before(Yuki::Animation.send_command_to(Graphics, :freeze))
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :dispose))
          return root
        end
        def create_background_animation
          background_setter = proc do |i|
            t = (1 - Math.cos(2 * Math::PI * i)) / 10 + i
            d = (t * 1200) % 120
            @background.set_position(d * DX + @viewport.rect.width / 2, d * DY + @viewport.rect.height / 2)
          end
          root = Yuki::Animation::TimedLoopAnimation.new(10)
          root.play_before(Yuki::Animation::ScalarAnimation.new(10, background_setter, :call, 0, 1))
          root.parallel_play(halo = Yuki::Animation::TimedLoopAnimation.new(0.5))
          halo.play_before(h1 = Yuki::Animation::ScalarAnimation.new(0.5, @halo2, :ox=, 0, 640))
          h1.parallel_play(Yuki::Animation::ScalarAnimation.new(0.5, @halo3, :ox=, 0, 640))
          return root
        end
        def create_paralax_animation
          root = Yuki::Animation.wait(0.1)
          root.play_before(Yuki::Animation::ScalarAnimation.new(0.4, @degrade, :zoom_y=, 0.10, 1.25))
          root.parallel_play(Yuki::Animation.opacity_change(0.2, @degrade, 0, 255))
          root.play_before(Yuki::Animation::ScalarAnimation.new(0.1, @degrade, :zoom_y=, 1.25, 1))
          return root
        end
        def create_sprite_move_animation
          root = Yuki::Animation.wait(0)
          parallel = nil
          positions = calculate_positions
          @sprites.each_with_index do |sprite, index|
            small_sprite, big_sprite = sprite
            end_x = positions[index]
            move_animation = Yuki::Animation.move(0.6, small_sprite, small_sprite.x, small_sprite.y, end_x, small_sprite.y)
            fade_animation = Yuki::Animation.opacity_change(0.4, small_sprite, 255, 0)
            fade_animation.parallel_play(Yuki::Animation.opacity_change(0.4, big_sprite, 0, 255))
            if index == 0
              root.play_before(parallel = move_animation)
              root.play_before(Yuki::Animation.wait(0.3))
              root.play_before(fade_animation)
            else
              parallel.parallel_play(move_animation)
              parallel.play_before(fade_animation)
            end
          end
          return root
        end
        def create_enemy_send_animation
          enemy_sprites.each { |sp| sp.visible = false }
          root = Yuki::Animation.wait(0)
          parallel = nil
          positions = calculate_positions
          @sprites.each_with_index do |sprite, index|
            _, big_sprite = sprite
            pos_x = positions[index] - 40
            move_animation = Yuki::Animation.move(0.6, big_sprite, big_sprite.x, big_sprite.y, pos_x, big_sprite.y)
            go_out_animation = Yuki::Animation.move(0.4, big_sprite, pos_x, big_sprite.y, @viewport.rect.width * 1.5, big_sprite.y)
            go_out_animation.parallel_play(Yuki::Animation.opacity_change(0.4, big_sprite, 255, 0))
            if index == 0
              root.play_before(parallel = move_animation)
              root.play_before(go_out_animation)
            else
              parallel.parallel_play(move_animation)
              parallel.play_before(go_out_animation)
            end
          end
          root.play_before(Yuki::Animation.send_command_to(Graphics, :freeze))
          root.play_before(Yuki::Animation.send_command_to(self, :hide_all_sprites))
          root.play_before(Yuki::Animation.send_command_to(Graphics, :transition))
          enemy_pokemon_sprites.each do |sp|
            root.play_before(Yuki::Animation.send_command_to(sp, :go_in))
          end
          return root
        end
        # Function that create the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_player_send_animation
          ya = Yuki::Animation
          animations = @actor_sprites.map do |sp|
            next(ya.move(1, sp, sp.x, sp.y, -sp.width, sp.y).parallel_play(sp.send_ball_animation))
          end
          animation = animations.pop
          animations.each { |anim| animation.parallel_add(anim) }
          actor_pokemon_sprites.each do |sp|
            throwed_anim = ya.wait(0.3)
            throwed_anim.play_before(ya.send_command_to(sp, :go_in))
            animation.parallel_add(throwed_anim)
          end
          animation.play_before(ya.wait(0.2))
          return animation
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
          root = Yuki::Animation.wait(0.3)
          positions = calculate_positions
          @sprites.each_with_index do |sprite, index|
            _, big_sprite = sprite
            pos_x = positions[index]
            root.play_before(go_in = Yuki::Animation.move(0.4, big_sprite, big_sprite.x, big_sprite.y, pos_x - 40, big_sprite.y))
            go_in.parallel_play(Yuki::Animation.opacity_change(0.4, big_sprite, 0, 255))
            root.play_before(Yuki::Animation.move(0.4, big_sprite, pos_x - 40, big_sprite.y, pos_x, big_sprite.y))
          end
          return root
        end
        # Function to calculate positions based on number of sprites
        # @param trainer_is_couple [Boolean]
        # @param vs_type [Array<Integer>]
        # @param width [Integer]
        # @return [Array<Integer>]
        def calculate_positions
          position_count = @scene.logic.battle_info.trainer_is_couple ? 1 : $game_temp.vs_type
          width = @viewport.rect.width
          case position_count
          when 1
            return [width / 2]
          when 2
            spacing = width / 3
            return [spacing, 2 * spacing]
          when 3
            spacing = width / 4
            return [spacing, 2 * spacing, 3 * spacing]
          else
            return []
          end
        end
        # Function that get out all battler sprites
        # @return [Yuki::Animation::TimedAnimation]
        def go_out_battlers
          battler_sprites = actor_pokemon_sprites + enemy_pokemon_sprites
          sprite_animations = Yuki::Animation.wait(0)
          battler_sprites.each do |sprite|
            sprite_animations.parallel_play(Yuki::Animation.send_command_to(sprite, :go_out))
          end
          return sprite_animations
        end
        def hide_all_sprites
          @to_dispose.each do |sprite|
            sprite.visible = false if sprite.is_a?(Sprite)
          end
        end
      end
      class Gen6Trainer < XYTrainer
      end
      # Trainer transition of Battle Frontier
      class BattleFrontierVertical < RSTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/battle_frontier_vertical'
        end
      end
      class BattleFrontierHorizontal < RSTrainer
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'shaders/battle_frontier_horizontal'
        end
      end
      # Red transition of Heartgold/Soulsilver games
      class Red < RBYTrainer
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
          return 10, 3
        end
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 1
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'pokeball_gold', 'spritesheets/crystal_wild'
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = ShaderedSprite.new(@viewport)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name[0], :transition)
          @top_sprite.zoom = 0.75
          @top_sprite.y = (@viewport.rect.height - @top_sprite.height * @top_sprite.zoom_y) / 2
          @top_sprite.x = (@viewport.rect.width - @top_sprite.width * @top_sprite.zoom_x) / 2
          @cell_sprite = SpriteSheet.new(@viewport, *pre_transition_cells)
          @cell_sprite.z = @screenshot_sprite.z * 3
          @cell_sprite.load(pre_transition_sprite_name[1], :transition)
          @cell_sprite.zoom = @viewport.rect.width / @cell_sprite.width.to_f
          @cell_sprite.y = (@viewport.rect.height - @cell_sprite.height * @cell_sprite.zoom_y) / 2
          @cell_sprite.visible = false
          @to_dispose << @screenshot_sprite << @top_sprite << @cell_sprite
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          cells = (@cell_sprite.nb_x * @cell_sprite.nb_y).times.map { |i| [i % @cell_sprite.nb_x, i / @cell_sprite.nb_x] }
          root = create_flash_animation(1.5, 6)
          root.play_before(Yuki::Animation.send_command_to(@cell_sprite, :visible=, true))
          root.play_before(Yuki::Animation::SpriteSheetAnimation.new(pre_transition_cells_duration, @cell_sprite, cells))
          return root
        end
      end
      # Team Rocket transition of Heartgold/Soulsilver games
      class TeamRocket < RBYTrainer
        # Y coordinate of the bar
        BAR_Y = 115
        # Text offset Y
        TEXT_Y = BAR_Y + 83
        # Text offset X
        TEXT_X = 105
        # Get the enemy trainer name
        # @return [String]
        def trainer_name
          @scene.battle_info.names[1][0]
        end
        # Return the pre_transtion sprite name
        # @return [Array<String>]
        def pre_transition_sprite_name
          return 'assets/team_rocket/hgss_bg_1', 'assets/team_rocket/hgss_bg_2', 'assets/team_rocket/hgss_strobes'
        end
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_strobes_sprite
          create_screenshot_sprite
          create_background_sprite
          create_mugshot_sprite
          create_mugshot_text
          @viewport.sort_z
        end
        # Function that creates the top sprite (unused here)
        def create_top_sprite
        end
        # Creates and configures the strobe sprite
        def create_strobes_sprite
          @strobes_sprite = ShaderedSprite.new(@viewport)
          @strobes_sprite.z = @screenshot_sprite.z * 3
          @strobes_sprite.load(pre_transition_sprite_name[2], :transition)
          @to_dispose << @strobes_sprite
        end
        # Creates the screenshot sprites
        def create_screenshot_sprite
          @screenshot_sprite.visible = false
          @top_screenshot_sprite = ShaderedSprite.new(@viewport)
          @top_screenshot_sprite.bitmap = @screenshot
          @top_screenshot_sprite.set_position(0, 0)
          @top_screenshot_sprite.set_rect(@top_screenshot_sprite.x, @top_screenshot_sprite.y, @top_screenshot_sprite.width, @top_screenshot_sprite.height / 2)
          @top_screenshot_sprite.z = @screenshot_sprite.z * 2
          @bottom_screenshot_sprite = ShaderedSprite.new(@viewport)
          @bottom_screenshot_sprite.bitmap = @screenshot
          @bottom_screenshot_sprite.set_position(0, @viewport.rect.height / 2)
          @bottom_screenshot_sprite.set_rect(@bottom_screenshot_sprite.x, @viewport.rect.height / 2, @bottom_screenshot_sprite.width, @bottom_screenshot_sprite.height / 2)
          @bottom_screenshot_sprite.z = @screenshot_sprite.z * 2
          @to_dispose << @screenshot_sprite << @top_screenshot_sprite << @bottom_screenshot_sprite
        end
        # Creates and configures the background sprites
        def create_background_sprite
          @first_background_sprite = ShaderedSprite.new(@viewport)
          @first_background_sprite.load(pre_transition_sprite_name[0], :transition)
          @first_background_sprite.zoom = @viewport.rect.width / @first_background_sprite.width.to_f
          @first_background_sprite.y = (@viewport.rect.height - @first_background_sprite.height * @first_background_sprite.zoom_y) / 2
          @first_background_sprite.z = @screenshot_sprite.z
          @second_background_sprite = ShaderedSprite.new(@viewport)
          @second_background_sprite.load(pre_transition_sprite_name[1], :transition)
          @second_background_sprite.zoom = @viewport.rect.width / @second_background_sprite.width.to_f
          @second_background_sprite.y = (@viewport.rect.height - @second_background_sprite.height * @second_background_sprite.zoom_y) / 2
          @second_background_sprite.z = @first_background_sprite.z + 1
          @second_background_sprite.opacity = 0
          @to_dispose << @first_background_sprite << @second_background_sprite
        end
        # Creates and configures the mugshot sprite for the trainer
        def create_mugshot_sprite
          @mugshot_sprite = ShaderedSprite.new(@viewport)
          @mugshot_sprite.load(resource_name('vs_bar/mugshot'), :battleback)
          @mugshot_sprite.set_position(@viewport.rect.width, BAR_Y)
          @mugshot_sprite.z = @screenshot_sprite.z * 3
          @mugshot_sprite.zoom = 1.4
          @to_dispose << @mugshot_sprite
        end
        # Creates and configures the text for the mugshot
        def create_mugshot_text
          @mugshot_text = Text.new(0, @viewport, -1, BAR_Y + TEXT_Y, 0, 16, trainer_name, 2, nil, 10)
          @mugshot_text.z = @screenshot_sprite.z * 3
          @to_dispose << @mugshot_text
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          animation = Yuki::Animation.wait(2.8).parallel_play(create_strobes_animation).parallel_play(create_screenshot_animation).parallel_play(create_second_background_animation).parallel_play(create_mugshot_animation).parallel_play(create_pre_transition_fade_out_animation)
          return animation
        end
        # Function that creates the strobes animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_strobes_animation
          start_x = @strobes_sprite.x
          end_x = -@viewport.rect.width
          start_y = end_y = @strobes_sprite.y
          animation = Yuki::Animation.move(0.5, @strobes_sprite, start_x, start_y, end_x, end_y).parallel_play(create_flash_animation(0.5, 2))
          animation.play_before(Yuki::Animation.send_command_to(@strobes_sprite, :visible=, false))
          return animation
        end
        # Function that creates the screenshot animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_screenshot_animation
          animation = Yuki::Animation.wait(0.5)
          animation.play_before(create_top_screenshot_animation).parallel_play(create_bottom_screenshot_animation)
          return animation
        end
        # Function that creates the top screenshot animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_top_screenshot_animation
          start_x = end_x = @top_screenshot_sprite.x
          start_y = @top_screenshot_sprite.y
          end_y = -@viewport.rect.height / 2
          return Yuki::Animation.move(0.1, @top_screenshot_sprite, start_x, start_y, end_x, end_y)
        end
        # Function that creates the bottom screenshot animation
        # @return [Yuki::Animation::Dim2Animation]
        def create_bottom_screenshot_animation
          start_x = end_x = @bottom_screenshot_sprite.x
          start_y = @bottom_screenshot_sprite.y
          end_y = @viewport.rect.height
          return Yuki::Animation.move(0.1, @bottom_screenshot_sprite, start_x, start_y, end_x, end_y)
        end
        # Function that creates the background animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_second_background_animation
          animation = Yuki::Animation.wait(1)
          animation.play_before(Yuki::Animation.opacity_change(0.15, @second_background_sprite, 0, 255))
          return animation
        end
        # Function that creates the mugshot animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_mugshot_animation
          mugshot_sprite_real_width = @mugshot_sprite.width * @mugshot_sprite.zoom_x
          start_x = @mugshot_sprite.x
          center_x = @viewport.rect.width / 2 - (mugshot_sprite_real_width / 2)
          end_x = -mugshot_sprite_real_width
          flash_animation = Yuki::Animation.wait(0.15)
          flash_animation.play_before(Yuki::Animation.send_command_to(@viewport, :flash, Color.new(255, 255, 255), 20))
          mugshot_entry = Yuki::Animation.move(0.15, @mugshot_sprite, start_x, BAR_Y, center_x, BAR_Y)
          mugshot_exit = Yuki::Animation.move(0.15, @mugshot_sprite, center_x, BAR_Y, end_x, BAR_Y)
          text_entry = Yuki::Animation.move_discreet(0.15, @mugshot_text, start_x, TEXT_Y, center_x + TEXT_X, TEXT_Y)
          text_exit = Yuki::Animation.move_discreet(0.15, @mugshot_text, center_x + TEXT_X, TEXT_Y, end_x, TEXT_Y)
          animation = Yuki::Animation.wait(1)
          animation.play_before(mugshot_entry).parallel_play(text_entry).parallel_play(flash_animation)
          animation.play_before(Yuki::Animation.wait(1))
          animation.play_before(mugshot_exit).parallel_play(text_exit)
          return animation
        end
        # Function that creates the pre transition fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_fade_out_animation
          transitioner = proc { |t| @viewport.shader.set_float_uniform('color', [1, 1, 1, t]) }
          animation = Yuki::Animation.wait(2.45)
          animation.play_before(Yuki::Animation.scalar(0.25, transitioner, :call, 0, 1))
          animation.play_before(Yuki::Animation.wait(0.10))
          return animation
        end
      end
    end
    WILD_TRANSITIONS.default = Transition::Base
    TRAINER_TRANSITIONS.default = Transition::Base
    public
    TRAINER_TRANSITIONS[2] = Transition::RBYTrainer
    TRAINER_TRANSITIONS.default = Transition::RBYTrainer
    public
    WILD_TRANSITIONS[0] = Transition::RBYWild
    WILD_TRANSITIONS.default = Transition::RBYWild
    public
    WILD_TRANSITIONS[1] = Transition::GoldWild
    WILD_TRANSITIONS[2] = Transition::CrystalWild
    public
    WILD_TRANSITIONS[3] = Transition::RSWild
    public
    WILD_TRANSITIONS[10] = Transition::RSCaveWild
    public
    TRAINER_TRANSITIONS[5] = Transition::RSTrainer
    Visual.register_transition_resource(5, :sprite)
    public
    WILD_TRANSITIONS[4] = Transition::DPPWild
    public
    WILD_TRANSITIONS[9] = Transition::DPPCaveWild
    public
    WILD_TRANSITIONS[12] = Transition::DPPSeaWild
    public
    TRAINER_TRANSITIONS[1] = Transition::DPPTrainer
    Visual.register_transition_resource(1, :sprite)
    public
    TRAINER_TRANSITIONS[3] = Transition::DPPGymLeader
    Visual.register_transition_resource(3, :sprite)
    public
    WILD_TRANSITIONS[5] = Transition::HGSSWild
    public
    WILD_TRANSITIONS[6] = Transition::HGSSCaveWild
    public
    WILD_TRANSITIONS[7] = Transition::HGSSSeaWild
    public
    TRAINER_TRANSITIONS[4] = Transition::HGSSTrainer
    Visual.register_transition_resource(4, :sprite)
    public
    TRAINER_TRANSITIONS[10] = Transition::HGSSGymLeader
    Visual.register_transition_resource(11, :sprite)
    public
    WILD_TRANSITIONS[8] = Transition::BWWild
    public
    WILD_TRANSITIONS[11] = Transition::BWSeaWild
    public
    TRAINER_TRANSITIONS[9] = Transition::BWTrainer
    Visual.register_transition_resource(9, :sprite)
    public
    TRAINER_TRANSITIONS[0] = Transition::XYTrainer
    Visual.register_transition_resource(0, :artwork_full)
    public
    TRAINER_TRANSITIONS[6] = Transition::BattleFrontierVertical
    TRAINER_TRANSITIONS[7] = Transition::BattleFrontierHorizontal
    Visual.register_transition_resource(6, :sprite)
    Visual.register_transition_resource(7, :sprite)
    public
    TRAINER_TRANSITIONS[8] = Transition::Red
    Visual.register_transition_resource(8, :sprite)
    public
    TRAINER_TRANSITIONS[11] = Transition::TeamRocket
    register_transition_resource(11, :sprite)
  end
  # Tell if Visual3D should be used
  BATTLE_CAMERA_3D = Configs.settings.is_use_battle_camera_3d
  # Class that manage all the things that are visually seen on the screen used only when BATTLECAMERA is true
  class Visual3D < Visual
    # Return half of the width of the default resolution
    HALF_WIDTH = 160
    # Return half of the height of the default resolution
    HALF_HEIGHT = 120
    # Camera of the battle
    # @return [Fake3D::Camera]
    attr_accessor :camera
    # Camera Positionner of the camera
    # @return [Fake3D::Camera]
    attr_accessor :camera_positionner
    # @return Array of the sprite applied to the camera
    attr_accessor :sprites3D
    # Create a new visual instance
    # @param scene [Scene] scene that hold the logic object
    def initialize(scene)
      @sprites3D = []
      super
      @camera.apply_to(@sprites3D + @background.battleback_sprite3D)
    end
    # Create the Visual viewport
    def create_viewport
      @viewport = Viewport.create(:main, 500)
      @viewport.extend(Viewport::WithToneAndColors)
      @viewport.shader = Shader.create(:map_shader)
      @viewport_sub = Viewport.create(:main, 501)
      create_cameras
    end
    # Create the camera and the camera_positionner
    def create_cameras
      @camera = Fake3D::Camera.new(viewport)
      @camera_positionner = CameraPositionner.new(@camera)
    end
    # Update the visuals
    def update
      super
      @sprites3D&.reject!(&:disposed?)
      @background.update_battleback
      update_camera
    end
    private
    # Create the default background
    def create_background
      case background_name
      when 'back_grass'
        @background = BattleUI::BattleBackGrass.new(viewport, @scene)
      else
        @background = BattleUI::BattleBackGrass.new(viewport, @scene)
      end
    end
    # Create the battler sprites (Trainer + Pokemon)
    def create_battlers
      infos = @scene.battle_info
      (logic = @scene.logic).bank_count.times do |bank|
        infos.battlers[bank].each_with_index do |battler, position|
          sprite = BattleUI::TrainerSprite3D.new(@viewport, @scene, battler, bank, position, infos)
          @sprites3D.append(sprite)
          store_battler_sprite(bank, -position - 1, sprite)
        end
        infos.vs_type.times do |position|
          sprite = BattleUI::PokemonSprite3D.new(@viewport, @scene, @camera, @camera_positionner)
          sprite.pokemon = logic.battler(bank, position)
          @sprites3D.append(sprite) unless sprite.pokemon.nil?
          @sprites3D.append(sprite.shadow) unless sprite.pokemon.nil?
          @animatable << sprite
          store_battler_sprite(bank, position, sprite)
          create_info_bar(bank, position)
          create_ability_bar(bank, position)
          create_item_bar(bank, position)
        end
        create_team_info(bank)
      end
      hide_info_bars(true)
    end
    # End of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_end(pokemon_index)
      @player_choice_ui.go_out
      @animations << @player_choice_ui
      start_center_animation
      if @player_choice_ui.result != :attack
        spc_stop_bouncing_animation(pokemon_index)
        wait_for_animation
      end
      @locking = false
    end
    # Begining of the show_player_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_player_choice_begin(pokemon_index)
      pokemon = @scene.logic.battler(0, pokemon_index)
      @locking = true
      @player_choice_ui.reset(@scene.logic.switch_handler.can_switch?(pokemon))
      if @player_choice_ui.out?
        @player_choice_ui.go_in
        @animations << @player_choice_ui
        wait_for_animation
      end
      start_camera_animation
      spc_show_message(pokemon_index)
      spc_start_bouncing_animation(pokemon_index)
    end
    # End of the skill_choice
    # @param pokemon_index [Integer] Index of the Pokemon in the party
    def show_skill_choice_end(pokemon_index)
      spc_stop_bouncing_animation(pokemon_index)
      @skill_choice_ui.go_out
      @animations << @skill_choice_ui
      start_center_animation
      wait_for_animation
      @locking = false
    end
    public
    # Offsets for target coordinates based on type and conditions
    TARGET_COORDINATE_OFFSETS = {ball: {solo: [-50, -96], base_position_0: [-90, -77], base_position_1: [-28, -70]}, stars: {solo: [-51, -11], base_position_0: [-91, 8], base_position_1: [-29, 15]}, catch_burst: {solo: [-50, -93], base_position_0: [-90, -73], base_position_1: [-28, -66]}, burst_break: {solo: [-39, 14], base_position_0: [-79, 54], base_position_1: [-17, 41]}}
    # Coordinates for the camera dependinng of the target
    CAMERA_CAPTURE_POSITION = {solo: [65, -10, 2], base_position_0: [65, -10, 2], base_position_1: [65, -10, 2]}
    # Show the catching animation
    # @param target_pokemon [PFM::PokemonBattler] pokemon being caught
    # @param ball [Studio::BallItem] ball used
    # @param nb_bounce [Integer] number of time the ball move
    # @param caught [Integer] if the pokemon got caught
    def show_catch_animation(target_pokemon, ball, nb_bounce, caught)
      @pokemon_to_catch = target_pokemon
      origin = battler_sprite(0, 0)
      target = battler_sprite(target_pokemon.bank, target_pokemon.position)
      @sprite = UI::ThrowingBallSprite3D.new(origin.viewport, ball)
      @burst_catch = UI::BallCatch.new(origin.viewport, ball)
      @burst2 = UI::BallBurst.new(origin.viewport, ball)
      animation = create_throw_ball_animation(@sprite, @burst_catch, target, origin)
      create_move_ball_animation(animation, @sprite, nb_bounce)
      caught ? create_caught_animation(animation, @sprite, target) : create_break_animation(animation, @burst2, @sprite, target)
      animation.start
      @animations << animation
      wait_for_animation
      start_center_animation unless caught
    end
    private
    # Create the throw ball animation
    # @param sprite [UI::ThrowingBallSprite]
    # @param burst_catch [UI::BallCatch]
    # @param target [Sprite]
    # @param origin [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_ball_animation(sprite, burst_catch, target, origin)
      ya = Yuki::Animation
      stop_camera
      sprite.set_position(*ball_origin_position)
      burst_catch.set_position(*animation_coordinates(target, :catch_burst))
      animation = throwing_animation(target, sprite)
      animation.play_before(ya.scalar(0.4, sprite, :throw_progression=, 0, 2))
      animation.play_before(ya.send_command_to(sprite, :sy=, 10))
      animation.play_before(create_enter_animation(target, burst_catch, sprite))
      animation.play_before(ya.scalar(0.5, sprite, :close_progression=, 0, 1))
      animation.play_before(ya.wait(0.1))
      fall_animation = create_fall_animation(target, sprite)
      sound_animation = sound_bounce_animation
      animation.play_before(fall_animation)
      fall_animation.parallel_play(sound_animation)
      return animation
    end
    # Create the throwing animation annd the zoom of the camera
    # @param target [Sprite]
    # @param sprite [UI::ThrowingBallSprite3D | UI::ThrowingBaitMudSprite]
    # @param type [Symbol] type of projectile
    # @return [Yuki::Animation::TimedAnimation]
    def throwing_animation(target, sprite, type = :ball)
      ya = Yuki::Animation
      camera_position = determine_camera_position
      animation = ya.scalar_offset(0.6, sprite, :y, :y=, 0, -64, distortion: :SQUARE010_DISTORTION)
      animation.parallel_play(ya.move(0.6, sprite, sprite.x, sprite.y, *animation_coordinates(target, type)))
      animation.parallel_play(ya.scalar(0.6, sprite, :throw_progression=, 0, 3))
      animation.parallel_play(ya.scalar(0.6, sprite, :zoom=, 3, 1))
      animation.parallel_play(ya.scalar(0.6, @camera_positionner, :x, @camera.x, camera_position[0]))
      animation.parallel_play(ya.scalar(0.6, @camera_positionner, :y, @camera.y, camera_position[1]))
      animation.parallel_play(ya.scalar(0.6, @camera_positionner, :z, @camera.z, camera_position[2]))
      animation.parallel_play(ya.se_play(*sending_ball_se))
      return animation
    end
    # Create the sound animation for the bouncing ball
    # @return [Yuki::Animation::TimedAnimation]
    def sound_bounce_animation
      ya = Yuki::Animation
      sound_animation = ya.wait(0.2)
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      sound_animation.play_before(ya.wait(0.4))
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      sound_animation.play_before(ya.wait(0.4))
      sound_animation.play_before(ya.se_play(*bouncing_ball_se))
      return sound_animation
    end
    # Create the fall animation
    # @param target [Sprite]
    # @param sprite [UI::ThrowingBallSprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_fall_animation(target, sprite)
      ya = Yuki::Animation
      fall_animation = ya.scalar(1, sprite, :y=, *animation_coordinates(target, :ball)[1] + 110, *animation_coordinates(target, :ball)[1], distortion: fall_distortion)
      fall_animation.parallel_add(ya.scalar(1, sprite, :throw_progression=, 0, 2))
      fall_animation.play_before(ya.send_command_to(sprite, :sy=, 0))
      fall_animation.play_before(ya.scalar(0.01, target, :y=, target.y, target.y))
      return fall_animation
    end
    # Create the fall animation
    # @param target [Sprite]
    # @param burst [UI::BallCatch]
    # @param sprite [UI::ThrowingBallSprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_enter_animation(target, burst_catch, sprite)
      color_updater_target = proc do |progress|
        color = [255, 255, 255, progress]
        target.shader.set_float_uniform('color', color)
      end
      ya = Yuki::Animation
      animation = ya.scalar(0.2, sprite, :open_progression=, 0, 1)
      enter_animation = ya.scalar(0.2, target, :zoom=, sprite_zoom, 0)
      enter_animation.parallel_add(ya.scalar(0.6, burst_catch, :catch_progression=, 1, 0))
      enter_animation.parallel_add(ya.scalar(0.2, target, :y=, target.y, target.y - 72))
      enter_animation.parallel_add(ya.scalar(0.2, color_updater_target, :call, 0, 1))
      enter_animation.parallel_add(ya.se_play(*opening_ball_se))
      enter_animation.play_before(ya.send_command_to(burst_catch, :dispose))
      return animation.play_before(enter_animation)
    end
    def fall_distortion
      return proc { |x| (Math.cos(2.5 * Math::PI * x) * Math.exp(-2 * x)).abs }
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param nb_bounce [Integer]
    def create_move_ball_animation(animation, sprite, nb_bounce)
      ya = Yuki::Animation
      animation.play_before(ya.wait(0.5))
      nb_bounce.clamp(0, 3).times do
        animation.play_before(ya.se_play(*moving_ball_se))
        animation.play_before(ya.scalar(0.5, sprite, :move_progression=, 0, 1))
        animation.play_before(ya.wait(0.5))
      end
    end
    # Create the move animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param sprite [UI::ThrowingBallSprite]
    # @param target [Sprite]
    def create_caught_animation(animation, sprite, target)
      stars = UI::BallStars.new(sprite.viewport)
      stars.set_position(*animation_coordinates(target, :stars))
      ya = Yuki::Animation
      color_updater_ball = proc do |progress|
        color = [0, 0, 0, progress]
        sprite.shader.set_float_uniform('color', color)
      end
      animation.play_before(ya.se_play(*catching_ball_se))
      animation.play_before(ya.scalar(0.01, color_updater_ball, :call, 0, 0.5))
      animation.play_before(ya.scalar(1, stars, :catch_progression=, 0, 1))
    end
    # Create the break animation
    # @param animation [Yuki::Animation::TimedAnimation]
    # @param burst [UI::BallBurst]
    # @param sprite [UI::ThrowingBallSprite3D]
    # @param target [Sprite]
    def create_break_animation(animation, burst, sprite, target)
      ya = Yuki::Animation
      burst.opacity = 0
      burst.set_position(*animation_coordinates(target, :burst_break))
      animation.play_before(ya.se_play(*break_ball_se))
      animation.play_before(ya.send_command_to(burst, :opacity=, 255))
      animation.play_before(target_out_animation(target, burst, sprite))
      animation.play_before(ya.send_command_to(burst, :dispose))
    end
    # Create the exit animation for the Pokemon (when not catch)
    # @param burst [UI::BallBurst]
    # @param sprite [UI::ThrowingBallSprite3D]
    # @param target [Sprite]
    def target_out_animation(target, burst, sprite)
      ya = Yuki::Animation
      color_sprite_break = proc do |progress|
        color = [255, 255, 255, progress]
        target.shader.set_float_uniform('color', color)
      end
      animation = ya.send_command_to(sprite, :dispose)
      animation.parallel_add(ya.scalar(0.4, target, :zoom=, 0, sprite_zoom))
      animation.parallel_add(ya.scalar(0.4, color_sprite_break, :call, 1, 0))
      animation.parallel_add(ya.scalar(0.4, burst, :open_progression=, 0, 1))
      return animation
    end
    # Sprite zoom of the Pokemon battler
    # @return [Integer]
    def sprite_zoom
      return 1
    end
    # Coordinates whee the ball start before being throwned
    # @return [Array<Integer, Integer>]
    def ball_origin_position
      return -20, 180
    end
    # Return the coordinates based on the target, type, and offsets
    # @param target [Sprite] the target sprite
    # @param type [Symbol] the type of coordinates
    # @return [Array<Integer>] the calculated coordinates [x, y]
    def animation_coordinates(target, type)
      key = type_of_position
      x_offset, y_offset = TARGET_COORDINATE_OFFSETS.dig(type, key)
      return [target.x + HALF_WIDTH + x_offset, target.y + HALF_HEIGHT + y_offset]
    end
    # Return the "zoom position" of the camera
    # @return [Array<Integer>]
    def determine_camera_position
      key = type_of_position
      return CAMERA_CAPTURE_POSITION[key]
    end
    # Return the correct key depending of the battle and target
    # @return [:Symbol]
    def type_of_position
      return :solo if @scene.battle_info.vs_type == 1
      return :base_position_0 if @pokemon_to_catch.position == 0
      return :base_position_1
    end
    public
    TARGET_COORDINATE_OFFSETS[:bait_mud] = {solo: [-40, 0], base_position_0: [-90, -77], base_position_1: [-28, -70]}
    # Show the bait or mud throw animation if Safari Battle
    # @param target_pokemon [PFM::PokemonBattler] pokemon being thrown something at
    # @param bait_mud [Symbol] :bait or :mud, depending on the player's choice
    def show_bait_mud_animation(target_pokemon, bait_mud)
      origin = battler_sprite(0, -1)
      target = battler_sprite(target_pokemon.bank, target_pokemon.position)
      @sprite = UI::ThrowingBaitMudSprite.new(origin.viewport, bait_mud)
      animation = create_throw_bait_mud_animation(@sprite, target)
      animation.start
      @animations << animation
      wait_for_animation
      start_center_animation
    end
    private
    # Create the throw ball animation
    # @param sprite [UI::ThrowingBaitMudSprite]
    # @param target [Sprite]
    # @return [Yuki::Animation::TimedAnimation]
    def create_throw_bait_mud_animation(sprite, target)
      ya = Yuki::Animation
      stop_camera
      sprite.set_position(*ball_origin_position)
      animation = throwing_animation(target, sprite, :bait_mud)
      animation.play_before(ya.wait(0.4))
      animation.play_before(ya.send_command_to(sprite, :dispose))
      return animation
    end
    public
    class CameraPositionner
      # Create a new CameraPositionner use for the camera movement
      # @param scene [Scene] scene that hold the logic object
      def initialize(camera)
        @camera = camera
      end
      # @param t [Float] value of x
      def x(t)
        new_x = t
        new_y = @camera.y
        new_z = @camera.z
        @camera.set_position(new_x, new_y, new_z)
      end
      # @param t [Float] value of y
      def y(t)
        new_x = @camera.x
        new_y = t
        new_z = @camera.z
        @camera.set_position(new_x, new_y, new_z)
      end
      # @param t [Float] value of z (0 is illegal)
      def z(t)
        new_x = @camera.x
        new_y = @camera.y
        new_z = t
        @camera.set_position(new_x, new_y, new_z)
      end
      # @param t [Float] value of the translation, apply the same for x and y
      def translation(t)
        new_x = t
        new_y = t
        new_z = @camera.z
        @camera.set_position(new_x, new_y, new_z)
      end
      # Apply a rotation to the camera using yaw
      # @param yaw [Float] angle around axis z (left-right)
      def rotate_z(yaw)
        @camera.set_rotation(yaw, 0, 0)
      end
      # Apply a rotation to the camera using pitch
      # @param pitch [Float] angle around axis y (up-down)
      def rotate_y(pitch)
        @camera.set_rotation(0, pitch, 0)
      end
      # Apply a rotation to the camera using roll
      # @param roll [Float] angle around axis x (tilt)
      def rotate_x(roll)
        @camera.set_rotation(0, 0, roll)
      end
    end
    public
    # Default Margin_X : 64 (32px on each side), Margin_Y : 60 (30px on each side)
    # This constant handles the camera coordinates and all info related
    # It is composed by Array made like that :
    # [start_x, final_x, start_y, final_y, start_z, final_z, duration_of_the_movement, wait_after_the_movement]
    # -9 20 1 => is when the camera is centered on your creature (but it's not the real center of the screen, 0 0 1 is the real one) at default zoom (z = 1)
    CAMERA_TRANSLATION = [[0, -21, 0, 29, 1, 0.9, 2, 1], [-21, 15, 29, -19, 0.9, 1, 3, 1.25], [15, -44, -19, 6, 1, 1, 2.5, 1.5], [-44, 0, 6, 0, 1, 1, 1.4, 2]]
    # coordinates of the camera centered
    CAMERA_CENTER = [-9, 20, 1, 0.3]
    # Update the position of the camera
    def update_camera
      @camera_animation&.update
      @camera.apply_to(@sprites3D + @background.battleback_sprite3D)
    end
    # Define the camera animation across the Battle Scene
    def start_camera_animation
      stop_camera
      total_duration = CAMERA_TRANSLATION.sum { |translation| translation[-2] + translation[-1] }
      global_animation = Yuki::Animation::TimedLoopAnimation.new(total_duration + no_movement_duration)
      global_animation.play_before(Yuki::Animation.wait(no_movement_duration))
      CAMERA_TRANSLATION.each_with_index do |translation, index|
        duration = translation[-2]
        wait_duration = translation[-1]
        if index == 0
          start_x, start_y, start_z = @camera.x, @camera.y, @camera.z
          final_x, final_y, final_z = translation[1], translation[3], translation[5]
        else
          if index == (CAMERA_TRANSLATION.length - 1)
            start_x, start_y, start_z = translation[0], translation[2], translation[4]
            final_x, final_y, final_z = @camera.x, @camera.y, @camera.z
          else
            start_x, start_y, start_z = translation[0], translation[2], translation[4]
            final_x, final_y, final_z = translation[1], translation[3], translation[5]
          end
        end
        animation = Yuki::Animation.scalar(duration, @camera_positionner, :x, start_x, final_x)
        animation.parallel_add(Yuki::Animation.scalar(duration, @camera_positionner, :y, start_y, final_y))
        animation.parallel_add(Yuki::Animation.scalar(duration, @camera_positionner, :z, start_z, final_z))
        animation.play_before(Yuki::Animation.wait(wait_duration))
        global_animation.play_before(animation)
      end
      @camera_animation = global_animation
      @camera_animation.resolver = self
      @camera_animation.start
    end
    # Define the translation to the center of the Screen
    def start_center_animation
      stop_camera
      duration = CAMERA_CENTER[3]
      animation = Yuki::Animation::ScalarAnimation.new(duration, @camera_positionner, :x, @camera.x, 0)
      animation.parallel_add(Yuki::Animation.scalar(duration, @camera_positionner, :y, @camera.y, 0))
      animation.parallel_add(Yuki::Animation.scalar(duration, @camera_positionner, :z, @camera.z, 1))
      @camera_animation = animation
      @camera_animation.start
    end
    # Time without moving at the beginning of start_camera_animation
    def no_movement_duration
      return 3
    end
    # delete all cameras
    def stop_camera
      @camera_animation = nil
    end
    # Center the camera on one of the sprite
    # @param bank [Integer]
    # @param position [Integer]
    def center_target(bank, position)
      if @scene.battle_info.vs_type == 1 || position < 0
        coordinates = camera_zoom_1v1(bank)
      else
        coordinates = camera_zoom_2v2(bank, position)
      end
      animation = Yuki::Animation::ScalarAnimation.new(0.35, @camera_positionner, :x, @camera.x, coordinates[0])
      animation.parallel_add(Yuki::Animation.scalar(0.35, @camera_positionner, :y, @camera.y, coordinates[1]))
      animation.parallel_add(Yuki::Animation.scalar(0.35, @camera_positionner, :z, @camera.z, coordinates[2]))
      @camera_animation = animation
      @camera_animation.start
    end
    # Coordinates to zoom for the camera in 1v1
    # @param bank [Integer]
    # @return Array[<Float,Float,Float>]
    def camera_zoom_1v1(bank)
      return [56, -30, 1.4] if bank == 1
      return [-40, 13, 1.2]
    end
    # Coordinates to zoom for the camera in 2v2
    # @param bank [Integer]
    # @param position [Integer]
    # @return Array[<Float,Float,Float>]
    def camera_zoom_2v2(bank, position)
      return position == 0 ? [44, -33, 1.4] : [68, -27, 1.4] if bank == 1
      return position == 0 ? [-52, 10, 1.2] : [-28, 16, 1.2]
    end
    public
    # Module holding all the Battle 3D Transitions
    module Transition3D
      # Base class of all transitions
      class Base < Battle::Visual::Transition::Base
        ANIMATION_DURATION = 0.75
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
          super(scene, screenshot)
          @camera = camera
          @camera_positionner = camera_positionner
        end
      end
      class RBYTrainer < Battle::Visual::Transition::RBYTrainer
        ANIMATION_DURATION = 0.75
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
          super(scene, screenshot)
          @camera = camera
          @camera_positionner = camera_positionner
        end
        # Function that starts the Enemy send animation
        def start_enemy_send_animation
          log_debug('start_enemy_send_animation')
          ya = Yuki::Animation
          pre_animation = ya.wait(1.8)
          pre_animation.parallel_add(create_enemy_send_animation)
          animation = pre_animation
          animation.parallel_add(ya.send_command_to(self, :show_enemy_send_message))
          animation.play_before(ya.message_locked_animation)
          animation.play_before(ya.send_command_to(self, :start_actor_send_animation))
          animation.start
          @animations << animation
        end
      end
      class Trainer3D < RBYTrainer
        # Default duration for the animations
        ANIMATION_DURATION = 0.5
        # Dezoom for player send animation (last parameter is an angle for axe x)
        CAMERA_COORDINATES_PLAYER_SEND = [-35, 20, 0.90, 5]
        # Coordinates at the end of the transition for the camera
        CAMERA_END_COORDINATES = [0, 0, 1, 0]
        # Shader Color applying when the sprites appear
        SHADER_COLOR = [0, 0, 0, 1]
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
          super
          setup_camera_position
        end
        # Function that creates the top sprite
        def create_top_sprite
          @screenshot_sprite.shader = setup_shader(shader_name)
          @to_dispose << @screenshot_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
          @enemy_sprites = enemy_sprites
          @enemy_sprites.each do |sprite|
            sprite.shader.set_float_uniform('color', SHADER_COLOR)
          end
        end
        # Function that creates the actor sprites
        def create_actors_sprites
          @actor_sprites = actor_sprites
          @actor_pokemon_sprites = actor_pokemon_sprites
          @actor_sprites.each do |sprite|
            sprite.shader.set_float_uniform('color', SHADER_COLOR)
            sprite.opacity = 0
          end
          if Yuki::FollowMe.enabled
            send_followers
          else
            if $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
              @actor_pokemon_sprites.each(&:follower_go_in_animation)
            end
          end
        end
        # Play the Follower go Animation on the right sprites
        def send_followers
          return false unless @actor_pokemon_sprites.any? { |actor_pokemon| actor_pokemon.pokemon.is_follower }
          @scene.battle_info.vs_type.times do |i|
            next unless @actor_pokemon_sprites[i].pokemon.is_follower
            next if @actor_sprites.length > 1 && i > 0
            @actor_pokemon_sprites[i].follower_go_in_animation
          end
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
          ya = Yuki::Animation
          animation = ya.wait(0.1)
          alpha_updater = proc do |alpha|
            @viewport.color.set(0, 0, 0, alpha)
          end
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, alpha_updater, :call, 1, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, @camera.x, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, @camera.y, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, @camera.z, 1.0))
          @enemy_sprites.select(&:shader).each do |sp|
            color_updater_enemy = proc do |progress|
              color = [0, 0, 0, progress]
              sp.shader.set_float_uniform('color', color)
            end
            animation.parallel_add(ya.scalar(ANIMATION_DURATION, color_updater_enemy, :call, 1, 0))
          end
          @actor_sprites.select(&:shader).each do |sp|
            color_updater_actor = proc do |progress|
              color = [0, 0, 0, progress]
              sp.shader.set_float_uniform('color', color)
            end
            animation.parallel_add(ya.scalar(ANIMATION_DURATION, color_updater_actor, :call, 1, 0))
          end
          return animation
        end
        # Function that create the animation of the enemy sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation]
        def create_enemy_send_animation
          ya = Yuki::Animation
          animations = @enemy_sprites.map do |sp|
            next(ya.move(0.5, sp, sp.x, sp.y, sp.x + 40, sp.y - 10).parallel_play(ya.scalar(0.5, sp, :opacity=, 255, 0).play_before(ya.send_command_to(sp, :show_next_frame)).root))
          end
          animation = animations.pop
          animations.each { |anim| animation.parallel_add(anim) }
          enemy_pokemon_sprites.each do |sp|
            animation.play_before(ya.send_command_to(sp, :go_in))
          end
          return animation
        end
        # Check if all the Pokémon on the field are sent
        def all_pokemon_on_field?
          return false if !(Yuki::FollowMe.enabled && Yuki::FollowMe.pokemon_count != 0)
          return @actor_pokemon_sprites[0].pokemon.is_follower if @scene.battle_info.vs_type == 1
          return (0..Yuki::FollowMe.pokemon_count).all? { |index| @actor_pokemon_sprites[index].pokemon.is_follower }
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation
        def create_player_send_animation
          return Yuki::Animation.wait(0) if all_pokemon_on_field? || $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
          ya = Yuki::Animation
          animation = ya.wait(0)
          animation.parallel_add(dezoom_camera_animation)
          @actor_sprites.each do |trainer|
            animation.parallel_add(Yuki::Animation.opacity_change(ANIMATION_DURATION, trainer, 0, 255, distortion: cubic_distortion))
          end
          animation.play_before(ball_throw_player)
          animation.play_before(ya.wait(1.5))
          animation.play_before(reset_camera_animation)
          return animation
        end
        # Function that creates the animation of sending the ball(s) for each actor
        # @return [Yuki::Animation::TimedAnimation]
        def ball_throw_player
          @trainer = @actor_sprites
          return sending_ball_classic if @scene.battle_info.vs_type == 1
          return sending_ball_duo if @actor_sprites.length == 1
          return sending_ball_multi
        end
        # Function that creates the animation of sending the ball(s) in 1v1
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_classic
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          trainer_animation = @trainer[0].send_ball_animation
          pokemon_animation = ya.wait(wait_time_pokemon_animation)
          pokemon_animation.play_before(@actor_pokemon_sprites[0].go_in_animation(true))
          wait_animation = ya.wait(1.5)
          send_animation.play_before(wait_animation)
          send_animation.parallel_add(trainer_animation)
          send_animation.parallel_add(pokemon_animation)
          return send_animation
        end
        # Function that creates the animation of sending the ball(s) in duo battle (no multi)
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_duo
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          trainer_animation = @trainer[0].send_ball_animation
          pokemon_animation = ya.wait(wait_time_pokemon_animation)
          pokemon_animation2 = ya.wait(wait_time_pokemon_animation)
          if @actor_pokemon_sprites[0].pokemon.is_follower
            pokemon_animation.play_before(@actor_pokemon_sprites[1].go_in_animation(true)) unless @actor_pokemon_sprites[1].nil?
          else
            pokemon_animation.play_before(@actor_pokemon_sprites[0].go_in_animation(true))
            pokemon_animation2.play_before(@actor_pokemon_sprites[1].go_in_animation(true)) unless @actor_pokemon_sprites[1].nil?
          end
          wait_animation = ya.wait(1.5)
          send_animation.play_before(wait_animation)
          send_animation.parallel_add(trainer_animation)
          send_animation.parallel_add(pokemon_animation)
          send_animation.parallel_add(pokemon_animation2)
          return send_animation
        end
        # Function that creates the animation of sending the ball(s) in multi battle
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_multi
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          send_animation.play_before(ya.wait(1.5))
          $game_temp.vs_type.times { |i| send_animation.parallel_add(trainer_send_ball_animation(i)) }
          $game_temp.vs_type.times { |i| send_animation.parallel_add(pokemon_send_ball_animation(i)) }
          return send_animation
        end
        # Create the dezoom animation for the player sending animation
        # @return [Yuki::Animation::TimedAnimation]
        def dezoom_camera_animation
          ya = Yuki::Animation
          x, y, z, axis_x = *CAMERA_COORDINATES_PLAYER_SEND
          animation = ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, @camera.x, x)
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, @camera.y, y))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, @camera.z, z))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :rotate_x, 0, axis_x))
          return animation
        end
        # Create the animation for resetting the camera to the center of the Battle Scene
        # @return [Yuki::Animation::TimedAnimation]
        def reset_camera_animation
          ya = Yuki::Animation
          x, y, z, axis_x = *CAMERA_COORDINATES_PLAYER_SEND
          end_x, end_y, end_z, end_axe_x = *CAMERA_END_COORDINATES
          animation = ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, x, end_x)
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, y, end_y))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, z, end_z))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :rotate_x, axis_x, end_axe_x))
          return animation
        end
        # Animation for the first trainer sending a ball
        # @return [Yuki::Animation::TimedAnimation]
        def trainer_send_ball_animation(index)
          ya = Yuki::Animation
          return @trainer[index].send_ball_animation unless $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
          return ya.wait(0)
        end
        # Animation for a Pokémon going into battle
        # @param index [Integer] index of the Pokémon in the bank (0 or 1)
        # @return [Yuki::Animation::TimedAnimation]
        def pokemon_send_ball_animation(index)
          ya = Yuki::Animation
          animation = ya.wait(wait_time_pokemon_animation)
          unless @actor_pokemon_sprites[index].pokemon.is_follower
            animation.play_before(@actor_pokemon_sprites[index].go_in_animation(true))
          end
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          root = Yuki::Animation.send_command_to(@screenshot_sprite, :set_origin, @screenshot_sprite.width / 2, @screenshot_sprite.height / 2)
          root.play_before(Yuki::Animation.send_command_to(@screenshot_sprite, :set_position, @viewport.rect.width / 2, @viewport.rect.height / 2))
          root.play_before(create_zoom_animation)
          root.play_before(create_shader_animation)
          return root
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
          ya = Yuki::Animation
          animation = ya.wait(0.1)
          return animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
          radius_updater = proc { |radius| @screenshot_sprite.shader.set_float_uniform('radius', radius) }
          alpha_updater = proc { |alpha| @screenshot_sprite.shader.set_float_uniform('alpha', alpha) }
          tau_updater = proc { |tau| @screenshot_sprite.shader.set_float_uniform('tau', tau) }
          time_to_process = 1.4
          root = Yuki::Animation.scalar(time_to_process, radius_updater, :call, 0, 0.5)
          root.parallel_play(Yuki::Animation.scalar(time_to_process, alpha_updater, :call, 1, 1))
          root.parallel_play(Yuki::Animation.scalar(time_to_process, tau_updater, :call, 0.5, 0.5))
          return root
        end
        # Function that create the animation of enemy sprite during the battle end
        # @return [Yuki::Animation::TimedAnimation]
        def show_enemy_sprite_battle_end
          temp_x, temp_y, temp_z = 48, 0, 1
          move = 40 * @scene.battle_info.vs_type
          ya = Yuki::Animation
          main_animation = ya.wait(0)
          sprite_animation = ya.wait(0)
          @enemy_sprites.each_with_index do |sprite, index|
            main_animation.play_before(ya.send_command_to(sprite, :set_end_battle_position, index))
            main_animation.play_before(ya.send_command_to(sprite, :opacity=, 255))
            x = sprite.base_position_end_battle(index)[0]
            sprite_animation.parallel_add(ya.scalar(ANIMATION_DURATION, sprite, :x=, x, x - move))
          end
          camera_move = Yuki::Animation.scalar(ANIMATION_DURATION, @camera_positionner, :x, @camera.x, temp_x)
          camera_move.parallel_add(Yuki::Animation.scalar(ANIMATION_DURATION, @camera_positionner, :y, @camera.y, temp_y))
          camera_move.parallel_add(Yuki::Animation.scalar(ANIMATION_DURATION, @camera_positionner, :z, @camera.z, temp_z))
          anim = ya.wait(1)
          anim.parallel_add(sprite_animation)
          anim.parallel_add(camera_move)
          main_animation.play_before(anim)
          return main_animation
        end
        # Create a zoom animation on the player
        # @return [Yuki::Animation::TimedAnimation]
        def create_zoom_animation
          return Yuki::Animation.scalar(0.1, @screenshot_sprite, :zoom=, 1, 1.1)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :yuki_weird
        end
        def setup_camera_position
          camera_x, camera_y = 0, 0
          enemies = enemy_pokemon_sprites
          enemies.each do |enemy|
            camera_x += enemy.x
            camera_y += enemy.y
          end
          @camera.set_position(100, -50, 1.8)
        end
        # Returns a cubic distortion for animations
        def cubic_distortion
          return proc { |t| next(t ** 3) }
        end
        # Waiting time before the pokemon out animation
        # @return [Float]
        def wait_time_pokemon_animation
          return 0.6
        end
      end
      class WildTransition < Base
        # Default duration for the animations
        ANIMATION_DURATION = 0.5
        # Shader Color applying when the sprites appear
        SHADER_COLOR = [0, 0, 0, 1]
        # Coordinates at the end of the transition for the camera
        CAMERA_END_COORDINATES = [0, 0, 1, 0]
        # Dezoom for player send animation (last parameter is an angle for axe x)
        CAMERA_COORDINATES_PLAYER_SEND = [-35, 20, 0.90, 5]
        # Create a new transition
        # @param scene [Battle::Scene]
        # @param screenshot [Texture]
        # @param camera [Fake3D::Camera]
        # @param camera_positionner [Visual3D::CameraPositionner]
        def initialize(scene, screenshot, camera, camera_positionner)
          super
          setup_camera_position
        end
        private
        # Set the default position for the camera at the start
        def setup_camera_position
          @camera.set_position(100, -50, 1.8)
        end
        # Return the pre_transtion cells
        # @return [Array]
        def pre_transition_cells
          return 10, 3
        end
        # Return the duration of pre_transtion cells
        # @return [Float]
        def pre_transition_cells_duration
          return 0.5
        end
        # Return the pre_transtion sprite name
        # @return [String]
        def pre_transition_sprite_name
          return 'spritesheets/rby_wild'
        end
        # Function that creates all the sprites
        def create_all_sprites
          super
          create_top_sprite
          create_enemy_sprites
          create_actors_sprites
        end
        # Function that creates the top sprite
        def create_top_sprite
          @top_sprite = SpriteSheet.new(@viewport, *pre_transition_cells)
          @top_sprite.z = @screenshot_sprite.z * 2
          @top_sprite.load(pre_transition_sprite_name, :transition)
          @top_sprite.zoom = @viewport.rect.width / @top_sprite.width.to_f
          @top_sprite.y = (@viewport.rect.height - @top_sprite.height * @top_sprite.zoom_y) / 2
          @top_sprite.visible = false
          @to_dispose << @screenshot_sprite << @top_sprite
        end
        # Function that creates the enemy sprites
        def create_enemy_sprites
          @enemy_sprites = enemy_pokemon_sprites
          @enemy_sprites.each do |sprite|
            sprite.shader.set_float_uniform('color', SHADER_COLOR)
          end
        end
        # Function that creates the actor sprites
        def create_actors_sprites
          @actor_sprites = actor_sprites
          @actor_pokemon_sprites = actor_pokemon_sprites
          @actor_sprites.each do |sprite|
            sprite.shader.set_float_uniform('color', SHADER_COLOR)
            sprite.opacity = 0
          end
          if Yuki::FollowMe.enabled
            send_followers
          else
            if $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
              @actor_pokemon_sprites.each(&:follower_go_in_animation)
            end
          end
        end
        # Play the Follower go Animation on the right sprites
        def send_followers
          return false unless @actor_pokemon_sprites.any? { |actor_pokemon| actor_pokemon.pokemon.is_follower }
          @scene.battle_info.vs_type.times do |i|
            next unless @actor_pokemon_sprites[i].pokemon.is_follower
            next if @actor_sprites.length > 1 && i > 0
            @actor_pokemon_sprites[i].follower_go_in_animation
          end
        end
        # Function that creates the Yuki::Animation related to the pre transition
        # @return [Yuki::Animation::TimedAnimation]
        def create_pre_transition_animation
          animation = create_flash_animation(1.5, 6)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0))
          animation.play_before(create_fade_in_animation)
          animation.play_before(Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 255))
          animation.play_before(Yuki::Animation.send_command_to(self, :dispose))
          animation.play_before(Yuki::Animation.wait(0.25))
          return animation
        end
        # Function that creates the fade in animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_in_animation
          cells = (@top_sprite.nb_x * @top_sprite.nb_y).times.map { |i| [i % @top_sprite.nb_x, i / @top_sprite.nb_x] }
          animation = Yuki::Animation.send_command_to(@top_sprite, :visible=, true)
          animation.play_before(Yuki::Animation::SpriteSheetAnimation.new(pre_transition_cells_duration, @top_sprite, cells))
          return animation
        end
        # Function that create the fade out animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_fade_out_animation
          animation = (Yuki::Animation.send_command_to(@viewport.color, :set, 0, 0, 0, 0))
          return animation
        end
        # Function that create the sprite movement animation
        # @return [Yuki::Animation::TimedAnimation]
        def create_sprite_move_animation
          ya = Yuki::Animation
          animation = ya.wait(0.1)
          alpha_updater = proc do |alpha|
            @viewport.color.set(0, 0, 0, alpha)
          end
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, alpha_updater, :call, 1, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, @camera.x, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, @camera.y, 0))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, @camera.z, 1.0))
          cries = @enemy_sprites.select { |sp| sp.respond_to?(:cry) }
          cries.each do |sp|
            animation.play_before(ya.send_command_to(sp, :cry))
            animation.play_before(ya.send_command_to(sp, :shiny_animation))
          end
          apply_shader_animation(animation, @enemy_sprites)
          apply_shader_animation(animation, @actor_sprites)
          return animation
        end
        # Check if all the Pokémon on the field are sent
        def all_pokemon_on_field?
          return false if !(Yuki::FollowMe.enabled && Yuki::FollowMe.pokemon_count != 0)
          return @actor_pokemon_sprites[0].pokemon.is_follower if @scene.battle_info.vs_type == 1
          return (0..Yuki::FollowMe.pokemon_count).all? { |index| @actor_pokemon_sprites[index].pokemon.is_follower }
        end
        # Function that creates the animation of the player sending its Pokemon
        # @return [Yuki::Animation::TimedAnimation
        def create_player_send_animation
          return Yuki::Animation.wait(0) if $game_variables[Yuki::Var::BT_Mode] == 5
          return Yuki::Animation.wait(0) if all_pokemon_on_field? || $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
          ya = Yuki::Animation
          animation = dezoom_camera_animation
          @actor_sprites.each do |trainer|
            animation.parallel_add(Yuki::Animation.opacity_change(ANIMATION_DURATION, trainer, 0, 255, distortion: proc { |t| next(t ** 3) }))
          end
          animation.play_before(ball_throw_player)
          animation.play_before(ya.wait(1.5))
          animation.play_before(reset_camera_animation)
          return animation
        end
        # Function that creates the animation of sending the ball(s) for each actor
        # @return [Yuki::Animation::TimedAnimation]
        def ball_throw_player
          @trainer = @actor_sprites
          return sending_ball_classic if @scene.battle_info.vs_type == 1
          return sending_ball_duo if @actor_sprites.length == 1
          return sending_ball_multi
        end
        # Function that creates the animation of sending the ball(s) in 1v1
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_classic
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          trainer_animation = @trainer[0].send_ball_animation
          pokemon_animation = ya.wait(wait_time_pokemon_animation)
          pokemon_animation.play_before(@actor_pokemon_sprites[0].go_in_animation(true))
          wait_animation = ya.wait(1.5)
          send_animation.play_before(wait_animation)
          send_animation.parallel_add(trainer_animation)
          send_animation.parallel_add(pokemon_animation)
          return send_animation
        end
        # Function that creates the animation of sending the ball(s) in duo battle (no multi)
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_duo
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          trainer_animation = @trainer[0].send_ball_animation
          pokemon_animation = ya.wait(wait_time_pokemon_animation)
          pokemon_animation2 = ya.wait(wait_time_pokemon_animation)
          if @actor_pokemon_sprites[0].pokemon.is_follower
            pokemon_animation.play_before(@actor_pokemon_sprites[1].go_in_animation(true)) unless @actor_pokemon_sprites[1].nil?
          else
            pokemon_animation.play_before(@actor_pokemon_sprites[0].go_in_animation(true))
            pokemon_animation2.play_before(@actor_pokemon_sprites[1].go_in_animation(true)) unless @actor_pokemon_sprites[1].nil?
          end
          wait_animation = ya.wait(1.5)
          send_animation.play_before(wait_animation)
          send_animation.parallel_add(trainer_animation)
          send_animation.parallel_add(pokemon_animation)
          send_animation.parallel_add(pokemon_animation2)
          return send_animation
        end
        # Function that creates the animation of sending the ball(s) in multi battle
        # @return [Yuki::Animation::TimedAnimation]
        def sending_ball_multi
          ya = Yuki::Animation
          send_animation = ya.wait(0)
          send_animation.play_before(ya.wait(1.5))
          $game_temp.vs_type.times { |i| send_animation.parallel_add(trainer_send_ball_animation(i)) }
          $game_temp.vs_type.times { |i| send_animation.parallel_add(pokemon_send_ball_animation(i)) }
          return send_animation
        end
        # Create the dezoom animation for the player sending animation
        # @return [Yuki::Animation::TimedAnimation]
        def dezoom_camera_animation
          ya = Yuki::Animation
          x, y, z, axis_x = *CAMERA_COORDINATES_PLAYER_SEND
          animation = ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, @camera.x, x)
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, @camera.y, y))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, @camera.z, z))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :rotate_x, 0, axis_x))
          return animation
        end
        # Create the animation for resetting the camera to the center of the Battle Scene
        # @return [Yuki::Animation::TimedAnimation]
        def reset_camera_animation
          ya = Yuki::Animation
          x, y, z, axis_x = *CAMERA_COORDINATES_PLAYER_SEND
          end_x, end_y, end_z, end_axe_x = *CAMERA_END_COORDINATES
          animation = ya.scalar(ANIMATION_DURATION, @camera_positionner, :x, x, end_x)
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :y, y, end_y))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :z, z, end_z))
          animation.parallel_add(ya.scalar(ANIMATION_DURATION, @camera_positionner, :rotate_x, axis_x, end_axe_x))
          return animation
        end
        # Create a shader animation on the screen
        # @return [Yuki::Animation::TimedAnimation]
        def create_shader_animation
          radius_updater = proc { |radius| @screenshot_sprite.shader.set_float_uniform('radius', radius) }
          alpha_updater = proc { |alpha| @screenshot_sprite.shader.set_float_uniform('alpha', alpha) }
          tau_updater = proc { |tau| @screenshot_sprite.shader.set_float_uniform('tau', tau) }
          time_to_process = 0.6
          root = Yuki::Animation.wait(0)
          root.play_before(Yuki::Animation.scalar(time_to_process, radius_updater, :call, 0, 0.5)).parallel_play(Yuki::Animation.scalar(time_to_process, alpha_updater, :call, 1, 0.5)).parallel_play(Yuki::Animation.scalar(time_to_process, tau_updater, :call, 0.5, 1))
          return root
        end
        # Animation for the first trainer sending a ball
        # @return [Yuki::Animation::TimedAnimation]
        def trainer_send_ball_animation(index)
          ya = Yuki::Animation
          @trainer = @actor_sprites
          return @trainer[index].send_ball_animation unless $game_switches[Yuki::Sw::BT_NO_BALL_ANIMATION]
          return ya.wait(0)
        end
        # Animation for a Pokémon going into battle
        # @param index [Integer] index of the Pokémon in the bank (0 or 1)
        # @return [Yuki::Animation::TimedAnimation]
        def pokemon_send_ball_animation(index)
          ya = Yuki::Animation
          animation = ya.wait(create_shader_animation)
          unless @actor_pokemon_sprites[index].pokemon.is_follower
            animation.play_before(@actor_pokemon_sprites[index].go_in_animation(true))
          end
          return animation
        end
        # Apply shader color animation to sprites
        # @param animation [Yuki::Animation::TimedAnimation]
        # @param sprites [Array] list of sprites to animate
        def apply_shader_animation(animation, sprites)
          ya = Yuki::Animation
          sprites.select(&:shader).each do |sp|
            color_updater = proc do |progress|
              color = [0, 0, 0, progress]
              sp.shader.set_float_uniform('color', color)
            end
            animation.parallel_add(ya.scalar(ANIMATION_DURATION, color_updater, :call, 1, 0))
          end
        end
        # Set up the shader
        # @param name [Symbol] name of the shader
        # @return [Shader]
        def setup_shader(name)
          return Shader.create(name)
        end
        # Return the shader name
        # @return [Symbol]
        def shader_name
          return :yuki_weird
        end
        # Waiting time before the pokemon out animation
        # @return [Float]
        def wait_time_pokemon_animation
          return 0.6
        end
      end
    end
    # Method that show the pre_transition of the battle
    def show_pre_transition
      @transition = battle_transition.new(@scene, @screenshot, @camera, @camera_positionner)
      @animations << @transition
      @transition.pre_transition
      @locking = true
    end
    # Return the current battle transition
    # @return [Class]
    def battle_transition
      collection = $game_temp.trainer_battle ? TRAINER_TRANSITIONS_3D : WILD_TRANSITIONS_3D
      transition_class = collection[0]
      log_debug("Choosen transition class : #{transition_class}")
      return transition_class
    end
    class << self
      # Register the transition resource type for a specific transition
      # @note If no resource type was registered, will send the default sprite one
      # @param id [Integer] id of the transition
      # @param resource_type [Symbol] the symbol of the resource_type (:sprite, :artwork_full, :artwork_small)
      def register_transition_resource(id, resource_type)
        return unless id.is_a?(Integer)
        return unless resource_type.is_a?(Symbol)
        TRANSITION_RESOURCE_TYPE3D[id] = resource_type
      end
      # Return the transition resource type for a given transition ID
      # @param id [Integer] ID of the transition
      # @return [Symbol]
      def transition_resource_type_for(id)
        resource_type = TRANSITION_RESOURCE_TYPE3D[id]
        return :sprite unless resource_type
        return resource_type
      end
    end
    # List of the resource type for each transition
    # @return [Hash{ Integer => Symbol }]
    TRANSITION_RESOURCE_TYPE3D = {}
    TRANSITION_RESOURCE_TYPE3D.default = :sprite
    # List of Wild Transitions
    # @return [Hash{ Integer => Class<Transition3D::Base> }]
    WILD_TRANSITIONS_3D = {}
    # List of Trainer Transitions
    # @return [Hash{ Integer => Class<Transition3D::Base> }]
    TRAINER_TRANSITIONS_3D = {}
    public
    TRAINER_TRANSITIONS_3D[0] = Transition3D::Trainer3D
    TRAINER_TRANSITIONS_3D.default = Transition3D::Trainer3D
    Visual3D.register_transition_resource(0, :sprite)
    public
    WILD_TRANSITIONS_3D[0] = Transition3D::WildTransition
    WILD_TRANSITIONS_3D.default = Transition3D::WildTransition
  end
  # Module holding all the message function used by the battle engine
  module Message
    include PFM::Text
    @battle_info = nil
    @logic = nil
    module_function
    # Setup the message system
    # @param logic [Battle::Logic] the current battle logic
    def setup(logic)
      @battle_info = logic.battle_info
      @logic = logic
      @text = PFM::Text
    end
    # A Wild Pokemon appeared
    # @return [String]
    def wild_battle_appearance
      sentence_index = @battle_info.wild_battle_reason.to_i % 7
      name = @logic.battler(1, 0)&.name
      @text.reset_variables
      @text.parse(18, 1 + sentence_index, PKNAME[0] => name.to_s)
    end
    # Trainer issuing a challenge
    # @return [String]
    def trainer_issuing_a_challenge
      @text.reset_variables
      @text.set_plural(@battle_info.names[1].size > 1)
      @battle_info.names[1].size > 1 ? trainer_issuing_a_challenge_multi : trainer_issuing_a_challenge_single
    end
    # Player sending out its Pokemon
    # @return [String]
    def player_sending_pokemon_start
      @text.reset_variables
      @text.set_plural(false)
      @battle_info.names[0].size > 1 ? player_sending_pokemon_start_multi : player_sending_pokemon_start_single
    end
    # Trainer sending out their Pokemon
    # @return [String]
    def trainer_sending_pokemon_start
      @text.reset_variables
      @text.set_plural(@battle_info.trainer_is_couple)
      text = []
      @battle_info.names[1].each_with_index do |name, index|
        if (class_name = @battle_info.classes[1][index])
          text << trainer_sending_pokemon_start_class(name, class_name, index)
        else
          text << trainer_sending_pokemon_start_no_class(name, index)
        end
      end
      text.join("\n")
    end
    # Trainer issuing a challenge with 2 trainers
    # @return [String]
    def trainer_issuing_a_challenge_multi
      text_id = @battle_info.classes[1].empty? ? 11 : 10
      if @battle_info.classes[1].empty?
        hash = {TRNAME[0] => @battle_info.names[1][0], TRNAME[1] => @battle_info.names[1][1]}
      else
        hash = {TRNAME[1] => @battle_info.names[1][0], TRNAME[3] => @battle_info.names[1][1], '[VAR 010E(0000)]' => @battle_info.classes[1][0], '[VAR 010E(0002)]' => @battle_info.classes[1][1] || @battle_info.classes[1][0]}
        hash['[VAR 019E(0000)]'] = "#{hash['[VAR 010E(0000)]']} #{hash[TRNAME[1]]}"
        hash['[VAR 019E(0002)]'] = "#{hash['[VAR 010E(0002)]']} #{hash[TRNAME[3]]}"
      end
      @text.parse(18, text_id, hash)
    end
    # Trainer issuing a challenge with one trainer
    # @return [String]
    def trainer_issuing_a_challenge_single
      text_id = @battle_info.classes[1].empty? ? 9 : 8
      if @battle_info.classes[1].empty?
        hash = {TRNAME[0] => @battle_info.names[1][0]}
      else
        hash = {TRNAME[1] => @battle_info.names[1][0], '[VAR 010E(0000)]' => @battle_info.classes[1][0]}
        hash['[VAR 019E(0000)]'] = "#{hash['[VAR 010E(0000)]']} #{hash[TRNAME[1]]}"
      end
      @text.parse(18, text_id, hash)
    end
    # When there's a friend trainer and we launch the Pokemon
    # @return [String]
    def player_sending_pokemon_start_multi
      text = [@text.parse(18, 18, PKNICK[1] => @logic.battler(0, 0).name, TRNAME[0] => @battle_info.names[0][0])]
      if @battle_info.classes[0][1]
        @text.set_pknick(@logic.battler(0, 1), 2)
        hash = {TRNAME[1] => @battle_info.names[0][1], '[VAR 010E(0000)]' => @battle_info.classes[0][1]}
        hash['[VAR 019E(0000)]'] = "#{hash['[VAR 010E(0000)]']} #{hash[TRNAME[1]]}"
        text << @text.parse(18, 15, hash)
      else
        @text.set_pknick(@logic.battler(0, 1), 1)
        text << @text.parse(18, 18, TRNAME[0] => @battle_info.names[0][0])
      end
      text.join("\n")
    end
    # When were' alone and we launch the Pokemon
    # @return [String]
    def player_sending_pokemon_start_single
      (count = @logic.battler_count(0)).times do |i|
        @text.set_pknick(@logic.battler(0, i), i)
      end
      return @text.parse(18, 14) if count == 3
      return @text.parse(18, 13) if count == 2
      return @text.parse(18, 12)
    ensure
      @text.reset_variables
    end
    # When the trainer has a class and it sends out its Pokemon
    # @param name [String] name of the trainer
    # @param class_name [String] class of the trainer
    # @param index [String] index of the trainer in the name array
    # @return [String]
    def trainer_sending_pokemon_start_class(name, class_name, index)
      hash = {TRNAME[1] => name, '[VAR 010E(0000)]' => class_name}
      hash['[VAR 019E(0000)]'] = "#{class_name} #{name}"
      arr = Array.new(@battle_info.vs_type) { |i| @logic.battler(1, i) }
      arr.select! { |pokemon| pokemon&.party_id == index }
      arr.each_with_index { |pokemon, i| @text.set_pknick(pokemon, i + 2) }
      return @text.parse(18, 15 + arr.size - 1, hash)
    ensure
      @text.reset_variables
    end
    # When the trainer has no class and it sends out its Pokemon
    # @param name [String] name of the trainer
    # @param index [String] index of the trainer in the name array
    # @return [String]
    def trainer_sending_pokemon_start_no_class(name, index)
      arr = Array.new(@battle_info.vs_type) { |i| @logic.battler(1, i) }
      arr.select! { |pokemon| pokemon&.party_id == index }
      arr.each_with_index { |pokemon, i| @text.set_pknick(pokemon, i + 2) }
      return @text.parse(18, 18 + arr.size - 1, TRNAME[0] => name)
    ensure
      @text.reset_variables
    end
  end
end
module UI
  class Sprite3D < ShaderedSprite
    prepend Fake3D::Sprite3D
  end
  class StatAnimation < SpriteSheet
    include RecenterSprite
    COLUMNS = 12
    ROWS = 10
    MAX_INDEX = COLUMNS * ROWS - 1
    # Create a new StatAnimation
    # @param viewport [Viewport]
    # @param amount [Integer]
    # @param z [Integer]
    # @param bank [Integer]
    def initialize(viewport, amount, z, bank)
      super(viewport, COLUMNS, ROWS)
      @amount = amount
      @bank = bank
      self.bitmap = RPG::Cache.animation(@amount > 0 ? 'stat_up' : 'stat_down')
      self.zoom = zoom_value
      self.sx = 0
      self.sy = 0
      self.z = z
      set_origin(width / 2, height)
      Graphics.sort_z
    end
    # Function that change the sprite according to the progression of the animation
    # @param progression [Float]
    def animation_progression=(progression)
      index = (progression * MAX_INDEX).floor.clamp(0, MAX_INDEX)
      self.sx = index % COLUMNS
      self.sy = index / COLUMNS
    end
    # return the zoom value for the bitmap
    # @return [Integer]
    def zoom_value
      return 1 if battle_3d? && !enemy?
      return 0.5
    end
    # Return the x offset for the Stat Animation
    # @param [Integer]
    def x_offset
      return -2 + Graphics.width / 2 if battle_3d?
      return -2
    end
    # Return the y offset for the Stat Animation
    # @param [Integer]
    def y_offset
      return 10 + Graphics.height / 2 if battle_3d?
      return 10
    end
    # Tell which type of battle it is
    # @return [Boolean]
    def battle_3d?
      return Battle::BATTLE_CAMERA_3D
    end
    # Tell if the Animation is from the enemy side
    # @return [Boolean]
    def enemy?
      return @bank == 1
    end
  end
  class StatusAnimation < SpriteSheet
    include RecenterSprite
    # Get the db_symbol of the status
    # @return [Symbol]
    attr_reader :status
    @registered_status = {}
    # Create a new StatusAnimation
    # @param viewport [Viewport]
    # @param status [Symbol] Symbol of the status
    def initialize(viewport, status, bank)
      @status = status
      @bank = bank
      @columns, @rows = status_dimension
      super(viewport, @columns, @rows)
      self.bitmap = RPG::Cache.animation(status_filename)
      self.sx = 0
      self.sy = 0
      set_origin(width / 2, height)
      self.zoom = zoom_value
    end
    class << self
      # Register a new status
      # @param db_symbol [Symbol] db_symbol of the status
      # @param klass [Class<StatusAnimation>] class of the status animation
      def register(db_symbol, klass)
        @registered_status[db_symbol] = klass
      end
      # Create a new Status animation
      # @param viewport [Viewport]
      # @param status [Symbol] db_symbol of the status
      # @param bank [Integer] bank of the Creature
      # @return [StatusAnimation]
      def new(viewport, status, bank)
        klass = @registered_status[status] || StatusAnimation
        object = klass.allocate
        object.send(:initialize, viewport, status, bank)
        return object
      end
    end
    # Function that change the sprite according to the progression of the animation
    # @param progression [Float]
    def animation_progression=(progression)
      max_index = @columns * @rows - 1
      index = (progression * max_index).floor.clamp(0, max_index)
      self.sx = index % @columns
      self.sy = index / @columns
    end
    # Return the x offset for the Status Animation
    # @param [Integer]
    def x_offset
      return Graphics.width / 2 if battle_3d?
      return 0
    end
    # Return the y offset for the Status Animation
    # @param [Integer]
    def y_offset
      return Graphics.height / 2 if battle_3d?
      return 0
    end
    # Return the duration of the Status Animation
    # @param [Integer]
    def status_duration
      return 1
    end
    private
    # Tell which type of battle it is
    # @return [Boolean]
    def battle_3d?
      return Battle::BATTLE_CAMERA_3D
    end
    # Tell if the sprite is from the enemy side
    # @return [Boolean]
    def enemy?
      return @bank == 1
    end
    # return the zoom value for the bitmap
    # @return [Integer]
    def zoom_value
      return 2 if battle_3d? && !enemy?
      return 1
    end
    # Get the dimension of the Spritesheet
    # @return [Array<Integer, Integer>]
    def status_dimension
    end
    # Get the filename status
    # @return [String]
    def status_filename
    end
    public
    class PoisonAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
        return -3 + Graphics.width / 2 if battle_3d?
        return -3
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return 3 + Graphics.height / 2 if battle_3d?
        return 3
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [12, 10]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/poison'
      end
      # Return the duration of the Status Animation
      # @param [Integer]
      def status_duration
        return 1.2
      end
    end
    register(:poison, PoisonAnimation)
    register(:toxic, PoisonAnimation)
    public
    class SleepAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
        return (enemy? ? -40 : 58) + Graphics.width / 2 if battle_3d?
        return enemy? ? -40 : 58
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return (enemy? ? 3 : -15) + Graphics.height / 2 if battle_3d?
        return enemy? ? 3 : -15
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [12, 10]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return enemy? ? 'status/sleep-front' : 'status/sleep-back'
      end
    end
    register(:sleep, SleepAnimation)
    public
    class FreezeAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
        return -3 + Graphics.width / 2 if battle_3d?
        return -3
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return 31 + Graphics.height / 2 if battle_3d?
        return 31
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [16, 15]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/freeze'
      end
    end
    register(:freeze, FreezeAnimation)
    public
    class BurnAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
        return 2 + Graphics.width / 2 if battle_3d?
        return 2
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return 44 + Graphics.height / 2 if battle_3d?
        return 44
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [9, 8]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/burn'
      end
    end
    register(:burn, BurnAnimation)
    public
    class ParalyzeAnimation < StatusAnimation
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return 3 + Graphics.height / 2 if battle_3d?
        return 3
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [10, 8]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/paralysis'
      end
    end
    register(:paralysis, ParalyzeAnimation)
    public
    class AttractAnimation < StatusAnimation
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [18, 17]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/attract'
      end
    end
    register(:attract, AttractAnimation)
    public
    class ConfusionAnimation < StatusAnimation
      # Return the x offset for the Status Animation
      # @param [Integer]
      def x_offset
        return -4 + Graphics.width / 2 if battle_3d?
        return -4
      end
      # Return the y offset for the Status Animation
      # @param [Integer]
      def y_offset
        return -29 + Graphics.height / 2 if battle_3d?
        return -29
      end
      # Return the duration of the Status Animation
      # @param [Integer]
      def status_duration
        return 2
      end
      # Get the dimension of the Spritesheet
      # @return [Array<Integer, Integer>]
      def status_dimension
        return [12, 12]
      end
      # Get the filename status
      # @return [String]
      def status_filename
        return 'status/confusion'
      end
      def zoom_value
        return 1 if battle_3d? && !enemy?
        return 0.5
      end
    end
    register(:confusion, ConfusionAnimation)
  end
  # Sprite responsive of showing the sprite of the Ball we throw to Pokemon or to release Pokemon
  class ThrowingBallSprite3D < SpriteSheet
    include RecenterSprite
    # Array mapping the move progression to the right cell
    MOVE_PROGRESSION_CELL = [11, 12, 13, 12, 11, 14, 15, 16, 15, 14, 0]
    # Create a new ThrowingBallSprite
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
      super(viewport, 1, 17)
      resolve_image(pokemon_or_item)
      self.sy = 3
      self.shader = Shader.create(:color_shader)
    end
    # Reset the ball position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    def reset_position(bank, position, scene, start_battle = false)
      set_position(*sprite_position(bank, position, scene))
      add_position(*offset_start_battle) if start_battle
      set_origin(width / 2, height / 2)
    end
    # Set the ThrowingBall position for retrieve animation
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    def retrieve_position(bank, position, scene)
      set_position(*get_retrieve_position(bank, position, scene))
      set_origin(width / 2, height / 2)
    end
    # Function that adjust the sy depending on the progression of the "throw" animation
    # @param progression [Float]
    def throw_progression=(progression)
      self.sy = (progression * 7).floor % 7
    end
    # Function that adjust the sy depending on the progression of the "throw" animation (enemy only)
    # @param progression [Float]
    def throw_progression_enemy=(progression)
      self.sy = (progression * 7).floor.clamp(0, 7)
    end
    # Function that adjust the sy depending on the progression of the "open" animation
    # @param progression [Float]
    def open_progression=(progression)
      self.sy = progression.floor.clamp(0, 1) + 9
    end
    # Function that adjust the sy depending on the progression of the "close" animation
    # @param progression [Float]
    def close_progression=(progression)
      target = (progression * 9).floor
      self.sy = target == 9 ? 0 : 10
    end
    # Function that adjust the sy depending on the progression of the "move" animation
    # @param progression [Float]
    def move_progression=(progression)
      self.sy = MOVE_PROGRESSION_CELL[(progression * 10).floor]
    end
    # Function that adjust the sy depending on the progression of the "break" animation
    # @param progression [Float]
    def break_progression=(progression)
      self.sy = (progression * 7).floor.clamp(0, 6) + 20
    end
    # Function that adjust the sy depending on the progression of the "caught" animation
    # @param progression [Float]
    def caught_progression=(progression)
      target = (progression * 5).floor
      self.sy = target == 5 ? 17 : 27 + target
    end
    # Coordinate of the offset to match the apparition of the Pokemon
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    # @return [Array<Integer, Integer>]
    def actor_ball_offset(position, scene, start_battle = false)
      if scene.battle_info.vs_type == 1
        return start_battle ? [196, 48] : [161, 22]
      else
        return start_battle ? [189, 19] : [156, -14] if position == 0
        return start_battle ? [199, 28] : [167, -8]
      end
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
      item = pokemon_or_item.is_a?(PFM::Pokemon) ? data_item(pokemon_or_item.captured_with) : pokemon_or_item
      unless item.is_a?(Studio::BallItem)
        log_error("The parameter #{pokemon_or_item} did not endup into Studio::BallItem object...")
        return
      end
      self.bitmap = RPG::Cache.ball('battle_balls/' + item.img)
      set_origin(width / 2, height / 2)
    end
    # Get the base position of the ball in 1v1
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v1(bank)
      return 242, 73 if bank == 1
      return 1, 155
    end
    # Get the base position of the ball in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v2(bank)
      return 200, 71 if bank == 1
      return 1, 155
    end
    def offset_position_v2(bank, scene)
      return 60, 9 if bank == 1
      return 0, 0 if scene.visual.battler_sprite(0, -2).nil?
      return 100, 0
    end
    # Add of offset to the ball at the start of a battle
    # @return [Array<Integer, Integer>]
    def offset_start_battle
      return 74, -45
    end
    # set the position of the ball the Pokemon is withdrawed in 1v1
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_position_v1(bank)
      return 242, 138 if bank == 1
      return 107, 199
    end
    # set the position of the ball the Pokemon is withdrawed in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_position_v2(bank)
      return 201, 132 if bank == 1
      return 56, 219
    end
    # Offset between the two position in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def retrieve_offset_v2(bank)
      return 60, 10 if bank == 1
      return 70, 5
    end
    # Get the sprite position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def sprite_position(bank, position, scene)
      if scene.battle_info.vs_type == 1
        x, y = base_position_v1_custom(bank)
      else
        x, y = base_position_v2(bank)
        dx, dy = offset_position_v2(bank, scene)
        x += dx * position
        y += dy * position
      end
      return x, y
    end
    # Get the sprite position fo the retrieve of a Pokemon
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def get_retrieve_position(bank, position, scene)
      if scene.battle_info.vs_type == 1
        x, y = retrieve_position_v1(bank)
      else
        x, y = retrieve_position_v2(bank)
        dx, dy = retrieve_offset_v2(bank)
        x += dx * position
        y += dy * position
      end
      return x, y
    end
  end
  class BallStars < SpriteSheet
    COLUMNS = 9
    ROWS = 7
    MAX_INDEX = COLUMNS * ROWS - 1
    # Filename of the Spritesheet used
    BALLSTARS_FILENAME = 'ball_stars'
    # Create a new BallStars
    # @param viewport [Viewport]
    def initialize(viewport)
      super(viewport, COLUMNS, ROWS)
      self.bitmap = RPG::Cache.ball(BALLSTARS_FILENAME)
      self.sx = 0
      self.sy = 0
      set_origin(width / 2, height / 2)
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def catch_progression=(progression)
      index = (progression * MAX_INDEX).floor.clamp(0, MAX_INDEX)
      self.sx = index % COLUMNS
      self.sy = index / COLUMNS
    end
  end
  class BallBurst < SpriteSheet
    include RecenterSprite
    # Create a new BallBurst
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
      super(viewport, 1, 20)
      resolve_image(pokemon_or_item)
      self.sy = 0
    end
    # Reset the Ballburst position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @param start_battle [Boolean] coordinates offset for the start of the battle
    def reset_position(bank, position, scene, start_battle = false)
      set_position(*sprite_position(bank, position, scene))
      add_position(*offset_start_battle) if start_battle
      set_origin(width / 2, height / 2)
    end
    # Set the Ballburst position for retrieve animation
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    def retrieve_position(bank, position, scene)
      set_position(*retrieve_position(bank, position, scene))
      set_origin(width / 2, height / 2)
    end
    # Function that adjust the sy depending on the progression of the "open" animation
    # @param progression [Float]
    def open_progression=(progression)
      self.sy = (progression * 19).floor.clamp(0, 19)
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
      item = pokemon_or_item.is_a?(PFM::Pokemon) ? data_item(pokemon_or_item.captured_with) : pokemon_or_item
      unless item.is_a?(Studio::BallItem)
        log_error("The parameter #{pokemon_or_item} did not endup into Studio::BallItem object...")
        return
      end
      self.bitmap = RPG::Cache.ball('ball_burst/' + item.img)
      set_origin(width / 2, height / 2)
    end
    # Get the base position of the burst in 1v1
    # @param bank
    # @return [Array<Integer, Integer>]
    def base_position_v1(bank)
      return 250, 73 if bank == 1
      return 137, 90
    end
    # Get the base position of the burst in 2v2
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def base_position_v2(bank)
      return 211, 71 if bank == 1
      return 87, 73
    end
    # Return the offset used in 2v2 battle, based on the bank
    # @param bank [Integer]
    # @return [Array<Integer, Integer>]
    def offset_position_v2(bank)
      return 60, 9 if bank == 1
      return 71, 15
    end
    # Add of offset to the burst at the start of a battle
    # @return [Array<Integer, Integer>]
    def offset_start_battle
      return 32, 23
    end
    # Get the sprite position
    # @param bank [Integer]
    # @param position [Integer]
    # @param scene [Battle::Scene]
    # @return [Array<Integer, Integer>]
    def sprite_position(bank, position, scene)
      if scene.battle_info.vs_type == 1
        x, y = base_position_v1_custom(bank)
      else
        x, y = base_position_v2(bank)
        dx, dy = offset_position_v2(bank)
        x += dx * position
        y += dy * position
      end
      return x, y
    end
  end
  class BallCatch < SpriteSheet
    include RecenterSprite
    COLUMNS = 10
    ROWS = 9
    MAX_INDEX = COLUMNS * ROWS - 1
    # Create a new BallCatch
    # @param viewport [Viewport]
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def initialize(viewport, pokemon_or_item)
      super(viewport, COLUMNS, ROWS)
      resolve_image(pokemon_or_item)
      self.sy = 0
      self.sx = 0
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def catch_progression=(progression)
      index = (progression * MAX_INDEX).floor.clamp(0, MAX_INDEX)
      self.sx = index % COLUMNS
      self.sy = index / COLUMNS
    end
    private
    # Resolve the sprite image
    # @param pokemon_or_item [PFM::Pokemon, Studio::BallItem]
    def resolve_image(pokemon_or_item)
      item = pokemon_or_item.is_a?(PFM::Pokemon) ? data_item(pokemon_or_item.captured_with) : pokemon_or_item
      unless item.is_a?(Studio::BallItem)
        log_error("The parameter #{pokemon_or_item} did not endup into Studio::BallItem object...")
        return
      end
      self.bitmap = RPG::Cache.ball('ball_catch')
      set_origin(width / 2, height / 2)
    end
  end
  class RetrieveBurst < SpriteSheet
    COLUMNS = 8
    ROWS = 7
    MAX_INDEX = COLUMNS * ROWS - 1
    # Filename of the Spritesheet used
    BURST_FILENAME = 'ball-retreat'
    # Create a new RetrieveBurst
    # @param viewport [Viewport]
    def initialize(viewport)
      super(viewport, COLUMNS, ROWS)
      self.bitmap = RPG::Cache.ball(BURST_FILENAME)
      set_origin(width / 2, height / 2)
      self.sy = 0
      self.sx = 0
    end
    # Function that adjust the bitmap depending of the "catch" animation
    # @param progression [Float]
    def retrieve_progression=(progression)
      index = (progression * MAX_INDEX).floor.clamp(0, MAX_INDEX)
      self.sx = index % COLUMNS
      self.sy = index / COLUMNS
    end
  end
  # Handle the mega evolution animation in the battle scene
  class MegaEvolveAnimation < SpriteStack
    # Create a new MegaEvolve Spritestack
    # @param viewport [Viewport]
    # @param scene [Battle::Scene]
    # @param target [PFM::PokemonBattler]
    # @param target_sprite [BattleUI::PokemonSprite]
    def initialize(viewport, scene, target, target_sprite)
      super(viewport)
      @scene = scene
      @target = target
      @target_sprite = target_sprite
      @default_cache = :animation
      create_sprite_mega
      @ring = create_sprite(ring_filename)
      @stars = create_sprite(star_filename)
      create_icon_mega
      @all_cells = create_sprite_cells(@main_sprite)
      @cells_first = create_sprite_cells(@main_sprite, exclude_column: 1)
      @cells_second = create_sprite_cells(@main_sprite, exclude_column: 2)
      @cells_last = create_sprite_cells(@main_sprite, exclude_column: 4)
    end
    # Play the MegaEvolve animation
    def mega_evolution_animation
      ya = Yuki::Animation
      following_animation = ya.send_command_to(@target_sprite, :pokemon=, @target)
      following_animation.play_before(ya::SpriteSheetAnimation.new(0.5, @main_sprite, @cells_last)).parallel_add(stars_animation).parallel_add(ring_animation).parallel_add(icon_mega_animation)
      following_animation.play_before(ya.send_command_to(@target_sprite, :cry))
      animation = ya.se_play(se_me)
      animation.play_before(ya::SpriteSheetAnimation.new(0.8, @main_sprite, @all_cells))
      animation.play_before(ya.send_command_to(@main_sprite, :load, "#{me_filename}-1", :animation))
      animation.play_before(ya::SpriteSheetAnimation.new(0.7, @main_sprite, @cells_first))
      animation.play_before(ya.send_command_to(@main_sprite, :load, "#{me_filename}-2", :animation))
      animation.play_before(ya::SpriteSheetAnimation.new(0.6, @main_sprite, @cells_second))
      animation.play_before(ya.send_command_to(@main_sprite, :load, "#{me_filename}-3", :animation))
      animation.play_before(following_animation)
      return animation
    end
    private
    # Create the ring animation
    def ring_animation
      ya = Yuki::Animation
      animation = ya.send_command_to(@ring, :opacity=, 255)
      animation.play_before(parallel_animation = ya.scalar(0.5, @ring, :zoom=, 0.7, 2.5))
      parallel_animation.play_before(ya.opacity_change(0.25, @ring, 255, 0))
      return animation
    end
    # Create the stars animation
    def stars_animation
      ya = Yuki::Animation
      animation = ya.send_command_to(@stars, :opacity=, 255)
      animation.play_before(parallel_animation = ya.scalar(0.25, @stars, :zoom=, 1, 1.5))
      parallel_animation.play_before(ya.opacity_change(0.25, @stars, 255, 0))
      return animation
    end
    # Create the icon mega animation
    def icon_mega_animation
      ya = Yuki::Animation
      animation = ya.send_command_to(@icon, :opacity=, 255)
      animation.play_before(ya.opacity_change(1.5, @icon, 255, 0))
      return animation
    end
    # Create the main Spritesheet for the animation
    def create_sprite_mega
      @main_sprite = add_sprite(@target_sprite.x, @target_sprite.y, me_filename, *me_dimension, type: SpriteSheet, ox: me_sprite_origin[0], oy: me_sprite_origin[1])
      @main_sprite.zoom = 2
      apply_3d_battle_settings(@main_sprite) if Battle::BATTLE_CAMERA_3D
    end
    # Create the icon mega for the animation
    def create_icon_mega
      @icon = add_sprite(@target_sprite.x, @target_sprite.y, me_icon_filename, ox: me_icon_origin[0], oy: me_icon_origin[1])
      @icon.opacity = 0
      apply_3d_battle_settings(@icon) if Battle::BATTLE_CAMERA_3D
    end
    # Create the coordinates of the all_cells in a sprite sheet.
    # @param sprite [Sprite]
    # @param exclude_column [Integer]
    # @return [Array<Array<Integer>>]
    def create_sprite_cells(sprite, exclude_column: 0)
      all_cells = (sprite.nb_x * sprite.nb_y - exclude_column * sprite.nb_x).times.map { |i| [i % sprite.nb_x, i / sprite.nb_x] }
      return all_cells
    end
    # Create the sprite for the mega evolution animation
    # @param file [String] filename of the sprite
    def create_sprite(filename)
      sprite = add_sprite(@target_sprite.x, @target_sprite.y, filename, ox: ring_and_stars_origin[0], oy: ring_and_stars_origin[1])
      sprite.opacity = 0
      apply_3d_battle_settings(sprite) if Battle::BATTLE_CAMERA_3D
      return sprite
    end
    # Apply the 3D settings to the sprite if the 3D camera is enabled
    # @param sprite [Sprite, Spritesheet]
    def apply_3d_battle_settings(sprite)
      sprite.shader = Shader.create(:fake_3d)
      @scene.visual.sprites3D.append(sprite)
      sprite.shader.set_float_uniform('z', @target_sprite.shader_z_position)
    end
    def ring_filename
      return 'mega-evolution/mega-evolution-ring'
    end
    def star_filename
      return 'mega-evolution/mega-evolution-star'
    end
    def me_filename
      return 'mega-evolution/mega-evolution'
    end
    def me_icon_filename
      return 'mega-evolution/icon_mega'
    end
    def se_me
      return 'mega-evolution'
    end
    def ring_and_stars_origin
      return 95, 148
    end
    def me_sprite_origin
      return 64, 90
    end
    def me_icon_origin
      return 128, 140
    end
    def me_dimension
      return 8, 8
    end
  end
end
module BattleUI
  class Sprite3D < ShaderedSprite
    prepend Fake3D::Sprite3D
    def z=(z)
      super(50 - z)
      z = 1
      shader.set_float_uniform('z', z)
    end
  end
end
