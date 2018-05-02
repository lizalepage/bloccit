require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
    let(:my_topic)  { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
    
    let(:my_sponsored_post) {my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1000)}
    
    describe "GET show" do
        it "returns http success" do
            get :show, params: {topic_id: my_topic.id, id: my_sponsored_post.id}
            expect(response).to have_http_status(:success)
        end
        
        it "renders the show view" do
            get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id}
            expect(response).to render_template :show
        end
        
        it "assigns my_sponsored_post to @sponsored_posts" do
            get :show, params: {topic_id: my_topic.id, id: my_sponsored_post.id}
            expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
        end
    end
    
    describe "GET new" do
        it "returns http success" do
            get :new, params: {topic_id: my_topic.id}
            expect(response).to have_http_status(:success)
        end
        
        it "renders the new view" do
            get :new, params: {topic_id: my_topic.id}
            expect(response).to render_template :new
        end
        
        it "instantiates @sponsored_post" do
            get :new, params: {topic_id: my_topic.id}
            expect(assigns(:sponsored_post)).not_to be_nil
        end    
    end
    
    describe "POST create" do
        it "increases the number of sponsored_posts by 1" do
           expect{post :create, params: {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1000} } }.to change(SponsoredPost,:count).by(1)
        end
        
        it "assigns the new sponsored_post to @sponsored_post" do
            post :create, params: {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1000} } 
            expect(assigns(:sponsored_post)).to eq SponsoredPost.last
        end
        
        it "redirects to the new sponsored_post" do
            post :create, params: {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1000} }
            expect(response).to redirect_to [my_topic, SponsoredPost.last]
        end
    
    end
    
    describe "GET edit" do
        it "returns http success" do
            get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
            expect(response).to have_http_status(:success)
        end
        
        it "renders the edit view" do
            get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
            expect(response).to render_template :edit
        end
        
        it "assigns sponsored_post to be updated to @sponsored_post" do
            get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
            
            sponsored_post_instance = assigns(:sponsored_post)
            
            expect(sponsored_post_instance.id).to eq my_sponsored_post.id
            expect(sponsored_post_instance.title).to eq my_sponsored_post.title
            expect(sponsored_post_instance.body).to eq my_sponsored_post.body
            
            
        end
            
            
    end
    
    describe "PUT update" do
        it "updates sponsored_post with expected attributes" do
            new_title = RandomData.random_sentence
            new_body = RandomData.random_paragraph
            new_price = 50
            
            put :update, params: {topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price } }
            
            updated_sponsored_post = assigns(:sponsored_post)
            expect(updated_sponsored_post.id).to eq my_sponsored_post.id
            expect(updated_sponsored_post.title).to eq new_title
            expect(updated_sponsored_post.body).to eq new_body
            expect(updated_sponsored_post.price).to eq new_price
        end
         
         it "redirects to the updated_sponsored_post" do
            new_title = RandomData.random_sentence
            new_body = RandomData.random_paragraph
            new_price = 50
            
              put :update, params: {topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price } }
              expect(response).to redirect_to [my_topic, my_sponsored_post]
        end

    end
    
    describe "DELETE destroy" do
        it "deletes the post" do
            delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
            
            count = SponsoredPost.where({id: my_sponsored_post.id}).size
            expect(count).to eq 0
        end
        
        it "redirects_to topic show" do
             delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
             expect(response).to redirect_to my_topic
        end
    end    
            
    
end
