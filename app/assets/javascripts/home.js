document.addEventListener('turbolinks:load', function() {
  let form = null;


  document.addEventListener("start", function(event) {
    let hiddens = form.getElementsByClassName('hidden_btn');
    for(let i of hiddens) {
      i.hidden = false;
      i.setAttribute("task__id", event.detail.taskId);
    }
    form.start.hidden = true;
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
