class FetchService
  def initialize(supplier_url)
    @url = supplier_url
  end

  def call
    HttpRequest.new(@url).get
  end
end
