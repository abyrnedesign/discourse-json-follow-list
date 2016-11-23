module JsonFollowList
	class FollowingController < ::ApplicationController
		requires_plugin 'json-follow-list'

		skip_before_filter :check_xhr #allow API requests
		before_filter :block_if_readonly_mode #or just check the users logged in

		def topics
			# Magically make arrays from string Wooooo!

			if params["uid"]
				uid = params["uid"].split(",").map(&:to_i)
			else
				uid = ''
			end

			if params["tid"]
				tid = params["tid"].split(",").map(&:to_i)
			else
				tid = ''
			end

			if params["usn"] && !params["usn"].empty?
				username = "%" + params["usn"] + "%"
			else
				username = ''
			end

			## look up the topics
			includeUser = Topic.unscoped {
				Topic.select('DISTINCT id').where('user_id IN (?) AND deleted_at IS NULL', uid).map(&:id)
			}

			tquery =  includeUser + tid

			#test for a group
			if params["grp"] && !params["grp"].empty?
				group = "%@" + params["grp"] + "%"

				posts = Post.unscoped {
					Post.where(' topic_id IN (?) OR raw LIKE (?) OR raw LIKE (?) AND deleted_at IS NULL AND NOT hidden', tquery, username, group)
													.order(created_at: :desc)
													.limit(params["total"])
													.offset(params["start"])
				}
			else
			 posts = Post.unscoped {
				 Post.where('topic_id IN (?) OR raw LIKE (?) AND deleted_at IS NULL AND NOT hidden', tquery, username)
			 									.order(created_at: :desc)
			 									.limit(params["total"])
												.offset(params["start"])
			}
			end

			# that cleaned that up
			render_json_dump(serialize_data(posts, PostSerializer,
																						 add_raw: true
																						 #add_title: true
																						 ))
			#K shows over
		end
	end
end
