# encoding: utf-8

class ThumbUploader < BaseUploader

  process :thumb_pos

  def thumb_pos
    manipulate! do |img|
      if model.pos.present?
        c = ::MiniMagick::CommandBuilder.new(:convert)
        dst = Tempfile.new('thumb.jpg')
        dst.binmode
        dst.write model.ori_image.read
        dst.close

        c.push dst.path
        c.push '-crop'
        pos = model.pos.split(',')
        c.push "#{pos[2]}x#{pos[3]}+#{pos[0]}+#{pos[1]}"

        c.push img.path

        img.run(c)
      end
      img = yield(img) if block_given?
      img
    end
  end

end
