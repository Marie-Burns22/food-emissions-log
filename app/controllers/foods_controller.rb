class FoodsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index #Refactor to make dry by passing the params[:u] to the scope method.

    if params[:u]
      @foods = Food.joins(:emissions).where( "emissions.unit = ?", params[:u] ).order(:amount)
    elsif params[:u] == "lbs of CO2e per serving"
      @foods = Food.joins(:emissions).merge(Emission.lb_unit).order(:amount)
    elsif params[:u] == "g of CO2e per serving"
      @foods = Food.joins(:emissions).merge(Emission.g_unit).order(:amount)
    elsif params[:u] == "kg of CO2 per 50 g of protein"
      @foods = Food.joins(:emissions).merge(Emission.kg_protein_unit).order(:amount)
  # elsif params[:food][:search] && params[:food][:search] != ""
  #       @foods = Food.where( "lower(name) = ?", params[:food][:search].downcase)
    else
      @foods = Food.all
    end
  end

  def edit
    @food = Food.find_by_id(params[:id])
    food_check
  end

  def update
    @food = Food.find_by_id(params[:id])
    food_check
    @food.update_attributes(food_params)
    redirect_to foods_path
  end

  def show
    @food = Food.find_by_id(params[:id])
    food_check
  end

  def destroy
  end

  private

  def food_params
    params.require(:food).permit(:name, :category, :id)
  end

  def food_check
    if !@food
      flash[:message] = "Food does not exist"
      redirect_to foods_path
    end
  end
end
