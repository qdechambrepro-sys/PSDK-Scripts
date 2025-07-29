module PFM
  # The quest management
  #
  # The main object is stored in $quests and PFM.game_state.quests
  class Quests
    # Tell if the system should check the signal when we test finished?(id) or failed?(id)
    AUTO_CHECK_SIGNAL_ON_TEST = true
    # Tell if the system should check the signal when we check the quest termination
    AUTO_CHECK_SIGNAL_ON_ALL_OBJECTIVE_VALIDATED = false
    # The list of active_quests
    # @return [Hash<Integer => Quest>]
    attr_accessor :active_quests
    # The list of finished_quests
    # @return [Hash<Integer => Quest>]
    attr_accessor :finished_quests
    # The list of failed_quests
    # @return [Hash<Integer => Quest>]
    attr_accessor :failed_quests
    # The signals that inform the game what quest started or has been finished
    # @return [Hash<start: Array<Integer>, finish: Array<Integer>, failed: Array<Integer>>]
    attr_accessor :signal
    # Create a new Quest management object
    def initialize
    end
    # Start a new quest if possible
    # @param quest_id [Integer] the ID of the quest in the database
    # @return [Boolean] if the quest started
    def start(quest_id)
    end
    # Return an active quest by its id
    # @param quest_id [Integer]
    # @return [Quest]
    def active_quest(quest_id)
    end
    # Return a finished quest by its id
    # @param quest_id [Integer]
    # @return [Quest]
    def finished_quest(quest_id)
    end
    # Fail a quest
    # Return a failed quest by its id
    # @param quest_id [Integer]
    # @return [Quest]
    def fail_quest(quest_id)
    end
    def failed_quest(quest_id)
    end
    # Show a goal of a quest
    # @param quest_id [Integer] the ID of the quest in the database
    # @param goal_index [Integer] the index of the goal in the goal order
    def show_goal(quest_id, goal_index)
    end
    # Tell if a goal is shown or not
    # @param quest_id [Integer] the ID of the quest in the database
    # @param goal_index [Integer] the index of the goal in the goal order
    # @return [Boolean]
    def goal_shown?(quest_id, goal_index)
    end
    # Get the goal data index (if array like items / speak_to return the index of the goal in the array info from
    # data/quest data)
    # @param quest_id [Integer] the ID of the quest in the database
    # @param goal_index [Integer] the index of the goal in the goal order
    # @return [Integer]
    def get_goal_data_index(quest_id, goal_index)
    end
    # Inform the manager that a NPC has been beaten
    # @param quest_id [Integer] the ID of the quest in the database
    # @param npc_name_index [Integer] the index of the name of the NPC in the quest data
    # @return [Boolean] if the quest has been updated
    def beat_npc(quest_id, npc_name_index)
    end
    # Inform the manager that a NPC has been spoken to
    # @param quest_id [Integer] the ID of the quest in the database
    # @param npc_name_index [Integer] the index of the name of the NPC in the quest data
    # @return [Boolean] if the quest has been updated
    def speak_to_npc(quest_id, npc_name_index)
    end
    # Inform the manager that an item has been added to the bag of the Player
    # @param item_id [Integer] ID of the item in the database
    # @param nb [Integer] number of item to add
    def add_item(item_id, nb = 1)
    end
    # Inform the manager that a Pokemon has been beaten
    # @param pokemon_symbol [Symbol] db_symbol of the Pokemon in the database
    def beat_pokemon(pokemon_symbol)
    end
    # Inform the manager that a Pokemon has been captured
    # @param pokemon [PFM::Pokemon] the Pokemon captured
    def catch_pokemon(pokemon)
    end
    # Inform the manager that a Pokemon has been seen
    # @param pokemon_symbol [Symbol] db_symbol of the Pokemon in the database
    def see_pokemon(pokemon_symbol)
    end
    # Inform the manager an egg has been found
    def egg_found
    end
    alias get_egg egg_found
    # Inform the manager an egg has hatched
    def hatch_egg
    end
    # Tell the quest it has been seen by the player
    # @param quest_id [Integer/Symbol] ID or db_symbol of the quest in the database
    # @return [Boolean] if the quest wasn't already seen by the player
    def seen_by_player(quest_id)
    end
    # Checks if a quest is new
    #
    # @param quest_id [Integer/Symbol] ID or db_symbol of the quest in the database
    # @return [Boolean] true if the quest has not been seen, false otherwise
    def new?(quest_id)
    end
    # Completes a custom objective for a given quest.
    #
    # @param quest_id [Integer/Symbol] The ID or db_symbol of the quest in the database.
    # @param objective_nb [Integer] The number of the objective to complete.
    #
    # @return [Boolean] True if the objective was completed successfully, false otherwise.
    def complete_custom_objective(quest_id, objective_nb)
    end
    # Checks if there are any quests that have started or finished.
    # If there are, it displays the quest information and updates the quest status.
    def check_up_signal
    end
    # Check if a quest is done or not
    # @param quest_id [Integer] ID of the quest in the database
    def check_quest(quest_id)
    end
    # Is a quest finished ?
    # @param quest_id [Integer] ID of the quest in the database
    # @return [Boolean]
    def finished?(quest_id)
    end
    # Is a quest failed ?
    # @param quest_id [Integer] ID of the quest in the database
    # @return [Boolean]
    def failed?(quest_id)
    end
    # Get the earnings of a quest
    # @param quest_id [Integer] ID of the quest in the database
    # @return [Boolean] if the earning were givent to the player
    def get_earnings(quest_id)
    end
    # Does the earning of a quest has been taken
    # @param quest_id [Integer] ID of the quest in the database
    def earnings_got?(quest_id)
    end
    # Import the quest data from dot 24 version of PSDK
    def import_from_dot24
    end
    # Update teh quest data for Studio
    def update_quest_data_for_studio
    end
    private
    # Convert a quest from .24 to .25
    # @param id [Integer] ID of the quest
    # @param quest [Hash]
    # @return [PFM::Quests::Quest]
    def convert_quest_from_dot24_to_dot25(id, quest)
    end
    # Convert a quest for Studio
    # @param id [Integer] ID of the quest
    # @param quest [PFM::Quests::Quest]
    def convert_quest_for_studio(id, quest)
    end
    # Transform keys in quest data hash
    # @param data [Hash] the data hash to update
    # @param type [Symbol] the objective type (:pokemon, :item)
    def transform_keys_in_hash(data, type = :pokemon)
    end
    # Import data from ID like objective
    # @param objectives [Array<Studio::Quest::Objective>]
    # @param quest [Hash] old quest
    # @param new_quest [PFM::Quests::Quest] new quest
    # @param test_method_name [Symbol] test method name of the objective
    # @param new_key [Symbol] new symbol key for the objective in new quest
    # @param old_key [Symbol] old symbol key for the objective in old quest
    def import_data_id_like_objective(objectives, quest, new_quest, test_method_name, new_key, old_key)
    end
    # Give a specific earning
    # @param earning [Hash]
    def give_earning(earning)
    end
    # Show the new/finished quest info
    # @param names [Array<String>]
    # @param quest_status [Symbol] status of quest (:new, :completed, :failed)
    def show_quest_inform(names, quest_status)
    end
    public
    # Class describing a running quest
    class Quest
      # Get the quest id
      # @return [Integer]
      attr_reader :quest_id
      # Create a new quest
      # @param quest_id [Integer] ID of the quest
      def initialize(quest_id)
      end
      # Get a specific data information
      # @param path [Array<Symbol, Integer>] path used to obtain the data
      # @param default [Object] default value
      # @return [Object, default]
      def data_get(*path, default)
      end
      # Set a specific data information
      # @param path [Array<Symbol, Integer>] path used to obtain the data
      # @param value [Object]
      def data_set(*path, value)
      end
      # Test if the quest has a specific kind of objective
      # @param objective_method_name [Symbol] name of the method to call to validate the objective
      # @param args [Array] double check to ensure the arguments match the test
      # @return [Boolean]
      def objective?(objective_method_name, *args)
      end
      # Test if a quest has a specific custom objective.
      #
      # @param objective_method_name [Symbol] The name of the method to call to validate the objective.
      # @param objective_nb [Integer] The number of the objective to test.
      #
      # @return [Boolean] True if the quest has the custom objective, false otherwise.
      def custom_objective?(objective_method_name, objective_nb)
      end
      # Distribute the earning of the quest
      def distribute_earnings
      end
      # Tell if all the objective of the quest are finished
      # @return [Boolean]
      def finished?
      end
      # Marks the quest as seen
      def checked_by_player
      end
      # Get the list of objective texts with their validation state
      # @return [Array<Array(String, Boolean)>]
      # @note Does not return text of hidden objectives
      def objective_text_list
      end
      # Check each specific pokemon criterion in catch_pokemon
      # @param pkm [Hash, Integer] the criteria of the Pokemon
      #
      #   The criteria are :
      #     nature: opt Integer # ID of the nature of the Pokemon
      #     type: opt Integer # One required type id
      #     min_level: opt Integer # The minimum level the Pokemon should have
      #     max_level: opt Integer # The maximum level the Pokemon should have
      #     level: opt Integer # The level the Pokemon must be
      # @param pokemon [PFM::Pokemon] the Pokemon that should be check with the criteria
      # @return [Boolean] if the Pokemon check the criteria
      def objective_catch_pokemon_test(pkm, pokemon)
      end
      class << self
        # Get Pokémon from data
        # @param data [Integer, Symbol, Hash, Studio::Group::Encounter] data of the Pokémon to give
        # @param level [Integer] The level of the Pokémon (only used if the data is an Integer or a Symbol)
        def pokemon_from_data(data, level)
        end
      end
      private
      # Test if the objective speak to is validated
      # @param index [Integer] index of the npc
      # @param _name [String] name of the npc (ignored)
      # @return [Boolean]
      def objective_speak_to(index, _name)
      end
      # Get the text related to the speak to objective
      # @param _index [Integer] index of the npc (ignored)
      # @param name [String] name of the npc
      # @return [String]
      def text_speak_to(_index, name)
      end
      # Test if the objective obtain item is validated
      # @param item_symbol [Integer] db_symbol of the item in the database
      # @param amount [Integer] number of item to obtain
      # @return [Boolean]
      def objective_obtain_item(item_symbol, amount)
      end
      # Text of the obtain item objective
      # @param item_symbol [Integer] db_symbol of the item in the database
      # @param amount [Integer] number of item to obtain
      # @return [String]
      def text_obtain_item(item_symbol, amount)
      end
      # Test if the objective see pokemon is validated
      # @param pokemon_symbol [Symbol] db_symbol of the pokemon to see
      # @param amount [Integer] number of pokemon to see
      # @return [Boolean]
      def objective_see_pokemon(pokemon_symbol, amount = 1)
      end
      # Text of the see pokemon objective
      # @param pokemon_symbol [Symbol] db_symbol of the pokemon to see
      # @param amount [Integer] number of pokemon to see
      # @return [String]
      def text_see_pokemon(pokemon_symbol, amount = 1)
      end
      # Test if the beat pokemon objective is validated
      # @param pokemon_symbol [Symbol] db_symbol of the pokemon to beat
      # @param amount [Integer] number of pokemon to beat
      # @return [Boolean]
      def objective_beat_pokemon(pokemon_symbol, amount)
      end
      # Text of the beat pokemon objective
      # @param pokemon_symbol [Symbol] db_symbol of the pokemon to beat
      # @param amount [Integer] number of pokemon to beat
      # @return [String]
      def text_beat_pokemon(pokemon_symbol, amount)
      end
      # Test if the catch pokemon objective is validated
      # @param pokemon_data [Hash] data of the pokemon to catch
      # @param amount [Integer] number of pokemon to beat
      # @return [Boolean]
      def objective_catch_pokemon(pokemon_data, amount)
      end
      # Text of the catch pokemon objective
      # @param pokemon_data [Integer] data of the pokemon to beat
      # @param amount [Integer] number of pokemon to beat
      # @return [String]
      def text_catch_pokemon(pokemon_data, amount)
      end
      # Get the exact text for the name of the caught pokemon
      # @param data [Integer, Hash]
      # @return [String]
      def text_catch_pokemon_name(data)
      end
      # Test if the beat NPC objective is validated
      # @param index [Integer] index of the npc
      # @param _name [String] name of the npc (ignored)
      # @param amount [Integer] number of time the npc should be beaten
      # @return [Boolean]
      def objective_beat_npc(index, _name, amount)
      end
      # Text of the beat NPC objective
      # @param index [Integer] index of the npc
      # @param name [String] name of the npc
      # @param amount [Integer] number of time the npc should be beaten
      # @return [String]
      def text_beat_npc(index, name, amount)
      end
      # Test if the obtain egg objective is validated
      # @param amount [Integer] amount of egg to obtain
      # @return [Boolean]
      def objective_obtain_egg(amount)
      end
      # Text of the obtain egg objective
      # @param amount [Integer] amount of egg to obtain
      # @return [Boolean]
      def text_obtain_egg(amount)
      end
      # Test if the hatch egg objective is validated
      # @param unk [nil] ???
      # @param amount [Integer] amount of egg to obtain
      # @return [Boolean]
      def objective_hatch_egg(unk, amount)
      end
      # Text of the hatch egg objective
      # @param unk [nil] ???
      # @param amount [Integer] amount of egg to obtain
      # @return [Boolean]
      def text_hatch_egg(unk, amount)
      end
      # Getting money from a quest
      # @param amount [Integer] amount of money gotten
      def earning_money(amount)
      end
      # Earning money text
      # @param amount [Integer] amount of money gotten
      # @return [String]
      def text_earn_money(amount)
      end
      # Getting item from a quest
      # @param item_id [Integer, Symbol] ID of the item to give
      # @param amount [Integer] number of item to give
      def earning_item(item_id, amount)
      end
      # Earning item text
      # @param item_id [Integer, Symbol] ID of the item to give
      # @param amount [Integer] number of item to give
      def text_earn_item(item_id, amount)
      end
      # Getting Pokemon from a quest
      # @param data [Integer, Symbol, Hash, Studio::Group::Encounter] data of the Pokémon to give
      def earning_pokemon(data)
      end
      # Earning Pokemon text
      # @param data [Integer, Symbol, Hash] data of the Pokémon to give
      def text_earn_pokemon(data)
      end
      # Getting egg from a quest
      # @param data [Integer, Symbol, Hash, Studio::Group::Encounter] data of the egg to give
      def earning_egg(data)
      end
      # Earning egg text
      # @param data [Integer, Symbol, Hash] data of the egg to give
      def text_earn_egg(data)
      end
      # Returns the custom objective status for the given index.
      #
      # @param index [Integer] The index of the custom objective.
      # @param text_id [Integer] (unused) index of the text
      # @return [Boolean] The status of the custom objective.
      def objective_custom(index, text_id)
      end
      # Custom objective text
      # @param index [Integer] (unused) The index of the custom objective.
      # @param text_id [Integer] index of the text
      # @return [String] The text of the custom objective.
      def text_custom(index, text_id)
      end
    end
  end
  class GameState
    # The player quests informations
    # @return [PFM::Quests]
    attr_accessor :quests
    safe_code('Setup Quest in GameState') do
      on_player_initialize(:quests) {@quests = PFM::Quests.new }
      on_expand_global_variables(:quests) do
        $quests = @quests
      end
    end
  end
