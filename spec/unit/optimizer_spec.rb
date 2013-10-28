require_relative "../../lib/middleman-imageoptim/optimizer"

describe Middleman::Imageoptim::Optimizer do
  subject(:optimizer) { Middleman::Imageoptim::Optimizer.new(app, builder, options) }
  let(:options) { Middleman::Imageoptim::Options.new() }
  let(:app) { double }
  let(:builder) { double }
  let(:size_src) { 1000 }
  let(:size_dst) { 1000 }

  describe "#size_change_word" do
    subject { optimizer.size_change_word(size_src, size_dst) }

    context "the destination file is the same size as the source file" do
      it "should be the same size" do
        subject.should == 'no change'
      end
    end

    context "the destination file is smaller" do
      let(:size_dst) { 500 }
      it "should be smaller" do
        subject.should == 'smaller'
      end
    end

    context "the destination file is larger" do
      let(:size_dst) { 1500 }
      it "should be larger" do
        subject.should == 'larger'
      end
    end
  end

  describe "#percentage_change" do
    subject { optimizer.percentage_change(size_src, size_dst) }

    context "the destination file is the same size as the source file" do
      it "should be the same size" do
        subject.should == "0.00%"
      end
    end

    context "the destination file is smaller" do
      let(:size_dst) { 500 }
      it "should be smaller" do
        subject.should == "50.00%"
      end
    end

    context "the destination file is larger" do
      let(:size_dst) { 1500 }
      it "should be larger" do
        subject.should == '-50.00%'
      end
    end
  end
end
