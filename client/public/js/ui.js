(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wassup');

  $('.show-candidate-list').on('click', function showListofCandidates(e){
    window.fee.getCandidateList();

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


}());
