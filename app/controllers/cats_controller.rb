class CatsController < ApplicationController
  def index
    @cats = Cat.all

    render :index
  end

  # def new
#   end

  def create
    @cat = Cat.new(params[:cat])
    if @cat.save
      flash[:notice] = "New cat created"
      redirect_to cat_url(@cat)
    else
      flash[:error] = "Invalid deets"
      redirect_to new_cat_url
    end
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end
end
