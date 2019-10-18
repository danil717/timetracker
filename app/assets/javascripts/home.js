document.addEventListener('turbolinks:load', function() {
  let form = null;

  document.addEventListener("start", function(event) {
    let hiddens = form.getElementsByClassName('hidden_btn');
    for(let i of hiddens) {
      i.hidden = false;
      i.setAttribute("task__id", event.detail.taskId);
    }
    form.start.hidden = true;
    // let pause = form.getElementById('pause') не находит по ИД
    // let stop = form.getElementById('stop')
    let pause = form.getElementsByClassName('btn-warning')[0];
    let stop = form.getElementsByClassName('btn-danger')[0];

    function stopPause() {
      let taskId = pause.getAttribute('task__id')
      const response = fetch(`/tasks/${taskId}/completion`, {
        method: 'post',
        headers: {
          "Content-type": "application/json"
        }
      })
      .then(function (data) {
        console.log('Request succeeded with JSON response', data);
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
    };

    pause.addEventListener('click', stopPause); //() => stopPause(pause.getAttribute('task__id'))
    stop.addEventListener('click', stopPause);
  });

  inputs.onclick = function(e) {
    if(e.target.id == 'start') {
      form = e.target.form;
      // disable button

      //
      form.submit.click();
      let btn = document.getElementsByClassName('btn-success');
      for(let i of btn) {
        i.disabled = true;
      };
    };
  };

});
