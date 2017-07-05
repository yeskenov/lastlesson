class Category < ActiveRecord::Base
    validates :name, presence: true, length: {minimum: 2, maximum: 13}, uniqueness: {case_sensitive: true}
end