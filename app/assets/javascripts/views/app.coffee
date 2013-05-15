window.AppView = Backbone.View.extend
  events:
    "focus #new_link_form input": "contributingOn"

  initialize: ->
    _.bindAll this
    @contributingOff()

  contributingOn: ->
    App.contributing = true
    @trigger "contributingOn"
    $("#contributing_mode").slideDown "fast"
    $("#links_container").animate
      opacity: 0.4
    , 300
    $("#links_container").bind "click.contributingOff", @contributingOff

  contributingOff: ->
    App.contributing = false
    @trigger "contributingOff"
    $(".invalid").removeClass "invalid"
    $("#contributing_mode").slideUp "fast"
    $(".contributing_tick").attr("checked", null).hide()
    $("#links_container").animate
      opacity: 1
    , 300
    $("#links_container").unbind "click.contributingOff"
    $("#new_link_tags").html ""