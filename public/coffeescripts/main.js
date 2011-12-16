
  $(function() {
    $('pre code').each(function(i, e) {
      return hljs.highlightBlock(e, '    ');
    });
    if (window.location.pathname === '/') {
      $('.comments').hide();
      return $('.comments-info').toggle((function() {
        $(this).data('original-text', $(this.text())).hide().text('hide comments').fadeIn().next().slideDown();
        return false;
      }), (function() {
        $(this).hide().text($(this).data('original-text')).fadeIn().next().slideUp();
        return false;
      }));
    }
  });
