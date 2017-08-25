# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_reader :password
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Must have a password'}
  validates :password, length: { minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  def self.find_by_credentials(options={})
    user = User.find_by(email: options[:email])
    return user if user &&
        BCrypt::Password.new(user.password_digest).is_password?(options[:password])
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def reset_session_token! # only works with saved user instances
    self.update(session_token: SecureRandom.urlsafe_base64)
  end

  def ensure_session_token # works with unsaved user instances
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
