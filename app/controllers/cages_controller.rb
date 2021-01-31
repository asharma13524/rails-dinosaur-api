class CagesController < ApplicationController

  # return all cages
  def index
    render json: Cage.all
  end

end
