RSpec.describe Bookshelf::API::Controllers::Books::Index do
  let(:action)     { described_class.new(repository: repository) }
  let(:repository) { object_double(Bookshelf::API::Repository.new, all: books) }
  let(:books)      { [] }
  let(:body)       { [JSON.dump(books)] }

  it "is successful" do
    response = action.call({})

    expect(response[0]).to                 eq(200)
    expect(response[2]).to                 eq(body)
    expect(response[1]['Content-Type']).to match('application/json')
  end

  it "considers */* requests as JSON" do
    response = action.call({"HTTP_ACCEPT" => "*/*"})

    expect(response[0]).to                 eq(200)
    expect(response[1]['Content-Type']).to match('application/json')
  end

  it "rejects text/xml requests" do
    response = action.call({"HTTP_ACCEPT" => "text/xml"})

    expect(response[0]).to                 eq(406)
    expect(response[2]).to                 eq(["Not Acceptable"])
  end
end
