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
        if @source_file.nil?
          YAML.dump({})
        else
          File.read(@source_file)
        end
      end
    end
  end
end
