class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorites
  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients, :method, :cuisine_id, presence: true

  has_attached_file :image , styles: {default: "500x300" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]



end
