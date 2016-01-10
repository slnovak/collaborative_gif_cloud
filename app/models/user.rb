class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, format: { with: /\A[a-z0-9][-_a-z0-9]{1,19}\z/i }

  has_many :gifs

  def full_name
    [first_name, last_name].join(" ")
  end

  def ceph_authorization_keys
    # TODO: determine strategy if multiple Ceph access keys exist
    ceph_identity[:keys].
      first.
      values_at(:access_key, :secret_key)
  end

  protected

  def ceph_identity
    find_ceph_identity || create_ceph_identity
  end

  def find_ceph_identity
    response = ceph_client.get_user(username)

    case response.status
    when Rack::Utils.status_code(:ok)
      JSON.parse(response.data[:body]).with_indifferent_access
    when Rack::Utils.status_code(:not_found)
      nil
    else
      raise "Received error code #{response.status_code} from Ceph"
    end
  end

  def create_ceph_identity
    response = ceph_client.create_user(username, full_name, email)

    case response.status
    when Rack::Utils.status_code(:ok)
      JSON.parse(response.data[:body]).with_indifferent_access
    else
      raise "Received error code #{response.status_code} from Ceph"
    end
  end

  def ceph_client
    Rails.application.config.x.ceph_client
  end
end
