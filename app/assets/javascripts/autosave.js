$(document).ready(function() {
  var typingTimer;
  var doneTypingInterval = 1000;

  var title = $("body").find("[name=title][data-autosave=true]");
  var content = $("body").find("[name=content][data-autosave=true]");

  var autosave = function() {
    $.ajax({
      type: 'POST',
      url: '/posts/autosave',
      data: {
        title: title.val(),
        content: content.val(),
      }
    });
  };

  $(title).on('input', function() {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(autosave, doneTypingInterval);
  });

  $(content).on('input', function() {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(autosave, doneTypingInterval);
  });
});
