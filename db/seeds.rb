# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'Aroldo', password: '12344321', email: 'aroldo@agmail.com', role: :reporter)
User.create(name: 'Arnaldo', password: '12344321', email: 'arnaldo@gmail.com', role: :chief_editor)
User.create(name: 'Boss', password: '12344321', email: 'admin@admin.com', role: :admin)
