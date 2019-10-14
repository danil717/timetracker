document.addEventListener('turbolinks:load', function() {

  let link = window.location.href.split('/');
  if(link[3] == '') {
    let start = document.getElementById('start');

    start.onclick = function() {
        let btn = document.getElementsByClassName('hidden_btn')
        for (let i of btn) {
            i.hidden = false
        };
        this.hidden = true
    };
  }

})
