# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend validate_popover: (options) ->
  settings = $.extend true, {}, $.validator.popover_defaults, options
  $.validator.get_offset_element = settings.get_offset_element if settings.get_offset_element
  this.validate(settings)

$.extend $.validator,
  popover_defaults:
    onsubmit: true
    popoverPosition: 'right'
    popoverContainer: 'body'
    hideForInvisible: true
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
  
  get_offset_element: (element)-> $(element)  

  reset_position: (popover, element)->
    offset = $.validator.get_offset_element(element).offset()
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

  get_position: (element) -> $(element).data('popover-position') || $.validator.validator_settings(element).popoverPosition

  get_container: (element) -> $(element).data('popover-container') || $.validator.validator_settings(element).popoverContainer

  reposition: (elements)->
    if elements?
      reposition_elements = elements
    else
      reposition_elements = $.validator.popover_elements_cached

    for element in reposition_elements
      ele = $(element)
      popover = ele.data('validate-popover')
      if popover? and popover.is(":visible")
        if $.validator.hide_popover_for_invisible(element) and !ele.is(":visible")
          popover.hide()
        else
          $.validator.reset_position popover, element

  get_validate_popover: (element)->
    v_popover = $(element).data('validate-popover')
    unless v_popover?
      $container = $($.validator.get_container(element))
      v_popover = $("<div class='popover #{$.validator.get_position(element)} error-popover' id='validate-popover'><div class='arrow'></div><div class='popover-content'></div></div>").appendTo($container)
      v_popover.click -> $(this).hide()
      $(element).data('validate-popover', v_popover)
      $.validator.popover_elements_cached.push element
    v_popover.hide()

  hide_popover_for_invisible: (element)->
    element_setting = $(element).data('popover-hide-for-invisible')
    if element_setting?
      element_setting
    else
      $.validator.validator_settings(element).hideForInvisible

  validator_settings: (element)-> $.data($(element)[0].form, "validator").settings

