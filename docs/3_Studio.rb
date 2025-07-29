class Object
  private
  # Get an ability
  # @param db_symbol [Symbol] db_symbol of the ability
  # @return [Studio::Ability]
  def data_ability(db_symbol)
  end
  # Iterate through all abilities
  # @yieldparam ability [Studio::Ability]
  # @return [Enumerator<Studio::Ability>]
  def each_data_ability(&block)
  end
  # Get an item
  # @param db_symbol [Symbol] db_symbol of the item
  # @return [Studio::Item]
  def data_item(db_symbol)
  end
  # Iterate through all items
  # @yieldparam item [Studio::Item]
  # @return [Enumerator<Studio::Item>]
  def each_data_item(&block)
  end
  # Get a move
  # @param db_symbol [Symbol] db_symbol of the move
  # @return [Studio::Move]
  def data_move(db_symbol)
  end
  # Iterate through all the moves
  # @yieldparam move [Studio::Move]
  # @return [Enumerator<Studio::Move>]
  def each_data_move(&block)
  end
  # Get every be_method and the moves using them
  # @return [Hash{ Symbol => Array<Symbol> }]
  def moves_by_be_method_hash
  end
  # Get a creature
  # @param db_symbol [Symbol] db_symbol of the creature
  # @return [Studio::Creature]
  def data_creature(db_symbol)
  end
  alias data_pokemon data_creature
  # Get a creature form
  # @param db_symbol [Symbol] db_symbol of the creature
  # @param form [Integer] form of the creature
  # @return [Studio::CreatureForm]
  def data_creature_form(db_symbol, form)
  end
  # Iterate through all the creatures
  # @yieldparam move [Studio::Creature]
  # @return [Enumerator<Studio::Creature>]
  def each_data_creature(&block)
  end
  # Get a nature
  # @param db_symbol [Symbol] db_symbol of the nature
  # @return [Studio::Nature]
  def data_nature(db_symbol)
  end
  # Iterate through all the natures
  # @yieldparam move [Studio::Nature]
  # @return [Enumerator<Studio::Nature>]
  def each_data_nature(&block)
  end
  # Get a quest
  # @param db_symbol [Symbol] db_symbol of the quest
  # @return [Studio::Quest]
  def data_quest(db_symbol)
  end
  # Iterate through all the quests
  # @yieldparam quest [Studio::Quest]
  # @return [Enumerator<Studio::Quest>]
  def each_data_quest(&block)
  end
  # Get a trainer
  # @param db_symbol [Symbol] db_symbol of the trainer
  # @return [Studio::Trainer]
  def data_trainer(db_symbol)
  end
  # Iterate through all the trainers
  # @yieldparam trainer [Studio::Trainer]
  # @return [Enumerator<Studio::Trainer>]
  def each_data_trainer(&block)
  end
  # Get a type
  # @param db_symbol [Symbol] db_symbol of the type
  # @return [Studio::Type]
  def data_type(db_symbol)
  end
  # Iterate through all the types
  # @yieldparam type [Studio::Type]
  # @return [Enumerator<Studio::Type>]
  def each_data_type(&block)
  end
  # Get a zone
  # @param db_symbol [Symbol] db_symbol of the zone
  # @return [Studio::Zone]
  def data_zone(db_symbol)
  end
  # Iterate through all the zones
  # @yieldparam zone [Studio::Zone]
  # @return [Enumerator<Studio::Zone>]
  def each_data_zone(&block)
  end
  # Get a group
  # @param db_symbol [Symbol] db_symbol of the group
  # @return [Studio::Group]
  def data_group(db_symbol)
  end
  # Iterate through all the groups
  # @yieldparam zone [Studio::Group]
  # @return [Enumerator<Studio::Group>]
  def each_data_group(&block)
  end
  # Get a world map
  # @param db_symbol [Symbol] db_symbol of the world map
  # @return [Studio::WorldMap]
  def data_world_map(db_symbol)
  end
  # Iterate through all the world map
  # @yieldparam world_map [Studio::WorldMap]
  # @return [Enumerator<Studio::WorldMap>]
  def each_data_world_map(&block)
  end
  # Get a dex
  # @param db_symbol [Symbol] db_symbol of the dex
  # @return [Studio::Dex]
  def data_dex(db_symbol)
  end
  # Iterate through all the dex
  # @yieldparam dex [Studio::Dex]
  # @return [Enumerator<Studio::Dex>]
  def each_data_dex(&block)
  end
  # Get a map link
  # @param db_symbol [Symbol] db_symbol of the map link
  # @return [Studio::MapLink]
  def data_map_link(db_symbol)
  end
  # Iterate through all the map links
  # @yieldparam map_link [Studio::MapLink]
  # @return [Enumerator<Studio::MapLink>]
  def each_data_map_link(&block)
  end
  # Get the game data
  # @return [Hash<Symbol => Hash>]
  def __game_data
  end
  # Get the game data by id
  # @param id_storage [Symbol]
  # @param storage [Symbol]
  # @param id [Integer]
  def __game_data_by_id(id_storage, storage, id)
  end
