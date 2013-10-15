describe "In a typical project" do
  describe "the tests" do
    it "would require a spec_helper in each test file to load other dependencies" do
      $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?.should == true
    end
  end

  describe "the lib directory" do
    it "would exist" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../lib/')).should == true
    end

    it "would contain the application code" do
      File.exists?(File.join(File.dirname(__FILE__), '../lib/foo.rb')).should == true
      File.exists?(File.join(File.dirname(__FILE__), '../lib/bar.rb')).should == true
    end
  end

  describe "the config directory" do
    it "would exist in the application root" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../config/')).should == true
    end

    it "would contain an environment file" do
      File.exists?(File.join(File.dirname(__FILE__), '../config/environment.rb')).should == true
    end

    describe "the environment file" do
      it "would load files from the lib directory" do
        File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/require/).any?.should == true
        File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/lib/).any?.should == true
      end
    end
  end

  describe "the spec_helper" do
    it "would load the environment file" do
      $LOADED_FEATURES.grep(/config\/environment\.rb/).any?.should == true

      spec_helper_file = File.read(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

      spec_helper_file.scan(/require/).any?.should == true
      spec_helper_file.scan(/environment/).any?.should == true

      expect { Foo }.to_not raise_error
      expect { Bar }.to_not raise_error
    end
  end

  describe "the bin directory" do
    it "would exist in the application root" do
      Dir.exists?(File.join(File.dirname(__FILE__), '../bin/')).should == true
    end

    it "would contain a run.rb file" do
      File.exists?(File.join(File.dirname(__FILE__), '../bin/run.rb')).should == true
    end

    describe "an executable (in this case run.rb)" do
      it "would load the environment" do
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
