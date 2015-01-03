module Middleman
  module Imageoptim
    class ManifestResource < ::Middleman::Sitemap::Resource
      
      attr_accessor :output

      def initialize(store, path)
        super(store, path)
      end

      def template?
        false
      end

      def render(*args, &block)
        "manifest temp"
      end

      def source_file
        nil
      end
      # def request_path
      #   @request_path
      # end

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

