# user
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             screen_name: "example")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               screen_name: "example_#{n+1}")
end

User.create!(name: "komori", email: "thekomori1113@gmail.com",
             password: "konmori",
             password_confirmation: "konmori",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             screen_name: "komori")


# micropost
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    reply_content = "@#{user.screen_name} #{Faker::Lorem.sentence(5)}"
    post = user.microposts.create!(content: content)
    post2 = user.microposts.create!(content: reply_content)
    Reply.create do |r|
      r.destination_id = post.id
      r.micropost_id = post2.id
    end
  end
end


# relationship
users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}


#notification
komori = User.last
followers.each { |follower| follower.follow(komori) }


# group, group_user
users = User.all
groups = []
50.times do |n|
  group = Group.create!(name: "group-#{n+1}",
                        detail: "group-#{n+1}")
  users[n+1].join_group_by_admin(group.id)
  groups << group
end
user = User.first
groups.each do |group|
  user.join_group_by_member(group.id)
end


# group_comment
groups.each do |group|
  group.users.each do |user|
    Comment.create!(body: "Hi, I'm #{user.name}.",
                    user_id: user.id,
                    group_id: group.id)
  end
end


# book
komori = User.last
user = User.first
book1 = Book.create do |n|
  n.title = "メタプログラミングRuby"
  n.content = "説明"
end
book2 = Book.create do |n|
  n.title = "book2"
  n.content = "説明"
end
books = [book1, book2]

# chapter
books.each do |book|
  5.times do |n|
    book.chapters.create do |c|
      c.title = "chapter-#{n+1}"
    end
  end
end

# book_user
books.each_with_index do |book, i|
  book.book_users.create do |n|
    n.user_id = user.id
    n.role = i + 1
  end
end
books.reverse.each_with_index do |book, i|
  book.book_users.create do |n|
    n.user_id = komori.id
    n.role = i + 1
  end
end

# reading_progresses
book_users = BookUser.all
book_users.each do |bookuser|
  bookuser.book.chapters.each_with_index do |chapter, i|
    ReadingProgress.create do |n|
      n.book_user_id = bookuser.id
      n.chapter_id = chapter.id
    end
  end
end
