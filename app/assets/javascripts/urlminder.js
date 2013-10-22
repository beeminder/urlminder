$(document).ready(function() {
  function showSpinner() {
    var spinnerOpts = {
      lines: 13, // The number of lines to draw
      length: 20, // The length of each line
      width: 10, // The line thickness
      radius: 30, // The radius of the inner circle
      corners: 1, // Corner roundness (0..1)
      rotate: 0, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      color: '#000', // #rgb or #rrggbb or array of colors
      speed: 1, // Rounds per second
      trail: 60, // Afterglow percentage
      shadow: false, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: 'auto', // Top position relative to parent in px
      left: 'auto' // Left position relative to parent in px
    };
    var target = document.getElementById('spinner');
    var spinner = new Spinner(opts).spin(target);
  }

  $(".add-url").click(function() {
    var lastURLId = $("#new_goal input.url:last").attr("id")
    var index = lastURLId.slice(lastURLId.length - 1) - 0;
    index += 1;
    $(".urls").append('<label class="col-lg-5 control-label" for="url_' + index + '"></label>');
    $(".urls").append('<div class="col-lg-7"><input class="form-control url" id="url_' + index + '" name="goal[url_' + index + ']" type="text"></div>');
    return false;
  });

  function validateForm () {
    error = false;
    if ($("#goal_rate").val().length == 0) {
      $("#goal_rate").parent().parent().addClass("has-error")
      error = true;
    };
    if ($("#goal_title").val().length == 0) {
      $("#goal_title").parent().parent().addClass("has-error")
      error = true;
    };
    if ($("#goal_slug").val().length == 0) {
      $("#goal_slug").parent().parent().addClass("has-error")
      error = true;
    };
    return !error;
  }

  $("form#new_goal").submit(function() {
    if (validateForm()) {
      showSpinner();
      $(this).find("button").attr("disabled", "disabled");
      $(this).submit();
    }
    else {
      return false;
    }
  });

  $(".well#connection a").click(function() {
    $(this).attr("disabled", "disabled");
  })

  $(".refresh-goal").click(function() {
    $(this).attr("disabled", "disabled");
    showSpinner();
  });
});