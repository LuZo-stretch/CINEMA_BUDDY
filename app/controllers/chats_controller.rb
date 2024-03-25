class ChatsController < ApplicationController
  def index
    # @chats = Chat.all
    @match_ids = current_user.get_all_matches.pluck(:id)
    @chats = Chat.where(match_id: @match_ids)
    # If I'm logged in I should only see my matches (current_user.matches)
    # get all my matches and all the ID of the matches
  # @chats = current_user.matches.includes(:chat).map(&:chat).compact

  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
      # add part of the messages
  end

  # create method to create chat between me and the match user
end
