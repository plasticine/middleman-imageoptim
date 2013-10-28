require "middleman-core"

module Middleman
  module Imageoptim
    class << self
      def registered(app, options_hash = {}, &block)
        options = Middleman::Imageoptim::Options.new(options_hash)
        yield options.user_options if block_given?

        app.after_build {|builder|
          Middleman::Imageoptim::Optimizer.new(app, builder, options).optimize!
        }
      end
      alias :included :registered
    end
  end
end
