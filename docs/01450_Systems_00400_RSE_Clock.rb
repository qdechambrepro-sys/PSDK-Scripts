module GamePlay
  # Module Holding all the modules to include for the RSEClock
  module RSEClockHelpers
    # Module defining the logic of the RSEClock
    module Logic
      # Get the hour that was set on the clock
      # @return [Integer]
      attr_reader :hour
      # Get the minute that was set on the clock
      attr_reader :minute
      # Create a new RSEClock
      # @param hour [Integer] hour to start the clock
      # @param minute [Integer] minute to start the clock
      def initialize(hour = 0, minute = 0)
      end
      private
      # Increase the minutes
      def increase_minutes
      end
      # Decrease the minutes
      def decrease_minutes
      end
      # Update the hour based on minutes
      def update_hour
      end
    end
    # Module defining the UI of the RSE Clock
    module UI
      private
      def create_graphics
      end
      def create_background
      end
      def create_clock
      end
      def create_am_pm
      end
      def create_minute_aiguille
      end
      def create_hour_aiguille
      end
      def update_aiguilles
      end
      def update_waiter
      end
    end
    # Module defining the questions asked by the RSEClock
    module Questions
      private
      def ask_confirmation
      end
      def question_string
      end
    end
  end
  # Scene asking the player to provide the time
  #
  # How to use:
  # 1. Set time with no initial time
  #   call_scene(GamePlay::RSEClock) { |scene| @time = "#{scene.hour}:#{scene.minute}"}
  # 2. Set time with initial time
  #   call_scene(GamePlay::RSEClock, hour, minute) { |scene| @time = "#{scene.hour}:#{scene.minute}"}
  class RSEClock < GamePlay::StateMachine
    include GamePlay::RSEClockHelpers::Logic
    include GamePlay::RSEClockHelpers::UI
    include GamePlay::RSEClockHelpers::Questions
    # Constant holding all the update method to call depending on the state
    STATE_UPDATE_METHODS = {init: :update_init, choice: :update_choice, inc_min: :update_inc_min, dec_min: :update_dec_min, wait: :update_wait, confirmation: :update_confirmation, out: :update_out}
    private
    # Function that initialize the state machine, please, do not forget to call this function where it makes sense (depending on dependencies)
    def initialize_state_machine
    end
    # Function that call the right update method, don't forget to call it if you're not inheriting from a class that calls it
    def update_state_machine
    end
    def update_init
    end
    def tansitioning_from_choice_to_inc_min?
    end
    def tansitioning_from_choice_to_dec_min?
    end
    def tansitioning_from_choice_to_confirmation?
    end
    def update_state_from_choice
    end
    def update_choice_inputs
    end
    def update_choice
    end
    def update_inc_min
    end
    def update_dec_min
    end
    def tansitioning_from_wait_to_choice?
    end
    def update_state_from_wait
    end
    def update_wait_inputs
    end
    def update_wait
    end
    def tansitioning_from_confirmation_to_out?
    end
    def tansitioning_from_confirmation_to_choice?
    end
    def update_state_from_confirmation
    end
    def update_confirmation_inputs
    end
    def update_confirmation
    end
    def update_out
    end
  end
end
__LINE__.to_i
