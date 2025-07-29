# Class describing game switches (events)
class Game_Switches < Array
  # Default initialization of game switches
  def initialize
  end
  # Converting game switches to bits
  def _dump(_level = 0)
  end
  # Loading game switches from the save file
  def self._load(args)
  end
end
# Class that describe game variables
class Game_Variables < Array
  # default initialization of game variables
  def initialize
  end
  # Getter
  # @param index [Integer] the index of the variable
  # @note return 0 if the variable is outside of the array.
  def [](index)
  end
  # Setter
  # @param index [Integer] the index of the variable in the Array
  # @param value [Integer] the new value of the variable
  def []=(index, value)
  end
end
# Describe switches that are related to a specific event
# @author Enterbrain
class Game_SelfSwitches
  # Default initialization
  def initialize
  end
  # Get the state of a self switch
  # @param key [Array] the key that identify the self switch
  # @return [Boolean]
  def [](key)
  end
  # Set the state of a self switch
  # @param key [Array] the key that identify the self switch
  # @param value [Boolean] the new value of the self switch
  def []=(key, value)
  end
end
# Collection of Game_Actor
class Game_Actors
  # Default initialization
  def initialize
  end
  # Fetch Game_Actor
  # @param actor_id [Integer] id of the Game_Actor in the database
  # @return [Game_Actor, nil]
  def [](actor_id)
  end
end
# @deprecated No longer used...
class Game_BattleAction
end
# @deprecated No longer used in its original use.
class Game_Battler
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader :battler_name
  # バトラー ファイル名
  attr_reader :battler_hue
  # バトラー 色相
  attr_reader :hp
  # HP
  attr_reader :sp
  # SP
  attr_reader :states
  # ステート
  attr_accessor :hidden
  # 隠れフラグ
  attr_accessor :damage
  # ダメージ値
  attr_accessor :critical
  # クリティカルフラグ
  attr_accessor :animation_id
  # アニメーション ID
  attr_accessor :animation_hit
  # アニメーション ヒットフラグ
  attr_accessor :white_flash
  # 白フラッシュフラグ
  attr_accessor :blink
  # 明滅フラグ
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
  end
  # Strength of the battler
  def str
  end
  # Dexterity of the battler
  def dex
  end
  # Agility of the battler
  def agi
  end
  # Intelligence of the battler
  def int
  end
  # Hit amount
  def hit
  end
  # Attack of the battler
  def atk
  end
  # Physical defense of the battler
  def pdef
  end
  # Magical defense of the battler
  def mdef
  end
  # Evasion of the battler
  def eva
  end
  # Set th HP of the battler
  def hp=(hp)
  end
  # Set the SP of the battler
  def sp=(sp)
  end
  # Is the battler dead?
  def dead?
  end
  # Does the battler exists?
  def exist?
  end
end
# @deprecated Not used by the core.
class Game_Enemy < Game_Battler
  # Create a new Game_Enemy instance
  # @param troop_id [Integer] ID of the troop
  # @param member_index [Integer] index of the member in the troop
  def initialize(troop_id, member_index)
  end
  # ID of the enemy
  def id
  end
  # Index of the enemy
  def index
  end
  # Name of the enemy
  def name
  end
  # Actions of the enemy
  def actions
  end
  # Experience points of the enemy
  def exp
  end
  # Money of the enemy
  def gold
  end
  # Item of the enemy
  def item_id
  end
  # Screen X position of the enemy
  def screen_x
  end
  # Screen Y position of the enemy
  def screen_y
  end
  # Screen Z position of the enemy
  def screen_z
  end
end
# Class that describe a troop of enemies
class Game_Troop
  # Default initializer.
  def initialize
  end
  # Returns the list of enemies
  # @return [Array<Game_Enemy>]
  def enemies
  end
  # Setup the troop with a troop from the database
  # @param troop_id [Integer] the id of the troop in the database
  def setup(troop_id)
  end
