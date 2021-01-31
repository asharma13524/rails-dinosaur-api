class DinosaursController < ApplicationController

  # render all dinosaurs
  def index
    render json: Dinosaur.all
  end

  # create a dinosaur
  def create
    dinosaur = Dinosaur.new(dinosaur_params)
    if dinosaur.save
      render json: dinosaur, status: :created
    else
      render json: dinosaur.errors, status: :unprocessable_entity
    end
  end

  def update
    # dinosaur = Dinosaur.find(params[:id])

  # delete a dinosaur
  def destroy
    Dinosaur.find(params[:id]).destroy!

    head :no_content
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species, :diet)
  end
end
