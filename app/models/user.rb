class User < ApplicationRecord
    has_secure_password #This is the macro that will enable use of bcrypt to hash passwords during signup and login
    validates :username, presence: true, uniqueness: true #A username should be there and not two usernames should be the same
     
    has_many :recipes #This bit relates a user to many instance of recipes

end