end
# Describe a player
class Game_Actor < Game_Battler
  # Sets the name of the Game_Actor
  # @return [String] the name
  attr_accessor :name
  # Sets the battle graphic
  # @return [String] the filename found in graphics/battlers
  attr_accessor :battler_name
  attr_reader :character_name
  attr_reader :character_hue
  attr_reader :level
  attr_reader :exp
  attr_reader :skills
  # Initialize a new Game_Actor
  # @param actor_id [Integer] the id of the actor in the database
  def initialize(actor_id)
  end
  # setup the Game_Actor object
  # @param actor_id [Integer] the id of the actor in the database
  def setup(actor_id)
  end
  # id of the Game_Actor in the database
  # @return [Integer]
  def id
  end
  # index of the Game_Actor in the $game_party.
  # @return [Integer, nil]
  def index
  end
  # @deprecated will be removed.
  def exp=(exp)
  end
  # @deprecated will be removed.
  def level=(level)
  end
  # Update the graphics of the Game_Actor
  # @param character_name [String] name of the character in Graphics/Characters
  # @param character_hue [0] ignored by the cache
  # @param battler_name [String] name of the battler in Graphics/Battlers
  # @param battler_hue [0] ignored by the cache
  def set_graphic(character_name, character_hue, battler_name, battler_hue)
  end
  # @deprecated will be removed.
  def screen_x
  end
  # @deprecated will be removed.
  def screen_y
  end
  # @deprecated will be removed.
  def screen_z
  end
end
# Describe a common event during the game processing
class Game_CommonEvent
  # @return [Integer] ID of the wild battle start common event
  WILD_BATTLE = 1
  # @return [Integer] ID of the appearence common event
  APPEARANCE = 2
  # @return [Integer] ID of the follower speech common event
  FOLLOWER_SPEECH = 5
  # @return [Integer] ID of the falling from hole common event
  HOLE_FALLING = 8
  # @return [Integer] ID of the enter surf common event
  SURF_ENTER = 9
  # @return [Integer] ID of the leaving surf common event
  SURF_LEAVE = 10
  # @return [Integer] ID of the headbutt common event
  HEADBUTT = 20
  # @return [Integer] ID of the waterfall common event
  WATERFALL = 26
  # @return [Integer] ID of the whirlpool common event
  WHIRLPOOL = 28
  # @return [Integer] ID of the dive common event
  DIVE = 29
  # Initialize the Game_CommonEvent
  # @param common_event_id [Integer] id of the common event in the database
  def initialize(common_event_id)
  end
  # Name of the common event
  def name
  end
  # trigger condition of the common event
  def trigger
  end
  # id of the switch that triggers the common event
  def switch_id
  end
  # List of commands of the common event
  def list
  end
  # Refresh the common event. If it triggers automatically, an internal Interpreter is generated
  def refresh
  end
  # Update the common event, if there's an internal Interpreter, it's being updated
  def update
  end
end
# The RPG Maker description of a Party
class Game_Party
  attr_reader :actors
  attr_accessor :gold
  attr_accessor :steps
  # Default initialization
  def initialize
  end
  # Set up the party with default members
  def setup_starting_members
  end
  # Refresh the game party with right actors according to the RMXP data
  def refresh
  end
  # Returns the max level in the team
  # @return [Integer] 0 if no actors
  def max_level
  end
  # Add an actor to the party
  # @param actor_id [Integer] the id of the actor in the database
  def add_actor(actor_id)
  end
  # Remove an actor of the party
  # @param actor_id [Integer] the id of the actor in the database
  def remove_actor(actor_id)
  end
  # gives gold to the party
  # @param n [Integer] amount of gold
  def gain_gold(n)
  end
  # takes gold from the party
  # @param n [Integer] amount of gold
  def lose_gold(n)
  end
  # Increase steps of the party
  def increase_steps
  end
