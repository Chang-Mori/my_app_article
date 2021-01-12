document.addEventListener("DOMContentLoaded", () => {
  const open = document.getElementById('open');
  const sideBar = document.querySelector('.side-bar');
  const close = document.getElementById('close');

  open.addEventListener('click', () => {
    sideBar.classList.add('show');
    open.classList.add('hide');
  });

  close.addEventListener('click', () => {
    sideBar.classList.remove('show');
    open.classList.remove('hide');
  });
});