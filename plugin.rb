# name: json-follow-list
# about: gathering followed topics for a single feed
# version: 0.0.1
# authors: abyrne

enabled_site_setting :following_list_enabled
# load the engine
load File.expand_path('../lib/json_follow_list/engine.rb', __FILE__)

after_initialize do
  require_dependency 'topic'
  require_dependency 'post'

  Discourse::Application.routes.append do
    mount ::JsonFollowList::Engine, at: "/followlist"
  end
end
