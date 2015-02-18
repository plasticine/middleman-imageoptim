require 'middleman-core/application'

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

      def metadata
        @local_metadata.dup
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
