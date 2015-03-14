# encoding: utf-8

describe Hexx::CLI::Name do

  describe ".new" do

    it "requires an argument" do
      expect { described_class.new    }.to     raise_error
      expect { described_class.new "" }.not_to raise_error
      expect { described_class.new "", "" }.to raise_error
    end

  end # describe .new

  let(:a) { described_class.new nil }
  let(:b) { described_class.new "cats" }
  let(:c) { described_class.new "cats.names" }
  let(:d) { described_class.new "cats-wildcats/jaguars::PantherTiger" }
  let(:e) { described_class.new "cats-wildcats/jaguars::PantherTigers" }
  let(:f) { described_class.new "cats-wildcats/jaguars::PantherTiger.a.B.c" }

  describe "#item" do

    it "returns a proper value" do
      expect(a.item).to eq ""
      expect(b.item).to eq "cat"
      expect(c.item).to eq "cat"
      expect(d.item).to eq "panther_tiger"
      expect(e.item).to eq "panther_tiger"
      expect(f.item).to eq "panther_tiger"
    end

  end # describe #item

  describe "#items" do

    it "returns a proper value" do
      expect(a.items).to eq ""
      expect(b.items).to eq "cats"
      expect(c.items).to eq "cats"
      expect(d.items).to eq "panther_tigers"
      expect(e.items).to eq "panther_tigers"
      expect(f.items).to eq "panther_tigers"
    end

  end # describe #items

  describe "#file" do

    it "returns a proper value" do
      expect(a.file).to eq ""
      expect(b.file).to eq "cats"
      expect(c.file).to eq "cats.names"
      expect(d.file).to eq "cats-wildcats-jaguars-panther_tiger"
      expect(e.file).to eq "cats-wildcats-jaguars-panther_tigers"
      expect(f.file).to eq "cats-wildcats-jaguars-panther_tiger.a.b.c"
    end

  end # describe #file

  describe "#path" do

    it "returns a proper value" do
      expect(a.path).to eq ""
      expect(b.path).to eq "cats"
      expect(c.path).to eq "cats.names"
      expect(d.path).to eq "cats/wildcats/jaguars/panther_tiger"
      expect(e.path).to eq "cats/wildcats/jaguars/panther_tigers"
      expect(f.path).to eq "cats/wildcats/jaguars/panther_tiger.a.b.c"
    end

  end # describe #path

  describe "#type" do

    it "returns a proper value" do
      expect(a.type).to eq ""
      expect(b.type).to eq "Cats"
      expect(c.type).to eq "Cats.names"
      expect(d.type).to eq "Cats::Wildcats::Jaguars::PantherTiger"
      expect(e.type).to eq "Cats::Wildcats::Jaguars::PantherTigers"
      expect(f.type).to eq "Cats::Wildcats::Jaguars::PantherTiger.a.b.c"
    end

  end # describe #type

  describe "#const" do

    it "returns a proper value" do
      expect(a.const).to eq ""
      expect(b.const).to eq "Cats"
      expect(c.const).to eq "Cats.names"
      expect(d.const).to eq "PantherTiger"
      expect(e.const).to eq "PantherTigers"
      expect(f.const).to eq "PantherTiger.a.b.c"
    end

  end # describe #const

  describe "#namespaces" do

    it "returns a proper value" do
      expect(a.namespaces).to eq %w()
      expect(b.namespaces).to eq %w()
      expect(c.namespaces).to eq %w()
      expect(d.namespaces).to eq %w(Cats Wildcats Jaguars)
      expect(e.namespaces).to eq %w(Cats Wildcats Jaguars)
      expect(f.namespaces).to eq %w(Cats Wildcats Jaguars)
    end

  end # describe #namespaces

end # describe Hexx::Name
