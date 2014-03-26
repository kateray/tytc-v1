window.TagView = Backbone.View.extend
  className: 'tag-option'

  events:

    # "click" : "select",
    "change .contributing_tick": "addTag"
    # "click .close-tag" : "unselect"

  initialize: ->
    _.bindAll this
    $(@el).bind "click", @toggle
    @model.bind "change", @render

  render: ->
    $(@el).html $("#tagTemplate").tmpl(@model.toJSON())
    @$(".contributing_tick").show()  if App.contributing is true
    this

  addTag: ->
    if App.contributing is true
      if @$(".contributing_tick").is(":checked")
        $("#new_link_tags").append "<div class = \"link_tag\" data-id=" + @model.get("id") + ">" + @$(".tag_option").html() + "</div>"
        Links.addTags.push @model.get("id")
      else
        $("#new_link_tags").find(".link_tag[data-id=\"" + @model.get("id") + "\"]").remove()
        Links.addTags.splice Links.addTags.indexOf(@model.get("id")), 1

  select: ->
    return if @$el.hasClass "selected"
    Links.queryParams.push @model.get("id")
    Links.query()
    @$el.addClass "selected"
    @$el.find('.close-tag').show()

  unselect: ->
    console.log 'hello'
    Links.queryParams.splice Links.queryParams.indexOf(@model.get("id")), 1
    Links.query()
    @$el.removeClass "selected"
    @$el.find('.close-tag').hide()

  toggle: ->
    if App.contributing == false && !$('#linkList').is(":hidden")
      if @$el.hasClass("selected")
        Links.queryParams.splice Links.queryParams.indexOf(@model.get("id")), 1
        Links.query()
        @$el.removeClass "selected"
        @$el.find('.close-tag').hide()
      else
        Links.queryParams.push @model.get("id")
        Links.query()
        @$el.addClass "selected"
        @$el.find('.close-tag').show()
