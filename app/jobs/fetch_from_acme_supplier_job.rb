class FetchFromAcmeSupplierJob < BaseFetchJob
  def url
    'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
  end

  def supplier_name
    'Acme'
  end
end
