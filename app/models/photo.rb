class Photo < ActiveRecord::Base
	extend FriendlyId
  friendly_id :photo_by_author, :use => :slugged

  def should_generate_new_friendly_id?
  title_changed?
  end

  delegate :profile_name, to: :user

  def photo_by_author
    "#{title} by #{profile_name}"
  end


  belongs_to :album
  belongs_to :user
  has_many :likes
  has_many :favorites
  has_many :views
  has_many :comments
  has_attached_file :path
  # Validate content type
  validates_attachment_content_type :path, :content_type => /\Aimage/
  # Validate filename
  validates_attachment_file_name :path, :matches => [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :path
end
