$(document).ready(initializesecondaryprereq);

function initializesecondaryprereq() {
    var $secondaryprereqformdiv = $('#event_secondary_prereq_form');
    $secondaryprereqformdiv.find('.secondary_prereq_event, .secondary_prereq_p').each(function() {
       var $field = $(this);
       if ($field.val() == '')
       {
           $field.css('background-color', '#FFCCCC');
       }
    });
    
    $('#secondary_prereq_collapse_button').click(togglesecondaryprereqcollapse);
    $('#secondary_prereq_button').click(createnewsecondaryprereq);
    $secondaryprereqformdiv.on('click', '.remove_secondary_prereq', removesecondaryprereqrow);
    $secondaryprereqformdiv.on('change', '.secondary_prereq_event', secondaryprereqdropdownhandler);
    $secondaryprereqformdiv.on('change', '.secondary_prereq_outcome', secondaryprereqdropdownhandler);
    $secondaryprereqformdiv.on('blur', '.secondary_prereq_p', secondaryprereqdropdownhandler);
};

var secondaryprereqdropdownhandler = function() {
    $(this.form).trigger('submit.rails');
};

var secondaryprereqphandler = function() {
    var $field = $(this);
    $field.val($.trim($field.val()));     // Trim the given value
    if ($field.val() != $field.data('oldvalue'))  // If the new value isn't the same as the already saved value
    {
        $(this.form).trigger('submit.rails');
    }
};

var togglesecondaryprereqcollapse = function() {
    var $toggleimg = $(this);
    $('#event_secondary_prereq_form').slideToggle(200);
    if ($toggleimg.attr('src') === '/assets/button_expanded.png')
    {
        $toggleimg.attr('src', '/assets/button_collapsed.png');
    }
    else
    {
        $toggleimg.attr('src', '/assets/button_expanded.png');
    }
};

var createnewsecondaryprereq = function() {
    $(this).parents("form").trigger('submit.rails');
};

var removesecondaryprereqrow = function() {
    var $row = $(this).parents(".row");
    $row.fadeOut(200, function() { 
        if ($row.hasClass('row_first'))
        {
            $row.next().addClass('row_first');
        }
        $row.remove(); 
    });
};