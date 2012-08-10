require 'spec_helper'
require 'absolute_renamer/case_modifier'

module AbsoluteRenamer
  describe CaseModifier do
    subject { Object.new.extend CaseModifier }
    let(:string) { 'hEllO WorlD' }

    describe '#modify_case' do
      it "should return its first parameter uppercased when the modifier is '&'" do
        subject.modify_case(string, '&').should eq('HELLO WORLD')
      end

      it "should return its first parameter downcased when the modifier is '%'" do
        subject.modify_case(string, '%').should eq('hello world')
      end

      it "should return its first parameter capitalized when the modifier is '*'" do
        subject.modify_case(string, '*').should eq('Hello World')
      end

      it "should return its first parameter unchanged when the modifier is unknown" do
        subject.modify_case(string, '@').should eq(string)
      end
    end

    describe '#camelcase' do
      it "should return a camelized version of the string" do
        subject.camelcase(string).should eq('Hello World')
      end
    end
  end
end