end
Graphics.on_start {__game_data }
# Module holding all the Studio data definition
module Studio
  # Module that helps the game to get text in various langages
  # @author Nuri Yuri
  module Text
    # List of lang id available in the game
    Available_Langs = ['en', 'fr', 'it', 'de', 'es', 'ko', 'kana']
    # Base index of pokemon text in csv files
    CSV_BASE = 100_000
    # Name of the file containing all the dialogs
    VD_TEXT_FILENAME = 'Data/2.dat'
    @texts = []
    @dialogs = {}
    @lang = nil
    module_function
    # load text in the correct lang ($options.language or LANG in game.ini)
    def load
    end
    # Return the default game lang
    # @return [String]
    def default_lang
    end
    # Get a text front the text database
    # @param file_id [Integer] ID of the text file
    # @param text_id [Integer] ID of the text in the file
    # @return [String] the text
    def get(file_id, text_id)
    end
    # Get a list of text from the text database
    # @param file_id [Integer] ID of the text file
    # @return [Array<String>] the list of text contained in the file.
    def get_file(file_id)
    end
    # Get a dialog message
    # @param file_id [Integer] id of the dialog file
    # @param text_id [Integer] id of the dialog message in the file (0 = 2nd line of csv, 1 = 3rd line of csv)
    # @return [String] the text
    def get_dialog_message(file_id, text_id)
    end
    alias get_external get_dialog_message
    module_function :get_external
    # Try to load a preprocessed dialog file (Marshal)
    # @param file_id [Integer] id of the dialog file
    # @return [Boolean] if the operation was a success
    def try2get_marshalized_dialog(file_id)
    end
    # Test if a marshalized text file exist
    # @param filename [String] name of the file in Data/text/Dialogs
    # @return [Boolean]
    def marshalized_text_file_exist?(filename)
    end
    # Try to load a csv dialog file
    # @param file_id [Integer] id of the dialog file
    # @return [Boolean] if the operation was a success
    def try2get_csv_dialog(file_id)
    end
    # Build the text array from the csv rows
    # @param rows [Array]
    # @param lang_index [Integer]
    # @return [Array<String>]
    def build_dialog_from_csv_rows(rows, lang_index)
    end
    # Marshalize the dialogs
    def compile
    end
    # Compile a single csv file
    # @param filename [String] name of the csv file
    def compile_csv(filename)
    end
    # Reload texts from Ruby Host
    def reload_rh_texts
    end
  end
  # Data class describing an Ability
  class Ability
    # ID of the ability
    # @return [Integer]
    attr_reader :id
    # db_symbol of the ability
    # @return [Symbol]
    attr_reader :db_symbol
    # ID of the text of the ability in the text files
    # @return [Integer]
    attr_reader :text_id
    # Get the text description of the ability
    # @return [String]
    def description
    end
    alias descr description
    # Get the text name of the ability
    # @return [String]
    def name
    end
  end
  # Data class describing a wild Group
  class Group
    # ID of the group
    # @return [Integer]
    attr_reader :id
    # db_symbol of the group
    # @return [Symbol]
    attr_reader :db_symbol
    # System tag in which the wild creature should appear
    # @return [Symbol]
    attr_reader :system_tag
    # Terrain tag in which the wild creature should appear
    # @return [Integer]
    attr_reader :terrain_tag
    # Tool used to trigger that group (:old_rod, :good_rod, :super_rod, :rock_smash, :head_butt)
    # @return [Symbol, nil]
    attr_reader :tool
    # The type of the wild battle (:simple, :double, :triple, :horde)
    # @return [Symbol]
    attr_reader :vs_type
    # All the custom condition for the group to be active
    # @return [Array<CustomCondition>]
    attr_reader :custom_conditions
    # All the wild encounters
    # @return [Array<Encounter>]
    attr_reader :encounters
    # Average number of steps for the group to have a creature spawn
    # @return [Integer]
    attr_reader :steps_average
    # If the wild battle should be a double battle
    # @deprecated Will be removed
    # @return [Boolean]
    def is_double_battle
    end
    # If the wild battle should be a horde battle
    # @deprecated Will be removed
    # @return [Boolean]
    def is_horde_battle
    end
    # Data class describing a custom group condition
    class CustomCondition
      # Type of the custom condition (:enabled_switch or :map_id)
      # @return [Symbol]
      attr_reader :type
      # Value of the condition
      # @return [Integer]
      attr_reader :value
      # Relation of the condition (:AND, :OR)
      # @return [Symbol]
      attr_reader :relation_with_previous_condition
      # Evaluate the condition in a reduce context
      # @param previous [Boolean] result of the previous condition
      # @return [Boolean]
      def reduce_evaluate(previous)
      end
      # Evaluate the condition
      def evaluate
      end
    end
    # Data class describing an Encounter for a wild group
    class Encounter
      # db_symbol of the creature that should be encountered
      # @return [Symbol]
      attr_reader :specie
      # Form of the creature that should be encountered
      # @return [Integer]
      attr_reader :form
      # Shiny attribute setup for the creature
      # @return [ShinySetup]
      attr_reader :shiny_setup
      # Level setup of the creature that should be encountered
      # @return [LevelSetup]
      attr_reader :level_setup
      # Encounter rate of the creature in its group
      # @return [Integer]
      attr_reader :encounter_rate
      # Additional info for the creature (to generate it)
      # @return [Hash]
      attr_reader :extra
      # Convert the encounter to an actual creature
      # @param level [Integer] level generated through outside factor (ability / other)
      # @return [PFM::Pokemon]
      def to_creature(level = nil)
      end
      # Generate generic form generation between 0 and 29 if form == -1 and the Pokemon has not a FORM_GENERATION
      def generic_form_generation
      end
      # Data class helping to know the shiny setup of a creature
      class ShinySetup
        # Create a new shiny setup
        # @param hash [Hash] shiny setup info
        def initialize(hash)
        end
        # Get the shiny attribute of the creature
        # @param rate [Float] current rate to guess the creature shiny rate
        # @return [Boolean]
        def shiny(rate = rand)
        end
        # Get the forbid shiny attribute
        # @return [Boolean]
        def not_shiny
        end
      end
      # Data class helping to know the level setup of a creature while picking its level from group
      class LevelSetup
        # Get the level range (to give to a rand function) to get the final level of the creature
        # @return [Range]
        attr_reader :range
        # Create a new level setup
        # @param hash [Hash]
        def initialize(hash)
        end
        # Tell if that level setup makes the encounter rejected by repel
        # @param actor_level [Integer]
        # @return [Boolean]
        def repel_rejected(actor_level)
        end
        # Tell if that level setup makes the encounter being selected because actor is weaker
        # @param actor_level [Integer]
        # @return [Boolean]
        def strong_selected(actor_level)
        end
      end
    end
  end
  # Data class describing an Item (see 00002 Item folder for functional items)
  class Item
    # List of get item ME
    ItemGetME = ['Audio/ME/ROSA_ItemObtained.ogg', 'Audio/ME/ROSA_KeyItemObtained.ogg', 'Audio/ME/ROSA_TMObtained.ogg']
    # ID of the item
    # @return [Integer]
    attr_reader :id
    # db_symbol of the item
    # @return [Symbol]
    attr_reader :db_symbol
    # Icon of the item (in the bag)
    # @return [String]
    attr_reader :icon
    # Price of the item (in the shop)
    # @return [Integer]
    attr_reader :price
    # Pocket of the item in the bag
    # @return [Integer]
    attr_reader :socket
    # Relative position of the item (in the socket) in ascending order
    # @return [Integer]
    attr_reader :position
    # If the item can be used in battle
    # @return [Boolean]
    attr_reader :is_battle_usable
    # If the item can be used in the overworld
    # @return [Boolean]
    attr_reader :is_map_usable
    # If the item must be consumed when used
    # @return [Boolean]
    attr_reader :is_limited
    # If the item can be held by a creature
    # @return [Boolean]
    attr_reader :is_holdable
    # Power of the Fling move when item is thrown
    # @return [Integer]
    attr_reader :fling_power
    # Get the name of the item
    # @return [String]
    def name
    end
    # Get the exact name of the item (including move name)
    # @return [String]
    def exact_name
    end
    # Name of the item in plural
    # @return [String]
    def plural_name
    end
    # Description of the item
    # @return [String]
    def description
    end
    alias descr description
    # Get the ME of the item when it's got
    # @return [String]
    def me
    end
  end
  # Data class describing a Move
  class Move
    # ID of the move
    # @return [Integer]
    attr_reader :id
    # db_symbol of the move
    # @return [Symbol]
    attr_reader :db_symbol
    # Get the move name
    # @return [String]
    def name
    end
    # Get the move description
    # @return [String]
    def description
    end
    alias descr description
    # ID of the common event to call on map
    # @return [Integer]
    attr_reader :map_use
    # symbol that helps the battle engine to pick the right Move procedure
    # @return [Symbol]
    attr_reader :battle_engine_method
    alias be_method battle_engine_method
    # Type of the move
    # @return [Symbol]
    attr_reader :type
    # Power of the move
    # @return [Integer]
    attr_reader :power
    # Accuracy of the move
    # @return [Integer]
    attr_reader :accuracy
    # Default amount of PP of the move
    # @return [Integer]
    attr_reader :pp
    # Category of the move (:physical, :special, :status)
    # @return [Symbol]
    attr_reader :category
    # Critical rate indicator of the move (0 => 0, 1 => 6.25%, 2 => 12.5%, 3 => 25%, 4 => 33%, 5 => 50%, 6 => 100%)
    # @return [Integer]
    attr_reader :movecritical_rate
    alias critical_rate movecritical_rate
    # Priority of the move (-7 ~ 0 ~ +7)
    # @return [Integer]
    attr_reader :priority
    # If the move makes contact with opponent
    # @return [Boolean]
    attr_reader :is_direct
    # If the move has a charging turn that can be skipped with a power-herb
    # @return [Boolean]
    attr_reader :is_charge
    # If the move has a pause turn after being used
    # @return [Boolean]
    attr_reader :is_recharge
    # If the move is blocked by detect or protect
    # @return [Boolean]
    attr_reader :is_blocable
    # If the move must be stolen if another creature used Snatch during this turn
    # @return [Boolean]
    attr_reader :is_snatchable
    # Another creature can copy this move if it targets the user of this move
    # @return [Boolean]
    attr_reader :is_mirror_move
    # If this move gets a power bonus of 1.2x when user has iron-fist ability
    # @return [Boolean]
    attr_reader :is_punch
    # If this move cannot be used under gravity
    # @return [Boolean]
    attr_reader :is_gravity
    # If this move can be reflected by magic-coat move or magic-bounce ability
    # @return [Boolean]
    attr_reader :is_magic_coat_affected
    # If this move can be used while frozen and defreeze user
    # @return [Boolean]
    attr_reader :is_unfreeze
    # If target of this move with ability soundproof are immune to this move
    # @return [Boolean]
    attr_reader :is_sound_attack
    # If the move deals 1.5x damage when user has sharpness ability
    # @return [Boolean]
    attr_reader :is_slicing_attack
    # If target of this move with ability wind power or wind rider will be activated to this move
    # @return [Boolean]
    attr_reader :is_wind
    # If the move can reach any target regardless of the position
    # @return [Boolean]
    attr_reader :is_distance
    # If the move can be blocked by heal-block
    # @return [Boolean]
    attr_reader :is_heal
    # If the move ignore the target's substitute
    # @return [Boolean]
    attr_reader :is_authentic
    # If the move deals 1.5x damage when user has strong-jaw ability
    # @return [Boolean]
    attr_reader :is_bite
    # If the move deals 1.5x damage when user has mega-launcher ability
    # @return [Boolean]
    attr_reader :is_pulse
    # If this move is blocked by bulletproof ability
    # @return [Boolean]
    attr_reader :is_ballistics
    # If this move is blocked by aroma-veil ability and cured by mental-herb item
    # @return [Boolean]
    attr_reader :is_mental
    # If this move cannot be used in Sky Battles
    # @return [Boolean]
    attr_reader :is_non_sky_battle
    # If this move triggers the dancer ability
    # @return [Boolean]
    attr_reader :is_dance
    # If this move triggers the King's Rock
    # @return [Boolean]
    attr_reader :is_king_rock_utility
    # If grass-type or creatures with overcoat ability are immune to this move
    # @return [Boolean]
    attr_reader :is_powder
    # Chance to trigger the secondary effect (0~100)
    # @return [Integer]
    attr_reader :effect_chance
    # Target type the move can aim
    # @return [Symbol]
    attr_reader :battle_engine_aimed_target
    # List of stage this move change
    # @return [Array<BattleStageMod>]
    attr_reader :battle_stage_mod
    # List of status this move can apply
    # @return [Array<MoveStatus>]
    attr_reader :move_status
    # Class describing the stat modification
    class BattleStageMod
      # Stat this stage mod change (:atk, :dfe, :spd, :ats, :dfs, :eva, :acc)
      # @return [Symbol]
      attr_reader :stat
      # Amount of the stage it changes
      # @return [Integer]
      attr_reader :count
    end
    # Class describing the status modification with it's chance to happen
    class MoveStatus
      # Status this move applies
      # @return [Symbol]
      attr_reader :status
      # Chance to trigger this status (0~100)
      # @return [Integer]
      attr_reader :luck_rate
    end
  end
  # Data class describing a creature
  class Creature
    # ID of the specie
    # @return [Integer]
    attr_reader :id
    # db_symbol of the specie
    # @return [Symbol]
    attr_reader :db_symbol
    # all the form of the creature
    # @return [Array<CreatureForm>]
    attr_reader :forms
    # Get the creature name
    # @return [String]
    def name
    end
    # Get the specie name
    # @return [String]
    def species
    end
    # Get the creature description
    # @return [String]
    def description
    end
    alias descr description
  end
  # Data class describing a creature form
  class CreatureForm < Creature
    undef forms
    # Current form ID
    # @return [Integer]
    attr_reader :form
    # Current form text ID
    # @return [FormTextId]
    attr_reader :form_text_id
    # Height of the form
    # @return [Float]
    attr_reader :height
    # Weight of the form
    # @return [Float]
    attr_reader :weight
    # Symbol of the first type of the form
    # @return [Symbol]
    attr_reader :type1
    # Symbol of the second type of the form
    # @return [Symbol]
    attr_reader :type2
    # Base hp of the form
    # @return [Integer]
    attr_reader :base_hp
    # Base atk of the form
    # @return [Integer]
    attr_reader :base_atk
    # Base dfe of the form
    # @return [Integer]
    attr_reader :base_dfe
    # Base spd of the form
    # @return [Integer]
    attr_reader :base_spd
    # Base ats of the form
    # @return [Integer]
    attr_reader :base_ats
    # Base dfs of the form
    # @return [Integer]
    attr_reader :base_dfs
    # HP EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_hp
    # Atk EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_atk
    # Dfe EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_dfe
    # Spd EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_spd
    # Ats EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_ats
    # Dfs EV given by this form when fainted
    # @return [Integer]
    attr_reader :ev_dfs
    # All the evolutions of that form
    # @return [Array<Evolution>]
    attr_reader :evolutions
    # Type of exp curve for the form
    # @return [Integer]
    attr_reader :experience_type
    # Base experience use in exp calculation when fainted
    # @return [Integer]
    attr_reader :base_experience
    # Loyalty the creature have when caught
    # @return [Integer]
    attr_reader :base_loyalty
    # Catch rate of the creature
    # @return [Integer]
    attr_reader :catch_rate
    # Female rate of the creature
    # @return [Integer]
    attr_reader :female_rate
    # List of breed groups of the creature
    # @return [Array<Integer>]
    attr_reader :breed_groups
    # Number of steps before the egg hatches
    # @return [Integer]
    attr_reader :hatch_steps
    # db_symbol of the baby creature
    # @return [Symbol]
    attr_reader :baby_db_symbol
    # Form of the baby
    # @return [Integer]
    attr_reader :baby_form
    # Item held by the creature when encountered
    # @return [Array<ItemHeld>]
    attr_reader :item_held
    # Abilities the creature can have
    # @return [Array<Symbol>]
    attr_reader :abilities
    # Front offset y of the creature so it can be centered in the UI
    # @return [Integer]
    attr_reader :front_offset_y
    # Moveset of the creature
    # @return [Array<LearnableMove>]
    attr_reader :move_set
    # Resources of the creature
    # @return [Resources]
    attr_reader :resources
    # Get the creature form name
    # @return [string]
    def form_name
    end
    # Get the creature form description
    # @return [string]
    def form_description
    end
    alias form_descr form_description
    # Data class describing an evolution
    class Evolution
      # db_symbol of the creature to evolve to
      # @return [Symbol]
      attr_reader :db_symbol
      # Form of the creature to evolve to
      # @return [Integer]
      attr_reader :form
      # Conditions of the evolution
      # @return [Array<Hash>]
      attr_reader :conditions
      # Get data by condition
      # @param type [Symbol] type of condition to check
      # @return [Symbol, Integer]
      def condition_data(type)
      end
    end
    # Item held by the creature when generated
    class ItemHeld
      # db_symbol of the item that should be held
      # @return [Symbol]
      attr_reader :db_symbol
      # Chance that the creature is holding this item
      # @return [Integer]
      attr_reader :chance
    end
    # Resource of the creature for UI purpose
    class Resources
      # Standard icon
      # @return [String]
      attr_reader :icon
      # Female icon
      # @return [String, nil]
      attr_reader :icon_f
      # Standard shiny icon
      # @return [String]
      attr_reader :icon_shiny
      # Female shiny icon
      # @return [String, nil]
      attr_reader :icon_shiny_f
      # Standard front
      # @return [String]
      attr_reader :front
      # Female front
      # @return [String, nil]
      attr_reader :front_f
      # Standard shiny front
      # @return [String]
      attr_reader :front_shiny
      # Female shiny front
      # @return [String, nil]
      attr_reader :front_shiny_f
      # Standard back
      # @return [String]
      attr_reader :back
      # Female back
      # @return [String, nil]
      attr_reader :back_f
      # Standard shiny back
      # @return [String]
      attr_reader :back_shiny
      # Female shiny back
      # @return [String, nil]
      attr_reader :back_shiny_f
      # Footprint
      # @return [String]
      attr_reader :footprint
      # Standard character
      # @return [String]
      attr_reader :character
      # Female character
      # @return [String, nil]
      attr_reader :character_f
      # Standard shiny character
      # @return [String]
      attr_reader :character_shiny
      # Female shiny character
      # @return [String, nil]
      attr_reader :character_shiny_f
      # Cry
      # @return [String]
      attr_reader :cry
      # Test if the females resources can be used
      # @return [Boolean]
      attr_reader :has_female
      # Egg
      # @return [String]
      attr_reader :egg
      # Egg icon
      # @return [String]
      attr_reader :icon_egg
    end
    class FormTextId
      # ID of the form name
      # @return [Integer]
      attr_reader :name
      # ID of the form description
      # @return [Integer]
      attr_reader :description
    end
  end
  # Data class describing a learnable move
  class LearnableMove
    # db_symbol of the move that can be learnt
    # @return [Symbol]
    attr_reader :move
    # Test if the move is learnable by level
    # @return [Boolean]
    def level_learnable?
    end
    # Test if the move is learnable by tutor
    # @return [Boolean]
    def tutor_learnable?
    end
    # Test if the move is learnable by tech item
    # @return [Boolean]
    def tech_learnable?
    end
    # Test if the move is learnable by breeding
    # @return [Boolean]
    def breed_learnable?
    end
    # Test if the move is learnable by evolution
    # @return [Boolean]
    def evolution_learnable?
    end
  end
  # Data class describing a move learnable by level
  class LevelLearnableMove < LearnableMove
    # Level when the move can be learnt
    # @return [Integer]
    attr_reader :level
    # Test if the move is learnable by level
    # @return [Boolean]
    def level_learnable?
    end
  end
  # Data class describing a move that can be teached by a Move Tutor
  class TutorLearnableMove < LearnableMove
    # Test if the move is learnable by tutor
    # @return [Boolean]
    def tutor_learnable?
    end
  end
  # Data class decribing a move that can be teached using a TechItem
  class TechLearnableMove < LearnableMove
    # Test if the move is learnable by tech item
    # @return [Boolean]
    def tech_learnable?
    end
  end
  # Data class describing a move that can be learnt through breeding
  class BreedLearnableMove < LearnableMove
    # Test if the move is learnable by breeding
    # @return [Boolean]
    def breed_learnable?
    end
  end
  # Data class describing a move that can be learnt through evolution
  class EvolutionLearnableMove < LearnableMove
    # Test if the move is learnable by evolution
    # @return [Boolean]
    def evolution_learnable?
    end
  end
  # Data class describing a dex
  class Dex
    # Get the db_symbol of the dex
    # @return [Symbol]
    attr_reader :db_symbol
    # Get the ID of the dex
    # @return [Integer]
    attr_reader :id
    # Get the start id of each creature in the dex
    # @return [Integer]
    attr_reader :start_id
    # Get the list of creature in the dex
    # @return [Array<CreatureInfo>]
    attr_reader :creatures
    # Get the dex name
    # @return [CSVAccess]
    attr_reader :csv
    # Get the name of the dex
    # @return [String]
    def name
    end
    # Data class describing a creature info in the dex
    class CreatureInfo
      # Get the db_symbol of the creature
      # @return [Symbol]
      attr_reader :db_symbol
      # Get the form of the creature
      # @return [Integer]
      attr_reader :form
      # Create a new CreatureInfo
      # @param db_symbol [Symbol]
      # @param form [Integer]
      def initialize(db_symbol, form)
      end
    end
  end
  class Nature
    # ID of the nature
    # @return [Integer]
    attr_reader :id
    # db_symbol of the nature
    # @return [Symbol]
    attr_reader :db_symbol
    # Hash containing the stats
    # @return [Hash{Symbol=>Integer}]
    attr_reader :stats
    # Hash containing the liked and disliked flavors
    # @return [Hash{Symbol=>Symbol}]
    attr_reader :flavors
    # Get the nature name
    # @return [String]
    def name
    end
    # Get the atk modifier of the nature
    # @return [Integer]
    def atk
    end
    # Get the dfe modifier of the nature
    # @return [Integer]
    def dfe
    end
    # Get the ats modifier of the nature
    # @return [Integer]
    def ats
    end
    # Get the dfs modifier of the nature
    # @return [Integer]
    def dfs
    end
    # Get the spd modifier of the nature
    # @return [Integer]
    def spd
    end
    # Get the important data in an array form
    # Used in multiple contexts so it's easier to just return the same thing as before
    # @return [Array<Integer>] [text_id, atk%, dfe%, spd%, ats%, dfs%]
    def to_a
    end
    # Get the liked flavor of the nature
    # @return [Symbol]
    def liked_flavor
    end
    # Get the disliked flavor of the nature
    # @return [Symbol]
    def disliked_flavor
    end
  end
  # Data class describing an Quest
  class Quest
    # ID of the quest
    # @return [Integer]
    attr_reader :id
    # db_symbol of the quest
    # @return [Symbol]
    attr_reader :db_symbol
    # Is the quest primary
    # @return [Boolean]
    attr_reader :is_primary
    # Kind of quest resolution process (:default or :progressive)
    # @return [Symbol]
    attr_reader :resolution
    # List of objective to complete the quest
    # @return [Array<Objective>]
    attr_reader :objectives
    # List of all the earning from completing the quest
    # @return [Array<Earning>]
    attr_reader :earnings
    # Get the text description of the ability
    # @return [String]
    def description
    end
    alias descr description
    # Get the text name of the ability
    # @return [String]
    def name
    end
    # Data class describing a quest objective
    class Objective
      # Name of the method to call to validate the objective
      # @return [Symbol]
      attr_reader :objective_method_name
      # Arguments of the method to call
      # @return [Array]
      attr_reader :objective_method_args
      # Name of the method to call in order to get the text to show in UI
      # @return [Symbol]
      attr_reader :text_format_method_name
      # If the objective is hidden by default
      # @return [Boolean]
      attr_reader :hidden_by_default
    end
    # Data class describing a quest earning
    class Earning
      # Name of the method to call to give the earning to player
      # @return [Symbol]
      attr_reader :earning_method_name
      # Argument of the method to call
      # @return [Array]
      attr_reader :earning_args
      # Name of the method to call in order to get the text to show in UI
      # @return [Symbol]
      attr_reader :text_format_method_name
    end
  end
  # Data class describing a trainer
  class Trainer
    # ID of the trainer
    # @return [Integer]
    attr_reader :id
    # db_symbol of the trainer
    # @return [Symbol]
    attr_reader :db_symbol
    # vs type of the trainer (if he uses 1 2 or more creature at once)
    # @return [Integer]
    attr_reader :vs_type
    # If the trainer is actually a couple (two trainer on same picture)
    # @return [Boolean]
    attr_reader :is_couple
    # Base factor of the money gave by this trainer in case of defeate (money = base * last_level)
    # @return [Integer]
    attr_reader :base_money
    # ID of the battler events to load in order to give more life to this trainer
    # @return [Integer]
    attr_reader :battle_id
    # AI level of that trainer
    # @return [Integer]
    attr_reader :ai
    # Party of that trainer
    # @return [Array<Group::Encounter>]
    attr_reader :party
    # List of all items the trainer holds in its bag
    # @return [Array<Hash>]
    attr_reader :bag_entries
    # Resources of the trainer
    # @return [Resources]
    attr_reader :resources
    # Get the class name of the trainer
    # @return [String]
    def class_name
    end
    # Get the text name of the trainer
    # @return [String]
    def name
    end
    # Get the victory text of the trainer
    def victory_text
    end
    # Get the defeat text of the trainer
    def defeat_text
    end
    class Resources
      # Sprite of the trainer (Gen 4/5 style)
      # @return [String]
      attr_reader :sprite
      # Full artwork of the trainer (Gen 6+ style)
      # @return [String]
      attr_reader :artwork_full
      # Small artwork of the trainer (Gen 6+ style)
      # @return [String]
      attr_reader :artwork_small
      # Character of the trainer
      # @return [String]
      attr_reader :character
      # BGM played when the enemy trainer sees the player (trainer_eye_sequence)
      # @return [String]
      attr_reader :encounter_bgm
      # BGM played when the enemy trainer wins the battle
      # @return [String]
      attr_reader :victory_bgm
      # BGM played when the enemy trainer loses the battle
      # @return [String]
      attr_reader :defeat_bgm
      # BGM played during the battle
      # @return [String]
      attr_reader :battle_bgm
    end
  end
  # Data class describing a type
  class Type
    # ID of the type
    # @return [Integer]
    attr_reader :id
    # db_symbol of the type
    # @return [Symbol]
    attr_reader :db_symbol
    # ID of the text of the type in the text files
    # @return [Integer]
    attr_reader :text_id
    # List of damage the type deals to another type
    # @return [Array<DamageTo>]
    attr_reader :damage_to
    # Color of the type
    # @return [Color, nil]
    attr_reader :color
    # Get the text name of the type
    # @return [String]
    def name
    end
    # Get the modifier of this type when hitting another type
    # @param other_type [Symbol] db_symbol of the other type
    # @return [Float]
    def hit(other_type)
    end
    # Data class describing the damage a type does against another type
    class DamageTo
      # Defensive type getting the damage factor
      # @return [Symbol]
      attr_reader :defensive_type
      # Factor of damage over the defensive type
      # @return [Float]
      attr_reader :factor
    end
  end
  # Data class describing a worldmap
  class WorldMap
    # ID of the worldmap
    # @return [Integer]
    attr_reader :id
    # db_symbol of the worldmap
    # @return [Symbol]
    attr_reader :db_symbol
    # Image filename of the worldmap
    # @return [String]
    attr_reader :image
    # Grid of the worldmap (2D array of zone id)
    # @return [Array]
    attr_reader :grid
    # Get the region name
    # @return [CSVAccess]
    attr_reader :region_name
    # Name of the region
    # @return [String]
    def name
    end
  end
  # Data class describing a CSV access
  class CSVAccess
    # ID of the csv file
    # @return [Integer]
    attr_reader :file_id
    # Index of the text in CSV file
    # @return [Integer]
    attr_reader :text_index
    # Get the text
    # @return [String]
    def get
    end
  end
  # Data class describing a zone (set of map under the same name, group etc...)
  class Zone
    # ID of the zone
    # @return [Integer]
    attr_reader :id
    # db_symbol of the zone
    # @return [Symbol]
    attr_reader :db_symbol
    # List of maps included in this zone
    # @return [Array<Integer>]
    attr_reader :maps
    # List of worldmap included in this zone
    # @return [Array<Integer>]
    attr_reader :worldmaps
    # ID of the panel to show when entering the zone (0 = none)
    # @return [Integer]
    attr_reader :panel_id
    # Target warp coordinates when using Dig, Fly or Teleport
    # @return [MapCoordinate]
    attr_reader :warp
    # Default position of the zone on the worldmap
    # @return [MapCoordinate]
    attr_reader :position
    # If the player can use fly, otherwise use dig
    # @return [Boolean]
    attr_reader :is_fly_allowed
    # If the player cannot use any teleportation method (fly, dig, teleport)
    # @return [Boolean]
    attr_reader :is_warp_disallowed
    # ID of the weather to automatically trigger
    # @return [Integer, nil]
    attr_reader :forced_weather
    # List of wild group db_symbol included on this map
    # @return [Array<Symbol>]
    attr_reader :wild_groups
    # Get the zone name
    # @return [String]
    def name
    end
    # Data class describing a map coordinate
    class MapCoordinate
      # Get the x position
      # @return [Integer]
      attr_reader :x
      # Get the y position
      # @return [Integer]
      attr_reader :y
    end
  end
  # Data class describing a map link
  #
  # @note This class has an id and a map_id, this leaves room to add conditional map links in the future ;)
  class MapLink
    # ID of the map link
    # @return [Integer]
    attr_reader :id
    # db_symbol of the map link
    # @return [Symbol]
    attr_reader :db_symbol
    # ID of the map player should be in to have this link
    # @return [Integer]
    attr_reader :map_id
    # List of maps linked to the north cardinal of current map
    # @return [Array<Link>]
    attr_reader :north_maps
    # List of maps linked to the east cardinal of current map
    # @return [Array<Link>]
    attr_reader :east_maps
    # List of maps linked to the south cardinal of current map
    # @return [Array<Link>]
    attr_reader :south_maps
    # List of maps linked to the west cardinal of current map
    # @return [Array<Link>]
    attr_reader :west_maps
    # Class describing how map is linked to current map with its offset and its id
    class Link
      # ID of the map linked to current map
      # @return [Integer]
      attr_reader :map_id
      # Offset to the right or bottom depending on which cardinal the map is
      # @return [Integer]
      attr_reader :offset
    end
  end
  # Data class describing an Item that calls an event in map
  class EventItem < Item
    # Get the ID of the event to call
    # @return [Integer]
    attr_reader :event_id
  end
  # Data class describing an Item that let the player flee battles
  class FleeingItem < Item
  end
  # Data class describing an Item that repels creature for a certain amount of step
  class RepelItem < Item
    # Get the number of steps this item repels
    # @return [Integer]
    attr_reader :repel_count
  end
  # Data class describing an Item that make creatures evolve
  class StoneItem < Item
  end
  # Data class describing an Item that allow a creature to learn a move
  class TechItem < Item
    # HM/TM text
    HM_TM_TEXT = '%s %s'
    # Get the db_symbol of the move it teaches
    # @return [Symbol]
    attr_reader :move
    # Get if the item is a Hidden Move or not
    # @return [Boolean]
    attr_reader :is_hm
    alias move_db_symbol move
    # Get the exact name of the item
    # @return [String]
    def exact_name
    end
  end
  # Data class describing an Item that allow the player to catch a creature
  class BallItem < Item
    # Get the image of the ball
    # @return [String]
    attr_reader :sprite_filename
    # Get the rate of the ball in worse conditions
    # @return [Integer, Float]
    attr_reader :catch_rate
    # Get the color of the ball
    # @return [Color]
    attr_reader :color
    alias img sprite_filename
  end
  # Data class describing an Item that is expected to heal a creature
  class HealingItem < Item
    # Get the loyalty malus
    # @return [Integer]
    attr_reader :loyalty_malus
  end
  # Data class describing an Item that heals a constant amount of hp
  class ConstantHealItem < HealingItem
    # Get the number of hp the item heals
    # @return [Integer]
    attr_reader :hp_count
  end
  # Data class describing an Item that gives experience to a Pokemon
  class ExpGiveItem < HealingItem
    # Get the number of exp point this item gives
    # @return [Integer]
    attr_reader :exp_count
  end
  # Data class describing an Item that increase the level of the Pokemon
  class LevelIncreaseItem < HealingItem
    # Get the number of level this item increase
    # @return [Integer]
    attr_reader :level_count
  end
  # Data class describing an Item that heals a certain amount of PP of a single move
  class PPHealItem < HealingItem
    # Get the number of PP of the move that gets healed
    # @return [Integer]
    attr_reader :pp_count
  end
  # Data class describing an Item that increase the PP of a move
  class PPIncreaseItem < HealingItem
    # Tell if this item sets the PP to the max possible amount
    # @return [Boolean]
    attr_reader :is_max
  end
  # Data class describing an Item that heals a rate (0~100% using a number between 0 & 1) of hp
  class RateHealItem < HealingItem
    # Get the rate of hp this item can heal
    # @return [Float]
    attr_reader :hp_rate
  end
  # Data class describing an Item that boost a specific stat of a creature in Battle
  class StatBoostItem < HealingItem
    # Get the symbol of the stat to boost
    # @return [Symbol]
    attr_reader :stat
    # Get the power of the stat to boost
    # @return [Integer]
    attr_reader :count
  end
  # Data class describing an Item that heals status
  class StatusHealItem < HealingItem
    # Get the list of states the item heals
    # @return [Array<Symbol>]
    attr_accessor :status_list
    # Get the status as Integer
    # @return [Array<Integer>]
    def status_id_list
    end
  end
  # Data class describing an Item that heals a certain amount of PP of all moves
  class AllPPHealItem < PPHealItem
  end
  # Data class describing an Item that boost an EV stat of a Pokemon
  class EVBoostItem < StatBoostItem
    # List of text ID to get the stat name
    STAT_NAME_TEXT_ID = {hp: 134, atk: 129, dfe: 130, spd: 133, ats: 131, dfs: 132}
  end
  # Data class describing an Item that heals a constant amount of hp and heals status as well
  class StatusConstantHealItem < ConstantHealItem
    # Get the list of states the item heals
    # @return [Array<Symbol>]
    attr_accessor :status_list
    # Get the status as Integer
    # @return [Array<Integer>]
    def status_id_list
    end
  end
  # Data class describing an Item that heals a rate amount of hp and heals status as well
  class StatusRateHealItem < RateHealItem
    # Get the list of states the item heals
    # @return [Array<Symbol>]
    attr_accessor :status_list
    # Get the status as Integer
    # @return [Array<Integer>]
    def status_id_list
    end
  end
