window.LinkShowView = Backbone.View.extend
  initialize: ->
    _.bindAll this
    @$(".vote_button").bind "click", @model.voteUp
    @model.bind "change", @render

  render: ->
    App.contributingOff()
    $(@el).html $("#linkShowTemplate").tmpl(@model.toJSON())
    if @model.get("has_voted") is "true"
      @$(".vote_button").css "opacity", "0"
    else
      @$(".vote_button").css "border-bottom-color", "#e5432f"
    new CommentListView(
      el: @$("#commentListView")
      link_id: @model.get("id")
    )
    this