end
# Class that manage Music playing, save and menu access, timer and interpreter
class Game_System
  attr_reader :map_interpreter
  # マップイベント用インタプリタ
  attr_reader :battle_interpreter
  # バトルイベント用インタプリタ
  attr_accessor :timer
  # タイマー
  attr_accessor :timer_working
  # タイマー作動中フラグ
  attr_accessor :save_disabled
  # セーブ禁止
  attr_accessor :menu_disabled
  # メニュー禁止
  attr_accessor :encounter_disabled
  # エンカウント禁止
  attr_accessor :message_position
  # 文章オプション 表示位置
  attr_accessor :message_frame
  # 文章オプション ウィンドウ枠
  attr_accessor :save_count
  # セーブ回数
  attr_accessor :magic_number
  # マジックナンバー
  # Default initializer
  def initialize
  end
  # play the cry of a Pokémon
  # @param id [Integer] the id of the Pokémon in the database
  # @param form [Integer] the id of the form of the Pokemon
  def cry_play(id, form: 0)
  end
  # Plays a BGM
  # @param bgm [RPG::AudioFile] a descriptor of the BGM
  # @param position [Integer] optional starting position
  def bgm_play(bgm, position: nil)
  end
  # Stop the BGM
  def bgm_stop
  end
  # Fade the BGM out
  # @param time [Integer] the time in seconds it takes to the BGM to fade
  def bgm_fade(time)
  end
  # Memorize the BGM
  def bgm_memorize
  end
  # Plays the Memorized BGM
  def bgm_restore
  end
  # Memorize an other BGM with position
  # @author Nuri Yuri
  def bgm_memorize2
  end
  # Plays the other Memorized BGM at the right position (FmodEx Eclusive)
  # @author Nuri Yuri
  def bgm_restore2
  end
  # Plays a BGS
  # @param bgs [RPG::AudioFile] a descriptor of the BGS
  def bgs_play(bgs)
  end
  # Fade the BGS out
  # @param time [Integer] the time in seconds it takes to the BGS to fade
  def bgs_fade(time)
  end
  # Memorize the BGS
  def bgs_memorize
  end
  # Play the memorized BGS
  def bgs_restore
  end
  # Plays a ME
  # @param me [RPG::AudioFile] a descriptor of the ME
  def me_play(me)
  end
  # Plays a SE
  # @param se [RPG::AudioFile] a descriptor of the SE
  def se_play(se)
  end
  # Stops every SE
  def se_stop
  end
  # Returns the playing BGM descriptor
  # @return [RPG::AudioFile]
  def playing_bgm
  end
  # Returns the playing BGS descriptor
  # @return [RPG::AudioFile]
  def playing_bgs
  end
  # Returns the name of the window skin
  # @return [String] The name of the window skin
  def windowskin_name
  end
  # Sets the name of the window skin
  # @param windowskin_name [String] The name of the window skin
  def windowskin_name=(windowskin_name)
  end
  # Returns the battle BGM descriptor
  # @return [RPG::AudioFile]
  def battle_bgm
  end
  # Sets the battle BGM descriptor
  # @param battle_bgm [RPG::AudioFile] descriptor
  def battle_bgm=(battle_bgm)
  end
  # Returns the battle end ME descriptor
  # @return [RPG::AudioFile]
  def battle_end_me
  end
  # Sets the battle end ME descriptor
  # @param battle_end_me [RPG::AudioFile] descriptor
  def battle_end_me=(battle_end_me)
  end
  # Updates the Game System (timer)
  def update
  end
