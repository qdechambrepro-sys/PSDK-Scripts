class Object
  # Array representing an empty optional key hash
  EMPTY_OPTIONAL = [].freeze
  # Default error message
  VALIDATE_PARAM_ERROR = 'Parameter %<param_name>s sent to %<method_name>s is incorrect : %<reason>s'
  # Exception message
  EXC_MSG = 'Invalid param value passed to %s#%s, see previous errors to know what are the invalid params'
  # Function that validate the input paramters
  # @note To use a custom message, define a validate_param_message
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_names [Array<Symbol>] list of the names of the params
  # @param param_values [Hash] hash associating a param value to the expected type (description)
  # @example Param with a static type
  #   validate_param(:meth, :param, param => Type)
  # @example Param with various allowed types
  #   validate_param(:meth, :param, param => [Type1, Type2])
  # @example Param using a validation method
  #   validate_param(:meth, :param, param => :validation_method)
  # @example Param using a complex structure (Array of String)
  #   validate_param(:meth, :param, param => { Array => String })
  # @example Param using a complex structure (Array of Symbol, Integer, String, repetetive)
  #   validate_param(:meth, :param, param => { Array => [Symbol, Integer, String], :cyclic => true, min: 3, max: 9})
  # @example Param using a complex structure (Hash)
  #   validate_param(:meth, :param, param => { Hash => { key1: Type, key2: Type2, key3: [String, Symbol] },
  #                                            :optional => [:key2] })
  def validate_param(method_name, *param_names, param_values)
    index = 0
    exception = false
    param_values.each do |param_value, param_types|
      exception |= validate_param_value(method_name, param_names[index], param_value, param_types)
      index += 1
    end
    raise ArgumentError, format(EXC_MSG, self.class, method_name) if exception
  end
  # Function that does nothing and return nil
  # @example
  #   alias function_to_disable void
  def void(*args)
    return nil
  end
  # Function that does nothing and return true
  # @example
  #   alias function_to_disable void_true
  def void_true(*args)
    return true
  end
  # Function that does nothing and return false
  # @example
  #   alias function_to_disable void_false
  def void_false(*args)
    return false
  end
  # Function that does nothing and return 0
  # @example
  #   alias function_to_disable void0
  def void0(*args)
    return 0
  end
  # Function that does nothing and return []
  # @example
  #   alias function_to_disable void_array
  def void_array(*args)
    return nil.to_a
  end
  # Function that does nothing and return ""
  # @example
  #   alias function_to_disable void_array
  def void_string(*args)
    return nil.to_s
  end
  private
  # Function that validate a single parameter
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Class] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_value(method_name, param_name, value, types)
    case types
    when Module
      return value.is_a?(types) ? false : validate_param_error_simple(method_name, param_name, value, types)
    when Symbol
      return send(types, value) ? false : validate_param_error_method(method_name, param_name, value, types)
    when Array
      return false if types.any? { |type| value.is_a?(type) }
      return validate_param_error_multiple(method_name, param_name, value, types)
    end
    return validate_param_complex_value(method_name, param_name, value, types)
  end
  # Function that shows an error on a parameter that should be validated by its type
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Class] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_simple(method_name, param_name, value, types)
    reason = "should be a #{types}; is a #{value.class} with value of #{value.inspect}."
    log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
    return true
  end
  # Function that shows an error on a parameter that should be validated by a method
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Symbol] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_method(method_name, param_name, value, types)
    reason = "hasn't validated criteria from #{types} method, value=#{value.inspect}."
    log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
    return true
  end
  # Function that shows an error on a parameter that should be validated by its type
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Array<Class>] expected type for param
  # @return [true] there's an exception to raise
  def validate_param_error_multiple(method_name, param_name, value, types)
    exp_types = types.join(', ').sub(/\,([^\,]+)$/, ' or a\\1')
    reason = "should be a #{exp_types}; is a #{value.class} with value of #{value.inspect}."
    log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
    return true
  end
  # Function that validate a single complex value parameter
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Hash] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_complex_value(method_name, param_name, value, types)
    error = false
    if (sub_type = types[Array])
      return validate_param_error_simple(method_name, param_name, value, Array) unless value.is_a?(Array)
      validate_param_complex_value_size(method_name, param_name, value, types)
      if sub_type.is_a?(Module)
        value.each_with_index do |sub_val, index|
          error |= validate_param_value(method_name, "#{param_name}[#{index}]", sub_val, sub_type)
        end
      else
        if sub_type.is_a?(Array)
          value.each_with_index do |sub_val, index|
            sub_typec = sub_type[index % sub_type.size]
            error |= validate_param_value(method_name, "#{param_name}[#{index}]", sub_val, sub_typec)
          end
        end
      end
    else
      if (type = types[Hash])
        return validate_param_error_simple(method_name, param_name, value, Hash) unless value.is_a?(Hash)
        optional = types[:optional] || EMPTY_OPTIONAL
        type.each do |key, sub_type2|
          unless value.key?(key)
            next if optional.include?(key)
            reason = "key #{key.inspect} is mandatory."
            log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
            next(error = true)
          end
          error |= validate_param_value(method_name, "#{param_name}[#{key.inspect}]", value[key], sub_type2)
        end
      end
    end
    return error
  end
  # Function that validate the size of a complex array value
  # @param method_name [Symbol] name of the method which its param are being validated
  # @param param_name [Symbol] name of the param that is being validated
  # @param value [Object] value of the param
  # @param types [Hash] expected type for param
  # @return [Boolean] if an exception should be raised when all parameters will be checked
  def validate_param_complex_value_size(method_name, param_name, value, types)
    error = false
    if (min = types[:min]) && min > value.size
      reason = "param should contain at least #{min} values and contain #{value.size} values"
      log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
      error = true
    end
    if (max = types[:max]) && max < value.size
      reason = "param should not contain more than #{max} values and contain #{value.size} values"
      log_error(format(validate_param_message, param_name: param_name, method_name: method_name, reason: reason))
      error = true
    end
    return error
  end
  # Return the common error message
  # @return [String]
  def validate_param_message
    VALIDATE_PARAM_ERROR
  end
  $DEBUG = false
end
# Class that describe a collection of characters
class String
  # Convert numeric related chars of the string to corresponding chars in the Pokemon DS font family
  # @return [self]
  # @author Nuri Yuri
  def to_pokemon_number
    return self unless Configs.texts.fonts.supports_pokemon_number
    tr!('0123456789n/', '│┤╡╢╖╕╣║╗╝‰▓')
    return self
  end
end
# Binding class of Ruby
class Binding
  alias [] local_variable_get
  alias []= local_variable_set
end
# Kernel module of Ruby
module Kernel
  # Infer the object as the specified class (lint)
  # @return [self]
  def from(other)
    raise "Object of class #{other.class} cannot be casted as #{self}" unless other.is_a?(self)
    return other
  end
end
# Module that allows you to schedule some tasks and run them at the right time
#
# The Scheduler has a @tasks Hash that is organized the following way:
#   @tasks[reason][class] = [tasks]
#   reason is one of the following reasons :
#     on_update: during Graphics.update
#     on_scene_switch: before going outside of the #main function of the scene (if called)
#     on_dispose: during the dispose process
#     on_init: at the begining of #main before Graphics.transition
#     on_warp_start: at the begining of player warp process (first action)
#     on_warp_process: after the player has been teleported but before the states has changed
#     on_warp_end: before the transition starts
#     on_hour_update: When the current hour change (ex: refresh groups)
#     on_getting_tileset_name: When the Map Engine search for the correct tileset name
#     on_transition: When Graphics.transition is called
#   class is a Class Object related to the scene where the Scheduler starts
#
# The Sheduler also has a @storage Hash that is used by the tasks to store informations
module Scheduler
  module_function
  # Initialize the Scheduler with no task and nothing in the storage
  def init
    @tasks = {on_update: {}, on_scene_switch: {}, on_dispose: {}, on_init: {}, on_warp_start: {}, on_warp_process: {}, on_warp_end: {}, on_hour_update: {}, on_getting_tileset_name: {}, on_transition: {}}
    @storage = {}
  end
  init
  # Start tasks that are related to a specific reason
  # @param reason [Symbol] reason explained at the top of the page
  # @param klass [Class, :any] the class of the scene
  def start(reason, klass = $scene.class)
    task_hash = @tasks[reason]
    return unless task_hash
    if klass != :any
      start(reason, :any)
      klass = klass.to_s
    end
    task_array = task_hash[klass]
    return unless task_array
    task_array.each(&:start)
  end
  # Remove a task
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param name [String] the name that describe the task
  # @param priority [Integer] its priority
  def __remove_task(reason, klass, name, priority)
    task_array = @tasks.dig(reason, klass.is_a?(Symbol) ? klass : klass.to_s)
    return unless task_array
    priority = -priority
    task_array.delete_if { |obj| obj.priority == priority && obj.name == name }
  end
  # add a task (and sort them by priority)
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param task [ProcTask, MessageTask] the task to run
  def __add_task(reason, klass, task)
    task_hash = @tasks[reason]
    return unless task_hash
    klass = klass.to_s unless klass.is_a?(Symbol)
    task_array = task_hash[klass] || []
    task_hash[klass] = task_array
    task_array << task
    task_array.sort! { |a, b| a.priority <=> b.priority }
  end
  # Description of a Task that execute a Proc
  class ProcTask
    # Priority of the task
    # @return [Integer]
    attr_reader :priority
    # Name that describe the task
    # @return [String]
    attr_reader :name
    # Initialize a ProcTask with its name, priority and the Proc it executes
    # @param name [String] name that describe the task
    # @param priority [Integer] the priority of the task
    # @param proc_object [Proc] the proc (with no param) of the task
    def initialize(name, priority, proc_object)
      @name = name
      @priority = -priority
      @proc = proc_object
    end
    # Invoke the #call method of the proc
    def start
      @proc.call
    end
  end
  # Add a proc task to the Scheduler
  # @param reason [Symbol] the reason
  # @param klass [Class] the class of the scene
  # @param name [String] the name that describe the task
  # @param priority [Integer] the priority of the task
  # @param proc_object [Proc] the Proc object of the task (kept for compatibility should not be defined)
  # @param block [Proc] the Proc object of the task
  def add_proc(reason, klass, name, priority, proc_object = nil, &block)
    proc_object = block if block
    __add_task(reason, klass, ProcTask.new(name, priority, proc_object))
  end
  # Describe a Task that send a message to a specific object
  class MessageTask
    # Priority of the task
    # @return [Integer]
    attr_reader :priority
    # Name that describe the task
    # @return [String]
    attr_reader :name
    # Initialize a MessageTask with its name, priority, the object and the message to send
    # @param name [String] name that describe the task
    # @param priority [Integer] the priority of the task
    # @param object [Object] the object that receive the message
    # @param message [Array<Symbol, *args>] the message to send
    def initialize(name, priority, object, message)
      @name = name
      @priority = -priority
      @object = object
      @message = message
    end
    # Send the message to the object
    def start
      @object.send(*@message)
    end
  end
  # Add a message task to the Scheduler
  # @param reason [Symbol] the reason
  # @param klass [Class, :any] the class of the scene
  # @param name [String] name that describe the task
  # @param priority [Integer] the priority of the task
  # @param object [Object] the object that receive the message
  # @param message [Array<Symbol, *args>] the message to send
  def add_message(reason, klass, name, priority, object, *message)
    __add_task(reason, klass, MessageTask.new(name, priority, object, message))
  end
  # Return the object of the Boot Scene (usually Scene_Title)
  # @return [Object]
  def get_boot_scene
    return Editors::SystemTags.new if PARGV[:tags]
    return Yuki::WorldMapEditor if PARGV[:worldmap]
    test = PARGV[:test].to_s
    return Scene_Title.new if test.empty?
    test = "tests/#{test}.rb"
    if File.exist?(test)
      ScriptLoader.load_tool('Tester')
      return Tester.new(test)
    end
    return Scene_Title.new
  end
end
module Yuki
  # Module that contain every constants associated to a Swicth ID of $game_switches.
  # The description of the constants are the meaning of the switch
  module Sw
    # If the player is a female
    Gender = 1
    # If the shadow are shown under the Sprite_Character
    CharaShadow = 2
    # If the Game_Event doesn't collide with other Game_Event when they slide
    ThroughEvent = 3
    # If the surf message doesn't display when the player collide with the water tiles
    NoSurfContact = 4
    # If the common event did its work as expected or not
    EV_Acted = 5
    # If the Maplinker is disabled
    MapLinkerDisabled = 6
    # If InGame time use the SystemTime
    TJN_RealTime = 7
    # If the InGame time doesn't update
    TJN_NoTime = 8
    # If the added Pokemon has been stored
    SYS_Stored = 9
    # If the time tone is shown
    TJN_Enabled = 10
    # It's the day time
    TJN_DayTime = 11
    # It's the night time
    TJN_NightTime = 12
    # It's the moring time
    TJN_MorningTime = 13
    # It's sunset time
    TJN_SunsetTime = 14
    # BW transition when going from outside to inside (No fade on the warp)
    WRP_Transition = 15
    # If the nuzlocke is enabled
    Nuzlocke_ENA = 16
    # If the player is on AccroBike (and not on the normal bike)
    EV_AccroBike = 17
    # Disable the reset_position of Yuki::FollowMe
    FM_NoReset = 18
    # If the Yuki::FollowMe system is enabled
    FM_Enabled = 19
    # If the player can use Fly thus is outside
    Env_CanFly = 20
    # If the player can use Dig thus is in a cave
    Env_CanDig = 21
    # If the Follower are repositionned like the player warp between two exterior map
    Env_FM_REP = 22
    # If the player is on the Bicycle
    EV_Bicycle = 23
    # If the player has a Pokemon with Strength and Strength is active
    EV_Strength = 24
    # If the message system calculate the line break automatically
    MSG_Recalibrate = 25
    # If the choice are shown on top left
    MSG_ChoiceOnTop = 26
    # If the message system break lines on some punctuations
    MSG_Ponctuation = 27
    # If the actor doesn't turn to the event that show the message
    MSG_Noturn = 28
    # If the Pokemon FollowMe should use Let's Go Mode
    FollowMe_LetsGoMode = 29
    # If the battle is updating the phase (inside battle event condition)
    BT_PhaseUpdate = 30
    # If the phase 1 of the battle is running (Intro)
    BT_Phase1 = 31
    # If the phase 2 of the battle is running (Action choice)
    BT_Phase2 = 32
    # If the phase 3 of the battle is running (Target choice)
    BT_Phase3 = 33
    # If the wild Pokemon fled the battle
    BT_Wild_Flee = 34
    # If the player fled the battle
    BT_Player_Flee = 35
    # If the player was defeated
    BT_Defeat = 36
    # If the player was victorious
    BT_Victory = 37
    # If the player caught the Wild Pokemon
    BT_Catch = 38
    # If the weather in Battle change the Weather outside
    MixWeather = 39
    # If the experience calculation is harder
    BT_HardExp = 40
    # If the player cant escape the battle
    BT_NoEscape = 41
    # If the battle doesn't give exp
    BT_NoExp = 42
    # If the catch is forbidden
    BT_NoCatch = 43
    # If the Moves are replaced by no moves when Pokemon are generated for battle
    BT_NO_MOVE_WHEN_DEFAULT = 44
    # If the trainer first Pokemon is sent without ball animation
    BT_NO_BALL_ANIMATION = 45
    # Authorize defeat in the battle in nuzlocke mode
    BT_AUTHORIZE_DEFEAT_NUZLOCKE = 46
    # Add the Reminder in the Party Menu
    BT_Party_Menu_Reminder = 47
    # Make the AI able to win a battle
    BT_AI_CAN_WIN = 48
    # Disable the Battleback Name reset when you go on a new map
    DISABLE_BATTLEBACK_RESET = 49
    # If exp gain is scaled by player Pokémon level
    BT_ScaledExp = 50
    # If the Water Reflection is disabled
    WATER_REFLECTION_DISABLED = 51
    # If the player is running
    EV_Run = 52
    # If the player can run
    EV_CanRun = 53
    # If the player automatically turn on himself when walking on Rapid SystemTag
    EV_TurnRapids = 54
    # If the player triggered flash
    EV_Flash = 55
    # Weather is rain
    WT_Rain = 56
    # Weather is sunset
    WT_Sunset = 57
    # Weather is sandstorm
    WT_Sandstorm = 58
    # Weather is snow
    WT_Snow = 59
    # Weather is fog
    WT_Fog = 60
    # Disable player detection by all the detection methods
    Env_Detection = 75
    # Tells if the player can't currently leave the bike (useful for Cycling Road)
    CantLeaveBike = 76
    # Enable/disable if pokemon die from poison in overworld
    OW_Poison = 77
    # Failure switch (do not use)
    Alola = 96
    # Victory on the Alpha Ruins game
    RuinsVictory = 97
    # If the Yuki::FollowMe system was enabled
    FM_WasEnabled = 98
    # If the Pokedex is in National Mode
    Pokedex_Nat = 99
    # If the player got the Pokedex
    Pokedex = 100
  end
  # Module that contain every constants associated to a Variable ID of $game_variables.
  # The description of the constants are the meaning of the variable
  module Var
    # Player ID (31bits)
    Player_ID = 1
    # Number of Pokemon Seen
    Pokedex_Seen = 2
    # Number of Pokemon caught
    Pokedex_Catch = 3
    # Current Box (0 is Box 1)
    Boxes_Current = 4
    # Number the in the GamePlay::InputNumber interface (default variable)
    EnteredNumber = 5
    # Number of Pokemon to select for creating temporary team
    Max_Pokemon_Select = 6
    # ID (in the database) of the trainer battle to start
    Trainer_Battle_ID = 8
    # ID of the particle data to use in order to show particle
    PAR_DatID = 9
    # InGame hour
    TJN_Hour = 10
    # InGame minute
    TJN_Min = 11
    # InGame seconds (unused)
    TJN_Sec = 12
    # InGame day of the week (1 = Monday)
    TJN_WDay = 13
    # InGame week
    TJN_Week = 14
    # InGame Month
    TJN_Month = 15
    # InGame day of the month
    TJN_MDay = 16
    # Current Tone (0 : Night, 1 : Sunset, 3 : Day, 2 : Morning)
    TJN_Tone = 17
    # Number of Following Human
    FM_N_Human = 18
    # Number of Following Pokemon (actors one)
    FM_N_Pokem = 19
    # Number of Friend's Following Pokemon
    FM_N_Friend = 20
    # The selected Follower (1 = first, 0 = none)
    FM_Sel_Foll = 21
    # ID of the map where Dig send the player out
    E_Dig_ID = 23
    # X position where Dig send the player out
    E_Dig_X = 24
    # Y position where Dig send the player out
    E_Dig_Y = 25
    # Temporary variable 1
    TMP1 = 26
    # Temporary variable 2
    TMP2 = 27
    # Temporary variable 3
    TMP3 = 28
    # Temporary variable 4
    TMP4 = 29
    # Temporary variable 5
    TMP5 = 30
    # Trainer transition type (0 = 6G, 1 = 5G)
    TrainerTransitionType = 31
    # Map Transition type (1 = Circular, 2 = Directed)
    MapTransitionID = 32
    # Level of the AI
    AI_LEVEL = 34
    # ID (in the database) of the second trainer of the duo battle
    Second_Trainer_ID = 35
    # ID (in the database) of the allied trainer of the duo battle
    Allied_Trainer_ID = 36
    # Coin case amount of coin
    CoinCase = 41
    # Soot sack: amount of volcanic ash in the bag
    SootSack = 42
    # Index of the Pokemon that use its skill in the Party_Menu
    Party_Menu_Sel = 43
    # ID of the map where the player return (Teleport, defeat)
    E_Return_ID = 47
    # X position of the map where the player return
    E_Return_X = 48
    # Y position of the map where the player return
    E_Return_Y = 49
    # Battle mode, 0 : Normal, 1 : P2P server, 2 : P2P Client
    BT_Mode = 50
    # Id of the current player ID
    Current_Player_ID = 51
  end
  # Module that allow to mesure elapsed time between two calls of #show
  #
  # This module is muted when PSDK_CONFIG.release? = true
  #
  # Example :
  #   Yuki::ElapsedTime.start(:test)
  #   do_something
  #   Yuki::ElapsedTime.show(:test, "Something took")
  #   do_something_else
  #   Yuki::ElapsedTime.show(:test, "Something else took")
  module ElapsedTime
    @timers = {}
    @disabled_timers = %i[audio_load_sound map_loading spriteset_map transfer_player maplinker]
    module_function
    # Start the time counter
    # @param name [Symbol] name of the timer
    def start(name)
      return if PSDK_CONFIG.release? || @disabled_timers.include?(name)
      @timers[name] = Time.new
    end
    # Disable a timer
    # @param name [Symbol] name of the timer
    def disable_timer(name)
      @disabled_timers << name
    end
    # Enable a timer
    # @param name [Symbol] name of the timer
    def enable_timer(name)
      @disabled_timers.delete(name)
    end
    # Show the elapsed time between the current and the last call of show
    # @param name [Symbol] name of the timer
    # @param message [String] message to show in the console
    def show(name, message)
      return if PSDK_CONFIG.release? || @disabled_timers.include?(name)
      timer = @timers[name]
      delta_time = Time.new - timer
      if delta_time > 1
        sub_show(delta_time, message, 's')
      else
        if (delta_time *= 1000) > 1
          sub_show(delta_time, message, 'ms')
        else
          if (delta_time *= 1000) > 1
            sub_show(delta_time, message, 'us')
          else
            sub_show(delta_time * 1000, message, 'ns')
          end
        end
      end
      @timers[name] = Time.new
    end
    # Show the real message in the console
    # @param delta [Float] number of unit elapsed
    # @param message [String] message to show on the terminal with the elapsed time
    # @param unit [String] unit of the elapsed time
    def sub_show(delta, message, unit)
      STDOUT.puts(format("\r[Yuki::ElapsedTime] %<message>s : %<delta>0.2f%<unit>s", message: message, delta: delta, unit: unit))
    end
  end
  # Class that helps to read Virtual Directories
  #
  # In reading mode, the Virtual Directories can be loaded to RAM if MAX_SIZE >= VD.size
  #
  # All the filenames inside the Yuki::VD has to be downcased filename in utf-8
  #
  # Note : Encryption is up to the developper and no longer supported on the basic script
  class VD
    # @return [String] the filename of the current Yuki::VD
    attr_reader :filename
    # Is the debug info on ?
    DEBUG_ON = ARGV.include?('debug-yuki-vd')
    # The max size of the file that can be loaded in memory
    MAX_SIZE = 10 * 1024 * 1024
    # 10Mo
    # List of allowed modes
    ALLOWED_MODES = %i[read write update]
    # Size of the pointer at the begin of the file
    POINTER_SIZE = 4
    # Unpack method of the pointer at the begin of the file
    UNPACK_METHOD = 'L'
    # Create a new Yuki::VD file or load it
    # @param filename [String] name of the Yuki::VD file
    # @param mode [:read, :write, :update] if we read or write the virtual directory
    def initialize(filename, mode)
      @mode = mode = fix_mode(mode)
      @filename = filename
      send("initialize_#{mode}")
    end
    # Read a file data from the VD
    # @param filename [String] the file we want to read its data
    # @return [String, nil] the data of the file
    def read_data(filename)
      return nil unless @file
      pos = @hash[filename]
      return nil unless pos
      @file.pos = pos
      size = @file.read(POINTER_SIZE).unpack1(UNPACK_METHOD)
      return @file.read(size)
    end
    # Test if a file exists in the VD
    # @param filename [String]
    # @return [Boolean]
    def exists?(filename)
      @hash[filename] != nil
    end
    # Write a file with its data in the VD
    # @param filename [String] the file name
    # @param data [String] the data of the file
    def write_data(filename, data)
      return unless @file
      @hash[filename] = @file.pos
      @file.write([data.bytesize].pack(UNPACK_METHOD))
      @file.write(data)
    end
    # Add a file to the Yuki::VD
    # @param filename [String] the file name
    # @param ext_name [String, nil] the file extension
    def add_file(filename, ext_name = nil)
      sub_filename = ext_name ? "#{filename}.#{ext_name}" : filename
      write_data(filename, File.binread(sub_filename))
    end
    # Get all the filename
    # @return [Array<String>]
    def get_filenames
      @hash.keys
    end
    # Close the VD
    def close
      return unless @file
      if @mode != :read
        pos = [@file.pos].pack(UNPACK_METHOD)
        @file.write(Marshal.dump(@hash))
        @file.pos = 0
        @file.write(pos)
      end
      @file.close
      @file = nil
    end
    private
    # Initialize the Yuki::VD in read mode
    def initialize_read
      @file = File.new(filename, 'rb')
      pos = @file.pos = @file.read(POINTER_SIZE).unpack1(UNPACK_METHOD)
      @hash = Marshal.load(@file)
      load_whole_file(pos) if pos < MAX_SIZE
    rescue Errno::ENOENT
      @file = nil
      @hash = {}
      log_error(format('%<filename>s not found', filename: filename)) if DEBUG_ON
    end
    # Load the VD in the memory
    # @param size [Integer] size of the VD memory
    def load_whole_file(size)
      @file.pos = 0
      data = @file.read(size)
      @file.close
      @file = StringIO.new(data, 'rb+')
      @file.pos = 0
    end
    # Initialize the Yuki::VD in write mode
    def initialize_write
      @file = File.new(filename, 'wb')
      @file.pos = POINTER_SIZE
      @hash = {}
    end
    # Initialize the Yuki::VD in update mode
    def initialize_update
      @file = File.new(filename, 'rb+')
      pos = @file.pos = @file.read(POINTER_SIZE).unpack1(UNPACK_METHOD)
      @hash = Marshal.load(@file)
      @file.pos = pos
    end
    # Fix the input mode in case it's a String
    # @param mode [Symbol, String]
    # @return [Symbol] one of the value of ALLOWED_MODES
    def fix_mode(mode)
      return mode if ALLOWED_MODES.include?(mode)
      r = (mode = mode.downcase).include?('r')
      w = mode.include?('w')
      plus = mode.include?('+')
      return :update if plus || (r && w)
      return :read if r
      return :write
    end
  end
  class GifReader
    class << self
      # Create a new GifReader from archives
      # @param filename [String] name of the gif file, including the .gif extension
      # @param cache_name [Symbol] name of the cache where to load the gif file
      # @param hue [Integer] 0 = normal, 1 = shiny for Pokemon battlers
      # @return [GifReader, nil]
      def create(filename, cache_name, hue = 0)
        gif_data = RPG::Cache.send(cache_name, filename, hue)
        return log_error("Failed to load GIF: #{cache_name} => #{filename}") && nil unless gif_data
        return GifReader.new(gif_data, true)
      end
      # Check if a Gif Exists
      # @param filename [String] name of the gif file, including the .gif extension
      # @param cache_name [Symbol] name of the cache where to load the gif file
      # @param hue [Integer] 0 = normal, 1 = shiny for Pokemon battlers
      # @return [Boolean]
      def exist?(filename, cache_name, hue = 0)
        cache_exist = :"#{cache_name}_exist?"
        return RPG::Cache.send(cache_exist, filename) if hue == 0
        return RPG::Cache.send(cache_exist, filename, hue)
      end
    end
    alias old_update update
    # Update function that takes in account framerate of the game
    # @param bitmap [LiteRGSS::Bitmap] texture that receive the update
    # @return [self]
    def update(bitmap)
      old_update(bitmap) unless Graphics::FPSBalancer.global.skipping? && @was_updated
      @was_updated = true
      return self
    end
  end
