window.CommentView = Backbone.View.extend
  initialize: ->
    _.bindAll this
    @model.bind "change", @render
    @model.bind "destroy", @remove

  render: ->
    $(@el).html $("#commentTemplate").tmpl(@model.toJSON())
    this

  remove: ->
    $(@el).remove()