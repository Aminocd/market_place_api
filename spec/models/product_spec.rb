require 'spec_helper'

describe Product do
	let(:product) { FactoryBot.build :product }
	subject { product }

	it { should respond_to(:title) }
	it { should respond_to(:price) }
	it { should respond_to(:published) }
	it { should respond_to(:user_id) }

	it { should_not be_published }

	it { should validate_presence_of :title }
	it { should validate_presence_of :price }
	it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
	it { should validate_presence_of :user }

	it { should belong_to :user }
	it { should have_many(:placements) }
	it { should have_many(:orders).through(:placements) }

	describe ".filter_by_title" do
		before(:each) do
			@product1 = FactoryBot.create :product, title: "A plasma TV"
			@product2 = FactoryBot.create :product, title: "laptop"
			@product3 = FactoryBot.create :product, title: "tablet"
			@product4 = FactoryBot.create :product, title: "LCD TV"
		end

		context "when a 'TV' title pattern is sent" do
			it "returns 2 items" do
				expect(Product.filter_by_title("TV").length).to eq 2
			end

			it "returns an array of items pattern @product1 and @product2" do
				expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
			end
		end
	end

	describe "filter by price and sort by update time" do
		before(:each) do
			@product1 = FactoryBot.create :product, price: 100
			@product2 = FactoryBot.create :product, price: 50
			@product3 = FactoryBot.create :product, price: 110
			@product4 = FactoryBot.create :product, price: 90
		end

		context ".above_or_equal_to_price" do
			it "returns products with a price greater than or equal to the value given as an argument" do
				expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
			end
		end

		context ".below_or_equal_to_price" do
			it "returns products with a price less than or equal to the value given as an argument" do
				expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
			end
		end

		context "sorted by last update" do
			before(:each) do
				@product2.touch
				@product3.touch
			end

			it "lists the products touched first" do
				expect(Product.recent).to match_array([@product3, @product2, @product4, @product1])
			end
		end
	end

	describe ".search" do
		before(:each) do
			@product1 = FactoryBot.create :product, price: 100, title: "Plasma TV"
			@product2 = FactoryBot.create :product, price: 50, title: "Videogame console"
			@product3 = FactoryBot.create :product, price: 150, title: "MP3"
			@product4 = FactoryBot.create :product, price: 99, title: "Laptop"
		end

		context "when title 'videogame' and min price '100' are set" do
			it "returns an empty array" do
				search_hash = { keyword: "videogame", min_price: 100}
				expect(Product.search(search_hash)).to be_empty
			end
		end

		context "when title 'tv', max price '150' and min price '50' are set" do
			it "returns product1" do
				search_hash = { keyword: "tv", min_price: 50, max_price: 150 }
				expect(Product.search(search_hash)).to match_array([@product1])
			end
		end

		context "when an empty hash is sent" do
			it "returns all the products" do
				search_hash = {}
				expect(Product.search(search_hash)).to match_array([@product1, @product2, @product3, @product4])
			end
		end

		context "when product_ids is present" do
			it "returns the product from the ids" do
				search_hash = { product_ids: [@product1.id, @product2.id] }
				expect(Product.search(search_hash)).to match_array([@product1, @product2])
			end
		end
	end
end