end
# Class that describes RGBA colors in integer scale (0~255)
class Color < LiteRGSS::Color
end
# Class that describe tones (added/modified colors to the surface)
class Tone < LiteRGSS::Tone
end
# Class that defines a rectangular surface of a Graphical element
class Rect < LiteRGSS::Rect
end
# Class that stores an image loaded from file or memory into the VRAM
class Texture < LiteRGSS::Bitmap
  # List of supported extensions
  SUPPORTED_EXTS = ['.png', '.PNG', '.jpg']
  # Initialize the texture, add automatically the extension to the filename
  # @param filename [String] Filename or FileData
  # @param from_mem [Boolean] load the file from memory (then filename is FileData)
  def initialize(filename, from_mem = nil)
    if from_mem || File.exist?(filename)
      super
    else
      if (new_filename = SUPPORTED_EXTS.map { |e| filename + e }.find { |f| File.exist?(f) })
        super(new_filename)
      else
        super(16, 16)
      end
    end
  end
end
# Class that stores an image loaded from file or memory into the VRAM
# @deprecated Please stop using bitmap to talk about texture!
class Bitmap < LiteRGSS::Bitmap
  # Create a new Bitmap
  def initialize(*args)
    log_error('Please stop using Bitmap!')
    super
  end
end
# Class that is dedicated to perform Image operation in Memory before displaying those operations inside a texture
class Image < LiteRGSS::Image
end
# BlendMode applicable to a Sprite/Viewport
class BlendMode < LiteRGSS::BlendMode
end
# Module responsive of showing graphics into the main window
module Graphics
  include Hooks
  extend Hooks
  @on_start = []
  @viewports = []
  @frozen = 0
  @frame_rate = 60
  @current_time = Time.new
  @has_focus = true
  @frame_count = 0
  @fullscreen_toggle_enabled = true
  class << self
    # Get the game window
    # @return [LiteRGSS::DisplayWindow]
    attr_reader :window
    # Get the global frame count
    # @return [Integer]
    attr_accessor :frame_count
    # Get the framerate
    # @return [Integer]
    attr_accessor :frame_rate
    # Get the current time
    # @return [Time]
    attr_reader :current_time
    # Get the time when the last frame was executed
    # @return [Time]
    attr_reader :last_time
    # Tell if it is allowed to go fullscreen with ALT+ENTER
    attr_accessor :fullscreen_toggle_enabled
    # Tell if the graphics window has focus
    # @return [Boolean]
    def focus?
      return @has_focus
    end
    # Tell if the graphics are frozen
    # @return [Boolean]
    def frozen?
      @frozen > 0
    end
    # Tell how much time there was since last frame
    # @return [Float]
    def delta
      return @current_time - @last_time
    end
    # Get the brightness of the main game window
    # @return [Integer]
    def brightness
      return window&.brightness || 0
    end
    # Set the brightness of the main game window
    # @param brightness [Integer]
    def brightness=(brightness)
      window&.brightness = brightness
    end
    # Get the height of the graphics
    # @return [Integer]
    def height
      return window.height
    end
    # Get the width of the graphics
    # @return [Integer]
    def width
      return window.width
    end
    # Get the shader of the graphics
    # @return [Shader]
    def shader
      return window&.shader
    end
    # Set the shader of the graphics
    # @param shader [Shader, nil]
    def shader=(shader)
      window&.shader = shader
    end
    # Freeze the graphics
    def freeze
      return unless @window
      @frozen_sprite.dispose if @frozen_sprite && !@frozen_sprite.disposed?
      @frozen_sprite = LiteRGSS::ShaderedSprite.new(window)
      @frozen_sprite.bitmap = snap_to_bitmap
      @frozen = 10
    end
    # Resize the window screen
    # @param width [Integer]
    # @param height [Integer]
    def resize_screen(width, height)
      window&.resize_screen(width, height)
    end
    # Snap the graphics to bitmap
    # @return [LiteRGSS::Bitmap]
    def snap_to_bitmap
      all_viewport = viewports_in_order.select(&:visible)
      tmp = LiteRGSS::Viewport.new(window, 0, 0, width, height)
      bk = Image.new(width, height)
      bk.fill_rect(0, 0, width, height, Color.new(0, 0, 0, 255))
      sp = LiteRGSS::Sprite.new(tmp)
      sp.bitmap = LiteRGSS::Bitmap.new(width, height)
      bk.copy_to_bitmap(sp.bitmap)
      texture_to_dispose = all_viewport.map do |vp|
        shader = vp.shader
        vp.shader = nil
        texture = vp.snap_to_bitmap
        vp.shader = shader
        sprite = LiteRGSS::ShaderedSprite.new(tmp)
        sprite.shader = shader
        sprite.bitmap = texture
        sprite.set_position(vp.rect.x, vp.rect.y)
        next(texture)
      end
      texture_to_dispose << bk
      texture_to_dispose << sp.bitmap
      result_texture = tmp.snap_to_bitmap
      texture_to_dispose.each(&:dispose)
      tmp.dispose
      return result_texture
    end
    # Take a screenshot of what's currently displayed on the player's screen and save it as a png file
    # @param filename [String] the filename of the png file (will automatically increment if filename contains '%d')
    # @param scale [Integer] the scale of the final screenshot (between 1 and 3, this helps to multiply 320*240 by a factor)
    def player_view_screenshot(filename, scale)
      raise 'You can\'t call player_view_screenshot in this scene!' unless $scene.respond_to?(:snap_to_bitmap)
      scale = scale.is_a?(Integer) ? scale.clamp(1, 3) : 1
      bmp = $scene.snap_to_bitmap
      png = bmp.to_png
      bmp.dispose
      img = Image.new(png, true)
      img2 = Image.new(img.width * scale, img.height * scale)
      img2.stretch_blt!(img2.rect, img, img.rect)
      id_screenshot = 0
      if filename.include?('%d')
        id_screenshot += 1 while File.exist?(format(filename, id_screenshot))
        img2.to_png_file(format(filename, id_screenshot))
      else
        img2.to_png_file(filename)
      end
      img.dispose
      img2.dispose
    end
    # Start the graphics
    def start
      return if @window
      @window = LiteRGSS::DisplayWindow.new(Configs.infos.game_title, *PSDK_CONFIG.choose_best_resolution, PSDK_CONFIG.window_scale, 32, 0, PSDK_CONFIG.vsync_enabled, PSDK_CONFIG.running_in_full_screen, !Configs.devices.mouse_skin)
      @on_start.each(&:call)
      @on_start.clear
      @last_time = @current_time = Time.new
      Input.register_events(@window)
      Mouse.register_events(@window)
      @window.on_lost_focus = proc {@has_focus = false }
      @window.on_gained_focus = proc do
        @has_focus = true
        FMOD::System.update if Object.const_defined?(:FMOD)
      end
      @window.on_closed = proc do
        @window = nil
        next(true)
      end
      init_sprite
    end
    # Stop the graphics
    def stop
      window&.dispose
      @window = nil
    end
    # Transition the graphics between a scene to another
    # @param frame_count_or_sec [Integer, Float] integer = frames, float = seconds; duration of the transition
    # @param texture [Texture] texture used to perform the transition (optional)
    def transition(frame_count_or_sec = 8, texture = nil)
      return unless @window
      exec_hooks(Graphics, :transition, binding)
      return if frame_count_or_sec <= 0 || !@frozen_sprite
      transition_internal(frame_count_or_sec, texture)
      exec_hooks(Graphics, :post_transition, binding)
    rescue Hooks::ForceReturn => e
      return e.data
    ensure
      @frozen_sprite&.bitmap&.dispose
      @frozen_sprite&.shader = nil
      @frozen_sprite&.dispose
      @frozen_sprite = nil
      @frozen = 0
    end
    # Update graphics window content & events. This method might wait for vsync before updating events
    def update
      return unless @window
      return update_freeze if frozen?
      exec_hooks(Graphics, :update, bnd = binding)
      exec_hooks(Graphics, :pre_update_internal, bnd)
      Input.swap_states
      Mouse.swap_states
      Audio.update
      window.update
      @last_time = @current_time
      @current_time = Time.new
      @frame_count += 1
      exec_hooks(Graphics, :post_update_internal, bnd)
    rescue Hooks::ForceReturn => e
      return e.data
    end
    # Update the graphics window content. This method might wait for vsync before returning
    def update_no_input
      return unless @window
      window.update_no_input
      @last_time = @current_time
      @current_time = Time.new
    end
    # Update the graphics window event without drawing anything.
    def update_only_input
      return unless @window
      Input.swap_states
      Mouse.swap_states
      window.update_only_input
      @last_time = @current_time
      @current_time = Time.new
    end
    # Make the graphics wait for an amout of time
    # @param frame_count_or_sec [Integer, Float] Integer => frames, Float = actual time
    # @yield
    def wait(frame_count_or_sec)
      return unless @window
      total_time = frame_count_or_sec.is_a?(Float) ? frame_count_or_sec : frame_count_or_sec.to_f / frame_rate
      initial_time = Graphics.current_time
      next_time = initial_time + total_time
      while Graphics.current_time < next_time
        Graphics.update
        yield if block_given?
      end
    end
    # Register an event on start of graphics
    # @param block [Proc]
    def on_start(&block)
      @on_start << block
    end
    # Register a viewport to the graphics (for special handling)
    # @param viewport [Viewport]
    # @return [self]
    def register_viewport(viewport)
      return self unless viewport.is_a?(Viewport)
      @viewports << viewport unless @viewports.include?(viewport)
      return self
    end
    # Unregister a viewport
    # @param viewport [Viewport]
    # @return [self]
    def unregitser_viewport(viewport)
      @viewports.delete(viewport)
      return self
    end
    # Reset frame counter (for FPS reason)
    def frame_reset
      exec_hooks(Graphics, :frame_reset, binding)
    end
    # Init the Sprite used by the Graphics module
    def init_sprite
      exec_hooks(Graphics, :init_sprite, binding)
    end
    # Sort the graphics in z
    def sort_z
      @window&.sort_z
    end
    # Swap the fullscreen state
    def swap_fullscreen
      settings = window.settings
      settings[7] = !settings[7]
      window.settings = settings
    end
    # Set the screen scale factor
    # @param scale [Float] scale of the screen
    def screen_scale=(scale)
      settings = window.settings
      settings[3] = scale
      window.settings = settings
    end
    private
    # Update the frozen state of graphics
    def update_freeze
      return if @frozen <= 0
      @frozen -= 1
      if @frozen == 0
        log_error('Graphics were frozen for too long, calling transition...')
        transition
      else
        exec_hooks(Graphics, :update_freeze, binding)
      end
    end
    # Get the registered viewport in order
    # @return [Array<Viewport>]
    def viewports_in_order
      viewports = @viewports.reject(&:disposed?)
      viewports.sort! do |a, b|
        next(a.z <=> b.z) if a.z != b.z
        next(a.__index__ <=> b.__index__)
      end
      return viewports
    end
    # Actual execution of the transition internal
    # @param frame_count_or_sec [Integer, Float] integer = frames, float = seconds; duration of the transition
    # @param texture [Texture] texture used to perform the transition (optional)
    def transition_internal(frame_count_or_sec, texture)
      total_time = frame_count_or_sec.is_a?(Float) ? frame_count_or_sec : frame_count_or_sec.to_f / frame_rate
      initial_time = Graphics.current_time
      next_time = initial_time + total_time
      @frozen_sprite.shader = Shader.create(texture ? :graphics_transition : :graphics_transition_static)
      @frozen_sprite.shader.set_texture_uniform('nextFrame', next_frame = snap_to_bitmap)
      @frozen_sprite.shader.set_texture_uniform('transition', texture) if texture
      viewports = viewports_in_order
      visibilities = viewports.map(&:visible)
      viewports.each { |v| v.visible = false }
      sort_z
      while (current_time = Time.new) < next_time
        @frozen_sprite.shader.set_float_uniform('param', ((current_time - initial_time) / total_time).clamp(0, 1))
        exec_hooks(Graphics, :update_transition_internal, binding)
        window.update
        @last_time = @current_time
        @current_time = Time.new
      end
      viewports.each_with_index { |v, i| v.visible = visibilities[i] }
      next_frame.dispose
    end
  end
  # Shader used to perform transition
  TRANSITION_FRAG_SHADER = "uniform float param;\nuniform sampler2D texture;\nuniform sampler2D transition;\nuniform sampler2D nextFrame;\nconst float sensibilite = 0.05;\nconst float scale = 1.0 + sensibilite;\nvoid main()\n{\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  vec4 tran = texture2D(transition, gl_TexCoord[0].xy);\n  float pixel = max(max(tran.r, tran.g), tran.b);\n  pixel -= (param * scale);\n  if(pixel < sensibilite)\n  {\n    vec4 nextFrag = texture2D(nextFrame, gl_TexCoord[0].xy);\n    frag = mix(frag, nextFrag, max(0.0, sensibilite + pixel / sensibilite));\n  }\n  gl_FragColor = frag;\n}\n"
  # Shader used to perform static transition
  STATIC_TRANSITION_FRAG_SHADER = "uniform float param;\nuniform sampler2D texture;\nuniform sampler2D nextFrame;\nvoid main()\n{\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  vec4 nextFrag = texture2D(nextFrame, gl_TexCoord[0].xy);\n  frag = mix(frag, nextFrag, max(0.0, param));\n  gl_FragColor = frag;\n}\n"
  class << self
    # Function that resets the mouse viewport
    def reset_mouse_viewport
      @mouse_fps_viewport&.rect&.set(0, 0, width, height)
    end
    private
    def mouse_fps_create_graphics
      @mouse_fps_viewport = Viewport.new(0, 0, width, height, 999_999)
      unregitser_viewport(@mouse_fps_viewport)
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics mouse_fps_create_graphics') {mouse_fps_create_graphics }
    def reset_fps_info
      @ruby_time = @current_time = @before_g_update = @last_fps_update_time = Time.new
      reset_gc_time
      reset_ruby_time
      @last_frame_count = Graphics.frame_count
    end
    Hooks.register(Graphics, :frame_reset, 'PSDK Graphics reset_fps_info') {reset_fps_info }
    def update_gc_time(delta_time)
      @gc_accu += delta_time
      @gc_count += 1
    end
    def reset_gc_time
      @gc_count = 0
      @gc_accu = 0.0
    end
    def update_ruby_time(delta_time)
      @ruby_accu += delta_time
      @ruby_count += 1
      @before_g_update = Time.new
    end
    def reset_ruby_time
      @ruby_count = 0
      @ruby_accu = 0.0
    end
    def init_fps_text
      @ingame_fps_text = Text.new(0, @mouse_fps_viewport, 0, 0, w = Graphics.width - 2, 13, '', 2, 1, 9)
      @gpu_fps_text = Text.new(0, @mouse_fps_viewport, 0, 16, w, 13, '', 2, 1, 9)
      @ruby_fps_text = Text.new(0, @mouse_fps_viewport, 0, 32, w, 13, '', 2, 1, 9)
      fps_visibility(PARGV[:"show-fps"])
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics init_fps_text') {init_fps_text }
    def fps_visibility(visible)
      @ingame_fps_text.visible = @gpu_fps_text.visible = @ruby_fps_text.visible = visible
    end
    def fps_update
      update_ruby_time(Time.new - @ruby_time)
      fps_visibility(!@ingame_fps_text.visible) if !@last_f2 && Input.press?(:L3)
      @last_f2 = Input.press?(:L3)
      dt = @current_time - @last_fps_update_time
      if dt >= 1
        @last_fps_update_time = @current_time
        @ingame_fps_text.text = "FPS: #{((Graphics.frame_count - @last_frame_count) / dt).round}" if dt * 10 >= 1
        @last_frame_count = Graphics.frame_count
        @gpu_fps_text.text = "GPU FPS: #{(@gc_count / @gc_accu).round}" unless @gc_count == 0 || @gc_accu == 0
        @ruby_fps_text.text = "Ruby FPS: #{(@ruby_count / @ruby_accu).round}" unless @ruby_count == 0 || @ruby_accu == 0
        reset_gc_time
        reset_ruby_time
      end
    end
    Hooks.register(Graphics, :pre_update_internal, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :update_freeze, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :update_transition_internal, 'PSDK Graphics fps_update') {fps_update }
    Hooks.register(Graphics, :post_transition, 'PSDK Graphics reset_fps_info') {reset_fps_info }
    def fps_gpu_update
      update_gc_time(Time.new - @before_g_update)
      @ruby_time = Time.new
    end
    Hooks.register(Graphics, :post_update_internal, 'PSDK Graphics fps_gpu_update') {fps_gpu_update }
    def mouse_create_graphics
      return if (@no_mouse = (Configs.devices.is_mouse_disabled && %i[tags worldmap].none? { |arg| PARGV[arg] }))
      @mouse = Sprite.new(@mouse_fps_viewport)
      if (mouse_skin = Configs.devices.mouse_skin) && RPG::Cache.windowskin_exist?(mouse_skin)
        @mouse.bitmap = RPG::Cache.windowskin(mouse_skin)
      end
    end
    Hooks.register(Graphics, :init_sprite, 'PSDK Graphics mouse_create_graphics') {mouse_create_graphics }
    def mouse_update_graphics
      return if @no_mouse
      @mouse.visible = Mouse.in?
      return unless Mouse.moved
      @mouse.set_position(Mouse.x, Mouse.y)
    end
    Hooks.register(Graphics, :pre_update_internal, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
    Hooks.register(Graphics, :update_freeze, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
    Hooks.register(Graphics, :update_transition_internal, 'PSDK Graphics mouse_update_graphics') {mouse_update_graphics }
  end
  reset_fps_info
  on_start do
    Graphics.load_icon
  end
  class << self
    # Load the window icon
    def load_icon
      return unless RPG::Cache.icon_exist?('game')
      windowskin_vd = RPG::Cache.instance_variable_get(:@icon_data)
      data = windowskin_vd&.read_data('game')
      image = data ? Image.new(data, true) : Image.new('graphics/icons/game.png')
      window.icon = image
      image.dispose
    end
    alias original_swap_fullscreen swap_fullscreen
    # Define swap_fullscreen so the icon is taken in account
    def swap_fullscreen
      original_swap_fullscreen
      load_icon
    end
  end
  # Class helping to balance FPS on FPS based things
  class FPSBalancer
    @globally_enabled = true
    @last_f3_up = Time.new - 10
    # Create a new FPSBalancer
    def initialize
      @frame_to_execute = 0
      @last_frame_rate = 0
      @frame_delta = 1
      @last_interval_index = 0
    end
    # Update the metrics of the FPSBalancer
    def update
      update_intervals if @last_frame_rate != Graphics.frame_rate
      current_index = (Graphics.current_time.usec / @frame_delta).floor
      if current_index == @last_interval_index
        @frame_to_execute = 0
      else
        if current_index > @last_interval_index
          @frame_to_execute = current_index - @last_interval_index
        else
          @frame_to_execute = Graphics.frame_rate - @last_interval_index + current_index
        end
      end
      @last_interval_index = current_index
      if Input.press?(:R3)
        FPSBalancer.last_f3_up = Graphics.current_time
      else
        if FPSBalancer.last_f3_up == Graphics.last_time
          FPSBalancer.globally_enabled = !FPSBalancer.globally_enabled
          FPSBalancer.last_f3_up -= 1
        end
      end
    end
    # Run code according to FPS Balancing (block will be executed only if it's ok)
    # @param block [Proc] code to execute as much as needed
    def run(&block)
      return unless block_given?
      return block.call unless FPSBalancer.globally_enabled
      @frame_to_execute.times(&block)
    end
    # Tell if the balancer is skipping frames
    def skipping?
      FPSBalancer.globally_enabled && @frame_to_execute == 0
    end
    # Force all the scripts to render if we're about to do something important
    def disable_skip_for_next_rendering
      return unless FPSBalancer.globally_enabled
      @frame_to_execute = 1
    end
    private
    def update_intervals
      @last_frame_rate = Graphics.frame_rate
      @frame_delta = 1_000_000.0 / @last_frame_rate
      @last_interval_index = (Graphics.current_time.usec / @frame_delta).floor - 1
      @last_interval_index += Graphics.frame_rate if @last_interval_index < 0
    end
    Hooks.register(Graphics, :post_transition, 'Reset interval after transition') do
      FPSBalancer.global.send(:update_intervals)
    end
    class << self
      # Get if the FPS balancing is globally enabled
      # @return [Boolean]
      attr_accessor :globally_enabled
      # Get last time F3 was pressed
      # @return [Time]
      attr_accessor :last_f3_up
      # Get the global balancer
      # @return [FPSBalancer]
      attr_reader :global
    end
    # Marker allowing the game to know the scene should be frame balanced
    module Marker
      # Function telling the object is supposed to be frame balanced
      def frame_balanced?
        return true
      end
    end
    @global = new
  end
  class << self
    alias original_update update
    # Update with fps balancing
    def update
      FPSBalancer.global.update
      if FPSBalancer.global.skipping? && !frozen? && $scene.is_a?(FPSBalancer::Marker)
        fps_update if respond_to?(:fps_update, true)
        update_no_input
        fps_gpu_update if respond_to?(:fps_gpu_update, true)
      else
        original_update
      end
    end
  end
end
Hooks.register(Graphics, :transition, 'PSDK Graphics.transition') {Scheduler.start(:on_transition) }
Hooks.register(Graphics, :update, 'PSDK Graphics.update') {Scheduler.start(:on_update) }
# Module responsive of giving information about user Inputs
#
# The virtual keys of the Input module are : :A, :B, :X, :Y, :L, :R, :L2, :R2, :L3, :R3, :START, :SELECT, :HOME, :UP, :DOWN, :LEFT, :RIGHT
module Input
  # Alias for the Keyboard module
  Keyboard = Sf::Keyboard
  # Range giving dead zone of axis
  DEAD_ZONE = -20..20
  # Range outside of which a trigger is considered on an exis
  NON_TRIGGER_ZONE = -50..50
  # Sensitivity in order to take a trigger in account on joystick movement
  AXIS_SENSITIVITY = 10
  # Cooldown delta of Input.repeat?
  REPEAT_COOLDOWN = 0.25
  # Time between each signals of Input.repeat? after cooldown
  REPEAT_SPACE = 0.08
  @repeat_handlers = Hash.new { |hash, key| hash[key] = RepeatKeyHandler.new(key) }
  @last_state = Hash.new {false }
  @current_state = Hash.new {false }
  @main_joy = 0
  @x_axis = Sf::Joystick::POV_X
  @y_axis = Sf::Joystick::POV_Y
  @x_joy_axis = Sf::Joystick::X
  @y_joy_axis = Sf::Joystick::Y
  @last_text = nil
  s = Keyboard::Scancode
  # List of keys the input knows
  Keys = {A: [s::C, s::Space, s::Enter, s::NumpadEnter, -1], B: [s::X, s::Backspace, s::Escape, s::LShift, -2], X: [s::V, s::Menu, s::Numpad3, s::V, -3], Y: [s::B, s::Numpad1, s::RShift, s::B, -4], L: [s::F, s::Num1, s::Numpad7, s::F, -5], R: [s::G, s::Num3, s::Numpad9, s::G, -6], L2: [s::R, s::R, s::R, s::R, -7], R2: [s::T, s::T, s::T, s::T, -8], L3: [s::Num4, s::Num4, s::Y, s::F2, -9], R3: [s::Num5, s::Num5, s::U, s::F3, -10], START: [s::J, s::J, s::Insert, s::Insert, -8], SELECT: [s::H, s::H, s::Pause, s::Pause, -7], HOME: [s::Semicolon, s::Semicolon, s::Home, s::Home, 255], UP: [s::Up, s::W, s::Numpad8, s::Up, -13], DOWN: [s::Down, s::S, s::Numpad2, s::Down, -14], LEFT: [s::Left, s::A, s::Numpad4, s::Left, -15], RIGHT: [s::Right, s::D, s::Numpad6, s::Right, -16]}
  # List of key ALIAS
  ALIAS_KEYS = {up: :UP, down: :DOWN, left: :LEFT, right: :RIGHT, a: :A, b: :B, x: :X, y: :Y, start: :START, select: :SELECT}
  # List of Axis mapping (axis => key_neg, key_pos)
  AXIS_MAPPING = {Sf::Joystick::Z => %i[R2 L2]}
  @previous_axis_positions = Hash.new { |hash, key| hash[key] = Hash.new {0 } }
  @joysticks_connected = []
  class << self
    # Get the main joystick
    # @return [Integer]
    attr_accessor :main_joy
    # Get the X axis
    attr_accessor :x_axis
    # Get the Y axis
    attr_accessor :y_axis
    # Get the Joystick X axis
    attr_accessor :x_joy_axis
    # Get the Joystick Y axis
    attr_accessor :y_joy_axis
    # Get the 4 direction status
    # @return [Integer] 2 = down, 4 = left, 6 = right, 8 = up, 0 = none
    def dir4
      return 6 if press?(:RIGHT)
      return 4 if press?(:LEFT)
      return 2 if press?(:DOWN)
      return 8 if press?(:UP)
      return 0
    end
    # Get the 8 direction status
    # @return [Integer] see NumPad to know direction
    def dir8
      if press?(:DOWN)
        return 1 if press?(:LEFT)
        return 3 if press?(:RIGHT)
        return 2
      else
        if press?(:UP)
          return 7 if press?(:LEFT)
          return 9 if press?(:RIGHT)
          return 8
        end
      end
      return dir4
    end
    # Get the last entered text
    # @return [String, nil]
    def get_text
      return nil unless Graphics.focus?
      return @last_text
    end
    # Get the axis position of a joystick
    # @param id [Integer] ID of the joystick
    # @param axis [Integer] axis
    # @return [Integer]
    def joy_axis_position(id, axis)
      Sf::Joystick.axis_position(id, axis)
    end
    # Tell if a key is pressed
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def press?(key)
      return false unless Graphics.focus?
      key = ALIAS_KEYS[key] || key unless Keys[key]
      return @current_state[key]
    end
    # Tell if a key was triggered
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def trigger?(key)
      return false unless Graphics.focus?
      key = ALIAS_KEYS[key] || key unless Keys[key]
      return @current_state[key] && !@last_state[key]
    end
    # Tell if a key was released
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def released?(key)
      return false unless Graphics.focus?
      key = ALIAS_KEYS[key] || key unless Keys[key]
      return @last_state[key] && !@current_state[key]
    end
    # Tell if a key is repeated (0.25s then each 0.08s)
    # @param key [Symbol] name of the key
    # @return [Boolean]
    def repeat?(key)
      return false unless Graphics.focus?
      key = ALIAS_KEYS[key] || key unless Keys[key]
      handler = @repeat_handlers[key]
      return handler.down
    end
    # Swap the states (each time input gets updated)
    def swap_states
      @last_state.merge!(@current_state)
      @repeat_handlers.each_value(&:update)
      @last_text = nil
    end
    # Register all events in the window
    # @param window [LiteRGSS::DisplayWindow]
    def register_events(window)
      window.on_text_entered = proc { |text| on_text_entered(text) }
      window.on_key_pressed = proc { |_, scan, alt| on_key_down(scan, alt) }
      window.on_key_released = proc { |_, scan| on_key_up(scan) }
      window.on_joystick_button_pressed = proc { |id, button| on_joystick_button_pressed(id, button) }
      window.on_joystick_button_released = proc { |id, button| on_joystick_button_released(id, button) }
      window.on_joystick_connected = proc { |id| on_joystick_connected(id) }
      window.on_joystick_disconnected = proc { |id| on_joystick_disconnected(id) }
      window.on_joystick_moved = proc { |id, axis, position| on_axis_moved(id, axis, position) }
    end
    private
    # Set the last entered text
    # @param text [String]
    def on_text_entered(text)
      @last_text = text
    end
    # Set a key up
    # @param key [Integer]
    # @param alt [Boolean] if the alt key is pressed
    def on_key_down(key, alt = false)
      return Graphics.swap_fullscreen if alt && key == Sf::Keyboard::Scancode::Enter && Graphics.fullscreen_toggle_enabled
      vkey, = Keys.find { |_, v| v.include?(key) }
      return unless vkey
      @current_state[vkey] = true
    end
    # Set a key down
    # @param key [Integer]
    def on_key_up(key)
      vkey, = Keys.find { |_, v| v.include?(key) }
      return unless vkey
      @current_state[vkey] = false
    end
    # Trigger a key depending on the joystick axis movement
    # @param id [Integer] id of the joystick
    # @param axis [Integer] axis
    # @param position [Integer] new position
    def on_axis_moved(id, axis, position)
      on_joystick_connected(id)
      return if id != main_joy
      last_position = @previous_axis_positions[id][axis]
      return if (position - last_position).abs <= AXIS_SENSITIVITY
      @previous_axis_positions[id][axis] = position
      if id == main_joy
        return on_axis_x(position) if axis == x_axis || axis == x_joy_axis
        return on_axis_y(position) if axis == y_axis
        return on_axis_joy_y(position) if axis == y_joy_axis
      end
      return unless (mapping = AXIS_MAPPING[axis])
      if DEAD_ZONE.include?(position)
        @current_state[mapping.first] = @current_state[mapping.last] = false
        return
      else
        if position.positive?
          @current_state[mapping.last] = true
          @current_state[mapping.first] = false
        else
          @current_state[mapping.first] = true
          @current_state[mapping.last] = false
        end
      end
    end
    # Trigger a RIGHT or LEFT thing depending on x axis position
    # @param position [Integer] new position
    def on_axis_x(position)
      if NON_TRIGGER_ZONE.include?(position)
        @current_state[:LEFT] = @current_state[:RIGHT] = false
        return
      else
        if position.positive?
          @current_state[:RIGHT] = true
          @current_state[:LEFT] = false
        else
          @current_state[:LEFT] = true
          @current_state[:RIGHT] = false
        end
      end
    end
    # Trigger a UP or DOWN thing depending on y axis position (D-Pad)
    # @param position [Integer] new position
    def on_axis_y(position)
      if NON_TRIGGER_ZONE.include?(position)
        @current_state[:UP] = @current_state[:DOWN] = false
        return
      else
        if position.positive?
          @current_state[:UP] = true
          @current_state[:DOWN] = false
        else
          @current_state[:DOWN] = true
          @current_state[:UP] = false
        end
      end
    end
    # Trigger a UP or DOWN thing depending on y axis position (Joystick)
    # @param position [Integer] new position
    def on_axis_joy_y(position)
      if NON_TRIGGER_ZONE.include?(position)
        @current_state[:UP] = @current_state[:DOWN] = false
        return
      else
        if position.positive?
          @current_state[:DOWN] = true
          @current_state[:UP] = false
        else
          @current_state[:UP] = true
          @current_state[:DOWN] = false
        end
      end
    end
    # Add the joystick to the list of connected joysticks and the new joystick connected becomes the main joystick
    # @param id [Integer] id of the joystick
    def on_joystick_connected(id)
      return if @joysticks_connected.include?(id)
      @joysticks_connected << id
      @main_joy = id
    end
    # Remove the joystick to the list of connected joysticks and change the main joystick if other joystick are connected
    # @param id [Integer] id of the joystick
    def on_joystick_disconnected(id)
      @joysticks_connected.delete(id)
      @main_joy = @joysticks_connected.empty? ? 0 : @joysticks_connected.last
    end
    # Set a key down if the button pressed comes of main joystick
    # @param id [Integer] id of the joystick
    # @param button [Integer]
    def on_joystick_button_pressed(id, button)
      on_key_down(-button - 1) if id == main_joy
    end
    # Set a key up if the button released comes of main joystick
    # @param id [Integer] id of the joystick
    # @param button [Integer]
    def on_joystick_button_released(id, button)
      on_key_up(-button - 1) if id == main_joy
    end
  end
  # Class responsive of emulating the repeat? behavior of the RGSS Input module.
  #
  # Note: for frame agnostic consideration this class holds the down value to true until read
  #  this is to ensure that scenes running at 60FPS instead of 240FPS do not miss the repeat? input
  class RepeatKeyHandler
    def initialize(key_id)
      @state = :update_idle
      @timer = Clock.new
      @timer.freeze
      @key_id = key_id
      reset_state
    end
    def update
      send(@state)
    end
    def down
      return false unless @down
      @consumed = true
      return true
    end
    private
    def reset_state
      @down = false
      @consumed = false
    end
    def update_idle
      return unless Input.press?(@key_id)
      @consumed = false
      @down = true
      @timer.reset
      @state = :update_cooling_down
    end
    def update_cooling_down
      update_key_consumption
      unless Input.press?(@key_id)
        reset_state
        return @state = :update_idle
      end
      if @timer.elapsed_time > REPEAT_COOLDOWN
        @state = :update_repeat_check
        @timer.reset
        @down = true
      end
    end
    def update_repeat_check
      update_key_consumption
      unless Input.press?(@key_id)
        reset_state
        return @state = :update_idle
      end
      if @timer.elapsed_time > REPEAT_SPACE
        @timer.reset
        @down = true
      end
    end
    def update_key_consumption
      return unless @consumed
      reset_state
    end
  end
end
# Module responsive of giving global state of mouse Inputs
#
# The buttons of the mouse are : :LEFT, :MIDDLE, :RIGHT, :X1, :X2
module Mouse
  @last_state = Hash.new {false }
  @current_state = Hash.new {false }
  # Mapping between button & symbols
  BUTTON_MAPPING = {Sf::Mouse::LEFT => :LEFT, Sf::Mouse::RIGHT => :RIGHT, Sf::Mouse::Middle => :MIDDLE, Sf::Mouse::XButton1 => :X1, Sf::Mouse::XButton2 => :X2}
  # List of alias button
  BUTTON_ALIAS = {left: :LEFT, right: :RIGHT, middle: :MIDDLE}
  @wheel = 0
  @wheel_delta = 0
  @x = -999_999
  @y = -999_999
  @in_screen = true
  @moved = false
  class << self
    # Mouse wheel position
    # @return [Integer]
    attr_accessor :wheel
    # Mouse wheel delta
    # @return [Integer]
    attr_reader :wheel_delta
    # Get the mouse x position
    # @return [Integer]
    attr_reader :x
    # Get the mouse y position
    # @return [Integer]
    attr_reader :y
    # Get if the mouse moved since last frame
    # @return [Boolean]
    attr_reader :moved
    # Tell if a button is pressed on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def press?(button)
      button = BUTTON_ALIAS[button] || button
      return @current_state[button]
    end
    # Tell if a button was triggered on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def trigger?(button)
      button = BUTTON_ALIAS[button] || button
      return @current_state[button] && !@last_state[button]
    end
    # Tell if a button was released on the mouse
    # @param button [Symbol]
    # @return [Boolean]
    def released?(button)
      button = BUTTON_ALIAS[button] || button
      return @last_state[button] && !@current_state[button]
    end
    # Tell if the mouse is in the screen
    # @return [Boolean]
    def in?
      return @in_screen
    end
    # Swap the state of the mouse
    def swap_states
      @last_state.merge!(@current_state)
      @moved = false
      @wheel_delta = 0
    end
    # Register event related to the mouse
    # @param window [LiteRGSS::DisplayWindow]
    def register_events(window)
      return if Configs.devices.is_mouse_disabled && %i[tags worldmap].none? { |arg| PARGV[arg] }
      window.on_touch_began = proc { |_finger_id, x, y|         on_mouse_entered
        on_mouse_moved(x, y)
        on_button_pressed(Sf::Mouse::LEFT)
 }
      window.on_touch_moved = proc { |_finger, x, y| on_mouse_moved(x, y) }
      window.on_touch_ended = proc { |_finger_id, x, y|         on_button_released(Sf::Mouse::LEFT)
        on_mouse_moved(x, y)
        on_mouse_left
 }
      window.on_mouse_wheel_scrolled = proc { |wheel, delta| on_wheel_scrolled(wheel, delta) }
      window.on_mouse_button_pressed = proc { |button| on_button_pressed(button) }
      window.on_mouse_button_released = proc { |button| on_button_released(button) }
      window.on_mouse_moved = proc { |x, y| on_mouse_moved(x, y) }
      window.on_mouse_entered = proc {on_mouse_entered }
      window.on_mouse_left = proc {on_mouse_left }
    end
    private
    # Update the mouse wheel state
    # @param wheel [Integer]
    # @param delta [Float]
    def on_wheel_scrolled(wheel, delta)
      return unless wheel == Sf::Mouse::VerticalWheel
      @wheel += delta.to_i
      @wheel_delta += delta.to_i
    end
    # Update the button state
    # @param button [Integer]
    def on_button_pressed(button)
      @current_state[BUTTON_MAPPING[button]] = true
    end
    # Update the button state
    # @param button [Integer]
    def on_button_released(button)
      @current_state[BUTTON_MAPPING[button]] = false
    end
    # Update the mouse position
    # @param x [Integer]
    # @param y [Integer]
    def on_mouse_moved(x, y)
      settings = Graphics.window.settings
      if settings[7]
        @x = (x * settings[1] / LiteRGSS::DisplayWindow.desktop_width)
        @y = (y * settings[2] / LiteRGSS::DisplayWindow.desktop_height)
      else
        @x = (x / PSDK_CONFIG.window_scale).floor
        @y = (y / PSDK_CONFIG.window_scale).floor
      end
      @moved = true
    end
    # Update the mouse status when it enters the screen
    def on_mouse_entered
      @in_screen = true
    end
    # Update the mouse status when it leaves the screen
    def on_mouse_left
      @in_screen = false
    end
  end
end
# Class that describes a surface of the screen where texts and sprites are shown (with some global effect)
class Viewport < LiteRGSS::Viewport
  # Hash containing all the Viewport configuration (:main, :sub etc...)
  CONFIGS = {}
  @global_offset_x = nil
  @global_offset_y = nil
  # Filename for viewport compiled config
  VIEWPORT_CONF_COMP = 'Data/Viewport.rxdata'
  # Filename for viewport uncompiled config
  VIEWPORT_CONF_TEXT = 'Data/Viewport.json'
  # Tell if the viewport needs to sort
  # @return [Boolean]
  attr_accessor :need_to_sort
  # Create a new viewport
  # @param x [Integer] x coordinate of the viewport on screen
  # @param y [Integer] y coordinate of the viewport on screen
  # @param width [Integer] width of the viewport
  # @param height [Integer] height of the viewport
  # @param z [Integer] z coordinate of the viewport
  def initialize(x, y, width, height, z = nil)
    super(Graphics.window, x, y, width, height)
    self.z = z if z
    @need_to_sort = true
    Graphics.register_viewport(self)
  end
  # Dispose a viewport
  # @return [self]
  def dispose
    Graphics.unregitser_viewport(self)
    super
  end
  class << self
    # Generating a viewport with one line of code
    # @overload create(screen_name_symbol, z = nil)
    #   @param screen_name_symbol [:main, :sub] describe with screen surface the viewport is (loaded from maker options)
    #   @param z [Integer, nil] superiority of the viewport
    # @overload create(x, y = 0, width = 1, height = 1, z = nil)
    #   @param x [Integer] x coordinate of the viewport
    #   @param y [Integer] y coordinate of the viewport
    #   @param width [Integer] width of the viewport
    #   @param height [Integer] height of the viewport
    #   @param z [Integer, nil] superiority of the viewport
    # @overload create(opts)
    #   @param opts [Hash] opts of the viewport definition
    #   @option opts [Integer] :x (0) x coordinate of the viewport
    #   @option opts [Integer] :y (0) y coordinate of the viewport
    #   @option opts [Integer] :width (320) width of the viewport
    #   @option opts [Integer] :height (240) height of the viewport
    #   @option opts [Integer, nil] :z (nil) superiority of the viewport
    # @return [Viewport] the generated viewport
    def create(x, y = 0, width = 1, height = 1, z = 0)
      if x.is_a?(Hash)
        z = x[:z] || z
        y = x[:y] || 0
        width = x[:width] || Configs.display.game_resolution.x
        height = x[:height] || Configs.display.game_resolution.y
        x = x[:x] || 0
      else
        if x.is_a?(Symbol)
          return create(CONFIGS[x], 0, 1, 1, y)
        end
      end
      gox = @global_offset_x || PSDK_CONFIG.viewport_offset_x || 0
      goy = @global_offset_y || PSDK_CONFIG.viewport_offset_y || 0
      v = Viewport.new(x + gox, y + goy, width, height, z)
      return v
    end
    # Load the viewport configs
    def load_configs
      unless PSDK_CONFIG.release?
        unless File.exist?(VIEWPORT_CONF_COMP) && File.exist?(VIEWPORT_CONF_TEXT)
          if File.exist?(VIEWPORT_CONF_TEXT)
            save_data(JSON.parse(File.read(VIEWPORT_CONF_TEXT), symbolize_names: true), VIEWPORT_CONF_COMP)
          else
            vp_conf = {main: {x: 0, y: 0, width: 320, height: 240}}
            File.write(VIEWPORT_CONF_TEXT, vp_conf.to_json)
            sleep(1)
            save_data(vp_conf, VIEWPORT_CONF_COMP)
          end
        end
        if File.mtime(VIEWPORT_CONF_TEXT) > File.mtime(VIEWPORT_CONF_COMP)
          log_debug('Updating Viewport Configuration...')
          save_data(JSON.parse(File.read(VIEWPORT_CONF_TEXT), symbolize_names: true), VIEWPORT_CONF_COMP)
        end
      end
      CONFIGS.merge!(load_data(VIEWPORT_CONF_COMP))
    end
  end
  # Format the viewport to string for logging purposes
  def to_s
    return '#<Viewport:disposed>' if disposed?
    return format('#<Viewport:%08x : %00d>', __id__, __index__)
  end
  alias inspect to_s
  # Flash the viewport
  # @param color [LiteRGSS::Color] the color used for the flash processing
  def flash(color, duration)
    self.shader ||= Shader.create(:color_shader_with_background)
    color ||= Color.new(0, 0, 0)
    @flash_color = color
    @flash_color_running = color.dup
    @flash_counter = 0
    @flash_duration = duration.to_f
  end
  # Update the viewport
  def update
    if @flash_color
      alpha = 1 - @flash_counter / @flash_duration
      @flash_color_running.alpha = @flash_color.alpha * alpha
      self.shader.set_float_uniform('color', @flash_color_running)
      @flash_counter += 1
      if @flash_counter >= @flash_duration
        self.shader.set_float_uniform('color', [0, 0, 0, 0])
        @flash_color_running = @flash_color = nil
      end
    end
  end
  # Module defining a shader'd entity that has .color and .tone methods (for flash or other purpose)
  module WithToneAndColors
    # Extended class of Tone allowing setters to port back values to the shader and its tied entity
    class Tone < LiteRGSS::Tone
      # Create a new Tied Tone
      # @param viewport [Viewport, Sprite] element on which the tone is tied
      # @param r [Integer] red color
      # @param g [Integer] green color
      # @param b [Integer] blue color
      # @param g2 [Integer] gray factor
      def initialize(viewport, r, g, b, g2)
        @viewport = viewport
        super(r, g, b, g2)
        update_viewport
      end
      # Set the attribute (according to how it works in normal class)
      # @param args [Array<Integer>]
      def set(*args)
        r = red
        g = green
        b = blue
        g2 = gray
        super
        update_viewport if r != red || g != green || b != blue || g2 != gray
      end
      # Set the red value
      # @param v [Integer]
      def red=(v)
        return if v == red
        super
        update_viewport
      end
      # Set the green value
      # @param v [Integer]
      def green=(v)
        return if v == green
        super
        update_viewport
      end
      # Set the blue value
      # @param v [Integer]
      def blue=(v)
        return if v == blue
        super
        update_viewport
      end
      # Set the gray value
      # @param v [Integer]
      def gray=(v)
        return if v == gray
        super
        update_viewport
      end
      private
      # Update the viewport tone shader attribute
      def update_viewport
        @viewport.shader&.set_float_uniform('tone', self)
      end
    end
    # Extended class of Color allowing setters to port back values to the shader and its tied entity
    class Color < LiteRGSS::Color
      # Create a new Tied Color
      # @param viewport [Viewport, Sprite] element on which the color is tied
      # @param r [Integer] red color
      # @param g [Integer] green color
      # @param b [Integer] blue color
      # @param a [Integer] alpha factor
      def initialize(viewport, r, g, b, a)
        @viewport = viewport
        super(r, g, b, a)
        update_viewport
      end
      # Set the attribute (according to how it works in normal class)
      # @param args [Array<Integer>]
      def set(*args)
        r = red
        g = green
        b = blue
        a = alpha
        super
        update_viewport if r != red || g != green || b != blue || a != alpha
      end
      # Set the red value
      # @param v [Integer]
      def red=(v)
        return if v == red
        super
        update_viewport
      end
      # Set the green value
      # @param v [Integer]
      def green=(v)
        return if v == green
        super
        update_viewport
      end
      # Set the blue value
      # @param v [Integer]
      def blue=(v)
        return if v == blue
        super
        update_viewport
      end
      # Set the alpha value
      # @param v [Integer]
      def alpha=(v)
        return if v == alpha
        super
        update_viewport
      end
      private
      # Update the viewport color shader attribute
      def update_viewport
        @viewport.shader&.set_float_uniform('color', self)
      end
    end
    # Set color of the viewport
    # @param value [Color]
    def color=(value)
      color.set(value.red, value.green, value.blue, value.alpha)
    end
    # Color of the viewport
    # @return [Color]
    def color
      @color ||= Color.new(self, 0, 0, 0, 0)
    end
    # Set the tone
    # @param value [Tone]
    def tone=(value)
      tone.set(value.red, value.green, value.blue, value.gray)
    end
    # Tone of the viewport
    # @return [Tone]
    def tone
      @tone ||= Tone.new(self, 0, 0, 0, 0)
    end
  end
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
    vp_rect = rect
    if vp_rect.x <= mouse_x && (vp_rect.x + vp_rect.width) > mouse_x && vp_rect.y <= mouse_y && (vp_rect.y + vp_rect.height) > mouse_y
      return true
    end
    return false
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
    vp_rect = rect
    return mouse_x - vp_rect.x + ox, mouse_y - vp_rect.y + oy
  end
end
Graphics.on_start {Viewport.load_configs }
# Class that describe a sprite shown on the screen or inside a viewport
class Sprite < LiteRGSS::ShaderedSprite
  # RGSS Compatibility "update" the sprite
  def update
    return nil
  end
  # define the superiority of the sprite
  # @param z [Integer] superiority
  # @return [self]
  def set_z(z)
    self.z = z
    return self
  end
  # define the pixel of the bitmap that is shown at the coordinate of the sprite.
  # The width and the height is divided by ox and oy to determine the pixel
  # @param ox [Numeric] factor of division of width to get the origin x
  # @param oy [Numeric] factor of division of height to get the origin y
  # @return [self]
  def set_origin_div(ox, oy)
    self.ox = bitmap.width / ox
    self.oy = bitmap.height / oy
    return self
  end
  # Define the surface of the bitmap that is shown on the screen surface
  # @param x [Integer] x coordinate on the bitmap
  # @param y [Integer] y coordinate on the bitmap
  # @param width [Integer] width of the surface
  # @param height [Integer] height of the surface
  # @return [self]
  def set_rect(x, y, width, height)
    src_rect.set(x, y, width, height)
    return self
  end
  # Define the surface of the bitmap that is shown with division of it
  # @param x [Integer] the division index to show on x
  # @param y [Integer] the division index to show on y
  # @param width [Integer] the division of width of the bitmap to show
  # @param height [Integer] the division of height of the bitmap to show
  # @return [self]
  def set_rect_div(x, y, width, height)
    width = bitmap.width / width
    height = bitmap.height / height
    src_rect.set(x * width, y * height, width, height)
    return self
  end
  # Set the texture show on the screen surface
  # @overload load(filename, cache_symbol)
  #   @param filename [String] the name of the image
  #   @param cache_symbol [Symbol] the symbol method to call with filename argument in RPG::Cache
  #   @param auto_rect [Boolean] if the rect should be automatically set
  # @overload load(bmp)
  #   @param texture [Texture, nil] the bitmap to show
  # @return [self]
  def load(texture, cache = nil, auto_rect = false)
    if cache && texture.is_a?(String)
      self.bitmap = RPG::Cache.send(cache, texture)
      set_rect_div(0, 0, 4, 4) if auto_rect && cache == :character
    else
      self.bitmap = texture
    end
    return self
  end
  alias set_bitmap load
  # Define a sprite that mix with a color
  class WithColor < Sprite
    # Create a new Sprite::WithColor
    # @param viewport [LiteRGSS::Viewport, nil]
    def initialize(viewport = nil)
      super(viewport)
      self.shader = Shader.create(:color_shader)
    end
    # Set the Sprite color
    # @param array [Array(Numeric, Numeric, Numeric, Numeric), LiteRGSS::Color] the color (values : 0~1.0)
    # @return [self]
    def color=(array)
      shader.set_float_uniform('color', array)
      return self
    end
    alias set_color color=
  end
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
    if viewport
      return false unless viewport.simple_mouse_in?(mouse_x, mouse_y)
      mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y)
    end
    bx = x
    by = y
    return false if mouse_x < bx || mouse_y < by
    bx += src_rect.width
    by += src_rect.height
    return false if mouse_x >= bx || mouse_y >= by
    return true
  end
  # Detect if the mouse is in the sprite (without rotation)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
    if viewport
      return false unless viewport.simple_mouse_in?(mouse_x, mouse_y)
      mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y)
    end
    bx = x - ox * (zx = zoom_x)
    by = y - oy * (zy = zoom_y)
    return false if mouse_x < bx || mouse_y < by
    bx += src_rect.width * zx
    by += src_rect.height * zy
    return false if mouse_x >= bx || mouse_y >= by
    return true
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
    mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y) if viewport
    mouse_x -= x
    mouse_y -= y
    rect = src_rect
    mouse_x += rect.x
    mouse_y += rect.y
    return mouse_x, mouse_y
  end
