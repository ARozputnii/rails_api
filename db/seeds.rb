p "Seeding 20 books"
20.times do |n|
  book = Book.create(title: Faker::Book.title,
              author:  Faker::Book.author,
              image: Faker::Avatar.image)
  p "Book #{book.title} was created!"
end