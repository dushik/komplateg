# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  remember_token  :string
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :operations, dependent: :destroy
  has_many :pdf_files

  before_save { email.downcase! }
  before_create :create_remember_token
  validates :name, presence:  true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:  true, format: {with:  VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
