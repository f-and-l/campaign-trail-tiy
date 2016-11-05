(function() {
  'use strict';
  window.fee = window.fee || {};


  $('.show-candidate-list').on('click', function showListofCandidates(e){
    window.fee.getCandidateList();
  });

  function buildCandidateList(data) {
    $('.list-of-candidates ul').children().remove();
    data.forEach(function addCandidateToUl(candidate){
      $('.list-of-candidates ul')
        .append(
          '<li data-id="' + candidate.id + '">' +
            '<img src="' + candidate.image_url + '">' +
             candidate.name +
             '<button>Delete</button>' +
          '</li>'
        );
    })
  };

  $('.list-of-candidates ul')
    .on('click', 'li button', function deleteACandidate(e){
      var id = ($(this).parent().attr('data-id'));
      window.fee.deleteCandidate(id);
  });

  $('.createCandidate').on('submit', function createCandidate(e){
      e.preventDefault();
      var candidateValues = {};
      candidateValues.name = $('#new-name').val();
      candidateValues.avatar= $('#new-avatar').val();
      candidateValues.intelligence = $('#intel').val();
      candidateValues.willPow = $('#willpower').val();
      candidateValues.charisma = $('#charisma').val();
      window.fee.candidatePost(candidateValues);
      console.log(candidateValues); // do stuff with var candidate
  });


  $('.create-campaign').on('click', function createCampaign(){
    window.fee.getCandidateList();
  });

  function createCampaignMenus(data){
    $('#canDropOne')
    .find(':first-child')
      .siblings().remove();
    $('#canDropTwo')
    .find(':first-child')
      .siblings().remove();
    data.forEach( function candidatesMenuOne(candidate){
      $('.create-a-campaign')
      .find('.campaignCanOne')
       .find('#canDropOne').append(
        '<option value="' + candidate.id + '">' +
        candidate.name + '</option>' );
    });
   data.forEach( function candidatesMenuTwo(candidate){
     $('.create-a-campaign')
     .find('.campaignCanTwo')
      .find('#canDropTwo').append(
       '<option value="' + candidate.id + '">' +
       candidate.name + '</option>' );
    });
  };

  window.fee.createCampaignMenus =  createCampaignMenus;
window.fee.buildCandidateList = buildCandidateList;


}());
