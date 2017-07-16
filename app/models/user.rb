class User < ApplicationRecord
  has_many :accounts

  devise :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  validates :username,
            :presence   => true,
            :uniqueness => {
                :case_sensitive => false
            }

  class << self
    def find_for_token(type, token)
      account = Account.find_for_token(type, token)
      account.user if account
    end

    def create_with_token(type, token)
      create(:name     => token.info.name,
             :email    => token.info.email,
             :username => SecureRandom.base58(48),
             :password => SecureRandom.base58(48),
             :accounts => [Account.create_with_token(type, token)])
    end

    def find_for_or_create_with_token(type, token)
      find_for_token(type, token) || create_with_token(type, token)
    end
  end
end