end
module Configs
  # Configuration of states
  class States
    # Get the ID of states
    # @return [Hash<Symbol => Integer>]
    attr_accessor :ids
    def initialize
    end
    # Get the symbol of a state from its id
    # @return [Symbol, nil]
    def symbol(id)
    end
    # Convert the config to json
    def to_json(*)
    end
  end
  register(:states, 'states', :json, false, States)
  # Configuration of stats
  class Stats
    # Maximum amount of EV
    # @return [Integer]
    attr_accessor :max_total_ev
    # Maximum amount of EV on a stat
    # @return [Integer]
    attr_accessor :max_stat_ev
    # Index of each hp ev
    # @return [Integer]
    attr_accessor :hp_index
    # Index of atk ev
    # @return [Integer]
    attr_accessor :atk_index
    # Index of dfe ev
    # @return [Integer]
    attr_accessor :dfe_index
    # Index of spd ev
    # @return [Integer]
    attr_accessor :spd_index
    # Index of ats ev
    # @return [Integer]
    attr_accessor :ats_index
    # Index of dfs ev
    # @return [Integer]
    attr_accessor :dfs_index
    # Index of atk stage
    # @return [Integer]
    attr_accessor :atk_stage_index
    # Index of dfe stage
    # @return [Integer]
    attr_accessor :dfe_stage_index
    # Index of spd stage
    # @return [Integer]
    attr_accessor :spd_stage_index
    # Index of ats stage
    # @return [Integer]
    attr_accessor :ats_stage_index
    # Index of dfs stage
    # @return [Integer]
    attr_accessor :dfs_stage_index
    # Index of eva stage
    # @return [Integer]
    attr_accessor :eva_stage_index
    # Index of acc stage
    # @return [Integer]
    attr_accessor :acc_stage_index
    def initialize
    end
    # Convert the config to json
    def to_json(*)
    end
  end
  register(:stats, 'stats', :json, false, Stats)
  # Configuration of window
  #
  # Every window builder should be Array of integer like this
  #    ConstName = [middle_tile_x, middle_tile_y, middle_tile_width, middle_tile_height,
  #                 contents_offset_left, contents_offset_top, contents_offset_right, contents_offset_bottom]
  class Window
    # All message frames with their names
    # @return [Hash<Symbol => String>]
    attr_accessor :message_frames
    # All the window builder
    # @return [Hash<Symbol => Array>]
    attr_accessor :builders
    def initialize
    end
    # Get all the message frame filenames
    # @return [Array<String>]
    def message_frame_filenames
    end
    # Get all the message frame names
    # @return [Array<String>]
    def message_frame_names
    end
    # Convert the config to json
    def to_json(*)
    end
  end
  register(:window, 'window', :json, false, Window)
