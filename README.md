# Middleman ImageOptim Extension

Serving big images is for numb-skulls! Compress and optimise your imagery during `middleman build` by running [image_optim](https://github.com/toy/image_optim) over it. Aww yiss!

[![Build Status](https://travis-ci.org/plasticine/middleman-imageoptim.png?branch=master)](https://travis-ci.org/plasticine/middleman-imageoptim)
[![Code Climate](https://codeclimate.com/github/plasticine/middleman-imageoptim.png)](https://codeclimate.com/github/plasticine/middleman-imageoptim)
[![Gem Version](https://badge.fury.io/rb/middleman-imageoptim.png)](http://badge.fury.io/rb/middleman-imageoptim)
[![Dependency Status](https://gemnasium.com/plasticine/middleman-imageoptim.png)](https://gemnasium.com/plasticine/middleman-imageoptim)

![](http://cl.ly/image/0h0b330F2p3C/Terminal%20%E2%80%94%20zsh%20%E2%80%94%20109%C3%9712.png)

* * *

## Installation

Go set up the [image_optim](https://github.com/toy/image_optim) external utilities, then;

### Middleman < 4.0
```ruby
gem 'middleman-imageoptim'
```

### Middleman ≥ 4.0

```ruby
gem "middleman-imageoptim", :git => "https://github.com/plasticine/middleman-imageoptim", :branch => "master"
```

## Usage

```ruby
activate :imageoptim
```

You can also configure the extension in the usual fashion, by passing a block to `:activate`
Below is the default configuration showing all available options;

```ruby
activate :imageoptim do |options|
  # Use a build manifest to prevent re-compressing images between builds
  options.manifest = true

  # Silence problematic image_optim workers
  options.skip_missing_workers = true

  # Cause image_optim to be in shouty-mode
  options.verbose = false

  # Setting these to true or nil will let options determine them (recommended)
  options.nice = true
  options.threads = true

  # Image extensions to attempt to compress
  options.image_extensions = %w(.png .jpg .gif .svg)

  # Compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  options.advpng    = { :level => 4 }
  options.gifsicle  = { :interlace => false }
  options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
  options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  options.optipng   = { :level => 6, :interlace => false }
  options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
  options.pngout    = { :copy_chunks => false, :strategy => 0 }
  options.svgo      = {}
end
```

***

## Changelog

##### `0.2.1`
- Minor bugfix for 3.3.9 support.

##### `0.2.0`
- Big cleanup to codebase.
- More tests.
- Caching between builds using a manifest file to skip over already-compressed assets (thanks for your work on this @jagthedrummer).
- Updates `image_optim` gem to latest version (`0.20.2`).
- Adds dependency on `image_optim_pack` to ensure that binaries are available.

##### `0.1.4`
- Respect plugin ordering in config.rb (thanks @jeffutter) [#8](https://github.com/plasticine/middleman-imageoptim/pull/8).

##### `0.1.3`
- Fix missing license in gemspec.

##### `0.1.2`
- Minor bugfix.

##### `0.1.1`
- Remove legacy requirement for padrino.

##### `0.1.0`
- Complete refactor and clean-up.
- Introduced an options class. options now work (lol, yay!), thanks @andrew-aladev for your help there.
- Change of extension activation name from `:image_optim` to `:imageoptim` for consistency with internal naming.
