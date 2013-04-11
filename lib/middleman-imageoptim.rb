require "middleman-core"
require "image_optim"
require "fileutils"

module MiddlemanImageoptim
  class << self
    def registered(app, options={})
      app.set :threads, 8
      app.set :image_extensions, %w(.png .jpg .gif)

      app.after_build do |builder|
        image_optim = ImageOptim.new(:threads => threads)
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
            percent_change = '%5.2f%% %s' % [100 - 100.0 * dst.size / src.size, (src.size - dst.size)]
            builder.say_status :optimise, "#{src} (#{number_to_human_size((src.size - dst.size).abs)} / #{percent_change} #{size_change_word})"
            FileUtils.mv(dst, src)
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