end
# @deprecated Please use Sprite directly
class ShaderedSprite < Sprite
end
# Class simulating repeating texture
class Plane < Sprite
  # Shader of the Plane sprite
  SHADER = "// Viewport tone (required)\nuniform vec4 tone;\n// Viewport color (required)\nuniform vec4 color;\n// Zoom configuration\nuniform vec2 zoom;\n// Origin configuration\nuniform vec2 origin;\n// Texture size configuration\nuniform vec2 textureSize;\n// Texture source\nuniform sampler2D texture;\n// Plane Texture (what's zoomed origined etc...)\nuniform sampler2D planeTexture;\n// Screen size\nuniform vec2 screenSize;\n// Gray scale transformation vector\nconst vec3 lumaF = vec3(.299, .587, .114);\n// Main process\nvoid main()\n{\n  // Coordinate on the screen in pixel\n  vec2 screenCoord = gl_TexCoord[0].xy * screenSize;\n  // Coordinaet in the texture in pixel (including zoom)\n  vec2 bmpCoord = mod(origin + screenCoord / zoom, textureSize) / textureSize;\n  vec4 frag = texture2D(planeTexture, bmpCoord);\n  // Tone&Color process\n  frag.rgb = mix(frag.rgb, color.rgb, color.a);\n  float luma = dot(frag.rgb, lumaF);\n  frag.rgb += tone.rgb;\n  frag.rgb = mix(frag.rgb, vec3(luma), tone.w);\n  frag.a *= gl_Color.a;\n  // Result\n  gl_FragColor = frag * texture2D(texture, gl_TexCoord[0].xy);\n}\n"
  # Get the real texture
  # @return [Texture]
  attr_reader :texture
  # Return the visibility of the plane
  # @return [Boolean]
  attr_reader :visible
  # Return the color of the plane /!\ this is unlinked set() won't change the color
  # @return [Color]
  attr_reader :color
  # Return the tone of the plane /!\ this is unlinked set() won't change the color
  # @return [Tone]
  attr_reader :tone
  # Return the blend type
  # @return [Integer]
  attr_reader :blend_type
  # Create a new plane
  # @param viewport [Viewport]
  def initialize(viewport)
    super(viewport)
    self.shader = Shader.new(SHADER)
    self.working_texture = Plane.texture
    self.tone = Tone.new(0, 0, 0, 0)
    self.color = Color.new(255, 255, 255, 0)
    @blend_type = 0
    @texture = nil
    @origin = [0, 0]
    self.visible = true
    set_origin(0, 0)
    @zoom = [1, 1]
    self.zoom = 1
    shader.set_float_uniform('screenSize', [width, height])
  end
  alias working_texture= bitmap=
  alias working_texture bitmap
  # Set the texture of the plane
  # @param texture [Texture]
  def texture=(texture)
    @texture = texture
    if texture.is_a?(LiteRGSS::Bitmap)
      shader.set_texture_uniform('planeTexture', texture)
      shader.set_float_uniform('textureSize', [texture.width, texture.height])
    end
    self.visible = @visible
  end
  alias bitmap= texture=
  alias bitmap texture
  # Set the visibility of the plane
  # @param visible [Boolean]
  def visible=(visible)
    super(visible && @texture.is_a?(LiteRGSS::Bitmap))
    @visible = visible
  end
  # Set the zoom of the Plane
  # @param zoom [Float]
  def zoom=(zoom)
    @zoom[0] = @zoom[1] = zoom
    shader.set_float_uniform('zoom', @zoom)
  end
  # Set the zoom_x of the Plane
  # @param zoom [Float]
  def zoom_x=(zoom)
    @zoom[0] = zoom
    shader.set_float_uniform('zoom', @zoom)
  end
  # Get the zoom_x of the Plane
  # @return [Float]
  def zoom_x
    @zoom[0]
  end
  # Set the zoom_y of the Plane
  # @param zoom [Float]
  def zoom_y=(zoom)
    @zoom[1] = zoom
    shader.set_float_uniform('zoom', @zoom)
  end
  # Get the zoom_y of the Plane
  # @return [Float]
  def zoom_y
    @zoom[1]
  end
  # Set the origin of the Plane
  # @param ox [Float]
  # @param oy [Float]
  def set_origin(ox, oy)
    @origin[0] = ox
    @origin[1] = oy
    shader.set_float_uniform('origin', @origin)
  end
  # Set the ox of the Plane
  # @param origin [Float]
  def ox=(origin)
    @origin[0] = origin
    shader.set_float_uniform('origin', @origin)
  end
  # Get the ox of the Plane
  # @return [Float]
  def ox
    @origin[0]
  end
  # Set the oy of the Plane
  # @param origin [Float]
  def oy=(origin)
    @origin[1] = origin
    shader.set_float_uniform('origin', @origin)
  end
  # Get the oy of the Plane
  # @return [Float]
  def oy
    @origin[1]
  end
  # Set the color of the Plane
  # @param color [Color]
  def color=(color)
    if color != @color && color.is_a?(Color)
      shader.set_float_uniform('color', color)
      @color ||= color
      @color.set(color.red, color.green, color.blue, color.alpha)
    end
  end
  # Set the tone of the Plane
  # @param tone [Tone]
  def tone=(tone)
    if tone != @tone && tone.is_a?(Tone)
      shader.set_float_uniform('tone', tone)
      @tone ||= tone
      @tone.set(tone.red, tone.green, tone.blue, tone.gray)
    end
  end
  # Set the blend type
  # @param blend_type [Integer]
  def blend_type=(blend_type)
    shader.blend_type = blend_type
    @blend_type = blend_type
  end
  class << self
    # Get the generic plane texture
    # @return [Texture]
    def texture
      if !@texture || @texture.disposed?
        @texture = Texture.new(Graphics.width, Graphics.height)
        image = Image.new(Graphics.width, Graphics.height)
        Graphics.height.times do |y|
          image.fill_rect(0, y, Graphics.width, 1, Color.new(255, 255, 255, 255))
        end
        image.copy_to_bitmap(@texture)
        image.dispose
      end
      return @texture
    end
  end
  undef x
  undef x=
  undef y
  undef y=
  undef set_position
