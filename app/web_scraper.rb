require "faraday"

class WebScraper
  USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0.2 Safari/605.1.15",
    "Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Mobile Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0"
  ].freeze

  DELAY = Array.new(20) { rand(0.5..0.65) }.freeze

  def initialize(urls)
    @urls = urls
    @connection = Faraday.new do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_contents
    @urls.map do |url|
      send_request(url)
    end
  end

  private

  def set_user_agent(request)
    user_agent = USER_AGENTS.sample
    request.headers['User-Agent'] = user_agent
  end

  def delay
    sleep(DELAY.sample)
  end

  def send_request(url)
    response = @connection.get(url) do |req|
      set_user_agent(req)
    end

    delay
    response.body
  end
end
