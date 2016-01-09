Paperclip.interpolates :elasticsearch_id do |attachment, style|
  # Note we want to use an empty string in case elasticsearch_id is nil.
  # Paperclip will call `gsub` on this valid, which raises an exception if the
  # valid is nil.
  attachment.instance.elasticsearch_id || ''
end
