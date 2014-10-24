require 'rails_helper'

feature 'Predition analysis' do
  scenario 'User can create a prediction request for a user' do
    user1 = User.create(username: 'Matthew')
    user2 = User.create(username: 'Bender')

    visit root_path

    expect(page).to have_content 'Predicitons with R'
    expect(page).to have_content 'Who?'
    expect(page).to have_content 'When?'

    select user2.username, from: 'Who?'
    select_date Date.tomorrow, from: 'prediction_date'

    click_button 'Create Prediciton'

    expect(Prediction.all.size).to eql 1
    expect(Prediction.find_by(user_id: user2.id, date: Date.tomorrow)).
      to_not be_nil
  end

  scenario 'User can view list of requested predictions' do
    Prediction.create(user_id: 123, date: Date.tomorrow)
    Prediction.create(user_id: 456, date: Date.today)

    visit predictions_path

    expect(page).to have_content('User ID')
    expect(page).to have_content('Date')
    expect(page).to have_content('123')
    expect(page).to have_content('456')
    expect(page).to have_content(Date.tomorrow.to_s)
    expect(page).to have_content(Date.today.to_s)
  end

  def select_date(date, options = {})
    field = options[:from]
    select date.year.to_s, from: "#{field}_1i"
    select date.strftime("%B"), from: "#{field}_2i"
    select date.day.to_s, from: "#{field}_3i"
  end
end
