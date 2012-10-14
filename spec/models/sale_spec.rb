require 'spec_helper'

describe Sale do
  context "creating a sale" do
    before(:each) do
      Sale.import_from_csv('spec/data/PPR-2010-01-Dublin.csv')
    end

    it "imports sales" do
      Sale.count.should == 15
      Sale.first.price.should == 343000
      Sale.last.price.should == 160000
    end

    it "creates some counties" do
      County.count.should == 1
      Sale.first.county.should == County.first
    end
  end
end
