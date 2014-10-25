class PredictionDatum < ActiveRecord::Base
  validates_presence_of :user_id, :start_time, :value
end
