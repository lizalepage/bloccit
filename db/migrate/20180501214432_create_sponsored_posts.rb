class CreateSponsoredPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsored_posts do |t|
      t.string :title
      t.text :body
      t.string :belongs_to
      t.string :Topic

      t.timestamps
    end
  end
end
