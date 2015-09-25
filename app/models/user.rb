class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_save   :correct_case_name
  before_create :create_activation_digest

  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :meetings

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 30 }
	validates :email, :favourite, presence: true
  validates :country, presence: true
	validates :postcode, length: { minimum: 4, maximum: 6 }, numericality: { only_integer: true }, allow_blank: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}\z/
  validates :password, length: { minimum: 6 }, allow_nil: true,
            format: { with: VALID_PASSWORD_REGEX, 
                      :message => "must have atleast one lowercase, one
                                   uppercase, one number and 
                                   be 6 characters long!" }


   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    def correct_case_name
      self.first_name = first_name.split.map(&:capitalize)*' '
      self.last_name = last_name.split.map(&:capitalize)*' '
      if self.middle_name != nil
        self.middle_name = middle_name.split.map(&:capitalize)*' '
      end
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
