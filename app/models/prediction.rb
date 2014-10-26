class Prediction < ActiveRecord::Base
  validates_presence_of :user_id, :date

  belongs_to :user
  has_many :prediction_data

  def process
    training_data = StatDatum.where(user_id: user_id).
      where('start_time > ?', 1.month.ago).to_a

    test_data = []

    predictor = RPredictor.new(training_data, test_data)
    predictor.make_prediction
  end
end
