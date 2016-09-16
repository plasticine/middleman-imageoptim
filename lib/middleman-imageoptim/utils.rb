module Middleman
  module Imageoptim
    module Utils
      def self.size_change_word(size_a, size_b)
        size_difference = (size_a - size_b)
        if size_difference > 0
          'smaller'
        elsif size_difference < 0
          'larger'
        else
          'no change'
        end
      end

      def self.percentage_change(size_a, size_b)
        '%.2f%%' % [100 - 100.0 * size_b / size_a]
      end

      def self.format_size(bytes)
        units = %w(B KiB MiB GiB TiB)
        if bytes.to_i < 1024
          exponent = 0
        else
          max_exp  = units.size - 1
          exponent = (Math.log(bytes) / Math.log(1024)).to_i
          exponent = max_exp if exponent > max_exp
          bytes /= 1024**exponent
        end
        "#{bytes}#{units[exponent]}"
      end

      def self.file_size_stats(source, destination)
        {
          source: source,
          percent_change: percentage_change(source.size, destination.size),
          size_change: format_size((source.size - destination.size)),
          size_change_type: size_change_word(source.size, destination.size)
        }
      end
    end
  end
end
