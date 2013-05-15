window.TagListView = Backbone.View.extend
  initialize: ->
    _.bindAll this
    Tags.bind "add", @addOne
    Tags.bind "reset", @addAll
    $(".new_tag_field").addDefaultText()
    $(".new_tag_field").keydown (event) ->
      if event.keyCode is 13
        Tags.create
          name: $.trim($(this).text())
          group: $(this).closest(".left_container").data("group")

        $(this).text("").blur()


  addOne: (tag) ->
    view = new TagView(model: tag)
    $(".left_container[data-group=" + tag.get("group") + "]").find(".tag_list").append view.render().el

  addAll: ->
    Tags.each @addOne