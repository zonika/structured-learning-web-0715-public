describe "a conventional ruby project structure" do
  describe "tests" do
    it "should require a helper to load other dependencies" do
      $LOADED_FEATURES.grep(/spec_helper\.rb/).any?.should == true
    end
  end

  describe "config directory" do
    it "should have an environment file" do
      File.exists?(File.join(File.dirname(__FILE__), '../config/env.rb')).should == true
    end

    it "should have it's environment file required in the spec_helper" do
      $LOADED_FEATURES.grep(/env\.rb/).any?.should == true
    end
  end
end
