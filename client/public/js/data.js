(function() {
  'use strict';
  window.fee = window.fee || {};

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
    window.fee.currentCandidates = data;
    window.fee.buildCandidateList(data);
    window.fee.createCampaignMenus(data);
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
  .fail (function handleError(xhr){
    console.log(xhr);
  });
}

function updateCandidate(candidateUpdate){
  console.log(candidateUpdate);
  $.ajax({
    url: '/candidates/' + candidateUpdate.id,
    method: 'PATCH',
    data: JSON.stringify({ name: candidateUpdate.name,
      image_url: candidateUpdate.avatar,
      willpower: candidateUpdate.willPow,
      charisma: candidateUpdate.charisma,
      intelligence: candidateUpdate.intelligence
      }),
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done (function handleSuccess(data) {
    console.log(data);
  })
  .fail (function handleError(xhr) {
    console.log(xhr);
  })
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

function campaignPost(ids){
  // var canArray = [];
  // ids.each( function arrayPush(){
  //   ids[i].push().
  // })
  $.ajax({
    url: '/campaigns',
    method: 'POST',
    dataType: 'json',
    data : JSON.stringify({ candidates: [ ids.canOneID, ids.canTwoID ]}),
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done (function handleSuccess(data){
    console.log(data.winner_id);
    window.fee.appendWinnerInfo(data.winner_id);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });

}



window.fee.campaignPost = campaignPost;
window.fee.getCandidateList = getCandidateList;
window.fee.deleteCandidate = deleteCandidate;
window.fee.candidatePost = candidatePost;
window.fee.updateCandidate = updateCandidate;


}());
