require 'json'
require 'redis'
require 'lotus/router'
require 'lotus/controller'

module Bookshelf
  module API

    Lotus::Controller.configure do
      handle_exceptions ENV['RACK_ENV'] == 'production'

      default_request_format  :json
      default_response_format :json

      prepare do
        include Controllers::Authentication
        accept :json
      end
    end

    class Repository
      def initialize
        @connection = Redis.new(url: ENV['REDIS_URL'])
      end

      def clear
        @connection.flushall
      end

      def create(collection, *records)
        records = Array(records).flatten

        transaction do
          counter = "_#{ collection }:id"
          @connection.setnx(counter, 0)

          Array(records).each do |record|
            id = @connection.incr(counter)
            @connection.mapped_hmset("#{ collection }:#{ id }", record.merge(id: id))
          end
        end
      end

      def all(collection)
        transaction do
          @connection.keys("#{ collection }:*").each_with_object([]) do |key, result|
            result << @connection.hgetall(key)
          end
        end
      end

      private

      def transaction
        # @connection.multi do
          yield
        # end
      end
    end

    class Application
      def initialize
        @router = Lotus::Router.new(
          namespace: Bookshelf::API::Controllers,
          parsers: [:json],
          &Proc.new { eval(File.read('config/routes.rb')) }
        )
      end

      def call(env)
        @router.call(env)
      end
    end

    module Controllers
      module Authentication
        def self.included(action)
          action.class_eval do
            before :authenticate!
          end
        end

        private

        def authenticate!
          authenticated? or halt(401)
        end

        def authenticated?
          true
        end
      end

      require_relative './controllers/books'
    end
  end
end
