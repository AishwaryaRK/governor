class User < ApplicationRecord
  devise :cas_authenticatable

  has_many :accounts
  has_one :profile

  validates :username,
            :presence   => true,
            :uniqueness => {
                :case_sensitive => false
            }

  class << self
    def find_for_token(type, token)
      account = Account.where(:type     => type,
                              :uid      => token.uid,
                              :provider => token.provider).first
      account.user if account
    end

    def create_with_token(type, token)
      name  = token.info['name'] || Haikunator.haikunate(0, ' ')
      email = token.info['email'] || "#{name.downcase.tr(' ', '.')}@example.com"
      create(:name     => name,
             :email    => email,
             :username => SecureRandom.base58(48),
             :password => SecureRandom.base58(48),
             :profile  => Profile.create_using_token(name, email, token),
             :accounts => [Account.create_using_token(type, token)])
    end

    def find_for_or_create_with_token(type, token)
      find_for_token(type, token) || create_with_token(type, token)
    end
  end
end
