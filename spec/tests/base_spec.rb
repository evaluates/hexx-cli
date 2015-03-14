# encoding: utf-8

# See settings for :sandbox and :capture tags in `config/initializers` folder
describe Hexx::CLI::Base do

  # source path is set to spec/fixtures
  let(:fixtures) { ::File.expand_path "../../fixtures", __FILE__ }
  before { allow(described_class).to receive(:source_root).and_return fixtures }

  describe ".new" do

    it "constructs Thor::Group instance" do
      expect(subject).to be_kind_of Thor::Group
    end

    it "constructs Thor::Actions instance" do
      expect(subject).to be_kind_of Thor::Actions
    end

  end # describe .new

  describe "##source_root" do

    it "returns a source root" do
      expect(subject.send :source_root)
        .to eq described_class.send(:source_root)
    end

  end # describe ##source_root

  describe "#copy_folder", :sandbox, :capture do

    shared_examples "copying files" do

      # target should be described in context

      it "[copy file as is]" do
        expect("#{ target }/subfolder/alfa.yml").to be_present_in_sandbox
      end

    end # examples

    shared_examples "removing last .erb only" do

      # target should be described in context

      it "[removes last .erb]" do
        expect("#{ target }/gamma.rb").to be_present_in_sandbox
      end

      it "[leaves previous .erb]" do
        expect("#{ target }/delta.erb").to be_present_in_sandbox
      end

    end # examples

    shared_examples "removing first underscores only" do

      it "[removes first _]" do
        expect("#{ target }/.beta").to be_present_in_sandbox
      end

      it "[leaves later _]" do
        expect("#{ target }/_omega").to be_present_in_sandbox
      end

    end # examples

    shared_examples "preprocessing ERB only" do

      # target should be described in context

      it "[preprocesses erb]" do
        content = read_in_sandbox("#{ target }/gamma.rb")
        expect(content).not_to include "<%= 2 * 2 -%>"
        expect(content).to include "4"
      end

      it "[leaves non-erb]" do
        content = read_in_sandbox("#{ target }/.beta")
        expect(content).to include "<%= 2 * 2 -%>"
        expect(content).not_to include "4"
      end

    end # examples

    context "when the target isn't set" do

      let(:target) { "root" }

      before { try_in_sandbox { subject.send :copy_folder, "root" } }

      it_behaves_like "copying files"
      it_behaves_like "removing last .erb only"
      it_behaves_like "removing first underscores only"
      it_behaves_like "preprocessing ERB only"

    end # context

    context "with the target is set" do

      let(:target) { "spec" }

      before { try_in_sandbox { subject.send :copy_folder, "root", target } }

      it_behaves_like "copying files"
      it_behaves_like "removing last .erb only"
      it_behaves_like "removing first underscores only"
      it_behaves_like "preprocessing ERB only"

    end # context

  end # describe ##copy_folder

  describe "#from_template", :sandbox, :capture do

    let(:content) { subject.send :from_template, "root/_.beta" }

    it "returns the ERB-preprocessed content of the template" do
      expect(content).not_to include "<%= 2 * 2 -%>"
      expect(content).to include "4"
    end

  end # describe ##from_template

end # describe Hexx::Generator
