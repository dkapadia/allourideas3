class ChoicesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def show
    @meta = '<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">'
    @question_id = Question.find_id_by_name(params[:question_id])
    @earl = Earl.find params[:question_id]
    @choice = Choice.find(params[:id], :params => {:question_id => @question_id})
    if @choice
      @question_name = @choice.attributes['question_name']
      @data = @choice.attributes['item_data']
      @score = @choice.attributes['score'].round rescue (@score = 0)
      logger.info "the score is #{@score.inspect}"
      @created_at = @choice.attributes['created_at']
      @votes_count = @choice.attributes['wins_plus_losses']
      respond_to do |format|
        format.html # show.html.erb
      end
    else
      redirect_to('/') and return
    end
  end
  
  
  def activate
    authenticate and return unless current_user
    
    @question = Question.find_by_name(params[:question_id])
    logger.info "actual question ID is #{@question.id}"
    @choice = Choice.find(params[:id], :params => {:question_id => @question.id})
    logger.info "Found choice: #{@choice.inspect}"
    #@choice.activate! if @choice
    
    redirect_to('/') and return unless current_user == @question.creator
    
    @choice.put(:update_from_abroad, :params => {:question_id => @question.id}) if @choice
    flash[:for_real] = "You have successfully activated the idea <strong>#{@choice.attributes['data']}</strong>"
    logger.info flash[:notice]
    # redirect_to("#{@question.earl}/choices/#{@choice.id}") and return
    redirect_to("#{@question.earl}") and return
  end
  
  
  def activate
    @question = Question.find_by_name(params[:question_id])
    logger.info "actual question ID is #{@question.id}"
    @choice = Choice.find(params[:id], :params => {:question_id => @question.id})
    logger.info "Found choice: #{@choice.inspect}"
    @choice.put(:update_from_abroad, :params => {:question_id => @question.id}) if @choice
    flash[:for_real] = "You have successfully activated the idea <strong>#{@choice.attributes['data']}</strong>"
    logger.info flash[:notice]
    # redirect_to("#{@question.earl}/choices/#{@choice.id}") and return
    redirect_to("#{@question.earl}") and return
  end
  
  
end