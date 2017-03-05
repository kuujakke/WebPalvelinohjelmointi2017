json.extract! brewery, :id, :name, :year
json.set!('beers', brewery.count)
json.set!('active', brewery.active)
json.url brewery_url(brewery, format: :json)