class Post < ActiveRecord::Base
	has_attached_file :image , styles: {medium: "300x300>"}
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :comments , dependent: :destroy
end
