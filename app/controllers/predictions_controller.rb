class PredictionsController < ApplicationController
  def new
    @prediction = Prediction.new
    @users = User.all
  end

  def create
    @prediction = Prediction.new(params[:prediction].permit(:user_id, :date))

    if @prediction.save
      @prediction.process
      redirect_to predictions_path, notice: 'Prediction Request Created!'
    else
      render :new
    end
  end

  def index
    @predictions = Prediction.all
  end
end
