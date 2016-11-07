(function() {
  'use strict';
  window.fee = window.fee || {};

  $('.list-of-candidates').hide();
  $('.create-a-campaign').hide();
  $('.campaign-list').hide();
  $('.updateAttributes').hide();
  $('.create-a-candidate').show();


  $('.show-candidate-list').on('click', function showListofCandidates(e){
    $('.list-of-candidates').show();
    $('.create-a-campaign').hide();
    $('.campaign-list').hide();
    $('.create-a-candidate').hide();
    $('.updateAttributes').hide();
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
    $('.updateAttributes').hide();
  });

  $('.list-of-candidates ul')
    .on('click', 'li .deleteThisCandidate', function deleteACandidate(e){
      var id = ($(this).parent().attr('data-id'));
      window.fee.deleteCandidate(id);
  });

 $('.list-of-candidates ul')
    .on('click', 'li .updateAtrCandidate', function updateCandidate(e) {
      $('.updateAttributes').show();
      $('.update-attribute').show();
      $('.updateMessage').remove();
      $('#update-name').val('');
      $('#update-avatar').val('');
      $('#update-intel').val('0');
      $('#update-willpower').val('0');
      $('#update-charisma').val('0');
      var id = ($(this).parent().attr('data-id'));
      window.fee.updateCan=id;
      console.log(id);
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
        candidateUpdate.id = window.fee.updateCan;
        $('.updateMessage').remove();
        $('.update-attribute').hide();
        $('.updateAttributes').append('<p class="updateMessage">Thank you your candidate has been updated</p>');
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
    $('.updateAttributes').hide();
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

  $('.see-old-campaigns').on('click', function createCampaignPage(){
    $('.campaign-list').show();
    $('.create-a-candidate').hide();
    $('.list-of-candidates').hide();
    $('.create-a-campaign').hide();
    $('.updateAttributes').hide();
    window.fee.getCampaignList();
  });

  function appendCampaignInfo(ids){
    console.log(ids);
    ids.forEach( function matchID(candidate){
    console.log(candidate.winner_id);
      if (candidate.winner_id === id) {
        $('.create-a-campaign').append('<p>The winner is ' + candidate.name);
      }
  });
  }

  window.fee.appendCampaignInfo = appendCampaignInfo;
  window.fee.appendWinnerInfo = appendWinnerInfo;
  window.fee.createCampaignMenus =  createCampaignMenus;
  window.fee.buildCandidateList = buildCandidateList;



}());
