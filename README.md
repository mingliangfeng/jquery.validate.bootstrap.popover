# jquery.validate.bootstrap.popover

Show error message via bootstrap popover for jquery validate.

Instead of calling **$('#form_id').validate()**, call this:

    $(function() {
    	$('#form_id').validate_popover();
    });


Check live demo [here](http://mingliangfeng.me/github%20project/2013/08/08/jquery-validate-bootstrap-popover-demo/).


## Public Methods

Public methods could be called:

    $.validator.reposition(); // re-position all popovers


Public methods list:

* **hide_validate_popover** Hide the popover for a validated element: $.validator.hide_validate_popover($("#client_email"));

* **show_error** Display error message programatically for an element: $.validator.show_error("You need to choose a template from the list.", $("#template"));

* **reposition** Re-position all popovers when no argument is given; otherwise, only re-position popovers for given validated elements. Useful to put into window resize handler. e.g. $.validator.reposition($("#client_email, #client_password"));
