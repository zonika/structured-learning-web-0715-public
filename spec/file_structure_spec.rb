describe "conventional ruby file structure" do
  describe "tests" do
    it "should require a helper to load other dependencies" do
      $LOADED_FEATURES.grep(/spec_helper.rb/).any?.should == true
    end
  end
end
