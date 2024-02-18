# frozen_string_literal: true

ActiveRecord::Base.transaction do
  images = %w[bulletin_0 bulletin_1 bulletin_2 bulletin_3 bulletin_4]

  User.create!(email: Faker::Internet.email, name: Faker::Name.name)
  users = User.all

  8.times do
    Category.create!(name: Faker::Lorem.unique.sentence)
  end
  categories = Category.all

  states = Bulletin.aasm.states.map(&:name)

  200.times do
    b = Bulletin.new(
      title: Faker::Lorem.unique.sentence.slice(...50),
      description: Faker::Lorem.unique.paragraph.slice(...1000),
      user: users.sample,
      category: categories.sample,
      state: states.sample
    )

    filename = "#{images.sample}.jpg"
    b.image.attach(
      io: File.open("test/fixtures/files/#{filename}"),
      filename:
    )
    b.save!
  end
end
