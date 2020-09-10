require 'middleman-core/application'
require 'middleman-core/sitemap/resource'

module Middleman
  module Imageoptim
    class ManifestResource < ::Middleman::Sitemap::Resource
      attr_accessor :output

      def template?
        false
      end

      def render(*_args, &_block)
        manifest_content
      end

      def binary?
        false
      end

      def raw_data
        {}
      end

      def ignored?
        false
      end

      private

      def manifest_content
        path = File.join(@app.config[:build_dir], @destination_path)
        if !File.exist?(path)
          YAML.dump({})
        else
          File.read(path)
        end
      end
    end
  end
end