end
Graphics.on_start do
  RPG::Cache.load_windowskin
  windowskin_vd = RPG::Cache.instance_variable_get(:@windowskin_data)
  data = windowskin_vd&.read_data('_colors')
  color_image = data ? Image.new(data, true) : Image.new('graphics/windowskins/_colors.png')
  color_image.width.times do |i|
    Fonts.define_outline_color(i, color_image.get_pixel(i, 0))
    Fonts.define_fill_color(i, color_image.get_pixel(i, 1))
    Fonts.define_shadow_color(i, color_image.get_pixel(i, 2))
  end
end
module PFM
  # Module that help item to be used by returning an "extend_data" that every interface can understand
  #   Structure of the extend_data returned
  #     no_effect: opt Boolean # The item has no effect
  #     chen: opt Boolean # The stalker also called Prof. CHEN that tells you the item cannot be used there
  #     open_party: opt Boolean # If the item require the Party menu to be opened in selection mode
  #     on_creature_choice: opt Proc # The proc to check when the player select a Pokemon(parameter) (return a value usefull to the interface)
  #     on_creature_use: opt Proc # The proc executed on a Pokemon(parameter) when the item is used
  #     open_skill: opt Boolean # If the item require the Skill selection interface to be open
  #     open_skill_learn: opt Integer # ID of the skill to learn if the item require to Open the Skill learn interface
  #     on_skill_choice: opt Proc # Proc to call to validate the choice of the skill(parameter)
  #     on_skill_use: opt Proc # Proc to call when a skill(parameter) is validated and chosen
  #     on_use: opt Proc # The proc to call when the item is used.
  #     action_to_push: opt Proc # The proc to call to push the specific action when the item is used in battle
  #     stone_evolve: opt Boolean # If a Pokemon evolve by stone
  #     use_before_telling: opt Boolean # If :on_use proc is called before telling the item is used
  #     skill_message_id: opt Integer # ID of the message to show in the win_text in the Summary
  #
  # @author Nuri Yuri
  module ItemDescriptor
    # Sound played when a Pokemon levels up and when an item is used
    LVL_SOUND = ['audio/me/rosa_levelup', 100, 100]
    # Proc executed when there's no condition (returns true)
    NO_CONDITION = proc {true }
    # Common event condition procs to call before calling event (common_event_id => proc { conditions })
    COMMON_EVENT_CONDITIONS = Hash.new(NO_CONDITION)
    # Fallback for old users
    CommonEventConditions = COMMON_EVENT_CONDITIONS
    # No effect Hash descriptor
    NO_EFFECT = {no_effect: true}
    # You cannot use this item here Hash descriptor
    CHEN = {chen: true}
    # Stage boost method Symbol in PFM::Pokemon
    BOOST = %i[change_atk change_dfe change_spd change_ats change_dfs change_eva change_acc]
    # Message text id of the various item heals (index => text_id)
    BagStatesHeal = [116, 110, 111, 112, 120, 113, 116, 116, 110]
    # Message text id of the various EV change (index => text_id)
    EVStat = [134, 129, 130, 133, 131, 132]
    # Constant containing all the default extend_data
    # @return [Hash{ Class => Wrapper }]
    EXTEND_DATAS = Hash.new {Wrapper.new }
    # Constant containing all the chen prevention
    CHEN_PREVENTIONS = {}
    module_function
    # Describe an item with a Hash descriptor
    # @param item_id [Integer] ID of the item in the database
    # @return [Wrapper] the Wrapper helping to use the item
    def actions(item_id)
    end
    # Define an event condition
    # @param event_id [Integer] ID of the common event that will be called if the condition validates
    # @yieldreturn [Boolean] if the event can be called
    def define_event_condition(event_id, &block)
    end
    # Define a usage of item from the bag
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @param use_before_telling [Boolean] if the item should be used before showing the message
    # @yieldparam item [Studio::Item] item used
    # @yieldparam scene [GamePlay::Base]
    # @yieldreturn [:unused] if block returns :unused, the item is considered as not used and not consumed
    def define_bag_use(klass, use_before_telling = false, &block)
    end
    # Define a chen prevention for an item (It's not time to use this item)
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldreturn [Boolean] if chen tells it's not time for that!
    def define_chen_prevention(klass, &block)
    end
    # Define if an item can be used on a specific Pokemon
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldparam creature [PFM::Pokemon] creature that should be tested
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_creature_usability(klass, &block)
    end
    # Define the actions performed on a Pokemon on map
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldparam creature [PFM::Pokemon]
    # @yieldparam scene [GamePlay::Base]
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_creature_use(klass, &block)
    end
    # Define the actions performed on a Pokemon in battle
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldparam creature [PFM::Pokemon]
    # @yieldparam scene [Battle::Scene]
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_creature_battler_use(klass, &block)
    end
    # Define if an item can be used on a specific Move
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @param skill_message_id [Integer, nil] ID of the message shown in the summary UI
    # @yieldparam item [Studio::Item] item used
    # @yieldparam skill [PFM::Skill] skill that should be tested
    # @yieldparam scene [Battle::Scene]
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_move_usability(klass, skill_message_id = nil, &block)
    end
    # Define the actions of the item on a specific move on map
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldparam creature [PFM::Pokemon]
    # @yieldparam skill [PFM::Skill]
    # @yieldparam scene [Battle::Scene]
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_move_use(klass, &block)
    end
    # Define the actions of the item on a specific move in battle
    # @param klass [Class<Studio::Item>, Symbol] class or db_symbol of the item
    # @yieldparam item [Studio::Item] item used
    # @yieldparam creature [PFM::Pokemon]
    # @yieldparam skill [PFM::Skill]
    # @yieldparam scene [Battle::Scene]
    # @yieldreturn [Boolean] if the item can be used on the Pokemon
    def define_on_battle_move_use(klass, &block)
    end
    # Wrapper to make the item description more usefull
    class Wrapper
      # Get if the item has no effect
      # @return [Boolean]
      attr_accessor :no_effect
      # Get if the item should not be used there
      # @return [Boolean]
      attr_accessor :chen
      # Get if the item should open the party menu
      # @return [Boolean]
      attr_accessor :open_party
      # Get if the item should open the skill menu
      # @return [Boolean]
      attr_accessor :open_skill
      # Get the ID of the move that should be learnt if it should be learnt
      # @return [Integer, nil]
      attr_accessor :open_skill_learn
      # Get if the item is making a Pokemon evolve
      # @return [Boolean]
      attr_accessor :stone_evolve
      # Get if the item should be used before the usage message
      # @return [Boolean]
      attr_accessor :use_before_telling
      # Get the item bound to this wrapper
      # @return [Studio::Item]
      attr_accessor :item
      # Get the skill bound to the wrapper
      # @return [PFM::Skill]
      attr_reader :skill
      # Get the ID of the message that should be shown in the Summary UI
      # @return [Integer, nil]
      attr_accessor :skill_message_id
      # Register the on_creature_choice block
      attr_writer :on_creature_choice
      # Register the on_creature_use block
      attr_writer :on_creature_use
      # Register the on_skill_choice block
      attr_writer :on_skill_choice
      # Register the on_skill_use block
      attr_writer :on_skill_use
      # Register the on_use block
      attr_writer :on_use
      # Register the action_to_push block
      attr_writer :action_to_push
      # Void all regular block for battle usage
      def void_non_battle_block
      end
      # Tell if the wrapper has a Pokemon choice
      # @return [Boolean]
      def on_creature_choice?
      end
      # Call the on_creature_choice block
      # @param creature [PFM::Pokemon]
      # @param scene [GamePlay::Base]
      # @return [Boolean]
      def on_creature_choice(creature, scene)
      end
      # Call the on_creature_use block
      # @param creature [PFM::Pokemon]
      # @param scene [GamePlay::Base]
      def on_creature_use(creature, scene)
      end
      # Call the on_creature_choice block
      # @param skill [PFM::Skill]
      # @param scene [GamePlay::Base]
      # @return [Boolean]
      def on_skill_choice(skill, scene)
      end
      # Call the on_skill_use block
      # @param creature [PFM::Pokemon]
      # @param skill [PFM::Skill]
      # @param scene [GamePlay::Base]
      def on_skill_use(creature, skill, scene)
      end
      # Call the on_use block
      # @param scene [GamePlay::Base]
      def on_use(scene)
      end
      # Call the action_to_push block
      def execute_battle_action
      end
      # Bind the wrapper to a scene, creature & skill
      # @param scene [GamePlay::Base]
      # @param creature [PFM::Pokemon]
      # @param skill [PFM::Skill]
      def bind(scene, creature, skill = nil)
      end
    end
    define_chen_prevention(:sacred_ash) {$actors.none? { |creature| creature.dead? && !creature.egg? } }
    define_bag_use(:sacred_ash) do
      $actors.compact.each do |pkmn|
        next unless pkmn.hp <= 0
        pkmn.cure
        pkmn.hp = pkmn.max_hp
        pkmn.skills_set.compact.each { |j| j.pp = j.ppmax }
        $scene.display_message(parse_text(22, 115, PFM::Text::PKNICK[0] => pkmn.given_name))
      end
    end
    define_chen_prevention(:honey) {!$env.normal? || $env.grass? || $env.building? }
    define_bag_use(:honey) do
      next($scene.display_message(text_get(39, 7).clone)) unless $wild_battle.available?
      $scene.return_to_scene(::Scene_Map)
      $game_system.map_interpreter.launch_common_event(1)
    end
    define_chen_prevention(:ability_capsule) {$game_temp.in_battle }
    define_on_creature_usability(:ability_capsule) do |_item, creature|
      next(false) if creature.egg?
      next(false) if %i[zygarde greninja].include?(creature.db_symbol)
      next(false) if creature.db_symbol == :rockruff && creature.ability_db_symbol == :own_tempo
      next(false) if creature.data.abilities[0] == creature.data.abilities[1]
      next(false) if creature.ability_db_symbol == creature.data.abilities.last
      next(true)
    end
    define_on_creature_use(:ability_capsule) do |_item, creature, _scene|
      creature.ability_index = creature.ability_index.zero? ? 1 : 0
      creature.update_ability
      Audio.me_play(*LVL_SOUND)
      $scene.display_message_and_wait(parse_text_with_pokemon(19, 405, creature, PFM::Text::ABILITY[1] => creature.ability_name))
    end
    define_chen_prevention(:ability_patch) {$game_temp.in_battle }
    define_on_creature_usability(:ability_patch) do |_item, creature|
      next(false) if creature.egg?
      abilities = creature.data.abilities
      next(false) if abilities[0..1].all? { |ability| ability == abilities[2] }
      next(true)
    end
    define_on_creature_use(:ability_patch) do |_item, creature, _scene|
      creature.ability_index = creature.ability_db_symbol == creature.data.abilities.last ? 0 : 2
      creature.update_ability
      Audio.me_play(*LVL_SOUND)
      $scene.display_message_and_wait(parse_text_with_pokemon(19, 405, creature, PFM::Text::ABILITY[1] => creature.ability_name))
    end
    define_event_condition(6)
    define_event_condition(7)
    define_event_condition(11) do
      next(false) if $game_player.surfing?
      next($game_switches[Yuki::Sw::EV_Bicycle] || $game_switches[Yuki::Sw::Env_CanFly] || $game_switches[Yuki::Sw::Env_CanDig])
    end
    define_event_condition(13) {$game_switches[Yuki::Sw::Env_CanDig] }
    define_event_condition(14) {$game_switches[Yuki::Sw::Env_CanDig] }
    define_event_condition(19)
    define_event_condition(22) {Game_Character::SurfTag.include?($game_player.front_system_tag) }
    define_event_condition(23) {Game_Character::SurfTag.include?($game_player.front_system_tag) }
    define_event_condition(24) {Game_Character::SurfTag.include?($game_player.front_system_tag) }
    define_event_condition(33) do
      next(false) if $game_player.surfing?
      next($game_switches[Yuki::Sw::EV_AccroBike] || $game_switches[Yuki::Sw::Env_CanFly] || $game_switches[Yuki::Sw::Env_CanDig])
    end
  end
