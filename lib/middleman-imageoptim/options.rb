module Middleman
  module Imageoptim
    # An options store that handles default options will accept user defined
    # overrides
    class Options
      # Mapping of valid option names to default values
      EXTENSION_OPTIONS = [
        :image_extensions,
        :manifest
      ].freeze
      OPTIONS = {
        advpng: { level: 4 },
        allow_lossy: false,
        gifsicle: { interlace: false },
        image_extensions: %w(.png .jpg .jpeg .gif .svg),
        jpegoptim: { strip: ['all'], max_quality: 100 },
        jpegtran: { copy_chunks: false, progressive: true, jpegrescan: true },
        nice: true,
        manifest: true,
        optipng: { level: 6, interlace: false },
        pack: true,
        pngcrush: { chunks: ['alla'], fix: false, brute: false },
        pngout: { copy_chunks: false, strategy: 0 },
        skip_missing_workers: true,
        svgo: {},
        threads: true,
        verbose: false
      }.freeze

      attr_accessor *OPTIONS.keys.map(&:to_sym)

      def initialize(user_options = {})
        set_options(user_options)
      end

      def imageoptim_options
        Hash[instance_variables.map do |name|
          [symbolize_key(name), instance_variable_get(name)]
        end].reject { |key| EXTENSION_OPTIONS.include?(key) }
      end

      private

      def symbolize_key(key)
        key.to_s[1..-1].to_sym
      end

      def set_options(user_options)
        OPTIONS.keys.each do |name|
          instance_variable_set(:"@#{name}", user_options.fetch(name, OPTIONS[name]))
        end
      end
    end
  end
end
