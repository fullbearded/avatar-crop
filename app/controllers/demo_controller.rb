class DemoController < ApplicationController
  def index
    @image = Image.last
    render layout: false
  end

  def show
    render layout: false
  end
end
