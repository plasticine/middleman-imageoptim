require_relative "../../lib/middleman-imageoptim/options"

describe Middleman::Imageoptim::Options do
  subject { Middleman::Imageoptim::Options.new(options_hash) }
  let(:options_hash) { {} }

  describe "default options" do
    its(:verbose) { should be_false }
    its(:nice) { should be_true }
    its(:threads) { should be_true }
    its(:image_extensions) { should == ['.png', '.jpg', '.gif'] }
    its(:pngcrush_options) { should == {:chunks => ['alla'], :fix => false, :brute => false} }
    its(:pngout_options) { should == {:copy_chunks => false, :strategy => 0} }
    its(:optipng_options) { should == {:level => 6, :interlace => false} }
    its(:advpng_options) { should == {:level => 4} }
    its(:jpegoptim_options) { should == {:strip => ['all'], :max_quality => 100} }
    its(:jpegtran_options) { should == {:copy_chunks => false, :progressive => true, :jpegrescan => true} }
    its(:gifsicle_options) { should == {:interlace => false} }
  end

  describe "with user options" do
    describe "#verbose" do
      let(:options_hash) { {verbose: true} }
      subject { options.verbose().should be_true }
    end

    describe "#nice" do
      let(:options_hash) { {nice: false} }
      subject { options.nice().should be_false }
    end

    describe "#threads" do
      let(:options_hash) { {threads: false} }
      subject { options.threads().should be_false }
    end

    describe "#image_extensions" do
      let(:options_hash) { {image_extensions: ['.gif']} }
      subject { options.image_extensions().should == ['.gif'] }
    end

    describe "#pngcrush_options" do
      let(:options_hash) { {pngcrush_options: {foo: 'bar'}} }
      subject { options.pngcrush_options().should == {foo: 'bar'} }
    end

    describe "#pngout_options" do
      let(:options_hash) { {pngout_options: {foo: 'bar'}} }
      subject { options.pngout_options().should == {foo: 'bar'} }
    end

    describe "#optipng_options" do
      let(:options_hash) { {optipng_options: {foo: 'bar'}} }
      subject { options.optipng_options().should == {foo: 'bar'} }
    end

    describe "#advpng_options" do
      let(:options_hash) { {advpng_options: {foo: 'bar'}} }
      subject { options.advpng_options().should == {foo: 'bar'} }
    end

    describe "#jpegoptim_options" do
      let(:options_hash) { {jpegoptim_options: {foo: 'bar'}} }
      subject { options.jpegoptim_options().should == {foo: 'bar'} }
    end

    describe "#jpegtran_options" do
      let(:options_hash) { {jpegtran_options: {foo: 'bar'}} }
      subject { options.jpegtran_options().should == {foo: 'bar'} }
    end

    describe "#gifsicle_options" do
      let(:options_hash) { {gifsicle_options: {foo: 'bar'}} }
      subject { options.gifsicle_options().should == {foo: 'bar'} }
    end
  end
end
