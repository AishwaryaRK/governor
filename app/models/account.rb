class Account < ApplicationRecord
  belongs_to :user

  self.inheritance_column = nil

  class << self
    def create_using_token(type, token)
      create(:type     => type,
             :uid      => token.uid,
             :provider => token.provider,
             :token    => token.as_json)
    end
  end
end
