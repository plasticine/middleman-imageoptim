require "middleman-core"

module Middleman

  # Middleman extension entry point
  module Imageoptim
    class Extension < Middleman::Extension
      
      def initialize(app, options_hash = {}, &block)
        super
        options = Middleman::Imageoptim::Options.new(options_hash)
        yield options.user_options if block_given?
        app.after_configuration do

          app.after_build  do |builder|
            Middleman::Imageoptim::Optimizer.new(app, builder, options).optimize!
          end

        end
        @options = options
      end
      #alias :included :registered



      def manipulate_resource_list(resources)
        modified_resources = []
        resources.each do |resource|
          if build_up_to_date?(resource)

            modified_resources.push Middleman::Sitemap::Resource.new(@app.sitemap,resource.destination_path,File.join(@app.build_dir,resource.destination_path))
          else
            modified_resources.push resource
          end
        end
        mresource = nil
        mpath = "imageoptim.manifest.bin"
        if File.exist?( File.join(@app.build_dir,mpath) )
          mresource = Middleman::Sitemap::Resource.new(@app.sitemap,mpath,File.join(@app.build_dir,mpath).to_s)
        else
          mresource = Middleman::Imageoptim::ManifestResource.new(@app.sitemap,mpath)
        end
        modified_resources + [mresource]
      end

      def build_up_to_date?(resource)
        is_image_extension?(File.extname(resource.destination_path)) &&
          resource.class.name == "Middleman::Sitemap::Resource" &&
          File.exist?( File.join(@app.build_dir,resource.destination_path) ) &&
          File.mtime(File.join(@app.build_dir,resource.destination_path)) > File.mtime(resource.source_file)
          
      end

      def is_image_extension?(extension)
        @options.image_extensions.include?(extension)
      end

    end
  end
end
