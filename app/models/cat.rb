class Cat < ActiveRecord::Base
  attr_accessible :age, :birthday, :color, :name, :sex

  validates :age, :birthday, :color, :name, :sex, :presence => true
  validates :sex, :length => { :is => 1 }

  has_many(
    :rental_requests,
    :class_name => 'CatRentalRequest',
    :foreign_key => :cat_id,
    :primary_key => :id,
    :dependent => :destroy
  )
end
