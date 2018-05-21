module UsersHelper
    def any_posts
        current_user.posts.count > 0
    end    
    
    def any_comments
        current_user.comments.count > 0
    end   
end