end
module UI
  module Quest
    # Scrollbar UI element for quest
    class ScrollBar < SpriteStack
      # @return [Integer] current index of the scrollbar
      attr_reader :index
      # @return [Integer] number of possible indexes
      attr_reader :max_index
      # Number of pixel the scrollbar use to move the button
      HEIGHT = 153
      # Base Y for the scrollbar
      BASE_Y = 38
      # Create a new scrollbar
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the current index of the scrollbar
      # @param value [Integer] the new index
      def index=(value)
      end
      # Set the number of possible index
      # @param value [Integer] the new max index
      def max_index=(value)
      end
    end
    # Arrow telling which item is selected
    class Arrow < Sprite
      # Create a new arrow
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the arrow animation
      def update
      end
      private
      # Initialize the sprite
      def init_sprite
      end
      # Return the coordinate of the sprite
      # @return [Array<Integer>]
      def coordinates
      end
      # Return the name of the sprite
      # @return [String]
      def image_name
      end
      # Set the looped animation of the arrow
      def set_animation
      end
    end
    # Quest Button UI element
    class QuestButton < SpriteStack
      attr_accessor :hidden
      # Return the quest linked to this button
      # @return PFM::Quests::Quest
      attr_reader :quest
      # Initialize the QuestButton component
      # @param viewport [Viewport]
      # @param x [Integer]
      # @param y [Integer]
      # @param quest [PFM::Quests::Quest]
      # @param status [Symbol] if the quest is a primary, a secondary, or a finished quest
      def initialize(viewport, x, y, quest, status)
      end
      # Get the animation corresponding to the mode the button switches in
      # @param mode [Symbol]
      # @return [Yuki::Animation::ScalarAnimation]
      def change_mode(mode)
      end
      # Reload all sub-component with a new quest
      # @param quest [PFM::Quests::Quest]
      def quest=(quest)
      end
      private
      def create_frame
      end
      def create_title
      end
      # Get the animation for when the button is closing
      # @return [Yuki::Animation::ScalarAnimation]
      def compacting_animation
      end
      # Get the animation for when the button is opening
      # @return [Yuki::Animation::ScalarAnimation]
      def opening_animation
      end
      # Get the right filepath for the frame
      # @return [String]
      def frame_filepath
      end
      # Return the data for the current quest stocked
      # @return [Studio::Quest]
      def quest_data
      end
    end
    # Reward Screen composition
    class RewardScreen < SpriteStack
      # Coordinate of all the reward buttons
      REWARD_COORDINATE = [[3, 1], [137, 1], [3, 36], [137, 36]]
      # Initialize the RewardScreen component
      # @param viewport [Viewport]
      # @param x [Integer]
      # @param y [Integer]
      def initialize(viewport, x, y)
      end
      # Scroll the rewards if there's more than 4 rewards
      # @param direction [Symbol] :left of :right
      def scroll_rewards(direction)
      end
      # Reload all sub-component with a new quest
      # @param quest [PFM::Quests::Quest]
      def quest=(quest)
      end
      private
      def create_prize_back
      end
      def create_rewards
      end
      # Regeneration procedure of the rewards
      # @param bool [Boolean] if RewardScreen should be visible afterward
      def regenerate_rewards(bool = false)
      end
      # Return the data for the current quest stocked
      # @return [Studio::Quest]
      def quest_data
      end
    end
    # Reward button UI element
    class RewardButton < SpriteStack
      # Create the RewardButton
      # @param viewport [Viewport]
      # @param x [Integer]
      # @param y [Integer]
      # @param reward [Studio::Quest::Earning, nil]
      def initialize(viewport, x, y, reward)
      end
      private
      def create_frame
      end
      # Determine the reward and set the right text and icons
      def determine_reward
      end
      def create_icon
      end
      def create_reward_name
      end
      def create_reward_quantity
      end
      # Hash defining how the reward should be created if it's money
      # @return [Hash]
      def earning_money
      end
      # Hash defining how the reward should be created if it's an item
      # @return [Hash]
      def earning_item
      end
      # Hash defining how the reward should be created if it's a Pokemon
      # @return [Hash]
      def earning_pokemon
      end
      # Hash defining how the reward should be created if it's a egg
      # @return [Hash]
      def earning_egg
      end
    end
    # UI element displaying a quest category
    class CategoryDisplay < SpriteStack
      # All the category text getters
      TEXT_CATEGORY = {primary: [:ext_text, 9006, 5], secondary: [:ext_text, 9006, 6], finished: [:ext_text, 9006, 7], failed: [:ext_text, 9006, 9]}
      # Initialize the QuestButton component
      # @param viewport [Viewport]
      # @param category [Symbol] the initial category the player spawns in (here for future compability)
      def initialize(viewport, category)
      end
      # Update the category text depending on the new category
      # @param category [Symbol]
      def update_category_text(category)
      end
      private
      def create_frame
      end
      def create_category_text
      end
      def create_arrow_frames
      end
      def coordinates
      end
      def text_coordinates
      end
      # Update the states of the arrows according to current category
      def update_arrows
      end
    end
    # Frame UI element for quests
    class QuestFrame < Sprite
      # Name of the file holding the quest frame
      FILENAME = 'quest/frame'
      # Initialize the graphism for the shop banner
      # @param viewport [Viewport] viewport in which the Sprite will be displayed
      def initialize(viewport)
      end
    end
    # UI element listing the quests
    class QuestList < SpriteStack
      # Number of buttons generated
      NB_QUEST_BUTTON = 7
      # Offset between each button
      BUTTON_OFFSET = 28
      # Base X coordinate
      BASE_X = 19
      # Base Y coordinate
      BASE_Y = 41
      # @return [Integer] index of the current active item
      attr_reader :index
      # @return [Array<QuestButton>]
      attr_reader :buttons
      # @return [Symbol] the pace of the timing (:slow, :medium, :fast)
      attr_writer :timing
      # Create a new QuestList
      # @param viewport [Viewport] viewport in which the SpriteStack will be displayed
      # @param quest_hash [Hash] the hash containing the quests
      # @param category [Symbol] the current category the UI spawns in
      def initialize(viewport, quest_hash, category)
      end
      # Return the number of buttons registered in the stack
      # @return [Integer]
      def number_of_buttons
      end
      # Set the current active item index
      # @param index [Integer]
      def index=(index)
      end
      # Move all the buttons up
      def move_up
      end
      # Move all the buttons down
      def move_down
      end
      # Tell if the current index is the same as the last quest for this category
      def last_index?
      end
      # Change the right button mode and return the animation
      # @param mode [Symbol]
      # @return [Yuki::Animation::ScalarAnimation]
      def change_mode(mode)
      end
      private
      def create_quest_buttons
      end
      # Hash that contains each timing for the scrolling
      # @return [Hash<Float>]
      TIMING = {slow: 0.25, medium: 0.15, fast: 0.05}
      # Return the right timing for animations
      # @return [Float]
      def timing
      end
      # Move down animation (when the player press the UP KEY)
      # @return Yuki::Animation::TimedAnimation
      def move_down_animation
      end
      # Move up animation
      # @return Yuki::Animation::TimedAnimation
      def move_up_animation
      end
      # Return the start index of the list
      # @return [Integer]
      def start_index
      end
    end
    # UI element showing the object list
    class ObjectiveList < SpriteStack
      # Initialize the ObjectiveList component
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Update the text depending on the forwarded data
      # @param data [Array<Array<String, Boolean>>]
      def update_text(data)
      end
      # Scroll the text in the right direction if there's more than 4 objectives
      # @param direction [Symbol] :UP or :DOWN
      def scroll_text(direction)
      end
      private
      def create_text
      end
      def create_arrows
      end
      # Update the text arrows depending on the current position of the text
      def update_arrows
      end
      def coordinates
      end
    end
    # UI Composition of the quest scene
    class Composition < SpriteStack
      # Get the scrollbar element
      # @return [UI::Quest::ScrollBar]
      attr_accessor :scrollbar
      # Get the current state of the button
      # @return [Symbol]
      attr_accessor :button_state
      # Create the Composition of the scene
      # @param viewport [Viewport]
      # @param sub_viewport [Viewport]
      # @param sub_viewport2 [Viewport]
      # @param quests [PFM::Quests]
      def initialize(viewport, sub_viewport, sub_viewport2, quests)
      end
      # Update all animations
      def update
      end
      # Tells if all animations are done
      # @return [Boolean]
      def done?
      end
      # Update the current category and launch the corresponding procedure
      # @param new_category [Symbol]
      def update_category(new_category)
      end
      # Get the current QuestList index
      # @return [Integer]
      def index
      end
      # Input the direction of the scrolling
      # @param direction [Symbol]
      # @param timing [Symbol] the timing of the scrolling
      def input_direction(direction, timing = :slow)
      end
      # Change the mode of the first button
      # @param mode [Symbol]
      def change_mode_quest(mode)
      end
      # Change the state in the deployed mode
      # @param mode [Symbol]
      def change_deployed_mode(mode)
      end
      # Swap through the rewards depending on the direction
      # @param direction [Symbol]
      def swap_rewards(direction)
      end
      # Scroll through the objective list depending on the direction
      # @param direction [Symbol]
      def scroll_objective_list(direction)
      end
      # Get the current QuestList
      # @return [QuestList, nil]
      def current_list
      end
      private
      def create_frame
      end
      def create_arrow
      end
      def create_category_window
      end
      def create_scrollbar
      end
      def create_quest_list
      end
      def create_quest_description
      end
      def update_quest_description
      end
      def create_quest_current_objective
      end
      def update_quest_current_objective
      end
      def create_quest_rewards
      end
      def update_quest_rewards
      end
      def create_quest_objective_list
      end
      def update_quest_objective_list
      end
      # Engage the swapping between old and new category
      # @param old_category [Symbol]
      def swap_lists(old_category)
      end
      # The timing of the animations
      # @return [Float]
      TIMING = 0.5
      # Return the animation for the list swapping
      # @param old_category [Symbol]
      # @param direction [Symbol] the direction of the swapping
      # @return [Yuki::Animation::TimedAnimation]
      def swap_list_animation(old_category, direction)
      end
      # Update the maximum index of the scrollbar
      def update_max_index_scrollbar
      end
      # Update the scrollbar's current index
      def update_scrollbar
      end
      # Update the visible attribute of arrow depending on if there's quest in a category or not
      def update_arrow
      end
      # Move the list in the given direction at the given timing
      # @param direction [Symbol]
      # @param timing [Symbol]
      def move_list(direction, timing)
      end
      # Reload all components involved in the deployed mode
      def reload_deployed_components
      end
    end
  end
  # UI element shown on the screen to inform the player a quest was started, failed or finished
  class QuestInformer < SpriteStack
    # Name of the ME to play
    ME_TO_PLAY = 'audio/me/rosa_keyitemobtained'
    # Base Y of the informer
    BASE_Y = 34
    # Offset Y between each informer
    OFFSET_Y = 24
    # Offset X between the two textes
    OFFSET_TEXT_X = 4
    # Lenght of a transition
    TRANSITION_LENGHT = 30
    # Lenght of the text move
    TEXT_MOVE_LENGHT = 30
    # Time the player has to read the text
    TEXT_REMAIN_LENGHT = 90
    # Create a new quest informer UI
    # @param viewport [Viewport]
    # @param name [String] Name of the quest
    # @param quest_status [Symbol] status of quest (:new, :completed, :failed)
    # @param index [Integer] index of the quest
    def initialize(viewport, name, quest_status, index)
    end
    # Update the animation for the quest informer
    def update
    end
    # Tell if the animation is finished
    def done?
    end
    private
    # Play the Quest got sound
    # @param index [Integer]
    def play_sound(index)
    end
  end
