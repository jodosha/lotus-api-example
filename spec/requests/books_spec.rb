RSpec.describe "/books", type: :api do
  before do
    repository = Bookshelf::API::Repository.new
    repository.clear

    repository.create(:books, [{title: 'TDD'}, {title: 'Refactoring'}])
    @body = JSON.dump(repository.all(:books))
  end

  it "is successful" do
    get "/books"

    expect(response.status).to                  eq(200)
    expect(response.body).to                    eq(@body)
    expect(response.headers['Content-Type']).to match('application/json')
  end
end

