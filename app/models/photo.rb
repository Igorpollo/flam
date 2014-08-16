class Photo < ActiveRecord::Base
  is_impressionable
  
	extend FriendlyId
  friendly_id :photo_by_author, :use => :slugged

  def should_generate_new_friendly_id?
  title_changed?
  end

  def photo_by_author
    "#{title} by #{user_id}"
  end


  belongs_to :album
  belongs_to :user
  has_many :comments
  has_attached_file :path
  # Validate content type
  validates_attachment_content_type :path, :content_type => /\Aimage/
  # Validate filename
  validates_attachment_file_name :path, :matches => [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :path
end
