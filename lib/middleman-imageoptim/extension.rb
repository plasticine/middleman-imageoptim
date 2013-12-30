require "middleman-core"

module Middleman

  # Middleman extension entry point
  module Imageoptim
    class << self
      def registered(app, options_hash = {}, &block)
        options = Middleman::Imageoptim::Options.new(options_hash)
        yield options.user_options if block_given?

        app.after_configuration do

          app.after_build  do |builder|
            Middleman::Imageoptim::Optimizer.new(app, builder, options).optimize!
          end

        end

      end
      alias :included :registered
    end
  end
end
