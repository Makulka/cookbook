 /* global $ */
/* global scroll_bottom */
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require_tree .

scroll_bottom = function() {
  if ($('#messages').length > 0) {
   $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

// submit_message = function() {
//   $('#message_body').on('keydown', function(e) {
//     if (e.keyCode == 13) {
//       $('button').click();
//       e.target.value = "";
//     };
//   });
// };

function validateFiles(inputFile) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (2 MB)";
  var extErrorMessage = "Only image file with extension: .jpg, .jpeg, .gif or .png is allowed";
  var allowedExtension = ["jpg", "jpeg", "gif", "png"];

  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;

  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop().toLowerCase();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });
  if (sizeExceeded) {
    window.alert(maxExceededMessage);
    $(inputFile).val('');
  };

  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}

$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
  $('select.dropdown').dropdown();
  scroll_bottom();
  //submit_comment();
  
  $('.average-review-rating').raty('destroy');
  $('.average-review-rating').raty({
		readOnly: true,
		path: '/assets/',
		hints: ['discusting', 'for the brave only', 'OKish', 'delicious', 'amazingly delicious'],
		score: function() {
			return $(this).attr('data-score')
		}
	});
})

submit_comment = function() {
  $('#comment_body').on('keydown', function(e) {
      if (e.keyCode == 13) {
        $('#comment_button').click();
      };
  });
};
