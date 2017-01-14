require 'spec_helper'

describe Product do
	let(:product) { FactoryGirl.build :product }
	subject { product }

	it { should respond_to(:title) }
	it { should respond_to(:price) }
	it { should respond_to(:published) }
	it { should respond_to(:user_id) }

	it { should not_be_published }
end
