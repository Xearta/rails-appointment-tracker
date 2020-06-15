# APPOINTMENT TRACKER APP:
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



## REQUIREMENTS:
[ ] - Include 1 has_many, 1 belongs_to, 2 has_many :through AND the join table must include a user-submittable attribute
[ ] - Models must include reasonable validations (Support against invalid data)
[ ] - One class level ActiveRecord Scope Method -> Must be chainable -> Must use an ActiveRecord Query Method within it
[ ] - Standard User Authentication
[ ] - Allow for 3rd party login (GitHub)
[ ] - Nested Routes -> Nested `new` directly related to parent AND nested `index` or `show`
[ ] - Correctly display validation errors in forms
[ ] - Application should be DRY


### TODOS:
- Check requirements
- TODO: Error messages
- TODO: Strike-through on expired
- TODO: Deletion
- TODO: Validations
- TODO: Styling
- TODO: Fix accounts not having a username