class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients, :method, :cuisine_id, presence: true
end
