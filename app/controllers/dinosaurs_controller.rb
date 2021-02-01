class DinosaursController < ApplicationController

  # return all dinosaurs
  def index
    render json: Dinosaur.all
  end

  # return dinosaurs based on species
  def show
    dinosaurs = Dinosaur.filter_by_species(params[:species])

    if dinosaurs
      render json: dinosaurs
    else
      render json: dinosaurs.errors, status: :unprocessable_entity
    end
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

  # update a dinosaur
  def update
    dinosaur = Dinosaur.find(params[:id])

    if dinosaur.update(dinosaur_params)
      head :no_content
    else
      render json: dinosaur.errors, status: :unprocessable_entity
    end
  end

  # delete a dinosaur
  def destroy
    Dinosaur.find(params[:id]).destroy!

    head :no_content
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species, :diet, :cage_id)
  end
end
