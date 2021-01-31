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


end

