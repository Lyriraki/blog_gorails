# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# TODO: Kamu Harus pelajari fungsi dari file ini.
user = User.where(email: 'lyriraki@gmail.com').first_or_initialize
user.update!(
  password: 'lyriraki21',
  password_confirmation: 'lyriraki21'
)

# * Untuk membuat 100 data sekaligus, hanya untuk uji coba pagination, Jadi cukup run sekali
# 100.times do |i|
#   BlogPost.create title: "Blog Post #{i}", content: "Hello World My Man", published_at: Time.current
# end

# * Sama dengan coding di atas, hanya saja, ini tidak membuat data baru, dan hanya mereset data yang sudah ada. Jadi data tetap akan berjumlah 100
100.times do |i|
  blog_post = BlogPost.where(title: "Blog Post #{i}").first_or_initialize
  blog_post.update(content: "Hello World My Man", published_at: Time.current)
end