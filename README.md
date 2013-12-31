# jquery.validate.bootstrap.popover

Show error message via bootstrap popover for jquery validate.

Instead of calling **$('#form_id').validate()**, call this:

    $(function() {
    	$('#form_id').validate_popover();
    });


Check live demo [here](http://mingliangfeng.me/github%20project/2013/08/08/jquery-validate-bootstrap-popover-demo/) and [here](http://mingliangfeng.me/github%20project/2013/09/28/jquery-validate-bootstrap-popover-modal/).

## Dependency
* [jquery](https://github.com/jquery/jquery)
* [jquery.validate](https://github.com/jzaefferer/jquery-validation)
* [bootstrap](https://github.com/twbs/bootstrap)

## Options

The plugin accepts options as a single object argument. Pass in the options like this:
```
$('#form_id').validate_popover({ popoverPosition: 'top' });
```

Supported options are:

* **popoverPosition** Supported values: 'right', 'top'; default to 'right'
* **popoverContainer** The container popover message will append to, default: 'body'
* **beforeShowError** A function will be called before the error popover shows, **this** of the function is the input html element validated: 

		$('#form_id').validate_popover({ beforeShowError: function(message) { 
		    alert(this.name + ": " + message); 
		  }
		});


### HTML data attribute options
* **data-popover-position** Supported values: 'right', 'top', this will override the global setting passed to **validate_popover** calling.

		data-popover-position = "top"


* **data-popover-offset** Adjust the offset of the popover message, format is "top,left", like the following example will decrease the top by 10, and increase the left by 100: 

		data-popover-offset = "-10,100"


## Public Methods

Public methods could be called:

    $.validator.reposition(); // re-position all popovers


Public methods list:

* **hide_validate_popover** Hide the popover for a validated element: 

		$.validator.hide_validate_popover($("#client_email"));


* **show_error** Display error message programatically for an element: 

		$.validator.show_error("You need to choose a template from the list.", $("#template"));


* **reposition** Re-position all popovers when no argument is given; otherwise, only re-position popovers for given validated elements. Useful to put into window resize handler. e.g. 

		$.validator.reposition($("#client_email, #client_password"));


## License

jquery.validate.bootstrap.popover is licensed under the MIT license.
