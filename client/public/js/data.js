(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wasssup dude');

function getCandidateList(){
  $.ajax({
    url: '/candidates',
    method: 'GET',
    dataType: 'json',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
    window.fee.buildCandidateList(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};

function deleteCandidate(idnum){
  $.ajax({
    url: '/candidates/' + idnum,
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done (function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
}

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
    data: JSON.stringify({ name: candidateName,
    image_url: avatarURL,
    willpower: willPow,
    charisma: charismaVal,
    intelligence: intell
    }),
    headers: {
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

 


window.fee.getCandidateList = getCandidateList;
window.fee.deleteCandidate = deleteCandidate;
window.fee.candidatePost = candidatePost;


}());
