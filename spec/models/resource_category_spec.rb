require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
    
    describe "attributes" do
      it "has a name" do
          expect(ResourceCategory.new).to respond_to(:name)
      end

      it "has a boolean, active" do
          expect(ResourceCategory.new).to respond_to(:active)
      end
    end
    
    describe "associations" do
      it "has and belongs to many organizations" do
        expect(ResourceCategory.new).to have_and_belong_to_many(:organizations)
      end

      it "has many tickets" do
        expect(ResourceCategory.new).to have_many(:tickets)
      end
    end

    describe "validations" do
      it "cannot have a blank name" do
        resCat = ResourceCategory.new(name: 'The Dogg Pound')
        expect(resCat).to be_valid
        resCat = ResourceCategory.new(name: nil)
        expect(resCat).to_not be_valid
      end

      it "cannot have a name longer than 255 chars" do
        expect(ResourceCategory.new).to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
      end

      it "must have a unique name" do
        duplicate_name = "Westside Connection"
        resCat = ResourceCategory.create!(name: duplicate_name)
        duplicate_resCat = ResourceCategory.new(name: "WC")
        expect(duplicate_resCat).to be_valid
        duplicate_resCat.name = duplicate_name
        expect(duplicate_resCat).to_not be_valid    
      end
    end

    describe "#activate" do
      it "must set active value to true" do
        resource_category = ResourceCategory.new(active: false)
        resource_category.activate
        expect(resource_category.active).to eq(true)
      end
    end

    describe "#deactivate" do
      it "must set active value to false" do
        resource_category = ResourceCategory.new(active: true)
        resource_category.deactivate
        expect(resource_category.active).to eq(false)
      end
    end

    describe "#inactive?" do
      it "must return true if inactive" do
        resource_category = ResourceCategory.new(active: false)
        expect(resource_category.inactive?).to eq(true)
      end

      it "must return false if active" do
        resource_category = ResourceCategory.new(active: true)
        expect(resource_category.inactive?).to eq(false)
      end
    end

end
