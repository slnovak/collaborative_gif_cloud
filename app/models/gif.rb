class GIF < ActiveRecord::Base
  include Elasticsearch::Model

  index_name "gifs-#{Rails.env}"

  acts_as_taggable

  belongs_to :user

  serialize :metadata

  # See config/initializers/paperclip.rb for the interpolation definition of
  # :elasticsearch_id. This allows us to save data in the object store using
  # the global UUID assigned from Elasticsearch.
  has_attached_file :image,
    storage: :fog,
    fog_credentials: lambda {|image| image.instance.fog_credentials },
    fog_directory: Rails.application.config_for(:ceph)['bucket'],
    fog_host: Rails.application.config_for(:ceph)['host'],
    fog_public: true,
    path: ':elasticsearch_id',
    ssl_verify_peer: false

  validates_attachment_content_type :image, content_type: 'image/gif'

  validates :user, presence: true

  # Before we create the GIF, we need to register it with Elasticsearch so that
  # we can get the Elasticsearch UUID and assign it to the GIF.
  before_create :register_with_elasticsearch!

  # If there is a rollback on create, unregister with Elasticsearch.
  after_rollback :unregister_with_elasticsearch!, on: :create

  # If we destroy a gif, remove it from Elasticsearch
  after_commit :unregister_with_elasticsearch!, on: :destroy

  def as_indexed_json(options={})
    # Note that we are not indexing :id since we want to use the UUID from
    # ElasticSearch to ensure that we index data in a federated environment.
    # Instead, we assign our ActiveRecord id to "application_id".

    as_json(except: [:id, :elasticsearch_id, :user_id]).
      merge(application_id: id, user: user.username)
  end

  def fog_credentials
    # Use the user's Ceph authorization keys to upload the file to Ceph.
    access_key, secret_key = user.ceph_authorization_keys

    { host: Rails.application.config_for(:ceph)['host'],
      scheme: Rails.application.config_for(:ceph)['scheme'],
      aws_access_key_id: access_key,
      aws_secret_access_key: secret_key,
      aws_signature_version: 2,
      path_style: false,
      provider: 'AWS' }
  end

  protected

  def register_with_elasticsearch!
    response = __elasticsearch__.index_document
    self.elasticsearch_id = response['_id']
  end

  def unregister_with_elasticsearch!
    __elasticsearch__.delete_document(id: elasticsearch_id)
  end
end
