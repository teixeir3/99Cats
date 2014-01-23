# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

doug = User.new(:user_name => "Doug")
doug.password = "123456"
doug.save

alex = User.new(:user_name => "Alex")
alex.password = "password"
alex.save

darcy = Cat.new(:name => "Darcy", :color => "gray", :age => 3,
                :sex => "m", :birthday => 20091123, :user_id => 1)
darcy.save

first_req  = CatRentalRequest.new(:cat_id => darcy.id, :start_date => 20140201, :end_date => 20140301)
second_req = CatRentalRequest.new(:cat_id => darcy.id, :start_date => 20140222, :end_date => 20140224)

first_req.approve!