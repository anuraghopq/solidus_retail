module Spree
  module Retail
    module Shopify
      class OrderPresenter < Delegator
        def all_inventory_units
          shipments.map(&:inventory_units).uniq
        end
      end
    end
  end
end
