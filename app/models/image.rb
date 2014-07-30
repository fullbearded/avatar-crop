class Image
  include Mongoid::Document

  field :ori_image
  field :thumbnail
  field :pos

  mount_uploader :ori_image, CommonAvatarUploader
  mount_uploader :thumbnail, ThumbUploader

  def thumb(options)
    self.pos = options.slice(*%w|x y w h|.map(&:to_sym)).values.join(',')

    self.thumbnail = self.ori_image
  end
end
