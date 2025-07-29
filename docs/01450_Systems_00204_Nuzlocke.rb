module PFM
  # Class responsive of managing Nuzlocke information and helping to implement the nuzlocke logic
  # @author Logically anime and ralandel
  class Nuzlocke
    # If we prevent Duplicate from locking catch
    # @return [Boolean]
    attr_accessor :no_lock_on_duplicate
    # Storage of dead Pokemon to re-use later in other systems
    # @return [Array<PFM::Pokemon>]
    attr_accessor :graveyard
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create a new Nuzlocke object
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Function that clears the dead Pokemon from the party
    # and put their item back in the bag
    def clear_dead_pokemon
    end
    alias dead clear_dead_pokemon
    # Lock the current zone (prevent Pokemon from being able to be caught here)
    # @note This method checks if that's possible to lock before locking
    # @param pokemon_id [Integer] ID of the Pokemon that was seen before locking
    def lock_catch_in_current_zone(pokemon_id)
    end
    # Tell if catching is locked in the given zone
    # @param id [Integer] ID of the zone
    # @return [Boolean]
    def catching_locked?(id)
    end
    # Tell if catching is locked in the current zone
    # @return [Boolean]
    def catching_locked_here?
    end
    # Switch the enable state of the Nuzlocke
    # @param bool [Boolean]
    def switch(bool)
    end
    # Tell if the Nuzlocke is enabled
    # @return [Boolean]
    def enabled?
    end
    # Enable the Nuzlocke
    def enable
    end
    # Disable the Nuzlocke
    def disable
    end
  end
end
PFM.nuzlocke_class = PFM::Nuzlocke
