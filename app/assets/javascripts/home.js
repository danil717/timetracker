document.addEventListener('turbolinks:load', function() {
  let form = null;

  document.addEventListener("start", function(event) {
    let hiddens = form.getElementsByClassName('hidden_btn');
    let addTask = document.getElementById('add__task');

    addTask.disabled = false;
    for(let i of hiddens) {
      i.disabled = false
      i.hidden = false;
      i.setAttribute("task__id", event.detail.taskId);
    }
    form.start.hidden = true;

    let pause = form.getElementsByClassName('btn-warning')[0];
    let stop = form.getElementsByClassName('btn-danger')[0];
    let start = form.getElementsByClassName('btn-success')[0]

    function stopPause() {
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
      })
      .catch(function (error) {
        console.log('Request failed', error);
      });
    };

    pause.addEventListener('click', stopPause); //() => stopPause(pause.getAttribute('task__id'))
    stop.addEventListener('click', stopPause);

    pause.onclick = function() {
      start.hidden = false
      start.disabled = false
      this.hidden = true
    }

    stop.onclick = function () {
      form.remove();
    }
  });

  if(window.location.href === "http://localhost:3000/") {
    inputs.onclick = function(e) {
      if(e.target.id == 'start') {
        form = e.target.form;

        form.submit.click();
        let btn = document.getElementsByClassName('btn');
        let description = document.getElementById('description');
        for(let i of btn) {
          i.disabled = true;
        };
        description.disabled = true;
      };
    };
  };

  function addTaskToTable(data) {
    console.log(data);
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
});
