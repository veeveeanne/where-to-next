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
        ['SEA', 'LAX', 'BOS']
      )
      allow(flight_data_creator).to receive(:search_helper).and_return(
        {
          origin: 'BOS',
          destination: 'DESTINATION',
          departure_date: '2020-08-01',
          return_date: '2020-08-05'
        }
      )
    end
    context 'when the destination airport is not the same as the departure airport' do
      it 'calls FetchFlights.call for each airport' do
        allow(FetchFlights).to receive(:call).and_return([1,2,3])

        expect(flight_data_creator.search_flights).to eq({'SEA' => [1,2,3], 'LAX' => [1,2,3]})
        expect(FetchFlights).to receive(:call).twice

        flight_data_creator.search_flights
      end
    end

    context 'when the destination airport is the same as the departure airport' do
      it 'does not call FetchFlights.call for the identical airport' do
        allow(FetchFlights).to receive(:call).and_return([1,2,3])

        expect(flight_data_creator.search_flights).to_not have_key 'BOS'
        expect(FetchFlights).to receive(:call).twice

        flight_data_creator.search_flights
      end
    end

    it 'returns a hash of the iata code and array of flight prices for each airport' do
      test = flight_data_creator.search_flights

      expect(test).to be_kind_of(Hash)
      expect(test).to have_key 'SEA'
      expect(test).to have_key 'LAX'
      expect(test['SEA']).to be_kind_of(Array)
      expect(test['LAX']).to be_kind_of(Array)
      expect(test['SEA'].length).to eq 5
      expect(test['LAX'].length).to eq 5
    end

    it 'assigns the flight_prices attribute to the hash of iata codes and array of flight prices for each airport' do
      test = flight_data_creator.search_flights

      expect(flight_data_creator.flight_prices).to be_kind_of(Hash)
      expect(flight_data_creator.flight_prices).to have_key 'SEA'
      expect(flight_data_creator.flight_prices).to have_key 'LAX'
      expect(flight_data_creator.flight_prices['SEA']).to be_kind_of(Array)
      expect(flight_data_creator.flight_prices['LAX']).to be_kind_of(Array)
      expect(flight_data_creator.flight_prices['SEA'].length).to eq 5
      expect(flight_data_creator.flight_prices['LAX'].length).to eq 5
    end
  end

  describe '#average' do
    it 'returns the average of the flight prices for a given airport code' do
      flight_data_creator.flight_prices['SEA'] = [15, 20, 15, 30]
      test = flight_data_creator.average('SEA')

      expect(test).to eq 20
    end

    it 'assigns the average flight price to a key of the airport code for the flight_options attribute' do
      flight_data_creator.flight_prices['SEA'] = [15, 20, 15, 30]
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

      expect(test).to be_kind_of(String)
      expect(test).to eq 'LAX'
    end
  end
end
