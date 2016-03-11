module JsonFollowList
	class FollowingController < ::ApplicationController
		requires_plugin 'json-follow-list'

		def topics
			# Magically make arrays from string Wooooo!
			uid = params["uid"].split(",")
			tid =  params["tid"].split(",")

			#request post from usrs AND specific topics ahhhhhhh!
			posts = Post.where('user_id IN (?) OR topic_id IN (?)', uid, tid )
			 									.order(created_at: :desc)
			                 	.limit(params["total"])
												.offset(params["start"])

			#Render a json object OMG!
			obj = {follow_posts: posts }
			render json: obj

			#K shows over
		end
	end
end
