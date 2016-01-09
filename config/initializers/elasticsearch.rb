config = Rails.application.config_for(:elasticsearch)

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: config[:host],
  port: config[:port] || 8080,
  username: config[:username],
  password: config[:password])