end
PFM::ItemDescriptor.define_bag_use(Studio::EventItem, true) do |item, scene|
  condition = PFM::ItemDescriptor::COMMON_EVENT_CONDITIONS[Studio::EventItem.from(item).event_id]
  if condition.call
    $game_temp.common_event_id = Studio::EventItem.from(item).event_id
  else
    scene.display_message_and_wait(parse_text(22, 43))
    next(:unused)
  end
end
PFM::ItemDescriptor.define_chen_prevention(Studio::FleeingItem) do
  next(!$game_temp.in_battle || $game_temp.trainer_battle || $game_switches[Yuki::Sw::BT_NoEscape])
end
PFM::ItemDescriptor.define_bag_use(Studio::FleeingItem, true) do |item, scene|
  GamePlay.bag_mixin.from(scene).battle_item_wrapper = PFM::ItemDescriptor.actions(item.id)
  $scene = scene.__last_scene
  scene.return_to_scene(Battle::Scene)
end
PFM::ItemDescriptor.define_bag_use(Studio::RepelItem, true) do |item, scene|
  if PFM.game_state.get_repel_count <= 0
    $game_temp.last_repel_used_id = item.id
    next(PFM.game_state.set_repel_count(Studio::RepelItem.from(item).repel_count))
  end
  scene.display_message_and_wait(parse_text(22, 47))
  next(:unused)
