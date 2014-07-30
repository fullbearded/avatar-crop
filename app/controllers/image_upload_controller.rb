class ImageUploadController < ApplicationController
  protect_from_forgery with: :null_session

  def upload_origin_image
    image = Image.new(ori_image: uploaded_file)
    image.save
    render json: {img: 'http://localhost:3000' + image.ori_image_url, id: image.id.to_s}
  end

  def upload_thumbnail
    image = Image.last
    image.thumb(x: params[:x], y: params[:y], w: params[:w], h: params[:h])
    image.save
    render json: {img: 'http://localhost:3000' + image.thumbnail_url}
  end

  private

  def uploaded_file
    params['file-object']
  end

end
