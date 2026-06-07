# Clean existing database records
puts "Cleaning database..."
PostEditor.destroy_all
Post.destroy_all
Editor.destroy_all
User.destroy_all

# Seed Users
puts "Creating Users..."
u1 = User.create!(
  name: "John Doe",
  dob: "1990-01-01",
  email: "john@example.com",
  phone_number: "1234567890",
  address: "123 Main St"
)
u2 = User.create!(
  name: "Jane Smith",
  dob: "1992-05-15",
  email: "jane@example.com",
  phone_number: "0987654321",
  address: "456 Oak Ave"
)

# Seed Editors
puts "Creating Editors..."
ed1 = Editor.create!(
  name: "Alice Editor",
  email: "alice@example.com"
)
ed2 = Editor.create!(
  name: "Bob Editor",
  email: "bob@example.com"
)

# Seed Posts (One-to-Many association via creator)
puts "Creating Posts..."
p1 = u1.posts.create!(
  title: "Getting Started with Rails",
  content: "Rails is a web-app framework that includes everything needed to create database-backed web applications."
)
p2 = u2.posts.create!(
  title: "Advanced Active Record",
  content: "Active Record is the M in MVC - the model - which is the layer of the system responsible for representing business data."
)

# Associate Editors with Posts (Many-to-Many association)
puts "Assigning Editors to Posts..."
p1.editors << ed1
p1.editors << ed2
p2.editors << ed1

puts "Seed completed successfully!"
