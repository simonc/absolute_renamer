require 'absolute_renamer'

module AbsoluteRenamer
  describe NameMaker do
    subject { NameMaker.new }

    it { should respond_to :interpreters }
    it { should respond_to :interpreters= }

    describe '#initialize' do
      it "should set the interpreters Array" do
        interpreters = %w(interpreter1 interpreter2)
        name_maker   = NameMaker.new(interpreters)

        name_maker.interpreters.should be(interpreters)
      end
    end

    describe '#new_value_for' do
      let(:interpreter1) { Interpreters::SimpleInterpreter.new('a', 'x') }
      let(:interpreter2) { Interpreters::SimpleInterpreter.new('b', 'y') }
      let(:interpreters) { [interpreter1, interpreter2] }
      let(:path_handler) { Object.new }

      subject { NameMaker.new(interpreters) }

      it "should call search_and_replace on every interpreter" do
        interpreter1.should_receive(:search_and_replace)
        interpreter2.should_receive(:search_and_replace)

        subject.new_value_for :name, 'aa_bb', path_handler
      end

      it "should update the current value between each interpreter call" do
        interpreter2.should_receive(:search_and_replace)
                    .with(:name, 'xx_bb', path_handler)

        subject.new_value_for :name, 'aa_bb', path_handler
      end

      it "should return the interpreted value" do
        subject.new_value_for(:name, 'aa_bb', path_handler).should == 'xx_yy'
      end
    end
  end
end
