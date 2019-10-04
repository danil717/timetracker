let ul = document.getElementsByTagName('ul')
console.log(ul)

ul.onclick = function(event) {
  console.log('asoiduhawo')
  if (event.target.tagName == "LI" && event.ctrlKey || event.metaKey) {
    event.target.classList.toggle('selected');
  } else {
  let selected = ul.querySelectorAll('.selected');
  for(let elem of selected) {
    elem.classList.remove('selected');
  }
  event.target.classList.add('selected');
  }
}
