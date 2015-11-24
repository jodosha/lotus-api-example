module ApiHelper
  require 'rack/test'
  include Rack::Test::Methods

  private

  def app
    Bookshelf::API::Application.new
  end

  def response
    last_response
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :api
end

