class User < ApplicationRecord 
    has_many :user_recipes
    has_many :recipes, through: :user_recipes
    
    has_many :friendships
    has_many :friends, through: :friendships
    
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
    
    def self.search(param, ignore_user)
        param.strip.downcase!
        User.where('first_name LIKE ?', "%#{param}%")
            .or(User.where('last_name LIKE ?', "%#{param}%"))
            .or(User.where('email LIKE ?', "%#{param}%"))
            .where.not(id: ignore_user.id)
    end
    
    def not_friends_with?(friend_id)
        friendships.where(friend_id: friend_id).count < 1
    end
    
    def self.find_created_recipes(current_user_id)
        Recipe.where(creator_id: current_user_id)
    end
    
    def count_created_recipes(user_id)
        Recipe.where(creator_id: user_id).count
    end
end