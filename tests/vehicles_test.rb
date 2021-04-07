require "test/unit"
require_relative "../classes/vehicle"

class VehicleTest < Test::Unit::TestCase
  def test_new_instance
    vehicle = Vehicle.new(make,registration)
    assert_not_nil(vehicle)
  end
end
