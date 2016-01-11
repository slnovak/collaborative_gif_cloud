require 'elasticsearch/dsl'

config = Rails.application.config_for(:elasticsearch)

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: config[:host],
  port: config[:port] || 8080,
  username: config[:username],
  password: config[:password])

# I should be shot for this. Load in a custom Elasticsearch ActiveRecord 
# adapter that binds to the "elasticsearch_id" column on records.
require "#{Rails.root}/lib/elasticsearch/model/adapters/active_record_with_elasticsearch_id"
