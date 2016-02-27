var datetimepicker = function() {
  if($("#datetimepicker1").length > 0) {
    $("#datetimepicker1").datetimepicker({
      format: "YYYY-MM-DD LT"
    });
  }

  if($("#datetimepicker2").length > 0) {
    $("#datetimepicker2").datetimepicker({
      format: "YYYY-MM-DD LT"
    });
  }

  $("#datetimepicker1").on("dp.change", function (e) {
    $("#datetimepicker2").data("DateTimePicker").minDate(e.date);
  });

  if($("#datetimepicker3").length > 0) {
    $("#datetimepicker3").datetimepicker({
      format: "YYYY-MM-DD LT"
    });
  }

  $("#datetimepicker2").on("dp.change", function (e) {
    $("#datetimepicker1").data("DateTimePicker").maxDate(e.date);
  });
}

$(document).ready("ready", datetimepicker);
$(document).on("page:update", datetimepicker);
