window.LinkList = Backbone.Collection.extend
  model: Link
  url: "/links"
  initialize: ->
    @addTags = new Array()
    @queryParams = new Array()

  query: ->
    params = {}
    params["tags"] = @queryParams
    @fetch data: params, reset: true