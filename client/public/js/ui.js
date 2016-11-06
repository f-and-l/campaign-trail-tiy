(function() {
  'use strict';
  window.fee = window.fee || {};

  console.log('wassup');

  $('.show-candidate-list').on('click', function showListofCandidates(e){
    window.fee.getCandidateList();
  } );

  function buildCandidateList(data) {
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
  }

  $('.list-of-candidates ul')
    .on('click', 'li .deleteThisCandidate', function deleteACandidate(e){
      var id = ($(this).parent().attr('data-id'));
      window.fee.deleteCandidate(id);
    } );

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

window.fee.buildCandidateList = buildCandidateList;


}());
