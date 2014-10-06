require 'spec_helper'

describe "In a typical project" do
  describe "the tests" do
    it "would require a spec_helper in each test file to load other dependencies" do
      expect($LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?).to eq(true)
    end
  end

  describe "the lib directory" do
    it "would exist in the application root" do
      expect(Dir.exists?(File.join(File.dirname(__FILE__), '../lib/'))).to eq(true)
    end

    it "would contain the application code" do
      expect(File.exists?(File.join(File.dirname(__FILE__), '../lib/foo.rb'))).to eq(true)
      expect(File.exists?(File.join(File.dirname(__FILE__), '../lib/bar.rb'))).to eq(true)
    end
  end

  describe "the config directory" do
    it "would exist in the application root" do
      expect(Dir.exists?(File.join(File.dirname(__FILE__), '../config/'))).to eq(true)
    end

    it "would contain an environment file" do
      expect(File.exists?(File.join(File.dirname(__FILE__), '../config/environment.rb'))).to eq(true)
    end

    describe "the environment file" do
      it "would load files from the lib directory" do
        expect(File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/require/).any?).to eq(true)
        expect(File.read(File.join(File.dirname(__FILE__), '../config/environment.rb')).scan(/lib/).any?).to eq(true)
      end
    end
  end

  describe "the spec_helper" do
    it "would load the environment file" do
      expect($LOADED_FEATURES.grep(/config\/environment\.rb/).any?).to eq(true)

      spec_helper_file = File.read(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

      expect(spec_helper_file.scan(/require/).any?).to eq(true)
      expect(spec_helper_file.scan(/environment/).any?).to eq(true)

      expect { Foo }.to_not raise_error
      expect { Bar }.to_not raise_error
    end
  end

  describe "the bin directory" do
    it "would exist in the application root" do
      expect(Dir.exists?(File.join(File.dirname(__FILE__), '../bin/'))).to eq(true)
    end

    it "would contain a run.rb file" do
      expect(File.exists?(File.join(File.dirname(__FILE__), '../bin/run.rb'))).to eq(true)
    end

    describe "an executable (in this case run.rb)" do
      it "would load the environment" do
        run_file_contents = File.read(File.join(File.dirname(__FILE__), '../bin/run.rb'))

        expect(run_file_contents.scan(/require/).any?).to eq(true)
        expect(run_file_contents.scan(/environment/).any?).to eq(true)
      end

      it "should call run on the Foo class" do
        expect(Foo).to receive(:run)

        require_relative '../bin/run.rb'
      end
    end
  end

  describe 'Gemfile and Gemfile.lock' do 
    it 'Gemfile exists' do 
      expect(File.exists?(File.join(File.dirname(__FILE__), '../Gemfile'))).to eq(true)
    end

    it 'Gemfile.lock exists' do 
      expect(File.exists?(File.join(File.dirname(__FILE__), '../Gemfile.lock'))).to eq(true)
    end
  end
end
