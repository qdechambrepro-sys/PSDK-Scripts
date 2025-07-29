module PFM
  # Daycare management system
  #
  # The global Daycare manager is stored in $daycare and PFM.game_state.daycare
  # @author Nuri Yuri
  #
  # Daycare data Hash format
  #   pokemon: Array # The list of Pokemon in the daycare (PFM::Pokemon or nil)
  #   level: Array # The list of level the Pokemon had when sent to the daycare
  #   layable: Integer # ID of the Pokemon that can be in the egg
  #   rate: Integer # Chance the egg can be layed
  #   egg: Boolean # If an egg has been layed
  class Daycare
    # Only use the FIRST FORM for breed groups
    USE_FIRST_FORM_BREED_GROUPS = false
    # Specific form handler (system that can force a for according to a code)
    SPECIFIC_FORM_HANDLER = {myfakepokemon: proc { |_mother, _father| next((rand(10))) }}
    # List of Pokemon that cannot breed (event if the conditions are valid)
    NOT_BREEDING = %i[phione manaphy]
    # List of Pokemon that only breed with Ditto
    BREEDING_WITH_DITTO = %i[phione manaphy]
    # ID of the Ditto group
    DITTO_GROUP = 13
    # ID of the breed group that forbid breeding
    NOT_BREEDING_GROUP = 15
    # List of price rate for all daycare
    # @return [Hash{Integer => Integer}]
    PRICE_RATE = Hash.new(100)
    # Egg rate according to the common group, common OT, oval_charm (dig(common_group?, common_OT?, oval_charm?))
    EGG_RATE = [[[50, 80], [20, 40]], [[70, 88], [50, 80]]]
    # "Female" breeder that can have different baby (non-incense condition)
    # @return [Hash{Symbol => Array}]
    BABY_VARIATION = {nidoranf: nidoran = %i[nidoranf nidoranm], nidoranm: nidoran, volbeat: volbeat = %i[volbeat illumise], illumise: volbeat, tauros: tauros = %i[tauros miltank], miltank: tauros}
    # Structure holding the information about the insence the male should hold
    # and the baby that will be generated
    IncenseInfo = Struct.new(:incense, :baby)
    # "Female" that can have different baby if the male hold an incense
    INCENSE_BABY = {marill: azurill = IncenseInfo.new(:sea_incense, :azurill), azumarill: azurill, wobbuffet: IncenseInfo.new(:lax_incense, :wynaut), roselia: budew = IncenseInfo.new(:rose_incense, :budew), roserade: budew, chimecho: IncenseInfo.new(:pure_incense, :chingling), sudowoodo: IncenseInfo.new(:rock_incense, :bonsly), mr_mime: mime_jr = IncenseInfo.new(:odd_incense, :mime_jr), mr_rime: mime_jr, chansey: happiny = IncenseInfo.new(:luck_incense, :happiny), blissey: happiny, snorlax: IncenseInfo.new(:full_incense, :munchlax), mantine: IncenseInfo.new(:wave_incense, :mantyke)}
    # Non inherite balls
    NON_INHERITED_BALL = %i[master_ball cherish_ball]
    # IV setter list
    IV_SET = %i[iv_hp= iv_dfe= iv_atk= iv_spd= iv_ats= iv_dfs=]
    # IV getter list
    IV_GET = %i[iv_hp iv_dfe iv_atk iv_spd iv_ats iv_dfs]
    # List of power item that transmit IV in the same order than IV_GET/IV_SET
    IV_POWER_ITEM = %i[power_weight power_belt power_bracer power_anklet power_lens power_band]
    # Get the game state responsive of the whole game state
    # @return [PFM::GameState]
    attr_accessor :game_state
    # Create the daycare manager
    # @param game_state [PFM::GameState] variable responsive of containing the whole game state for easier access
    def initialize(game_state = PFM.game_state)
    end
    # Update every daycare
    def update
    end
    # Store a Pokemon to a daycare
    # @param id [Integer] the ID of the daycare
    # @param pokemon [PFM::Pokemon] the pokemon to store in the daycare
    # @return [Boolean] if the pokemon could be stored in the daycare
    def store(id, pokemon)
    end
    # Price to pay in order to withdraw a Pokemon
    # @param id [Integer] the ID of the daycare
    # @param index [Integer] the index of the Pokemon in the daycare
    # @return [Integer] the price to pay
    def price(id, index)
    end
    # Get a Pokemon information in the daycare
    # @param id [Integer] the ID of the daycare
    # @param index [Integer] the index of the Pokemon in the daycare
    # @param prop [Symbol] the method to call of PFM::Pokemon to get the information
    # @param args [Array] the list of arguments of the property
    # @return [Object] the result
    def get_pokemon(id, index, prop, *args)
    end
    # Withdraw a Pokemon from a daycare
    # @param id [Integer] the ID of the daycare
    # @param index [Integer] the index of the Pokemon in the daycare
    # @return [PFM::Pokemon, nil]
    def retrieve_pokemon(id, index)
    end
    alias withdraw_pokemon retrieve_pokemon
    alias retreive_pokemon retrieve_pokemon
    # Get the egg rate of a daycare
    # @param id [Integer] the ID of the daycare
    # @return [Integer]
    def retrieve_egg_rate(id)
    end
    alias retreive_egg_rate retrieve_egg_rate
    # Retrieve the egg layed
    # @param id [Integer] the ID of the daycare
    # @return [PFM::Pokemon]
    def retrieve_egg(id)
    end
    alias retreive_egg retrieve_egg
    # If an egg was layed in this daycare
    # @param id [Integer] the ID of the daycare
    # @return [Boolean]
    def layed_egg?(id)
    end
    alias has_egg? layed_egg?
    # If a daycare is full
    # @param id [Integer] the ID of the daycare
    # @return [Boolean]
    def full?(id)
    end
    # If a daycare is empty
    # @param id [Integer] the ID of the daycare
    # @return [Boolean]
    def empty?(id)
    end
    # Parse the daycare Pokemon text info
    # @param var_id [Integer] ID of the game variable where the ID of the daycare is stored
    # @param index [Integer] index of the Pokemon in the daycare
    def parse_poke(var_id, index)
    end
    private
    # Check the layability of a daycare
    # @param daycare [Hash] the daycare informations Hash
    # @param parents [Array] the list of Pokemon in the daycar
    def layable_check(daycare, parents)
    end
    # Special check to lay an egg
    # @param daycare [Hash] the daycare information
    # @param female [PFM::Pokemon] the female
    # @param male [PFM::Pokemon] the male
    # @return [Integer, false] the id of the Pokemon that will be in the egg or no special baby with these Pokemon
    def special_lay_check(daycare, female, male)
    end
    # Give 1 exp point to a pokemon
    # @param pokemon [PFM::Pokemon] the pokemon to give one exp point
    def exp_pokemon(pokemon)
    end
    # Attempt to lay an egg
    # @param daycare [Hash] the daycare informations Hash
    def try_to_lay(daycare)
    end
    # Make the pokemon inherit the gene of its parents
    # @param pokemon [PFM::Pokemon] the pokemon
    # @param parents [Array(PFM::Pokemon, PFM::Pokemon)] the parents
    def inherit(pokemon, parents)
    end
    # Tell if the system should check for eggs in this update
    # @return [Boolean]
    def should_check_eggs?
    end
    # Return the parents in male, female order (to make the lay process easier)
    # @param potential_male [PFM::Pokemon]
    # @param potential_female [PFM::Pokemon]
    # @return [Array<PFM::Pokemon>]
    def assign_gender(potential_male, potential_female)
    end
    # Return the data of each breedable Pokemon
    # @param male [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    # @return [Array<Studio::CreatureForm>]
    def get_pokemon_data(male, female)
    end
    # Return the egg rate (% chance of having an egg)
    # @param male [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    # @return [Integer]
    def perform_simple_rate_calculation(male, female)
    end
    # Return if the parents breed groupes are compatible
    # @param common_in_group [Array]
    # @param male_data [Studio::CreatureForm]
    # @param female_data [Studio::CreatureForm]
    # @return [Boolean]
    def check_group_compatibility(common_in_group, male_data, female_data)
    end
    # Make the pokemon inherit its form
    # @param pokemon [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    # @param male [PFM::Pokemon]
    def inherit_form(pokemon, female, male)
    end
    # Make the pokemon inherit its nature
    # @param pokemon [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    # @param male [PFM::Pokemon]
    def inherit_nature(pokemon, female, male)
    end
    # Make the Pokemon inherit the female ability
    # If the ability is the hidden one, it'll have 60% chance, otherwise 80% chance
    # @param pokemon [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    def inherit_ability(pokemon, female)
    end
    # Make the Pokemon inherit the parents moves
    # @param pokemon [PFM::Pokemon]
    # @param male [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    def inherit_moves(pokemon, male, female)
    end
    # Teach a skill to the Pokemon
    # @param pokemon [PFM::Pokemon]
    # @param skill_id [Integer, Symbol] ID of the skill in the database
    def learn_skill(pokemon, skill_id)
    end
    # Try to teach Volt Tackle to Pichu
    # @param pokemon [PFM::Pokemon]
    # @param male [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    def learn_volt_tackle(pokemon, male, female)
    end
    # Inherit the IV
    # @param pokemon [PFM::Pokemon]
    # @param male [PFM::Pokemon]
    # @param female [PFM::Pokemon]
    def inherit_iv(pokemon, male, female)
    end
    # Inherit the IV when one of the parent holds the destiny knot.
    # It'll transmit 5 of the IV (of both parents randomly) to the child
    # @param pokemon [PFM::Pokemon]
    # @param parents [Array<PFM::Pokemon>]
    def inherit_iv_destiny_knot(pokemon, *parents)
    end
    # Regular IV inherit from parents.
    # 3 attempt to inherit the IV.
    #   The first attempt will give one of the IV of any parent
    #   The second will give one of the IV (excluding HP) of any parent
    #   The third will give one of the IV (excluding HP & DFE) of any parent
    # All attempt can overwrite the previous one (if the stat is the same)
    # @note This works thanks to the IV_GET & IV_SET constant configuration!
    # @param pokemon [PFM::Pokemon]
    # @param parents [Array<PFM::Pokemon>]
    def inherit_iv_regular(pokemon, *parents)
    end
    # IV inherit from parents holding power item
    # @param pokemon [PFM::Pokemon]
    # @param parents [Array<PFM::Pokemon>]
    def inherit_iv_power(pokemon, *parents)
    end
  end
  class GameState
    # The daycare management object
    # @return [PFM::Daycare]
    attr_accessor :daycare
    on_player_initialize(:daycare) {@daycare = PFM.daycare_class.new(self) }
    on_expand_global_variables(:daycare) do
      $daycare = @daycare
      @daycare.game_state = self
    end
  end
end
PFM.daycare_class = PFM::Daycare