end
# Class that describes a text shown on the screen or inside a viewport
class Text < LiteRGSS::Text
  # Detect if the mouse is in the sprite (without rotation and stuff like that)
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
    if viewport
      return false unless viewport.simple_mouse_in?(mouse_x, mouse_y)
      mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y)
    end
    bx = x
    by = y
    return false if mouse_x < bx || mouse_y < by
    bx += width
    by += height
    return false if mouse_x >= bx || mouse_y >= by
    return true
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the sprite
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the sprite
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
    mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y) if viewport
    mouse_x -= x
    mouse_y -= y
    return mouse_x, mouse_y
  end
end
# Class used to show a Window object on screen.
#
# A Window is an object that has a frame (built from #window_builder and #windowskin) and some contents that can be Sprites or Texts.
class Window < LiteRGSS::Window
  # Detect if the mouse is in the window
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Boolean]
  # @author Nuri Yuri
  def simple_mouse_in?(mouse_x = Mouse.x, mouse_y = Mouse.y)
    if viewport
      return false unless viewport.simple_mouse_in?(mouse_x, mouse_y)
      mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y)
    end
    bx = x
    by = y
    return false if mouse_x < bx || mouse_y < by
    bx += width
    by += height
    return false if mouse_x >= bx || mouse_y >= by
    return true
  end
  # Convert mouse coordinate on the screen to mouse coordinates on the window
  # @param mouse_x [Integer] the mouse x position on the screen
  # @param mouse_y [Integer] the mouse y position on the screen
  # @return [Array(Integer, Integer)] the mouse coordinates on the window
  # @author Nuri Yuri
  def translate_mouse_coords(mouse_x = Mouse.x, mouse_y = Mouse.y)
    mouse_x, mouse_y = viewport.translate_mouse_coords(mouse_x, mouse_y) if viewport
    rect = self.rect
    mouse_x -= rect.x - ox
    mouse_y -= rect.y - oy
    return mouse_x, mouse_y
  end
