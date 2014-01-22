class CatsController < ApplicationController
  def index
    @cats = Cat.all

    render :index
  end

  # def new
#   end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

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

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(params[:cat])
      flash[:notice] = "#{@cat.name}'s deets updated"
      redirect_to cat_url(@cat)
    else
      flash[:error] = "Invalid deets"
      redirect_to edit_cat_url(@cat)
    end
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end
end
