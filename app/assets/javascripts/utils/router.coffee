window.Router = Backbone.Router.extend
  routes:
    'links/:id':  'showLink'

  showLink: ->
    console.log 'yayyyy'