class DishIngredients < ApplicationRecord
  belongs_to :dish
  belongs_to :ingredient
end
