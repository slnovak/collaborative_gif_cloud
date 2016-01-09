config = Rails.application.config_for(:ceph).with_indifferent_access

Rails.application.config.x.ceph_client = Fog::Radosgw::Provisioning.new(
  host: config[:host],
  port: config[:port],
  radosgw_access_key_id: config[:access_key],
  radosgw_secret_access_key: config[:secret_key]
)
