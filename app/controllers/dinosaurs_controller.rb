class DinosaursController < ApplicationController
  def index
    render json: Dinosaur.all
  end

  def create
    dinosaur = Dinosaur.new(dinosaur_params)
    if dinosaur.save
      render json: dinosaur, status: :created
    else
      render json: dinosaur.errors, status: :unprocessable_entity
    end
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species, :diet)
  end
end
