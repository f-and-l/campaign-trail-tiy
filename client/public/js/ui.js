(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wassup');

  $('.show-candidate-list').on('click', function showListofCandidates(e){
    window.fee.getCandidateList();
  } );

  function buildCandidateList(data) {
    console.log(data);
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
  }

  $('.list-of-candidates ul')
    .on('click', 'li button', function deleteACandidate(e){
      var id = ($(this).parent().attr('data-id'));
      //window.fee.getCandidateList();
      window.fee.deleteCandidate(id);
    } );

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

window.fee.buildCandidateList = buildCandidateList;

}());
