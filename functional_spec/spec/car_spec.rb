require 'spec_helper'

RSpec.describe 'Car', type: :aruba do

  describe 'initialize' do
    context 'given correct input params' do
      it 'returns new car instance' do
        car = Car.new('KA-01-HH-3141', 'Black')
        expect(car.class).to eql(Car)
        expect(car.car_reg_number).to eql('KA-01-HH-3141')
        expect(car.car_colour).to eql('Black')
      end
    end

    context 'given no params' do
      it 'throws missing argument exception' do
        expect { Car.new }.to raise_error(ArgumentError)
        expect { Car.new('KA-01-HH-3141') }.to raise_error(ArgumentError)
        expect { Car.new('Black') }.to raise_error(ArgumentError)
      end
    end
  end

end
