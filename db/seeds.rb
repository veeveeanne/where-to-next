destination1 = Destination.create(name: "Lincoln Center", state: "New York")
destination2 = Destination.create(name: "Art Institute of Chicago", state: "Illinois")
destination3 = Destination.create(name: "Gateway Arch", state: "Missouri")

user1 = User.create(email: "hello1@email.com", first_name: "Vivian", last_name: "Wang", location: "Boston", password: "abcdef")
user2 = User.create(email: "hello2@email.com", first_name: "Isaac", last_name: "Chen", location: "Bellevue", password: "123456")

Listing.create(destination: destination1, user: user1)
Listing.create(destination: destination1, user: user2)
Listing.create(destination: destination2, user: user1)
Listing.create(destination: destination3, user: user2)
