window.Router = Backbone.Router.extend
  routes:
    '':          'showIndex'
    'links/:id':  'showLink'

  showIndex: ->
    console.log 'okayyy'
    LinksView.showIndex()

  showLink: (id) ->
    Links.get(id).showLinkView()