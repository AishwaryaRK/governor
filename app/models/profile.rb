class Profile < ApplicationRecord
  belongs_to :user

  class << self
    def create_using_token(name, email, token)
      avatar_url = token.info['image']
      location   = token.info['location'] || 'Internet'
      biography  = token.info['description'] || Chuck.say
      create(:display_name => name,
             :public_email => email,
             :avatar_url   => avatar_url,
             :location     => location,
             :biography    => biography)
    end
  end
end
