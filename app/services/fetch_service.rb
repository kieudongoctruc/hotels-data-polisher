class FetchService
  SUPPLIERS = [
    'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme',
    'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia',
    'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies'
  ]

  def call
    data = []
    SUPPLIERS.each do |supplier|
      hotels = HttpRequest.new(supplier).get()&.body || []
      data.concat(hotels)
    end
    data
  end
end
