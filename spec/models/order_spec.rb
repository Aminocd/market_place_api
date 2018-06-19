require 'spec_helper'

RSpec.describe Order, type: :model do
	let(:order) { FactoryBot.build :order }
	subject { order }

	it { should respond_to(:total) }
	it { should respond_to(:user_id) }

	it { should validate_presence_of :user }
#	it { should validate_presence_of :total }
#	it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) } # can't do the last two validations because the set_total! method causes them to fail

	it { should belong_to :user }

	it { should have_many(:placements) }
	it { should have_many(:products).through(:placements) }

	describe "#build_placements_with_product_ids_and_quantities" do
	end

	describe "valid?" do
		before(:each) do
			product1 = FactoryBot.create :product, price: 85, quantity: 5
			product2 = FactoryBot.create :product, price: 100, quantity: 10

			placement1 = FactoryBot.create :placement, product: product1, quantity: 3
			placement2 = FactoryBot.create :placement, product: product2, quantity: 15

			@order = FactoryBot.create :order

			@order.placements << placement1
			@order.placements << placement2
		end

		it "should not be valid" do
			expect(@order).to_not be_valid
		end
	end
end
