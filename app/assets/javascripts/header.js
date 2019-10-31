document.addEventListener("turbolinks:load", function() {
  let home = document.getElementById('home');
  let link = window.location.href.split('/');
  let tasks = document.getElementById('tasks')
  let login = document.getElementById('login');
  let register = document.getElementById('register');

  if(link[3] === '') {
    home.style.color = 'rgb(250, 250, 89)';
  } else if(window.location.href.match('tasks') !== null) {
    tasks.style.color = 'rgb(250, 250, 89)';
  }else if(link[4] === 'sign_up') {
    register.style.color = 'rgb(250, 250, 89)';
  } else if(link[4] === 'sign_in') {
    login.style.color = 'rgb(250, 250, 89)';
  }
});
