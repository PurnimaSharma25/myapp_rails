class User
  include Mongoid::Document
  has_and_belongs_to_many :friends, class_name: "User"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :fname,              type: String, default: ""
  field :lname,              type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :auth_token,          type: String, default: ""

  ## Rememberable
  field :remember_created_at, type: Time

  before_create :generate_auth_token


  def generate_auth_token
    # token = nil
    # loop do
    #   token = SecureRandom.hex(16)
    #   debugger
    #   user = User.find_by(:auth_token => token)
    #   debugger
    #   break if user.blank?
    # end
    # self.auth_token = token
  end


end
