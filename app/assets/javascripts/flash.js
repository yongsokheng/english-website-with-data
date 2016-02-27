var flash = function() {
  if($(".hide-flash").length > 0) {
    setTimeout(function() {
      $(".hide-flash").fadeOut("normal");
    }, 3000);
  }
}

$(document).ready("ready", flash);
$(document).on("page:update", flash);
