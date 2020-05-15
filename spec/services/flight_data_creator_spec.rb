require 'rails_helper'

describe FlightDataCreator do
  let!(:flight_data_creator) { FlightDataCreator.new(
    [
      {id: 1, user_id: 1, destination_id: 1},
      {id: 2, user_id: 1, destination_id: 2}
    ],
    {
      'airport_code' => 'BOS',
      'departure_date' => '2020-08-01',
      'return_date' => '2020-08-05'
    }
    )}

  describe '.new' do
    let!(:listings) { ['listing1', 'listing2'] }
    let!(:params) { {'params1' => 'value1', 'params2' => 'value2'} }

    it 'takes an array of listings and hash of params as arguments' do
      data_creator = FlightDataCreator.new(listings, params)

      expect(data_creator).to be_a(FlightDataCreator)
      expect(data_creator.destinations).to eq listings
      expect(data_creator.params).to eq params
    end
  end

  describe 'search_flights' do
    before(:each) do
      allow(flight_data_creator).to receive(:airports).and_return(
        ['SEA', 'LAX']
      )
    end

    it 'returns a hash of the iata code and array of flight prices for each airport' do
      test = flight_data_creator.search_flights

      expect(test).to be_kind_of(Hash)
      expect(test).to have_key 'SEA'
      expect(test).to have_key 'LAX'
      expect(test['SEA']).to be_kind_of(Array)
      expect(test['LAX']).to be_kind_of(Array)
      expect(test['SEA'][0]).to eq 329.06
      expect(test['LAX'][0]).to eq 329.06
    end
  end

  describe '#average' do
    before(:each) do
      allow(flight_data_creator).to receive(:search_flights).and_return(
        {
          'SEA' => [15,20,15,30],
          'LAX' => [20,30,10,20]
        }
      )
    end

    it 'returns the average of the flight prices for a given airport code' do
      test = flight_data_creator.average('SEA')
      expect(test).to eq 20
    end

    it 'assigns the average flight price to a key of the airport code for the flight_options attribute' do
      test = flight_data_creator.average('SEA')
      expect(flight_data_creator.flight_options['SEA']).to eq 20
    end
  end

  describe '#suggested' do
    it 'returns an array with the key value pair of the lowest price' do
      flight_data_creator.flight_options['SEA'] = 20
      flight_data_creator.flight_options['LAX'] = 10
      flight_data_creator.flight_options['BOS'] = 15

      test = flight_data_creator.suggested
      expect(test[0]).to eq 'LAX'
      expect(test[1]).to eq 10
    end
  end
end
