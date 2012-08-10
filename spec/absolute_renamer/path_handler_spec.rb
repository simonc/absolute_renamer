require 'absolute_renamer/path_handler'

module AbsoluteRenamer
  describe PathHandler do
    let(:config) { Hash[:dots, 1] }
    let(:name_maker) { NameMaker.new }
    let(:renamer) { Renamer.new(config) }
    let(:sandbox) { File.expand_path('../../support/sandbox', __FILE__) }
    let(:path_handler) { PathHandler.new path, config }

    subject { path_handler }

    context "with a default path" do
      let(:path) { '/path/to/a/file.ext' }

      it { should respond_to :path }
      it { should respond_to :new_name= }
      it { should respond_to :new_extension= }

      its(:dirname)       { should == '/path/to/a' }
      its(:extension)     { should == 'ext' }
      its(:filename)      { should == 'file.ext' }
      its(:name)          { should == 'file' }
      its(:new_extension) { should == path_handler.extension }
      its(:new_filename)  { should == path_handler.filename }
      its(:new_name)      { should == path_handler.name }
      its(:new_path)      { should == path_handler.path }

      describe '#initialize' do
        its(:path) { should be(path) }
      end

      describe '#rename!' do
        it "should call rename on the passed renamer with self as argument" do
          renamer.should_receive(:rename).with(subject)

          subject.rename! renamer
        end
      end

      describe '#set_new_extension!' do
        let(:config) { Hash[:dots, 1, :'ext-format', '$'] }

        it "should use the passed name_maker to get the new extension" do
          name_maker.should_receive(:new_value_for).with(:extension, '$', path_handler)

          subject.set_new_extension! name_maker
        end

        it "should set the extension of the path_handler" do
          name_maker.stub(:new_value_for).and_return('new-ext')

          subject.set_new_extension! name_maker
          subject.new_extension.should == 'new-ext'
        end
      end

      describe '#set_new_name!' do
        let(:config) { Hash[:dots, 1, :format, '$'] }

        it "should use the passed name_maker to get the new name" do
          name_maker.should_receive(:new_value_for).with(:name, '$', path_handler)

          subject.set_new_name! name_maker
        end

        it "should set the extension of the path_handler" do
          name_maker.stub(:new_value_for).and_return('new-name')

          subject.set_new_name! name_maker
          subject.new_name.should == 'new-name'
        end
      end

      context "with config set to no-extension = true" do
        let(:config) { Hash[:dots, 1, :'no-extension', true] }

        its(:new_path) { should == '/path/to/a/file' }
      end
    end

    context "when wrapping a file" do
      let(:path) { File.join sandbox, 'file_1.txt' }

      its(:directory?) { should be_false }
    end

    context "when wrapping a file with no extension" do
      let(:path) { File.join sandbox, 'file_4' }

      its(:directory?) { should be_false }
      its(:name) { should == 'file_4' }
      its(:extension) { should be_nil }
      its(:new_filename) { should == 'file_4' }

      context "when an extension format is specified in the config" do
        let(:config) { Hash[:dots, 1, :'ext-format', 'txt'] }

        it "should be able to generate a new_extension" do
          subject.set_new_path! name_maker
          subject.new_filename.should == 'file_4.txt'
        end
      end
    end

    context "when wrapping a directory" do
      let(:path)  { File.join sandbox, 'directory_1' }

      its(:directory?) { should be_true }

      context "when compared with another directory path_handler" do
        let(:path_handler2) { PathHandler.new path2, config }

        context "having the same dirname" do
          let(:path2) { File.join sandbox, 'directory_2' }

          it "should sort them by name" do
            [path_handler, path_handler2].sort.should == [path_handler, path_handler2]
          end
        end

        context "being parents" do
          let(:path2) { File.join sandbox, 'directory_1', 'directory_11' }

          it "should sort them by dirname in descendant order" do
            [path_handler, path_handler2].sort.should == [path_handler2, path_handler]
          end
        end
      end
    end
  end
end
