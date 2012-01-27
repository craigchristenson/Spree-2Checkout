
function process_callback(json) {

  var pend_url = json.back_url+'/'+json.collection_id+'/'+json.collection_status+'/'+json.external_reference+'/'+json.preference_id;
  window.location = pend_url;  
}
