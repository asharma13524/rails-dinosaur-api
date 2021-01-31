class CagesController < ApplicationController

  # return all cages
  def index
    render json: Cage.all
  end

  # create a new cage
  def create
    cage = Cage.new(cage_params)

    if cage.save
      render json: cage, status: :created
    else
      render json: cage.errors, status: :unprocessable_entity
    end
  end

  private

  def cage_params
    params.require(:cage).permit(:cage_status, :cage_type, :species, :max_dinosaurs)
  end

end
