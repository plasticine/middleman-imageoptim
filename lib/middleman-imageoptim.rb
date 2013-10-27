require "middleman-core"
require "image_optim"
require "fileutils"

module Middleman
  module ImageOptim
    class << self
      @@defaults = {
        :verbose => false,
        :nice    => true,
        :threads => true,
        :image_extensions => [".png", ".jpg", ".gif"],
        :pngcrush  => {:chunks => ["alla"], :fix => false, :brute => false},
        :pngout    => {:copy_chunks => false, :strategy => 0},
        :optipng   => {:level => 6, :interlace => false},
        :advpng    => {:level => 4},
        :jpegoptim => {:strip => ["all"], :max_quality => 100},
        :jpegtran  => {:copy_chunks => false, :progressive => true, :jpegrescan => true},
        :gifsicle  => {:interlace => false}
      }
      def registered(app, options_hash={}, &block)
        options = @@defaults.merge(options_hash)
        yield options if block_given?

        app.after_build do |builder|
          verbose          = options[:verbose]
          image_extensions = options[:image_extensions]
          
          options.delete(:verbose)
          options.delete(:image_extensions)
          image_optim = ::ImageOptim.new(options)
          
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
end

::Middleman::Extensions.register(:image_optim) do
  ::Middleman::ImageOptim
end
