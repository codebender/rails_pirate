require 'rails_helper'

describe StatDatum do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :value }
end