end
PFM::ItemDescriptor.define_chen_prevention(Studio::StoneItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::StoneItem) do |item, creature|
  next(false) if creature.egg?
  next(creature.evolve_check(:stone, item.db_symbol) && true)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::StoneItem) do |item, creature, scene|
  id, form = creature.evolve_check(:stone, item.db_symbol)
  GamePlay.make_pokemon_evolve(creature, id, form, true) do |evolve_scene|
    scene.running = false
    $bag.add_item(item.id, 1) unless evolve_scene.evolved
  end
end
PFM::ItemDescriptor.define_chen_prevention(Studio::TechItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::TechItem) do |item, creature|
  next(false) if creature.egg?
  next(creature.can_learn?(Studio::TechItem.from(item).move))
end
PFM::ItemDescriptor.define_chen_prevention(Studio::BallItem) do
  next(!$game_temp.in_battle)
end
PFM::ItemDescriptor.define_bag_use(Studio::BallItem, true) do |item, scene|
  battle_scene = scene.find_parent(Battle::Scene)
  if battle_scene.logic.alive_battlers(1).size > 1
    scene.display_message_and_wait(parse_text(20, 50))
    next(:unused)
  else
    if battle_scene.logic.alive_battlers(1)[0].effects.has?(:out_of_reach_base)
      scene.display_message_and_wait(parse_text(20, 52))
      next(:unused)
    else
      if battle_scene.player_actions.size >= 1
        scene.display_message_and_wait(parse_text(20, 53))
        next(:unused)
      else
        GamePlay.bag_mixin.from(scene).battle_item_wrapper = PFM::ItemDescriptor.actions(item.id)
        scene.return_to_scene(Battle::Scene)
      end
    end
  end
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::HealingItem) do |item, creature|
  next(false) if creature.egg?
  next((creature.dup.loyalty -= Studio::HealingItem.from(item).loyalty_malus) != creature.loyalty)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::HealingItem) do |item, creature|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::HealingItem) do |item, creature|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::ConstantHealItem) do |_, creature|
  next(false) if creature.dead?
  next(creature.hp < creature.max_hp)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::ConstantHealItem) do |item, creature, scene|
  original_hp = creature.hp
  creature.hp += Studio::ConstantHealItem.from(item).hp_count
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  diff = creature.hp - original_hp
  message = parse_text(22, 109, PFM::Text::PKNICK[0] => creature.given_name, PFM::Text::NUM3[1] => diff.to_s)
  scene.display_message_and_wait(message)
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::ConstantHealItem) do |item, creature, scene|
  battle_item = Studio::ConstantHealItem.from(item)
  creature.loyalty -= battle_item.loyalty_malus
  scene.logic.damage_handler.heal(creature, battle_item.hp_count, test_heal_block: false)
