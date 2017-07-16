class Account < ApplicationRecord
  belongs_to :user

  self.inheritance_column = nil

  class << self
    def find_for_token(type, token)
      where(:type     => type,
            :uid      => token.uid,
            :provider => token.provider).first
    end

    def create_with_token(type, token)
      create(:type     => type,
             :uid      => token.uid,
             :provider => token.provider,
             :token    => token.as_json)
    end
  end
end
