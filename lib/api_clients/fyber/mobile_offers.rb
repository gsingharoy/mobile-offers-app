module ApiClients
  module Fyber
    class MobileOffers

      CONFIG_FILE = File.join([Rails.root, 'config', 'api_clients','fyber', 'mobile_offers.yml'])

      def initialize(attrs = {})
        [:uid, :pub0, :page].each do |attr|
          raise("missing attrs :#{attr}") if attrs[attr].blank?
        end
        @uid  = attrs[:uid]
        @pub0 = attrs[:pub0]
        @page = attrs[:page]
      end

      private

      def config
        @config ||= ActiveSupport::HashWithIndifferentAccess.new(YAML.load_file(CONFIG_FILE)[Rails.env])
      end
    end
  end
end