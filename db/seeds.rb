# role: 1-admin, 2-manager, 3-accountant, 4-enduser

# Create some main sections.
Section.create! name: "Section A"
Section.create! name: "Section B"

#Create admin
User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1,
  section_id: 1
)


# Generate 2 managers
2.times do |n|
  name = "Manager#{n+1}"
  email = "manager#{n+1}@gmail.com"
  password = "password"
  role = 3
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role: role,
    password: password,
    password_confirmation: password,
    section_id: section_id
  )
end

# Generate 3 accountant
3.times do |n|
  name = "Accountant#{n+1}"
  email = "accountant#{n+1}@gmail.com"
  password = "password"
  role = 2
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role: role,
    password: password,
    password_confirmation: password,
    section_id: section_id
  )
end

# Generate 4 end user
4.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "password"
  role = 4
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role: role,
    password: password,
    password_confirmation: password,
    section_id: section_id
  )
end

# Generate requests for a subset of users.
users = User.order(:created_at).take(10)
2.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 20)
  currency = Faker::Currency.code
  status = 1
  users.each { |user| user.requests.create!(
      title: title,
      content: content,
      currency: currency,
      status: status
    )}
end

requests = Request.order(:created_at).take(20)
2.times do
  amount = Faker::Number.number(digits: 10)
  description = Faker::Lorem.sentence(word_count: 10)
  section_name = Faker::Address.country
  requests.each { |request| request.request_details.create!(amount: amount, description: description, section_name: section_name) }
end

# Generate a bunch of additional suppliers.
# TYPE: true =>personal, false =>company
10.times do |n|
  name = Faker::Name.name
  Supplier.create!(name: name)
end

# Generate income for a subset of users.
users = User.order(:created_at).take(5)
3.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  amount = 100000
  currency = "USD"
  supplier_id = 1
  status = 1
  users.each { |user| user.incomes.create!(
    title: title,
    content: content,
    amount: amount,
    currency: currency,
    supplier_id: supplier_id,
    status: status
    )
  }
end

#generate currencies VND, USD, JPY
Currency.create! name: "VND"
Currency.create! name: "USD"
Currency.create! name: "JPY"
