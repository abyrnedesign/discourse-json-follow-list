JsonFollowList::Engine.routes.draw do
	get '/list' => 'following#topics'
end
