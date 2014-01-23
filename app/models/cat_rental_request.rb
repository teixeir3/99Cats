class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  before_validation :make_pending_status

  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { :in => %w(PENDING APPROVED DENIED),
    :message => "%{value} is not a valid status"}
    validate :not_overlapped
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

    def pending?
      self.status == "PENDING"
    end

    def overlapping_approved_requests
      overlapping_requests.where("status = 'APPROVED'")
    end

    def overlapping_pending_requests
      # returns array of overlapping pending requests
      overlapping_requests.where("status = 'PENDING'")
    end

    def not_overlapped
      !overlapping_approved_requests.empty?
    end

    def make_pending_status
      self.status ||= "PENDING"
    end

    def approve!
      # move request status from pending to approved
      # save
      #deny all conflicting requests
      # do this saving in single transaction

      transaction do
        self.status = "APPROVED"
        self.save!


        overlapping_pending_requests.each do |request|
          request.deny!
        end
      end
    end

    def deny!
      self.status = "DENIED"
      self.save!
    end
end
