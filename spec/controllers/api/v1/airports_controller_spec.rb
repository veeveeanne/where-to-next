# require 'rails_helper'
# require 'active_support'
#
# RSpec.describe Api::V1::AirportsController, type: :controller do
#   describe 'POST#create' do
#     let!(:destination) { Destination.create(
#       name: 'Boston',
#       state: 'Massachusetts',
#       address: '123 Main St',
#       latitude: 42.361145,
#       longitude: -71.057083
#       ) }
#     let!(:params_hash) { { destination: {
#       id: destination.id,
#       name: destination.name,
#       state: destination.state,
#       address: destination.address,
#       latitude: destination.latitude,
#       longitude: destination.longitude
#     } } }
#
#     context 'when a record already exists in the database with the given params' do
#       let!(:airport) { Airport.create(
#         name: 'EDWARD L LOGAN INTL',
#         iata_code: 'BOS',
#         latitude: 42.36514,
#         longitude: -71.01777,
#         city: 'BOSTON'
#         )}
#
#       it 'does not create a new record' do
#         previous_count = Airport.count
#         post :create, params: params_hash
#         new_count = Airport.count
#
#         expect(new_count).to eq previous_count
#       end
#
#       it 'associates the provided destination with the returned airport' do
#         post :create, params: params_hash
#
#         parsed_response = JSON.parse(response.body)
#
#         expect(Destination.find(destination.id).airport_id).to eq parsed_response['id']
#       end
#
#       it 'returns the json for the found airport record' do
#         post :create, params: params_hash
#
#         parsed_response = JSON.parse(response.body)
#
#         expect(parsed_response).to be_kind_of(Hash)
#         expect(parsed_response.length).to eq 8
#         expect(parsed_response['name']).to eq 'EDWARD L LOGAN INTL'
#         expect(parsed_response['iata_code']).to eq 'BOS'
#         expect(parsed_response['city']).to eq 'BOSTON'
#         expect(parsed_response['latitude'].to_f).to eq 42.36514
#         expect(parsed_response['longitude'].to_f).to eq -71.01777
#       end
#     end
#
#     context 'when there are no records with the provided params' do
#       it 'creates a new airport record' do
#         previous_count = Airport.count
#         post :create, params: params_hash
#         new_count = Airport.count
#
#         expect(new_count).to eq (previous_count + 1)
#       end
#
#       it 'associates the provided destination with the created airport' do
#         post :create, params: params_hash
#
#         parsed_response = JSON.parse(response.body)
#
#         expect(Destination.find(destination.id).airport_id).to eq parsed_response['id']
#       end
#
#       it 'returns json for the created airport' do
#         post :create, params: params_hash
#
#         parsed_response = JSON.parse(response.body)
#
#         expect(parsed_response).to be_kind_of(Hash)
#         expect(parsed_response.length).to eq 8
#         expect(parsed_response['name']).to eq 'EDWARD L LOGAN INTL'
#         expect(parsed_response['iata_code']).to eq 'BOS'
#         expect(parsed_response['city']).to eq 'BOSTON'
#         expect(parsed_response['latitude'].to_f).to eq 42.36514
#         expect(parsed_response['longitude'].to_f).to eq -71.01777
#       end
#     end
#   end
#
#   describe 'GET#search' do
#     let!(:airport) { Airport.create(
#       name: 'EDWARD L LOGAN INTL',
#       iata_code: 'BOS',
#       latitude: 42.36514,
#       longitude: -71.01777,
#       city: 'BOSTON'
#       )}
#
#     it 'returns json of airports where the name matches case-insensitively to the provided params' do
#       get :search, params: {keyword: 'logan'}
#       parsed_response = JSON.parse(response.body)
#
#       expect(parsed_response).to be_kind_of(Array)
#       expect(parsed_response.length).to eq 1
#       expect(parsed_response[0]['id']).to eq airport.id
#       expect(parsed_response[0]['name']).to eq airport.name
#       expect(parsed_response[0]['iata_code']).to eq airport.iata_code
#       expect(parsed_response[0]['latitude'].to_d).to eq airport.latitude
#       expect(parsed_response[0]['longitude'].to_d).to eq airport.longitude
#       expect(parsed_response[0]['city']).to eq airport.city
#     end
#
#     it 'returns json of airports where the city matches case-insensitively to the provided params' do
#       get :search, params: {keyword: 'boston'}
#       parsed_response = JSON.parse(response.body)
#
#       expect(parsed_response).to be_kind_of(Array)
#       expect(parsed_response.length).to eq 1
#       expect(parsed_response[0]['id']).to eq airport.id
#       expect(parsed_response[0]['name']).to eq airport.name
#       expect(parsed_response[0]['iata_code']).to eq airport.iata_code
#       expect(parsed_response[0]['latitude'].to_d).to eq airport.latitude
#       expect(parsed_response[0]['longitude'].to_d).to eq airport.longitude
#       expect(parsed_response[0]['city']).to eq airport.city
#     end
#   end
#
#   describe 'GET#explore' do
#     let!(:airport) { Airport.create(
#       name: 'SEATTLE TACOMA INTL',
#       iata_code: 'SEA',
#       latitude: 47.44889,
#       longitude: -122.3094,
#       city: 'SEATTLE'
#     )}
#
#     it 'creates new records for the returned matches from the AmadeusWrapper' do
#       previous_count = Airport.count
#       get :explore, params: {keyword: 'boston'}
#       new_count = Airport.count
#
#       expect(new_count).to eq (previous_count + 1)
#     end
#
#     it 'returns json of airports that match the provided params' do
#       get :explore, params: {keyword: 'boston'}
#       parsed_response = JSON.parse(response.body)
#
#       expect(parsed_response).to be_kind_of(Array)
#       expect(parsed_response.length).to eq 1
#       expect(parsed_response[0]['name']).to eq 'EDWARD L LOGAN INTL'
#       expect(parsed_response[0]['iata_code']).to eq 'BOS'
#       expect(parsed_response[0]['latitude'].to_f).to eq 42.36514
#       expect(parsed_response[0]['longitude'].to_f).to eq -71.01777
#       expect(parsed_response[0]['city']).to eq 'BOSTON'
#     end
#   end
# end
