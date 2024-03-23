class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat_id = @chat.id
    @message.user_id = current_user.id

    @message.save
    ChatChannel.broadcast_to(
      @chat,
      render_to_string(
        partial: "message",
        locals: { message: @message }
      )
    )
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
