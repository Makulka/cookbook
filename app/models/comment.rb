class Comment < ApplicationRecord
    belongs_to :recipe
    
    validates :body, presence: true, length: {minimum: 3, maximum: 300}
      
end
