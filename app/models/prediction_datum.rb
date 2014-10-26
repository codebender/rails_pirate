class PredictionDatum < ActiveRecord::Base
  validates_presence_of :user_id, :prediction_id, :start_time, :value
end
