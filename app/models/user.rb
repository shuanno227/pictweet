class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # tweetsテーブルとのアソシエーション
  has_many :tweets       
  # commentsテーブルとのアソシエーション
  has_many :comments
end
