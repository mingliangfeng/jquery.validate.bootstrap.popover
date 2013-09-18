# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend validate_popover: (options) ->
  settings = $.extend true, {}, $.validator.popover_defaults, options
  this.validate(settings)

$.extend $.validator, 
  popover_defaults:
    onsubmit: true
    popoverPosition: 'right'
    success: (error, element)-> $.validator.hide_validate_popover(element)
    errorPlacement: (error, element)-> 
      message = error.html()
      this.beforeShowError.call(element.get(0), message);
      $.validator.show_error(message, element)
    beforeShowError: (message)->
  
  popover_elements_cached: []

  hide_validate_popover: (element)->
    if element.length > 1
      for ele in element
        $.validator.get_validate_popover(ele)
    else
      $.validator.get_validate_popover(element)

  show_error: (message, element)->
    $v_popover = $.validator.get_validate_popover(element)
    $('.popover-content', $v_popover).html(message)
    $.validator.reset_position $v_popover, element
    $v_popover.show() if message? and message != ''
  
  reset_position: (popover, element)->
    offset = $(element).offset()
    offset_adjust = $(element).data('popover-offset') || "0,0"
    [top_adjust, left_adjust] = offset_adjust.split(',')

    position = $.validator.get_position(element)
    if position == 'top'
      top = offset.top - 11 - 26 + parseInt(top_adjust)
      left = offset.left + parseInt(left_adjust)
    else
      top = offset.top - 3 + parseInt(top_adjust)
      left = offset.left + $(element).width() + 20 + parseInt(left_adjust)
    popover.css({top: top, left: left})

  get_position: (element) -> $(element).data('popover-position') || $.data($(element)[0].form, "validator").settings.popoverPosition

  reposition: (elements)->
    if elements?
      reposition_elements = elements
    else
      reposition_elements = $.validator.popover_elements_cached

    for element in reposition_elements
      popover = $(element).data('validate-popover')
      if popover? and popover.is(":visible")
        $.validator.reset_position popover, element

  get_validate_popover: (element)->
    v_popover = $(element).data('validate-popover')
    unless v_popover?
      v_popover = $("<div class='popover #{$.validator.get_position(element)} error-popover' id='validate-popover'><div class='arrow'></div><div class='popover-content'></div></div>").appendTo($('body')) 
      v_popover.click -> $(this).hide()
      $(element).data('validate-popover', v_popover)
      $.validator.popover_elements_cached.push element
    v_popover.hide()

