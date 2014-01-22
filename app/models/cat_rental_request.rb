class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { :in => %w(PENDING APPROVED DENIED),
    :message => "%{value} is not a valid status"}

    # Add association with cats
    belongs_to(
      :cat,
      :class_name => 'Cat',
      :foreign_key => :cat_id,
      :primary_key => :id
    )

    def overlapping_requests
      # it conflicts with ours if some other rental's start_date is before our end_date and after our start_date
      # OR if their end date
      CatRentalRequest.where("(cat_id = ?) AND NOT
                      ((start_date > ?) OR (end_date < ?))", cat_id, end_date, start_date)
    end

    def overlapping_approved_requests
      overlapping_requests.where("status = 'APPROVED'")
    end
end
