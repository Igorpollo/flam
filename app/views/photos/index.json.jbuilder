json.array!(@photos) do |photo|
  json.extract! photo, :id, :album_id, :user_id, :title, :description
  json.url photo_url(photo, format: :json)
end
