require_relative './oystercard.rb'

# should be responsible for starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.


class Journey
  attr_accessor = :j_entry_station

  def initialize(card)
    @j_entry_station = card.entry_station
  end

  def in_journey?
    #@entry_station
  #  @in_journey
    @j_entry_station
  end

  # def add_journey_history
  #
  # end


end
