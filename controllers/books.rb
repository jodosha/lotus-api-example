module Bookshelf::API::Controllers::Books
  class Index
    include Lotus::Action

    def initialize(repository: Bookshelf::API::Repository.new)
      @repository = repository
    end

    def call(params)
      self.body = JSON.dump(
        @repository.all(:books)
      )
    end
  end
end
