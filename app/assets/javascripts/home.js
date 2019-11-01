document.addEventListener('turbolinks:load', function() {
  if(window.location.href === "http://localhost:3000/") {
    let form = null;
    let stops = document.getElementsByClassName('btn-danger');
    let starts = document.getElementsByClassName('btn-success');
    let pause = form.getElementsByClassName('btn-warning')[0];
    let start = form.getElementsByClassName('btn-success')[0];
    document.addEventListener("start", function(event) {
      let hiddens = form.getElementsByClassName('hidden_btn');
      let stop = form.getElementsByClassName('btn-danger')[0];
      let description = form.getElementsByClassName('form-control')[0];
      let select = form.getElementsByClassName('dropdown-toggle')[0];
      disabled(stops, true)
      stop.disabled = false
      disabled(starts, true)
      description.style.pointerEvents = 'none'
      select.style.pointerEvents = 'none'

      for(let i of hiddens) {
        i.hidden = false;
        i.setAttribute('task__id', event.detail.taskId);
      }
      form.start.hidden = true;
      form.submit.setAttribute('class', 'stop-pause')
    });

    inputs.onclick = function(e) {
      if(e.target.id == 'start') {
        formDefined(e.target.form);
      } else if(e.target.id == 'pause') {
        stopPause(true, e.target.form);
      }else if(e.target.id == 'stop') {
        disabled(starts, false)
        disabled(stops, false);
        if(e.target.form.submit.getAttribute('class') === 'start-pause') {
          e.target.form.remove()
        } else {
          stopPause(false, e.target.form);
        }
      }
    }

    function formDefined(specificForm) {
      form = specificForm;
      form.submit.click();
    }

    function stopPause(isPause, form) {
      let taskId = pause.getAttribute('task__id');

      const response = fetch(`/tasks/${taskId}/completion`, {
        method: 'post',
        headers: {
          "Content-type": "application/json",
        }
      })
      .then(response => response.text())
      .then(data => {
        addTaskToTable(data);
        if(isPause) {
          let starts = document.getElementsByClassName('btn-success')
          let stop = document.getElementsByClassName('btn-danger')
          disabled(starts, false);
          disabled(stop, false);
          start.hidden = false;
          pause.hidden = true;
          form.submit.setAttribute('class', 'start-pause')
        } else {
          form.remove();
        };
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
    };

    function disabled(item, dis) {
      if (dis === true) {
        for(let i of item) {
          i.disabled = true;
        }
      } else {
        for(let i of item) {
          i.disabled = false;
        }
      }
    }

    function addTaskToTable(data) {
      let obj = JSON.parse(data)
      let td1 = document.createElement('td');
      let td2 = document.createElement('td');
      let td3 = document.createElement('td');
      let td4 = document.createElement('td');
      let tr = document.createElement('tr');
      let table = document.getElementsByClassName('table')[0];

    table.appendChild(tr)
    td1.innerText = obj.project_name;
    td2.innerText = obj.description;
    td3.innerText = obj.created_at_strf + '/' + obj.end_time_strf;
    td4.innerText = obj.full_time;
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);
    }
  }
});
