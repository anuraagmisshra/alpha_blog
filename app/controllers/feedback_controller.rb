# frozen_string_literal: true

class FeedbackController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    feedback = Feedback.new(feedback_params)
    if feedback.save
      flash[:success] = 'Thanks for the feedback. We are working to make this better day by day'
      redirect_to root_path
    else
      flash.now[:error] = 'Something went wrong please try again'
      render 'new'
    end
  end

  private

  def feedback_params
    params.expect(feedback: %i[title description user_id])
  end
end
