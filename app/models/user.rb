class User
  include Mongoid::Document
  
  field :username, type: String
  field :email, type: String
  
  validates_presence_of :username, :message => I18n.t("user.yml.validations.empty_username")
  
  attr_accessible :username, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

end
