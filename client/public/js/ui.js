(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wassup');

  $('.createCandidate').on('submit', function createCandidate(e){
      e.preventDefault();
      var candidateValues = {};
      candidateValues.name = $('#new-name').val();
      candidateValues.avatar= $('#new-avatar').val();
      candidateValues.intelligence = $('#intel').val();
      candidateValues.willPow = $('#willpower').val();
      candidateValues.charisma = $('#charisma').val();
      fee.candidatePost(candidateValues);
      console.log(candidateValues); // do stuff with var candidate
  });


}());
