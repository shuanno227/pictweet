class Comment < ApplicationRecord
  # tweetsテーブルとのアソシエーション
  belongs_to :tweet
  # usersテーブルとのアソシエーション
  belongs_to :user
end
