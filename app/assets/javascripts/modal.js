$(document).ready(function() {
  $("body").on("click", "[data-open-modal]", function(e) {
    e.preventDefault();

    var modalSelector = $(this).data("open-modal")
    if (!modalSelector) { return false; }

    $("#" + modalSelector).css("display", "table");
  });

  $("body").on("click", "[data-close-modal]", function(e) {
    e.preventDefault();

    var modalSelector = $(this).data("close-modal")
    if (!modalSelector) { return false; }

    $("#" + modalSelector).css("display", "none");
  });
});
