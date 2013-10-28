module Middleman
  module Imageoptim

    # An options store that handles default options will accept user defined
    # overrides
    class Options
      attr_accessor :user_options
      attr_reader :verbose, :nice, :threads, :image_extensions,
        :pngcrush_options, :pngout_options, :optipng_options, :advpng_options,
        :jpegoptim_options, :jpegtran_options, :gifsicle_options

      UserOptions = Struct.new(:verbose, :nice, :threads, :image_extensions,
        :pngcrush_options, :pngout_options, :optipng_options, :advpng_options,
        :jpegoptim_options, :jpegtran_options, :gifsicle_options)

      def initialize(options_hash = {})
        @user_options = UserOptions.new(*options_hash)
      end

      def verbose
        !@user_options.verbose.nil? ? @user_options.verbose : false
      end

      def nice
        !@user_options.nice.nil? ? @user_options.nice : true
      end

      def threads
        !@user_options.threads.nil? ? @user_options.threads : true
      end

      def image_extensions
        !@user_options.image_extensions.nil? ? @user_options.image_extensions : %w(.png .jpg .gif)
      end

      def pngcrush_options
        !@user_options.pngcrush_options.nil? ? @user_options.pngcrush_options : {:chunks => ['alla'], :fix => false, :brute => false}
      end

      def pngout_options
        !@user_options.pngout_options.nil? ? @user_options.pngout_options : {:copy_chunks => false, :strategy => 0}
      end

      def optipng_options
        !@user_options.optipng_options.nil? ? @user_options.optipng_options : {:level => 6, :interlace => false}
      end

      def advpng_options
        !@user_options.advpng_options.nil? ? @user_options.advpng_options : {:level => 4}
      end

      def jpegoptim_options
        !@user_options.jpegoptim_options.nil? ? @user_options.jpegoptim_options : {:strip => ['all'], :max_quality => 100}
      end

      def jpegtran_options
        !@user_options.jpegtran_options.nil? ? @user_options.jpegtran_options : {:copy_chunks => false, :progressive => true, :jpegrescan => true}
      end

      def gifsicle_options
        !@user_options.gifsicle_options.nil? ? @user_options.gifsicle_options : {:interlace => false}
      end
    end
  end
end
