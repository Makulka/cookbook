class User < ApplicationRecord 
    has_many :user_recipes
    has_many :recipes, through: :user_recipes
    
    before_save { self.email = email.downcase}
    
    validates :username, presence: true, uniqueness: { case_sensitive: false }, 
        length: { minimum: 3, maximum: 25 }
        
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, 
        length: { maximum: 105}, format: {with: VALID_EMAIL_REGEX }
        
    has_secure_password
    
    def has_not_this_recipe?(recipe_id)
        user_recipes.where(recipe_id: recipe_id).count < 1
    end
end