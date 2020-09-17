20.times do |n|
  book = Book.create(title: Faker::Book.title,
              author:  Faker::Book.author,
              image: Faker::Avatar.image)
  p "Book #{book.title} was created!"
end

10.times do |n|
  user = User.create(email: Faker::Internet::email,
                     password: '123123123')
  p "User #{user.email} was created!"
end

100.times do |n|
  review = Review.create(title: Faker::Book.genre,
                          content_rating: rand(1..10),
                          recommend_rating: rand(1..10),
                          book_id: rand(1..20),
                          user_id: rand(1..10))
  p "Review #{review.title} was created!"
end
