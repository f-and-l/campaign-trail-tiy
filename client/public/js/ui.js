(function() {
  'use strict';
  window.fee = fee = (fee || {});

  $('.createCandidate').on('submit', function createCandidate(e){
      e.preventDefault();
      var candidateValues = {};
      candidateValues.name = $('#new-name').val();
      candidateValues.avatar= $('#new-avatar').val();
      candidateValues.intelligence = $('#intel').val();
      candidateValues.willPow = $('#willpower').val();
      candidateValues.charisma = $('#charisma').val();
      var candidate = fee.candidatePost(candidateValues);
      console.log(candidate) // do stuff with var candidate
  });


}());
