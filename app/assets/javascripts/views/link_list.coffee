window.LinkListView = Backbone.View.extend
  initialize: ->
    _.bindAll this
    Links.bind "add", @addOne
    Links.bind "reset", @addAll
    App.view.bind "contributingOn", @contributingOn
    App.view.bind "contributingOff", @contributingOff
    @contributingOff()
    $("form[id=\"new_link\"]").find("input, textarea").addDefaultText()
    $("form[id=\"new_link\"]").submit @createLink
    $(document).ajaxComplete (event, XMLHttpRequest, ajaxOptions, errorThrown) ->
      unless XMLHttpRequest.status is 200
        showError XMLHttpRequest.responseText
        $("form[id=\"new_link\"]").resetForm()

    $("#show_index").click (e) ->
      e.preventDefault()
      App.router.navigate "/", {trigger: true}

  createLink: (event) ->
    event.preventDefault()
    formData = $("form[id=\"new_link\"]").serializeForm()
    formData["url"] = "http://" + formData["url"]  unless formData["url"].match(/^https?:\/\//)
    $(".invalid").removeClass "invalid"
    
    #TKTK should be a validation
    left = $(".left_container").filter((index) ->
      $(this).find(".contributing_tick:checked").length is 0
    )
    if left.length
      left.addClass "invalid"
      taggings = []
    else
      taggings = Links.addTags
    formData["taggings"] = taggings
    newLink = Links.create(formData,
      wait: true
    )
    if newLink
      App.view.contributingOff()
      $("form[id=\"new_link\"]").resetForm()
    false

  showIndex: ->
    #tktk this is a bad way of finding whether to query
    Links.query()  if $("#linkList").find(".link_container").length < 2 and $("#user_container").length is 0
    if first is true
      first = false
      $("#linkShow_container").hide()
      $("#linkList").show()
      $("#linkShow").html ""
    else
      $("#linkList").show "slide",
        direction: "left"

      $("#linkShow_container").hide "slide",
        direction: "right"
      , 400, ->
        $("#linkShow").html ""

  addOne: (link) ->
    view = new LinkView({model: link})
    $(@el).append view.render().el
    App.view.contributingOff()  if App.contributing

  addAll: ->
    $(@el).html ""
    Links.each @addOne

  contributingOn: ->
    $("form[id=\"new_link\"]").find("button").removeAttr "disabled"
    $(".contributing_tick").attr("checked", false).show()
    Links.addTags = []
    $("#new_link_tags").html ""

  contributingOff: ->
    $("form[id=\"new_link\"]").find("button").attr "disabled", "disabled"