(function() {
  'use strict';
  window.fee = fee = (fee || {});

  $('.createCandidate').on('click', function createCandidate(e){
      e.preventDefault();
      var candidate = fee.candidatePost(); // do stuff with var candidate
  });


}());
