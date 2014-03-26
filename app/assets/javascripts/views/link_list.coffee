window.LinkListView = Backbone.View.extend
  el: '#main-column'

  events: ->
    'submit form[id="new_link"]' : 'createLink'
    'click .level-button' : 'chooseLevel'
    'focus input[id="link_url"]' : 'defaultURL'
    'blur input[id="link_url"]' : 'removeDefaultURL'


  initialize: ->
    _.bindAll this
    Links.bind "add", @addOne
    Links.bind "reset", @addAll

    $('form[id="new_link"]').find('input').focus ->
      $('#contributing-mode').collapse('show')
      $('#close-new-link').show()

    $('#close-new-link').click ->
      $('#contributing-mode').collapse('hide')
      $('#close-new-link').hide()


    $(document).ajaxComplete (event, XMLHttpRequest, ajaxOptions, errorThrown) ->
      unless XMLHttpRequest.status is 200
        showError XMLHttpRequest.responseText
        $("form[id=\"new_link\"]").resetForm()

    $("#show_index").click (e) ->
      e.preventDefault()
      App.router.navigate "/", {trigger: true}

    $("#language-autocomplete").bind "railsAutocomplete.select", @addLanguageTag
    $("#category-autocomplete").bind "railsAutocomplete.select", @addCategoryTag

    @level = 0
    @languageTags = []
    @categoryTags = []


  defaultURL: ->
    if $('input[id="link_url"]').val() == ""
      $('input[id="link_url"]').val("http://")

  removeDefaultURL: ->
    if $('input[id="link_url"]').val() == "http://"
      $('input[id="link_url"]').val('')

  addLanguageTag: (event, data)->
    if _.contains(@languageTags, parseInt(data.item.id))
      return
    @languageTags.push(parseInt(data.item.id))
    newTag = new NewTagView(data.item)
    $('#new-language-tags').append newTag.render().el
    $("#language-autocomplete").val('')

  addCategoryTag: (event, data)->
    if _.contains(@categoryTags, parseInt(data.item.id))
      return
    @categoryTags.push(parseInt(data.item.id))
    newTag = new NewTagView(data.item)
    $('#new-category-tags').append newTag.render().el
    $("#category-autocomplete").val('')

  chooseLevel: (e) ->
    @level = $(e.currentTarget).data('tag-id')

  createLink: (e) ->
    e.preventDefault()

    errors = []

    if ($('input[id="link_title"]').val() == "")
      errors.push('Title')
      $('input[id="link_title"]').addClass('input-error')

    if ($('input[id="link_url"]').val() == "")
      errors.push('Url')
      $('input[id="link_url"]').addClass('input-error')

    if ($('textarea[id="link_description"]').val() == "")
      errors.push('Description')
      $('textarea[id="link_description"]').addClass('input-error')

    if (@level == 0)
      errors.push('Level')
      $('.level-button').addClass('input-error')

    if (@languageTags.length == 0)
      errors.push('Language')
      $('#language-autocomplete').addClass('input-error')

    if (@categoryTags.length == 0)
      errors.push('Category')
      $('#category-autocomplete').addClass('input-error')

    if errors.length == 0
      sendData = {}
      sendData['title'] = $('input[id="link_title"]').val()
      sendData['url'] = $('input[id="link_url"]').val()
      sendData['description'] = $('textarea[id="link_description"]').val()

      tag_ids = @languageTags.concat(@categoryTags)
      tag_ids.push @level
      taggings = _.map _.uniq(tag_ids), (id) ->
        {tag_id: id}
      sendData['taggings_attributes'] = taggings

      newLink = Links.create(sendData,
        wait: true
      )
      if newLink
        console.log newLink
        $('form[id="new_link"]').resetForm()
        @level = 0
        @languageTags = []
        @categoryTags = []

      # $.ajax
      #   type: "POST"
      #   url: "/links"
      #   data: {'link' : sendData}
      #   success: (data) =>
      #     console.log data
      #     $('form[id="new_link"]').resetForm()
      #     @level = 0
      #     @languageTags = []
      #     @categoryTags = []
      #   error: =>
      #     console.log 'whoa'

    else
      $('.form-errors').text('Please add: ' + errors.join(', '))





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
    $('#links_container').append view.render().el

  addAll: ->
    Links.each @addOne
