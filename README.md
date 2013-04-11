# Middleman ImageOptim Extension

## Wat.

Compress and optimise your imagery during `middleman build` by running [image_optim](https://github.com/toy/image_optim) over it. Yay-hooray!

## Installation

Go set up the [image_optim](https://github.com/toy/image_optim) external utilities, then;

```ruby
gem "middleman-imageoptim", "0.0.3"
```

## Usage

```ruby
activate :image_optim
```

You can also configure the extension in the usual fashion, by passing a block to `:activate`
Below is the default configuration showing all available options;

```ruby
activate :image_optim do |image_optim|
  # print out skipped images
  image_optim.verbose = false

  # Setting these to true or nil will let image_optim determine them (recommended)
  image_optim.nice = true
  image_optim.threads = true

  # Image extensions to attempt to compress
  image_optim.image_extensions = %w(.png .jpg .gif)

  # compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  image_optim.pngcrush_options = {:chunks => ['alla'], :fix => false, :brute => false}
  image_optim.pngout_options = {:copy_chunks => false, :strategy => 0}
  image_optim.optipng_options = {:level => 6, :interlace => false}
  image_optim.advpng_options = {:level => 4}
  image_optim.jpegoptim_options = {:strip => ['all'], :max_quality => 100}
  image_optim.jpegtran_options = {:copy_chunks => false, :progressive => true, :jpegrescan => true}
  image_optim.gifsicle_options = {:interlace => false}
end
```
