document.addEventListener('turbolinks:load', function() {
  if(window.location.href === "http://localhost:3000/") {
    let form = null;

    document.addEventListener("start", function(event) {
      let hiddens = form.getElementsByClassName('hidden_btn');
      let addTask = document.getElementById('add__task');
      let pause = form.getElementsByClassName('btn-warning')[0];
      let stop = form.getElementsByClassName('btn-danger')[0];
      let start = form.getElementsByClassName('btn-success')[0];
      let btn = form.getElementsByClassName('btn');
      let description = form.getElementsByClassName('form-control')[0];
      window.form = form

      disabled(btn, true)
      description.disabled = true;
      addTask.disabled = false;

      for(let i of hiddens) {
        i.disabled = false;
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
      let pause = form.getElementsByClassName('btn-warning')[0];
      let start = form.getElementsByClassName('btn-success')[0];
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
          disabled(starts, false)
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
      td3.innerText = obj.created_at + '/' + obj.end_time;
      td4.innerText = obj.full_t
      tr.appendChild(td1);
      tr.appendChild(td2);
      tr.appendChild(td3);
      tr.appendChild(td4);
    }
  }
});
