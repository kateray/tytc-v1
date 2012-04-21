class VotesController < ApplicationController
  def create
    @vote = current_user.votes.build(params[:vote])
    
    if @vote.save
      head :ok
    else
      render :text => @vote.errors.full_messages.join(", "), :status => :unprocessable_entity
    end
    
  end
end
