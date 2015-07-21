class User < ActiveRecord::Base
  has_secure_password
  has_many :topics
  before_create { generate_token(:auth_token) }

  validates :email, presence: true
  # validates :password, presence: true#, confirmation: true
  #validates :password_confirmation, presence: true

  def send_password_reset
    generate_token(:reset_token)
    self.reset_token_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  # def create_password_reset_token
  #   self.reset_token = SecureRandom.hex 128
  # end

end
