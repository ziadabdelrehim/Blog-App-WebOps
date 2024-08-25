class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    # This line enables password hashing and authentication features
    has_secure_password
    
    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :image, presence: true


    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
  
   
  end
  