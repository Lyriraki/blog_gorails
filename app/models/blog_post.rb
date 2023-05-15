class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  # TODO: Pelajari lagi code lambda di bawah ini
  # scope :sorted, -> { order(published_at: :desc, updated_at: :desc) }
  # ! Intinya coding di atas tidak berjalan sebagaimana mestinya
  # ! Karena harusnya urutannya scheduled-publish-draft tapi coding di atas malah tidak berjalan
  # * Maka dari itu ada 2 opsi untuk melakukan query
  # * Pertama - Pakai raw Query dari PostgreSQL
  # * scope :sorted, -> { order(Arel.sql('published_at DESC NULLS LAST')).order(updated_at: :desc) }
  # * Kedua - Pakai Query Ruby
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at <= ?', Time.current) }
  scope :scheduled, -> { where('published_at > ?', Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
