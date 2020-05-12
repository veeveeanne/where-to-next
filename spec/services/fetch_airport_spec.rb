describe FetchAirport do
  describe '.call' do
    it 'calls on AmadeusService.fetch_airport' do
      amadeus = class_double(AmadeusService)
      allow(amadeus).to receive(:fetch_airport).and_return([
        {
          name: 'name1',
          iata_code: 'code1',
          address: { cityName: 'city1' },
          geoCode: { latitude: '123', longitude: '321'}
        },
        {
          name: 'name2',
          iata_code: 'code2',
          address: { cityName: 'city2' },
          geoCode: { latitude: '456', longitude: '654'}
        }
        ])


      binding.pry
    end
  end
end
