module Middleman
  module Imageoptim
    require 'image_optim'
    require 'fileutils'

    # Optimizer class that accepts an options object and processes files and
    # passes them off to image_optim to be processed
    class Optimizer
      attr_reader :app, :builder, :options, :byte_savings

      def self.optimize!(app, builder, options)
        new(app, builder, options).process_images
      end

      def initialize(app, builder, options)
        @app = app
        @builder = builder
        @options = options
        @byte_savings = 0
      end

      def process_images
        images = updated_images
        modes = preoptimize_modes(images)
        optimizer.optimize_images(images) do |source, destination|
          process_image(source, destination, modes.fetch(source.to_s))
        end
        update_manifest
        say_status 'Total savings: %{data}', data: Utils.format_size(byte_savings)
      end

      private

      def update_manifest
        return unless options.manifest
        manifest.build_and_write(optimizable_images)
        say_status '%{manifest_path} updated', manifest_path: manifest.path
      end

      def process_image(source, destination = nil, mode = nil)
        if destination
          update_bytes_saved(source.size - destination.size)
          say_status '%{source} (%{percent_change} / %{size_change} %{size_change_type})', Utils.file_size_stats(source, destination)
          FileUtils.move(destination, source)
        else
          skip_message = '[skipped] %{source} - optimized version is identical to source (may have been previously optimized)'
          say_status skip_message, source: source
        end
      ensure
        ensure_file_mode(mode, source) unless mode.nil?
      end

      def updated_images
        optimizable_images.select { |path| file_updated?(path) }
      end

      def optimizable_images
        build_files.select do |path|
          options.image_extensions.include?(File.extname(path)) && optimizer.optimizable?(path)
        end
      end

      def file_updated?(file_path)
        return true unless options.manifest
        File.mtime(file_path) != manifest.resource(file_path)
      end

      def preoptimize_modes(images)
        images.inject({}) do |modes, image|
          modes[image.to_s] = get_file_mode(image)
          modes
        end
      end

      def build_files
        ::Middleman::Util.all_files_under(build_dir)
      end

      def build_dir
        if Gem::Version.new(Middleman::VERSION) >= Gem::Version.new('4.0.0')
          app.config[:build_dir]
        else
          app.build_dir
        end
      end

      def say_status(status, interpolations = {})
        builder_thor.say_status(:imageoptim, status % interpolations) if builder
      end

      def builder_thor
        if Gem::Version.new(Middleman::VERSION) >= Gem::Version.new('4.0.0')
          builder.thor
        else
          builder
        end
      end

      def optimizer
        @optimizer ||= ImageOptim.new(options.imageoptim_options)
      end

      def manifest
        @manifest ||= Manifest.new(app)
      end

      def update_bytes_saved(bytes)
        @byte_savings += bytes
      end

      def get_file_mode(file)
        sprintf('%o', File.stat(file).mode)[-4, 4].gsub(/^0*/, '')
      end

      def ensure_file_mode(mode, file)
        return if mode == get_file_mode(file)
        FileUtils.chmod(mode.to_i(8), file)
        say_status 'fixed file mode on %{file} file to match source', file: file
      end
    end
  end
end
