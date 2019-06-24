class PhotoImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :default do
    process :default_mogrify
  end

  version :thumbnail, :from_version => :default do
    process :resize_to_fit => [360, 360]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_whitelist
    %r{image/}
  end

  private

  def default_mogrify
    manipulate! do |img|
      img.combine_options do |c|
        c.auto_orient
        c.resize "1000x1000>"
        c.quality 80
      end

      img
    end
  end
end
