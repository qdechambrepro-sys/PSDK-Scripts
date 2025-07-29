module UI
  module MoveTeaching
    # UI part displaying the background of the Skill Learn scene
    class BaseBackground < SpriteStack
      # Create the Background
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      private
      # Create the background
      def create_background
      end
      # @return [Array] the background coordinates
      def background_coordinates
      end
      # @return [String] the background name
      def background_name
      end
    end
    # UI part displaying the Pokémon informations in the Skill Learn scene
    class PokemonInfos < SpriteStack
      # List of Pokemon that shouldn't show the gender sprite
      NO_GENDER = %i[nidoranf nidoranm]
      # Create sprite & some informations of the Pokémon
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the data of the Pokemon
      def data=(pokemon)
      end
      # Update the graphics
      def update_graphics
      end
      private
      def create_sprites
      end
      # @return [UI::PokemonFaceSprite]
      def create_sprite
      end
      # @return Array of coordinates of the Pokémon face sprite
      def sprite_coordinates
      end
      # @return [SymText]
      def create_name
      end
      # @return Array of coordinates of the Pokémon name
      def name_coordinates
      end
      # @return [GenderSprite]
      def create_gender
      end
      # @return Array of coordinates of the Pokémon gender
      def gender_coordinates
      end
    end
    # UI part displaying the Skill description in the Skill Learn scene
    class SkillDescription < SpriteStack
      # Create informations of the hovered skill
      # @param viewport [Viewport]
      def initialize(viewport)
      end
      # Set the data of the UI
      # @param skill [PFM::Skill]
      def data=(skill)
      end
      # Set the visibility of the UI
      # @param value [Boolean] new visibility
      def visible=(value)
      end
      private
      # Update the informations of the Skill
      # @param skill [PFM::Skill]
      def update_infos(skill)
      end
      # Init the texts of the skill informations
      def create_texts
      end
    end
    # UI part displaying the new skill informations in the Skill Learn scene
    class NewSkill < SpriteStack
      # @return [Boolean] if the move is currently selected
      attr_reader :selected
      # Create informations of the new skill to learn
      # @param viewport [Viewport]
      # @param index [Integer]
      def initialize(viewport, index)
      end
      # Set the skill data
      # @param skill [PFM::Skill]
      def data=(skill)
      end
      # Set the visibility of the sprite
      # @param value [Boolean] new visibility
      def visible=(value)
      end
      # Get the visibility of the sprite
      # @return [Boolean]
      def visible
      end
      # Define if the skill is selected
      # @param selected [Boolean]
      def selected=(selected)
      end
      private
      # Create the texts of the new skill to learn
      def create_texts
      end
      # @return Array of coordinates of the "New" text
      def new_text_coordinates
      end
      # Return the "New" text
      def new_text
      end
      # @return Array of coordinates of the Skill name
      def name_coordinates
      end
      # @return Array of coordinates of the Skill pp text
      def pp_text_coordinates
      end
      # @return Array of coordinates of the Skill pp text value
      def pp_text_value_coordinates
      end
      # Create some graphics of the new skill to learn
      def create_graphics
      end
      # @return Array of coordinates of the Skill type
      def type_coordinates
      end
      # Return the name of the new_selector file
      # @return [String]
      def new_selector_name
      end
      # Return the name of the method used to get the PP text
      # @return [Symbol]
      def pp_method
      end
    end
    # UI part displaying a Skill in the Skill Learn UI
    class Skill < SpriteStack
      # Array describing the various coordinates of the skills in the UI
      FINAL_COORDINATES = [[28, 156], [174, 156], [28, 188], [174, 188]]
      # Color when it's selected
      FORGET_COLOR = Color.new(0, 200, 0, 255)
      # Color when it's not selected
      NORMAL_COLOR = Color.new(0, 0, 0, 0)
      # @return [Boolean] if the move is currently selected
      attr_reader :selected
      # @return [Boolean] if the move is currently being moved
      attr_reader :forget
      # Create a new Skill
      # @param viewport [Viewport]
      # @param index [Integer] index of the skill in the UI
      def initialize(viewport, index)
      end
      # Set the skill data
      # @param skill [PFM::Skill]
      def data=(skill)
      end
      # Set the visibility of the sprite
      # @param value [Boolean] new visibility
      def visible=(value)
      end
      # Get the visibility of the sprite
      # @return [Boolean]
      def visible
      end
      # Define if the skill is selected
      # @param selected [Boolean]
      def selected=(selected)
      end
      # Define if the skill is being moved
      # @param forget [Boolean]
      def forget=(forget)
      end
      private
      # Create the texts of the skill
      def create_texts
      end
      # @return Array of coordinates of the Skill name
      def name_coordinates
      end
      # @return Array of coordinates of the Skill pp text
      def pp_text_coordinates
      end
      # @return Array of coordinates of the Skill pp text value
      def pp_text_value_coordinates
      end
      # Create some graphics of the new skill to learn
      def create_graphics
      end
      # @return Array of coordinates of the Skill type
      def type_coordinates
      end
      # Return the name of the selector file
      # @return [String]
      def selector_name
      end
      # Return the name of the method used to get the PP text
      # @return [Symbol]
      def pp_method
      end
    end
  end
