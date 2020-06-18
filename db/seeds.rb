# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "tester@test.com", username: "Test User", password: "qwerty", password_confirmation: "qwerty")

Patient.create(name: "Joe Jones", age: 34)
Patient.create(name: "Barry Bones", age: 24)
Patient.create(name: "Sally Sticks", age: 67)

Appointment.create(user_id: 1, patient_id: 1, appointment_date: "2020-06-15 09:05:00")
Appointment.create(user_id: 1, patient_id: 2, appointment_date: "2020-06-25 10:15:00")
Appointment.create(user_id: 1, patient_id: 1, appointment_date: "2020-07-01 16:00:00")
Appointment.create(user_id: 1, patient_id: 3, appointment_date: "2020-08-01 08:00:00")
