$(document).ready(initializeadvice);

function initializeadvice() {
	var $html = $('html');
	$('.advice_dropdown, .advice_text_field, .advice_text').each(function() {
	   var $field = $(this);
       if ($field.val() == '')
       {
           $field.css('background-color', '#FFCCCC');
       }
	});
	
	$('.add_advice_button').click(addrootadvicecontentmarkerforajax);
	$html.on('click', '.advice_add_child_button', addchildadvicecontentmarkerforajax);
	$html.on({ mouseenter: mouseonadvicedelete, mouseleave: mouseoffadvicedelete }, ".remove_advice_button");
	$html.on('change', '.advice_dropdown', advicedropdownhandler);
	$html.on('change', '.advice_template', advicedropdownhandler);
	$html.on('change', '.advice_header_template', advicedropdownhandler);
	$html.on('change', '.advice_condition', adviceconditionhandler);
	$html.on('blur', '.advice_text_field', advicetextfieldhandler);
	$html.on('blur', '.advice_text', contenttextfieldhandler);
	$html.on('blur', '.advice_text', minimizetextfield);
	$html.on('focus', '.advice_text', enlargetextfield);
	$('.advice_collapse_button').click(toggleadvicecollapse);
}

var ajaxcontentmarker = '<div id="ajaxcontentmarker"></div>';

var addrootadvicecontentmarkerforajax = function() {
    $(this).closest('.advice_header').next().children('.advice_branch').children('.advice_rows').append(ajaxcontentmarker);
};

var addchildadvicecontentmarkerforajax = function() {
    $('#ajaxcontentmarker').remove();
    $(this).closest('.advice_branch').children('.advice_child_block').children('.advice_rows').append(ajaxcontentmarker);
};

var adviceconditionhandler = function() {
    $(this.form).trigger('submit.rails');
};

var advicedropdownhandler = function() {
	$(this.form).trigger('submit.rails');
};

var advicetextfieldhandler = function() {
	var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var toggleadvicecollapse = function() {
    var $toggleimg = $(this);
    $toggleimg.closest('.advice_header').next().slideToggle(200);
    if ($toggleimg.attr('src') === '/assets/button_expanded.png')
    {
        $toggleimg.attr('src', '/assets/button_collapsed.png');
    }
    else
    {
        $toggleimg.attr('src', '/assets/button_expanded.png');
    }
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
};

var enlargetextfield = function() {
	var $text = $(this);
	$text.css('height', '80px');
};

var minimizetextfield = function() {
	var $text = $(this);
	$text.css('height', '20px');
};*/

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

var mouseonadvicedelete = function() {
	var $branch = $(this).closest('.advice_branch');
	$branch.stop().fadeTo(200, 0.3);
};

var mouseoffadvicedelete = function() {
	var $branch = $(this).closest('.advice_branch');
	$branch.stop().fadeTo(200, 1);
};