describe "a somewhat conventional ruby project structure" do
  describe "tests" do
    it "should require a helper to load other dependencies" do
      $LOADED_FEATURES.grep(/spec_helper\.rb/).any?.should == true
    end
  end

  describe "config directory" do
    it "should exist" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../config/')).should == true
    end

    it "should have an environment file" do
      File.exists?(File.join(File.dirname(__FILE__), '../config/environment.rb')).should == true
    end

    describe "environment file" do
      it "should load files from the lib directory" do
        File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/require/).any?.should == true
        File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/lib/).any?.should == true
      end
    end
  end

  describe "loading the environment for testing" do
    it "should load the environment file in the spec_helper" do
      $LOADED_FEATURES.grep(/environment\.rb/).any?.should == true

      File.read(File.join(File.dirname(__FILE__), 'spec_helper.rb')).scan(/require.*environment/).any?.should == true
    end
  end

  describe "lib directory" do
    it "should exist" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../lib/')).should == true
    end

    it "should contain the application code" do
      File.exists?(File.join(File.dirname(__FILE__), '../lib/foo.rb')).should == true
      File.exists?(File.join(File.dirname(__FILE__), '../lib/bar.rb')).should == true
    end
  end

  describe "lib directory" do
    it "should have all it's files loaded" do
      expect { Foo }.to_not raise_error
      expect { Bar }.to_not raise_error
    end
  end

  describe "bin directory" do
    it "should exists" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../bin/')).should == true
    end

    it "should contain a run.rb file" do
      File.exists?(File.join(File.dirname(__FILE__), '../bin/run.rb')).should == true
    end

    describe "run.rb executable" do
      it "should load the environment" do
        run_file_contents = File.read(File.join(File.dirname(__FILE__), '../bin/run.rb'))

        run_file_contents.scan(/require/).any?.should == true
        run_file_contents.scan(/environment/).any?.should == true
      end

      it "should call run on the Foo class" do
        Foo.should_receive(:run)
        require_relative '../bin/run.rb'
      end
    end
  end
end
