module JsonFollowList
	class FollowingController < ::ApplicationController
		requires_plugin 'json-follow-list'

		skip_before_filter :check_xhr #allow API requests
    before_filter :ensure_logged_in #or just check the users logged in

		def topics
			# Magically make arrays from string Wooooo!
			uid = params["uid"].split(",")
			tid = params["tid"].split(",")

			#request post from usrs AND specific topics ahhhhhhh!
			posts = Post.where('user_id IN (?) OR topic_id IN (?) OR raw LIKE (?)', uid, tid, '%@everyone%' )
			 									.order(created_at: :desc)
			                 	.limit(params["total"])
												.offset(params["start"])

			# that cleaned that up
			render_json_dump(serialize_data(posts, PostSerializer))
			#K shows over
		end
	end
end