end
# Class that stores a lot of Game State
class Game_Temp
  attr_accessor :map_bgm
  # マップ画面 BGM (バトル時記憶用)
  attr_accessor :message_text
  # メッセージ 文章
  attr_accessor :message_proc
  # メッセージ コールバック (Proc)
  attr_accessor :choices
  # Tableau contenant les choix
  attr_accessor :choice_start
  # 選択肢 開始行
  attr_accessor :choice_max
  # 選択肢 項目数
  attr_accessor :choice_cancel_type
  # 選択肢 キャンセルの場合
  attr_accessor :choice_proc
  # 選択肢 コールバック (Proc)
  attr_accessor :num_input_start
  # 数値入力 開始行
  attr_accessor :num_input_variable_id
  # 数値入力 変数 ID
  attr_accessor :num_input_digits_max
  # 数値入力 桁数
  attr_accessor :message_window_showing
  # メッセージウィンドウ表示中
  attr_accessor :common_event_id
  # コモンイベント ID
  attr_accessor :in_battle
  # 戦闘中フラグ
  attr_accessor :battle_calling
  # バトル 呼び出しフラグ
  attr_accessor :battle_troop_id
  # バトル トループ ID
  attr_accessor :battle_can_escape
  # バトル 逃走可能フラグ
  attr_accessor :battle_can_lose
  # バトル 敗北可能フラグ
  attr_accessor :battle_proc
  # バトル コールバック (Proc)
  # Current turn of the battle
  # - each time AI is about to get triggered, this counter increase by 1 (after player choice)
  # - starts at 0 before 1st AI trigger (meaning that launching all Pokemon phase is 0)
  # @return [Integer]
  attr_accessor :battle_turn
  attr_accessor :battle_event_flags
  # バトル イベント実行済みフラグ
  attr_accessor :battle_abort
  # バトル 中断フラグ
  attr_accessor :battle_main_phase
  # バトル メインフェーズフラグ
  attr_accessor :battleback_name
  # バトルバック ファイル名
  attr_accessor :forcing_battler
  # アクション強制対象のバトラー
  attr_accessor :shop_calling
  # ショップ 呼び出しフラグ
  attr_accessor :shop_goods
  # ショップ 商品リスト
  attr_accessor :name_calling
  # 名前入力 呼び出しフラグ
  attr_accessor :name_actor_id
  # 名前入力 アクター ID
  attr_accessor :name_max_char
  # 名前入力 最大文字数
  attr_accessor :menu_calling
  # メニュー 呼び出しフラグ
  attr_accessor :menu_beep
  # メニュー SE 演奏フラグ
  attr_accessor :save_calling
  # セーブ 呼び出しフラグ
  attr_accessor :debug_calling
  # デバッグ 呼び出しフラグ
  attr_accessor :player_transferring
  # プレイヤー場所移動フラグ
  attr_accessor :player_new_map_id
  # プレイヤー移動先 マップ ID
  attr_accessor :player_new_x
  # プレイヤー移動先 X 座標
  attr_accessor :player_new_y
  # プレイヤー移動先 Y 座標
  attr_accessor :player_new_direction
  # プレイヤー移動先 向き
  attr_accessor :transition_processing
  # トランジション処理中フラグ
  attr_accessor :transition_name
  # トランジション ファイル名
  attr_accessor :gameover
  # ゲームオーバーフラグ
  attr_accessor :to_title
  # タイトル画面に戻すフラグ
  attr_accessor :last_file_index
  # 最後にセーブしたファイルの番号
  attr_accessor :debug_top_row
  # デバッグ画面 状態保存用
  attr_accessor :debug_index
  # デバッグ画面 状態保存用
  attr_accessor :last_menu_index
  #Dernière position dans le menu
  attr_accessor :god_mode
  attr_accessor :vs_type
  attr_accessor :vs_actors
  attr_accessor :vs_enemies
  attr_accessor :enemy_battler
  attr_accessor :trainer_battle
  attr_accessor :temp_team
  # Tableau contenant une équipe temporaire
  # Name of the tileset to load instead of the normal one
  # @return [String]
  attr_accessor :tileset_name
  # Variable used to store the tileset name
  attr_accessor :tileset_temp
  # ID of the currently processed map by the maplinker (to fetch the tileset)
  # @return [String]
  attr_accessor :maplinker_map_id
  # Store the id of last repel used
  attr_accessor :last_repel_used_id
  # Initialize with default game state
  def initialize
  end
