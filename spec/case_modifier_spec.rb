require File.expand_path('../spec_helper', __FILE__)
require 'absolute_renamer/case_modifier'

module AbsoluteRenamer
  describe CaseModifier do
    before :each do
      @dummy = Object.new
      @dummy.extend CaseModifier
      @str = 'hEllO WorlD'
    end

    context "using the modify_case method" do
      it "should return its first parameter uppercased when the modifier is &" do
        @dummy.modify_case(@str, '&').should eq('HELLO WORLD')
      end

      it "should return its first parameter downcased when the modifier is %" do
        @dummy.modify_case(@str, '%').should eq('hello world')
      end

      it "should return its first parameter capitalized when the modifier is *" do
        @dummy.modify_case(@str, '*').should eq('Hello World')
      end

      it "should return its first parameter unchanged when the modifier is $" do
        @dummy.modify_case(@str, '$').should eq(@str)
      end

      it "should return its first parameter unchanged when the modifier is unknown" do
        @dummy.modify_case(@str, '@').should eq(@str)
      end
    end

    it "should be able to camelize a string" do
      @dummy.camelize(@str).should eq('Hello World')
    end
  end
end
