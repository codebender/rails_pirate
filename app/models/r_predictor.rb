require 'rserve'

class RPredictor
  attr_accessor :training_data, :test_data

  def initialize(training_data, test_data)
    @training_data = training_data
    @test_data = test_data
  end

  def make_prediction
    r_results = r_client.eval(r_script)

    hashize_results(r_results)
  end

  private

  def r_client
    Rserve::Connection.new
  end

  def r_script
<<-EOF
  train <- data.frame(datetime=c(#{dates_string(training_data)}),value=c(#{training_data.map(&:value).join(',')}))
  test <- data.frame(datetime=c(#{dates_string(test_data)}))

  train$hour <- factor(format(as.POSIXct(train$datetime, format='%Y-%m-%d %H:%M'), format='%H'))
  train$weekday <- factor(format(as.POSIXct(train$datetime, format='%Y-%m-%d %H:%M'), format='%u'))

  test$hour <- factor(format(as.POSIXct(test$datetime, format='%Y-%m-%d %H:%M'), format='%H'))
  test$weekday <- factor(format(as.POSIXct(test$datetime, format='%Y-%m-%d %H:%M'), format='%u'))

  hour_wday_mean <- aggregate(value ~ hour + weekday, data=train, mean)
  merged <- merge(test, hour_wday_mean, by=c('hour', 'weekday'))

  merged <- merged[order(merged$datetime),]

  # Create submission dataframe and output to file
  submit <- data.frame(datetime = merged$datetime, value = merged$value)
EOF
  end

  def dates_string(data)
    test_data.map do |datum|
      "'#{datum.start_time.strftime('%Y-%m-%d %H:%M')}'"
    end.join(',')
  end

  def hashize_results(r_results)
    ruby_results = r_results.to_ruby
    ruby_results[0].zip(ruby_results[1]).to_h
  end
end
