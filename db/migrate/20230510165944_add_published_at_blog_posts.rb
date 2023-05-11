class AddPublishedAtBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :published_at, :datetime
  end
end

# * Migration ini berfungsi untuk menambahkankan kolom baru di database blog_post dengan nama
# * published_at dan dengan tipe datetime
