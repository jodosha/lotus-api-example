require 'bundler/setup'
require_relative './app'

run Bookshelf::API::Application.new
