class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :favorites
  has_many :favorite_recipes, through: :favorites, source: :recipe
  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end

  def owner?(recipe)
    email == recipe.user.email
  end
end
