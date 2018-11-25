require_relative './slot'
class NoLotError < StandardError; end
class Lot
  attr_accessor :slots

  def initialize(total_slots)
    @slots = []
    total_slots.to_i.times do |slot_index|
      slot_number = slot_index + 1
      slots[slot_index] = Slot.new(slot_number)
    end
    puts "Created a parking lot with #{ total_slots } slots"
  end

  def park(car_reg_number, car_colour)
    next_nearest_slot = slots.find { |slot| slot.is_free? }
    if next_nearest_slot
      next_nearest_slot.park(car_reg_number, car_colour)
      puts "Allocated slot number: #{next_nearest_slot.slot_number}"
    else
      puts "Sorry, parking lot is full"
    end
  end

  def leave(slot_number)
    slot_number = slot_number.to_i
    if slot_number > 0 && (slot_number <= slots.size)
      slot_index = slot_number - 1
      slots[slot_index].mark_free!
      puts "Slot number #{slot_number} is free"
    else
      puts "Invalid slot number"
    end
  end

  def status
    puts "Slot No.    Registration No    Colour"
    slots.each do | slot |
      puts "#{ slot.slot_number }           #{ slot.car_reg_number }      #{ slot.car_colour }" unless (slot.is_free?)
    end
  end

  def registration_numbers_for_cars_with_colour(colour)
    filtered_cars = filter_cars('car_reg_number', 'car_colour', colour)
    puts filtered_cars.compact.join(', ')
  end

  def slot_numbers_for_cars_with_colour(colour)
    filtered_cars = filter_cars('slot_number', 'car_colour', colour)
    puts filtered_cars.compact.join(', ')
  end

  def slot_number_for_registration_number(car_reg_number)
    slot = slots.find do |slot|
      slot.car_reg_number == car_reg_number
    end
    puts slot ? slot.slot_number : 'Not found'
  end

  private
    def filter_cars(filtered_value, filter_by, filter)
      slots.collect do |slot|
        slot.send(filtered_value) if slot.send(filter_by) == filter
      end
    end
end