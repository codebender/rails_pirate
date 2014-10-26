require 'rails_helper'

describe Prediction do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:date) }

  it { should have_many(:prediction_data) }
  it { should belong_to(:user) }

  describe 'process' do
    let(:prediction) { Prediction.new(user_id: 123, date: Date.tomorrow) }
    let(:prediciton_results) { double(Rserve::REXP::GenericVector) }

    before(:each) do
      allow_any_instance_of(RPredictor).to receive(:make_prediction).and_return(prediciton_results)
      allow(prediciton_results).to receive(:to_ruby).and_return([[],[]])
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
      prediction.date = Date.new(2014, 10, 26)
      prediction.save

      expect(prediciton_results).to receive(:to_ruby).and_return([
        ['2014-10-26 6:00', '2014-10-26 7:00', '2014-10-26 8:00',
         '2014-10-26 9:00', '2014-10-26 10:00', '2014-10-26 11:00',
         '2014-10-26 12:00', '2014-10-26 13:00', '2014-10-26 14:00',
         '2014-10-26 15:00', '2014-10-26 16:00', '2014-10-26 17:00',
         '2014-10-26 18:00', '2014-10-26 19:00', '2014-10-26 20:00',
         '2014-10-26 21:00', '2014-10-26 22:00', '2014-10-26 23:00',
         '2014-10-27 0:00', '2014-10-27 1:00', '2014-10-27 2:00',
         '2014-10-27 3:00', '2014-10-27 4:00', '2014-10-27 5:00'],
        [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]])

      prediction.process

      expect(PredictionDatum.where(prediction_id: prediction.id).size).to eq 24
    end
  end
end
