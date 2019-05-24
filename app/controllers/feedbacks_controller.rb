class FeedbacksController < ApplicationController

  def create
     puts "send mail here"

  end
  
  def new
      @feedback = Feedback.new
  end
end
