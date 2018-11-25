require "spec_helper"

RSpec.describe "Lot", type: :aruba do

  describe "initialize" do
    context "given correct input params" do
      it "returns new lot instance" do
        lot = Lot.new(1)
        expect(lot.slots.size).to eql(1)
        expect(lot.slots[0].slot_number).to eql(1)
        lot2 = Lot.new(2)
        expect(lot2.slots.size).to eql(2)
      end
    end

    context "given no input params" do
      it "throws missing argument exception" do
        expect { Lot.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "park" do
    let(:lot) { Lot.new("1") }
    context "given correct input params and available free slots" do
      it "allocates a slot to car" do
        lot.park("KA-01-HH-3141", "White")
        expect(lot.slots[0].car_reg_number).to eql("KA-01-HH-3141")
        expect(lot.slots[0].car_colour).to eql("White")
      end
    end

    context "given correct input params and no free slots" do
      it "logs errors" do
        lot.park("KA-01-HH-3141", "White")
        expect do
            lot.park("KA-01-HH-3142", "Black")
        end.to output("Sorry, parking lot is full\n").to_stdout
      end
    end

    context "given correct input params and car already parked" do
      it "logs errors" do
        lot.park("KA-01-HH-3141", "White")
        expect do
          lot.park("KA-01-HH-3141", "White")
        end.to output("Car already parked!\n").to_stdout
      end
    end

    context "given no correct input params" do
      it "throws missing argument exception" do
        expect { lot.park }.to raise_error(ArgumentError)
      end
    end
  end

  describe "leave" do
    let(:lot) { Lot.new("1") }
    context "given correct input params and within slot range" do
      it "slot to be free when a car leaves" do
        lot.park("KA-01-HH-3141", "White")
        lot.leave(1)
        expect(lot.slots[0].is_free?).to eql(true)
        lot.leave(1)
        expect(lot.slots[0].is_free?).to eql(true)
      end
    end

    context "given correct input params but outside slots available" do
      it "logs slot error" do
        lot.park("KA-01-HH-3141", "White")
        expect do
            lot.leave(10)
        end.to output("Invalid slot number\n").to_stdout
      end
    end

    context "given no correct input params" do
      it "throws missing argument exception" do
        expect { lot.leave }.to raise_error(ArgumentError)
      end
    end
  end

  describe "registration_numbers_for_cars_with_colour" do
    let(:lot) { Lot.new(5) }
    context "given correct input params and cars found" do
      it "returns car numbers in comma seperated format" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.registration_numbers_for_cars_with_colour("White")
        end.to output("KA-01-HH-3141, KA-01-HH-3143\n").to_stdout
      end
    end

    context "given correct input params and cars not found" do
      it "returns empty string" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.registration_numbers_for_cars_with_colour("Red")
        end.to output("\n").to_stdout
      end
    end

    context "given no correct input params" do
      it "throws missing argument exception" do
        expect { lot.registration_numbers_for_cars_with_colour }.to raise_error(ArgumentError)
      end
    end
  end

  describe "slot_numbers_for_cars_with_colour" do
    let(:lot) { Lot.new(5) }
    context "given correct input params and slots found" do
      it "returns car numbers in comma seperated format" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.slot_numbers_for_cars_with_colour("White")
        end.to output("1, 3\n").to_stdout
      end
    end

    context "given correct input params and slots not found" do
      it "returns empty string" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.slot_numbers_for_cars_with_colour("Red")
        end.to output("\n").to_stdout
      end
    end

    context "given no correct input params" do
      it "throws missing argument exception" do
        expect { lot.slot_numbers_for_cars_with_colour }.to raise_error(ArgumentError)
      end
    end
  end

  describe "slot_number_for_registration_number" do
    let(:lot) { Lot.new(5) }
    context "given correct input params and car found" do
      it "returns car numbers in comma seperated format" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.slot_number_for_registration_number("KA-01-HH-3141")
        end.to output("1\n").to_stdout
      end
    end

    context "given correct input params and car not found" do
      it "returns empty string" do
        lot.park("KA-01-HH-3141", "White")
        lot.park("KA-01-HH-3142", "Black")
        lot.park("KA-01-HH-3143", "White")
        lot.park("KA-01-HH-3144", "Black")
        expect do
            lot.slot_number_for_registration_number("KA-01-HH-3145")
        end.to output("Not found\n").to_stdout
      end
    end

    context "given no correct input params" do
      it "throws missing argument exception" do
        expect { lot.slot_number_for_registration_number }.to raise_error(ArgumentError)
      end
    end
  end

end
