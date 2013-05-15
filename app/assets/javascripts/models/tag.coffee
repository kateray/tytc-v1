class window.Tag extends Backbone.Model
  validate: (attrs) ->
    errors = []
    if not attrs.name or attrs.name.length > 25
      $(".left_container[data-group=\"" + attrs.group + "\"]").find(".tag_error").text("Tag is too long").show().delay(1400).fadeOut "slow", ->
        $(this).text ""

      errors.push "Tag is too long"
    if Tags.where(name: attrs.name).length > 0 and Tags.where(name: attrs.name)[0].cid isnt @cid
      $(".left_container[data-group=\"" + attrs.group + "\"]").find(".tag_error").text("Tag already exists!").show().delay(1400).fadeOut "slow", ->
        $(this).text ""

      errors.push "Tag exists"
    (if _.any(errors) then errors else null)