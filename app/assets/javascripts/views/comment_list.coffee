window.CommentListView = Backbone.View.extend
  initialize: (options) ->
    _.bindAll this
    Comments.bind "create"
    Comments.bind "add", @addOne
    Comments.bind "reset", @addAll
    App.view.bind "contributingOn", @contributingOn
    App.view.bind "contributingOff", @contributingOff
    @input = @$("#new_comment")
    @link_id = options.link_id
    Comments.fetch data:
      link_id: @link_id

    @contributingOff()
    @$("textarea[id=\"comment_content\"]").addDefaultText "Write a comment"
    @$("form[id=\"new_comment\"]").submit @create

  addOne: (comment) ->
    view = new CommentView(model: comment)
    @$("#commentList").prepend view.render().el

  addAll: ->
    Comments.each @addOne

  create: (event) ->
    event.preventDefault()
    formData = $("form[id=\"new_comment\"]").serializeForm()
    Comments.create formData
    $("form[id=\"new_comment\"]").resetForm()
    false

  contributingOn: ->
    @$("textarea, input, button").attr "disabled", "disabled"

  contributingOff: ->
    @$("textarea, input, button").removeAttr "disabled"