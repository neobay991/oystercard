# frozen_string_literal: true

# :nodoc:
class Station
  attr_reader :name, :zone

  def initialize(station_name, station_zone)
    @name = station_name
    @zone = station_zone
  end
end
