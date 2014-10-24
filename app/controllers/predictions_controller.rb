class PredictionsController < ApplicationController
  def new
    @prediction = Prediction.new
    @users = User.all
  end

  def create
    @prediction = Prediction.new(params[:prediction].permit(:user_id, :date))

    if @prediction.save
      render :index, notice: 'Prediction Request Created!'
    else
      render :new
    end
  end
end