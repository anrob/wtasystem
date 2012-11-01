class Staff < ActiveRecord::Base
  attr_accessible :email, :image, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.email = auth.info.email
        user.image = auth.info.image
        user.save!
      end
    end
end
