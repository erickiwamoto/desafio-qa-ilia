Given('i have a new pet') do
  id = Faker::Number.number(digits: 10)
  category_id = Faker::Number.number(digits: 3)
  category_name = Faker::Creature::Dog.breed
  name = Faker::Creature::Dog.name
  tag_id = Faker::Number.number(digits: 3)
  tag_nome = Faker::Creature::Dog.gender

  @body = {
    id: id,
    category: {
      id: category_id,
      name: category_name
    },
    name: name,
    photoUrls: [
      'string'
    ],
    tags: [
      {
        id: tag_id,
        name: tag_nome
      }
    ],
    status: 'available'
  }.to_json

  @body = JSON.parse(@body)
end

When('I register the pet in the service {string}') do |service|
  @result = HTTParty.post(
    "https://petstore.swagger.io#{service}",
    body: @body.to_json,
    headers: { 'Content-Type' => 'application/json' }
  )
end

Then('the response status code is {string}') do |status_code|
  expect(@result.response.code).to eql status_code
end

When('I edit the {string} of the pet in the service {string}') do |_name, _service|
  @body = {
    id: pet_id,
    category: {
      id: category_id,
      name: category_name
    },
    name: name,
    photoUrls: [
      'string'
    ],
    tags: [
      {
        id: tag_id,
        name: tag_nome
      }
    ],
    status: 'available'
  }.to_json

  @body = JSON.parse(@body)
end

When('I edit the {string} of the pet {int} in the service {string}') do |name, pet_id, service|
  body = {
    id: pet_id,
    category: {
      id: 1,
      name: 'og'
    },
    name: name,
    photoUrls: [
      'string'
    ],
    tags: [
      {
        id: 1,
        name: 'dog'
      }
    ],
    status: 'available'
  }.to_json

  body = JSON.parse(body)

  @result = HTTParty.put(
    "https://petstore.swagger.io#{service}",
    body: body.to_json,
    headers: { 'Content-Type' => 'application/json' }
  )
end

When('I get a pet with {string} in the service {string}') do |status, service|
  @result = HTTParty.get(
    "https://petstore.swagger.io#{service}",
    query: status
  )
end

Then('I see a list of registered pets') do
  @result.parsed_response.each do |u|
    expect(u).to have_key('id')
    expect(u).to have_key('name')
    expect(u).to have_key('status')
  end
end
