jQuery ($) ->
  $("#flash_error, #flash_alert, #flash_notice").each ->
    $(this).delay 2000
    $(this).slideUp "fast"

  window.App = {}
  window.App.contributing = false
  window.App.view = new AppView(el: $('body'))
  window.App.router = new Router()

  window.Votes = new VoteList

  window.Links = new LinkList
  window.LinksView = new LinkListView({el : '#linkList'})

  window.Tags = new TagList
  window.Taggings = new TaggingList;
  new TagListView()

  window.Comments = new CommentList()

	$("#user_form").find("input").addDefaultText()
	$("#editable_description").addDefaultText "Write something about yourself"  if $.trim($("#editable_description").text()).length is 0
	$("#update_user").click ->
	  sendData = {}
	  $("#editable_description").val ""  if $("#editable_description").text() is $("#editable_description").data("default")
	  sendData["description"] = $("#editable_description").text()
	  $.post "/save",
	    user: sendData
	  , ->
	    showError "Changes Saved"


  Backbone.history.start({pushState: true})