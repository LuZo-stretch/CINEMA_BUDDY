# format.json { render json: { matched: false, match_id: match.id } }

json.matched @matched
json.match_id @match_id
json.icon render(partial: "heart", formats: :html, locals: {user: @user_match})