end
# Interpreter of the event commands
class Interpreter_RMXP
  # Id of the event that started the Interpreter
  # @return [Integer]
  attr_reader :event_id
  # Initialize the Interpreter
  # @param depth [Integer] depth of the Interpreter
  # @param main [Boolean] if the interpreter is the main interpreter
  def initialize(depth = 0, main = false)
  end
  # Clear the state of the interpreter
  def clear
  end
  # Launch a common event in a child interpreter
  # @param id [Integer] id of the common event
  def launch_common_event(id)
  end
  # Setup the interpreter with a list of Commands
  # @param list [Array<RPG::Command>] list of commands
  # @param event_id [Integer] id of the event that launch the interpreter
  # @param block [Proc] the ruby commands to execute using a fiber (list is ignored if this variable is set)
  def setup(list, event_id, block = nil)
  end
  # Tells if the interpreter is running or not
  # @return [Boolean]
  def running?
  end
  # Setup the interpreter with an event (Game_Event / Game_CommonEvent) that can run
  def setup_starting_event
  end
  # Update the interpreter
  def update
  end
  # Constant that holds the LiteRGSS input key to RGSS input Key
  LiteRGSS2RGSS_Input = {A: 13, B: 12, X: 14, Y: 15, L: 17, R: 18, UP: 8, DOWN: 2, LEFT: 4, RIGHT: 6, L2: 16, R2: 25, L3: 23, R3: 29, START: 22, SELECT: 21}
  # Constant that holds the RGSS input key to LiteRGSS input key
  RGSS2LiteRGSS_Input = LiteRGSS2RGSS_Input.invert
  RGSS2LiteRGSS_Input[11] = :A
  RGSS2LiteRGSS_Input.default = :HOME
  # Check if a button is triggered and store its id in a variable
  def input_button
  end
  # Setup choices in order to start a choice process
  def setup_choices(parameters)
  end
  # Execute a block on a specific actor (parameter > 0) or every actors in the Party
  # @param parameter [Integer] whole party or id of an actor in the database
  def iterate_actor(parameter)
  end
  # Execute a block on a specific enemy (parameter >= 0) or every enemies in the troop
  # @param parameter [Integer] whole troop or index of an enemy in the troop
  def iterate_enemy(parameter)
  end
  # Execute a block on a every enemies (parameter1 == 0) or every actors (parameter2 == -1) or a specific actor in the party
  # @param parameter1 [Integer] if 0, execute a block on every enemies
  # @param parameter2 [Integer] whole party or index of an actor in the party
  def iterate_battler(parameter1, parameter2)
  end
  private
  # Test a scene is being called
  # @return [Boolean]
  def calling_scene?
  end
  # Test if the Interpreter is currently waiting for an event
  # @return [Boolean]
  # @note This function automatically update the states it use if it returns false
  def waiting_event?
  end
  # Prevent the event from freezing the game if they process more than 100 commands
  def update_loop_count
  end
  # Create the Interpreter Fiber
  # @param block [Proc] the ruby commands to execute using a fiber
  def create_fiber(block)
  end
  public
  # Execute a command of the current event
  def execute_command
  end
  # Command that end the interpretation of the current event
  def command_end
  end
  # Command that skip the next commands until it find a command with the same indent
  def command_skip
  end
  # Command that retrieve a Game_Character object
  # @param parameter [Integer, Symbol] > 0 : id of the event, 0 : current event, -1 : player or follower, Symbol : alias
  # @return [Game_Event, Game_Player, Game_Character]
  def get_character(parameter)
  end
  # Command that retrieve a value and negate it if wanted
  # @param operation [Integer] if 1 negate the value
  # @param operand_type [Integer] if 0 takes operand, otherwise take the game variable n°operand
  # @param operand [Integer] the value or index
  def operate_value(operation, operand_type, operand)
  end
  # Hash containing the command translation from code to method name
  COMMAND_TRANSLATION = {101 => :command_101, 102 => :command_102, 402 => :command_402, 403 => :command_403, 103 => :command_103, 104 => :command_104, 105 => :command_105, 106 => :command_106, 111 => :command_111, 411 => :command_411, 112 => :command_112, 413 => :command_413, 113 => :command_113, 115 => :command_115, 116 => :command_116, 117 => :command_117, 118 => :command_118, 119 => :command_119, 121 => :command_121, 122 => :command_122, 123 => :command_123, 124 => :command_124, 125 => :command_125, 126 => :command_126, 127 => :command_127, 128 => :command_128, 129 => :command_129, 131 => :command_131, 132 => :command_132, 133 => :command_133, 134 => :command_134, 135 => :command_135, 136 => :command_136, 201 => :command_201, 202 => :command_202, 203 => :command_203, 204 => :command_204, 205 => :command_205, 206 => :command_206, 207 => :command_207, 208 => :command_208, 209 => :command_209, 210 => :command_210, 221 => :command_221, 222 => :command_222, 223 => :command_223, 224 => :command_224, 225 => :command_225, 231 => :command_231, 232 => :command_232, 233 => :command_233, 234 => :command_234, 235 => :command_235, 236 => :command_236, 241 => :command_241, 242 => :command_242, 245 => :command_245, 246 => :command_246, 247 => :command_247, 248 => :command_248, 249 => :command_249, 250 => :command_250, 251 => :command_251, 301 => :command_301, 601 => :command_601, 602 => :command_602, 603 => :command_603, 302 => :command_302, 303 => :command_303, 311 => :command_311, 312 => :command_312, 313 => :command_313, 314 => :command_314, 315 => :command_315, 316 => :command_316, 317 => :command_317, 318 => :command_318, 319 => :command_319, 320 => :command_320, 321 => :command_321, 322 => :command_322, 331 => :command_331, 332 => :command_332, 333 => :command_333, 334 => :command_334, 335 => :command_335, 336 => :command_336, 337 => :command_337, 338 => :command_338, 339 => :command_339, 340 => :command_340, 351 => :command_351, 352 => :command_352, 353 => :command_353, 354 => :command_354, 355 => :command_355}
  public
  # Command that starts a message display, if followed by a choice/input num command,
  # displays the choice/input num in the meantime
  def command_101
  end
  # Command that display a choice if possible (no message)
  def command_102
  end
  # Command that execute the choice branch depending on the choice result
  def command_402
  end
  # Command that execute the cancel branch if the result was 4 (max option in RMXP)
  def command_403
  end
  # Display an input number if possible (no message)
  def command_103
  end
  # Change the message settings (position / frame type)
  def command_104
  end
  # Start a store button id to variable process
  def command_105
  end
  # Wait 2 times the number of frame requested
  def command_106
  end
  # Conditionnal command
  def command_111
  end
  include EvalKiller if defined?(EvalKiller)
  # Function that execute a script for the conditions
  # @param script [String]
  def eval_condition_script(script)
  end
  # Command testing the false section of condition
  def command_411
  end
  # Loop command
  def command_112
  end
  # Repeat loop command (try to go back to the loop command of the same indent)
  def command_413
  end
  # Break loop command (try to go to the end of the loop)
  def command_113
  end
  # End the interpretation of the current event
  def command_115
  end
  # erase this event
  def command_116
  end
  # Call a common event
  def command_117
  end
  # Label command
  def command_118
  end
  # jump to a label
  def command_119
  end
  public
  # Multiple switch set
  def command_121
  end
  # Variable set
  def command_122
  end
  # Self Switch set
  def command_123
  end
  # Timer start / stop
  def command_124
  end
  # Earn gold command
  def command_125
  end
  # Get item command
  def command_126
  end
  # Gain weapon command
  def command_127
  end
  # Gain armor command
  def command_128
  end
  # Add or remove actor command
  def command_129
  end
  # Window skin change command
  def command_131
  end
  # Battle BGM change command
  def command_132
  end
  # Battle end ME change command
  def command_133
  end
  # Save disable command
  def command_134
  end
  # Menu disable command
  def command_135
  end
  # Encounter disable command
  def command_136
  end
  public
  # Warp command
  def command_201
  end
  # Displace command
  def command_202
  end
  # Map scroll command
  def command_203
  end
  # Map property change command
  def command_204
  end
  # Map Tone change command
  def command_205
  end
  # Map fog opacity change command
  def command_206
  end
  # Display animation on character command
  def command_207
  end
  # Make player transparent command
  def command_208
  end
  # Move route set command
  def command_209
  end
  # Wait until end of events move route
  def command_210
  end
  # Prepare transition command
  def command_221
  end
  # Execute transition command
  def command_222
  end
  # Screen tone change command
  def command_223
  end
  # Flash screen command
  def command_224
  end
  # Shake screen command
  def command_225
  end
  # Picture display command
  def command_231
  end
  # Picture move command
  def command_232
  end
  # Picture rotate command
  def command_233
  end
  # Picture tone change command
  def command_234
  end
  # Picture erase command
  def command_235
  end
  # Weather change command
  def command_236
  end
  # BGM play command
  def command_241
  end
  # BGM fade command
  def command_242
  end
  # BGS play command
  def command_245
  end
  # BGS Fade command
  def command_246
  end
  # BGM & BGS memorize command
  def command_247
  end
  # BGM & BGS restore command
  def command_248
  end
  # ME play command
  def command_249
  end
  # SE play command
  def command_250
  end
  # SE stop command
  def command_251
  end
  public
  # Start battle command
  def command_301
  end
  # 勝った場合
  def command_601
  end
  # 逃げた場合
  def command_602
  end
  # 負けた場合
  def command_603
  end
  # Call a shop command
  def command_302
  end
  # Name calling command
  def command_303
  end
  # Add or remove HP command
  def command_311
  end
  # Add or remove SP command
  def command_312
  end
  # Add or remove state command
  def command_313
  end
  # Heal command
  def command_314
  end
  # Add exp command
  def command_315
  end
  # Add level command
  def command_316
  end
  # Change stat command
  def command_317
  end
  # Skill learn/forget command
  def command_318
  end
  # Equip command
  def command_319
  end
  # Name change command
  def command_320
  end
  # Class change command
  def command_321
  end
  # Actor graphic change command
  def command_322
  end
  public
  # Enemy HP change command
  def command_331
  end
  # Enemy SP change command
  def command_332
  end
  # Enemy state change command
  def command_333
  end
  # Enemy heal command
  def command_334
  end
  # Enemy show command
  def command_335
  end
  # Enemy transform command
  def command_336
  end
  # Play animation on battler
  def command_337
  end
  # Damage on battler command
  def command_338
  end
  # Battler force action command
  def command_339
  end
  # End battle command
  def command_340
  end
  # Call menu command
  def command_351
  end
  # Call save command
  def command_352
  end
  # Game Over command
  def command_353
  end
  # Go to title command
  def command_354
  end
  # Execute script command
  def command_355
  end
  # Function that execute a script
  # @param script [String]
  def eval_script(script)
  end
