(function() {
  'use strict';
  window.fee = fee = (fee || {});


function candidatePost(){
  $.ajax({
    url: '/candidates',
    method: 'POST',
    dataType: 'json',
    data: {
      name: candidateName,
      image_url: avatarURL,
      willpower: willPow,
      charisma: charismaVal
    },
    headers {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};

function candidateGet(){
  $.ajax({
    url: '/candidates',
    method: 'GET',
    dataType: 'json'
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};

function candidateById(){
  $.ajax({
    url: 'candidates/id', ///do we need to pass in id or post id in url?
    mehtod: 'GET',
    dataType: 'json'
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};

function candidatePatch(updates){
  $.ajax({
    url: 'candidates/id',
    method: 'PATCH',
    dataType: 'json'
    data: {
      updates
    },
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};

function candidateDelete(){
  $.ajax({
    url: 'candidates/id',
    mehtod: 'DELETE',
    dataType: 'json',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .done( function handleSuccess(data){
    console.log(data);
  })
  .fail( function handleError(xhr){
    console.log(xhr);
  });
};


fee.candidatePost = candidatePost;
fee.candidateGet = candidateGet;
fee.candidateById = candidateById;
fee.candidatePatch = candidatePatch;
fee.candidateDelete = candidateDelete;

}());
