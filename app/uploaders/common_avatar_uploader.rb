# encoding: utf-8

class CommonAvatarUploader < BaseUploader
  process :resize_and_pad => [450, 450]

end
