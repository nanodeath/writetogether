(function($){
  var dialog = $("#upload_dialog");
  $(".errors", dialog).hide();
  $("#upload_dialog").dialog({
    autoOpen: false,
    title: "Upload a new work",
      resizable: false,
      draggable: false,
      modal: true,
      buttons: {
        "Upload": function(){
          var errors = [];
          var title = $("#upload_work_title").val();
          var file = $("#file_upload").val();
          if(title == ""){
            errors.push("Title can't be blank");
          } else if(title.length < 4){
            errors.push("Title can't be shorter than 4 characters");
          }
          if(file == ""){
            errors.push("Forgot to specify a file");
          }
          if(errors.length == 0){
            $("#upload_dialog .errors").hide();
            $("#upload_dialog form").submit();
          } else {
            var error_html = "";
            for(e in errors){
              error_html += "<li>" + errors[e] + "</li>";
            }
            $("#upload_dialog .error_text").html("<ul>" + error_html + "</ul>");
            $("#upload_dialog .errors").show();
            $("#upload_dialog").dialog("open");
          }
          
        },
        "Cancel": function(){
          $(".error_text", dialog).html("");
          $(".errors", dialog).hide();
          $("input", dialog).val("");
          $(this).dialog("close");
        }
      },
      width: 325
  })
  $("#upload_new_work").click(function(){
    $("#upload_dialog").dialog("open");
  });
})(jQuery);