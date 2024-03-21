class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
      # add part of the messages
  end

  # create method to create chat between me and the match user
end
