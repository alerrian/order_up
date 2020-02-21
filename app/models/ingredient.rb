class Ingredient < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :calories

  has_many :dish_ingredients
  has_many :dishes, through: :dish_ingredients

  def self.uniq_ingredient_list
    order(name: :asc).distinct.pluck(:name)
  end
end
