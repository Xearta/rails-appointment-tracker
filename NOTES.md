## REQUIREMENTS:
[X] - Include 1 has_many, 1 belongs_to, 2 has_many :through AND the join table must include a user-submittable attribute
[X] - Models must include reasonable validations (Support against invalid data)
[X] - One class level ActiveRecord Scope Method -> Must be chainable -> Must use an ActiveRecord Query Method within it
[X] - Standard User Authentication
[X] - Allow for 3rd party login (GitHub)
[X] - Nested Routes -> Nested `new` directly related to parent AND nested `index` or `show`
[X] - Correctly display validation errors in forms
[X] - Application should be DRY


#### APPOINTMENT TRACKER APP: ####
# Doctor (User)
has_many :appointments
has_many :patients through: => :appointments
- Username
- Email
- Password

# Patient
has_many :appointments
has_many :doctors through: => :appointments
- Name
- Age

# Appointments
belongs_to :doctor
belongs_to :patient
- user_id
- patient_id
- Datetime

## NESTED ROUTES:
/patients/1/appointments/new
/patients/1/appointments/1