class Photo < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_attached_file :path
  # Validate content type
  validates_attachment_content_type :path, :content_type => /\Aimage/
  # Validate filename
  validates_attachment_file_name :path, :matches => [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :path
end
