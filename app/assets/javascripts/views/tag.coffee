window.TagView = Backbone.View.extend
  events:
    
    # "click" : "toggle",
    "change .contributing_tick": "addTag"

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

  toggle: ->
    if App.contributing == false
      if @$(".tag_option").hasClass("selected")
        Links.queryParams.splice Links.queryParams.indexOf(@model.get("id")), 1
        Links.query()
        @$(".tag_option").removeClass "selected"
      else
        Links.queryParams.push @model.get("id")
        Links.query()
        @$(".tag_option").addClass "selected"