# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Game.create(name: "Gears of War", owner: sophie)
Game.create(name: "Need For Speed", owner: sophie)