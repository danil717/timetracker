document.addEventListener('turbolinks:load', function() {
  let start = document.getElementById('start');

  start.addEventListener('click', (e) => {
      let btn = document.getElementsByClassName('hidden_btn')
      for (let i of btn) {
          i.hidden = false
      };
  });
})
