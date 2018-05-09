class User < ApplicationRecord
    before_save { self.email = email.downcase if email.present?}

    before_save :format_user_name
    
    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    
    validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 6 }, allow_blank: true
    
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 254 }
    
    has_secure_password
    
    def format_user_name
        if name 
            new_name = name.split
            name_array = []
        
            new_name.each do |n|
                name_array << n.capitalize
            end 
        self.name = name_array.join(" ")
        end
    end    
end