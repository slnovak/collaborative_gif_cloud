module GifsHelper
  def extension(gif)
    MIME::Types[gif.image.content_type].first.extensions.first.upcase
  end
end
