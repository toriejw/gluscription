$(document).ready(function(){
  $('.well').hide();

  $('#create-search-bar')
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);
      $form.find('textfield,input[type="text"]').val("");

      $('.well').show();
      $('#result').html(xhr.responseText);
    })
    .bind("ajax:error", function(evt, xhr, status, error){
      var $form = $(this),
          errors,
          errorsText;

      try {
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        errors = { message: "Please reload the page and try again" };
      }

      errorText = "There were errors with the submission \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";
      $('#result').html(errorText);

    });

});
