require 'rails_helper'

describe 'Jurassic API', type: :request do
  let(:first_cage) { FactoryBot.create(:cage, cage_status: "ON", cage_type: "herbivore", species: "herbivore", max_dinosaurs: 3)}

  it 'returns all dinosaurs' do
    FactoryBot.create(:dinosaur, name: "Carl", species: "Brachiosaurus", diet: "herbivore", cage: first_cage)
    FactoryBot.create(:dinosaur, name: "Alex", species: "Triceratops", diet: "herbivore", cage: first_cage)

    get '/dinosaurs'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end

