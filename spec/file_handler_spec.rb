require File.expand_path('../spec_helper', __FILE__)

module AbsoluteRenamer
  describe FileHandler do
    let(:file_handler) { double('FileHandler') }

    before :each do
      @path = '/some/path/to/some/file.txt'
    end

    context 'constructor' do
      it "should wait for one parameter" do
        lambda { FileHandler.new }.should raise_error(ArgumentError)
      end

      it "should wait for a path as parameter" do
        FileHandler.new(@path).should be_a(FileHandler)
      end
    end

    
  end
end