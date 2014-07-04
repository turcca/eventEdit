$(document).ready(initializeprobability);

function initializeprobability() {
	var $probabilityformdiv = $('#event_probability_form');
	$probabilityformdiv.find('.probability_dropdown, .probability_text_field').each(function() {
	   var $field = $(this);
	   if ($field.val() == '')
	   {
	       $field.css('background-color', '#FFCCCC');
	   }
	});
	
	$('#probability_collapse_button').click(toggleprobabilitycollapse);
	$('#probability_button').click(createnewprobability);
	
	$probabilityformdiv.on('click', '.remove_probability', removeprobabilityrow);
	$probabilityformdiv.on('change', '.probability_dropdown', probabilitydropdownhandler);
	$probabilityformdiv.on('change', '.probability_condition', probabilityconditionhandler);
	$probabilityformdiv.on('blur', '.probability_text_field', probabilitytextfieldhandler);
	$probabilityformdiv.on('change', '.probability_andor', probabilityandorhandler);
};

var probabilitydropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

var probabilityconditionhandler = function() {
    $(this.form).trigger('submit.rails');
};

var probabilityandorhandler = function() {
    $(this.form).trigger('submit.rails');
};

var probabilitytextfieldhandler = function() {
    var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var toggleprobabilitycollapse = function() {
	var $toggleimg = $(this);
	$('#event_probability_form').slideToggle(200);
	if ($toggleimg.attr('src') === '/assets/button_expanded.png')
	{
		$toggleimg.attr('src', '/assets/button_collapsed.png');
	}
	else
	{
		$toggleimg.attr('src', '/assets/button_expanded.png');
	}
};

var createnewprobability = function() {
	$(this).parents("form").trigger('submit.rails');
};

var removeprobabilityrow = function() {
	var $row = $(this).parents(".row");
	$row.fadeOut(200, function() { 
		if ($row.hasClass('row_first'))
		{
			$row.next().addClass('row_first');
		}
		$row.remove(); 
	});
};