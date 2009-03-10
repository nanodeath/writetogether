(function($){
  var your_works_dialog = $(".your_works#upload_dialog");
  var review_requests_dialog = $(".review_request#upload_dialog");

  $(".errors", your_works_dialog).hide();
  $(".errors", review_requests_dialog).hide();

  your_works_dialog.dialog({
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
            errors.push({field: "#upload_work_title", message: "Title can't be blank"});
          } else if(title.length < 4){
            errors.push({field: "#upload_work_title", message: "Title can't be shorter than 4 characters"});
          }
          if(file == ""){
            errors.push({field: "#file_upload", message: "Forgot to specify a file"});
          }
          if(errors.length == 0){
            $("#upload_dialog .errors").hide();
            $("#upload_dialog form").submit();
          } else {
            var error_html = "";
            $("input,textarea", your_works_dialog).removeClass("ui-state-error");
            for(e in errors){
              error_html += "<li>" + errors[e].message + "</li>";
              $(errors[e].field).addClass("ui-state-error");
            }
            $("#upload_dialog .error_text").html("<ul>" + error_html + "</ul>");
            $("#upload_dialog .errors").show();
            $("#upload_dialog").dialog("open");
          }
          
        },
        "Cancel": function(){
          $(".error_text", your_works_dialog).html("");
          $(".errors", your_works_dialog).hide();
          $("input,textarea", your_works_dialog).val("").removeClass("ui-state-error");
          $(this).dialog("close");
        }
      },
      width: 325
  });
  $("#upload_new_work").click(function(){
    $("#upload_dialog").dialog("open");
  });

  review_requests_dialog.dialog({
    autoOpen: false,
    title: "Send response",
      resizable: false,
      draggable: false,
      modal: true,
      buttons: {
        "Send": function(){
          var errors = [];
          var response = $("#response_field", review_requests_dialog).val();
          if(response == ""){
            errors.push("Response can't be blank");
          } else if(response.length <= 3){
            errors.push("Response should probably be longer than 3 characters");
          }
          if(errors.length == 0){
            $(".errors", review_requests_dialog).hide();
            $("form", review_requests_dialog).submit();
          } else {
            var error_html = "";
            for(e in errors){
              error_html += "<li>" + errors[e] + "</li>";
            }
            $(".error_text", review_requests_dialog).html("<ul>" + error_html + "</ul>");
            $(".errors", review_requests_dialog).show();
            review_requests_dialog.dialog("open");
          }

        },
        "Cancel": function(){
          $(".error_text", review_requests_dialog).html("");
          $(".errors", review_requests_dialog).hide();
          $("input,textarea", review_requests_dialog).val("");
          $(this).dialog("close");
        }
      },
      width: 325
  })

  $("#done_reviewing").click(function(){
    $(".review_request#upload_dialog").dialog("open");
  });
})(jQuery);