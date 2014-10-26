require 'rails_helper'

describe PredictionDatum do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :prediction_id }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :value }
end
