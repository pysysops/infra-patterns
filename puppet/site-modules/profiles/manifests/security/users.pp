# Add / Maintain Users - in hiera users
class profiles::security::users {
  notify { 'user management': }
}
