require 'digest/sha1'

module ApiClients
  module Fyber
    class MobileOffers

      CONFIG_FILE = File.join([Rails.root, 'config', 'api_clients','fyber', 'mobile_offers.yml'])

      BASE_URI = 'http://api.fyber.com/feed/v1/offers.json'

      def initialize(attrs = {})
        [:uid, :pub0, :page].each do |attr|
          raise("missing attrs :#{attr}") if attrs[attr].blank?
        end
        @attrs = attrs
      end

      def fetch
        HTTParty.get("#{BASE_URI}?#{url_params}")
      end

      private

      def url_params
        "#{url_params_without_hashkey}&hashkey=#{hashkey}"
      end

      def hashkey
        Digest::SHA1.hexdigest("#{url_params_without_hashkey}&#{config[:api_token]}")
      end

      def url_params_without_hashkey
        @url_params_without_hashkey ||= "appid=#{config[:appid]}&"\
        "device_id=#{config[:device_id]}&"\
        "ip=#{@attrs[:ip] || config[:ip]}&"\
        "locale=#{config[:locale]}&"\
        "offer_types=#{config[:offer_types]}&"\
        "page=#{@attrs[:page]}&"\
        "pub0=#{@attrs[:pub0]}&"\
        "timestamp=#{Time.now.utc.to_i - 10}&"\
        "uid=#{@attrs[:uid]}"
      end

      def config
        @config ||= ActiveSupport::HashWithIndifferentAccess.new(YAML.load_file(CONFIG_FILE)[Rails.env])
      end
    end
  end
end