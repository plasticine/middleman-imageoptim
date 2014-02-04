module Middleman
  module Imageoptim
    require "image_optim"
    require "fileutils"

    # Optimizer class that accepts an options object and processes files and
    # passes them off to image_optim to be processed
    class Optimizer
      def initialize(app, builder, options)
        @app           = app
        @builder       = builder
        @options       = options
        @total_savings = 0
        @current_manifest = {}
        @previous_manifest = load_manifest || {}
      end

      def optimize!
        images_to_optimize = updated_file_paths(file_paths())

        #images_to_optimize.each do |file|
          #if File.mtime(file) == @previous_manifest[file.to_s]
            #say_status "[skipped] #{file}"
            #next
          #end
          #optimizer.optimize_image!(file)
          #@current_manifest[file.to_s] = File.mtime(file)
        #end
        
        optimizer.optimize_images(images_to_optimize) {|src_file, dst_file|
          if dst_file
            @total_savings += (src_file.size - dst_file.size)
            say_file_size_stats(src_file, dst_file)
            FileUtils.mv dst_file, src_file
          elsif @options.verbose
            say_status "[skipped] #{src_file}"
          end
        }
        build_and_write_manifest
        say_status "Total image savings: #{format_size(@total_savings)}"
      end

      def filter_file_paths(paths)
        paths.select {|path|
          is_image_extension(path.extname) && image_is_optimizable(path)
        }
      end

      def updated_file_paths(paths)
        filter_file_paths(paths).select{|path|
          File.mtime(path) != @previous_manifest[path.to_s]
        }
      end

      def is_image_extension(extension)
        @options.image_extensions.include?(extension)
      end

      def image_is_optimizable(path)
        optimizer.optimizable?(path)
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

      private

      def file_paths
        ::Middleman::Util.all_files_under(@app.inst.build_dir)
      end

      def manifest_path
        File.join(@app.inst.build_dir,"imageoptim.manifest.bin")
      end

      def build_and_write_manifest
        build_manifest
        write_manifest
      end

      def build_manifest
        files = filter_file_paths(file_paths())
        files.each do |file|
          @current_manifest[file.to_s] = File.mtime(file)
        end
      end

      def write_manifest
        File.open(manifest_path, 'w') {|f| f.write(serialized_manifest) }
      end

      def serialized_manifest
        YAML::dump(@current_manifest)
      end

      def load_manifest
        manifest = YAML::load( File.open(manifest_path).read )
      rescue Errno::ENOENT => e
        {}
      end

      def say_file_size_stats(src_file, dst_file)
        file_percent_change = percentage_change(src_file.size, dst_file.size)
        file_size_change = format_size((src_file.size - dst_file.size))
        file_size_change_type = size_change_word(src_file.size, dst_file.size)
        say_status "#{src_file} (#{file_percent_change} / #{file_size_change} #{file_size_change_type})"
      end

      def say_status(status)
        if @builder
          @builder.say_status :image_optim, status
        end
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

      def format_size(bytes)
        units = %W(B KiB MiB GiB TiB)

        if bytes.to_i < 1024
          exponent = 0
        else
          max_exp  = units.size - 1
          exponent = (Math.log(bytes) / Math.log(1024)).to_i
          exponent = max_exp if exponent > max_exp
          bytes  /= 1024 ** exponent
        end

        "#{bytes}#{units[exponent]}"
      end
    end
  end
end
