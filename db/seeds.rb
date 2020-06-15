# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Patient.create(name: "Jeff", age: 34)
Patient.create(name: "Sophie", age: 24)

Appointment.create(user_id: 1, patient_id: 1, appointment_date: "2020-06-15 09:05:00")
Appointment.create(user_id: 1, patient_id: 2, appointment_date: "2020-06-25 09:05:00")
Appointment.create(user_id: 1, patient_id: 1, appointment_date: "2020-07-01 09:05:00")