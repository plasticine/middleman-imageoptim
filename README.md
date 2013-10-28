# Middleman ImageOptim Extension

## Wat.

Serving big images is fo numb-skulls! Compress and optimise your imagery during `middleman build` by running [image_optim](https://github.com/toy/image_optim) over it. Yay-hooray!

[![Build Status](https://travis-ci.org/plasticine/middleman-imageoptim.png?branch=master)](https://travis-ci.org/plasticine/middleman-imageoptim)
[![Coverage Status](https://coveralls.io/repos/plasticine/middleman-imageoptim/badge.png)](https://coveralls.io/r/plasticine/middleman-imageoptim)
[![Gem Version](https://badge.fury.io/rb/middleman-imageoptim.png)](http://badge.fury.io/rb/middleman-imageoptim)
[![Dependency Status](https://gemnasium.com/plasticine/middleman-imageoptim.png)](https://gemnasium.com/plasticine/middleman-imageoptim)

![](http://cl.ly/image/0h0b330F2p3C/Terminal%20%E2%80%94%20zsh%20%E2%80%94%20109%C3%9712.png)

## Installation

Go set up the [image_optim](https://github.com/toy/image_optim) external utilities, then;

```ruby
gem "middleman-imageoptim", "~> 0.1.0"
```

## Usage

```ruby
activate :imageoptim
```

You can also configure the extension in the usual fashion, by passing a block to `:activate`
Below is the default configuration showing all available options;

```ruby
activate :imageoptim do |options|
  # print out skipped images
  options.verbose = false

  # Setting these to true or nil will let options determine them (recommended)
  options.nice = true
  options.threads = true

  # Image extensions to attempt to compress
  options.image_extensions = %w(.png .jpg .gif)

  # compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  options.pngcrush_options  = {:chunks => ['alla'], :fix => false, :brute => false}
  options.pngout_options    = {:copy_chunks => false, :strategy => 0}
  options.optipng_options   = {:level => 6, :interlace => false}
  options.advpng_options    = {:level => 4}
  options.jpegoptim_options = {:strip => ['all'], :max_quality => 100}
  options.jpegtran_options  = {:copy_chunks => false, :progressive => true, :jpegrescan => true}
  options.gifsicle_options  = {:interlace => false}
end
```

***

## Changelog

##### `0.1.0`
- complete refactor and clean-up
- introduced an options class. options now work (lol, yay!), thanks @andrew-aladev for your help there
- change of extension activation name from `:image_optim` to `:imageoptim` for consistency with internal naming
