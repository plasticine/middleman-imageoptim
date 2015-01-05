module Middleman
  module Imageoptim
    class Manifest
      MANIFEST_FILENAME = 'imageoptim.manifest.bin'

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def path
        File.join(app.build_dir, MANIFEST_FILENAME)
      end

      def build_and_write(resources)
        write(dump(build(resources)))
      end

      def resource(key)
        resources[key.to_s]
      end

      private

      def build(resources)
        resources.inject({}) do |new_manifest, resource|
          new_manifest[resource.to_s] = File.mtime(resource)
          new_manifest
        end
      end

      def write(manifest)
        File.open(path, 'wb') do |manifest_file|
          manifest_file.write(manifest)
        end
      end

      def resources
        @resources ||= load(File.binread(path))
      end

      def dump(source)
        Marshal.dump(source)
      end

      def load(source)
        Marshal.load(source)
      end
    end
  end
end
