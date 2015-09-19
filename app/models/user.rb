# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  has_many :moderated_subs,
    class_name: "Sub",
    primary_key: :id,
    foreign_key: :moderator_id

  has_many :authored_posts,
    class_name: "Post",
    primary_key: :id,
    foreign_key: :author_id

  has_many :authored_comments,
    class_name: "Comment",
    primary_key: :id,
    foreign_key: :author_id

  def self.generate_token
    token = SecureRandom::urlsafe_base64
    while User.exists?(session_token: token)
      token = SecureRandom::urlsafe_base64
    end
    token
  end

  def User.find_by_credentials(user_name, given_password)
    user = User.find_by(user_name: user_name)
    user && user.is_password?(given_password) ? user : nil
    # return user if user && user.is_password?(given_password)
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def is_password?(given_password)
    bycrypt = BCrypt::Password.new(self.password_digest)
    bycrypt.is_password?(given_password)
  end


  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_token
  end
end
