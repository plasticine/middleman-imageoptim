require 'middleman-core'

module Middleman
  # Middleman extension entry point
  module Imageoptim
    class Extension < Middleman::Extension
      if Gem::Version.new(Middleman::VERSION) >= Gem::Version.new('4.0.0')
        option :advpng, { level: 4 }, ''
        option :allow_lossy, false, ''
        option :gifsicle, { interlace: false }, ''
        option :image_extensions, %w(.png .jpg .jpeg .gif .svg), ''
        option :jpegoptim, { strip: ['all'], max_quality: 100 }, ''
        option :jpegtran, { copy_chunks: false, progressive: true, jpegrescan: true }, ''
        option :nice, true, ''
        option :manifest, true, ''
        option :optipng, { level: 6, interlace: false }, ''
        option :pack, true, ''
        option :pngcrush, { chunks: ['alla'], fix: false, brute: false }, ''
        option :pngout, { copy_chunks: false, strategy: 0 }, ''
        option :skip_missing_workers, true, ''
        option :svgo, {}, ''
        option :threads, true, ''
        option :verbose, false, ''
      end

      def after_build(builder)
        Middleman::Imageoptim::Optimizer.optimize!(app, builder, options)
      end

      def manipulate_resource_list(resources)
        return resources unless options.manifest
        Middleman::Imageoptim::ResourceList.manipulate(app, resources, options)
      end

      private

      def setup_options(options_hash = {}, &_block)
        if Gem::Version.new(Middleman::VERSION) >= Gem::Version.new('4.0.0')
          super
        else
          @options = Middleman::Imageoptim::Options.new(options_hash)
          yield @options if block_given?
          @options.freeze
        end
      end
    end
  end
end
