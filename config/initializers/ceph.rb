config = Rails.application.config_for(:ceph).with_indifferent_access

Rails.application.config.x.ceph_bucket_path = "#{config[:scheme]}://#{config[:host]}/#{config[:bucket]}"

# Create our Ceph client for talking with the radosgw service.
Rails.application.config.x.ceph_client = Fog::Radosgw::Provisioning.new(
  host: config[:host],
  port: config[:port],
  radosgw_access_key_id: config[:access_key],
  radosgw_secret_access_key: config[:secret_key]
)

ceph = Fog::Storage.new({
  provider: 'AWS',
  host: config[:host],
  aws_access_key_id: config[:access_key],
  aws_secret_access_key: config[:secret_key],
  path_style: false,
  scheme: config[:scheme],
  port: config[:port],
  aws_signature_version: 2
})

# Fetch the list of buckets in Ceph.
directories = ceph.directories

# Create our bucket if it does not exist.
if directories.map(&:key).exclude? config[:bucket]
  directories.create(
    key: config[:bucket],
    public: true)

  # Allow users to read/write to this bucket.
  ceph.put_bucket_acl(config[:bucket], "public-read-write")
end

Excon.defaults[:ssl_verify_peer] = config[:ssl_verify_peer]
