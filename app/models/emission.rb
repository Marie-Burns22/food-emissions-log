class Emission < ApplicationRecord
  belongs_to :food
  belongs_to :student

  validates :unit, :presence => true
  validates :amount, :presence => true
  validates :source, :presence => true

  #accepts_nested_attributes_for :food

  # scope :kg_unit, -> { where(unit: "kg CO2e per lb of food") }
  # scope :lb_unit, -> { where(unit: "lbs of CO2e per serving") }
  # scope :g_unit, -> { where(unit: "g of CO2e per serving")}
  # scope :kg_protein_unit, -> { where(unit: "kg of CO2 per 50 g of protein")}

  scope :category, -> (category) {where("food.category LIKE ?", category)}
  scope :food, -> (food) {where("food LIKE ?", food)}

  def food_attributes=(attributes)
    food = Food.find_or_create_by(attributes)
    self.food = food if food.valid?
  end

  def convert(unit, amount)
    # This method is for the MVC version that creates new emission instances.
    # It will take in the unit (from a drop down menu) and the amount.
    # Will return kgCO2e per kg of food
  end

  def servings_to_kg(servings, category)
    # This method is for the mobile/React frontend app.
    # Student enters the number of servings (can be less than 1) of a food.
    # Based on category of food, returns the kgs of food in the serving.
  end

  def emissions_per_input(kg, food)
    # Accepts the kg returned by servings_to_kg and the name of the food.
    # queries the emissions for the food
    # multiples the emissions by the kg.
    # returns the emissions for the amount of food entered.
    # rendered in the mobile/react app
  end


end
