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

  describe 'GET /cages/:id' do
    let!(:cage) {FactoryBot.create(:cage, cage_status: "ON", cage_type: "carnivore", species:"Spinosaurus", max_dinosaurs: 3)}
    it 'returns a cage by id' do

      get "/cages/#{cage.id}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["id"]).to eq (cage.id)
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

