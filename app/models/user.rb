class User < ApplicationRecord

    has_one :portfolio
    has_many :transactions
    has_many :stocks, through: :transactions


    validates :email_address, uniqueness: true
    has_secure_password 

end
