(function() {
  'use strict';
  window.fee = window.fee || {};

  $('.list-of-candidates').hide();
  $('.create-a-campaign').hide();
  $('.campaign-list').hide();
  $('.create-a-candidate').show();


  $('.show-candidate-list').on('click', function showListofCandidates(e){
    $('.list-of-candidates').show();
    $('.create-a-campaign').hide();
    $('.campaign-list').hide();
    $('.create-a-candidate').hide();
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
             '<button class="deleteThisCandidate">Delete</button>' +
             '<button class="updateAtrCandidate">Update</button>' +
          '</li>'
        );
    })
  };

  $('.create-candidate').on('click', function createCampaignPage(){
    $('.create-a-candidate').show();
    $('.list-of-candidates').hide();
    $('.create-a-campaign').hide();
    $('.campaign-list').hide();

  });

  $('.list-of-candidates ul')
    .on('click', 'li .deleteThisCandidate', function deleteACandidate(e){
      var id = ($(this).parent().attr('data-id'));
      window.fee.deleteCandidate(id);
  });

 $('.list-of-candidates ul')
    .on('click', 'li .updateAtrCandidate', function updateCandidate(e) {
      console.log(candidateUpdate);
    } );

$('.update-attribute')
      .on('submit', function updateAttribute(e) {
        e.preventDefault();
        var candidateUpdate = {};
        candidateUpdate.name = $('#update-name').val();
        candidateUpdate.avatar= $('#update-avatar').val();
        candidateUpdate.intelligence = $('#update-intel').val();
        candidateUpdate.willPow = $('#update-willpower').val();
        candidateUpdate.charisma = $('#update-charisma').val();
        candidateUpdate.id = ($(this).parent().attr('data-id'));
        window.fee.updateCandidate(candidateUpdate);
      })

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
    $('.create-a-campaign').show();
    $('.list-of-candidates').hide();
    $('.campaign-list').hide();
    $('.create-a-candidate').hide();
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
       .find('#canDropOne').append(
        '<option value="' + candidate.id + '">' +
        candidate.name + '</option>' );
    });
   data.forEach( function candidatesMenuTwo(candidate){
     $('.create-a-campaign')
      .find('#canDropTwo').append(
       '<option value="' + candidate.id + '">' +
       candidate.name + '</option>' );
    });
  };

  $('.campaignStart').on('submit', function postCampaign(e){
    e.preventDefault();
    var canIDS = {};
    canIDS.canOneID = $('#canDropOne').val();
    canIDS.canTwoID = $('#canDropTwo').val();
    window.fee.campaignPost(canIDS);
  });

  function appendWinnerInfo(id){
    window.fee.currentCandidates.forEach( function matchID(candidate){
      console.log(id);
      if (candidate.id === id) {
        $('.create-a-campaign').append('<p>The winner is ' + candidate.name);
      }
    })
  };


  window.fee.appendWinnerInfo = appendWinnerInfo;
  window.fee.createCampaignMenus =  createCampaignMenus;
  window.fee.buildCandidateList = buildCandidateList;



}());