end
module GamePlay
  # Module defining the IO of the move teaching scene so user know what to expect
  module MoveTeachingMixin
    # Tell if the move was learnt or not
    # @return [Boolean]
    attr_accessor :learnt
  end
  # Scene responsive of teaching a move to a Pokemon
  #
  # How to call it ?
  #   This scene has a return parameter called `learnt` telling wether the move has been learnt or not.
  #   You might use call_scene like this for this Scene:
  #     call_scene(GamePlay::MoveTeaching, pokemon, move_id) { |scene| do something with scene.learnt }
  class MoveTeaching < BaseCleanUpdate::FrameBalanced
    include UI::MoveTeaching
    include MoveTeachingMixin
    # Create a new Skill Learn scene
    # param pokemon [PFM::Pokemon]
    # param skill [Integer] or [Symbol]
    def initialize(pokemon, skill_id)
    end
    include UI::MoveTeaching
    # Update the graphics every frame
    def update_graphics
    end
    # Create the differents graphics of the UI
    def create_graphics
    end
    # Set the visibility ON
    def ui_visibility=(visible)
    end
    private
    # Create the background
    def create_background
    end
    # Create the window background
    def create_window
    end
    # Create the Pokemon infos
    def create_pokemon_infos
    end
    # Create the Skill description view
    def create_skill_description
    end
    # Create the Skills (new one + skill_set)
    def create_skills
    end
    # Create the New skill view
    def create_new_skill
    end
    # Create the Skillset
    def create_skill_set
    end
    public
    # List of methds associated to the inputs
    AIU_KEY2METHOD = {UP: :action_up, DOWN: :action_down, LEFT: :action_left, RIGHT: :action_right, A: :action_a, B: :action_b}
    # Update inputs every frame
    def update_inputs
    end
    private
    # Update buttons inputs
    def update_buttons_inputs
    end
    # Swap the button selection state
    # @param old_index [Integer] previous index to make that button "not selected"
    def swap_buttons(old_index)
    end
    # Action when the up button is pressed
    def action_up
    end
    # Action when the down button is pressed
    def action_down
    end
    # Action when the left button is pressed
    def action_left
    end
    # Action when the right button is pressed
    def action_right
    end
    # Action when the A button is pressed
    def action_a
    end
    # Action when the B button is pressed
    def action_b
    end
    public
    # Actions of the scene
    # Array containing the Yes No texts of a choice
    CHOICE_TEXTS = [[23, 85], [23, 86]]
    # Array containing the texts of the scene
    LEARNING_TEXTS = [[22, 99], [22, 100], [22, 101], [22, 102], [22, 103], [22, 106], [11, 313]]
    private
    # Message starting with the scene
    # @return [Boolean] false to ensure mouse is skipped
    def message_start
    end
    # Shows "Pkmn learned xxx!"
    def display_learned_move_message
    end
    # Shows "Pkmn want to learn xxxx. Do you want to forget a move?"
    # @return [Integer] 0 = yes, 1 = no
    def display_learning_move_question
    end
    # Message ending with the scene
    def message_end
    end
    # Shows the give up on this move choice
    # @return [Integer] 0 = yes, 1 = no
    def display_give_up_question
    end
    # Shows the give up message
    def display_give_up_message
    end
    # Replace the skill with the new one
    def forget
    end
    # Display "You're good with having it forget xxx?"
    # @return [Integer] 0 = yes, 1 = no
    def display_forget_question
    end
    # Display the move forgotten message
    def display_move_forgotten_new_move_learnt
    end
    # Method displaying the Which move should be forgotten? message
    def which_move
    end
    # If the scene is called during a battle
    def battle_check
    end
    # Displays the UI
    def show_ui
    end
    public
    # Function responsive of updating the mouse
    def update_mouse(moved)
    end
  end
  # Compatibility with old PSDK version
  Skill_Learn = MoveTeaching
end
GamePlay.move_teaching_mixin = GamePlay::MoveTeachingMixin
GamePlay.move_teaching_class = GamePlay::MoveTeaching
