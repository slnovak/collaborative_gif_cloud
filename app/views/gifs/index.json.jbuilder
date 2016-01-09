json.array!(@gifs) do |gif|
  json.extract! gif, :id
  json.url gif_url(gif, format: :json)
end
