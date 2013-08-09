# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend validate_popover: (options) ->
  settings = $.extend true, {}, $.validator.popover_defaults, options
  this.validate(settings)

$.extend $.validator, 
  popover_defaults:
    onsubmit: true
    success: (error, element)-> $.validator.hide_validate_popover(element)
    errorPlacement: (error, element)-> 
      message = error.html()
      this.beforeShowError.call(element.get(0), message);
      $.validator.show_error(message, element)
    beforeShowError: ->

  hide_validate_popover: (element)->
    if element.length > 1
      for ele in element
        $.validator.get_validate_popover(ele)
    else
      $.validator.get_validate_popover(element)

  show_error: (message, element)->
    $v_popover = $.validator.get_validate_popover(element)
    $('.popover-content', $v_popover).html(message)
    offset = $(element).offset()
    offset_adjust = $(element).data('popover-offset') || "0,0"
    [top_adjust, left_adjust] = offset_adjust.split(',')
    top = offset.top - 3 + parseInt(top_adjust)
    left = offset.left + $(element).width() + 20 + parseInt(left_adjust)
    $v_popover.css({top: top, left: left}).show()

  get_validate_popover: (element)->
    v_popover = $(element).data('validate-popover')
    unless v_popover?
      v_popover = $('<div class="popover right error-popover" id="validate-popover"><div class="arrow"></div><div class="popover-content"></div></div>').appendTo($('body')) 
      $(element).data('validate-popover', v_popover)
    v_popover.hide()

