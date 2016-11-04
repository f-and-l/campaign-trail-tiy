(function() {
  'use strict';
  window.fee = fee = (fee || {});


function candidatePost(candidateValues){
  candidateValues.name = candidateName;
  console.log(candidateName);
  $.ajax({
    url: '/candidates',
    method: 'POST',
    dataType: 'json',
    data: {
      name: candidateName,
      image_url: avatarURL,
      willpower: willPow,
      charisma: charismaVal,
      intelligence: intell
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
