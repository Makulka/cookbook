class Recipe < ApplicationRecord 
    has_many :user_recipes
    has_many :users, through: :user_recipes
    
    validates :title, presence: true, length: {minimum: 3, maximum: 50}
    validates :description, presence: true, length: {minimum: 3, maximum: 300}
    validates :creator_id, presence: true
    #validates :steps, presence: true, unless: ->(recipe){recipe.link.present?}
    #validates :link, presence: true, unless: ->(recipe){recipe.steps.present?}
    
    def self.search(param)
        param.strip.downcase!
        Recipe.where('title LIKE ?', "%#{param}%")
            .or(Recipe.where('description LIKE ?', "%#{param}%"))
            .or(Recipe.where('steps LIKE ?', "%#{param}%"))
            .or(Recipe.where('ingredients LIKE ?', "%#{param}%"))
    end
    
end