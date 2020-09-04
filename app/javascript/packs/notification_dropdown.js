$(document).ready(function(){
  $('#update_notify').on('click', function(){
    let url = $('#notification_url').text()
    $.ajax({
      url,
      type: 'get',
      success: function(data) {
        $('#notification-content').html(data.html); 
      }
    })
  })
});
