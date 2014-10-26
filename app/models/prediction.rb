class Prediction < ActiveRecord::Base
  validates_presence_of :user_id, :date

  belongs_to :user
  has_many :prediction_data

  def process
    training_data = StatDatum.where(user_id: user_id).
      where('start_time > ?', 1.month.ago).to_a

    test_data = build_test_data
    
    results = RPredictor.new(training_data, test_data).make_prediction

    save_results(results, test_data)
  end

  private

  def build_test_data
    test_data = []

    Time.use_zone('Mountain Time (US & Canada)') do
      range = date.at_beginning_of_day.to_i...date.at_end_of_day.to_i

      range.step(1.hour) do |seconds_since_epoch|
        test_data << PredictionDatum.new(start_time: Time.at(seconds_since_epoch),
          user_id: user_id, prediction_id: id)
      end
    end

    test_data
  end

  def save_results(results, test_data)
    results.each do |result_time, result_value|
      test_data.find { |data| data.start_time == Time.zone.parse(result_time) }.
        value = result_value
    end

    test_data.each(&:save)
  end
end
