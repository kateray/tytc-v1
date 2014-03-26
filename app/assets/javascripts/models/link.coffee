window.Link = Backbone.Model.extend
  defaults:
    votes_count: 0
    comments_count: 0

  validate: (attrs) ->
    errors = []
    # if not attrs.title or attrs.title.length < 3
    #   $("input[id=\"link_title\"]").addDefaultText("Please enter a title").addClass "invalid"
    #   errors.push "Title can't be blank"
    # if not attrs.url or validateURL(attrs.url) is false
    #   $("input[id=\"link_url\"]").addDefaultText("Please enter a valid url").addClass "invalid"
    #   errors.push "Bad url"
    errors.push "missing tags"  if _.isEmpty(attrs.taggings)
    (if _.any(errors) then errors else null)

  voteUp: ->
    if @get("has_voted") is "false"
      Votes.create link_id: @get("id")
      @set
        votes_count: @get("votes_count") + 1
        has_voted: "true"

  showLinkView: ->
    view = new LinkShowView(model: this)
    $("#linkShow").append view.render().el
    $("#linkShow_container, #show_index").show()
    $("#linkList").hide()
