/**
*	@name							Elastic
*	@descripton						Elastic is jQuery plugin that grow and shrink your textareas automatically
*	@version						1.6.11
*	@requires						jQuery 1.2.6+
*
*	@author							Jan Jarfalk
*	@author-email					jan.jarfalk@unwrongest.com
*	@author-website					http://www.unwrongest.com
*
*	@licence						MIT License - http://www.opensource.org/licenses/mit-license.php
*/(function(a){jQuery.fn.extend({elastic:function(){var b=["paddingTop","paddingRight","paddingBottom","paddingLeft","fontSize","lineHeight","fontFamily","width","fontWeight","border-top-width","border-right-width","border-bottom-width","border-left-width","borderTopStyle","borderTopColor","borderRightStyle","borderRightColor","borderBottomStyle","borderBottomColor","borderLeftStyle","borderLeftColor"];return this.each(function(){function j(){var a=Math.floor(parseInt(c.width(),10));d.width()!==a&&(d.css({width:a+"px"}),l(!0))}function k(a,b){var d=Math.floor(parseInt(a,10));c.height()!==d&&c.css({height:d+"px",overflow:b})}function l(a){var b=c.val().replace(/&/g,"&amp;").replace(/ {2}/g,"&nbsp;").replace(/<|>/g,"&gt;").replace(/\n/g,"<br />"),h=d.html().replace(/<br>/ig,"<br />");if(a||b+"&nbsp;"!==h){d.html(b+"&nbsp;");if(Math.abs(d.height()+e-c.height())>3){var i=d.height()+e;i>=g?k(g,"auto"):i<=f?k(f,"hidden"):k(i,"hidden")}}}if(this.type!=="textarea")return!1;var c=jQuery(this),d=jQuery("<div />").css({position:"absolute",display:"none","word-wrap":"break-word","white-space":"pre-wrap"}),e=parseInt(c.css("line-height"),10)||parseInt(c.css("font-size"),"10"),f=parseInt(c.css("height"),10)||e*3,g=parseInt(c.css("max-height"),10)||Number.MAX_VALUE,h=0;g<0&&(g=Number.MAX_VALUE),d.appendTo(c.parent());var i=b.length;while(i--)d.css(b[i].toString(),c.css(b[i].toString()));c.css({overflow:"hidden"}),c.bind("keyup change cut paste",function(){l()}),a(window).bind("resize",j),c.bind("resize",j),c.bind("update",l),c.bind("blur",function(){d.height()<g&&(d.height()>f?c.height(d.height()):c.height(f))}),c.bind("input paste",function(a){setTimeout(l,250)}),l()})}})})(jQuery);