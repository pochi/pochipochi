class Provider < ActiveRecord::Base
  belongs_to :user

  def self.create_with_omniauth(auth, user)
    create! do |provider|
      provider.name = auth["provider"]
      provider.uid = auth["uid"]
      provider.user_id = user.id
    end
  end
end
