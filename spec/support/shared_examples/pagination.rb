shared_examples "pagination list" do
	it { expect(json_response).to have_key(:"meta")}
	it { expect(json_response[:meta]).to have_key(:"pagination") }
	it { expect(json_response[:meta][:pagination]).to have_key(:"per-page") }
	it { expect(json_response[:meta][:pagination]).to have_key(:"total-count") }
	it { expect(json_response[:meta][:pagination]).to have_key(:"total-pages") }
end
