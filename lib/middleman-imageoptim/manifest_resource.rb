module Middleman
  module Imageoptim
    class ManifestResource < ::Middleman::Sitemap::Resource
      attr_accessor :output

      def template?
        false
      end

      def render(*_args, &_block)
        Marshal.dump({})
      end

      def source_file
        nil
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
    end
  end
end
