class CatRentalRequestsController < ApplicationController

  def new
    #needs to build but not save a new cat
    @rental_request = CatRentalRequest.new
  end

  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end
end
