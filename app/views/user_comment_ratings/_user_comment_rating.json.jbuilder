json.extract! user_comment_rating, :id, :value, :comment_id, :user_id, :created_at, :updated_at
json.url user_comment_rating_url(user_comment_rating, format: :json)
