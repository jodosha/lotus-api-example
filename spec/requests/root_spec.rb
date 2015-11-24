RSpec.describe "/books", type: :api do
  it "redirects to /books" do
    get "/"

    expect(response.status).to              eq(301)
    expect(response.headers['Location']).to eq('/books')

    follow_redirect!

    expect(response.status).to                  eq(200)
    expect(response.headers['Content-Type']).to match('application/json')
  end
end

