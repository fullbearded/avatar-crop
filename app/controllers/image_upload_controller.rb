class ImageUploadController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create_avatar
    image = Image.new(ori_image: uploaded_file)
    image.save
    render json: {origin_avatar: 'http://localhost:3000' + image.ori_image_url}
  end

  def update_avatar
    image = Image.last
    image.attributes = params.permit(:crop_x, :crop_y, :crop_w, :crop_h)
    if params[:uploaded] == 'true'
      image.thumbnail = image.ori_image
    else
      image.thumbnail? ? image.thumbnail.recreate_versions! : image.thumbnail = File.new(Rails.root.join('app','assets', 'images', 'avatar.jpg'))
    end
    image.save
    render json: {avatar: 'http://localhost:3000' + image.thumbnail_url(:thumb)}
  end

  private

  def uploaded_file
    params['file-object']
  end

end
