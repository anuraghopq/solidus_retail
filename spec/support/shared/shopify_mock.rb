RSpec.shared_context 'shopify_mock' do
  require 'shopify_api'

  before :each do
    ActiveResource::Base.format = :json
    ShopifyAPI.constants.each do |const|
      const = "ShopifyAPI::#{const}".constantize
      const.format = :json if const.respond_to?(:format=)
    end

    ShopifyAPI::Base.clear_session
    ShopifyAPI::Base.site = 'https://this-is-my-test-shop.myshopify.com/admin'
    ShopifyAPI::Base.password = nil
    ShopifyAPI::Base.user = nil
  end

  def mock_request(file, endpoint, extension)
    url = "#{shopify_base_url}/#{endpoint}.#{extension}"
    json = read_file(file, extension)
    stub_request(:get, url).to_return(status: 200, body: json, headers: {})
  end

  def read_file(file, extension = 'json')
    File.open("#{File.dirname(__FILE__)}/../data/#{file}.#{extension}").read
  end

  def shopify_base_url
    return ShopifyAPI::Base.site unless ShopifyAPI::Base.site.to_s[-1] == '/'
    ShopifyAPI::Base.site = 'https://this-is-my-test-shop.myshopify.com/admin'
  end
end
