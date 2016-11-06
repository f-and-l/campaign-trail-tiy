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
    console.log(data);
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
};

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
};

function candidatePost(candidateValues){
  $.ajax({
    url: '/candidates',
    method: 'POST',
    data: JSON.stringify({ name: candidateValues.name,
      image_url: candidateValues.avatar,
      willpower: candidateValues.willPo,
      charisma: candidateValues.charisma,
      intelligence: candidateValues.intelligence
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

};

function getCampaignList(){
  $.ajax({
    url: '/campaigns',
    method: 'GET',
    dataType: 'json',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);;
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};




window.fee.campaignPost = campaignPost;
window.fee.getCandidateList = getCandidateList;
window.fee.deleteCandidate = deleteCandidate;
window.fee.candidatePost = candidatePost;
window.fee.updateCandidate = updateCandidate;
window.fee.getCampaignList = getCampaignList;


}());
