class User
  include Mongoid::Document

  has_many :services, dependent: :destroy
  field :username
  has_many :goals

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def email_required?
    false
  end

  def password_required?
    false
  end

  def has_token
    services.where(:provider => "beeminder").first
  end

  def beeminder_client
    s = services.where(:provider => "beeminder").first
    s ? Beeminder::User.new(s.token, :auth_type => :oauth) : nil
  end

  def apply_omniauth(omniauth)
    service = services.where(provider: omniauth['provider']).first
    service ||= services.build
    service.provider  = omniauth["provider"]
    service.uid       = omniauth["uid"]
    service.token     = omniauth["credentials"]["token"]
    service.uname     = omniauth["info"]["id"]

    self.username ||= omniauth['info']['id']
  end
end
