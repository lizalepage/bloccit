class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post
    before_save { self.email = email.downcase if email.present?}

    before_save :format_user_name
    before_save {self.role ||= :member }
    
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
    
    def favorite_for(post)
        favorites.where(post_id: post.id).first

    end
    
    def avatar_url(size)
        gravatar_id = Digest::MD5::hexdigest(self.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end


    
    
    def favorite_list
        favorites.where(user: user)
    end    
    
    def avatar_url(size)
        gravatar_id = Digest::MD5::hexdigest(self.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end

        
    
  
    
    enum role: [:member, :admin, :moderator]
end
