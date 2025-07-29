module GamePlay
  # Module defining the IO of the move reminder scene so user know what to expect
  module MoveReminderMixin
    # Tell if a move was learnt or not
    # @return [Boolean]
    attr_accessor :return_data
    # Tell if the move reminder reminded a move or not
    # @return [Boolean]
    def reminded_move?
    end
  end
  # Move reminder Scene
  class Move_Reminder < BaseCleanUpdate::FrameBalanced
    include MoveReminderMixin
    # Front background image
    BACKGROUND = 'MR_UI'
    # Cursor filename
    CURSOR = 'ball_selec'
    # List of button texts
    BUTTON_TEXTS = [[:ext_text, 9000, 117], [:ext_text, 9000, 113], ': previous', [:ext_text, 9000, 115]]
    # List of button used in the UI
    BUTTON_KEYS = %i[A DOWN UP B]
    # List of button action
    BUTTON_ACTION = %i[action_a action_down action_up action_b]
    # Text helping the player
    HELP_TEXT = 'Which move should %s learn?'
    # Number of frame before help text shows up
    HELP_TEXT_COUNT = 180
    # Create a new Move_Reminder Scene
    # @param pokemon [PFM::Pokemon] pokemon that should learn a move
    # @param mode [Integer] Define the moves you can see :
    #   1 = breed_moves + learnt + potentially_learnt
    #   2 = all moves
    #   other = learnt + potentially_learnt
    def initialize(pokemon, mode = 0)
    end
    # Update the inputs
    def update_inputs
    end
    # Update the graphics
    def update_graphics
    end
    # Update the mouse
    # @param moved [Boolean] boolean telling if the mouse moved
    # @return [Boolean] if the update can continue
    def update_mouse(moved)
    end
    private
    # Create the Move Reminder UI
    def create_graphics
    end
    # Create the generic base used by the Move Reminder UI
    def create_base
    end
    def create_ui
    end
    # Call the Skill Learn UI when the player press A
    def action_a
    end
    # Stop the scene
    def action_b
    end
    # Set the index to the previous one
    def action_up
    end
    # Set the index to the next one
    def action_down
    end
  end
end
GamePlay.move_reminder_mixin = GamePlay::MoveReminderMixin
GamePlay.move_reminder_class = GamePlay::Move_Reminder
