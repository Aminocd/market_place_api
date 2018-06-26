class Api::V1::OrderProductSerializer < Api::V1::ProductSerializer
	def include_user?
		false
	end
end