end
# Class allowing to draw Shapes in a viewport
class Shape < LiteRGSS::Shape
end
# Class that allow to draw tiles on a row
class SpriteMap < LiteRGSS::SpriteMap
end
module LiteRGSS
  module Fonts
    @line_heights = []
    class << self
      # Load a line height for a specific font
      # @param font_id [Integer] ID of the font
      # @param line_height [Integer] new line height for the font
      def load_line_height(font_id, line_height)
        @line_heights[font_id] = line_height
      end
      # Get the line height for a specific font
      # @param font_id [Integer] ID of the font
      # @return [Integer]
      def line_height(font_id)
        @line_heights[font_id] || 16
      end
    end
  end
  class Text
    # Module holding few constatns that are still not in configuration file
    # TODO: Move those constants to configuration file
    module Util
      # Default outlinesize, nil gives a 0 and keep shadow processing, 0 or more disable shadow processing
      DEFAULT_OUTLINE_SIZE = nil
      # Offset induced by the Font
      FOY = 2
    end
    # Set a multiline text
    # @param value [String] Multiline text that should be ajusted to be display on multiple lines
    def multiline_text=(value)
      sw = text_width(' ') + 1
      x = 0
      max_width = width
      words = ''
      value.split(/ /).compact.each do |word|
        if word.include?("\n")
          word, next_word = word.split("\n")
          w = text_width(word)
          words << "\n" if x + w > max_width
          x = 0
          words << word << "\n" << next_word << ' '
          x += (text_width(next_word) + sw)
        else
          w = text_width(word)
          if x + w > max_width
            x = 0
            words << "\n"
          end
          words << word << ' '
          x += (w + sw)
        end
      end
      self.text = ' ' if words == text
      self.text = words
    end
  end
end
# Alias access to the Fonts module
Fonts = LiteRGSS::Fonts
Graphics.on_start do
  Configs.texts.fonts.ttf_files.each do |ttf_file|
    id = ttf_file[:id]
    LiteRGSS::Fonts.load_font(id, "Fonts/#{ttf_file[:name]}.ttf")
    LiteRGSS::Fonts.set_default_size(id, ttf_file[:size])
    LiteRGSS::Fonts.load_line_height(id, ttf_file[:lineHeight])
  end
  Configs.texts.fonts.alt_sizes.each do |size|
    id = size[:id]
    LiteRGSS::Fonts.set_default_size(id, size[:size])
    LiteRGSS::Fonts.load_line_height(id, size[:lineHeight])
  end
