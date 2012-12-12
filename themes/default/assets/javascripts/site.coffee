$(document).ready ->
  # confirm operations
  $('input[data-confirm],a[data-confirm]').live 'click', (e) ->
    confirm('Are you sure?')

  # open external links in new tabs
  $('a').attr 'target', ->
    if @host is location.host then '_self' else '_blank'

  # navigate back on clicking cancel button
  $('.btn.cancel').click ->
    window.history.back()

  # elastic and tabby textarea
  $('textarea')
    .elastic()
    .tabby()


  # tabs
  $('.tabs').tabs()

  # search
  $('#search').submit ->
    keyword = $('input', @).val()
    console.log(keyword)
    hostname = window.location.hostname
    url = "http://www.google.com/search?q=site:#{hostname}%20#{keyword}"
    window.open url, '_blank'
    false
