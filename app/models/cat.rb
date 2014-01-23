class Cat < ActiveRecord::Base
  attr_accessible :age, :birthday, :color, :name, :sex, :user_id

  validates :age, :birthday, :color, :name, :sex, :presence => true
  validates :sex, :length => { :is => 1 }

  has_many(
    :rental_requests,
    :class_name => 'CatRentalRequest',
    :foreign_key => :cat_id,
    :primary_key => :id,
    :dependent => :destroy
  )

  belongs_to(
    :owner,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )


end
