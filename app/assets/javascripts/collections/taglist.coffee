window.TagList = Backbone.Collection.extend
  model: Tag
  url: "/tags"
  comparator: (tag) ->
    if tag.get("group") is "Level"
      time = new Date(tag.get("time") * 1000)
      time
    else
      -tag.get("links_count")