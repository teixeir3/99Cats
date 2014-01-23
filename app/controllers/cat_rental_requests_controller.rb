class CatRentalRequestsController < ApplicationController
  before_filter :require_ownership, :only => [:approve, :deny]

  def new
    #needs to build but not save a new cat
    @rental_request = CatRentalRequest.new
  end

  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end

  def approve
    if @rental_request.approve!
      redirect_to cat_url(@rental_request.cat)
    else
      flash[:error] = "Overlapping bookings!"
      redirect_to cat_url(@rental_request.cat)
    end
  end

  def deny
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat)
  end

  private

  def require_ownership
    @rental_request = CatRentalRequest.find(params[:id])
    unless @rental_request.cat_owner.id == current_user.id
      flash[:error] = "Cannot edit someone else's cat!"
      redirect_to cat_url(@rental_request.cat)
    end
  end
end
