require "sinatra"
require "sinatra/reloader"
require "http"

# define a route
get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV['EXCHANGE_RATE_KEY']}"

  raw_data = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_data)
  all_curr_hash = parsed_data.fetch('currencies')

  @all_curr_sym = all_curr_hash.keys
  
  erb(:homepage)
end


# define a route
get("/:fcurr") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV['EXCHANGE_RATE_KEY']}"

  raw_data = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_data)
  all_curr_hash = parsed_data.fetch('currencies')

  @all_curr_sym = all_curr_hash.keys
  @sym_from = params.fetch('fcurr')
  erb(:convertpage)
  

end

get("/:fcurr/:tcurr") do
  @sym_to = params.fetch('tcurr')
  @sym_from = params.fetch('fcurr')
  
  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV['EXCHANGE_RATE_KEY']}&from=#{@sym_from}&to=#{@sym_to}&amount=1"

  raw_data = HTTP.get(api_url)
  parsed_data = JSON.parse(raw_data)
  @rate = parsed_data.fetch('result')

  erb(:convertresult)
  

end
