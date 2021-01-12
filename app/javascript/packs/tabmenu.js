document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.getElementsByClassName('tab');
  
  for(let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', tabSwitch);
  }

  function tabSwitch(){
    document.getElementsByClassName('side-active')[0].classList.remove('side-active');
    this.classList.add('side-active');

    document.getElementsByClassName('side-show')[0].classList.remove('side-show');
    const arrayTabs = Array.prototype.slice.call(tabs);
    const index = arrayTabs.indexOf(this);
    document.getElementsByClassName('tab-content')[index].classList.add('side-show');
  };
});
