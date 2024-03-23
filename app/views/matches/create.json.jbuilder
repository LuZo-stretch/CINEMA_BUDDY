# format.json { render json: { matched: false, match_id: match.id } }

# json.user_match_id @user_match_id
json.matched @matched
json.match_id @match_id
json.chat @chat
json.icon render(partial: "heart", formats: :html, locals: { user: @user_match })
json.icon_show render(partial: "heart-show", formats: :html, locals: { user: @user_match })
