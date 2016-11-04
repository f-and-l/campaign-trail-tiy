(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wasssup dude');


function candidatePost(candidateValues){
  var candidateName = candidateValues.name;
  var avatarURL = candidateValues.avatar;
  var intell = candidateValues.intelligence;
  var willPow =  candidateValues.willPow;
  var charismaVal = candidateValues.charisma;

  console.log(candidateName, avatarURL, willPow, charismaVal, intell);
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
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
    // window.fee.candidate = {};
    // window.fee.candidate.name = data.name;
    // window.fee.candidate.avatarURL = data.avatarURL;
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};




fee.candidatePost = candidatePost;


}());
