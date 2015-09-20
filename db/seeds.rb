# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

elmo   = User.create!(user_name: "elmo", password: "password")
grouch = User.create!(user_name: "oscar", password: "password")
bbird  = User.create!(user_name: "bigbird", password: "password")

wl    = elmo.moderated_subs.create!(title: "Weightlifting", 
                                    description: "Lift weights?")
trash = grouch.moderated_subs.create!(title: "Trash Cans", 
                                    description: "My home")

tfw = trash.posts.create(author_id: grouch.id,
                         title: "tfw living in a trash can",
                         url: "http://i.imgur.com/B9Wn83f.png",
                         description: "i live in a trash can")