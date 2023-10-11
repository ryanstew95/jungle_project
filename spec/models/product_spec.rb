require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    before(:each) do
      @category = Category.create(name: 'Electronics')
      @product = Product.new(
        name: 'Awesome Gadget',
        price_cents: 999,
        quantity: 5,
        category: @category
      )
    end

    it 'is valid with all four fields set' do
      expect(@product).to be_valid
    end

    it 'is invalid without a name' do
      @product.name = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without a price' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is invalid without a quantity' do
      @product.quantity = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is invalid without a category' do
      @product.category = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
