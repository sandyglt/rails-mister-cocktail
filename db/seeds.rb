require "open-uri"
require "json"

result_hash = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list").read)
ingredients = []
result_hash["drinks"].each do |ingredient|
  ingredients << ingredient["strIngredient1"]
end

ingredients.each do |ingredient|
  Ingredient.create!(name: ingredient)
end
