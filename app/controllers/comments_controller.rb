class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    current_family.comments.create(comment_params.merge(user: current_user))
    redirect_to school_family_path(current_school, current_family)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:message)
  end
  
  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:family_id])
  end

  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(params[:school_id])
  end  
end
