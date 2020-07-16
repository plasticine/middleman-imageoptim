require 'middleman-core'
require 'middleman-imageoptim/optimizer'
require 'middleman-imageoptim/options'
require 'middleman-imageoptim/resource_list'
require 'middleman-imageoptim/utils'
require 'middleman-imageoptim/manifest'
require 'middleman-imageoptim/manifest_resource'

::Middleman::Extensions.register(:imageoptim) do
  require 'middleman-imageoptim/extension'
  ::Middleman::Imageoptim::Extension
end
