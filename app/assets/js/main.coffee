$ ->
  # hide comments in index page
  if window.location.pathname is '/'
    $('.comments').hide()
    # toggle comments
    $('.comments-info').toggle (->
      $(this)
        .data('original-text', $(this).text())
        .hide()
        .text('hide comments')
        .fadeIn()
        .next()
        .slideDown()
      false), (->
      $(this)
        .hide()
        .text($(this).data('original-text'))
        .fadeIn()
        .next()
        .slideUp()
      false)

  # confirm operations
  $('input[data-confirm],a[data-confirm]').live 'click', (e) ->
    confirm('Are you sure?')

  # open external links in new tabs
  $('a').attr 'target', ->
    if @host is location.host then '_self' else '_blank'

  # navigate back on clicking cancel button
  $('.btn.cancel').click ->
    window.history.back()

  # highlight codes
  $('pre code').each (i, e) ->
    hljs.highlightBlock e, '    '

  # submit comments form via ajax
  $('.comment-form').submit (evt) ->
    # find form
    $form = $(this)
    # disable submit button
    $button = $form.find('input[type=submit]')
    $button.attr
      disabled : true
      value    : 'Submitting'
    # send form
    $.ajax
      type     : 'post'
      url      : $form.attr('action')
      data     : $form.serializeArray()
      success  : (data) ->
                   $data = $(data).hide()
                   $form.prev('.comments-list').append $data
                   $data.slideDown()
      complete : ->
                   # restore button status
                   $button.attr
                     disabled : false
                     value    : 'Submit'
    # prevent default, stop propogate
    false

  # elastic and tabby textarea
  $('textarea')
    .elastic()
    .tabby()
