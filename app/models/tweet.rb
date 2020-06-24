class Tweet < ApplicationRecord
  validates :text, presence: true
  # usersテーブルとのアソシエーション
  belongs_to :user
  # commentsテーブルとのアソシエーション
  has_many :comments

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end
end
