require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit the chef show page' do
    before :each do
      @chef1 = Chef.create!(
        name: 'Chef Doom'
      )

      @chef2 = Chef.create!(
        name: 'Chef Cool'
      )

      @dish1 = Dish.create!(
        name: 'Best Dish',
        description: 'I am the best dish ever',
        chef_id: @chef1.id
      )

      @dish2 = Dish.create!(
        name: 'Second Best Dish',
        description: 'I am the second best dish ever',
        chef_id: @chef2.id
      )

      ingredient1 = Ingredient.create!(
        name: 'Dish1 ingredient 1',
        calories: 10
      )

      ingredient2 = Ingredient.create!(
        name: 'Dish1 ingredient 2',
        calories: 20
      )

      ingredient3 = Ingredient.create!(
        name: 'Dish2 ingredient 1',
        calories: 15
      )

      DishIngredient.create!(dish_id: @dish1.id, ingredient_id: ingredient1.id)
      DishIngredient.create!(dish_id: @dish1.id, ingredient_id: ingredient2.id)
      DishIngredient.create!(dish_id: @dish2.id, ingredient_id: ingredient3.id)
    end
    it 'it has the name of the chef' do
      visit "/chef/#{@chef1.id}"

      expect(page).to have_content('Chef Name: Chef Doom')
    end

    it 'chas a link to see all ingredients that this chef uses in dishes' do
      visit "/chef/#{@chef1.id}"

      click_on 'Ingredients I Use'

      expect(current_path).to eq("/chef/#{@chef1.id}/ingredients")
      expect(page).to have_content('Ingredients:')
      expect(page).to have_content('Dish1 ingredient 1')
      expect(page).to have_content('Dish1 ingredient 2')
    end
  end
end
