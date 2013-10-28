require "middleman-core"
require "middleman-imageoptim/optimizer"
require "middleman-imageoptim/options"

::Middleman::Extensions.register(:imageoptim) do
  require "middleman-imageoptim/extension"
  ::Middleman::Imageoptim
end

::Middleman::Extensions.register(:image_optim) do
  warn ":image_optim is deprecated. Please use `:imageoptim` instead."

  require "middleman-imageoptim/extension"
  ::Middleman::Imageoptim
end
