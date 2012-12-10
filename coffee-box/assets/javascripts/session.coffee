Session =
  hookLogin: ->
    # login form submit button
    $('#login-form').submit ->
      $(this)
        .find('input[type=submit]')
        .attr
          disabled: true
          value: 'Redirecting'

$(document).ready ->
  Session.hookLogin()
