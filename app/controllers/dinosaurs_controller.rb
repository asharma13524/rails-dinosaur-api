class DinosaursController < ApplicationController
  def index
    render json: Dinosaur.all
  end
end
