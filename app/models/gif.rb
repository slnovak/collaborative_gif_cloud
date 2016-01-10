class GIF < ActiveRecord::Base
  include Elasticsearch::Model

  acts_as_taggable

  belongs_to :user

  serialize :metadata

  # See config/initializers/paperclip.rb for the interpolation definition of
  # :elasticsearch_id. This allows us to save data in the object store using
  # the global UUID assigned from Elasticsearch.
  has_attached_file :image,
    storage: :fog,
    fog_credentials: lambda {|gif| gif.fog_credentials },
    fog_directory: Rails.application.config_for(:ceph)[:bucket],
    path: ':elasticsearch_id'

  validates_attachment_content_type :image, content_type: 'image/gif'

  validates :user, presence: true

  around_create do |gif, block|
    # Before we save, index the document and assign the elastic_search id to
    # the model. This is so that we use the Elasticsearch uuid when saving the
    # image to Ceph.

    gif.register_with_elasticsearch!
    block.call
    gif.unregister_with_elasticsearch! unless gif.persisted?
  end

  # If we destroy a gif, remove it from Elasticsearch
  after_commit :unregister_with_elasticsearch!, on: :destroy

  def as_indexed_json(options={})
    # Note that we are not indexing :id since we want to use the UUID from
    # ElasticSearch to ensure that we index data in a federated environment.
    # Instead, we assign our ActiveRecord id to "application_id".

    as_json(except: [:id, :elasticsearch_id, :user_id]).
      merge(application_id: id, user: user.username)
  end

  protected

  def fog_credentials
    # Use the user's Ceph authorization keys to upload the file to Ceph.
    access_key, secret_key = user.ceph_authorization_keys

    { host: Rails.appication.config_for(:ceph)[:host],
      aws_access_kid_id: access_key,
      aws_secret_access_key: secret_key,
      provider: 'AWS' }
  end

  def register_with_elasticsearch!
    response = __elasticsearch__.index_document
    self.elasticsearch_id = response['_id']
  end

  def unregister_with_elasticsearch!
    __elasticsearch__.delete_document
    self.elasticsearch_id = nil
  end
end
