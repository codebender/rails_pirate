require 'rails_helper'

describe RPredictor do
  describe 'make_prediction' do
    it 'calls the rserve client with the r script' do
      instance = RPredictor.new([], [])
      rserve = double(Rserve::Connection)
      allow(Rserve::Connection).to receive(:new).and_return(rserve)
      expect(rserve).to receive(:eval).with(instance.send(:r_script))

      instance.make_prediction
    end
  end
end
