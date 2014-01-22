class Cat < ActiveRecord::Base
  attr_accessible :age, :birthday, :color, :name, :sex

  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :sex, :length => { :is => 1 }
end
