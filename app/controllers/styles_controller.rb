class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit]
  def index
    @styles = Style.all
  end
  def show
    @beers = Beer.where(style_id: @style)
  end
  def edit
  end
  def set_style
    @style = Style.find(params[:id])
  end
end
