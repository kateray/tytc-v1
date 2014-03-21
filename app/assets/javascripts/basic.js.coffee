$(document).ready ->
  $('.login_link').click (e) ->
    e.preventDefault()
    $('.sessions-modal').modal()
    $('.sessions-modal .modal-title').text('Sign In')
    $('.sessions-modal .login-container').show()
    $('.sessions-modal .signup-container').hide()

  $('.signup_link').click (e) ->
    e.preventDefault()
    $('.sessions-modal').modal()
    $('.sessions-modal .modal-title').text('Sign Up')
    $('.sessions-modal .login-container').hide()
    $('.sessions-modal .signup-container').show()
