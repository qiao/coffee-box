Comments =
  hide: ->
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
    @

  hideDeleteLink: ->
    # show comment delete links only on comment hover
    $('.comment-delete-link').css opacity: 0
    $('.comment')
      .mouseover ->
        $(this).find('.comment-delete-link').css opacity: 1
      .mouseout ->
        $(this).find('.comment-delete-link').css opacity: 0
    @

  hookSubmit: ->
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
                     $form
                       .siblings()
                       .filter('.comments-list')
                       .append($data)
                     $data.slideDown()
                     $form.find('textarea').val('')
        complete : ->
                     # restore button status
                     $button.attr
                       disabled : false
                       value    : 'Submit'
      # prevent default, stop propogate
      false
    @

  hookDelete: ->
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
    @


$(document).ready ->
  # hide comments in index page
  if window.location.pathname is '/'
    Comments.hide()


  Comments
    .hookSubmit()
    .hookDelete()
