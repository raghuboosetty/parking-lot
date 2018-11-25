require "spec_helper"

RSpec.describe "Slot", type: :aruba do

  describe "initialize" do
    it "returns new slot instance" do
      slot = Slot.new("1")
      expect(slot.class).to eql(Slot)
      expect(slot.slot_number).to eql(1)
      slot = Slot.new(2)
      expect(slot.slot_number).to eql(2)
    end
    
    it "throws exception when there are no input params" do
      expect { Slot.new }.to raise_error(ArgumentError)
    end
  end

  describe "park" do
    let(:slot) { Slot.new("1") }
    context "given car params are correct" do
      it "sets car as alloted new car" do
        slot.park("KA-01-HH-3141", "Black")
        expect(slot.car.car_reg_number).to eql("KA-01-HH-3141")
        expect(slot.car.car_colour).to eql("Black")
      end

      it "throws error if a car is parked where slot is filled" do
        slot.park("KA-01-HH-3142", "White")
        expect { slot.park("KA-01-HH-3142", "White") }.to raise_error(ParkError)
      end
    end

    context "given car params are missing" do
      it "throws missing argument exception" do
        expect { slot.park("KA-01-HH-3141") }.to raise_error(ArgumentError)
      end
    end
  end

  describe "car_reg_number and car_colour" do
    let(:slot) { Slot.new("1") }
    context "car_reg_number" do
      it "gives nil if no car alloted" do
        expect(slot.car_reg_number).to eql(nil)
      end

      it "gives car number if car alloted" do
        slot.park("KA-01-HH-3141", "White")
        expect(slot.car_reg_number).to eql("KA-01-HH-3141")
      end
    end
  
    context "car_colour" do
      it "gives nil if no car alloted" do
        expect(slot.car_colour).to eql(nil)
      end

      it "gives car number if car alloted" do
        slot.park("KA-01-HH-3141", "White")
        expect(slot.car_colour).to eql("White")
      end
    end
  end

  describe "mark_free! and is_free?" do
    let(:slot) { Slot.new("1") }
    context "mark_free!" do
      it "sets car as nil" do
        slot.mark_free!
        expect(slot.car).to eql(nil)
      end
    end

    context "is_free? - no car alloted" do
      it "returns true" do
        expect(slot.is_free?).to eql(true)
      end
    end

    context "is_free? - car alloted" do
      it "returns false" do
        slot.park("KA-01-HH-3141", "White")
        expect(slot.is_free?).to eql(false)
      end
    end
  end
end