end
PFM::ItemDescriptor.define_chen_prevention(Studio::ExpGiveItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::ExpGiveItem) do |_item, creature|
  next(false) if creature.egg?
  next(creature.level < creature.max_level)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::ExpGiveItem) do |item, creature, scene|
  missing_exp_total = creature.exp_list[creature.max_level] - creature.exp
  max_candy_amount = missing_exp_total / Studio::ExpGiveItem.from(item).exp_count
  max_candy_amount += 1 if missing_exp_total % Studio::ExpGiveItem.from(item).exp_count != 0
  $game_temp.num_input_variable_id = Yuki::Var::EnteredNumber
  $game_temp.num_input_digits_max = $bag.item_quantity(item.db_symbol).to_s.size
  $game_temp.num_input_start = [$bag.item_quantity(item.db_symbol), max_candy_amount].min
  PFM::Text.set_item_name(item.exact_name)
  scene.display_message(parse_text(22, 198))
  index = $actors.find_index(creature)
  exp_count = Studio::ExpGiveItem.from(item).exp_count * $game_variables[Yuki::Var::EnteredNumber]
  $game_system.map_interpreter.give_exp(index, exp_count)
  $bag.remove_item(item.db_symbol, $game_variables[Yuki::Var::EnteredNumber] - 1)
  PFM::Text.reset_variables
end
PFM::ItemDescriptor.define_chen_prevention(Studio::LevelIncreaseItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::LevelIncreaseItem) do |_item, creature|
  next(false) if creature.egg?
  next((creature.level + 1) <= creature.max_level || creature.evolve_check(:level_up) != false)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::LevelIncreaseItem) do |item, creature, scene|
  max_amount = ((creature.max_level - creature.level) / Studio::LevelIncreaseItem.from(item).level_count).clamp(1, Float::INFINITY)
  $game_temp.num_input_variable_id = Yuki::Var::EnteredNumber
  $game_temp.num_input_digits_max = $bag.item_quantity(item.db_symbol).to_s.size
  $game_temp.num_input_start = [$bag.item_quantity(item.db_symbol), max_amount].min
  PFM::Text.set_item_name(item.exact_name)
  scene.display_message(parse_text(22, 198))
  level_amount = $game_variables[Yuki::Var::EnteredNumber] * Studio::LevelIncreaseItem.from(item).level_count
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus * $game_variables[Yuki::Var::EnteredNumber]
  level_amount.times do
    if creature.level_up
      list = creature.level_up_stat_refresh
      Audio.me_play(*PFM::ItemDescriptor::LVL_SOUND)
      message = parse_text(22, 128, PFM::Text::PKNICK[0] => creature.given_name, PFM::Text::NUM3[1] => creature.level.to_s)
      scene.display_message_and_wait(message)
      creature.level_up_window_call(list[0], list[1], 40_005)
      scene.message_window.update while scene.message_window && $game_temp.message_window_showing
      creature.check_skill_and_learn
    end
    id, form = creature.evolve_check(:level_up)
    GamePlay.make_pokemon_evolve(creature, id, form, false) if id
  end
  $bag.remove_item(item.db_symbol, $game_variables[Yuki::Var::EnteredNumber] - 1)
  PFM::Text.reset_variables
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::PPHealItem) do |_, creature|
  next(false) if creature.egg?
  moves = $game_temp.in_battle ? PFM::PokemonBattler.from(creature).moveset : creature.skills_set
  next(moves.any? { |move| move.pp < move.ppmax })
end
PFM::ItemDescriptor.define_on_move_usability(Studio::PPHealItem, 34) do |_, skill|
  next(skill.pp < skill.ppmax)
end
PFM::ItemDescriptor.define_on_move_use(Studio::PPHealItem) do |item, creature, skill, scene|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  skill.pp += Studio::PPHealItem.from(item).pp_count
  scene.display_message_and_wait(parse_text(22, 114, PFM::Text::MOVE[0] => skill.name))
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::PPHealItem) do |item, creature, skill, scene|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  skill.pp += Studio::PPHealItem.from(item).pp_count
  scene.display_message_and_wait(parse_text(22, 114, PFM::Text::MOVE[0] => skill.name))
end
PFM::ItemDescriptor.define_chen_prevention(Studio::PPIncreaseItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::PPIncreaseItem) do |_, creature|
  next(false) if creature.egg?
  moves = $game_temp.in_battle ? PFM::PokemonBattler.from(creature).moveset : creature.skills_set
  next(moves.any? { |move| (move.data.pp * 8 / 5) > move.ppmax })
end
PFM::ItemDescriptor.define_on_move_usability(Studio::PPIncreaseItem, 35) do |_, skill|
  next((skill.data.pp * 8 / 5) > skill.ppmax)
end
PFM::ItemDescriptor.define_on_move_use(Studio::PPIncreaseItem) do |item, creature, skill, scene|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  if Studio::PPIncreaseItem.from(item).is_max
    skill.ppmax = skill.data.pp * 8 / 5
  else
    skill.ppmax += skill.data.pp * 1 / 5
  end
  skill.pp += 99
  scene.display_message_and_wait(parse_text(22, 117, PFM::Text::MOVE[0] => skill.name))
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::RateHealItem) do |_, creature|
  next(false) if creature.dead?
  next(creature.hp < creature.max_hp)
end
PFM::ItemDescriptor.define_on_creature_use(Studio::RateHealItem) do |item, creature, scene|
  original_hp = creature.hp
  creature.hp += (creature.max_hp * Studio::RateHealItem.from(item).hp_rate).to_i
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  diff = creature.hp - original_hp
  message = parse_text(22, 109, PFM::Text::PKNICK[0] => creature.given_name, PFM::Text::NUM3[1] => diff.to_s)
  scene.display_message_and_wait(message)
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::RateHealItem) do |item, creature, scene|
  battle_item = Studio::RateHealItem.from(item)
  creature.loyalty -= battle_item.loyalty_malus
  scene.logic.damage_handler.heal(creature, (creature.max_hp * battle_item.hp_rate).to_i, test_heal_block: false)
end
PFM::ItemDescriptor.define_chen_prevention(Studio::StatBoostItem) do
  next(!$game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::StatBoostItem) do |item, creature|
  next(false) if creature.egg? || !PFM::PokemonBattler.from(creature).can_fight?
  next(creature.send(:"#{item.stat}_stage") < 6)
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::StatBoostItem) do |item, creature, scene|
  boost_item = Studio::StatBoostItem.from(item)
  creature.loyalty -= boost_item.loyalty_malus
  scene.logic.stat_change_handler.stat_change(boost_item.stat, boost_item.count, creature)
end
PFM::ItemDescriptor.define_chen_prevention(:dire_hit) do
  next(!$game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(:dire_hit) do |_item, creature|
  next(PFM::PokemonBattler.from(creature).can_fight?)
end
PFM::ItemDescriptor.define_on_creature_battler_use(:dire_hit) do |_item, creature, scene|
  pokemon = PFM::PokemonBattler.from(creature)
  if %i[dragon_cheer focus_energy].any? { |e| pokemon.effects.has?(e) }
    scene.display_message_and_wait(text_get(18, 70))
    pokemon.bag.add_item(:dire_hit, 1)
  else
    pokemon.effects.add(Battle::Effects::FocusEnergy.new(scene.logic, pokemon))
    scene.display_message_and_wait(parse_text_with_pokemon(19, 1047, pokemon))
  end
end
PFM::ItemDescriptor.define_chen_prevention(:guard_spec) do
  next(!$game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(:guard_spec) do |_item, creature|
  next(PFM::PokemonBattler.from(creature).can_fight?)
end
PFM::ItemDescriptor.define_on_creature_battler_use(:guard_spec) do |_item, creature, scene|
  pokemon = PFM::PokemonBattler.from(creature)
  if scene.logic.bank_effects[pokemon.bank].has?(:mist)
    scene.display_message_and_wait(text_get(18, 70))
    pokemon.bag.add_item(:guard_spec, 1)
  else
    scene.logic.bank_effects[pokemon.bank].add(Battle::Effects::Mist.new(scene.logic, pokemon.bank))
    scene.display_message_and_wait(parse_text(18, pokemon.bank == 0 ? 142 : 143))
  end
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::StatusHealItem) do |item, creature|
  next(false) if creature.egg?
  status_heal_item = Studio::StatusHealItem.from(item)
  confuse_check = $game_temp.in_battle && creature.confused? && status_heal_item.status_list.include?(:confusion)
  next(confuse_check || status_heal_item.status_id_list.include?(creature.status))
end
PFM::ItemDescriptor.define_on_creature_use(Studio::StatusHealItem) do |item, creature, scene|
  creature.loyalty -= Studio::StatusHealItem.from(item).loyalty_malus
  status = creature.status
  creature.status = 0
  message = parse_text(22, PFM::ItemDescriptor::BagStatesHeal[status], PFM::Text::PKNICK[0] => creature.given_name)
  scene.display_message_and_wait(message)
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::StatusHealItem) do |item, creature, scene|
  status_heal_item = Studio::StatusHealItem.from(item)
  creature.loyalty -= status_heal_item.loyalty_malus
  scene.logic.status_change_handler.status_change(:cure, creature) if status_heal_item.status_id_list.include?(creature.status)
  if status_heal_item.status_list.include?(:confusion) && creature.confused?
    scene.logic.status_change_handler.status_change(:confuse_cure, creature, message_overwrite: 351)
  end
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::AllPPHealItem) do |_, creature|
  next(false) if creature.egg?
  moves = $game_temp.in_battle ? PFM::PokemonBattler.from(creature).moveset : creature.skills_set
  next(moves.any? { |move| move.pp < move.ppmax })
