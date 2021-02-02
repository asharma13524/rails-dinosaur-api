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
    # create the new dinosaur
    dinosaur = Dinosaur.new(dinosaur_params)
    cage_id = params[:cage_id]
    # check if cage already exists
    if Cage.exists?(id:cage_id)
      cage = Cage.find(cage_id)
    end
    species = params[:species]
    diet = params[:diet]
    # if cage is active, is a herbivore cage, and has space, associate dinosaur to that cage
    if(cage && cage.cage_status != "DOWN" && diet == cage.cage_type && diet == "herbivore" && cage.dinosaurs.length < cage.max_dinosaurs)
      if dinosaur.save
        render json: dinosaur, status: :created
      end
    # if cage is active, is a carnivore cage, is the same species, and has space, then associate dinosaur to that cage
    elsif(cage && cage.cage_status != "DOWN" && cage.cage_type == "carnivore" && cage.species == species && cage.dinosaurs.length < cage.max_dinosaurs)
      if dinosaur.save
        render json: dinosaur, status: :created
      end

    else
      # loop through all existing cages and see if we can place dinosaur in an existing cage
      Cage.all.each do | cage |
        if( cage.cage_status != "DOWN" && diet == cage.cage_type && diet == "herbivore" && cage.dinosaurs.length < cage.max_dinosaurs)
          if dinosaur.save
            render json: dinosaur, status: :created
            return
          end

        elsif(cage.cage_status != "DOWN" && diet == cage.cage_type && diet == "carnivore" && cage.species == species && cage.dinosaurs.length < cage.max_dinosaurs)
          if dinosaur.save
            render json: dinosaur, status: :created
          end
        end
      end
      # if we can't place dinosaur in existing cage, create a new cage
      new_cage = Cage.create!(cage_status: "ACTIVE", cage_type: diet, species: species, max_dinosaurs: 3)
      dinosaur.cage_id = new_cage.id
      if dinosaur.save
        render json: dinosaur, status: :created
      end
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
