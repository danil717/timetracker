class ErrorsController < ApplicationController
  def error_404
    render :status => 404
    #render 'errors/not_found'
  end
end
