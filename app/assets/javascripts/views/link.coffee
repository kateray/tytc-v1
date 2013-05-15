window.LinkView = Backbone.View.extend
  events:
    'click .link_comments'  : 'showLink'
  
  # "click .vote_button" : "voteUp"
  initialize: ->
    # _.bindAll this
    that = this
    @$(".vote_button").bind "click", @model.voteUp
    # @$(".link_comments").bind "click", (event) ->
    #   console.log 'hrm'
    #   if $("#linkList").data("page") is "links"
    #     event.preventDefault()
    #     History.pushState {'id': that.model.get("id")}, null, "/links/" + that.model.get("id")
    #     state = History.getState()
    #     console.log state

    @model.bind "change", @render
    @model.bind "destroy", @remove

  render: ->
    $(@el).html $("#linkTemplate").tmpl(@model.toJSON())
    if @model.get("has_voted") is "true"
      @$(".vote_button").css "opacity", "0"
    else
      @$(".vote_button").css "border-bottom-color", "#e5432f"
    this

  remove: ->
    $(@el).remove()

  showLink: (e) ->
    e.preventDefault()
    App.router.navigate "links/" + @model.get('id'), {trigger: true}