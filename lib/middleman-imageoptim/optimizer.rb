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
        images = updated_optimizable_images
        optimizer.optimize_images(images) do |source, destination|
          process_image(source, destination)
        end
        update_manifest(images)
        say_status 'Total savings: %{data}', data: Utils.format_size(byte_savings)
      end

      private

      def update_manifest(images)
        return unless options.manifest
        manifest.build_and_write(images)
        say_status '%{manifest_path} updated', manifest_path: manifest.path
      end

      def process_image(source, destination = nil)
        if destination
          update_bytes_saved(source.size - destination.size)
          say_status '%{source} (%{percent_change} / %{size_change} %{size_change_type})', Utils.file_size_stats(source, destination)
          FileUtils.mv(destination, source)
        else
          say_status '[skipped] %{source}', source: source
        end
      end

      def updated_optimizable_images
        build_files.select do |path|
          options.image_extensions.include?(File.extname(path)) &&
            optimizer.optimizable?(path) &&
            file_was_updated?(path)
        end
      end

      def file_was_updated?(file_path)
        return true unless options.manifest
        File.mtime(file_path) != manifest.resource(file_path)
      end

      def build_files
        ::Middleman::Util.all_files_under(app.build_dir)
      end

      def say_status(status, interpolations = {})
        builder.say_status(:imageoptim, status % interpolations) if builder
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
    end
  end
end
