# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

# ingredient = JSON.parse(open('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read)
# ingredient["drinks"].each do |element|
#   Ingredient.create(name: element["strIngredient1"])
# end
50.times do
  sleep 0.5
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  resp = open(url).read
  data = JSON.parse(resp)

  cocktail = data['drinks'][0]['strDrink']
  image = data['drinks'][0]['strDrinkThumb']

  saved_cocktail = Cocktail.create(
    name: cocktail,
    remote_image_url_url: image
  )

  (1..15).each do |index|
    ingredient = data['drinks'][0]["strIngredient#{index}"]
    dose = data['drinks'][0]["strMeasure#{index}"]

    next unless ingredient.present?

    saved_ingredient = Ingredient.create(
      name: ingredient,
      # image_url: COCKTAIL_IMAGES[rand(0..COCKTAIL_IMAGES.length)]
    )

    unless saved_ingredient.persisted?
      saved_ingredient = Ingredient.find_by(name: ingredient)
    end

    next unless dose.present?

    Dose.create(
      description: dose,
      cocktail_id: saved_cocktail.id,
      ingredient_id: saved_ingredient.id
    )
  end
end

