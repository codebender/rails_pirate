require 'rails_helper'

describe Prediction do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:date) }
end
