Preview =
  hookPreview: ->
    $('.form-toolbar').each ->
      $toolbar  = $(@)
      $edit     = $toolbar.find('.toolbar-edit')
      $preview  = $toolbar.find('.toolbar-preview')
      $textarea = $toolbar.next().find('textarea')

      # determine which url to send
      url = if $('.comment-form').length then '/comments/preview' else '/posts/preview'
      
      $preview.click ->
        return false if $preview.parent().hasClass('active')
        $edit.parent().removeClass('active')
        $preview.parent().addClass('active')
        $.ajax
          type      : 'post'
          url       : url
          data      : { rawContent: $textarea.val() }
          success   : (data) ->
                        $previewDiv = $('<div>')
                          .html(data)
                          .addClass('preview')
                        $textarea
                          .hide()
                          .after($previewDiv)
        false

      $edit.click ->
        return false if $edit.parent().hasClass('active')
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

$(document).ready ->
  Preview.hookPreview()
