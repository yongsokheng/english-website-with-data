$(document).ready(function(){
  $(".btn-schedule").click(function(){
    var schedule_at = $("#article_schedule_at").val();
    if(schedule_at == "") {
      alert("Schedule Datetime cannot be blank");
      return false;
    }
  });
})
