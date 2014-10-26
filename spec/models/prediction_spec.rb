require 'rails_helper'

describe Prediction do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:date) }

  it { should have_many(:prediction_data) }
  it { should belong_to(:user) }

  describe 'process' do
    let(:prediction) { Prediction.new(user_id: 123, date: Date.tomorrow) }

    before(:each) do
      allow_any_instance_of(RPredictor).to receive(:make_prediction)
    end

    it 'requests the last month of stat data' do
      week_old = StatDatum.create(user_id: 123, start_time: 1.week.ago, value: 1)
      three_week_old = StatDatum.create(user_id: 123, start_time: 3.weeks.ago,
        value: 2)
      five_week_old = StatDatum.create(user_id: 123, start_time: 5.weeks.ago,
        value: 3)
      prediction.process
    end

    it 'asks R for a prediction for the requested date' do
      expect_any_instance_of(RPredictor).to receive(:make_prediction)
      prediction.process
    end

    it 'saves the prediction data' do
      prediction.process
    end
  end
end
