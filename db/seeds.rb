User.create(name: "giapb",email: "giapb@mail.com", password:"Aa123456")

90.times do |x|
  User.create(name: Faker::Name.name, email: "email#{x}@mail.com", password:"Bb123456")
end

users = User.all
users.each do |u|
  11.times do |x|
    e = u.entries.build title: Faker::Lorem.sentence, content: Faker::Lorem.sentence
    e.save
  end
end

entries = Entry.all
entries.each do |e|
  21.times do |i|
    r = rand 90
    c = e.comments.build user_id: r,content: Faker::Lorem.question
    c.save
  end
end

10.times do |x|
  u1 = User.find_by id: r1
  u2 = User.find_by id: r2
  u1.follow u2 unless (r1 == r2 or r1 * r2 == 0)
end
