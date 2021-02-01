require 'rails_helper'

describe 'Jurassic API', type: :request do
  let(:first_cage) { FactoryBot.create(:cage, cage_status: "ON", cage_type: "herbivore", species: "herbivore", max_dinosaurs: 3)}
  let(:second_cage) { FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species: "Tyrannosaurus", max_dinosaurs: 3)}

  describe 'GET /dinosaurs' do
    it 'returns all dinosaurs' do
      FactoryBot.create(:dinosaur, name: "Carl", species: "Brachiosaurus", diet: "herbivore", cage: first_cage)
      FactoryBot.create(:dinosaur, name: "Alex", species: "Triceratops", diet: "herbivore", cage: first_cage)

      get '/dinosaurs'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /dinosaurs' do
    it 'creates a new dinosaur' do
      expect {
        post '/dinosaurs', params: { dinosaur: {name: 'Lily', species: 'Tyrannosaurus', diet: 'carnivore', cage_id: second_cage.id} }
      }.to change { Dinosaur.count }.from(0).to(1)


      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /dinosaurs/:id' do
    let!(:dinosaur) { FactoryBot.create(:dinosaur, name: "Carl", species: "Brachiosaurus", diet: "herbivore", cage: first_cage) }

    it 'deletes a dinosaur' do
      expect {
        delete "/dinosaurs/#{dinosaur.id}"
      }.to change { Dinosaur.count }.from(1).to(0)


      expect(response).to have_http_status(:no_content)
    end
  end
end

