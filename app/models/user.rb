class User < ActiveRecord::Base
  attr_accessible :user_name, :password_digest, :session_token
  attr_reader :password

  validates :user_name, :presence => true, :uniqueness => true
  validates :password_digest, :presence => { :message => "Password can't be blank"}
  validates :session_token, :presence => true
  validates :password, :length => { :minimum => 6, :allow_nil => true }

  after_initialize :ensure_session_token

  has_many(
    :cats,
    :class_name => "Cat",
    :foreign_key => :user_id,
    :primary_key => :id
  )


  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    current_user = self.find_by_user_name(user_name)

    return nil if current_user.nil?

    current_user.is_password?(password) ? current_user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end


  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
