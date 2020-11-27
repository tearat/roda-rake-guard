require 'roda'
require 'json'

load './app/database.rb'
load './models/book.rb'
load './models/shop.rb'
load './serializers/book_serializers.rb'
load './serializers/shop_serializers.rb'

class App < Roda
  plugin :json
  # plugin :match_affix, "", /(\/|\z)/
  # plugin :run_append_slash
  # plugin :match_affix, ""

  route do |r|
    # GET / request
    r.root do
      r.redirect '/hello'
    end

    # /hello branch
    r.on 'hello' do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello'

      # GET /hello/world request
      r.get 'world' do
        "#{@greeting} world!"
      end

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting}!"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end

    r.get 'books' do
      @data = Book.all
      @data.map { |item| BookListSerializer.new(item) }.to_json
    end

    r.on 'books', Integer do |id|
      @data = Book.find(id)
      BookDetailSerializer.new(@data).to_json
    end

    r.get 'shops' do
      @data = Shop.all
      @data.map { |item| ShopListSerializer.new(item) }.to_json
    end

    r.on 'shops', Integer do |id|
      @data = Shop.find(id)
      ShopDetailSerializer.new(@data).to_json
    end
  end
end

run App.freeze.app
