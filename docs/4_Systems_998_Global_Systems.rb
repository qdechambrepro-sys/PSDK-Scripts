module PFM
  # Module holding all the logic about Honey Trees
  module HoneyTree
    # Maximum number of honney trees
    COUNT = 21
    # List of probability for each mon_index
    MON_INDEXES = [0...40, 40...60, 60...80, 80...90, 90...95, 95...100]
    # Probablity to get the last mon_index on the same tree
    LAST_MON_INDEX_CHANCES = 90
    # 2D List of shakes value (column -> chance -> nb_shakes)
    SHAKES_NUMBERS = [[], [0...20, 20...79, 79...99, 99...100], [0...1, 1...21, 21...96, 96...100], [0...1, 1...2, 2...7, 7...100]]
    # List of chance to get a specific column if the Tree is a Munchlax tree or not
    COLUMN_INDEXES = {false => [0...10, 10...80, 80...100], true => [0...9, 9...29, 29...99, 99...100]}
    # Time to wait before being able to fight a Pokemon (in seconds)
    WAIT_TO_BATTLE = 21_540
    # Time when the Pokemon leave the tree
    LEAVE_TREE_TIME = 86_340
    # List of Pokemon / Column
    POKEMON_LISTS = [[], %i[combee wurmple burmy cherubi aipom aipom], %i[burmy cherubi combee aipom aipom heracross], %i[munchlax munchlax munchlax munchlax munchlax munchlax]]
    # Level range of the battles
    LEVEL_RANGE = 5..15
    module_function
    # Return the honney tree info
    # @param id [Integer] ID of the tree
    # @return [Hash{ Symbol => Integer}]
    def get(id)
    end
    # Tell if a tree has a Pokemon in it
    # @param id [Integer] ID of the tree
    # @return [Boolean]
    def has_pokemon?(id)
    end
    # Tell if the tree is ready to battle
    # @param id [Integer] ID of the tree
    # @return [Boolean]
    def can_battle?(id)
    end
    # Slather a tree
    # @param id [Integer] ID of the tree
    def slather(id)
    end
    # Return the ID of the last tree
    # @return [Integer]
    def last_tree_id
    end
    # Set the ID of the last tree
    # @param id [Integer] ID of the tree
    def last_tree_id=(id)
    end
    # Return the last index of the choosen mon in the table
    # @return [Integer]
    def last_mon_index
    end
    # Set the ID of the last choosen mon in the table
    # @param index [Integer]
    def last_mon_index=(index)
    end
    # Tell if the tree is a munchlax tree or not
    # @param id [Integer] ID of the tree
    # @return [Boolean]
    def munchlax?(id)
    end
    class << self
      private
      # Get the new column index
      # @param id [Integer] ID of the tree
      # @return [Integer]
      def column(id)
      end
      # Return the index of the current mon
      # @param id [Integer] ID of the tree
      # @return [Integer]
      def mon_index(id)
      end
      # Return the number of shakes
      # @param column [Integer] column where to get the shake value
      # @return [Integer]
      def shakes(column)
      end
    end
  end
  class GameState
    # Access to the honey tree information
    # @return [Array<Hash{ Symbol => Integer}>]
    attr_reader :honey_trees
    on_player_initialize(:honey_trees) {@honey_trees = [] }
    on_expand_global_variables(:honey_trees) {@honey_trees ||= [] }
  end
end
Util::SystemMessage::MESSAGES[:honey_tree_slather] = proc {'Do you want to slather this tree with honey?' }
Util::SystemMessage::MESSAGES[:honey_tree_sweet_scent] = proc {'There is a sweet scent in the air...' }
Util::SystemMessage::MESSAGES[:honey_tree_slathered] = proc {'The bark is slathered with Honey...' }
class Interpreter
  # Function calling the honey tree event
  # @param id [Integer] ID of the honey tree
  def honey_tree_event(id)
  end
  private
  # Function that asks if you want to slaghter
  # @param id [Integer] ID of the honey tree
  def honey_tree_slather_event(id)
  end
end
