(function() {
  'use strict';
  window.fee = fee = (fee || {});


function candidatePost(){
  $.ajax({
    url: '/candidates',
    method: 'POST',
    dataType: 'json',
    data: {
      name: candidateName,
      image_url: avatarURL,
      willpower: willPow,
      charisma: charismaVal
    },
    headers {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};




fee.candidatePost = candidatePost;


}());
