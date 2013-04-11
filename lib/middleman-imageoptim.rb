require "middleman-core"
require "image_optim"
require "fileutils"

module MiddlemanImageoptim
  class << self
    def registered(app, options={})
      app.set :verbose, false
      app.set :nice, true
      app.set :threads, true
      app.set :image_extensions, %w(.png .jpg .gif)
      app.set :pngcrush_options, {:chunks => ['alla'], :fix => false, :brute => false}
      app.set :pngout_options, {:copy_chunks => false, :strategy => 0}
      app.set :optipng_options, {:level => 6, :interlace => false}
      app.set :advpng_options, {:level => 4}
      app.set :jpegoptim_options, {:strip => ['all'], :max_quality => 100}
      app.set :jpegtran_options, {:copy_chunks => false, :progressive => true, :jpegrescan => true}
      app.set :gifsicle_options, {:interlace => false}

      app.after_build do |builder|
        image_optim = ImageOptim.new(
          :nice => nice,
          :threads => threads,
          :pngcrush => pngcrush_options,
          :pngout => pngout_options,
          :optipng => optipng_options,
          :advpng => advpng_options,
          :jpegoptim => jpegoptim_options,
          :jpegtran => jpegtran_options,
          :gifsicle => gifsicle_options
        )
        optimizable_paths = []
        paths = ::Middleman::Util.all_files_under(self.class.inst.build_dir)

        # iterate over all the paths in the middleman build directory
        paths.each do |path|

          # reject non-image extension paths
          next unless image_extensions.include? path.extname

          # check that we can handle this image
          if image_optim.optimizable?(path.to_s)
            optimizable_paths << path
          else
            builder.say_status :img_optim, "skipping #{path} as it is not an image or there is no optimizer for it"
          end
        end

        # start compressing image assets
        image_optim.optimize_images(optimizable_paths) do |src, dst|
          if dst
            size_change_word = (src.size - dst.size) > 0 ? 'smaller' : 'larger'
            percent_change = '%.2f%%' % [100 - 100.0 * dst.size / src.size]
            builder.say_status :img_optimise, "#{src} (#{percent_change} / #{number_to_human_size((src.size - dst.size).abs)} #{size_change_word})"
            FileUtils.mv(dst, src)
          elsif verbose
            builder.say_status :img_optimise, "#{src} (skipped)"
          end
        end
      end
    end
    alias :included :registered
  end
end

::Middleman::Extensions.register(:image_optim) do
  ::MiddlemanImageoptim
end
