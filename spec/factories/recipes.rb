FactoryBot.define do
  factory :recipe do
    title 'Bolo de cenoura'
    association :cuisine
    association :user
    difficulty 'Fácil'
    cook_time 60
    ingredients 'Farinha, açucar e ovo'
    recipe_type 'Sobremesa'
    add_attribute(:method) { 'Misturar tudo e assar' }
  end
end
