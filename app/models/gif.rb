class GIF < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :metadata

  belongs_to :user

  attr_accessor :ceph_access_key, :ceph_secret_key

  has_attached_file :image,
    storage: :fog,
    fog_credentials: lambda {|gif| gif.fog_credentials },
    fog_directory: Rails.application.config_for(:ceph)[:bucket],
    path: lambda {|gif| gif.elastic_search_id }

  # TODO
  # + Figure out how to configure Ceph to work with has_attached file
  #
  # + When saving a file, we're going to need to assign ceph_*_key from
  #   the controller. This should be pulled from the session and should be
  #   generated from the Ceph API.

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
