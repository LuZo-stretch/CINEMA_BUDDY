class MessagesController < ApplicationController
  def show
    @chat = Chatroom.find(params[:id])
    @message = Message.new
  end
end
