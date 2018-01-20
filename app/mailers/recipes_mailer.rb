class RecipesMailer < ActionMailer::Base
  default from: 'no-reply@cookbook.com'

  def share(email, message, recipe_id)
    @message = message
    @recipe = Recipe.find(recipe_id)
    mail(to: email, subject: 'Foi compartilhada uma receita com você')
  end
end
