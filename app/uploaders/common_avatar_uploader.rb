# encoding: utf-8

class CommonAvatarUploader < BaseUploader
  process :resize_and_pad => [700, 465]

end
