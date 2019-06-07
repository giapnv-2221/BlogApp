User.create(name: "giapb",email: "giapb@mail.com", password:"Aa123456")

9.times do |x|
  User.create(name: "username #{x}", email: "email#{x}@mail.com", password:"Bb123456")
end

users = User.all
users.each do |u|
  9.times do |x|
    e = u.entries.build title: "The tittle #{x}", content: "This is content of #{x}"
    e.save
  end
end

entries = Entry.all
entries.each do |e|
  5.times do |i|
    r = rand 5
    c = e.comments.build user_id: r,content: "this is comment #{i}"
    c.save
  end
end
