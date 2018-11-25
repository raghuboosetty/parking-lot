require_relative './car'
class ParkError < StandardError; end
class Slot
  attr_accessor :slot_number, :car

  def initialize (slot_number)
    @slot_number = slot_number.to_i
  end

  def park(car_reg_number, car_colour)
    if self.car
      raise ParkError
    else
      self.car = ::Car.new(car_reg_number, car_colour)
    end
  end

  def mark_free!
    self.car = nil
  end

  def is_free?
    self.car == nil
  end

  def car_reg_number
    car.car_reg_number if car
  end

  def car_colour
    car.car_colour if car
  end
end