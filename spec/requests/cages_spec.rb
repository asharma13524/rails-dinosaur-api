require 'rails_helper'

describe 'Jurassic API', type: :request do
  describe 'GET /cages' do
    it 'returns all cages' do
      FactoryBot.create(:cage, cage_status: "ON", cage_type: "herbivore", species:"herbivore", max_dinosaurs: 5)
      FactoryBot.create(:cage, cage_status: "ON", cage_type: "herbivore", species:"herbivore", max_dinosaurs: 5)

      get '/cages'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)

    end
  end

  describe 'GET /cages/:cage_status' do
    let!(:first_cage) {FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}
    let!(:second_cage) {FactoryBot.create(:cage, cage_status: "OFF", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}
    let!(:third_cage) {FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}

    it 'returns cages filtered by cage_status' do
      # only cages with status ON
      get "/cages/#{first_cage.cage_status}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq (2)
    end
  end

  describe 'POST /cages' do
    it 'creates a new cage' do
      expect {
        post '/cages', params: { cage: { cage_status: "ON", cage_type: "herbivore", species:"Tyrannosaurus", max_dinosaurs: 4} }
      }.to change { Cage.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'UPDATE /cage/:id' do
    let!(:cage) {FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}

    it 'updates a cage' do
      put "/cages/#{cage.id}", params: { cage: { cage_status: "OFF", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3} }

      updated_cage = Cage.find(cage.id)
      expect(response).to have_http_status(:no_content)
      expect(updated_cage.cage_status).to match("OFF")
    end
  end

  describe 'DELETE /cages/:id' do
    let!(:cage) {FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}
    it 'deletes a cage' do
      expect {
        delete "/cages/#{cage.id}"
      }.to change { Cage.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end

