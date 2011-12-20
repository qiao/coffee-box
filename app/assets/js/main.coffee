# highlight codes
highlightCodes = ($container)->
  $container.find('pre code').each (i, e) ->
    hljs.highlightBlock e, '    '


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

  highlightCodes $('.entry')

  # elastic and tabby textarea
  $('textarea')
    .elastic()
    .tabby()

  # show comment delete links only on comment hover
  $('.comment-delete-link').css opacity: 0
  $('.comment')
    .mouseover ->
      $(this).find('.comment-delete-link').css opacity: 1
    .mouseout ->
      $(this).find('.comment-delete-link').css opacity: 0

  # submit comments via ajax
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
                   highlightCodes($data)
                   $form
                     .siblings()
                     .filter('.comments-list')
                     .append($data)
                   $data.slideDown()
      complete : ->
                   # restore button status
                   $button.attr
                     disabled : false
                     value    : 'Submit'
    # prevent default, stop propogate
    false

  # delete comments via ajax
  $('.comment').each ->
    $comment = $(this)
    $comment.find('.comment-delete-form').submit ->
      $form = $(this)
      $.ajax
        type      : 'post'
        url       : $form.attr('action')
        data      : $form.serializeArray()
        success   : -> $comment.slideUp()
      false

  # preview
  $('.form-toolbar').each ->
    $toolbar  = $(this)
    $edit     = $toolbar.find('.toolbar-edit')
    $preview  = $toolbar.find('.toolbar-preview')
    $textarea = $toolbar.next().find('textarea')
    
    $preview.click ->
      return false if $textarea.next().hasClass('preview')
      $edit.parent().removeClass('active')
      $preview.parent().addClass('active')
      $.ajax
        type      : 'post'
        url       : '/comments/preview'
        data      : { raw_content: $textarea.val() }
        success   : (data) ->
                      $previewDiv = $('<div>')
                        .html(data)
                        .addClass('preview')
                        .css
                          width  : $textarea.width()
                          height : $textarea.height()
                      $textarea
                        .hide()
                        .after($previewDiv)
                      highlightCodes($previewDiv)
      false

    $edit.click ->
      return false unless $textarea.next().hasClass('preview')
      $textarea
        .show()
        .next()
        .remove()
      $edit
        .parent()
        .addClass('active')
        .next()
        .removeClass('active')
      false
