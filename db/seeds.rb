User.create(name: "giapb",email: "giapb@mail.com", password:"Aa123456")

90.times do |x|
  User.create(name: "username #{x}", email: "email#{x}@mail.com", password:"Bb123456")
end

users = User.all
users.each do |u|
  20.times do |x|
    e = u.entries.build title: "The tittle #{x}", content: "This is content of #{x}"
    e.save
  end
end

entries = Entry.all
entries.each do |e|
  50.times do |i|
    r = rand 50
    c = e.comments.build user_id: r,content: "this is comment #{i}"
    c.save
  end
end

1000.times do |x|
  r1 = rand 89
  r2 = rand 89
  u1 = User.find_by id: r1
  u2 = User.find_by id: r2
  u1.follow u2
end
