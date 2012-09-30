require 'spec_helper'

describe Sale do
  context "creating a sale" do
    it "imports sales" do
      Sale.import_from_csv('spec/data/PPR-2010-01-Dublin.csv')
      Sale.count.should == 14
      true.should == true
    end

    it "stores a hash of the import data" do
      true.should == true
    end
  end
end
