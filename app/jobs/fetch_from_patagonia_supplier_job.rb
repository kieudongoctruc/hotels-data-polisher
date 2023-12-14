class FetchFromPatagoniaSupplierJob < BaseFetchJob
  def url
    'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia'
  end

  def supplier_name
    'Patagonia'
  end
end
