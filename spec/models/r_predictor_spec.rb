require 'rails_helper'

describe RPredictor do
  describe 'make_prediction' do
    it 'calls the rserve client with the r script' do
      instance = RPredictor.new([], [])
      expect_any_instance_of(Rserve::Connection).to receive(:eval).
        with(instance.send(:r_script))

      instance.make_prediction
    end
  end
end
