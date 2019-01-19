class Comment < ApplicationRecord
    belongs_to :recipe
    
    validates :body, presence: true, length: {maximum: 300}
      
end
