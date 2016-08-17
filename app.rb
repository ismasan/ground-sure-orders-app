require "sinatra"
require "json"
require "open-uri"
require "sinatra/base"

URL = "http://groundsure-orders-api.herokuapp.com/"

class App < Sinatra::Base
  get "/?" do
    @items = items
    erb :index
  end

  get "/items/:index" do |index|
    @item = items[index.to_i]
    @total = @item["units"].to_i * @item["unit_price"].to_f

    erb :item
  end

  def items
    @items ||= (
      JSON.parse(open(URL).read)["items"]
    )
  end
end
