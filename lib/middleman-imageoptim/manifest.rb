module Middleman
  module Imageoptim
    class Manifest
      MANIFEST_FILENAME = 'imageoptim.manifest.yml'.freeze

      attr_reader :app, :path_option

      def initialize(app, path_option = nil)
        @app = app
        @path_option = path_option
      end

      def path
        @path ||= File.join(base_path, MANIFEST_FILENAME)
      end

      def build_dir
        if Gem::Version.new(Middleman::VERSION) >= Gem::Version.new('4.0.0')
          app.config[:build_dir]
        else
          app.build_dir
        end
      end

      def build_and_write(new_resources)
        write(dump(build(new_resources)))
      end

      def resource(key)
        resources[key.to_s]
      end

      private

      def base_path
        if path_option.present?
          path_option
        else
          build_dir
        end
      end

      def resources
        @resources ||= begin
          if File.exist?(path)
            YAML.load_file(path)
          else
            {}
          end
        end
      end

      def dump(source)
        YAML.dump(source)
      end

      def build(resources)
        resources.inject({}) do |new_manifest, resource|
          new_manifest[resource.to_s] = File.mtime(resource)
          new_manifest
        end
      end

      def write(manifest)
        FileUtils.mkpath(base_path) unless File.exists?(path)

        File.open(path, 'w') do |manifest_file|
          manifest_file.write(manifest)
        end
      end
    end
  end
end
