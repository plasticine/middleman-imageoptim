require 'spec_helper'
require_relative '../../lib/middleman-imageoptim/utils'

describe Middleman::Imageoptim::Utils do
  let(:size_src) { 1000 }
  let(:size_dst) { 1000 }

  describe '#size_change_word' do
    subject { described_class.size_change_word(size_src, size_dst) }

    context 'the destination file is the same size as the source file' do
      it 'should be the same size' do
        expect(subject).to eq('no change')
      end
    end

    context 'the destination file is smaller' do
      let(:size_dst) { 500 }
      it 'should be smaller' do
        expect(subject).to eq('smaller')
      end
    end

    context 'the destination file is larger' do
      let(:size_dst) { 1500 }
      it 'should be larger' do
        expect(subject).to eq('larger')
      end
    end
  end

  describe '#percentage_change' do
    subject { described_class.percentage_change(size_src, size_dst) }

    context 'the destination file is the same size as the source file' do
      it 'should be the same size' do
        expect(subject).to eq('0.00%')
      end
    end

    context 'the destination file is smaller' do
      let(:size_dst) { 500 }
      it 'should be smaller' do
        expect(subject).to eq('50.00%')
      end
    end

    context 'the destination file is larger' do
      let(:size_dst) { 1500 }
      it 'should be larger' do
        expect(subject).to eq('-50.00%')
      end
    end
  end
end
