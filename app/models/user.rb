class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ! devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # ! Alasan kenapa :registerable ku hapus supaya tidak ada user luar yang membuat akun baru di blog milikku
  # * Alangkah baiknya untuk memasukkan data user melalui console saja
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
