class CoverImageUploader < CommonUploader
  include CarrierWave::MiniMagick

  process resize_to_fit: [600, 600]

  def store_dir
    if model.class.to_s.in?(Article::TYPES)
      return "uploads/article/cover_image/#{model.id}"
    end
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :optimize

  def optimize
    manipulate! do |img|
      return img unless img.mime_type.match /image\/jpeg/
      img.combine_options do |c|
        c.strip
        c.quality '80'
        c.depth '8'
        c.interlace 'plane'
      end
      img
    end
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
