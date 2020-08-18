# Role_id: 1-admin, 2-manager, 3-accountant, 4-enduser

# Create some main sections.
Section.create! name: "Section A"
Section.create! name: "Section B"

#Create role
Role.create! name: "Admin"
Role.create! name: "Accountant"
Role.create! name: "Manager"
Role.create! name: "Normal User"

#Create admin
User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role_id: 1,
  section_id: 1
)


# Generate 2 managers
2.times do |n|
  name = Faker::Name.name
  email = "manager#{n+1}@gmail.com"
  password = "password"
  role_id = 3
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role_id: role_id,
    password: password,
    password_confirmation: password,
    section_id: section_id
  )
end

# Generate 3 accountant
3.times do |n|
  name = Faker::Name.name
  email = "accountant#{n+1}@gmail.com"
  password = "password"
  role_id = 2
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role_id: role_id,
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
  role_id = 4
  section_id = 1
  User.create!(
    name: name,
    email: email,
    role_id: role_id,
    password: password,
    password_confirmation: password,
    section_id: section_id
  )
end

# Create status
Status.create! name: "pending"
Status.create! name: "approved"
Status.create! name: "paid"
Status.create! name: "rejected"
Status.create! name: "canceled"

# Generate requests for a subset of users.
users = User.order(:created_at).take(10)
2.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  status_id = 1
  users.each { |user| user.requests.create!(title: title, content: content, status_id: status_id) }
end

# Generate requests details for a subset of requests.
requests = Request.order(:created_at).take(20)
2.times do
  amount = Faker::Number.number(digits: 10)
  currency = Faker::Currency.code
  section_name = Faker::Address.country
  requests.each { |request| request.request_details.create!(amount: amount, currency: currency, section_name: section_name) }
end

# Generate a bunch of additional suppliers.
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
  users.each { |user| user.incomes.create!(
    title: title,
    content: content,
    amount: amount,
    currency: currency,
    supplier_id: supplier_id
    )
  }
end
