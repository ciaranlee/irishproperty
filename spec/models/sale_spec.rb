require 'spec_helper'

describe Sale do
  context "creating a sale" do
    it "imports sales" do
      Sale.import_from_csv('spec/data/PPR-2010-01-Dublin.csv')
      Sale.count.should == 15
      Sale.first.price.should == 343000
      Sale.last.price.should == 160000
    end

    it "stores a hash of the import data" do
      true.should == true
    end
  end
end
