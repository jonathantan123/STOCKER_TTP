class Portfolio < ApplicationRecord
    belongs_to :user
    serialize :stocks, Array
end
