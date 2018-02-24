require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'should send email correctly' do
      subject = 'Foi compartilhada uma receita com você'
      user = create(:user, email: 'teste@gmail.com')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = create(:recipe, recipe_type: recipe_type,
                               user: user)

      mail = RecipesMailer.share('teste@gmail.com',
                                 'Olha essa receita',
                                 recipe.id)

      expect(mail.to).to include 'teste@gmail.com'
      expect(mail.subject).to eq subject
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'Olha essa receita'
      expect(mail.body).to include recipe_url(recipe)
    end
  end
end
