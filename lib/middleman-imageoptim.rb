require "middleman-core"
require "middleman-imageoptim/optimizer"
require "middleman-imageoptim/options"

::Middleman::Extensions.register(:imageoptim) do
  require "middleman-imageoptim/extension"
  ::Middleman::Imageoptim
end
