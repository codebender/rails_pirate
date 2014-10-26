require 'rails_helper'

describe Prediction do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:date) }

  it { should have_many(:prediction_data) }
  it { should belong_to(:user) }

  describe 'process' do
    let(:prediction) { Prediction.new(user_id: 123,
      date: Date.new(2014, 10, 26)) }
    let(:prediciton_results) {
      { '2014-10-26 6:00' => 1, '2014-10-26 7:00' => 2, '2014-10-26 8:00' => 3,
       '2014-10-26 9:00' => 4, '2014-10-26 10:00' => 5, '2014-10-26 11:00' => 6,
       '2014-10-26 12:00' => 7, '2014-10-26 13:00' => 8,
       '2014-10-26 14:00' => 9, '2014-10-26 15:00' => 10,
       '2014-10-26 16:00' => 11, '2014-10-26 17:00' => 12,
       '2014-10-26 18:00' => 13, '2014-10-26 19:00' => 14,
       '2014-10-26 20:00' => 15, '2014-10-26 21:00' => 16,
       '2014-10-26 22:00' => 17, '2014-10-26 23:00' => 18,
       '2014-10-27 0:00' => 19, '2014-10-27 1:00' => 20,
       '2014-10-27 2:00' => 21, '2014-10-27 3:00' => 22,
       '2014-10-27 4:00' => 23, '2014-10-27 5:00' => 24 }
    }

    before(:each) do
      allow_any_instance_of(RPredictor).to receive(:make_prediction).
        and_return(prediciton_results)
    end

    it 'requests the last month of stat data' do
      week_old = StatDatum.create(user_id: 123, start_time: 1.week.ago,
        value: 1)
      three_week_old = StatDatum.create(user_id: 123, start_time: 3.weeks.ago,
        value: 2)
      five_week_old = StatDatum.create(user_id: 123, start_time: 5.weeks.ago,
        value: 3)

      expect(RPredictor).to receive(:new).with([week_old, three_week_old],
        Array).and_call_original
      prediction.process
    end

    it 'asks R for a prediction for the requested date' do
      expect_any_instance_of(RPredictor).to receive(:make_prediction)
      prediction.process
    end

    it 'saves the prediction data' do
      prediction.save

      prediction.process

      expect(PredictionDatum.where(prediction_id: prediction.id).size).to eq 24
    end
  end
end
