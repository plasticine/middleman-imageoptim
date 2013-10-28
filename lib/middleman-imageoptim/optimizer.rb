module Middleman
  module Imageoptim
    require "image_optim"
    require "fileutils"
    require "padrino-helpers"

    class Optimizer
      include ::Padrino::Helpers::NumberHelpers

      def initialize(app, builder, options)
        @app           = app
        @builder       = builder
        @options       = options
        @total_savings = 0
      end

      def optimize!
        images_to_optimize = filter_file_paths(file_paths())
        optimizer.optimize_images(images_to_optimize) {|src_file, dst_file|
          if dst_file
            @total_savings += (src_file.size - dst_file.size)
            say_status "#{src_file} (#{percentage_change(src_file.size, dst_file.size)} / #{format_size((src_file.size - dst_file.size))} #{size_change_word(src_file.size, dst_file.size)})"
            FileUtils.mv dst_file, src_file
          elsif @options.verbose
            say_status "[skipped] #{src_file}"
          end
        }
        say_status "Total image savings: #{format_size(@total_savings)}"
      end

      def say_status(status)
        if @builder
          @builder.say_status :image_optim, status
        end
      end

      def file_paths
        ::Middleman::Util.all_files_under(@app.inst.build_dir)
      end

      def filter_file_paths(paths)
        paths.select {|path|
          is_image_extension(path.extname) && image_is_optimizable(path)
        }
      end

      def is_image_extension(extension)
        @options.image_extensions.include?(extension)
      end

      def image_is_optimizable(path)
        optimizer.optimizable?(path)
      end

      def format_size(bytes)
        number_to_human_size(bytes)
      end

      def size_change_word(size_src, size_dst)
        size_difference = (size_src - size_dst)
        if size_difference > 0
          'smaller'
        elsif size_difference < 0
          'larger'
        else
          'no change'
        end
      end

      def percentage_change(size_src, size_dst)
        '%.2f%%' % [100 - 100.0 * size_dst / size_src]
      end

      def optimizer
        @optimizer ||= ImageOptim.new(
          :nice      => @options.nice,
          :threads   => @options.threads,
          :pngcrush  => @options.pngcrush_options,
          :pngout    => @options.pngout_options,
          :optipng   => @options.optipng_options,
          :advpng    => @options.advpng_options,
          :jpegoptim => @options.jpegoptim_options,
          :jpegtran  => @options.jpegtran_options,
          :gifsicle  => @options.gifsicle_options
        )
      end
    end
  end
end
