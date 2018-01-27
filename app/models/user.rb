class User < ApplicationRecord
  include Clearance::User

  PASSWORD_REGEX = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/

  validates :name,      presence: true
  validates :email,     presence: true
  validates :password,  unless: :skip_password_validation?,
                        format: {
                          with: PASSWORD_REGEX,
                          message: "must include at least one lowercase letter, one uppercase letter, and one digit"
                        }

end