end
# Module holding the core logic for Fake3D
module Fake3D
  # Module to prepend to one of your Sprite class to make them Fake3D able
  module Sprite3D
    def initialize(viewport)
      super(viewport)
      self.shader = Shader.create(:fake_3d)
      self.z = 1
    end
    # Set the z position of the sprite
    # @param z [Numeric]
    def z=(z)
      super(1000 - z)
      shader.set_float_uniform('z', z)
    end
    # Set the position of the sprite
    # @param x [Integer] x position of the sprite (Warning, 0 is most likely the center of the viewport)
    # @param y [Integer] y position of the sprite (Warning, y still goes to the bottom, 0 is most likely the center of the viewport)
    # @param z [Numeric] z position of the sprite (1 is most likely at scale, 2 is smaller, 0 is illegal)
    def set_position(x, y, z = nil)
      super(x, y)
      self.z = z if z
    end
  end
  # Camera of a Fake3D scene
  #
  # This class is used to help Sprite3D to render at the right position by applying a camera matrix
  class Camera
    # Minimum Z the camera can go
    MIN_Z = 0.1
    # Get the camera pitch
    # @return [Numeric]
    attr_reader :pitch
    # Get the camera yaw
    # @return [Numeric]
    attr_reader :yaw
    # Get the camera roll
    # @return [Numeric]
    attr_reader :roll
    # Check if the camera was updated
    # @return [Boolean]
    attr_reader :was_updated
    # Get the z coordinate of the camera
    # @return [Numeric]
    attr_reader :z
    # Create a new Camera
    # @param viewport [Viewport] viewport used to compute the projection matrix
    def initialize(viewport)
      require 'matrix' unless defined?(Matrix)
      @pitch = 0
      @yaw = 0
      @roll = 0
      @txy_matrix = Matrix[[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
      @scale_tz_matrix = Matrix[[2, 0, 0, 0.0], [0, 2, 0, 0.0], [0, 0, 1, 0.0], [0, 0, 0, 2.0]]
      @rotation_matrix = Matrix[[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
      @projection_matrix = projection_matrix(viewport)
      @was_updated = true
      @z = 1
    end
    # Set the camera rotation
    # @param yaw [Integer] angle around axis z
    # @param pitch [Integer] angle around axis y
    # @param roll [Integer] angle around axis x
    def set_rotation(yaw, pitch, roll)
      @was_updated = true
      @pitch = pitch % 360
      @yaw = yaw % 360
      @roll = roll % 360
      @rotation_matrix = pitch_yaw_roll(@pitch, @yaw, @roll)
    end
    # Set the camera position
    # @param x [Numeric] x position of the camera
    # @param y [Numeric] y position of the camera
    # @param z [Numeric] z position of the camera (z = 1 => sprite of z = 1 at scale, sprite of z = 2 demi scale, z = 2 => sprite of z = 1 might disappear, sprite of z = 2 at scale)
    def set_position(x, y, z)
      @was_updated = true
      apply_z(z)
      @txy_matrix[0, 3] = -x
      @txy_matrix[1, 3] = -y
    end
    # Get the x coordinate of the camera
    # @return [Numeric]
    def x
      return -@txy_matrix[0, 3]
    end
    # Get the y coordinate of the camera
    # @return [Numeric]
    def y
      return -@txy_matrix[1, 3]
    end
    # Apply the camera to a sprite
    # @param sprite [Sprite3D, Array<Sprite3D>]
    def apply_to(sprite)
      @camera_matrix = compute_matrix if @was_updated
      uniform = 'camera'
      if sprite.is_a?(Array)
        sprite.each { |sp| sp.shader.set_matrix_uniform(uniform, @camera_matrix) }
      else
        sprite.shader.set_matrix_uniform(uniform, @camera_matrix)
      end
    end
    private
    # Apply the Z of the camera. Overwrite this method to apply your own z computation
    # @param z [Float]
    def apply_z(z)
      z = z.clamp(MIN_Z, Float::INFINITY)
      @scale_tz_matrix[3, 3] = 1 / (0.5 * z)
      @z = z
    end
    def pitch_yaw_roll(pitch, yaw, roll)
      pitch *= Math::PI / 180
      yaw *= Math::PI / 180
      roll *= Math::PI / 180
      cos_beta = Math.cos(pitch)
      sin_beta = Math.sin(pitch)
      cos_alpha = Math.cos(yaw)
      sin_alpha = Math.sin(yaw)
      cos_gamma = Math.cos(roll)
      sin_gamma = Math.sin(roll)
      return Matrix[[cos_alpha * cos_beta, cos_alpha * sin_beta * sin_gamma - sin_alpha * cos_gamma, cos_alpha * sin_beta * cos_gamma + sin_alpha * sin_gamma, 0], [sin_alpha * cos_beta, sin_alpha * sin_beta * sin_gamma + cos_alpha * cos_gamma, sin_alpha * sin_beta * cos_gamma - cos_alpha * sin_gamma, 0], [-sin_beta, cos_beta * sin_gamma, cos_beta * cos_gamma, 0], [0, 0, 0, 1]]
    end
    # @param viewport [Viewport] viewport used to compute the projection matrix
    def projection_matrix(viewport)
      a = 2 / viewport.rect.width.to_f
      b = -2 / viewport.rect.height.to_f
      return Matrix[[a, 0, 0, 0], [0, b, 0, 0], [0, 0, 0, 1], [0, 0, 1, 0]]
    end
    def compute_matrix
      @was_updated = false
      return (@scale_tz_matrix * @rotation_matrix * @projection_matrix * @txy_matrix).transpose.to_a.flatten
    end
  end
end
# Shader loaded applicable to a Sprite/Viewport or Graphics
#
# Special features:
#   Shader.register(name_sym, frag_file, vert_file = nil, tone_process: false, color_process: false, alpha_process: false)
#     This function registers a shader as name name_sym
#       if frag_file contains `void main()` it'll assume its the file contents of the shader
#       otherwise it'll assume it's the filename and load it from disc
#       if vert_file is nil, it won't load the vertex shader
#       if vert_file contains `void main()` it'll assume it's the file contents of the shader
#       otherwise it'll assume it's the filename and load it from disc
#       tone_process adds tone process to the shader (fragment color needs to be called frag), it'll add the required constant and uniforms (tone)
#       color_process adds the color process to the shader (fragment color needs to be called frag), it'll add the required uniforms (color)
#       alpha_process adds the alpha process to the shader (fragment color needs to be called frag), it'll use gl_Color.a
#   Shader.create(name_sym)
#     This function instanciate a shader by it's name_sym so you don't have to load the files several time and you have all the correct data
# @note `#version 120` will be automatically added to the begining of the file if not present
class Shader < LiteRGSS::Shader
  # Shader version based on the platform
  SHADER_VERSION = PSDK_PLATFORM == :macos ? "#version 120\n" : "#version 130\n"
  # Color uniform
  COLOR_UNIFORM = "\\0uniform vec4 color;\n"
  # Color process
  COLOR_PROCESS = "\n  frag.rgb = mix(frag.rgb, color.rgb, color.a);\\0"
  # Tone uniform
  TONE_UNIFORM = "\\0uniform vec4 tone;\nconst vec3 lumaF = vec3(.299, .587, .114);\n"
  # Tone process
  TONE_PROCESS = "\n  float luma = dot(frag.rgb, lumaF);\n  frag.rgb = mix(frag.rgb, vec3(luma), tone.w);\n  frag.rgb += tone.rgb;\\0"
  # Alpha process
  ALPHA_PROCESS = "\n  frag.a *= gl_Color.a;\\0"
  # Default shader when there's nothing to do
  DEFAULT_SHADER = "#{SHADER_VERSION}\nuniform sampler2D texture;\nvoid main() {\n  vec4 frag = texture2D(texture, gl_TexCoord[0].xy);\n  gl_FragColor = frag;\n}\n"
  # Part detecting the shader code begin
  SHADER_CONTENT_DETECTION = 'void main()'
  # Part detecting the shader version pre-processor
  SHADER_VERSION_DETECTION = '#version '
  # Part responsive of detecting where to add the processes
  SHADER_FRAG_FEATURE_ADD = /\n( |)+gl_FragColor( |)+=/
  # Part responsive of detecting where to add the uniforms
  SHADER_UNIFORM_ADD = /\#version[^\n]+\n/
  @registered_shaders = {}
  @pre_registered_shaders = {}
  class << self
    # Register a new shader by it's name
    # @param name_sym [Symbol] name of the shader
    # @param frag_file [String] file content or filename of the frag shader, the function will look at void main() to know
    # @param vert_file [String] file content or filename of the vertex shader, the function will look at void main() to know
    # @param tone_process [Boolean] if the function should add tone_process to the shader
    # @param color_process [Boolean] if the function should add color_process to the shader
    # @param alpha_process [Boolean] if the function should add alpha_process to the shader
    def register(name_sym, frag_file, vert_file = nil, tone_process: false, color_process: false, alpha_process: false)
      @pre_registered_shaders[name_sym] = [frag_file, vert_file, color_process, tone_process, alpha_process]
    end
    # Function that creates a shader by its name
    # @param name_sym [Symbol] name of the shader
    # @return [Shader]
    def create(name_sym)
      Shader.new(*load_shader_params(name_sym))
    end
    # Function that loads the shader params by its name
    # @param name_sym [Symbol] name of the shader
    # @return [Array<String>]
    def load_shader_params(name_sym)
      return @registered_shaders[name_sym] if @registered_shaders.key?(name_sym)
      return load_shader_params_from_pre_registered_shader(name_sym) if @pre_registered_shaders.key?(name_sym)
      log_error("Failed to load #{name_sym} shader. It is not registered!")
      return [DEFAULT_SHADER]
    end
    # Function that loads the shader params by its name from pre-registered shaders
    # @param name_sym [Symbol] name of the shader
    # @return [Array<String>]
    def load_shader_params_from_pre_registered_shader(name_sym)
      log_info("Loading #{name_sym} shader")
      frag_file, vert_file, color_process, tone_process, alpha_process = @pre_registered_shaders[name_sym]
      frag = load_shader_file(frag_file)
      vert = vert_file && load_shader_file(vert_file, true)
      frag = add_frag_color(frag) if color_process
      frag = add_frag_tone(frag) if tone_process
      frag = add_frag_alpha(frag) if alpha_process
      params = [vert, frag].compact
      @registered_shaders[name_sym] = params
      @pre_registered_shaders.delete(name_sym)
      return params
    end
    # Load a shader data from a file
    # @param filename [String] name of the file in Graphics/Shaders
    # @return [String] the shader string
    def load_to_string(filename)
      log_error("Calling Shader.load_to_string is deprecated, please use Shader.create(name) instead to get the right shader.\nThe game will sleep 10 seconds to make sure you see this message")
      sleep(10)
      return File.read("graphics/shaders/#{filename.downcase}.txt")
    rescue StandardError
      log_error("Failed to load shader #{filename}, sprite using this shader will not display correctly")
      return @registered_shaders[:full_shader]&.last || DEFAULT_SHADER
    end
    private
    # Function that loads the shader file
    # @param filecontent_or_name [String]
    # @param is_vertex [Boolean] is set to true, returns nil when file does not exists
    # @return [String, nil]
    def load_shader_file(filecontent_or_name, is_vertex = false)
      contents = filecontent_or_name if filecontent_or_name.include?(SHADER_CONTENT_DETECTION)
      contents ||= load_shader_from_file(filecontent_or_name, is_vertex)
      return contents unless contents
      return SHADER_VERSION + contents unless contents.include?(SHADER_VERSION_DETECTION)
      return contents
    end
    # Function that auto-loads the content of a shader from file
    # @param filename [String]
    # @param is_vertex [Boolean] is set to true, returns nil when file does not exists
    # @return [String, nil]
    def load_shader_from_file(filename, is_vertex)
      return File.read(filename) if File.exist?(filename)
      log_error("Failed to load #{filename} shader")
      return is_vertex ? nil : DEFAULT_SHADER
    end
    # Function that adds the color processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_color(shader)
      return shader.sub(SHADER_UNIFORM_ADD, COLOR_UNIFORM).sub(SHADER_FRAG_FEATURE_ADD, COLOR_PROCESS)
    end
    # Function that adds the tone processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_tone(shader)
      return shader.sub(SHADER_UNIFORM_ADD, TONE_UNIFORM).sub(SHADER_FRAG_FEATURE_ADD, TONE_PROCESS)
    end
    # Function that adds the alpha processing to shader
    # @param shader [String] shader code
    # @return [String]
    def add_frag_alpha(shader)
      return shader.sub(SHADER_FRAG_FEATURE_ADD, ALPHA_PROCESS)
    end
  end
  background_color_shader = DEFAULT_SHADER.sub(SHADER_FRAG_FEATURE_ADD, "\n  frag.a = max(frag.a, color.a);\\0")
  register(:map_shader, background_color_shader, 'graphics/shaders/map_viewport.vert', tone_process: true, color_process: true)
  register(:tone_shader, DEFAULT_SHADER, tone_process: true, alpha_process: true)
  register(:color_shader, DEFAULT_SHADER, color_process: true, alpha_process: true)
  register(:color_shader_with_background, background_color_shader, color_process: true, alpha_process: true)
  register(:full_shader, DEFAULT_SHADER, tone_process: true, color_process: true, alpha_process: true)
  register(:yuki_circular, 'graphics/shaders/yuki_transition_circular.txt')
  register(:yuki_directed, 'graphics/shaders/yuki_transition_directed.txt')
  register(:yuki_weird, 'graphics/shaders/yuki_transition_weird.txt')
  register(:blur, 'graphics/shaders/blur.txt')
  register(:battle_shadow, 'graphics/shaders/battle_shadow.frag', 'graphics/shaders/battle_shadow.vert')
  register(:battle_backout, 'graphics/shaders/battle_backout.frag')
  register(:graphics_transition, Graphics::TRANSITION_FRAG_SHADER)
  register(:graphics_transition_static, Graphics::STATIC_TRANSITION_FRAG_SHADER)
  register(:rby_trainer, 'graphics/shaders/rbytrainer.frag')
  register(:rs_sprite_side, 'graphics/shaders/rs_wild_ext_side.frag')
  register(:black_to_white, 'graphics/shaders/black_to_white.frag')
  register(:dpp_sprite_side, 'graphics/shaders/dpp_wild_ext_side.frag')
  register(:sinusoidal, 'graphics/shaders/hgss_wild_sea.frag')
  register(:bw_wild_sea, 'graphics/shaders/bw_wild_sea.frag')
  register(:fake_3d, 'graphics/shaders/fake_3d.frag', 'graphics/shaders/fake_3d.vert', tone_process: true, color_process: true, alpha_process: true)
  register(:battle_shadow_3d, 'graphics/shaders/battle_shadow.frag', 'graphics/shaders/battle_shadow_3d.vert')
end
module RPG
  # Script that cache bitmaps when they are reusable.
  # @author Nuri Yuri
  module Cache
    # Array of load methods to call when the game starts
    LOADS = %i[load_animation load_autotile load_ball load_battleback load_battler load_character load_fog load_icon load_panorama load_particle load_pc load_picture load_pokedex load_title load_tileset load_transition load_interface load_foot_print load_b_icon load_poke_front load_poke_back]
    # Extension of gif files
    GIF_EXTENSION = '.gif'
    # Common filename of the image to load
    Common_filename = 'Graphics/%s/%s'
    # Common filename with .png
    Common_filename_format = format('%s.png', Common_filename)
    # Notification message when an image couldn't be loaded properly
    Notification_title = 'Failed to load graphic'
    # Path where autotiles are stored from Graphics
    Autotiles_Path = 'autotiles'
    # Path where animations are stored from Graphics
    Animations_Path = 'animations'
    # Path where ball are stored from Graphics
    Ball_Path = 'ball'
    # Path where battlebacks are stored from Graphics
    BattleBacks_Path = 'battlebacks'
    # Path where battlers are stored from Graphics
    Battlers_Path = 'battlers'
    # Path where characters are stored from Graphics
    Characters_Path = 'characters'
    # Path where fogs are stored from Graphics
    Fogs_Path = 'fogs'
    # Path where icons are stored from Graphics
    Icons_Path = 'icons'
    # Path where interface are stored from Graphics
    Interface_Path = 'interface'
    # Path where panoramas are stored from Graphics
    Panoramas_Path = 'panoramas'
    # Path where particles are stored from Graphics
    Particles_Path = 'particles'
    # Path where pc are stored from Graphics
    PC_Path = 'pc'
    # Path where pictures are stored from Graphics
    Pictures_Path = 'pictures'
    # Path where pokedex images are stored from Graphics
    Pokedex_Path = 'pokedex'
    # Path where titles are stored from Graphics
    Titles_Path = 'titles'
    # Path where tilesets are stored from Graphics
    Tilesets_Path = 'tilesets'
    # Path where transitions are stored from Graphics
    Transitions_Path = 'transitions'
    # Path where windowskins are stored from Graphics
    Windowskins_Path = 'windowskins'
    # Path where footprints are stored from Graphics
    Pokedex_FootPrints_Path = 'pokedex/footprints'
    # Path where pokeicon are stored from Graphics
    Pokedex_PokeIcon_Path = 'pokedex/pokeicon'
    # Path where pokefront are stored from Graphics
    Pokedex_PokeFront_Path = ['pokedex/pokefront', 'pokedex/pokefrontshiny']
    # Path where pokeback are stored from Graphics
    Pokedex_PokeBack_Path = ['pokedex/pokeback', 'pokedex/pokebackshiny']
    module_function
    # Gets the default bitmap
    # @note Should be used in scripts that require a bitmap be doesn't perform anything on the bitmap
    def default_bitmap
      @default_bitmap = Texture.new(16, 16) if @default_bitmap&.disposed?
      @default_bitmap
    end
    # Dispose every bitmap of a cache table
    # @param cache_tab [Hash{String => Texture}] cache table where bitmaps should be disposed
    def dispose_bitmaps_from_cache_tab(cache_tab)
      cache_tab.each_value { |bitmap| bitmap.dispose if bitmap && !bitmap.disposed? }
      cache_tab.clear
    end
    # Test if a file exist
    # @param filename [String] filename of the image
    # @param path [String] path of the image inside Graphics/
    # @param file_data [Yuki::VD] "virtual directory"
    # @return [Boolean] if the image exist or not
    def test_file_existence(filename, path, file_data = nil)
      return true if file_data&.exists?(filename.downcase)
      return true if File.exist?(format(Common_filename_format, path, filename).downcase)
      return true if File.exist?(format(Common_filename, path, filename).downcase)
      false
    end
    # Loads an image (from cache, disk or virtual directory)
    # @param cache_tab [Hash{String => Texture}] cache table where bitmaps are being stored
    # @param filename [String] filename of the image
    # @param path [String] path of the image inside Graphics/
    # @param file_data [Yuki::VD] "virtual directory"
    # @param image_class [Class] Texture or Image depending on the desired process
    # @return [Texture]
    # @note This function displays a desktop notification if the image is not found.
    #       The resultat bitmap is an empty 16x16 bitmap in this case.
    def load_image(cache_tab, filename, path, file_data = nil, image_class = Texture)
      complete_filename = format(Common_filename, path, filename).downcase
      return bitmap = image_class.new(16, 16) if File.directory?(complete_filename) || filename.empty?
      return File.binread(complete_filename) if File.exist?(complete_filename)
      bitmap = cache_tab.fetch(filename, nil)
      if !bitmap || bitmap.disposed?
        filename_ext = "#{complete_filename}.png"
        bitmap = image_class.new(filename_ext) if File.exist?(filename_ext) || !file_data.exists?(filename.downcase)
        bitmap = load_image_from_file_data(filename, file_data, image_class) if (!bitmap || bitmap.disposed?) && file_data
        bitmap ||= image_class.new(16, 16)
      end
      return bitmap
    rescue StandardError
      log_error "#{Notification_title} #{complete_filename}"
      return bitmap = image_class.new("\x89PNG\r\n\x1a\n\0\0\0\rIHDR\0\0\0 \0\0\0 \x02\x03\0\0\0\x0e\x14\x92g\0\0\0\tPLTE\0\0\0\xff\xff\xff\xff\0\0\xcd^\xb7\x9c\0\0\0>IDATx\x01\x85\xcf1\x0e\0 \x08CQ\x17\xef\xe7\xd2\x85\xfb\xb1\xf4\x94&$Fm\x07\xfe\xf4\x06B`x\x13\xd5z\xc0\xea\x07 H \x04\x91\x02\xd2\x01E\x9e\xcd\x17\xd1\xc3/\xecg\xecSk\x03[\xafg\x99\xe2\xed\xcfV\0\0\0\0IEND\xaeB`\x82", true)
    ensure
      cache_tab[filename] = bitmap if bitmap.is_a?(Texture)
    end
    # Loads an image from virtual directory with the right encoding
    # @param filename [String] filename of the image
    # @param file_data [Yuki::VD] "virtual directory"
    # @param image_class [Class] Texture or Image depending on the desired process
    # @return [Texture] the image loaded from the virtual directory
    def load_image_from_file_data(filename, file_data, image_class)
      bitmap_data = file_data.read_data(filename.downcase)
      return bitmap_data if filename.end_with?(GIF_EXTENSION)
      bitmap = image_class.new(bitmap_data, true) if bitmap_data
      bitmap
    end
    # Load/unload the animation cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_animation(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@animation_cache)
      else
        @animation_cache = {}
        @animation_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/animation' : "#{PSDK_PATH}resources/animation", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def animation_exist?(filename)
      test_file_existence(filename, Animations_Path, @animation_data)
    end
    # Load an animation image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def animation(filename, _hue = 0)
      load_image(@animation_cache, filename, Animations_Path, @animation_data)
    end
    # Load/unload the autotile cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_autotile(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@autotile_cache)
      else
        @autotile_cache = {}
        @autotile_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/autotile' : "#{PSDK_PATH}resources/autotile", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def autotile_exist?(filename)
      test_file_existence(filename, Autotiles_Path, @autotile_data)
    end
    # Load an autotile image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def autotile(filename, _hue = 0)
      load_image(@autotile_cache, filename, Autotiles_Path, @autotile_data)
    end
    # Load/unload the ball cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_ball(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@ball_cache)
      else
        @ball_cache = {}
        @ball_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/ball' : "#{PSDK_PATH}resources/ball", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def ball_exist?(filename)
      test_file_existence(filename, Ball_Path, @ball_data)
    end
    # Load ball animation image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def ball(filename, _hue = 0)
      load_image(@ball_cache, filename, Ball_Path, @ball_data)
    end
    # Load/unload the battleback cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_battleback(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@battleback_cache)
      else
        @battleback_cache = {}
        @battleback_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/battleback' : "#{PSDK_PATH}resources/battleback", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def battleback_exist?(filename)
      test_file_existence(filename, BattleBacks_Path, @battleback_data)
    end
    # Load a battle back image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def battleback(filename, _hue = 0)
      load_image(@battleback_cache, filename, BattleBacks_Path, @battleback_data)
    end
    # Load/unload the battler cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_battler(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@battler_cache)
      else
        @battler_cache = {}
        @battler_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/battler' : "#{PSDK_PATH}resources/battler", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def battler_exist?(filename)
      test_file_existence(filename, Battlers_Path, @battler_data)
    end
    # Load a battler image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def battler(filename, _hue = 0)
      load_image(@battler_cache, filename, Battlers_Path, @battler_data)
    end
    # Load/unload the character cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_character(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@character_cache)
      else
        @character_cache = {}
        @character_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/character' : "#{PSDK_PATH}resources/character", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def character_exist?(filename)
      test_file_existence(filename, Characters_Path, @character_data)
    end
    # Load a character image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def character(filename, _hue = 0)
      load_image(@character_cache, filename, Characters_Path, @character_data)
    end
    # Load/unload the fog cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_fog(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@fog_cache)
      else
        @fog_cache = {}
        @fog_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/fog' : "#{PSDK_PATH}resources/fog", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def fog_exist?(filename)
      test_file_existence(filename, Fogs_Path, @fog_data)
    end
    # Load a fog image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def fog(filename, _hue = 0)
      load_image(@fog_cache, filename, Fogs_Path, @fog_data)
    end
    # Load/unload the icon cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_icon(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@icon_cache)
      else
        @icon_cache = {}
        @icon_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/icon' : "#{PSDK_PATH}resources/icon", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def icon_exist?(filename)
      test_file_existence(filename, Icons_Path, @icon_data)
    end
    # Load an icon
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def icon(filename, _hue = 0)
      load_image(@icon_cache, filename, Icons_Path, @icon_data)
    end
    # Load/unload the interface cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_interface(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@interface_cache)
      else
        @interface_cache = {}
        @interface_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/interface' : "#{PSDK_PATH}resources/interface", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def interface_exist?(filename)
      test_file_existence(filename, Interface_Path, @interface_data)
    end
    # Load an interface image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def interface(filename, _hue = 0)
      if interface_exist?(filename_with_language = filename + ($options&.language || 'en')) || interface_exist?(filename_with_language = "#{filename}en")
        filename = filename_with_language
      end
      load_image(@interface_cache, filename, Interface_Path, @interface_data)
    end
    # Load an interface "Image" (to perform some background process)
    # @param filename [String] name of the image in the folder
    # @return [Image]
    def interface_image(filename)
      if interface_exist?(filename_with_language = filename + ($options&.language || 'en')) || interface_exist?(filename_with_language = "#{filename}en")
        filename = filename_with_language
      end
      load_image(@interface_cache, filename, Interface_Path, @interface_data, Image)
    end
    # Load/unload the panorama cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_panorama(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@panorama_cache)
      else
        @panorama_cache = {}
        @panorama_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/panorama' : "#{PSDK_PATH}resources/panorama", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def panorama_exist?(filename)
      test_file_existence(filename, Panoramas_Path, @panorama_data)
    end
    # Load a panorama image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def panorama(filename, _hue = 0)
      load_image(@panorama_cache, filename, Panoramas_Path, @panorama_data)
    end
    # Load/unload the particle cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_particle(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@particle_cache)
      else
        @particle_cache = {}
        @particle_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/particle' : "#{PSDK_PATH}resources/particle", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def particle_exist?(filename)
      test_file_existence(filename, Particles_Path, @particle_data)
    end
    # Load a particle image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def particle(filename, _hue = 0)
      load_image(@particle_cache, filename, Particles_Path, @particle_data)
    end
    # Load/unload the pc cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_pc(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@pc_cache)
      else
        @pc_cache = {}
        @pc_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/pc' : "#{PSDK_PATH}resources/pc", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def pc_exist?(filename)
      test_file_existence(filename, PC_Path, @pc_data)
    end
    # Load a pc image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def pc(filename, _hue = 0)
      load_image(@pc_cache, filename, PC_Path, @pc_data)
    end
    # Load/unload the picture cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_picture(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@picture_cache)
      else
        @picture_cache = {}
        @picture_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/picture' : "#{PSDK_PATH}resources/picture", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def picture_exist?(filename)
      test_file_existence(filename, Pictures_Path, @picture_data)
    end
    # Load a picture image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def picture(filename, _hue = 0)
      load_image(@picture_cache, filename, Pictures_Path, @picture_data)
    end
    # Load/unload the pokedex cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_pokedex(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@pokedex_cache)
      else
        @pokedex_cache = {}
        @pokedex_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/pokedex' : "#{PSDK_PATH}resources/pokedex", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def pokedex_exist?(filename)
      test_file_existence(filename, Pokedex_Path, @pokedex_data)
    end
    # Load a pokedex image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def pokedex(filename, _hue = 0)
      load_image(@pokedex_cache, filename, Pokedex_Path, @pokedex_data)
    end
    # Load/unload the title cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_title(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@title_cache)
      else
        @title_cache = {}
        @title_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/title' : "#{PSDK_PATH}resources/title", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def title_exist?(filename)
      test_file_existence(filename, Titles_Path, @title_data)
    end
    # Load a title image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def title(filename, _hue = 0)
      load_image(@title_cache, filename, Titles_Path, @title_data)
    end
    # Load/unload the tileset cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_tileset(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@tileset_cache)
      else
        @tileset_cache = {}
        @tileset_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/tileset' : "#{PSDK_PATH}resources/tileset", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def tileset_exist?(filename)
      test_file_existence(filename, Tilesets_Path, @tileset_data)
    end
    # Load a tileset image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def tileset(filename, _hue = 0)
      load_image(@tileset_cache, filename, Tilesets_Path, @tileset_data)
    end
    # Load a tileset "Image" (to perform some background process)
    # @param filename [String] name of the image in the folder
    # @return [Image]
    def tileset_image(filename)
      load_image(@tileset_cache, filename, Tilesets_Path, @tileset_data, Image)
    end
    # Load/unload the transition cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_transition(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@transition_cache)
      else
        @transition_cache = {}
        @transition_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/transition' : "#{PSDK_PATH}resources/transition", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def transition_exist?(filename)
      test_file_existence(filename, Transitions_Path, @transition_data)
    end
    # Load a transition image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def transition(filename, _hue = 0)
      load_image(@transition_cache, filename, Transitions_Path, @transition_data)
    end
    # Load/unload the windoskin cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_windowskin(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@windowskin_cache)
      else
        @windowskin_cache = {}
        @windowskin_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/windowskin' : "#{PSDK_PATH}resources/windowskin", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def windowskin_exist?(filename)
      test_file_existence(filename, Windowskins_Path, @windowskin_data)
    end
    # Load a windowskin image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def windowskin(filename, _hue = 0)
      load_image(@windowskin_cache, filename, Windowskins_Path, @windowskin_data)
    end
    # Load/unload the foot print cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_foot_print(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@foot_print_cache)
      else
        @foot_print_cache = {}
        @foot_print_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/foot_print' : "#{PSDK_PATH}resources/foot_print", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def foot_print_exist?(filename)
      test_file_existence(filename, Pokedex_FootPrints_Path, @foot_print_data)
    end
    # Load a foot print image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def foot_print(filename, _hue = 0)
      load_image(@foot_print_cache, filename, Pokedex_FootPrints_Path, @foot_print_data)
    end
    # Load/unload the pokemon icon cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_b_icon(flush_it = false)
      if flush_it
        dispose_bitmaps_from_cache_tab(@b_icon_cache)
      else
        @b_icon_cache = {}
        @b_icon_data = Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/b_icon' : "#{PSDK_PATH}resources/b_icon", :read)
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @return [Boolean]
    def b_icon_exist?(filename)
      test_file_existence(filename, Pokedex_PokeIcon_Path, @b_icon_data)
    end
    # Load a Pokemon icon image
    # @param filename [String] name of the image in the folder
    # @param _hue [Integer] ingored (compatibility with RMXP)
    # @return [Texture]
    def b_icon(filename, _hue = 0)
      load_image(@b_icon_cache, filename, Pokedex_PokeIcon_Path, @b_icon_data)
    end
    # Load/unload the pokemon front cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_poke_front(flush_it = false)
      if flush_it
        @poke_front_cache.each { |cache_tab| dispose_bitmaps_from_cache_tab(cache_tab) }
      else
        @poke_front_cache = Array.new(Pokedex_PokeFront_Path.size) {{} }
        @poke_front_data = [Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/poke_front' : "#{PSDK_PATH}resources/poke_front", :read), Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/poke_front_s' : "#{PSDK_PATH}resources/poke_front_s", :read)]
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @param hue [Integer] if the front is shiny or not
    # @return [Boolean]
    def poke_front_exist?(filename, hue = 0)
      test_file_existence(filename, Pokedex_PokeFront_Path.fetch(hue), @poke_front_data[hue])
    end
    # Load a pokemon face image
    # @param filename [String] name of the image in the folder
    # @param hue [Integer] 0 = normal, 1 = shiny
    # @return [Texture]
    def poke_front(filename, hue = 0)
      load_image(@poke_front_cache.fetch(hue), filename, Pokedex_PokeFront_Path.fetch(hue), @poke_front_data[hue])
    end
    # Load/unload the pokemon back cache
    # @param flush_it [Boolean] if we need to flush the cache
    def load_poke_back(flush_it = false)
      if flush_it
        @poke_back_cache.each { |cache_tab| dispose_bitmaps_from_cache_tab(cache_tab) }
      else
        @poke_back_cache = Array.new(Pokedex_PokeBack_Path.size) {{} }
        @poke_back_data = [Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/poke_back' : "#{PSDK_PATH}resources/poke_back", :read), Yuki::VD.new(PSDK_CONFIG.release? ? 'graphics/poke_back_s' : "#{PSDK_PATH}resources/poke_back_s", :read)]
      end
    end
    # Test if the image exist in the folder
    # @param filename [String]
    # @param hue [Integer] if the back is shiny or not
    # @return [Boolean]
    def poke_back_exist?(filename, hue = 0)
      test_file_existence(filename, Pokedex_PokeBack_Path.fetch(hue), @poke_back_data[hue])
    end
    # Load a pokemon back image
    # @param filename [String] name of the image in the folder
    # @param hue [Integer] 0 = normal, 1 = shiny
    # @return [Texture]
    def poke_back(filename, hue = 0)
      load_image(@poke_back_cache.fetch(hue), filename, Pokedex_PokeBack_Path.fetch(hue), @poke_back_data[hue])
    end
  end
  class Animation
    attr_accessor :id
    attr_accessor :name
    attr_accessor :animation_name
    attr_accessor :animation_hue
    attr_accessor :position
    attr_accessor :frame_max
    attr_accessor :frames
    attr_accessor :timings
    class Frame
      attr_accessor :cell_max
      attr_accessor :cell_data
    end
    class Timing
      attr_accessor :frame
      attr_accessor :se
      attr_accessor :flash_scope
      attr_accessor :flash_color
      attr_accessor :flash_duration
      attr_accessor :condition
    end
  end
  class AudioFile
    def initialize(name = '', volume = 100, pitch = 100)
      @name = name
      @volume = volume
      @pitch = pitch
    end
    attr_accessor :name
    attr_accessor :volume
    attr_accessor :pitch
  end
  class Class
    class Learning
    end
  end
  class CommonEvent
    attr_accessor :id
    attr_accessor :name
    attr_accessor :trigger
    attr_accessor :switch_id
    attr_accessor :list
  end
  class Enemy
    attr_accessor :id
    attr_accessor :name
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :maxhp
    attr_accessor :str
    attr_accessor :dex
    attr_accessor :agi
    attr_accessor :int
    attr_accessor :atk
    attr_accessor :pdef
    attr_accessor :mdef
    attr_accessor :eva
    attr_accessor :element_ranks
    attr_accessor :state_ranks
    attr_accessor :actions
    attr_accessor :exp
    attr_accessor :gold
    attr_accessor :item_id
    attr_accessor :weapon_id
    attr_accessor :armor_id
    attr_accessor :treasure_prob
    class Action
    end
  end
  class Event
    attr_accessor :id
    attr_accessor :name
    attr_accessor :x
    attr_accessor :y
    attr_accessor :pages
    # Properties dedicated to the MapLinker
    attr_accessor :original_id, :original_map, :offset_x, :offset_y
    class Page
      attr_accessor :condition
      attr_accessor :graphic
      attr_accessor :move_type
      attr_accessor :move_speed
      attr_accessor :move_frequency
      attr_accessor :move_route
      attr_accessor :walk_anime
      attr_accessor :step_anime
      attr_accessor :direction_fix
      attr_accessor :through
      attr_accessor :always_on_top
      attr_accessor :trigger
      attr_accessor :list
      class Condition
        # Return if the page condition is currently valid
        # @param map_id [Integer] ID of the map where the event is
        # @param event_id [Integer] ID of the event
        # @return [Boolean] if the page is valid
        def valid?(map_id, event_id)
          return false if @switch1_valid && !$game_switches[@switch1_id]
          return false if @switch2_valid && !$game_switches[@switch2_id]
          return false if @variable_valid && $game_variables[@variable_id] < @variable_value
          if @self_switch_valid
            return false unless $game_self_switches[[map_id, event_id, @self_switch_ch]]
          end
          return true
        end
        attr_accessor :switch1_valid
        attr_accessor :switch2_valid
        attr_accessor :variable_valid
        attr_accessor :self_switch_valid
        attr_accessor :switch1_id
        attr_accessor :switch2_id
        attr_accessor :variable_id
        attr_accessor :variable_value
        attr_accessor :self_switch_ch
      end
      class Graphic
        attr_accessor :tile_id
        attr_accessor :character_name
        attr_accessor :character_hue
        attr_accessor :direction
        attr_accessor :pattern
        attr_accessor :opacity
        attr_accessor :blend_type
      end
    end
  end
  class EventCommand
    attr_accessor :code
    attr_accessor :indent
    attr_accessor :parameters
  end
  class Map
    def initialize(width, height)
      @tileset_id = 1
      @width = width
      @height = height
      @autoplay_bgm = false
      @bgm = RPG::AudioFile.new
      @autoplay_bgs = false
      @bgs = RPG::AudioFile.new('', 80)
      @encounter_list = []
      @encounter_step = 30
      @data = Table.new(width, height, 3)
      @data.fill(0)
      @events = {}
    end
    attr_accessor :tileset_id
    attr_accessor :width
    attr_accessor :height
    attr_accessor :autoplay_bgm
    attr_accessor :bgm
    attr_accessor :autoplay_bgs
    attr_accessor :bgs
    attr_accessor :encounter_list
    attr_accessor :encounter_step
    attr_accessor :data
    attr_accessor :events
  end
  class MapInfo
    attr_accessor :name
    attr_accessor :parent_id
    attr_accessor :order
    attr_accessor :expanded
    attr_accessor :scroll_x
    attr_accessor :scroll_y
  end
  class MoveCommand
    def initialize(code = 0, parameters = [])
      @code = code
      @parameters = parameters
    end
    attr_accessor :code
    attr_accessor :parameters
  end
  class MoveRoute
    def initialize
      @repeat = true
      @skippable = false
      @list = [RPG::MoveCommand.new]
    end
    attr_accessor :repeat
    attr_accessor :skippable
    attr_accessor :list
  end
  class Sprite < ::Sprite
    attr_accessor :blend_type
    attr_accessor :bush_depth
    attr_accessor :tone
    attr_accessor :color
    def flash(*args)
    end
    def color
      return Color.new(0, 0, 0, 0)
    end
    def tone
      return Tone.new(0, 0, 0, 0)
    end
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
    end
    def dispose
      dispose_damage
      dispose_animation
      dispose_loop_animation
      super
    end
    def whiten
      self.blend_type = 0
      self.color.set(255, 255, 255, 128)
      self.opacity = 255
      @_whiten_duration = 16
      @_appear_duration = 0
      @_escape_duration = 0
      @_collapse_duration = 0
    end
    def appear
      self.blend_type = 0
      self.color.set(0, 0, 0, 0)
      self.opacity = 0
      @_appear_duration = 16
      @_whiten_duration = 0
      @_escape_duration = 0
      @_collapse_duration = 0
    end
    def escape
      self.blend_type = 0
      self.color.set(0, 0, 0, 0)
      self.opacity = 255
      @_escape_duration = 32
      @_whiten_duration = 0
      @_appear_duration = 0
      @_collapse_duration = 0
    end
    def collapse
      self.blend_type = 1
      self.color.set(255, 64, 64, 255)
      self.opacity = 255
      @_collapse_duration = 48
      @_whiten_duration = 0
      @_appear_duration = 0
      @_escape_duration = 0
    end
    def damage(value, critical)
      dispose_damage
      if value.is_a?(Numeric)
        damage_string = value.abs.to_s
      else
        damage_string = value.to_s
      end
      bitmap = Texture.new(160, 48)
      bitmap.font.name = 'Arial Black'
      bitmap.font.size = 32
      bitmap.font.color.set(0, 0, 0)
      bitmap.draw_text(-1, 12 - 1, 160, 36, damage_string, 1)
      bitmap.draw_text(+1, 12 - 1, 160, 36, damage_string, 1)
      bitmap.draw_text(-1, 12 + 1, 160, 36, damage_string, 1)
      bitmap.draw_text(+1, 12 + 1, 160, 36, damage_string, 1)
      if value.is_a?(Numeric) && value < 0
        bitmap.font.color.set(176, 255, 144)
      else
        bitmap.font.color.set(255, 255, 255)
      end
      bitmap.draw_text(0, 12, 160, 36, damage_string, 1)
      if critical
        bitmap.font.size = 20
        bitmap.font.color.set(0, 0, 0)
        bitmap.draw_text(-1, -1, 160, 20, 'CRITICAL', 1)
        bitmap.draw_text(+1, -1, 160, 20, 'CRITICAL', 1)
        bitmap.draw_text(-1, +1, 160, 20, 'CRITICAL', 1)
        bitmap.draw_text(+1, +1, 160, 20, 'CRITICAL', 1)
        bitmap.font.color.set(255, 255, 255)
        bitmap.draw_text(0, 0, 160, 20, 'CRITICAL', 1)
      end
      @_damage_sprite = ::Sprite.new(self.viewport)
      @_damage_sprite.bitmap = bitmap
      @_damage_sprite.ox = 80
      @_damage_sprite.oy = 20
      @_damage_sprite.x = self.x
      @_damage_sprite.y = self.y - self.oy / 2
      @_damage_sprite.z = 3000
      @_damage_duration = 40
    end
    def animation(animation, hit)
      dispose_animation
      @_animation = animation
      return if @_animation == nil
      @_animation_hit = hit
      @_animation_duration = @_animation.frame_max
      animation_name = @_animation.animation_name
      animation_hue = @_animation.animation_hue
      bitmap = RPG::Cache.animation(animation_name, animation_hue)
      if @@_reference_count.include?(bitmap)
        @@_reference_count[bitmap] += 1
      else
        @@_reference_count[bitmap] = 1
      end
      @_animation_sprites = []
      if @_animation.position != 3 || !@@_animations.include?(animation)
        for i in 0..15
          sprite = ::Sprite.new(self.viewport)
          sprite.bitmap = bitmap
          sprite.visible = false
          @_animation_sprites.push(sprite)
        end
        unless @@_animations.include?(animation)
          @@_animations.push(animation)
        end
      end
      update_animation
    end
    def loop_animation(animation)
      return if animation == @_loop_animation
      dispose_loop_animation
      @_loop_animation = animation
      return if @_loop_animation == nil
      @_loop_animation_index = 0
      animation_name = @_loop_animation.animation_name
      animation_hue = @_loop_animation.animation_hue
      bitmap = RPG::Cache.animation(animation_name, animation_hue)
      if @@_reference_count.include?(bitmap)
        @@_reference_count[bitmap] += 1
      else
        @@_reference_count[bitmap] = 1
      end
      @_loop_animation_sprites = []
      for i in 0..15
        sprite = ::Sprite.new(self.viewport)
        sprite.bitmap = bitmap
        sprite.visible = false
        @_loop_animation_sprites.push(sprite)
      end
      update_loop_animation
    end
    def dispose_damage
      if @_damage_sprite != nil
        @_damage_sprite.bitmap.dispose
        @_damage_sprite.dispose
        @_damage_sprite = nil
        @_damage_duration = 0
      end
    end
    def dispose_animation
      if @_animation_sprites != nil
        sprite = @_animation_sprites[0]
        if sprite != nil
          @@_reference_count[sprite.bitmap] -= 1
          if @@_reference_count[sprite.bitmap] == 0
            sprite.bitmap.dispose
          end
        end
        for sprite in @_animation_sprites
          sprite.dispose
        end
        @_animation_sprites = nil
        @_animation = nil
      end
    end
    def dispose_loop_animation
      if @_loop_animation_sprites != nil
        sprite = @_loop_animation_sprites[0]
        if sprite != nil
          @@_reference_count[sprite.bitmap] -= 1
          if @@_reference_count[sprite.bitmap] == 0
            sprite.bitmap.dispose
          end
        end
        for sprite in @_loop_animation_sprites
          sprite.dispose
        end
        @_loop_animation_sprites = nil
        @_loop_animation = nil
      end
    end
    def blink_on
      unless @_blink
        @_blink = true
        @_blink_count = 0
      end
    end
    def blink_off
      if @_blink
        @_blink = false
        self.color.set(0, 0, 0, 0)
      end
    end
    def blink?
      @_blink
    end
    def effect?
      @_whiten_duration > 0 || @_appear_duration > 0 || @_escape_duration > 0 || @_collapse_duration > 0 || @_damage_duration > 0 || @_animation_duration > 0
    end
    def update
      super
      if @_whiten_duration > 0
        @_whiten_duration -= 1
        self.color.alpha = 128 - (16 - @_whiten_duration) * 10
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
      if @_damage_duration > 0
        @_damage_duration -= 1
        case @_damage_duration
        when 38..39
          @_damage_sprite.y -= 4
        when 36..37
          @_damage_sprite.y -= 2
        when 34..35
          @_damage_sprite.y += 2
        when 28..33
          @_damage_sprite.y += 4
        end
        @_damage_sprite.opacity = 256 - (12 - @_damage_duration) * 32
        if @_damage_duration == 0
          dispose_damage
        end
      end
      if @_animation != nil && (Graphics.frame_count % 2 == 0)
        @_animation_duration -= 1
        update_animation
      end
      if @_loop_animation != nil && (Graphics.frame_count % 2 == 0)
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
        self.color.set(255, 255, 255, alpha)
      end
      @@_animations.clear
    end
    def update_animation
      if @_animation_duration > 0
        frame_index = @_animation.frame_max - @_animation_duration
        cell_data = @_animation.frames[frame_index].cell_data
        position = @_animation.position
        animation_set_sprites(@_animation_sprites, cell_data, position)
        for timing in @_animation.timings
          if timing.frame == frame_index
            animation_process_timing(timing, @_animation_hit)
          end
        end
      else
        dispose_animation
      end
    end
    def update_loop_animation
      frame_index = @_loop_animation_index
      cell_data = @_loop_animation.frames[frame_index].cell_data
      position = @_loop_animation.position
      animation_set_sprites(@_loop_animation_sprites, cell_data, position)
      for timing in @_loop_animation.timings
        if timing.frame == frame_index
          animation_process_timing(timing, true)
        end
      end
    end
    def animation_set_sprites(sprites, cell_data, position)
      for i in 0..15
        sprite = sprites[i]
        pattern = cell_data[i, 0]
        if sprite == nil || pattern == nil || pattern == -1
          sprite.visible = false if sprite != nil
          next
        end
        sprite.visible = true
        sprite.src_rect.set(pattern % 5 * 192, pattern / 5 * 192, 192, 192)
        if position == 3
          if self.viewport != nil
            sprite.x = self.viewport.rect.width / 2
            sprite.y = self.viewport.rect.height - 160
          else
            sprite.x = 320
            sprite.y = 240
          end
        else
          sprite.x = self.x - self.ox + self.src_rect.width / 2
          sprite.y = self.y - self.oy + self.src_rect.height / 2
          sprite.y -= self.src_rect.height / 4 if position == 0
          sprite.y += self.src_rect.height / 4 if position == 2
        end
        sprite.x += cell_data[i, 1]
        sprite.y += cell_data[i, 2]
        sprite.z = 2000
        sprite.ox = 96
        sprite.oy = 96
        sprite.zoom_x = cell_data[i, 3] / 100.0
        sprite.zoom_y = cell_data[i, 3] / 100.0
        sprite.angle = cell_data[i, 4]
        sprite.mirror = (cell_data[i, 5] == 1)
        sprite.opacity = cell_data[i, 6] * self.opacity / 255.0
        sprite.blend_type = cell_data[i, 7]
      end
    end
    def animation_process_timing(timing, hit)
      if (timing.condition == 0) || (timing.condition == 1 && hit == true) || (timing.condition == 2 && hit == false)
        if timing.se.name != ''
          se = timing.se
          Audio.se_play('Audio/SE/' + se.name, se.volume, se.pitch)
        end
        case timing.flash_scope
        when 1
          self.flash(timing.flash_color, timing.flash_duration * 2)
        when 2
          if self.viewport != nil
            self.viewport.flash(timing.flash_color, timing.flash_duration * 2)
          end
        when 3
          self.flash(nil, timing.flash_duration * 2)
        end
      end
    end
    def x=(x)
      sx = x - self.x
      if sx != 0
        if @_animation_sprites != nil
          for i in 0..15
            @_animation_sprites[i].x += sx
          end
        end
        if @_loop_animation_sprites != nil
          for i in 0..15
            @_loop_animation_sprites[i].x += sx
          end
        end
      end
      super
    end
    def y=(y)
      sy = y - self.y
      if sy != 0
        if @_animation_sprites != nil
          for i in 0..15
            @_animation_sprites[i].y += sy
          end
        end
        if @_loop_animation_sprites != nil
          for i in 0..15
            @_loop_animation_sprites[i].y += sy
          end
        end
      end
      super
    end
  end
  class System
    attr_accessor :magic_number
    attr_accessor :party_members
    attr_accessor :elements
    attr_accessor :switches
    attr_accessor :variables
    attr_accessor :windowskin_name
    attr_accessor :title_name
    attr_accessor :gameover_name
    attr_accessor :battle_transition
    attr_accessor :title_bgm
    attr_accessor :battle_bgm
    attr_accessor :battle_end_me
    attr_accessor :gameover_me
    attr_accessor :cursor_se
    attr_accessor :decision_se
    attr_accessor :cancel_se
    attr_accessor :buzzer_se
    attr_accessor :equip_se
    attr_accessor :shop_se
    attr_accessor :save_se
    attr_accessor :load_se
    attr_accessor :battle_start_se
    attr_accessor :escape_se
    attr_accessor :actor_collapse_se
    attr_accessor :enemy_collapse_se
    attr_accessor :words
    attr_accessor :test_battlers
    attr_accessor :test_troop_id
    attr_accessor :start_map_id
    attr_accessor :start_x
    attr_accessor :start_y
    attr_accessor :battleback_name
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :edit_map_id
    class TestBattler
      attr_accessor :actor_id
      attr_accessor :level
      attr_accessor :weapon_id
      attr_accessor :armor1_id
      attr_accessor :armor2_id
      attr_accessor :armor3_id
      attr_accessor :armor4_id
    end
    class Words
    end
  end
  class Tileset
    attr_accessor :id
    attr_accessor :name
    attr_accessor :tileset_name
    attr_accessor :autotile_names
    attr_accessor :panorama_name
    attr_accessor :panorama_hue
    attr_accessor :fog_name
    attr_accessor :fog_hue
    attr_accessor :fog_opacity
    attr_accessor :fog_blend_type
    attr_accessor :fog_zoom
    attr_accessor :fog_sx
    attr_accessor :fog_sy
    attr_accessor :battleback_name
    attr_accessor :passages
    attr_accessor :priorities
    attr_accessor :terrain_tags
  end
  class Troop
    attr_accessor :id
    attr_accessor :name
    attr_accessor :members
    attr_accessor :pages
    class Member
      attr_accessor :enemy_id
      attr_accessor :x
      attr_accessor :y
      attr_accessor :hidden
    end
    class Page
      attr_accessor :condition
      attr_accessor :span
      attr_accessor :list
      class Condition
        attr_accessor :turn_valid
        attr_accessor :enemy_valid
        attr_accessor :actor_valid
        attr_accessor :switch_valid
        attr_accessor :turn_a
        attr_accessor :turn_b
        attr_accessor :enemy_index
        attr_accessor :enemy_hp
        attr_accessor :actor_id
        attr_accessor :actor_hp
        attr_accessor :switch_id
      end
    end
  end
  class Actor
    attr_accessor :id
    attr_accessor :name
    attr_accessor :initial_level
    attr_accessor :final_level
    attr_accessor :exp_basis
    attr_accessor :exp_inflation
    attr_accessor :character_name
    attr_accessor :character_hue
    attr_accessor :battler_name
    attr_accessor :battler_hue
    attr_accessor :parameters
    attr_accessor :weapon_id
    attr_accessor :armor1_id
    attr_accessor :armor2_id
    attr_accessor :armor3_id
    attr_accessor :armor4_id
    attr_accessor :weapon_fix
    attr_accessor :armor1_fix
    attr_accessor :armor2_fix
    attr_accessor :armor3_fix
    attr_accessor :armor4_fix
  end
end
Graphics.on_start do
  RPG::Cache::LOADS.each do |k|
    RPG::Cache.send(k)
  end
end
# Module responsive of handling audio in game
module Audio
  # Base class for all audio drivers (mainly definition)
  class DriverBase
    @@logged_audio_filenames = []
    # List of the Audio extension that are supported
    AUDIO_FILENAME_EXTENSIONS = ['.ogg', '.mp3', '.wav', '.flac']
    # Update the driver (must be called every meaningful frames)
    def update
    end
    # Reset the driver
    def reset
    end
    # Release the driver
    def release
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    def play_music(channel, filename, volume, pitch, fade_with_previous)
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
      return 0
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
      return 0
    end
    private
    # Load an Audio file content
    # @param filename [String]
    # @return [String, nil]
    def try_load(filename)
      audio_filename = search_audio_filename(filename)
      return File.binread(audio_filename) if File.exist?(audio_filename)
      return nil if @@logged_audio_filenames.include?(filename)
      log_error("FATAL ERROR: No such file or directory #{filename}")
      @@logged_audio_filenames << filename
      return nil
    end
    # Find the audio filename
    # @param filename [String]
    # @return [String]
    def search_audio_filename(filename)
      return filename if File.exist?(filename)
      lower_filename = filename.downcase
      return lower_filename if File.exist?(lower_filename)
      return audio_filename_extensions.filter_map do |ext|
        audio_filename = lower_filename + ext
        next(audio_filename) if File.exist?(audio_filename)
      end.first || filename
    end
    # Get all the supported extensions
    # @return [Array<String>]
    def audio_filename_extensions
      AUDIO_FILENAME_EXTENSIONS
    end
  end
  @known_drivers = {default: DriverBase}
  @selected_driver = :default
  module_function
  # Globally initialize the audio module (after all driver has been chosen and the game was loaded)
  def __init__
    @driver = @known_drivers[@selected_driver].new()
  end
  # Globally release the audio module (after the game is done or if you need to swap drivers)
  def __release__
    @driver&.release
    @driver = nil
  end
  # Globally reset the audio (when soft resetting the game or for other reasons)
  def __reset__
    @driver&.reset
  end
  # Update the audio (must be called every meaningful frames)
  def update
    @driver&.update
  end
  # Get the current driver
  # @return [DriverBase]
  def driver
    return @driver
  end
  # Register an audio driver
  # @param driver_name [Symbol] name of the driver
  # @param driver_class [Class<DriverBase>] driver class (to instanciate when chosen)
  def register_driver(driver_name, driver_class)
    @selected_driver = driver_name if @selected_driver != :fmod
    @known_drivers[driver_name] = driver_class
  end
  public
  @music_volume = 100
  @sfx_volume = 100
  module_function
  # Get volume of bgm and me
  # @return [Integer] a value between 0 and 100
  def music_volume
    return @music_volume
  end
  # Set the volume of bgm and me
  # @param value [Integer] a value between 0 and 100
  def music_volume=(value)
    volume = value.to_i.clamp(0, 100)
    @music_volume = volume
    music_channels.each do |channel|
      @driver.set_channel_volume(channel, volume)
    end
  end
  # Get all the music channels (to patch if you want to include more)
  # @return [Array<Symbol>]
  def music_channels
    %i[bgm me]
  end
  # Get volume of sfx
  # @return [Integer] a value between 0 and 100
  def sfx_volume
    return @sfx_volume
  end
  # Set the volume of sfx
  # @param value [Integer] a value between 0 and 100
  def sfx_volume=(value)
    volume = value.to_i.clamp(0, 100)
    @sfx_volume = volume
    sfx_channels.each do |channel|
      @driver.set_channel_volume(channel, volume)
    end
  end
  # Get all the sfx channels (to patch if you want to include more)
  # @return [Array<Symbol>]
  def sfx_channels
    %i[bgs]
  end
  public
  # Constant allowing maker to define if music must fade in by default
  FADE_IN_BY_DEFAULT = true
  module_function
  # plays a BGM and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the BGM between 0 and 100
  # @param pitch [Integer] speed of the BGM in percent
  # @param fade_in [Boolean, Integer] if the BGM fades in when different (or time in ms)
  # @param position [Integer, nil] optional starting position
  def bgm_play(filename, volume = 100, pitch = 100, fade_in = FADE_IN_BY_DEFAULT, position: nil)
    @driver&.play_music(:bgm, filename, volume * @music_volume / 100, pitch, fade_in, position)
  end
  # Returns the BGM position
  # @return [Integer]
  def bgm_position
    @driver&.get_channel_audio_position(:bgm) || 0
  end
  # Set the BGM position
  # @param position [Integer]
  def bgm_position=(position)
    @driver&.set_channel_audio_position(:bgm, position)
  end
  # Fades the BGM
  # @param time [Integer] fade time in ms
  def bgm_fade(time)
    @driver&.fade_channel_out(:bgm, time)
  end
  # Stop the BGM
  def bgm_stop
    @driver&.stop_channel(:bgm)
  end
  # plays a BGS and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the BGS between 0 and 100
  # @param pitch [Integer] speed of the BGS in percent
  # @param fade_in [Boolean, Integer] if the BGS fades in when different (or time in ms)
  # @param position [Integer, nil] optional starting position
  def bgs_play(filename, volume = 100, pitch = 100, fade_in = FADE_IN_BY_DEFAULT, position: nil)
    @driver&.play_music(:bgs, filename, volume * @sfx_volume / 100, pitch, fade_in, position)
  end
  # Returns the BGS position
  # @return [Integer]
  def bgs_position
    @driver&.get_channel_audio_position(:bgs) || 0
  end
  # Set the BGS position
  # @param position [Integer]
  def bgs_position=(position)
    @driver&.set_channel_audio_position(:bgs, position)
  end
  # Fades the BGS
  # @param time [Integer] fade time in ms
  def bgs_fade(time)
    @driver&.fade_channel_out(:bgs, time)
  end
  # Stop the BGS
  def bgs_stop
    @driver&.stop_channel(:bgs)
  end
  # plays a ME and stop the current one
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the ME between 0 and 100
  # @param pitch [Integer] speed of the ME in percent
  # @param preserve_bgm [Boolean] if the bgm should not be paused
  def me_play(filename, volume = 100, pitch = 100, preserve_bgm = false)
    @driver&.play_sound(:me, filename, volume * @music_volume / 100, pitch)
    return if preserve_bgm
    duration = @driver&.get_channel_duration(:me)
    @driver&.mute_channel_for(:bgm, duration * 100 / pitch) if duration && duration != 0
  end
  # Returns the ME position
  # @return [Integer]
  def me_position
    @driver&.get_channel_audio_position(:me) || 0
  end
  # Set the ME position
  # @param position [Integer]
  def me_position=(position)
    @driver&.set_channel_audio_position(:me, position)
  end
  # Fades the ME
  # @param time [Integer] fade time in ms
  def me_fade(time)
    @driver&.fade_channel_out(:me, time)
    @driver&.unmute_channel(:bgm)
  end
  # Stop the ME
  def me_stop
    @driver&.stop_channel(:me)
    @driver&.unmute_channel(:bgm)
  end
  # plays a SE if possible
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the SE between 0 and 100
  # @param pitch [Integer] speed of the SE in percent
  def se_play(filename, volume = 100, pitch = 100)
    @driver&.play_sound(:se, filename, volume * @sfx_volume / 100, pitch)
  end
  # Stop SE
  def se_stop
    @driver&.stop_channel(:se)
    @driver&.stop_channel(:cries)
  end
  # plays a cry
  # @param filename [String] name of the audio file
  # @param volume [Integer] volume of the SE between 0 and 100
  # @param pitch [Integer] speed of the SE in percent
  def cry_play(filename, volume = 100, pitch = 100)
    @driver&.play_sound(:cries, filename, volume * @sfx_volume / 100, pitch)
  end
  public
  class SFMLAudioDriver < DriverBase
    # Create a new SFML Audio Driver
    def initialize
      @channels = {bgm: SFMLAudio::Music.new, bgs: SFMLAudio::Music.new, me: SFMLAudio::Sound.new}
      @fade_settings = {}
      @mute_settings = {}
      @me_buffer = SFMLAudio::SoundBuffer.new
      @se_sounds = {}
      @se_buffers = {}
      @cries_stack = []
    end
    # Reset the driver
    def reset
      @channels.each_key { |s| stop_channel(s) }
      @se_sounds.each_value(&:stop)
      @cries_stack.each(&:stop)
      @cries_stack.clear
      @se_sounds.clear
    end
    # Release the driver
    def release
      reset
    end
    # Update the driver
    def update
      @fade_settings.each { |k, v| update_fade(k, *v) }
      @mute_settings.each { |k, v| update_mute(k, v) }
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
      stop_channel(channel)
      return unless (memory = try_load(filename))
      c = channel == :se ? get_se_sound(filename) : (@channels[channel] ||= SFMLAudio::Sound.new)
      buffer = channel == :me ? @me_buffer : (@se_buffers[filename] ||= SFMLAudio::SoundBuffer.new)
      buffer.load_from_memory(memory)
      c.set_buffer(buffer)
      c.set_pitch(pitch / 100.0)
      c.set_volume(volume)
      c.play
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    # @param position [Integer, nil] optional starting position
    def play_music(channel, filename, volume, pitch, fade_with_previous, position = nil)
      stop_channel(channel)
      return unless (memory = try_load(filename))
      c = (@channels[channel] ||= SFMLAudio::Music.new)
      c.open_from_memory(memory)
      auto_loop(c, memory)
      c.set_loop(true)
      c.set_pitch(pitch / 100.0)
      c.set_volume(volume)
      set_channel_audio_position(c, position) if position
      c.play
      c.pause if @mute_settings[channel]
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
      c = @channels[channel]
      return if !c || c.stopped?
      @fade_settings[channel] = [Time.new, c.get_volume, duration / 1000.0]
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
      if channel == :se
        @se_sounds.each_value(&:stop)
        @cries_stack.each(&:stop)
        @cries_stack.clear
        @se_sounds.clear
        @se_buffers.clear
        return
      end
      @fade_settings.delete(channel)
      c = @channels[channel]
      return if !c || c.stopped?
      c.stop
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
      c = @channels[channel]
      return if !c || c.stopped?
      c.set_volume(volume)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
      c = @channels[channel]
      return 0 if !c || c.stopped?
      return (c.get_playing_offset * c.get_sample_rate).to_i
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
      c = @channels[channel]
      return if !c || c.stopped?
      c.set_playing_offset(position / c.get_sample_rate.to_f)
    rescue StandardError
      log_error("set_channel_audio_position= : #{$!.message}")
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
      c = @channels[channel]
      return if !c || c.stopped?
      @mute_settings[channel] = Graphics.current_time + duration
      c.pause
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
      c = @mute_settings.delete(channel)
      return if !c || c.stopped?
      c.play
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
      c = @channels[channel]
      return 0 if !c || c.stopped?
      return channel == :me ? @me_buffer.get_duration : c.get_duration
    end
    private
    # Automatically loop an audio
    # @param music [SFMLAudio::Music]
    # @param memory [String] audio file content
    def auto_loop(music, memory)
      data = memory[0, 2048]
      start_index = data.index('LOOPSTART=')
      length_index = data.index('LOOPLENGTH=')
      return unless start_index && length_index
      start = data[start_index + 10, 20].to_i
      lenght = data[length_index + 11, 20].to_i
      log_info("LOOP: #{start} -> #{start + lenght}") unless PSDK_CONFIG.release?
      frequency = music.get_sample_rate.to_f
      music.set_loop_points(start / frequency, lenght / frequency)
    end
    # Update a fading operation
    # @param channel [Symbol]
    # @param start_time [Time]
    # @param volume [Float]
    # @param duration [Float]
    # @return [Boolean] if the sound should be stopped
    def update_fade(channel, start_time, volume, duration)
      c = @channels[channel]
      current_duration = Graphics.current_time - start_time
      if c && !c.stopped? && current_duration < duration
        c.set_volume(volume * (1 - current_duration / duration))
      else
        @fade_settings.delete(channel)
        stop_channel(channel)
      end
    end
    # Update a mute operation
    # @param channel [Symbol]
    # @param end_mute [Time]
    def update_mute(channel, end_mute)
      c = @channels[channel]
      if end_mute >= Graphics.current_time
        @mute_settings.delete(channel)
        c.play if c&.stopped?
      end
    end
    # Get the SE sound
    # @param filename [String]
    # @return [SFMLAudio::Sound]
    def get_se_sound(filename)
      sound = SFMLAudio::Sound.new
      if filename.downcase.include?('/cries/')
        @cries_stack << sound
        @cries_stack.shift.stop if @cries_stack.size > 5
      else
        @se_sounds[filename] = sound
      end
      return sound
    end
  end
  register_driver(:sfml, SFMLAudioDriver) if Object.const_defined?(:SFMLAudio)
  public
  class FMODDriver < DriverBase
    # List of the Audio extension that are supported
    AUDIO_FILENAME_EXTENSIONS = ['.ogg', '.mp3', '.wav', '.mid', '.aac', '.wma', '.it', '.xm', '.mod', '.s3m', '.midi', '.flac']
    # List of Audio Priorities (if not found => 128)
    AUDIO_PRIORITIES = {bgm: 0, me: 1, bgs: 2, se: 250, cries: 249}
    # Time of the audio fade in
    FADE_IN_TIME = 250
    @@BUG_FMOD_INITIALIZED = false
    # Create a new FMOD driver
    def initialize
      @sounds = {}
      @names = {}
      @channels = {}
      @se_sounds = {}
      @cries_stack = []
      @fading_sounds = {}
      @mutexes = Hash.new { |h, k| h[k] = Mutex.new }
      FMOD::System.init(64, FMOD::INIT::NORMAL) unless @@BUG_FMOD_INITIALIZED
      @@BUG_FMOD_INITIALIZED = true
    end
    # Update the driver (must be called every meaningful frames)
    def update
      FMOD::System.update
    end
    # Reset the driver
    def reset
      @channels.each_key { |s| stop_channel(s) }
      @se_sounds.each_value(&:release)
      @se_sounds.clear
      @cries_stack.each(&:release)
      @cries_stack.clear
      @fading_sounds.each_key(&:release)
      @fading_sounds.clear
    end
    # Release the driver
    def release
      reset
    end
    # Play a sound (just once)
    # @param channel [Symbol] channel for the sound (:se, :me)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_sound(channel, filename, volume, pitch)
      synchronize(@mutexes[channel]) do
        channel == :me ? play_me_sound(filename, volume, pitch) : play_se_sound(filename, volume, pitch)
      end
    end
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    # @param position [Integer, nil] optional starting position
    def play_music(channel, filename, volume, pitch, fade_with_previous, position = nil)
      Thread.new do
        synchronize(@mutexes[channel]) do
          play_music_internal(channel, filename, volume, pitch, fade_with_previous, position)
        end
      end
    end
    # Fade a channel out
    # @param channel [Symbol] channel to fade
    # @param duration [Integer] duration of the fade out in ms
    def fade_channel_out(channel, duration)
      synchronize(@mutexes[channel]) do
                c = @channels[channel]
        sound = @sounds[channel]
        return if !c || !sound || @fading_sounds[sound]
        fade(duration, @fading_sounds[sound] = c)
        @channels.delete(channel)
      rescue FMOD::Error
        @fading_sounds.delete(sound)
        @channels.delete(channel)

      end
    end
    # Stop a channel
    # @param channel [Symbol] channel to stop
    def stop_channel(channel)
      if channel == :se
        @se_sounds.each_value(&:release)
        @se_sounds.clear
        @cries_stack.each(&:release)
        @cries_stack.clear
        return
      end
      synchronize(@mutexes[channel]) do
                @channels[channel]&.stop
      rescue FMOD::Error => e
        puts "Failed to properly stop #{channel} channel: #{e.message}" if debug?
      ensure
        @channels.delete(channel)

      end
    end
    # Set a channel volume
    # @param channel [Symbol] channel to set the volume
    # @param volume [Integer] volume of the channel (0~100)
    def set_channel_volume(channel, volume)
      synchronize(@mutexes[channel]) do
        c = @channels[channel]
        c&.setVolume(volume / 100.0)
      end
    rescue FMOD::Error => e
      puts "Failed to set #{channel} channel volume: #{e.message}" if debug?
      @channels.delete(channel)
    end
    # Get a channel audio position
    # @param channel [Symbol]
    # @return [Integer] channel audio position in driver's unit
    def get_channel_audio_position(channel)
      synchronize(@mutexes[channel]) do
        c = @channels[channel]
        return c.getPosition(FMOD::TIMEUNIT::PCM) if c
      end
      return 0
    rescue FMOD::Error => e
      puts "Failed to get #{channel} channel position: #{e.message}" if debug?
      @channels.delete(channel)
      return 0
    end
    # Set a channel audio position
    # @param channel [Symbol]
    # @param position [Integer] audio position in driver's unit
    def set_channel_audio_position(channel, position)
      synchronize(@mutexes[channel]) do
        c = @channels[channel]
        c&.setPosition(position, FMOD::TIMEUNIT::PCM)
      end
    rescue FMOD::Error => e
      puts "Failed to set #{channel} channel position: #{e.message}" if debug?
    end
    # Mute a channel for an amount of time
    # @param channel [Symbol]
    # @param duration [Integer] mute duration in driver's time
    def mute_channel_for(channel, duration)
      synchronize(@mutexes[channel]) do
        c = @channels[channel]
        c&.setDelay(c.getDSPClock.last + duration, 0, false)
      end
    rescue FMOD::Error => e
      puts "Failed to mute #{channel} channel: #{e.message}" if debug?
    end
    # Unmute a channel
    # @param channel [Symbol]
    def unmute_channel(channel)
      synchronize(@mutexes[channel]) do
        c = @channels[channel]
        c&.setDelay(0, 0, false)
      end
    rescue FMOD::Error => e
      puts "Failed to un-mute #{channel} channel: #{e.message}" if debug?
    end
    # Get a channel duration
    # @param channel [Symbol]
    # @return [Integer]
    def get_channel_duration(channel)
      sound = @sounds[channel]
      return 0 unless sound
      return sound.getLength(FMOD::TIMEUNIT::PCM)
    rescue FMOD::Error => e
      puts "Failed to get #{channel} channel duration: #{e.message}" if debug?
      return 0
    end
    private
    # Play a music (looped)
    # @param channel [Symbol] channel for the music (:bgm, :bgs)
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    # @param fade_with_previous [Boolean] if the previous music should be faded with this one
    # @param position [Integer] optional starting position
    def play_music_internal(channel, filename, volume, pitch, fade_with_previous, position)
      was_playing = was_sound_previously_playing?(filename, @names[channel], sound = @sounds[channel], @channels[channel], fade_with_previous)
      @names[channel] = filename
      fade_in = (fade_with_previous && sound && !was_playing)
      release_fading_sounds((was_playing || fade_in) ? nil : sound)
      unless was_playing
        @sounds[channel] = @channels[channel] = nil
        return unless (sound = @sounds[channel] = create_sound_sound(filename))
        auto_loop(@sounds[channel])
      end
      @channels[channel] = FMOD::System.playSound(sound, true) unless was_playing && @channels[channel]
      c = @channels[channel]
      if position && c
        current_position = get_channel_audio_position(channel)
        set_channel_audio_position(channel, position) if position != current_position
      end
      adjust_channel(c, channel, volume, pitch)
      fade(fade_in == true ? FADE_IN_TIME : fade_in, c, 0, 1.0) if fade_in
      @fading_sounds.delete(sound)
    rescue FMOD::Error
      log_error("Le fichier #{filename} n'a pas pu être lu...\nErreur : #{$!.message}")
      stop_channel(channel)
    ensure
      call_was_playing_callback
    end
    # Play a ME
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_me_sound(filename, volume, pitch)
      was_playing = was_sound_previously_playing?(filename, @names[:me], sound = @sounds[:me], @channels[:me])
      @names[:me] = filename
      release_fading_sounds(was_playing ? nil : sound)
      unless was_playing
        @sounds[:me] = @channels[:me] = nil
        return unless (sound = @sounds[:me] = create_sound_sound(filename, FMOD::MODE::LOOP_OFF | FMOD::MODE::FMOD_2D))
      end
      c = @channels[:me] = FMOD::System.playSound(sound, true)
      adjust_channel(c, :me, volume, pitch)
      @fading_sounds.delete(sound)
    rescue FMOD::Error
      log_error("Le fichier #{filename} n'a pas pu être lu...\nErreur : #{$!.message}")
      stop_channel(:me)
    ensure
      call_was_playing_callback
    end
    # Play a SE
    # @param filename [String] name of the sound
    # @param volume [Integer] volume of the sound (0~100)
    # @param pitch [Integer] pitch of the sound (50~150)
    def play_se_sound(filename, volume, pitch)
      unless (sound = @se_sounds[filename])
        return unless (sound = create_sound_sound(filename, FMOD::MODE::LOOP_OFF | FMOD::MODE::FMOD_2D))
        if filename.downcase.include?('/cries/')
          @cries_stack << sound
          @cries_stack.shift.release if @cries_stack.size > 5
        else
          @se_sounds[filename] = sound
        end
      end
      c = FMOD::System.playSound(sound, true)
      adjust_channel(c, filename.include?('/cries/') ? :cries : :se, volume, pitch)
    rescue FMOD::Error => e
      if e.message.sub('FmodError ', '').to_i == 46
        @se_sounds.delete(filename)
        retry
      else
        log_error("Failed to play se #{filename}")
      end
    end
    # Get all the supported extensions
    # @return [Array<String>]
    def audio_filename_extensions
      AUDIO_FILENAME_EXTENSIONS
    end
    # Auto loop a music
    # @param sound [FMOD::Sound] the sound that contain the data
    # @note Only works with createSound and should be called before the channel creation
    def auto_loop(sound)
      start = sound.getTag('LOOPSTART', 0)[2].to_i rescue nil
      length = sound.getTag('LOOPLENGTH', 0)[2].to_i rescue nil
      unless start && length
        index = 0
        while (tag = sound.getTag('TXXX', index) rescue nil)
          index += 1
          next unless tag[2].is_a?(String)
          name, data = tag[2].split("\x00")
          if name == 'LOOPSTART' && !start
            start = data.to_i
          else
            if name == 'LOOPLENGTH' && !length
              length = data.to_i
            end
          end
        end
      end
      return unless start && length
      log_info "LOOP: #{start} -> #{start + length}" unless PSDK_CONFIG.release?
      sound.setLoopPoints(start, FMOD::TIMEUNIT::PCM, start + length, FMOD::TIMEUNIT::PCM)
    end
    # Fade a channel
    # @param time [Integer] number of miliseconds to perform the fade
    # @param channel [FMOD::Channel] the channel to fade
    # @param start_value [Numeric]
    # @param end_value [Numeric]
    def fade(time, channel, start_value = 1.0, end_value = 0)
      sr = FMOD::System.getSoftwareFormat.first
      pdsp = channel.getDSPClock.last
      stop_time = pdsp + Integer(time * sr / 1000)
      channel.addFadePoint(pdsp, start_value)
      channel.addFadePoint(stop_time, end_value)
      channel.setDelay(0, stop_time + 20, false) if end_value == 0
      channel.setVolumeRamp(true)
      channel.instance_variable_set(:@stop_time, stop_time)
    end
    # Try to release all fading sounds that are done fading
    # @param additionnal_sound [FMOD::Sound, nil] a sound that should be released with the others
    # @note : Warning ! Doing sound.release before channel.anything make the channel invalid and raise an FMOD::Error
    def release_fading_sounds(additionnal_sound)
      unless @fading_sounds.empty?
        sound_guardian = Audio.music_channels.map { |c| @sounds[c] }.concat(Audio.sfx_channels.map { |c| @sounds[c] })
        sounds_to_delete = []
        @fading_sounds.each do |sound, channel|
                    additionnal_sound = nil if additionnal_sound == sound
          next unless channel_stop_time_exceeded(channel)
          sounds_to_delete << sound
          channel.stop
          next if sound_guardian.include?(sound)
          sound.release
        rescue FMOD::Error
          next

        end
        sounds_to_delete.each { |sound| @fading_sounds.delete(sound) }
      end
      additionnal_sound&.release
    end
    # Return if the channel time is higher than the stop time
    # @note will return true if the channel handle is invalid
    # @param channel [FMOD::Channel]
    # @return [Boolean]
    def channel_stop_time_exceeded(channel)
      return channel.getDSPClock.last >= channel.instance_variable_get(:@stop_time).to_i
    rescue FMOD::Error
      return true
    end
    # Synchronize a mutex
    # @param mutex [Mutex] the mutex to safely synchronize
    # @param block [Proc] the block to call
    def synchronize(mutex, &block)
      return yield if mutex.locked? && mutex.owned?
      mutex.synchronize(&block)
    end
    # Create a bgm sound used to play the BGM
    # @param filename [String] the correct filename of the sound
    # @param flags [Integer, nil] the FMOD flags for the creation
    # @return [FMOD::Sound] the sound
    def create_sound_sound(filename, flags = nil)
      file_data = try_load(filename)
      return nil unless file_data
      audio_filename = search_audio_filename(filename)
      gm_filename = audio_filename.include?('.mid') && File.exist?('gm.dls') ? 'gm.dls' : nil
      sound_info = FMOD::SoundExInfo.new(file_data.bytesize, nil, nil, nil, nil, nil, gm_filename)
      sound = FMOD::System.createSound(file_data, create_sound_get_flags(flags), sound_info)
      sound.instance_variable_set(:@extinfo, sound_info)
      return sound
    end
    # Return the expected flag for create_sound_sound
    # @param flags [Integer, nil] the FMOD flags for the creation
    # @return [Integer]
    def create_sound_get_flags(flags)
      return (flags | FMOD::MODE::OPENMEMORY | FMOD::MODE::CREATESTREAM) if flags
      return (FMOD::MODE::LOOP_NORMAL | FMOD::MODE::FMOD_2D | FMOD::MODE::OPENMEMORY | FMOD::MODE::CREATESTREAM)
    end
    # Function that detects if the previous playing sound is the same as the next one
    # @param filename [String] the filename of the sound
    # @param old_filename [String] the filename of the old sound
    # @param sound [FMOD::Sound] the previous playing sound
    # @param channel [FMOD::Channel, nil] the previous playing channel
    # @param fade_out [Boolean, Integer] if the channel should fades out (Integer = time to fade)
    # @note If the sound wasn't the same, the channel will be stopped if not nil
    # @return [Boolean]
    def was_sound_previously_playing?(filename, old_filename, sound, channel, fade_out = false)
      return false unless sound
      return true unless filename.downcase != old_filename.downcase
      return false unless channel && (channel.isPlaying rescue false)
      if fade_out && !@fading_sounds[sound]
        fade_time = fade_out == true ? FADE_IN_TIME : fade_out
        @was_playing_callback = proc {fade(fade_time, @fading_sounds[sound] = channel) }
      else
        @was_playing_callback = proc {channel.stop }
      end
      return false
    end
    # Adjust channel volume and pitch
    # @param channel [Fmod::Channel]
    # @param channel_type [Symbol]
    # @param volume [Numeric] target volume
    # @param pitch [Numeric] target pitch
    def adjust_channel(channel, channel_type, volume, pitch)
      channel.setPriority(AUDIO_PRIORITIES[channel_type] || 128)
      channel.setVolume(volume / 100.0)
      channel.setPitch(pitch / 100.0)
      channel.setPaused(false)
    end
    # Automatically call the "was playing callback"
    def call_was_playing_callback
      @was_playing_callback&.call
      @was_playing_callback = nil
    rescue StandardError
      @was_playing_callback = nil
    end
  end
  register_driver(:fmod, FMODDriver) if Object.const_defined?(:FMOD)
end
