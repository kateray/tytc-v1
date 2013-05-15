window.Comment = Backbone.Model.extend
  validate: (attrs) ->
    errors = []
    if not attrs.content or attrs.content.length is 0
      $("textarea[id=\"comment_content\"]").addDefaultText("Please enter a valid comment").addClass "invalid"
      errors.push "Comment can't be blank"
    (if _.any(errors) then errors else null)