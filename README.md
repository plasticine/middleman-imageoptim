# Middleman ImageOptim Extension

## Wat.

Serving big images is fo numb-skulls! Compress and optimise your imagery during `middleman build` by running [image_optim](https://github.com/toy/image_optim) over it. Yay-hooray!

![](http://cl.ly/image/0h0b330F2p3C/Terminal%20%E2%80%94%20zsh%20%E2%80%94%20109%C3%9712.png)

## Installation

Go set up the [image_optim](https://github.com/toy/image_optim) external utilities, then;

```ruby
gem "middleman-imageoptim", "~> 0.0.4"
```

## Usage

```ruby
activate :image_optim
```

You can also configure the extension in the usual fashion, by passing a block to `:activate`
Below is the default configuration showing all available options;

```ruby
activate :image_optim do |options|
  # print out skipped images
  options[:verbose] = false

  # Setting these to true or nil will let image_optim determine them (recommended)
  options[:nice] = true
  options[:threads] = true

  # Image extensions to attempt to compress
  options[:image_extensions] = [".png", ".jpg", ".gif"]

  # compressor worker options, individual optimisers can be disabled by passing false instead of a hash
  options[:pngcrush]  = {:chunks => ['alla'], :fix => false, :brute => false}
  options[:pngout]    = {:copy_chunks => false, :strategy => 0}
  options[:optipng]   = {:level => 6, :interlace => false}
  options[:advpng]    = {:level => 4}
  options[:jpegoptim] = {:strip => ['all'], :max_quality => 100}
  options[:jpegtran]  = {:copy_chunks => false, :progressive => true, :jpegrescan => true}
  options[:gifsicle]  = {:interlace => false}
end
```

Without block
```ruby
activate :image_optim, :pngout => false
```
