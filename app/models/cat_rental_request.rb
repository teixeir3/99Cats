class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { :in => %w(PENDING APPROVED DENIED),
    :message => "%{value} is not a valid status"}
end
