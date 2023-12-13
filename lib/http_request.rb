class HttpRequest
  require 'net/http'

  def initialize(url)
    @uri = URI.parse(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def get
    begin
      request = Net::HTTP::Get.new(@uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = @http.request(request)
      JSON.parse(response.body)
    rescue
      # TODO: send error to a bug reporter service
    end
  end
end
