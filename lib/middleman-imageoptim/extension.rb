require 'middleman-core'

module Middleman
  # Middleman extension entry point
  module Imageoptim
    class Extension < Middleman::Extension
      def after_build(builder)
        Middleman::Imageoptim::Optimizer.optimize!(app, builder, options)
      end

      def manipulate_resource_list(resources)
        return resources unless options.manifest
        Middleman::Imageoptim::ResourceList.manipulate(app, resources, options)
      end

      private

      def setup_options(options_hash = {}, &_block)
        @options = Middleman::Imageoptim::Options.new(options_hash)
        yield @options if block_given?
        @options.freeze
      end
    end
  end
end
