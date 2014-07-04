$(document).ready(initializecontent);

function initializecontent() {
	var $html = $('html');
	$('.content_dropdown, .content_text_field, .content_text').each(function() {
	   var $field = $(this);
       if ($field.val() == '')
       {
           $field.css('background-color', '#FFCCCC');
       }
	});
	
	$('#text_button').click(addroottextcontentmarkerforajax);
	$('#choice_button').click(addrootchoicecontentmarkerforajax);
	$('#effect_button').click(addrooteffectcontentmarkerforajax);
	$html.on('click', '.add_child_outcome', addchildoutcomecontentmarkerforajax);
	$html.on('click', '.add_child_choice', addchildchoicecontentmarkerforajax);
	$html.on('click', '.add_child_text', addchildtextcontentmarkerforajax);
	$html.on('click', '.add_child_effect', addchildeffectcontentmarkerforajax);
	$html.on('click', '.add_sibling_choice', addsiblingchoicecontentmarkerforajax);
	$html.on('click', '.add_sibling_text', addsiblingtextcontentmarkerforajax);
    $html.on('click', '.add_sibling_effect', addsiblingeffectcontentmarkerforajax);
	$html.on({ mouseenter: mouseoncontentdelete, mouseleave: mouseoffcontentdelete }, ".remove_content_button");
	$html.on('change', '.content_dropdown', contentdropdownhandler);
	$html.on('change', '.content_condition', contentconditionhandler);
	$html.on('blur', '.content_text_field', contenttextfieldhandler);
	$html.on('change', '.content_andor', contentandorhandler);
	$html.on('blur', '.content_text', contenttextfieldhandler);
	$html.on('blur', '.content_text', minimizetextfield);
	$html.on('focus', '.content_text', enlargetextfield);
	$(document).keydown(showcontentsiblingbuttons);
	$(document).keyup(hidecontentsiblingbuttons);
}

var showcontentsiblingbuttons = function(e) {
	if (e.keyCode == 17)
	{
		$('.content_right_hidden').show();
	}
};

var hidecontentsiblingbuttons = function(e) {
	if (e.keyCode == 17)
	{
		$('.content_right_hidden').hide();
	}
};

var ajaxcontentmarker = '<div id="ajaxcontentmarker"></div>';

var addrootchoicecontentmarkerforajax = function() {
    $('#event_content_form').children('.content_branch').children('.content_choice_rows').append(ajaxcontentmarker);
};

var addroottextcontentmarkerforajax = function() {
    $('#event_content_form').children('.content_branch').children('.content_text_rows').append(ajaxcontentmarker);
};

var addrooteffectcontentmarkerforajax = function() {
    $('#event_content_form').children('.content_branch').children('.content_effect_rows').append(ajaxcontentmarker);
};

var addchildoutcomecontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    $(this).closest('.content_branch').children('.child_block').children('.content_outcome_rows').append(ajaxcontentmarker);
};

var addchildtextcontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    $(this).closest('.content_branch').children('.child_block').children('.content_text_rows').append(ajaxcontentmarker);
};

var addsiblingtextcontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    var $temp = $(this).closest('.content_branch').parent().closest('.content_branch');
    if ($temp.children('.child_block').length)
    {
        $temp = $temp.children('.child_block').children('.content_text_rows');
    }
    else
    {
        $temp = $temp.children('.content_text_rows');
    }
    $temp.append(ajaxcontentmarker);
};

var addchildchoicecontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    $(this).closest('.content_branch').children('.child_block').children('.content_choice_rows').append(ajaxcontentmarker);
};

var addsiblingchoicecontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    var $temp = $(this).closest('.content_branch').parent().closest('.content_branch');
    if ($temp.children('.child_block').length)
    {
        $temp = $temp.children('.child_block').children('.content_choice_rows');
    }
    else
    {
        $temp = $temp.children('.content_choice_rows');
    }
    $temp.append(ajaxcontentmarker);
};

var addchildeffectcontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    $(this).closest('.content_branch').children('.child_block').children('.content_effect_rows').append(ajaxcontentmarker);
};

var addsiblingeffectcontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    var $temp = $(this).closest('.content_branch').parent().closest('.content_branch');
    if ($temp.children('.child_block').length)
    {
        $temp = $temp.children('.child_block').children('.content_effect_rows');
    }
    else
    {
        $temp = $temp.children('.content_effect_rows');
    }
    $temp.append(ajaxcontentmarker);
};

var contentconditionhandler = function() {
    $(this.form).trigger('submit.rails');
};

var contentdropdownhandler = function() {
	$(this.form).trigger('submit.rails');
};

var contenttextfieldhandler = function() {
	var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var contentandorhandler = function() {
	$(this.form).trigger('submit.rails');
};

/*var contenttool2handler = function() {
	var $tool2 = $(this);
	var $holder = $tool2.closest('.content_line_bg');
	var $skill2 = $holder.find('.content_skill2');
	var $equality2 = $holder.find('.content_equality2');
	if ($tool2.val() === '')
	{
		$holder.find('.content_equality2, .content_value2').fadeTo(300, 0)
 																	 .val("")
 																	 .data('oldvalue', '')
				 	 									  			 .prop("disabled",true);
 		$skill2.fadeOut(300)
 			   .val("")
 			   .data('oldvalue', '');
 		$tool2.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		$tool2.css( 'background-color', '#FFFFFF' );
		if ($.inArray($tool2.val(), gon.contenttoolfollowedbycontentskill) != -1)
		{
			$skill2.fadeIn(300);
			if ($skill2.val() === '')
			{
				$skill2.css( 'background-color', '#FFCCCC' );
			}
		}
		else
		{
			$skill2.fadeOut(300, function() {
				$equality2.fadeTo(300, 1)
					  	  .prop("disabled",false);
			})
				   .val("")
				   .data('oldvalue', '');
			if ($equality2.val() === '')
			{
				$equality2.css( 'background-color', '#FFCCCC' );
			}
		}
	}
	contentcheckforsaving.apply(this);
};

var contentskill2handler = function() {
	var $skill2 = $(this);
	var $holder = $skill2.closest('.content_line_bg');
	if ($skill2.val() === '')
	{
 		$skill2.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		var $equality2 = $holder.find('.content_equality2');
		$skill2.css( 'background-color', '#FFFFFF' );
		$equality2.fadeTo(300, 1)
				  .prop("disabled",false);
		if ($equality2.val() === '')
		{
			$equality2.css( 'background-color', '#FFCCCC' );
		}
	}
	contentcheckforsaving.apply(this);
};

var contentequality2handler = function() {
	var $equality2 = $(this);
	var $holder = $equality2.closest('.content_line_bg');
	var $value2 = $holder.find('.content_value2');
	if ($equality2.val() === '')
	{
		$value2.fadeTo(300, 0)
 			   .val("")
 			   .data('oldvalue', '')
 			   .prop("disabled",true);
 		$equality2.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		$equality2.css( 'background-color', '#FFFFFF' );
		$value2.fadeTo(300, 1)
			   .prop("disabled",false);
		if ($value2.val() === '')
		{
			$value2.css( 'background-color', '#FFCCCC' );
		}
	}
	contentcheckforsaving.apply(this);
};

var contentvalue2handler = function() {
	var $value2 = $(this);
	$value2.val($.trim($value2.val()));		// Trim the given value
	if ($value2.val() === '')
	{
 		$value2.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		$value2.css( 'background-color', '#FFFFFF' );
		if ($value2.val() != $value2.data('oldvalue'))	// If the new value isn't the same as the already saved value
		{
			$value2.data('oldvalue', $value2.val());	// Save the new value as old before sending the form
			contentcheckforsaving.apply(this);
		}
	}
};

var contenttexthandler = function() {
	var $text = $(this);
	$text.val($.trim($text.val()));		// Trim the given value
	
	
	if ($text.val() === '')
	{
		$text.css( 'background-color', '#FFCCCC' );
	}
	else
	{
		var type = $text.closest('.content_row').find('.content_type').val();
		if (type === 'ContentText')
		{
			$text.css( 'background-color', '#FFE0B2' );
		}
		else if (type === 'ContentChoice')
		{
			$text.css( 'background-color', '#C28566' );
		}
	}
	if ($text.val() != $text.data('oldvalue')) // If there is a value and it's not the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};*/

var enlargetextfield = function() {
	var $text = $(this);
	$text.css('height', '80px');
};

var minimizetextfield = function() {
	var $text = $(this);
	$text.css('height', '20px');
};

/*var contentcheckforsaving = function() {
	var $holder = $(this).closest('.content_line_bg');
	var type = $(this).closest('.content_row').find('.content_type').val();
	var $condition = $holder.find('.content_condition');
	var $tool1 = $holder.find('.content_tool1');
	var $tool2 = $holder.find('.content_tool2');
	var $skill1 = $holder.find('.content_skill1');
	var $skill2 = $holder.find('.content_skill2');
	var $equality1 = $holder.find('.content_equality1');
	var $equality2 = $holder.find('.content_equality2');
	var $value1 = $holder.find('.content_value1');
	var $value2 = $holder.find('.content_value2');
	var $rangevalue = $holder.find('.content_rangevalue');
	var $andor = $holder.find('.content_andor');
	var $text = $holder.find('.content_text');
	if ($condition.val() === '' && $tool1.val() === '' && $equality1.val() === '' && $value1.val() === '' && $rangevalue.val() === '' && $andor.val() === '' && $tool2.val() === '' && $equality2.val() === '' && $value2.val() === '')
	{
		$(this).closest('form').trigger('submit.rails');
	}
	else if ($condition.val() != '' && $tool1.val() != '' && $equality1.val() === 'range' && $value1.val() != '' && $rangevalue.val() != '' && $andor.val() === '' && $tool2.val() === '' && $equality2.val() === '' && $value2.val() === '')
	{
		if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) != -1 && $skill1.val() != '')
		{
			$(this).closest('form').trigger('submit.rails');
		}
		else if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) === -1 && $skill1.val() === '')
		{
			$(this).closest('form').trigger('submit.rails');
		}
	}
	else if ($condition.val() != '' && $tool1.val() != '' && $equality1.val() != '' && $equality1.val() != 'range' && $value1.val() != '' && $rangevalue.val() === '' && $andor.val() === '' && $tool2.val() === '' && $equality2.val() === '' && $value2.val() === '')
	{
		if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) != -1 && $skill1.val() != '')
		{
			$(this).closest('form').trigger('submit.rails');
		}
		else if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) === -1 && $skill1.val() === '')
		{
			$(this).closest('form').trigger('submit.rails');
		}
	}
	else if ($condition.val() != '' && $tool1.val() != '' && $equality1.val() != '' && $equality1.val() != 'range' && $value1.val() != '' && $rangevalue.val() === '' && $andor.val() != '' && $tool2.val() != '' && $equality2.val() != '' && $value2.val() != '')
	{
		if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) != -1 && $skill1.val() != '')
		{
			if ($.inArray($tool2.val(), gon.contenttoolfollowedbycontentskill) != -1 && $skill2.val() != '')
			{
				$(this).closest('form').trigger('submit.rails');
			}
			else if ($.inArray($tool2.val(), gon.contenttoolfollowedbycontentskill) === -1 && $skill2.val() === '')
			{
				$(this).closest('form').trigger('submit.rails');
			}
		}
		else if ($.inArray($tool1.val(), gon.contenttoolfollowedbycontentskill) === -1 && $skill1.val() === '')
		{
			if ($.inArray($tool2.val(), gon.contenttoolfollowedbycontentskill) != -1 && $skill2.val() != '')
			{
				$(this).closest('form').trigger('submit.rails');
			}
			else if ($.inArray($tool2.val(), gon.contenttoolfollowedbycontentskill) === -1 && $skill2.val === '')
			{
				$(this).closest('form').trigger('submit.rails');
			}
		}
	}
};*/

var mouseoncontentdelete = function() {
	var $branch = $(this).closest('.content_branch');
	$branch.stop().fadeTo(200, 0.3);
};

var mouseoffcontentdelete = function() {
	var $branch = $(this).closest('.content_branch');
	$branch.stop().fadeTo(200, 1);
};