end
# Hash gérant les variables locales. Des variables propres à l'évènement, 
# Permet de ne pas devoir utiliser de variable de jeu pour gérer ce qui est propre
# à un évènement
# Dans les scrpit, la variable globale $game_self_variables contient les variables
# locales
# 
# @note This script should be after Interpreter 7
# @author Leikt
class Game_SelfVariables
  # Default initialization
  def initialize
  end
  # Fetch the value of a self variable
  # @param key [Array] the key that identify the self variable
  # @return [Object]
  def [](key)
  end
  # Set the value of a self variable
  # @param key [Array] the key that identify the self variable
  # @param value [Object] the new value
  def []=(key, value)
  end
  # Perform an action on the specific variable and return the result
  # @param key [Array] the key that identify the self variable
  # @param operation [Symbol] symbol of the operation to do on the variable
  # @param value [Object] value associated to the operation
  def do(key, operation = nil, value = nil)
  end
end
class Interpreter < Interpreter_RMXP
  # @overload get_local_variable(id_var)
  #   Get a local variable
  #   @param id_var [Symbol] the id of the variable
  # @overload get_local_variable(id_var, operation, value = nil)
  #   Perform an operation on a local variable and get the result
  #   @param id_var [Symbol] the id of the variable
  #   @param operation [Symbol] symbol of the operation to do on the variable
  #   @param value [Object] value associated to the operation
  # @overload get_local_variable(id_event, id_var)
  #   Get a local variable of a specific event
  #   @param id_event [Integer] the id of the event
  #   @param id_var [Symbol] the id of the variable
  # @overload get_local_variable(id_event, id_var, operation, value = nil)
  #   Perform an operation on a local variable of an specific event and get the result
  #   @param id_event [Integer] the id of the event
  #   @param id_var [Symbol] the id of the variable
  #   @param operation [Symbol] symbol of the operation to do on the variable
  #   @param value [Object] value associated to the operation
  # @overload get_local_variable(id_map, id_event, id_var)
  #   Get a local variable of a specific event on a specific map
  #   @param id_map [Integer] the id of the map
  #   @param id_event [Integer] the id of the event
  #   @param id_var [Symbol] the id of the variable
  # @overload get_local_variable(id_map, id_event, id_var, operation, value = nil)
  #   Perform an operation on a local variable of an specific event on a specific map and get the result
  #   @param id_map [Integer] the id of the map
  #   @param id_event [Integer] the id of the event
  #   @param id_var [Symbol] the id of the variable
  #   @param operation [Symbol] symbol of the operation to do on the variable
  #   @param value [Object] value associated to the operation
  # @return [Object]
  def get_local_variable(*args)
  end
  alias VL get_local_variable
  alias LV get_local_variable
  # Set a local variable
  # @param value [Object] the new value of the variable
  # @param id_var [Symbol] the id of the variable
  # @param id_event [Integer] the id of the event
  # @param id_map [Integer] the id of the map
  def set_local_variable(value, id_var, id_event = @event_id, id_map = @map_id)
  end
  alias set_VL set_local_variable
  alias set_LV set_local_variable
end
