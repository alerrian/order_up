require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit the dish show page' do
    before :each do
      chef1 = Chef.create!(
        name: 'Chef Doom'
      )

      chef2 = Chef.create!(
        name: 'Chef Cool'
      )

      @dish1 = Dish.create!(
        name: 'Best Dish',
        description: 'I am the best dish ever',
        chef_id: chef1.id
      )

      @dish2 = Dish.create!(
        name: 'Second Best Dish',
        description: 'I am the second best dish ever',
        chef_id: chef2.id
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

    it 'it shows me the name of the chef that made that dish' do
      visit "/dish/#{@dish1.id}"

      within "#dish_chef" do
        expect(page).to have_content('Chef Name: Chef Doom')
      end

      visit "/dish/#{@dish2.id}"

      within "#dish_chef" do
        expect(page).to have_content('Chef Name: Chef Cool')
      end
    end

    it 'shows me the ingredients in a dish' do
      visit "/dish/#{@dish1.id}"

      within "#dish_ingredients" do
        expect(page).to have_content('Ingredients:')
        expect(page).to have_content('Dish1 ingredient 1')
        expect(page).to have_content('Dish1 ingredient 2')
      end

      visit "/dish/#{@dish2.id}"

      within "#dish_ingredients" do
        expect(page).to have_content('Ingredients:')
        expect(page).to have_content('Dish2 ingredient 1')
      end
    end

    it 'can see calorie count for dish' do
      visit "/dish/#{@dish1.id}"

      within "#calories" do
        expect(page).to have_content('Dish Calorie Count: 30')
      end

      visit "/dish/#{@dish2.id}"

      within "#calories" do
        expect(page).to have_content('Dish Calorie Count: 15')
      end
    end
  end
end
