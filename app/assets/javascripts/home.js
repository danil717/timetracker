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
      let taskId = pause.getAttribute('task__id');
      // var req = new XMLHttpRequest();
      // req.open('POST', `/tasks/${taskId}/completion`, true);
      // req.setRequestHeader("Accept", "text/javascript");
      // req.responseType='script';
      // req.send();



      const response = fetch(`/tasks/${taskId}/completion`, {
        method: 'post',
        headers: {
          "Content-type": "application/json",
        }
      })
      .then(response => response.text())
      .then(data => {
        console.log('Request succeeded with JSON response', data);
        let obj = JSON.parse(data)
        let td1 = document.createElement('td');
        let td2 = document.createElement('td');
        let td3 = document.createElement('td');
        let td4 = document.createElement('td');
        let tr = document.createElement('tr');
        let table = document.getElementsByClassName('table')[0]
        table.appendChild(tr)
        td1.innerText = obj.project_name;
        td2.innerText = obj.description;
        td3.innerText = obj.created_at + '/' + obj.end_time;
        td4.innerText = obj.full_t
        tr.appendChild(td1)
        tr.appendChild(td2)
        tr.appendChild(td3)
        tr.appendChild(td4)
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
    };
    pause.addEventListener('click', stopPause); //() => stopPause(pause.getAttribute('task__id'))
    stop.addEventListener('click', stopPause);
  });
  if(window.location.href === "http://localhost:3000/") {
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
  };
});
