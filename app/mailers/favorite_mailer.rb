class FavoriteMailer < ApplicationMailer
    default from: "lizalepage@gmail.com"
    
    def new_comment(user, post, comment)
        headers["Message-ID"] = "<comments/#{comment.id}@mighty-hamlet-44946.herokuapp.com>"
        headers["In-Reply-To"] = "<post/#{post.id}@mighty-hamlet-44946.herokuapp.com>"
        headers["References"] = "<post/#{post.id}@mighty-hamlet-44946.herokuapp.com>"
        
        @user = user
        @post = post
        @comment = comment
        
        mail(to: user.email, subject: "new comment on #{post.title}")
    end
    
    def new_post(post)
        
        headers["Message-ID"] = "<post/#{post.id}@mighty-hamlet-44946.herokuapp.com>"
        headers["In-Reply-To"] = "<post/#{post.id}@mighty-hamlet-44946.herokuapp.com>"
        headers["References"] = "<post/#{post.id}@mighty-hamlet-44946.herokuapp.com>"
        
    
        @post = post
        
         mail(to: post.user.email, subject: "You created #{post.title}")
    
    end    
end
