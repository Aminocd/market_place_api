class Api::V1::OrderProductSerializer < ProductSerializer
	def include_user?
		false
	end
end
