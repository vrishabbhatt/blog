class AddPostIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments , :post_id , :int , default: :nil
  end
end
