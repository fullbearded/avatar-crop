class Image
  include Mongoid::Document

  field :ori_image
  field :thumbnail

  mount_uploader :ori_image, CommonAvatarUploader
  mount_uploader :thumbnail, ThumbUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

end
