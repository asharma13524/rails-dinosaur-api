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

  # update a cage
  def update
    cage = Cage.find(params[:id])

    if cage.update(cage_params)
      head :no_content
    else
      render json: cage.errors, status: :unprocessable_entity
    end
  end

  # delete a cage
  def destroy
    Cage.find(params[:id]).destroy!

    head :no_content
  end

  private

  def cage_params
    params.require(:cage).permit(:cage_status, :cage_type, :species, :max_dinosaurs)
  end

end