end
PFM::ItemDescriptor.define_on_creature_use(Studio::AllPPHealItem) do |item, creature, scene|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  pp_count = Studio::AllPPHealItem.from(item).pp_count
  creature.skills_set.each { |skill| skill.pp += pp_count }
  scene.display_message_and_wait(parse_text(22, 114, PFM::Text::PKNICK[0] => creature.given_name))
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::AllPPHealItem) do |item, creature, scene|
  creature.loyalty -= Studio::HealingItem.from(item).loyalty_malus
  pp_count = Studio::AllPPHealItem.from(item).pp_count
  creature.moveset.each { |move| move.pp += pp_count }
  scene.display_message_and_wait(parse_text(22, 114, PFM::Text::PKNICK[0] => creature.given_name))
end
PFM::ItemDescriptor.define_chen_prevention(Studio::EVBoostItem) do
  next($game_temp.in_battle)
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::EVBoostItem) do |item, creature|
  next(false) if creature.egg?
  ev_boost = Studio::EVBoostItem.from(item)
  next(false) if creature.total_ev >= Configs.stats.max_total_ev && ev_boost.count > 0
  next(creature.send(:"ev_#{ev_boost.stat}") < Configs.stats.max_stat_ev) if ev_boost.count > 0
  next(creature.send(:"ev_#{ev_boost.stat}") > 0) if ev_boost.count < 0
end
PFM::ItemDescriptor.define_on_creature_use(Studio::EVBoostItem) do |item, creature, scene|
  boost_item = Studio::EVBoostItem.from(item)
  if boost_item.count > 0
    missing_ev_amount = [Configs.stats.max_stat_ev - creature.send(:"ev_#{boost_item.stat}"), Configs.stats.max_total_ev - creature.total_ev].min
  else
    missing_ev_amount = creature.send(:"ev_#{boost_item.stat}")
  end
  max_item_amount = missing_ev_amount / boost_item.count.abs
  max_item_amount += 1 if missing_ev_amount % boost_item.count != 0
  $game_temp.num_input_variable_id = Yuki::Var::EnteredNumber
  $game_temp.num_input_digits_max = $bag.item_quantity(item.db_symbol).to_s.size
  $game_temp.num_input_start = [$bag.item_quantity(item.db_symbol), max_item_amount].min
  PFM::Text.set_item_name(item.exact_name)
  scene.display_message(parse_text(22, 198))
  creature.loyalty -= boost_item.loyalty_malus * $game_variables[Yuki::Var::EnteredNumber]
  new_ev = (creature.send(:"ev_#{boost_item.stat}") + boost_item.count * $game_variables[Yuki::Var::EnteredNumber]).clamp(0, [Configs.stats.max_stat_ev, creature.send(:"ev_#{boost_item.stat}") + missing_ev_amount].min)
  creature.send(:"ev_#{boost_item.stat}=", new_ev)
  stat_name = text_get(22, Studio::EVBoostItem::STAT_NAME_TEXT_ID[boost_item.stat])
  message = parse_text(22, boost_item.count > 0 ? 118 : 136, PFM::Text::PKNICK[0] => creature.given_name, '[VAR EVSTAT(0001)]' => stat_name)
  scene.display_message_and_wait(message) unless $game_variables[Yuki::Var::EnteredNumber] == 0
  $bag.remove_item(item.db_symbol, $game_variables[Yuki::Var::EnteredNumber] - 1)
  PFM::Text.reset_variables
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::StatusConstantHealItem) do |item, creature|
  next(false) if creature.egg?
  heal_item = Studio::StatusConstantHealItem.from(item)
  states = heal_item.status_list
  include_death = states.include?(:death)
  next(false) if creature.dead? && !include_death
  next(false) if creature.alive? && include_death
  next(false) if $game_temp.in_battle && creature.dead? && include_death && PFM.game_state.nuzlocke.enabled?
  confuse_check = $game_temp.in_battle && creature.confused? && states.include?(:confusion)
  next(creature.hp < creature.max_hp || confuse_check || heal_item.status_id_list.include?(creature.status))
end
PFM::ItemDescriptor.define_on_creature_use(Studio::StatusConstantHealItem) do |item, creature, scene|
  original_hp = creature.hp
  heal_item = Studio::StatusConstantHealItem.from(item)
  creature.hp += heal_item.hp_count
  creature.loyalty -= heal_item.loyalty_malus
  diff = creature.hp - original_hp
  if diff != 0
    message = parse_text(22, 109, PFM::Text::PKNICK[0] => creature.given_name, PFM::Text::NUM3[1] => diff.to_s)
    scene.display_message_and_wait(message)
  end
  status = creature.status
  if status != 0 && heal_item.status_id_list.include?(status)
    creature.status = 0
    message = parse_text(22, PFM::ItemDescriptor::BagStatesHeal[status], PFM::Text::PKNICK[0] => creature.given_name)
    scene.display_message_and_wait(message)
  end
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::StatusConstantHealItem) do |item, creature, scene|
  battle_item = Studio::StatusConstantHealItem.from(item)
  creature.loyalty -= battle_item.loyalty_malus
  was_dead = creature.dead?
  scene.logic.damage_handler.heal(creature, battle_item.hp_count, test_heal_block: false)
  if was_dead && creature.position >= 0 && creature.position < scene.battle_info.vs_type
    scene.visual.battler_sprite(creature.bank, creature.position).go_in
    scene.visual.show_info_bar(creature)
  end
  scene.logic.status_change_handler.status_change(:cure, creature) if battle_item.status_id_list.include?(creature.status)
  if battle_item.status_list.include?(:confusion) && creature.confused?
    scene.logic.status_change_handler.status_change(:confuse_cure, creature, message_overwrite: 351)
  end
end
PFM::ItemDescriptor.define_on_creature_usability(Studio::StatusRateHealItem) do |item, creature|
  next(false) if creature.egg?
  heal_item = Studio::StatusRateHealItem.from(item)
  states = heal_item.status_list
  include_death = states.include?(:death)
  next(false) if creature.dead? && !include_death
  next(false) if creature.alive? && include_death
  next(false) if $game_temp.in_battle && creature.dead? && include_death && PFM.game_state.nuzlocke.enabled?
  confuse_check = $game_temp.in_battle && creature.confused? && states.include?(:confusion)
  next(creature.hp < creature.max_hp || confuse_check || heal_item.status_id_list.include?(creature.status))
end
PFM::ItemDescriptor.define_on_creature_use(Studio::StatusRateHealItem) do |item, creature, scene|
  original_hp = creature.hp
  heal_item = Studio::StatusRateHealItem.from(item)
  creature.hp += (creature.max_hp * heal_item.hp_rate).to_i
  creature.loyalty -= heal_item.loyalty_malus
  diff = creature.hp - original_hp
  if diff > 0
    message = parse_text(22, 109, PFM::Text::PKNICK[0] => creature.given_name, PFM::Text::NUM3[1] => diff.to_s)
    scene.display_message_and_wait(message)
  end
  status = creature.status
  if status != 0 && heal_item.status_id_list.include?(status)
    creature.status = 0
    message = parse_text(22, PFM::ItemDescriptor::BagStatesHeal[status], PFM::Text::PKNICK[0] => creature.given_name)
    scene.display_message_and_wait(message)
  end
end
PFM::ItemDescriptor.define_on_creature_battler_use(Studio::StatusRateHealItem) do |item, creature, scene|
  battle_item = Studio::StatusRateHealItem.from(item)
  creature.loyalty -= battle_item.loyalty_malus
  was_dead = creature.dead?
  scene.logic.damage_handler.heal(creature, (creature.max_hp * battle_item.hp_rate).to_i, test_heal_block: false)
  if was_dead && creature.position >= 0 && creature.position < scene.battle_info.vs_type
    scene.visual.battler_sprite(creature.bank, creature.position).go_in
    scene.visual.show_info_bar(creature)
  end
  scene.logic.status_change_handler.status_change(:cure, creature) if battle_item.status_id_list.include?(creature.status)
  if battle_item.status_list.include?(:confusion) && creature.confused?
    scene.logic.status_change_handler.status_change(:confuse_cure, creature, message_overwrite: 351)
  end
end
