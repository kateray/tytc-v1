window.TagListView = Backbone.View.extend
  el: $('body')

  events:
    "click #expand-language-tags" : "showAllLanguages"
    "click #expand-category-tags" : "showAllCategories"

  initialize: ->
    _.bindAll this
    Tags.bind "add", @addOne
    Tags.bind "reset", @addAll
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

  showAllLanguages: ->
    $('.left_container[data-group="Language"]').find('.tag-option').css('display', 'block')
    $('#expand-language-tags').hide()

  showAllCategories: ->
    $('.left_container[data-group="Category"]').find('.tag-option').css('display', 'block')
    $('#expand-category-tags').hide()
