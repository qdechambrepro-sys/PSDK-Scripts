
module Graphics
  class << self
    private

    def io_initialize
      STDOUT.sync = true unless STDOUT.tty?
      return if PSDK_CONFIG.release?
      return if PARGV.game_launched_by_studio?

      @is_macOS = PSDK_PLATFORM == :macos && !Kernel.method_defined?(:load_extensions)
      @cmd_thread = create_command_thread
    rescue StandardError
      puts 'Failed to initialize IO related things'
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics io_initialize') { io_initialize }

    # Create the Command thread
    def create_command_thread
      require 'readline' if @is_macOS

      Thread.new do
        loop do
          log_info('Type help to get a list of the commands you can use.')
          @__cmd_to_eval = read_command_from_terminal
          sleep
        rescue StandardError
          @cmd_thread = nil
          @__cmd_to_eval = nil
          break
        end
      end
    end

    def read_command_from_terminal
      unless @is_macOS
        print 'Command: '
        return STDIN.gets.chomp
      end

      line = Readline::readline('Command: ')
      return '' unless line

      line.strip!
      Readline::HISTORY.push(line) if line != 'help'
      return line
    end

    # Eval a command from the console
    def update_cmd_eval
      return unless (cmd = @__cmd_to_eval)
      @__cmd_to_eval = nil
      begin
        puts Object.instance_eval(cmd)
      rescue StandardError, SyntaxError
        print "\r"
        puts "#{$!.class} : #{$!.message}"
        puts $!.backtrace
      end
      @cmd_thread&.wakeup
    end
    Hooks.register(Graphics, :post_update_internal, 'PSDK Graphics update_cmd_eval') { update_cmd_eval }
  end
end

class Object
  # Method that shows the help
  def help
    cc 0x75
    puts "\r#{'PSDK Help'.center(80)}"
    cc 0x07
    print <<~EODESCRIPTION
      Here's the list of the command you can enter in this terminal.
      Remember that you're executing actual Ruby code.
      When an ID is 005 or 023 you have to write 5 or 23, the 0-prefix should never appear in the command you enter.
    EODESCRIPTION
    cc 0x06
    print <<~EOLIST
      Warp the player to another map :\e[37m
        - Debugger.warp(map_id, x, y)\e[36m
      Test a trainer battle :\e[37m
        - Debugger.battle_trainer(trainer_id)\e[36m
      Add a Pokemon to the party :\e[37m
        - S.MI.add_pokemon(id, level)\e[36m
      Add a Pokemon defined by a Hash to the party :\e[37m
        - S.MI.add_specific_pokemon(hash)\e[36m
      Remove a Pokemon from the Party :\e[37m
        - S.MI.withdraw_pokemon_at(index)\e[36m
      Learn a skill to a Pokemon :\e[37m
        - S.MI.skill_learn(pokemon, skill_id)
        - S.MI.skill_learn($actors[index_in_the_party], skill_id)\e[36m
      Add an egg to the party :\e[37m
        - S.MI.add_egg(id)\e[36m
      Start a wild battle :\e[37m
        - S.MI.call_battle_wild(id, level)
        - S.MI.call_battle_wild(id1, level1, id2, level2) \e[32m# 2v2\e[37m
        - S.MI.call_battle_wild(pokemon, nil)
        - S.MI.call_battle_wild(pokemon1, nil, pokemon2)\e[36m
      Save the game :\e[37m
        - S.MI.force_save
    EOLIST
  end
end
