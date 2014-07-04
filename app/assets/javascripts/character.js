$(document).ready(initializecharacter);

function initializecharacter() {
	var $chartools = $('.character_dropdown, .character_text_field');
	var $loctools = $('.location_dropdown, .location_text_field');
	var $triggertools = $('.trigger_dropdown, .trigger_text_field');
	var $prereqevent = $('#event_prereq_event');
	var $character_row = $('#event_character_row');
	var $location_row = $('#event_location_row');
	var $trigger_row = $('#event_trigger_row');
	var $prereq_row = $('#event_prereq_row');
	var $charimg = $("img#add_character_row");
	var $locimg = $("img#add_location_row");
	var $triggerimg = $("img#add_trigger_row");
	var $prereqimg = $("img#add_prereq_row");
	var $name = $("#event_field_name");
	var $frequency = $('#event_frequency');
	var $situation = $('#event_situation');
	var $ambient = $('#event_ambient');
	if ($name.val() === '')
	{
		$name.css( 'background-color', '#FFCCCC' );
	}
	if ($frequency.val() === '')
    {
        $frequency.css( 'background-color', '#FFCCCC' );
    }
    if ($situation.val() === '')
    {
        $situation.css( 'background-color', '#FFCCCC' );
    }
    if ($ambient.val() === '')
    {
        $ambient.css( 'background-color', '#FFCCCC' );
    }
	var showcharacterrowatstart = false;
	$chartools.each(function() {
        var $tool = $(this);
        if ($tool.val() === '')
        {
            $tool.css( 'background-color', '#FFCCCC' );
        }
        else
        {
            showcharacterrowatstart = true;
        }
	});
	if (showcharacterrowatstart)
	{
	    $character_row.show();
	    $charimg.css('opacity', 0).removeClass('cursor_button');
	}
	var showlocationrowatstart = false;
    $loctools.each(function() {
        var $tool = $(this);
        if ($tool.val() === '')
        {
            $tool.css( 'background-color', '#FFCCCC' );
        }
        else
        {
            showlocationrowatstart = true;
        }
    });
    if (showlocationrowatstart)
    {
        $location_row.show();
        $locimg.css('opacity', 0).removeClass('cursor_button');
    }
	var showtriggerrowatstart = false;
    $triggertools.each(function() {
        var $tool = $(this);
        if ($tool.val() === '')
        {
            $tool.css( 'background-color', '#FFCCCC' );
        }
        else
        {
            showtriggerrowatstart = true;
        }
    });
    if (showtriggerrowatstart)
    {
        $trigger_row.show();
        $triggerimg.css('opacity', 0).removeClass('cursor_button');
    }
    if ($prereqevent.val() != '')
    {
        $prereq_row.show();
        $prereqimg.css('opacity', 0).removeClass('cursor_button');
    }
	$('#edit_notices').css('opacity', 1)
					  .fadeTo(2000, 0);
	$character_row.on('change', '.character_dropdown', characterdropdownhandler);
	$character_row.on('blur', '.character_text_field', charactertextfieldhandler);
	$location_row.on('change', '.location_dropdown', locationdropdownhandler);
    $location_row.on('blur', '.location_text_field', locationtextfieldhandler);
	$prereq_row.on('change', '#event_prereq_event', prereqdropdownhandler);
	$prereq_row.on('change', '#event_prereq_outcome', prereqdropdownhandler);
	$charimg.click(showcharacterrow);
	$locimg.click(showlocationrow);
	$("#remove_character_row").click(removecharacterrow);
	$("#remove_location_row").click(removelocationrow);
	$triggerimg.click(showtriggerrow);
    $("#remove_trigger_row").click(removetriggerrow);
	$("img#add_prereq_row").click(showprereqrow);
	$("#remove_prereq_row").click(removeprereqrow);
	$("#event_field_name").blur(eventnamehandler);
	$("#event_field_comment").blur(eventcommenthandler);
	$("#event_field_comment").blur(minimizecommentfield);
	$("#event_field_comment").focus(enlargecommentfield);
	$frequency.change(frequencydropdownhandler);
	$situation.change(situationdropdownhandler);
	$ambient.change(ambientdropdownhandler);
	$("#filter_row").on('change', ".event_filter", filterdropdownhandler);
} ;

var characterdropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

var locationdropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

var prereqdropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

var charactertextfieldhandler = function() {
    var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var locationtextfieldhandler = function() {
    var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var showcharacterrow = function() {
	$(this).fadeTo(200, 0, function() { $('#event_character_row').fadeIn(200); } ).removeClass('cursor_button');
};

var removecharacterrow = function() {
	$('#event_character_row').fadeOut(200, function() {
	    $("img#add_character_row").fadeTo(200, 1).addClass('cursor_button');
	    var $tools = $(".character_dropdown, .character_text_field");
        $tools.each(function() {
            $(this).val('');
        });
        $(this).parents("form").trigger('submit.rails');
	});
};

var showlocationrow = function() {
    $(this).fadeTo(200, 0, function() { $('#event_location_row').fadeIn(200); } ).removeClass('cursor_button');
};

var removelocationrow = function() {
    $('#event_location_row').fadeOut(200, function() {
        $("img#add_location_row").fadeTo(200, 1).addClass('cursor_button');
        var $tools = $(".location_dropdown, .location_text_field");
        $tools.each(function() {
            $(this).val('');
        });
        $(this).parents("form").trigger('submit.rails');
    });
};

var showtriggerrow = function() {
    $(this).fadeTo(200, 0, function() { $('#event_trigger_row').fadeIn(200); } ).removeClass('cursor_button');
};

var removetriggerrow = function() {
    $('#event_trigger_row').fadeOut(200, function() {
        $("img#add_trigger_row").fadeTo(200, 1).addClass('cursor_button');
        var $tools = $(".trigger_dropdown, .trigger_text_field");
        $tools.each(function() {
            $(this).val('');
        });
        $(this).parents("form").trigger('submit.rails');
    });
};

var showprereqrow = function() {
    $(this).fadeTo(200, 0, function() { $('#event_prereq_row').fadeIn(200); } ).removeClass('cursor_button');
};

var removeprereqrow = function() {
    $('#event_prereq_row').fadeOut(200, function() {
        $("img#add_prereq_row").fadeTo(200, 1).addClass('cursor_button');
        var $tools = $("#event_prereq_event");
        $tools.each(function() {
            $(this).val('');
        });
        $(this).parents("form").trigger('submit.rails');
    });
};

var eventnamehandler = function()
{
	var $name = $(this);
	$name.val($.trim($name.val()));		// Trim the given value
	if ($name.val() === '')
	{
		$name.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		$name.css( 'background-color', '#FFFFFF' );
		if ($name.val() != $name.data('oldvalue'))	// If the new value isn't the same as the already saved value
		{
			$name.data('oldvalue', $name.val());	// Save the new value as old before sending the form
			$(this.form).trigger('submit.rails');
		}
	}
} ;

var eventcommenthandler = function() {
	var $comment = $(this);
	$comment.val($.trim($comment.val()));		// Trim the given value
	if ($comment.val() != $comment.data('oldvalue') && $("#event_field_name").val() != '')	// If there is a value and it's not the same as the already saved value
	{
		$comment.data('oldvalue', $comment.val());	// Save the new value as old before sending the form
		$(this.form).trigger('submit.rails');
	}
} ;

var enlargecommentfield = function() {
	var $comment = $(this);
	$comment.css('height', '80px');
};

var minimizecommentfield = function() {
	var $comment = $(this);
	$comment.css('height', '16px');
};

var frequencydropdownhandler = function() {
    var $frequency = $(this);
    if ($frequency.val() === '')
    {
        $frequency.css( 'background-color', '#FFCCCC' );
    }
    else
    {
        $frequency.css( 'background-color', '#FFFFFF' );
    }
    $(this.form).trigger('submit.rails');
};

var situationdropdownhandler = function() {
    var $situation = $(this);
    if ($situation.val() === '')
    {
        $situation.css( 'background-color', '#FFCCCC' );
    }
    else
    {
        $situation.css( 'background-color', '#FFFFFF' );
    }
    $(this.form).trigger('submit.rails');
};

var ambientdropdownhandler = function() {
    var $ambient = $(this);
    if ($ambient.val() === '')
    {
        $ambient.css( 'background-color', '#FFCCCC' );
    }
    else
    {
        $ambient.css( 'background-color', '#FFFFFF' );
    }
    $(this.form).trigger('submit.rails');
};

var filterdropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

