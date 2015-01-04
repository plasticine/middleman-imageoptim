require 'spec_helper'
require_relative '../../lib/middleman-imageoptim/options'

describe Middleman::Imageoptim::Options do
  let(:options_hash) { {} }
  let(:instance) { described_class.new(options_hash) }
  subject { instance }

  describe 'default options' do
    its(:verbose) { should be_falsey }
    its(:nice) { should be_truthy }
    its(:threads) { should be_truthy }
    its(:skip_missing_workers) { should be_truthy }
    its(:allow_lossy) { should be_falsey }
    its(:image_extensions) { should == ['.png', '.jpg', '.jpeg', '.gif', '.svg'] }
    its(:pngcrush) { should == { chunks: ['alla'], fix: false, brute: false } }
    its(:pngout) { should == { copy_chunks: false, strategy: 0 } }
    its(:optipng) { should == { level: 6, interlace: false } }
    its(:advpng) { should == { level: 4 } }
    its(:jpegoptim) { should == { strip: ['all'], max_quality: 100 } }
    its(:jpegtran) { should == { copy_chunks: false, progressive: true, jpegrescan: true } }
    its(:gifsicle) { should == { interlace: false } }
    its(:svgo) { should == {} }
  end

  describe 'getting options for imageoptim' do
    describe '#imageoptim_options' do
      subject { instance.imageoptim_options }
      let(:options_hash) do
        { verbose: true, manifest: false, image_extensions: ['.gif'] }
      end
      it do
        is_expected.to eql(
          advpng: { level: 4 },
          allow_lossy: false,
          gifsicle: { interlace: false },
          jpegoptim: { strip: ['all'], max_quality: 100 },
          jpegtran: { copy_chunks: false, progressive: true, jpegrescan: true },
          nice: true,
          optipng: { level: 6, interlace: false },
          pack: true,
          pngcrush: { chunks: ['alla'], fix: false, brute: false },
          pngout: { copy_chunks: false, strategy: 0 },
          skip_missing_workers: true,
          svgo: {},
          threads: true,
          verbose: true
        )
      end
    end
  end

  describe 'with user options' do
    describe '#verbose' do
      subject { instance.verbose }
      let(:options_hash) { { verbose: true } }
      it { is_expected.to be_truthy }
    end

    describe '#nice' do
      subject { instance.nice }
      let(:options_hash) { { nice: false } }
      it { is_expected.to be_falsey }
    end

    describe '#threads' do
      subject { instance.threads }
      let(:options_hash) { { threads: false } }
      it { is_expected.to be_falsey }
    end

    describe '#image_extensions' do
      subject { instance.image_extensions }
      let(:options_hash) { { image_extensions: ['.gif'] } }
      it { is_expected.to eq(['.gif']) }
    end

    describe '#pngcrush_options' do
      subject { instance.pngcrush }
      let(:options_hash) { { pngcrush: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#pngout' do
      subject { instance.pngout }
      let(:options_hash) { { pngout: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#optipng' do
      subject { instance.optipng }
      let(:options_hash) { { optipng: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#advpng' do
      subject { instance.advpng }
      let(:options_hash) { { advpng: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#jpegoptim' do
      subject { instance.jpegoptim }
      let(:options_hash) { { jpegoptim: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#jpegtran' do
      subject { instance.jpegtran }
      let(:options_hash) { { jpegtran: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#gifsicle' do
      subject { instance.gifsicle }
      let(:options_hash) { { gifsicle: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end

    describe '#svgo' do
      subject { instance.svgo }
      let(:options_hash) { { svgo: { foo: 'bar' } } }
      it { is_expected.to eq(foo: 'bar') }
    end
  end
end