end
Graphics.on_start do
  UI::QuestInformer.class_eval do
    const_set :PHASE2, UI::QuestInformer::TRANSITION_LENGHT + UI::QuestInformer::TEXT_MOVE_LENGHT
    const_set :PHASE3, UI::QuestInformer::PHASE2 + UI::QuestInformer::TEXT_REMAIN_LENGHT
    const_set :PHASE_END, UI::QuestInformer::PHASE3 + UI::QuestInformer::TRANSITION_LENGHT
  end
end
module GamePlay
  class QuestUI < BaseCleanUpdate::FrameBalanced
    # List of the categories of the quests
    # @return [Array<Symbol>]
    CATEGORIES = %i[primary secondary finished failed]
    # Initialize the whole Quest UI
    # @param quests [PFM::Quests] the quests to send to the Quest UI
    def initialize(quests = PFM.game_state.quests)
    end
    def update_graphics
    end
    private
    def create_graphics
    end
    def create_viewport
    end
    def create_base_ui
    end
    def button_texts
    end
    # Return the text for the A button
    # @return [String]
    def a_button_text
    end
    # Return the text for the B button
    # @return [String]
    def b_button_text
    end
    # Return the text for the X button
    # @return [String]
    def x_button_text
    end
    def create_composition
    end
    # Tell if the first button is currently deployed
    # @return [Boolean]
    def deployed?
    end
    # Commute the variable telling if the first button is compacted or deployed
    def commute_quest_deployed
    end
    public
    private
    # Update the text of the A button depending on if the quests are deployed or not
    def update_a_button_text
    end
    # Update the text of the B button depending on if the quests are deployed or not
    def update_b_button_text
    end
    # Update the text of the B button depending on if the quests are deployed or not
    def update_x_button_text
    end
    # Change the category depending on the input
    # @param trigger [Symbol] :left or :right
    def change_category(trigger)
    end
    # Launch the quest switching mode procedure
    def switch_quest_mode
    end
    public
    # List of method called by automatic_input_update when pressing on a key
    AIU_KEY2METHOD = {A: :action_a, X: :action_x, Y: :action_y, B: :action_b, LEFT: :action_left, RIGHT: :action_right}
    # Update the input of the scene
    def update_inputs
    end
    private
    # Return the keys used to scroll
    # @return [Array<Symbol>]
    SCROLL_KEYS = %i[UP DOWN]
    # Check if the scroll keys are triggered or pressed depending on the context3
    # @return [Boolean] if update_inputs should continue
    def check_up_down_keys
    end
    # Action related to A button
    def action_a
    end
    # Action related to B button
    def action_b
    end
    # Action related to X button
    def action_x
    end
    # Action related to Y button
    def action_y
    end
    # When the player press LEFT
    def action_left
    end
    # When the player press RIGHT
    def action_right
    end
    # Return the right scroll action depending on the context
    # @param direction [Symbol]
    # @param timing [Symbol]
    def action_scroll(direction, timing = :slow)
    end
    public
    # List of action the mouse can perform with ctrl button
    ACTIONS = %i[action_a action_x action_y action_b]
    # Update the mouse interactions
    # @param moved [Boolean] if the mouse moved durring the frame
    # @return [Boolean] if the thing after can update
    def update_mouse(moved)
    end
    private
    # Part where we update the mouse ctrl button
    def update_ctrl_button_mouse
    end
    # Part where we try to update the list index if the mouse wheel change
    def update_mouse_index
    end
    # Update the list index according to a delta with mouse interaction
    # @param delta [Integer] number of index we want to add / remove
    def update_mouse_delta_index(delta)
    end
  end
end
GamePlay.quest_ui_class = GamePlay::QuestUI
