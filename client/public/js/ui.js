(function() {
  'use strict';
  window.fee = fee = (fee || {});

  $('.createCandidate').on('submit', function createCandidate(e){
      e.preventDefault();
      
      var candidate = fee.candidatePost();
      console.log(candidate) // do stuff with var candidate
  });


}());
