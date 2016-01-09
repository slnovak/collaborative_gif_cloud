class GIF < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user

  serialize :metadata

  attr_accessor :ceph_access_key, :ceph_secret_key

  has_attached_file :image,
    storage: :fog,
    fog_credentials: lambda {|gif| gif.fog_credentials },
    fog_directory: Rails.application.config_for(:ceph)[:bucket],
    path: lambda {|gif| gif.elastic_search_id }

  def as_indexed_json(options={})
    as_json(except: [:id, :elasticsearch_id, :user_id])
  end

  protected

  def fog_credentials
    {
      host: Rails.appication.config_for(:ceph)[:host],
      aws_access_kid_id: ceph_access_key,
      aws_secret_access_key: ceph_secret_key,
      provider: 'AWS'
    }
  end
end
