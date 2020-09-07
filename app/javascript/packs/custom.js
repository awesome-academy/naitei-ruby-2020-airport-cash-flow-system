$(document).ready(function(){
  $('#clear-condition-search').click(function (e) {
    e.preventDefault()
    $('#q_user_name_cont').val('')
    $('#q_request_details_section_name_eq').val('')
    $('#q_status_eq').val('')
    $('#q_title_or_content_or_request_details_description_cont').val('')
    $('#q_created_at_eq').val('')
    $('#q_sum_amount_gteq').val('')
    $('#q_sum_amount_lteq').val('')
  })  
});
