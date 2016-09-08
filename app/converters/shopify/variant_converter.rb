module Shopify
  class VariantConverter
    def initialize(variant:)
      @variant = variant
    end

    def to_hash
      {
        product_id: variant_product.pos_product_id,
        weight: variant.weight,
        weight_unit: variant.weight_unit,
        price: variant.price,
        sku: variant.sku,
        updated_at: variant.updated_at
      }.merge(variant_uniqueness_constraint)
    end

    private

    attr_reader :variant

    def variant_uniqueness_constraint
      { option1: variant.sku }
    end

    def variant_product
      variant.product
    end
  end
end
