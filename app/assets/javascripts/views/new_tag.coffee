window.NewTagView = Backbone.View.extend
  tagName: 'span'

  className: 'new-tag'

  template: _.template('<%= name %><span class="close-new-tag" data-id=<%= tag_id %>>x</span>')

  initialize: (data) ->
    @name = data.value
    @tag_id = data.id

  render: ->
    @$el.html(@template({name: @name, tag_id: @tag_id}))
    return this
