# encoding: utf-8

class ThumbUploader < BaseUploader

  version :thumb do
    process :crop
  end

  version :thumb_small do
    process :crop
    process :resize_to_limit => [30, 30]
  end

  def crop
    if model.crop_x.present?
      manipulate! do |img|
        img.crop "#{model.crop_w}x#{model.crop_h}+#{model.crop_x}+#{model.crop_y}"
        img = yield(img) if block_given?
        img
      end
    end
  end

end
