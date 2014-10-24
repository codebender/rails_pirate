class Prediction < ActiveRecord::Base
  validates_presence_of :user_id, :date
end
