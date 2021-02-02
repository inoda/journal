$(document).ready(function() {
  var typingTimer;
  var doneTypingInterval = 1000;

  var title = $("body").find("[name=title][data-autosave=true]");
  var content = $("body").find("[name=content][data-autosave=true]");
  var statusDisplay = $("body").find("[data-autosave=status]");

  var autosave = function() {
    $.ajax({
      type: 'POST',
      url: '/posts/autosave',
      data: {
        title: title.val(),
        content: content.val(),
      },
      success: function() {
        statusDisplay.html('Progress is saved &#10003;');
      },
      error: function() {
        statusDisplay.text('Failed to save progress.');
      },
    });
  };

  $(title).on('input', function() {
    statusDisplay.text('Saving progress...');
    clearTimeout(typingTimer);
    typingTimer = setTimeout(autosave, doneTypingInterval);
  });

  $(content).on('input', function() {
    statusDisplay.text('Saving progress...');
    clearTimeout(typingTimer);
    typingTimer = setTimeout(autosave, doneTypingInterval);
  });
});
