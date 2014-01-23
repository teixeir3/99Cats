class CatsController < ApplicationController
  before_filter :require_ownership, :only => [:edit, :update]

  def index
    @cats = Cat.all
    # fail
    render :index
  end

  def new
    #needs to build but not save a new cat
    @cat = Cat.new

    render :new
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def create
    @cat = Cat.new(params[:cat])
    @cat.user_id = current_user.id

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
      p @cat.errors
      flash[:notice] = "#{@cat.name}'s deets updated"
      redirect_to cat_url(@cat)
    else
      flash[:error] = "Invalid deets"
      redirect_to edit_cat_url(@cat)
    end
  end

  def show
    @cat = Cat.find(params[:id])
    @rental_request = @cat.rental_requests.select(&:pending?).first

    render :show
  end

  private

  def require_ownership
    unless params[:cat][:user_id] == current_user.id
      flash[:error] = "Cannot edit someone else's cat!"
      redirect_to cat_url(@cat)
    end
  end
end
