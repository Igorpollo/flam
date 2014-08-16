class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


         validates :profile_name, presence: true,
                                  uniqueness: true,
                                  format: {
                                    with: /\A[a-zA-Z0-9_-]+$\z/,
                                    message: "Only letters and numbers are permited."
                                  }
         def to_param
           profile_name
         end
         
         def full_name
         	first_name + " " + last_name
         end

        def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.first_name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
 		end
		end

		 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      	end
    	end
  		end
         has_many :albums
         has_many :comments
         has_many :likes
         has_many :favorites
         has_many :photos
         has_many :clientes
         has_many :user_followers
         has_many :followers, through: :user_followers


end
