#Discourse plugin json-follow-list

The gift that Keeps on giving.

Takes a list of posts from the current user
orders with a list of posts from other users that the individual is "following".

- Uses a limit and offset to assist in use in a lazy load UI
- Renders all to JSON obj.

Note: this is not intended for a Discourse UI and is only being consumed by another UI.
as a result there is no templates included.

once installed access via myurl.com/followlist/list?uid=1,2&start=18&total=5&tid=4,3
where:
- uid = users id
- tib = topic id
- start = offset
- total = limit
