require 'random_data'

15.times do
   Topic.create!(
     name:         RandomData.random_sentence,
     description:  RandomData.random_paragraph
   )
end
topics = Topic.all



50.times do

    Post.create!(
        topic:  topics.sample,
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
   )
end

posts = Post.all
 


100.times do
    Comment.create!(
 
        post: posts.sample,
        body: RandomData.random_paragraph
   )
end


10.times do
    Advertisement.create!(
        title: RandomData.random_sentence,
        copy: RandomData.random_paragraph,
        price: 100000)
end


10.times do
    Question.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false)
end   

Post.create_with(id: 111).find_or_create_by(title: "Unique Post", body: "The most unique paragraph there everywas")
    
Comment.find_or_create_by(body: "love how unique this is", post_id: 111)



puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisement created"
