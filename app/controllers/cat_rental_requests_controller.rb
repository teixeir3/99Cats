class CatRentalRequestsController < ApplicationController

  def new
    #needs to build but not save a new cat
    @rental_request = CatRentalRequest.new
  end

  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end

  def approve
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.approve!
    redirect_to cat_url(@rental_request.cat)
  end

  def deny
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat)
  end
end
